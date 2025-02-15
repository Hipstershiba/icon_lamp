class Blob {
  // Propriedades fisicas
  private float radius;
  private float diameter;
  private float density;

  // Vetores de posicao, velocidade e aceleracao
  private PVector position;
  private PVector speed;
  private PVector acceleration;
  private float maxSpeed;
  private float maxAcceleration;

  // Propriedades de movimento
  private int noiseStart;
  private float noiseStep;

  public Blob(float radius) {
    this.radius = radius;
    this.diameter = radius * 2;
    this.density = 1;

    float x = ((width/2) * map(radius, min(width, height) / 30, min(width, height) / 4, 1, 0)) * randomGaussian() + width/2;
    float y = random(-radius, height + radius);

    this.position = new PVector(x, y);
    this.speed = new PVector(0, random(-1, 1));
    this.acceleration = new PVector(0, 0);
    this.maxSpeed = 1;
    this.maxAcceleration = 0.01;

    this.noiseStart = int(random(10000));
    this.noiseStep = 2;
  }

  public void update() {
    this.accelerate();
    this.updateSpeed();
    this.move();
    this.bouncyBorders();
  } 

  public void display(PGraphics layer) {
    if(layer != null) {
      layer.fill(0);
      layer.noStroke();
      layer.circle(this.position.x,this.position.y, this.diameter);
    }
  }

  private void updateSpeed() {
    this.speed.add(this.acceleration);
    this.speed.limit(this.maxSpeed);
  }

  private void move() {
    this.position.add(this.speed);
  }

  private void accelerate() {
    this.noiseStep += 0.00005;
    float noiseX = noise(noiseStart + noiseStep);
    float noiseY = noise(noiseStart + noiseStep + 1000);

    float x = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration/50, maxAcceleration/50);
    float y = map(noise(noiseStart + noiseStep), 0, 1, -maxAcceleration, maxAcceleration);

    this.acceleration.set(x, y);
  }

  private void bouncyBorders() {
    float tolerance = 0.1;
    float bounceFactor = -0.5;

    if (this.position.x > width + radius * tolerance) {
      this.position.x = width + radius * tolerance;
      this.speed.x *= bounceFactor;
    } else if (this.position.x < -radius * tolerance) {
      this.position.x = -radius * tolerance;
      this.speed.x *= bounceFactor;
    }

    if (this.position.y > height + radius * tolerance) {
      this.position.y = height + radius * tolerance;
      this.speed.y *= bounceFactor;
    } else if (this.position.y < -radius * tolerance) {
      this.position.y = -radius * tolerance;
      this.speed.y *= bounceFactor;
    }
  }

  public PVector getPosition() {
    return this.position.copy();
  }

  public float getX() {
    return this.position.x;
  }

  public float getY() {
    return this.position.y;
  }

  public float getRadius() {
    return this.radius;
  }

}
