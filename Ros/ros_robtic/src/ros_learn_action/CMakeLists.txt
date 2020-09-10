cmake_minimum_required(VERSION 3.0.2)
project(ros_learn_action)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rosmsg
  message_generation
  actionlib_msgs
  actionlib
)

add_action_files(
   FILES
   Fibonacci.action
)

## Generate added messages and services with any dependencies listed here
generate_messages(
        DEPENDENCIES
        std_msgs
        actionlib_msgs
)

catkin_package(
  CATKIN_DEPENDS roscpp rosmsg message_runtime
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

add_executable(action_server src/action_server.cpp)
target_link_libraries(action_server ${catkin_LIBRARIES})
add_dependencies(action_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(action_client src/action_client.cpp)
target_link_libraries(action_client ${catkin_LIBRARIES})
add_dependencies(action_client ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})