#include <mosquittopp.h>

#include <string.h>


class Communicator: public mosqpp::mosquittopp
{
private:
    const char *host;
    const char *id;
    const char *topic;
    int port;
    int keep_alive;


public:
    Communicator(const char *id,const char *topic, const char *host, int port);

    ~Communicator();

    void on_connect(int rc);

    void on_disconnect(int rc);

    void on_publish(int mid);

    bool send_message(const char * _message);
};
