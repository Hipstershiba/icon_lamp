class Blob {
  float radius;
  float diameter;
  float density;

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
    density = 1;

    x = ((width/2) * map(radius, min(width, height) / 30, min(width, height) / 4, 1, 0)) * randomGaussian() + width/2;
    y = random(-radius, height + radius);

    speedX = 0;
    speedY = random(-1, 1);
    accelerationX = 0;
    accelerationY = 0;
    maxSpeed = 1;
    maxAcceleration = 0.01;

    noiseStart = int(random(10000));
    noiseStep = 2;
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
    x += speedX;
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
    accelerationX = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration/50, maxAcceleration/50);
    accelerationY = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration, maxAcceleration);
  }

  void bouncyBorders() {
    float radius_tolerance = 0.1;
    if (x > width + radius * radius_tolerance) {
      x = width + radius * radius_tolerance;
      speedX *= -0.8;
    } else if (x < -radius * radius_tolerance) {
      x = -radius * radius_tolerance;
      speedX *= -0.8;
    }
    if (y > height + radius * radius_tolerance) {
      y = height + radius * radius_tolerance;
      speedY *= -0.8;
    } else if (y < -radius * radius_tolerance) {
      y = -radius * radius_tolerance;
      speedY *= -0.8;
    }
  }
}
