cmake_minimum_required(VERSION 3.0.2)
project(ros_learn_service)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rosmsg
  message_generation
)

## Generate services in the 'srv' folder
add_service_files(
  FILES
  SrvTutorial.srv
)

## Generate added messages and services with any dependencies listed here
generate_messages(
        DEPENDENCIES
        std_msgs
)

catkin_package(
  CATKIN_DEPENDS roscpp rosmsg message_runtime
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)

add_executable(service_server src/service_server.cpp)
target_link_libraries(service_server ${catkin_LIBRARIES})
add_dependencies(service_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(service_client src/service_client.cpp)
target_link_libraries(service_client ${catkin_LIBRARIES})
add_dependencies(service_client ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
