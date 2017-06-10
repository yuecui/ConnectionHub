#include <iostream>
#include "Communicator.h"
using namespace std;


//constructor that does initialization and start a new thread to process network traffic.
Communicator::Communicator(const char *id, const char *topic, const char *host, int port) : mosquittopp(id) {   
	mosqpp::lib_init();

	int keepalive = 60;    // Basic configuration setup for myMosq class	
	this->topic = topic;
	this->host = host;
	connect(host, port, keepalive);
	loop_start(); 
};


Communicator::~Communicator() {

    loop_stop();
    mosqpp::lib_cleanup();
}

void Communicator::on_connect(int rc) {
    if(rc == 0){
        cout <<"Connected with server" << endl;
    }else{
        cout << "Impossible to connect with server" << endl;
    }
}

void Communicator::on_disconnect(int rc) {
    cout << "disconnection" << endl;
}

void Communicator::on_publish(int mid) {
    cout << "Message succeed to be published" << endl;
}

bool Communicator::send_message(const char * _message) {
	const char * myTopic;
	myTopic = this->topic;
    int ret = publish(NULL, myTopic, strlen(_message), _message, 1, false);
    return (ret == MOSQ_ERR_SUCCESS);
}


