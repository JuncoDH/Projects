class Dot{
  float x;
  float y;
  Brain brain;
  
  boolean died = false;
  boolean reached_goal = false;
  boolean is_the_best = false;
  
  float fitness = 0;
  
  Dot() {
    //start at the middle lower screen
    x = SCREEN_X/2;
    y = SCREEN_Y - 20;
    brain = new Brain();
  }
  void show() {
    if(is_the_best == true) {
      fill(0, 255, 0);
      ellipse(x, y, 12, 12);
    }
    else {
      fill(0);
      ellipse(x, y, 8, 8);
    }
  }
  void update() {
    float random_interval = 10;
    if(died == true) {
      return;
    }
    if(brain.step == brain.MAX_STEP) {
      died = true;
      return;
    }
    //move knowing the position and the angle
    x = x + random_interval*cos(brain.angle[brain.step++]);
    y = y + random_interval*sin(brain.angle[brain.step++]);

    if(x <= 0 || y <= 0 || x >= SCREEN_X || y >= SCREEN_Y) {
      died = true;
    }
    //The red killer rectangle
    if(0 <= x && x <= 500 && 200 <= y && y <= 225) {
      died = true;
    }
    
    if(dist(goal_x, goal_y, x, y) < 5) {
      reached_goal = true;
      died = true;
    }
  }
  
  boolean alive() {
    return died == false;
  }
  //fitness function, if not reached the goal then 1/dist^2, else 1M/brain.step^2
  void calc_fitness() {
    if(reached_goal) {
      fitness = 1000000.0 / (brain.step*brain.step+1);
    }
    else {
      fitness = 1.0/(dist(goal_x, goal_y, x, y)*dist(goal_x, goal_y, x, y));
    }
  }
  
}
