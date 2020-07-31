#include <iostream>
#include "ros/ros.h"
#include "new_msgs/student.h"

using namespace std;

void callback(const new_msgs::student::ConstPtr &message) {
  cout << message->name << endl;
  cout << message->age << endl;
  cout << "-----------------------" << endl;
}

int main(int argc, char **argv) {
  // 创建节点
  string nodeName = "my_subscriber1";
  ros::init(argc, argv, nodeName);
  ros::NodeHandle node;

  //创建订阅者
  string topicName = "my_topic";
  const ros::Subscriber &subscriber = node.subscribe(topicName, 1000, callback);

  ros::spin();
  return 0;
}

