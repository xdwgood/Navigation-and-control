#include "ros/ros.h"
#include "ros_learn_service/SrvTutorial.h"


int main(int argc,char **argv){

    ros::init(argc,argv,"service_client");
    ros::NodeHandle nh;

    ros::ServiceClient ros_learn_service_client = nh.serviceClient<ros_learn_service::SrvTutorial>("ros_tutorial_srv");
    ros_learn_service::SrvTutorial srv;

    srv.request.a = 1;
    srv.request.b = 2;

    if(ros_learn_service_client.call(srv)) {

        ROS_INFO("receive %ld",(long int)srv.response.result);

    } else {

        ROS_INFO("Failed");
        return 1;

    }
       
    return 0;
}