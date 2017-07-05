# main.py
import socket
import pyaudio
import wave
from camera import VideoCamera
import paho.mqtt.client as mqtt
import numpy as np
import cv2
CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 8000

IP_Address = raw_input("Enter the host IP address: ")
cap = cv2.VideoCapture(0)
audio_client = mqtt.Client()
video_client = mqtt.Client()
audio_client.connect(IP_Address, 1883, 60)  

video_client.connect(IP_Address, 1883, 60)
p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,
            channels=CHANNELS,
            rate=RATE,
            input=True,
            frames_per_buffer=CHUNK)
while True:
        audio_data  = stream.read(CHUNK)
        audio_frames = bytearray(audio_data)
        ret, video_frame = cap.read()
        resized = cv2.resize(video_frame,(400,300))
        r,data = cv2.imencode(".jpeg",resized)
        cv2.imshow("frame",resized)
        data = bytearray(data.tostring())        
        audio_client.publish("audio",audio_frames)
        video_client.publish("video",data)

        if cv2.waitKey(1) & 0xFF == ord('q'):
                break
cap.release()
cv2.destroyAllWindows()
	
    

    
	
