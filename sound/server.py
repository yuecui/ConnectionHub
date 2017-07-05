import socket
import pyaudio
import wave
import time
import paho.mqtt.client as mqtt

CHUNK = 1024
FORMAT = pyaudio.paInt16
CHANNELS = 1
RATE = 16000
WIDTH = 2

#p = pyaudio.PyAudio()

IP_Address = raw_input("Enter the host IP address: ")

HOST = '127.0.0.1'                 # Symbolic name meaning all available interfaces
PORT = 10010              # Arbitrary non-privileged port
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(1)
conn, addr = s.accept()
client = mqtt.Client()
client.connect(IP_Address, 1883, 60)
print 'Connected by', addr
data = conn.recv(1024)
frames = bytearray(data)
while True:
	data = conn.recv(1024)
	frames = bytearray(data)
	client.publish('voice',frames)
	print "message sent"
conn.close()
