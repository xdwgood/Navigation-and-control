#include "ros/ros.h"
#include "ros_learn_7/MsgTutorial.h"

int main(int argc,char **argv){

    ros::init(argc,argv,"topic_publisher");
    ros::NodeHandle nh;

    ros::Publisher ros_learn_7_pub = nh.advertise<ros_learn_7::MsgTutorial>("ros_learn_7_msg",100);

    ros::Rate loop_rate(1);
    ros_learn_7::MsgTutorial msg;

    int count = 0;

    while(ros::ok()){

        msg.stamp = ros::Time::now();
        msg.data = count;
        ROS_INFO("send %d",msg.data);
        ros_learn_7_pub.publish(msg);
        loop_rate.sleep();
        ++count;
    }
    
    return 0;
}