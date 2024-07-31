PGraphics logo_canvas;
PGraphics lava_canvas;

PShape logo_icon_vector;

Blob[] blobs;
// this values will devide the width of the screen,
// so the larger the value, smaller the blob.
float minRadius = 30;
float smallRadius = 20;
float largeRadius = 10;
float maxRadius = 3;

void setup() {
    // size(800, 800);
    fullScreen();
    logo_canvas = createGraphics(width, height);
    lava_canvas = createGraphics(width, height);

    logo_icon_vector = loadShape("logo_icon.svg");

    blendMode(DIFFERENCE);

    minRadius = width/minRadius;
    smallRadius = width/smallRadius;
    largeRadius = width/largeRadius;
    maxRadius = width/maxRadius;

    blobs = new Blob[60];
    for (int i = 0; i < blobs.length; i++) {
        blobs[i] = new Blob(random(random(random(minRadius,smallRadius), random(smallRadius,largeRadius)), random(largeRadius, maxRadius)));
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