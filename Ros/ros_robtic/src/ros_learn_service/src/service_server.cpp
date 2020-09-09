#include "ros/ros.h"
#include "ros_learn_service/SrvTutorial.h"

bool calculation(ros_learn_service::SrvTutorial::Request &req,ros_learn_service::SrvTutorial::Response &res){
    res.result = req.a + req.b;

    ROS_INFO("result %ld",(long int)res.result);
    return true;
}

int main(int argc,char **argv){

    ros::init(argc,argv,"service_server");
    ros::NodeHandle nh;

    ros::ServiceServer ros_learn_service_server = nh.advertiseService("ros_tutorial_srv",calculation);

    ros::spin();
    
    return 0;
}