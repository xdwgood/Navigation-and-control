#include "ros/ros.h"
#include "ros_learn_7/MsgTutorial.h"

void msgCallback(const ros_learn_7::MsgTutorial::ConstPtr&msg){
    
    ROS_INFO("recieve %d",msg->data);

}

int main(int argc,char **argv){

    ros::init(argc,argv,"topic_subscriber");
    ros::NodeHandle nh;

    ros::Subscriber ros_learn_7_sub = nh.subscribe("ros_learn_7_msg",100,msgCallback);

    ros::spin();
    return 0;
}