# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "ros_learn_service: 0 messages, 1 services")

set(MSG_I_FLAGS "-Istd_msgs:/opt/ros/melodic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(ros_learn_service_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_custom_target(_ros_learn_service_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "ros_learn_service" "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages

### Generating Services
_generate_srv_cpp(ros_learn_service
  "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ros_learn_service
)

### Generating Module File
_generate_module_cpp(ros_learn_service
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ros_learn_service
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(ros_learn_service_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(ros_learn_service_generate_messages ros_learn_service_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_dependencies(ros_learn_service_generate_messages_cpp _ros_learn_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ros_learn_service_gencpp)
add_dependencies(ros_learn_service_gencpp ros_learn_service_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ros_learn_service_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages

### Generating Services
_generate_srv_eus(ros_learn_service
  "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ros_learn_service
)

### Generating Module File
_generate_module_eus(ros_learn_service
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ros_learn_service
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(ros_learn_service_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(ros_learn_service_generate_messages ros_learn_service_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_dependencies(ros_learn_service_generate_messages_eus _ros_learn_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ros_learn_service_geneus)
add_dependencies(ros_learn_service_geneus ros_learn_service_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ros_learn_service_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages

### Generating Services
_generate_srv_lisp(ros_learn_service
  "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ros_learn_service
)

### Generating Module File
_generate_module_lisp(ros_learn_service
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ros_learn_service
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(ros_learn_service_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(ros_learn_service_generate_messages ros_learn_service_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_dependencies(ros_learn_service_generate_messages_lisp _ros_learn_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ros_learn_service_genlisp)
add_dependencies(ros_learn_service_genlisp ros_learn_service_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ros_learn_service_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages

### Generating Services
_generate_srv_nodejs(ros_learn_service
  "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ros_learn_service
)

### Generating Module File
_generate_module_nodejs(ros_learn_service
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ros_learn_service
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(ros_learn_service_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(ros_learn_service_generate_messages ros_learn_service_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_dependencies(ros_learn_service_generate_messages_nodejs _ros_learn_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ros_learn_service_gennodejs)
add_dependencies(ros_learn_service_gennodejs ros_learn_service_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ros_learn_service_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages

### Generating Services
_generate_srv_py(ros_learn_service
  "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ros_learn_service
)

### Generating Module File
_generate_module_py(ros_learn_service
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ros_learn_service
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(ros_learn_service_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(ros_learn_service_generate_messages ros_learn_service_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/dw/Navigation-and-control/Ros/ros_robtic/src/ros_learn_service/srv/SrvTutorial.srv" NAME_WE)
add_dependencies(ros_learn_service_generate_messages_py _ros_learn_service_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(ros_learn_service_genpy)
add_dependencies(ros_learn_service_genpy ros_learn_service_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS ros_learn_service_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ros_learn_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/ros_learn_service
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(ros_learn_service_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ros_learn_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/ros_learn_service
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(ros_learn_service_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ros_learn_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/ros_learn_service
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(ros_learn_service_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ros_learn_service)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/ros_learn_service
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(ros_learn_service_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ros_learn_service)
  install(CODE "execute_process(COMMAND \"/usr/bin/python2\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ros_learn_service\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/ros_learn_service
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(ros_learn_service_generate_messages_py std_msgs_generate_messages_py)
endif()
