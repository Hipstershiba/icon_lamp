class Corner {
    private PVector position;
    private float value;

    Corner(float x, float y) {
        this.position = new PVector(x, y);
        this.value = 0;
        this.oberservers = [];
    }

    public void resetValue() {
        this.value = 0;
    }

    public void updateValue(float x, float y, float radius) {
        float r = sq(radius);
        float deltaX = sq(x - this.position.x);
        float deltaY = sq(y - this.position.y);
        this.value += r / (deltaX + deltaY);
    }

    public void display(PGraphics layer, float wieght) {
        if (this.value >= 1) {
            layer.stroke(0, 255, 0);
        } else {
            layer.stroke(0, 0, 0);
        }
        layer.strokeWeight(weight);
        layer.point(this.position.x, this.position.y);
    }

    public PVector getPosition() {
        return this.position;
    }

    public float getX() {
        return this.position.x;
    }

    public float getY() {
        return this.position.y;
    }

    public float getValue() {
        return this.value;
    }
}