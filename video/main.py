# main.py
import socket
import pyaudio
import wave
from flask import Flask, render_template, Response
from camera import VideoCamera
import paho.mqtt.client as mqtt
CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 16000
RECORD_SECONDS = 40
app = Flask(__name__)

@app.route('/')
def index():
	return render_template('index.html')

def gen(camera):
	audio_client = mqtt.Client()
	video_client = mqtt.Client()
	audio_client.connect("172.17.80.164", 1883, 60)
	
	video_client.connect("172.17.80.164", 1883, 60)
	p = pyaudio.PyAudio()

	stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True,
                frames_per_buffer=CHUNK)
	while True:
		video_frame = camera.get_frame()
		audio_data  = stream.read(CHUNK)
		audio_frames = bytearray(audio_data)
	
		yield (b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' + video_frame + b'\r\n\r\n')
		video_data = bytearray(video_frame)		
		audio_client.publish("audio",audio_frames)
		print "sending audio"
		video_client.publish("video",video_data)
		print "sending video"

@app.route('/video_feed')
def video_feed():
    return Response(gen(VideoCamera()), mimetype='multipart/x-mixed-replace; boundary=frame')

if __name__ == '__main__':
	app.run(host='0.0.0.0', debug=True)
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    

    
	
