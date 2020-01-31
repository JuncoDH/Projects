class Population {
  int n_population = 100;//50;
  int count_alive = n_population;
  Dot[] p = new Dot[n_population];
  float sum_fitness = 0;
  Population() {
    for(int i = 0; i < n_population; i++) {
      p[i] = new Dot();
    }
  }
  //show the population
  void show() {
    for(int i = 0; i < n_population; i++) {
      p[i].show();
    }
  }
  
  void update() {
    count_alive = 0;
    for(int i = 0; i < n_population; i++) {
      p[i].update();
      if(p[i].alive() == true) {
        count_alive ++;
      }
    }
  }
  
  boolean alive() {
    return count_alive > 0;
  }
  //sum all fitness
  void calc_fitness() {
    float sum = 0;
    for(int i = 0; i < n_population; i++) {
      p[i].calc_fitness();
      sum += p[i].fitness;
    }
    sum_fitness = sum;
  }
  //take the one with the highest fitness
  int update_the_best() {
    calc_fitness();
    int i = 0;
    for(int j = 1; j < n_population; j++) {
      if(p[j].fitness > p[i].fitness) {i = j;}
    }
    p[i].is_the_best = true;
    return i;
  }
  //sum all the fitness and the parent is proportional to the strength
  int find_parent() {
    calc_fitness();
    float sum = 0, rand = random(sum_fitness);
    for(int i = 0; i < n_population; i++) {
      sum += p[i].fitness;
      if(sum >= rand) {return i;}
    }
    println("ERROR EN FIND PARENT");
    return -1;
  }
  //clone the brain of the parent
  Population natural_selection() {
    int the_best = update_the_best();
    Population np = new Population();
    for(int i = 0; i < n_population; i++) {
      np.p[i].brain = p[find_parent()].brain.clone();
    }
    np.p[the_best].brain = p[the_best].brain.clone();
    if(p[the_best].reached_goal == true) {
      println("the best", the_best, "with ", p[the_best].brain.step,"steps");
    } else {
      println("the best", the_best, "not reached goal");
    }
    np.p[the_best].is_the_best = true;
    
    
    return np;
  }
  //mutate with a ratio of 5%
  void mutate() {
    float mutate_ratio = 0.05;//0.01;
    
    for(int i = 0; i < n_population; i++) {
      if(p[i].is_the_best) continue;
      for(int j = 0; j < p[i].brain.MAX_STEP; j++) {
        
        if(random(1) < mutate_ratio) {
          p[i].brain.update(j);
        }
      }
    }
  }
  
}
