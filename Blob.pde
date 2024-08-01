class Blob {
  float radius;
  float diameter;
  float x;
  float y;
  float speedX;
  float speedY;
  float accelerationX;
  float accelerationY;
  float maxSpeed;
  float maxAcceleration;
  int noiseStart;
  float noiseStep;

  Blob(float radius) {
    this.radius = radius;
    diameter = radius * 2;
    x = ((width/2) * map(radius, min(width, height) / 30, min(width, height) / 4, 1, 0)) * randomGaussian() + width/2;
    y = random(-radius, height + radius);
    speedX = 0;
    speedY = random(-1, 1);
    accelerationX = 0;
    accelerationY = 0;
    maxSpeed = 1;
    maxAcceleration = 0.01;
    noiseStart = int(random(10000));
  }

  void display(PGraphics layer) {
    if(layer != null) {
      layer.fill(0);
      layer.noStroke();
      layer.circle(x, y, diameter);
    }
  }

  void update() {
    accelerate();
    updateSpeed();
    move();
    bouncyBorders();
  }

  void move() {
    // x += speedX;
    y += speedY;
  }

  void updateSpeed() {
    speedX += accelerationX;
    speedY += accelerationY;
    speedX = constrain(speedX, -maxSpeed, maxSpeed);
    speedY = constrain(speedY, -maxSpeed, maxSpeed);
  }

  void accelerate() {
    noiseStep += 0.00005;
    accelerationX = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration, maxAcceleration);
    accelerationY = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration, maxAcceleration);
  }

  void bouncyBorders() {
    if (x > width + radius/2) {
      x = width + radius/2;
      speedX *= -0.8;
    } else if (x < -radius/2) {
      x = -radius/2;
      speedX *= -0.8;
    }
    if (y > height + radius/2) {
      y = height + radius/2;
      speedY *= -0.8;
    } else if (y < -radius/2) {
      y = -radius/2;
      speedY *= -0.8;
    }
  }
}
