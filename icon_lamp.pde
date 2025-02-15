PGraphics logo_canvas;
PGraphics lava_canvas;

PShape logo_icon_vector;

Blob[] blobs;
Corner[] corners;

int resolution;

void setup() {
    size(400, 400);
    // fullScreen(P2D, 2);
    logo_canvas = createGraphics(width, height);
    lava_canvas = createGraphics(width, height);

    logo_icon_vector = loadShape("logo_icon.svg");

    blendMode(EXCLUSION);

    int blob_radius = 0;
    blobs = new Blob[1];
    for (int i = 0; i < blobs.length; i++) {
        blob_radius = sort_radius();
        blobs[i] = new Blob(blob_radius);
    }

    resolution = 200;
    updateResolution(resolution);
    println("corner length: " + corners.length);

}

void draw() {
    background(255);
    updateCorners();
    logo_drawer();
    lava_drawer();
}

void logo_drawer() {
    logo_canvas.beginDraw();
    logo_canvas.background(255);
    logo_canvas.shapeMode(CENTER);
    float horizontal_ratio = width / logo_icon_vector.width;
    float vertical_ratio = height / logo_icon_vector.height;
    float ratio  =  min(horizontal_ratio, vertical_ratio) * 0.8;
    float new_horizontal_size = logo_icon_vector.width * ratio;
    float new_vertical_size = logo_icon_vector.height * ratio;
    logo_canvas.shape(logo_icon_vector, width/2, height/2, new_horizontal_size, new_vertical_size);

    for (int i = 0; i < corners.length; i++) {
        corners[i].display(logo_canvas, 3);
    }

    logo_canvas.endDraw();
    image(logo_canvas, 0, 0);
}

void lava_drawer() {
    lava_canvas.beginDraw();
    lava_canvas.background(255);
    // lava_canvas.fill(0);
    // lava_canvas.circle(mouseX, mouseY, 100);
    for (int i = 0; i < blobs.length; i++) {
        blobs[i].update();
        blobs[i].display(lava_canvas);
    }
    lava_canvas.endDraw();
    image(lava_canvas, 0, 0);
}

int sort_radius() {
    float min_radius = min(width, height) / 30;
    float max_radius = min(width, height) / 4;
    float mean = (max_radius - min_radius) / 2.5;
    float standard_deviation = (max_radius - min_radius) / 4;
    float bias = 0.3;
    int sorted_radius = int(standard_deviation * (randomGaussian() - bias) + mean);
    if (sorted_radius < min_radius) {
        sorted_radius = int(min_radius);
    } else if (sorted_radius > max_radius) {
        sorted_radius = int(max_radius);
    }
    return sorted_radius;
}

void updateResolution(int newResolution) {
    createCorners(newResolution);
}

void createCorners(int resolution) {
    int columns = ceil(width / resolution) + 1;
    int rows = ceil(height / resolution) + 1;
    int totalCorners = columns * rows;
    corners = new Corner[totalCorners];
    for (int i = 0; i < columns; i++) {
        for (int j = 0; j < rows; j++) {
            int index = i + j * columns;
            corners[index] = new Corner(i * resolution, j * resolution);    
        }
    }
}

void updateCorners() {
    for (int i = 0; i < corners.length; i++) {
        corners[i].resetValue();
        for (int j = 0; j < blobs.length; j++) {
            corners[i].updateValue(blobs[j].getX(), blobs[j].getY(), blobs[j].getRadius());
        }
    }
}