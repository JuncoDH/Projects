// CodeBullet https://www.youtube.com/watch?v=BOZfhUcNiqk
//https://processing.org/reference/rect_.html

int SCREEN_X = 800;
int SCREEN_Y = 400;

int goal_x = SCREEN_X/2;
int goal_y = 20;
  
void setup() {
  //Size of the screen
  size(800, 400);
}

//Your population
Population p = new Population();


//WARN, IT FAILS IF IT FINDS A LOCAL MINIMUM, THEN INCREASE THE POPULATION NUMBER OR THE RANDOM ANGLE OF THE MUTATION
void draw() {
  //Background white
  background(255);
  
  //Print goal
  fill(0, 0, 255);
  ellipse(goal_x, goal_y, 10, 10);
  
  //Print red obstacle
  fill(255, 0, 0);
  rect(0, 200, 500, 25);
  
  //If all your population is dead do a natural selection and mutate them
  if(p.alive() == false) {
      p = p.natural_selection(); 
      p.mutate();
      
  } else { //else print them and update them
   p.show();
   p.update();
  }
}
