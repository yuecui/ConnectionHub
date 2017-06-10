#include <iostream>
#include <unistd.h>
#include <cstdio>
#include <cstring>
#include <sys/types.h> 
#include <sys/socket.h>
#include <netinet/in.h>
#include <mosquittopp.h>
#include <mosquitto.h>
#include "Communicator.h"
using namespace std;

class Communicator* mySender = NULL;

int main(int argc, char *argv[]){
	mosqpp::lib_init();

	char IP_Address[40], topic[20], port[10];
	
	cout << "Enter the topic:";
	std::cin >> topic;	

	cout << "Enter the port number that your TOPIC at:";
	std::cin >> port;

	cout << "Enter the HOST's IP:";
	std::cin >> IP_Address;



	mySender = new Communicator("1",topic,IP_Address, 1883);

	int sockfd, newsockfd, portno;
	socklen_t clilen;
	char buffer[256];
	int n;
	struct sockaddr_in serv_addr, cli_addr;

	sockfd = socket(AF_INET, SOCK_STREAM, 0);
	
	if (sockfd < 0) 
	printf("ERROR opening socket\n");
	bzero((char *) &serv_addr, sizeof(serv_addr));
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = INADDR_ANY;
	serv_addr.sin_port = htons(atoi(port));
	if (bind(sockfd, (struct sockaddr *) &serv_addr,sizeof(serv_addr)) < 0) 
		  printf("ERROR on binding\n");
	listen(sockfd,5);
	clilen = sizeof(cli_addr);
	newsockfd = accept(sockfd, (struct sockaddr *) &cli_addr, &clilen);
	if (newsockfd < 0) 
	  printf("ERROR on accept\n");
	bzero(buffer,256);
	while (1) {
		n = read(newsockfd,buffer,255);
		if (n < 0) printf("ERROR reading from socket\n");
		mySender->send_message(buffer);
	}
	close(newsockfd);
	close(sockfd);

	
	mosqpp::lib_cleanup();
	
	return 0;
}


