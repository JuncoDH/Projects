//This will keep the movements of the dot, for mutate them
class Brain {
  int MAX_STEP = 300;//1000;
  float[] angle = new float[MAX_STEP];
  int step = 0;
  //They will only move them random_anglek radians from their current angle, to not go backwards
  float random_angle = PI/5;
  Brain() {
    angle[0]  = random(-PI, PI);
    for(int i = 1; i < MAX_STEP; i++) {
      angle[i] = angle[i-1] + random(-random_angle, random_angle);
    }
  }
  Brain clone() {
    Brain nb = new Brain();
    for(int i = 0; i < MAX_STEP; i++) {
      nb.angle[i] = angle[i];
    }
    return nb;
  }
  //Randomize the i-th angle
  void update(int i) {
    if(i == 0) {angle[0]  = random(-PI, PI);}
    else angle[i] = angle[i-1] + random(-random_angle, random_angle);
    angle[i] = random(-random_angle, random_angle);
    
  }
  
}
