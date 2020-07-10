from drone import Drone
from genetic_algorithm import *
from math import pi


def deg2rad(list1):
    list1[0] = list1[0] / 180 * pi
    list1[1] = list1[1] / 180 * pi
    list1[2] = list1[2] / 180 * pi
    return list1


# Initialisation and algorithm object creation
steps = 200
population_number = 100
ga = GA(population_number)

# Creating, initialising and giving to the drone the reference
# The angles are in degrees, and : state = [phi, theta, psi, P, Q, R, Z, Z_dot]
init_state = deg2rad([5, 5, 5, 0, 0, 0, -1, 0])
ref_state = deg2rad([0, 0, 0, 0, 0, 0, 0, 0])
drone = Drone(init_state=init_state, ref_state=ref_state)

for generation in range(steps):
    all_state_memories = []
    all_control_memories = []
    if generation % 10 == 0:
        print("Generation :", generation)
    for index in range(population_number):
        # Resetting the drone memory
        drone.reset_memory()
        # Simulating the drone for that gain
        drone.simulate(ga.population[index])
        # Storing the memory for the fitness calculation
        all_state_memories.append(drone.state_memory)
        all_control_memories.append(drone.control_memory)
    # Selecting individual
    selection = ga.selection(all_state_memories, all_control_memories)
    # Mating and mutation
    ga.mating(selection)
    ga.mutation()
    # Printing and showing graphs part
    if generation == steps - 1:
        print('\ngain :', ga.population[index])
        drone.position_show()
        drone.angle_show()
        drone.control_angle_show()
        drone.control_thrust_show()