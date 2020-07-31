#include <iostream>
#include "ros/ros.h"

#include "new_msgs/student.h"

using namespace std;

int main(int argc, char **argv) {
  // 创建节点
  string nodeName = "my_publisher1";
  ros::init(argc, argv, nodeName);
  ros::NodeHandle node;

  //通过节点创建发布者
  string topicName = "my_topic";
  const ros::Publisher &publisher = node.advertise<new_msgs::student>(topicName, 1000);

  int index = 0;
  ros::Rate rate(1);
  while (ros::ok()) {
    //通过publisher发布消息
    new_msgs::student msg;
    msg.name = "name-" + to_string(index);
    msg.age = index;
    publisher.publish(msg);

    index++;
    rate.sleep();
  }

  ros::spin();
  return 0;
}