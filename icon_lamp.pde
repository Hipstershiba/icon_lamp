PGraphics logo_canvas;
PGraphics lava_canvas;

PShape logo_icon_vector;

Blob[] blobs;

void setup() {
    // size(800, 800);
    fullScreen();
    logo_canvas = createGraphics(width, height);
    lava_canvas = createGraphics(width, height);

    logo_icon_vector = loadShape("logo_icon.svg");

    blendMode(DIFFERENCE);

    int blob_radius = 0;
    blobs = new Blob[60];
    for (int i = 0; i < blobs.length; i++) {
        blob_radius = sort_radius();
        blobs[i] = new Blob(blob_radius);
    }
}

void draw() {
    background(255);
    logo_drawer();
    lava_drwer();
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
    logo_canvas.endDraw();
    image(logo_canvas, 0, 0);
}

void lava_drwer() {
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
    float mean = (max_radius - min_radius) / 2;
    float standard_deviation = (max_radius - min_radius) / 2;
    float bias = 0.3;
    int sorted_radius = int(standard_deviation * (randomGaussian() - bias) + mean);
    if (sorted_radius < min_radius) {
        sorted_radius = int(min_radius);
    } else if (sorted_radius > max_radius) {
        sorted_radius = int(max_radius);
    }
    return sorted_radius;
}