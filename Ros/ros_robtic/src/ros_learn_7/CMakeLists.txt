cmake_minimum_required(VERSION 3.0.2)
project(ros_learn_7)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rosmsg
  message_generation
)

add_message_files(
        FILES
        MsgTutorial.msg
)
generate_messages(
        DEPENDENCIES
        std_msgs
)


catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES new_msgs
  CATKIN_DEPENDS roscpp rosmsg message_runtime
#  DEPENDS system_lib
)


include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

add_executable(topic_publisher src/topic_publisher.cpp)
target_link_libraries(topic_publisher
    ${catkin_LIBRARIES}
)

add_executable(topic_subscriber src/topic_subscriber.cpp)
target_link_libraries(topic_subscriber
    ${catkin_LIBRARIES}
)
