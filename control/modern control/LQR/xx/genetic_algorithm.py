import numpy as np
from numpy.random import randint
from random import random, gauss, uniform
from drone import dt
from math import isnan

# Fitness calculation variables (LQR)
R = [350, 35, 28000, 0.36]
Q = [8, 0.1, 8, 0.1, 5, 0.00000003, 3400, 50]


class GA:
    def __init__(self, pop_size, genes_nb=8, genes_upper_lim=0, genes_lower_lim=2, z_enable=True):
        self.pop_size = pop_size
        self.genes_nb = genes_nb
        self.genes_upper_lim = genes_upper_lim
        self.genes_lower_lim = genes_lower_lim
        self.z_enable = z_enable
        self.population = []
        self.fitness = []
        self.init_pop()
        self.mutation_variance = 0.8
        self.reproduction_rate = 0.6

    def init_pop(self):
        for _ in range(self.pop_size):
            self.population.append(self.individual())

    def individual(self):
        # Creating individual
        individual = []
        for i in range(3):
            temp = [0]*8
            temp[i] = round(random() * (self.genes_upper_lim - self.genes_lower_lim) + self.genes_lower_lim, 2)
            temp[i+3] = round(random() * (self.genes_upper_lim - self.genes_lower_lim) + self.genes_lower_lim, 2)
            individual += [temp]

        # z part
        individual += [[0]*8]
        individual[-1][-2] = round(random() * -100, 2)
        individual[-1][-1] = round(random() * -100, 2)
        return individual

    def individual_fitness(self, response, control_signal):
        # Calculating fitness
        # Squaring response part
        phi_squared = [Q[0]*element[0]**2 for element in response]
        phi_dot_squared = [Q[3]*element[1]**2 for element in response]
        theta_squared = [Q[1]*element[2]**2 for element in response]
        theta_dot_squared = [Q[4]*element[3]**2 for element in response]
        psi_squared = [Q[2]*element[4]**2 for element in response]
        psi_dot_squared = [Q[5]*element[5]**2 for element in response]
        z_squared = [Q[6]*element[6]**2 for element in response]
        z_dot_squared = [Q[7]*element[7]**2 for element in response]

        # Squaring control signal part
        tau_phi_squared = [R[0]*element[0]**2 for element in control_signal]
        tau_theta_squared = [R[1]*element[1]**2 for element in control_signal]
        tau_psi_squared = [R[2]*element[2]**2 for element in control_signal]
        thrust_squared = [R[3]*element[3]**2 for element in control_signal]

        # Adding the weighted parts
        total = [phi_squared[i] + phi_dot_squared[i] + theta_squared[i] + theta_dot_squared[i] +
                 psi_squared[i] + psi_dot_squared[i] + z_squared[i]+z_dot_squared[i] +
                 tau_phi_squared[i] + tau_theta_squared[i] +
                 tau_psi_squared[i] + thrust_squared[i] for i in range(len(response))]
        integral = dt * ((total[0]+total[-1])/2 + sum(total[1:-1]))
        if isnan(integral):
            return 9999999
        else:
            return integral

    def calculate_fitness(self, state_memories, control_memories):
        # Calculate fitness for each individual and sorting them
        fitness = [[round(self.individual_fitness(state_memories[i], control_memories[i]), 2), i]
                   for i in range(len(state_memories))]
        fitness_sorted, sorted_index = zip(*sorted(fitness, reverse=True))
        self.population = [self.population[i] for i in sorted_index]
        print(fitness_sorted, " = ", round(sum(fitness_sorted)))
        self.fitness = fitness_sorted

    def selection(self, state_memories, control_memories):
        # Roulette wheel selection
        self.calculate_fitness(state_memories, control_memories)
        chance = gauss(self.reproduction_rate, 0.11)
        while chance > 1 or chance < 0:
            chance = gauss(self.reproduction_rate, 0.11)
        # Reversing the fitness so the ones who has the lowest fitness have a higher chance to get selected
        fitnesses = [round(abs(self.fitness[i]-1.1*max(self.fitness)), 2) for i in range(len(self.fitness))]
        sum_fitness = sum(fitnesses)
        fitness_normalised = [fitness/sum_fitness for fitness in fitnesses]
        # Selecting
        fitness_cumsum = list(np.cumsum(fitness_normalised))
        fitness_cumsum.append(chance)
        selection_index = sorted(fitness_cumsum).index(chance)
        selection = list(range(selection_index, self.pop_size))
        while len(selection) < 2:
            selection = self.selection(state_memories, control_memories)
        else:
            if len(selection) % 2 == 1:
                return selection[1:]
            else:
                return selection

    def mating(self, selection):
        for i in range(0, len(selection), 2):
            pivot_point = randint(1, self.genes_nb)
            child_one = []
            child_two = []
            for j in range(4):
                if self.z_enable and j == 3:
                    pivot_point = 7
                child_one += [self.population[selection[i]][j][0:pivot_point] +
                              self.population[selection[i+1]][j][pivot_point:]]
                child_two += [self.population[selection[i+1]][j][0:pivot_point] +
                              self.population[selection[i]][j][pivot_point:]]
            self.population[i] = child_one
            self.population[i+1] = child_two

    def mutation(self):
        # Mutation for all genes of all individuals except the 2 best individual
        for j, person in enumerate(self.population[:-2]):
            for k, genes in enumerate(person):
                for i, gene in enumerate(genes):
                    if uniform(0, 1) <= 0.3 and self.population[j][k][i] != 0:
                        if k == 3 and (i == 6 or i == 7):
                            self.population[j][k][i] = max(-100, min(round(gauss(gene, self.mutation_variance), 2), 0))
                        else:
                            self.population[j][k][i] = max(self.genes_lower_lim, min(round(gauss(gene, self.mutation_variance), 2), self.genes_upper_lim))