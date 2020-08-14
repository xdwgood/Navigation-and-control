cmake_minimum_required(VERSION 3.0.2)
project(beginner_tutorials)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  message_generation
  std_msgs
  actionlib_msgs
  actionlib
  pluginlib
)

add_action_files(
   FILES
   Fibonacci.action
)

add_message_files(
        FILES
        Num.msg
        Area.msg
)

add_service_files(
  FILES
  AddTwoInts.srv
)

generate_messages(
        DEPENDENCIES
        std_msgs
        actionlib_msgs
)

catkin_package(
  CATKIN_DEPENDS message_runtime roscpp rospy std_msgs
)

include_directories(
# include
  ${catkin_INCLUDE_DIRS}
)


add_executable(hello_world src/hello_world/hello_world.cpp)

target_link_libraries(hello_world ${catkin_LIBRARIES})

add_dependencies(hello_world ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})


add_executable(listener src/listener/listener.cpp)

target_link_libraries(listener ${catkin_LIBRARIES})

add_dependencies(listener ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(talker src/talker/talker.cpp)

target_link_libraries(talker ${catkin_LIBRARIES})

add_dependencies(talker ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(listenersrv src/listener/listenersrv.cpp)

target_link_libraries(listenersrv ${catkin_LIBRARIES})
add_dependencies(listenersrv ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
add_executable(talkersrv src/talker/talkersrv.cpp)
target_link_libraries(talkersrv ${catkin_LIBRARIES})
add_dependencies(talkersrv ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(talker_para src/talker/talker_para.cpp)
target_link_libraries(talker_para ${catkin_LIBRARIES})
add_dependencies(talker_para ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(fibonacci_server src/fibonacci/fibonacci_server.cpp)

target_link_libraries(fibonacci_server ${catkin_LIBRARIES})

add_dependencies(fibonacci_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(fibonacci_client src/fibonacci/fibonacci_client.cpp)
target_link_libraries(fibonacci_client ${catkin_LIBRARIES})
add_dependencies(fibonacci_client ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

add_executable(plugin_use src/plugin_use/plugin_use.cpp)

target_link_libraries(plugin_use ${catkin_LIBRARIES})

add_dependencies(plugin_use ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

install(TARGETS hello_world RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION})
