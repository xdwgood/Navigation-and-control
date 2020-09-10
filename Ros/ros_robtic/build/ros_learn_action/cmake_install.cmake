# Install script for directory: /home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_action

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/dw/Navigation-and-control/Ros/ros_robtic/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action/action" TYPE FILE FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_action/action/Fibonacci.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action/msg" TYPE FILE FILES
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciAction.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciActionGoal.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciActionResult.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciActionFeedback.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciGoal.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciResult.msg"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/ros_learn_action/msg/FibonacciFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action/cmake" TYPE FILE FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/build/ros_learn_action/catkin_generated/installspace/ros_learn_action-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/include/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/roseus/ros/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/common-lisp/ros/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/share/gennodejs/ros/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python2" -m compileall "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/lib/python2.7/dist-packages/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python2.7/dist-packages" TYPE DIRECTORY FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/devel/lib/python2.7/dist-packages/ros_learn_action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/build/ros_learn_action/catkin_generated/installspace/ros_learn_action.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action/cmake" TYPE FILE FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/build/ros_learn_action/catkin_generated/installspace/ros_learn_action-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action/cmake" TYPE FILE FILES
    "/home/dw/Navigation-and-control/Ros/ros_robtic/build/ros_learn_action/catkin_generated/installspace/ros_learn_actionConfig.cmake"
    "/home/dw/Navigation-and-control/Ros/ros_robtic/build/ros_learn_action/catkin_generated/installspace/ros_learn_actionConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ros_learn_action" TYPE FILE FILES "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_action/package.xml")
endif()

