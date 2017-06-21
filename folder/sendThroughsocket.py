import bluetooth
import gtk
import logging
import time
import os
import sys
import threading
import time
import socket
import paho.mqtt.client as mqtt
import multiprocessing 


DEVICE_NAME = "HXM"
LOG = logging.getLogger("hxm")
HOST_IS_DOWN_SIGNATURE = "Host is down"


class HXM(object):
	
	def __init__(self):
		
		self.__connected = False
		self.__is_stopping = False

		
	def __lookup_bt_address(self):
		
		max_tries = 10
		tries = 0
		while tries < max_tries and not self.__is_stopping:
			tries += 1
			print("Scanning bluetooth devices... (try %d of %d)" \
					 % (tries, max_tries))

			for addr, name in bluetooth.discover_devices(lookup_names=True):
				print("Found device: %s (%s)" % (name, addr))
				if name is not None and name.startswith(DEVICE_NAME):
					return addr

	def __connect(self):
		
		btsocket = bluetooth.BluetoothSocket(bluetooth.RFCOMM)

		address = self.__lookup_bt_address()
		
		print("Connecting to BT address: %s" % address)
		btsocket.connect((address, 1))
		return btsocket
	
	def __decode(self, data):
		
		if len(data) != 59:
			return None, None
		
		if ord(data[1]) != 55:
			LOG.debug("__decode, data[1] != 55, ignoring frame")
			return None, None
		
		
		hr = ord(data[11])	 
		bat = ord(data[10])  
		return hr, bat
		
	def __listen(self, btsocket):
		while not self.__is_stopping:
			data = btsocket.recv(60)

			hr, bat = self.__decode(data)
			#print (hr, bat)
			if hr and bat:
				return hr, bat

	def run(self,conn):
		
		btsocket = self.__connect()
		if btsocket is None:
			return
		
		while not self.__is_stopping:
			try:
				while btsocket is None and not self.__is_stopping:
					time.sleep(1)
					#results_receiver(None, None)
					btsocket = self.__connect()
			
				(hr, bat) = self.__listen(btsocket)
				print "Getting information..."		
				conn.send(" HR: %d, bat: %d" % (hr, bat))

			except bluetooth.BluetoothError, ex:
				LOG.exception("Bluetooth error, will try to reconnect")
				btsocket = None
		
		
	def stop(self):

		self.__is_stopping = True
				

class HXMThread(threading.Thread):
	def __init__(self, results_receiver):

		threading.Thread.__init__(self)
		self.__results_receiver = results_receiver
		self.__hxm = HXM()
	
	def run(self):

		self.__hxm.run(self.__results_receiver)
		
	def stop(self):
		
		self.__hxm.stop()

if __name__ == "__main__":
	logging.basicConfig(stream=sys.stdout, level=logging.DEBUG)
	#client = mqtt.Client()
	#client.connect(IP_Address, 1883, 60)	
	queue = multiprocessing.Queue()
	hxm = HXM()
	put_conn, get_conn = multiprocessing.Pipe()
	p= multiprocessing.Process(target=hxm.run, args=(put_conn,))
	p.start()
	s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
	s.connect(("127.0.0.1", 10020))
	while True:
		s.send(get_conn.recv())
		
	#while True:
		#client.publish("topic",get_conn.recv())
	#p.join() 
	#client.loop_forever()
	

	
