//Variables for a Chladni pattern
float a = 1;
float b = 1;
float m = 7;
float n = 2;

float error = 0.1; //Error from 0 for the equation

PImage buffer; //Buffer image to make drawing of the image faster

float zoff; //Z offset in 3d perlin noise

//Setup canvas and buffer
void setup() {
  size(640, 480);
  buffer = createImage(width, height, RGB);
}

void draw() {
  buffer.loadPixels(); //Load the pixels
  for ( int x = 0; x < width; x++ ) { //Loop through width of canvas
    for ( int y = 0; y < height; y++ ) { //Loop through height of canvas
      int index = x + y * width; //Get 1d index for 2d array index

      //Map x and y to a number between -1 and 1 for the equation 
      float pointX = map(x, 0, width, -1, 1);
      float pointY = map(y, 0, height, -1, 1);

      //Find the value of the X Y point, if it is close to 0 it is part of the chladni pattern
      double point = (a*(Math.sin(Math.PI*n*pointX)*Math.sin(Math.PI*m*pointY))) + (b*(Math.sin(Math.PI*m*pointX)*Math.sin(Math.PI*n*pointY))); 
      if ( point + error > 0 && point - error < 0 && random(1)>0.0) {
        //Turn x and y into numbers which are closer to the points next to them (not a distance of 1, instead a distance of 0.01 meaning the transition is smoother in perlin noise)
        float xoff = x * 0.01; 
        float yoff = y * 0.01;

        //Get the noise value for the X Y and Z offset
        float c = noise(xoff, yoff, zoff)*255;

        buffer.pixels[index] = color(c, 0, 255-c, 80); //Colour the pixel of the buffer
      } else {
        buffer.pixels[index] = color(0); //Colour the pixel of the buffer black
      }
    }
  }
  buffer.updatePixels(); //Update the buffer iamge

  image(buffer, 0, 0); //Draw the image on the screen

  //Change n and m to animate the patterns
  m -= 0.025;
  n += 0.025;

  zoff += 0.1; //Increase Z offset to "move" through the perlin noise
}
