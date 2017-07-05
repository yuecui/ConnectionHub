import socket
import pyaudio
import wave
import time
import paho.mqtt.client as mqtt
from datetime import datetime
from time import strftime
CHUNK = 1024
CHANNELS = 1
RATE = 8000
WIDTH = 2
print "This program is used for accepting audio data"
IP_Address = raw_input("Enter the host address:")
TOPIC = raw_input("Enter the topic:")
# The callback for when the client receives a CONNACK response from the server.
def on_connect(client, userdata, rc):
    print("Connected with result code "+ str(rc))
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe(TOPIC)

# The callback for when a PUBLISH message is received from the server.
def on_message(client, userdata, msg):	

	data = msg.payload
	stream.write(data)
	print  datetime.now().time().strftime("%H:%M:%S"), "listening...."
client = mqtt.Client()
	
	
p = pyaudio.PyAudio()	
stream = p.open(format=p.get_format_from_width(WIDTH),
            channels=CHANNELS,
            rate=RATE,
            output=True,
            frames_per_buffer=CHUNK)
client.on_connect = on_connect
client.on_message = on_message

client.connect(IP_Address, 1883, 60)

# Blocking call that processes network traffic, dispatches callbacks and
# handles reconnecting.
# Other loop*() functions are available that give a threaded interface and a
# manual interface.
client.loop_forever()


