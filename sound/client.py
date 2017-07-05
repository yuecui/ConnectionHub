import socket
import pyaudio
import wave
import paho.mqtt.client as mqtt
#record
CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 16000
RECORD_SECONDS = 40

IP_Address = raw_input("Enter the host IP address: ")
TOPIC = raw_input ("Enter the topic :")
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client = mqtt.Client()
client.connect(IP_Address, 1883, 60)
print "Socket has been created."

p = pyaudio.PyAudio()

stream = p.open(format=FORMAT,
                channels=CHANNELS,
                rate=RATE,
                input=True,
                frames_per_buffer=CHUNK)

print("*recording")


while True:
	data  = stream.read(CHUNK)
	frames = bytearray(data)
	client.publish(TOPIC,frames)
	print "message sent"

print("*done recording")

stream.stop_stream()
stream.close()
p.terminate()
s.close()

print("*closed")
