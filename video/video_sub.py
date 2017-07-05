# main.py

from flask import Flask, render_template, Response
import paho.mqtt.client as mqtt
import cv2
from datetime import datetime
from time import strftime
import numpy


def on_connect(client, userdata, rc):
    print("Connected with result code "+ str(rc))
    # Subscribing in on_connect() means that if we lose the connection and
    # reconnect then subscriptions will be renewed.
    client.subscribe("video")


def on_message(client, userdata, msg):	
	try:
		frame = msg.payload
		print len(frame)
		array = numpy.fromstring(frame,dtype=numpy.uint8)
		#array = array.reshape(480,640,3)
		data = cv2.imdecode(array, cv2.CV_LOAD_IMAGE_COLOR)
		cv2.imshow('frame' , data)
		if cv2.waitKey(1) & 0xFF == ord('q'):
			exit()
	except KeyboardInterrupt:
		cv2.destroyAllWindows()
		

if __name__ == '__main__':
	client = mqtt.Client()
	client.on_connect = on_connect
	client.on_message = on_message
	client.connect("192.168.43.148", 1883, 60)

	client.loop_forever()
