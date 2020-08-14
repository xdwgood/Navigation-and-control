cmake_minimum_required(VERSION 3.0.2)
project(pluginlib_tutorials)

find_package(catkin REQUIRED COMPONENTS
  pluginlib
  roscpp
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

## Declare a C++ library
add_library(polygon_plugins
   src/polygon_plugins.cpp
)

add_executable(polygon_loader src/polygon_loader.cpp)
target_link_libraries(polygon_loader ${catkin_LIBRARIES})
