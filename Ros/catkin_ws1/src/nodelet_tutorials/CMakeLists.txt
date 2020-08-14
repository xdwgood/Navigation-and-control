cmake_minimum_required(VERSION 3.0.2)
project(nodelet_tutorials)

find_package(catkin REQUIRED COMPONENTS
  nodelet
  roscpp
  std_msgs
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)


add_library(${PROJECT_NAME} src/nodelet_plugins.cpp)
