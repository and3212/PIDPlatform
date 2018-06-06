import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class sim extends PApplet {

final int DIMENSION_SCALE = 3;
final float GRAVITY = 0.1f;

float rotX = radians(270);
float rotY = radians(0);
float rotZ = radians(0);
float zoom = 0.5f;
float xTrans = 0;
float yTrans = -200;
float rotX_saved = radians(270);
float rotY_saved = radians(0);
float rotZ_saved = radians(0);
float zoom_saved = 0.5f;
float xTrans_saved = 0;
float yTrans_saved = -200;
boolean zEnabled = false;

// Platform variables
final int PLATFORM_LENGTH = (165 * DIMENSION_SCALE);
final int PLATFORM_WIDTH = (105 * DIMENSION_SCALE);
final int PLATFORM_HEIGHT = 4 * DIMENSION_SCALE;
final int PLATFORM_BOTTOM = (150 * DIMENSION_SCALE);
final int PLATFORM_TOP = PLATFORM_BOTTOM + PLATFORM_HEIGHT;


final int HEXPLATE_BOTTOM = PLATFORM_BOTTOM - PLATFORM_HEIGHT;
final int HEXPLATE_TOP = PLATFORM_BOTTOM;
final int HEXPLATE_MID = HEXPLATE_BOTTOM + (int)(abs(HEXPLATE_TOP - HEXPLATE_BOTTOM) / 2.0f);


final int HEX_R = (100 * DIMENSION_SCALE);  // Radius of the circle the hexagon is circumscribed in
final int HEX_S = (150 * DIMENSION_SCALE);  // Length of the larger side
final int HEX_H = (int) sqrt((HEX_R * HEX_R) - ((HEX_S * HEX_S) / 4.0f));
final int HEX_Z = (50 * DIMENSION_SCALE);  // Thickness of the hexagon
final int HEX_M = (15 * DIMENSION_SCALE);   // Motor offset from the sides

final int HEX_AX = (int)-(HEX_S / 2.0f);
final int HEX_AY = -HEX_H;
final int HEX_BX = (int)(HEX_S / 2.0f);
final int HEX_BY = -HEX_H;
final int HEX_CX = (int)((HEX_H * cos(PI/6)) + (HEX_S / 2.0f * cos(-PI/3)));
final int HEX_CY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0f * sin(-PI/3)));
final int HEX_DX = (int)((HEX_H * cos(PI/6)) + (HEX_S / 2.0f * cos(TWO_PI/3)));
final int HEX_DY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0f * sin(TWO_PI/3)));
final int HEX_EX = (int)-((HEX_H * cos(PI/6)) + (HEX_S / 2.0f * cos(TWO_PI/3)));
final int HEX_EY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0f * sin(TWO_PI/3)));
final int HEX_FX = (int)-((HEX_H * cos(PI/6)) + (HEX_S / 2.0f * cos(-PI/3)));
final int HEX_FY = (int)((HEX_H * sin(PI/6)) + (HEX_S / 2.0f * sin(-PI/3)));

// Points for anchors
final int ANCHOR_OFFSET = (3 * DIMENSION_SCALE);
final int ANCHOR_FX = (int)(((HEX_FX + (HEX_AX + HEX_FX) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;
final int ANCHOR_FY = (int)(((HEX_FY + (HEX_AY + HEX_FY) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;
final int ANCHOR_AX = (int)(((HEX_AX + (HEX_AX + HEX_FX) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;
final int ANCHOR_AY = (int)(((HEX_AY + (HEX_AY + HEX_FY) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;

final int ANCHOR_BX = (int)(((HEX_BX + (HEX_BX + HEX_CX) / 2.0f)) / 2.0f) + ANCHOR_OFFSET;
final int ANCHOR_BY = (int)(((HEX_BY + (HEX_BY + HEX_CY) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;
final int ANCHOR_CX = (int)(((HEX_CX + (HEX_BX + HEX_CX) / 2.0f)) / 2.0f) + ANCHOR_OFFSET;
final int ANCHOR_CY = (int)(((HEX_CY + (HEX_BY + HEX_CY) / 2.0f)) / 2.0f) - ANCHOR_OFFSET;

final int ANCHOR_DX = (int)(((HEX_DX + (HEX_DX + HEX_EX) / 2.0f)) / 2.0f);
final int ANCHOR_DY = (int)(((HEX_DY + (HEX_DY + HEX_EY) / 2.0f)) / 2.0f) + ANCHOR_OFFSET;
final int ANCHOR_EX = (int)(((HEX_EX + (HEX_DX + HEX_EX) / 2.0f)) / 2.0f);
final int ANCHOR_EY = (int)(((HEX_EY + (HEX_DY + HEX_EY) / 2.0f)) / 2.0f) + ANCHOR_OFFSET;

final int ANCHOR_Z = HEXPLATE_MID;

// Points for motors
final int MOTOR_AX = HEX_AX + HEX_M;
final int MOTOR_AY = HEX_AY;
final int MOTOR_BX = HEX_BX - HEX_M;
final int MOTOR_BY = HEX_BY;

// final int MOTOR_CX = HEX_CX - (int)(HEX_M * cos(PI/3));
// final int MOTOR_CY = HEX_CY + (int)(HEX_M * sin(PI/3));
// final int MOTOR_DX = HEX_DX + (int)(HEX_M * cos(PI/3));
// final int MOTOR_DY = HEX_DY - (int)(HEX_M * sin(PI/3));
//
// final int MOTOR_EX = HEX_EX - (int)(HEX_M * cos(PI/3));
// final int MOTOR_EY = HEX_EY - (int)(HEX_M * sin(PI/3));
// final int MOTOR_FX = HEX_FX + (int)(HEX_M * cos(PI/3));
// final int MOTOR_FY = HEX_FY + (int)(HEX_M * sin(PI/3));


//       Length
// |------------------|
// |                  | Width
// |------------------|
//
// Height is 3D

//              |       |     |
//              |   O   |     |
//              |       |     | <-- edge of the hex wall
//              |       |     |
//                   5mm  5mm
// To center = wall.x - 10mm
// Height = 35mm?

final int SERVO_HEIGHT = 35 * DIMENSION_SCALE;
Arm arms[];
Ball ball;

// Platform variables
Platform platform;
PVector pA = new PVector(HEX_AX, HEX_AY, 0);
PVector pB = new PVector(HEX_BX, HEX_BY, 0);
PVector pC = new PVector(HEX_CX, HEX_CY, 0);


public void setup() {
    
    background(0);
    lights();

    // Initialize arms
    arms = new Arm[6];
    arms[0] = new Arm('A', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[1] = new Arm('B', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    arms[2] = new Arm('C', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[3] = new Arm('D', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    arms[4] = new Arm('E', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    arms[5] = new Arm('F', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);

    // Initialize the Platform
    platform = new Platform(PLATFORM_LENGTH, PLATFORM_WIDTH, PLATFORM_HEIGHT);
    ball = new Ball(50);

    // arms[0] = new Arm('A', MOTOR_AX, MOTOR_AY, SERVO_HEIGHT, ANCHOR_AX, ANCHOR_AY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
    // arms[1] = new Arm('B', MOTOR_BX, MOTOR_BY, SERVO_HEIGHT, ANCHOR_BX, ANCHOR_BY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
    // arms[2] = new Arm('C', MOTOR_CX, MOTOR_CY, SERVO_HEIGHT, ANCHOR_CX, ANCHOR_CY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
    // arms[3] = new Arm('D', MOTOR_DX, MOTOR_DY, SERVO_HEIGHT, ANCHOR_DX, ANCHOR_DY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
    // arms[4] = new Arm('E', MOTOR_EX, MOTOR_EY, SERVO_HEIGHT, ANCHOR_EX, ANCHOR_EY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
    // arms[5] = new Arm('F', MOTOR_FX, MOTOR_FY, SERVO_HEIGHT, ANCHOR_FX, ANCHOR_FY, PLATFORM_BOTTOM - PLATFORM_THICKNESS);
}

public void draw() {
    background(0);
    lights();

    // Sets up the environment
    translate(width / 2, height / 2);
    scale(1, -1);

    // Custom movement from mouse events
    translate(xTrans, yTrans);
    scale(zoom);
    rotateX(rotX);
    rotateY(rotY);
    rotateZ(rotZ);

    // Draws the bottom grid reference plane
    fill(75, 0, 130);
    stroke(255);
    strokeWeight(2);
    int graphWidth = 10*100;
    int graphHeight = 10*100;
    int startX = -graphWidth/2;
    int startY = -graphHeight/2;
    pushMatrix();
    translate(0, 0, -1);
    rect(startX, startY, graphWidth, graphHeight);

    for (int x = 0; x < graphHeight; x += 100) {
        line(startX + x, startY, startX + x, startY + graphHeight);
    }
    for (int y = 0; y < graphWidth; y += 100) {
        line(startX, startY + y, startX + graphWidth, startY + y);
    }
    popMatrix();
    strokeWeight(1);
    stroke(255);

    pA.z = arms[0].getHeight();
    pB.z = arms[1].getHeight();
    pC.z = arms[2].getHeight();
    platform.update(pA, pB, pC);
    platform.draw();

    ball.move();
    ball.draw();

    drawHex(HEX_Z, 0);
    drawHex(HEXPLATE_TOP, HEXPLATE_BOTTOM);


    anchors();
    arms[0].dot();
    arms[1].dot();
    arms[2].dot();
    arms[3].dot();
    arms[4].dot();
    arms[5].dot();
    //
    arms[0].drawKnob();
    arms[1].drawKnob();
    arms[2].drawKnob();
    arms[3].drawKnob();
    arms[4].drawKnob();
    arms[5].drawKnob();
    //
    arms[0].drawArm();
    arms[1].drawArm();
    arms[2].drawArm();
    arms[3].drawArm();
    arms[4].drawArm();
    arms[5].drawArm();

    pushMatrix();
    translate(-300, -500, 0);
    sphere(10);
    popMatrix();
}


// Draws a hexagon
public void drawHex(int top, int bottom) {
    noStroke();
    fill(100, 100, 0);

    // Bottom of the base
    beginShape();
    vertex(HEX_AX, HEX_AY, bottom);
    vertex(HEX_BX, HEX_BY, bottom);
    vertex(HEX_CX, HEX_CY, bottom);
    vertex(HEX_DX, HEX_DY, bottom);
    vertex(HEX_EX, HEX_EY, bottom);
    vertex(HEX_FX, HEX_FY, bottom);
    vertex(HEX_AX, HEX_AY, bottom);
    endShape();

    // Top of the base
    beginShape();
    vertex(HEX_AX, HEX_AY, top);
    vertex(HEX_BX, HEX_BY, top);
    vertex(HEX_CX, HEX_CY, top);
    vertex(HEX_DX, HEX_DY, top);
    vertex(HEX_EX, HEX_EY, top);
    vertex(HEX_FX, HEX_FY, top);
    vertex(HEX_AX, HEX_AY, top);
    endShape();

    // Walls of the base
    stroke(255);
    beginShape(QUADS);
    vertex(HEX_AX, HEX_AY, top);
    vertex(HEX_AX, HEX_AY, bottom);
    vertex(HEX_BX, HEX_BY, bottom);
    vertex(HEX_BX, HEX_BY, top);

    vertex(HEX_BX, HEX_BY, top);
    vertex(HEX_BX, HEX_BY, bottom);
    vertex(HEX_CX, HEX_CY, bottom);
    vertex(HEX_CX, HEX_CY, top);

    vertex(HEX_CX, HEX_CY, top);
    vertex(HEX_CX, HEX_CY, bottom);
    vertex(HEX_DX, HEX_DY, bottom);
    vertex(HEX_DX, HEX_DY, top);

    vertex(HEX_DX, HEX_DY, top);
    vertex(HEX_DX, HEX_DY, bottom);
    vertex(HEX_EX, HEX_EY, bottom);
    vertex(HEX_EX, HEX_EY, top);

    vertex(HEX_EX, HEX_EY, top);
    vertex(HEX_EX, HEX_EY, bottom);
    vertex(HEX_FX, HEX_FY, bottom);
    vertex(HEX_FX, HEX_FY, top);

    vertex(HEX_FX, HEX_FY, top);
    vertex(HEX_FX, HEX_FY, bottom);
    vertex(HEX_AX, HEX_AY, bottom);
    vertex(HEX_AX, HEX_AY, top);
    endShape();
}

// Draws the platform


// (-g, -h) -- 1 -- Red
// (g, -h)  -- 2 -- Orange
// (e, -f)   -- 3 -- Yellow
// (d, c)   -- 4 -- Green
// (-d, c)  -- 5 -- Blue
// (-e, -f)  -- 6 -- Purple

public void anchors() {
    stroke(0);

    // 1 top
    pushMatrix();
    translate(ANCHOR_AX, ANCHOR_AY, ANCHOR_Z);
    fill(255, 0, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 2 top
    pushMatrix();
    translate(ANCHOR_BX, ANCHOR_BY, ANCHOR_Z);
    fill(255, 127, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 3 top
    pushMatrix();
    translate(ANCHOR_CX, ANCHOR_CY, ANCHOR_Z);
    fill(255, 255, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 4 top
    pushMatrix();
    translate(ANCHOR_DX, ANCHOR_DY, ANCHOR_Z);
    fill(0, 255, 0);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 5 top
    pushMatrix();
    translate(ANCHOR_EX, ANCHOR_EY, ANCHOR_Z);
    fill(0, 0, 255);
    ellipse(0, 0, 25, 25);
    popMatrix();

    // 6 top
    pushMatrix();
    translate(ANCHOR_FX, ANCHOR_FY, ANCHOR_Z);
    fill(75, 0, 130);
    ellipse(0, 0, 25, 25);
    popMatrix();
}




// Rotates and moves the sketch
public void mouseDragged() {
    if (mouseButton == LEFT && zEnabled) {
        float rate = 0.01f;
        rotZ += (mouseX - pmouseX) * rate;
    }
    else if (mouseButton == LEFT) {
        float rate = 0.01f;
        rotX += (mouseY - pmouseY) * rate;
        rotY += (mouseX - pmouseX) * rate;

    } else if (mouseButton == RIGHT) {
        yTrans += (pmouseY - mouseY);
        xTrans += (mouseX - pmouseX);
    }
}

// Zoom in and out with the scroll wheel
public void mouseWheel(MouseEvent event) {
    float e = event.getCount();
    zoom += e / 100.0f;
}

// Key press logic
public void keyPressed() {
    // Reset the camera
    if (key == 'x' || key == 'X') {
        rotX = radians(270);
        rotY = radians(0);
        rotZ = radians(0);
        zoom = 0.5f;
        xTrans = 0;
        yTrans = -200;
    // Save the current camera position
    } else if (key == 'c' || key == 'C') {
        rotX_saved = rotX;
        rotY_saved = rotY;
        rotZ_saved = rotZ;
        zoom_saved = zoom;
        xTrans_saved = xTrans;
        yTrans_saved = yTrans;
    // Jump back to the saved position
    } else if (key == 'v' || key == 'V') {
        rotX = rotX_saved;
        rotY = rotY_saved;
        rotZ = rotZ_saved;
        zoom = zoom_saved;
        xTrans = xTrans_saved;
        yTrans = yTrans_saved;
    } else if (key == 'z' || key == 'Z') {
        zEnabled = !zEnabled;
    }
}
class Arm {
    private int servoX;
    private int servoY;
    private int servoZ;
    private char letter;

    private int anchorX;
    private int anchorY;
    private int anchorZ;

    private int knobWidth = 11 * DIMENSION_SCALE;
    private int knobLength = 30 * DIMENSION_SCALE;
    private int leftRight;

    private int l;
    private PVector p = new PVector(0, 0, 0);
    private int b;
    private int t;
    private int q;

    Arm(char letter_, int servoX_, int servoY_, int servoZ_,
        int anchorX_, int anchorY_, int anchorZ_) {
        letter = letter_;
        servoX = servoX_;
        servoY = servoY_;
        servoZ = servoZ_;
        anchorX = anchorX_;
        anchorY = anchorY_;
        anchorZ = anchorZ_;

        leftRight = ((int)letter % 2 == 0) ? -1 : 1;
        t = anchorZ - servoZ;
        b = abs(servoX - anchorX);
        p.z = t;
        l = PLATFORM_BOTTOM;
    }

    public void dot() {
        pushMatrix();
        stroke(225);
        fill(0, 0, 0);
        fixRotation();

        translate(servoX, servoY, servoZ);
        sphere(14);

        popMatrix();
    }

    public void drawKnob() {
        pushMatrix();
        stroke(255);
        fill(255, 0, 0);
        fixRotation();

        translate(servoX, servoY-PLATFORM_HEIGHT, servoZ - (ceil(knobWidth/2.0f)));
        rotateX(radians(90));
        rect(0, 0, leftRight * knobLength, knobWidth);

        popMatrix();
    }

    public void drawArm() {
        pushMatrix();
        noFill();
        stroke(150);
        strokeWeight(3 * DIMENSION_SCALE);
        fixRotation();

        int knobCoordX = servoX + (leftRight * knobLength);
        int knobCoordY = servoY - PLATFORM_HEIGHT;
        int knobCoordZ = servoZ;
        line(anchorX, anchorY, anchorZ, knobCoordX, knobCoordY, knobCoordZ);

        int step1 = (anchorX - knobCoordX) * (anchorX - knobCoordX);
        int step2 = (anchorY - knobCoordY) * (anchorY - knobCoordY);
        //println(sqrt(step1 + step2));

        popMatrix();
    }

    public void fixRotation() {
        if (letter == 'C' || letter == 'D') {
            rotateZ(radians(120));
        } else if (letter == 'E' || letter == 'F') {
            rotateZ(radians(240));
        }
    }

    public void find_li() {

    }

    public int getHeight() {
        return l;
    }

}
class Ball {
    private PVector position = new PVector(0, 0, 1000);
    private PVector velocity = new PVector(0, 0, 0);
    private int radius;

    Ball(int radius_) {
        radius = radius_;
    }

    // Updates the position of the ball
    public void move() {
        int platformTop = platform.getZ((int)position.x, (int)position.y);
        PVector v = platform.getPlaneVector();
        float theta = acos(v.z / sqrt(v.x * v.x + v.y * v.y + v.z * v.z));

        // Updates Z direction
        velocity.z -= GRAVITY;
        position.z += velocity.z;

        // If we are on the platform
        if (position.z <= platformTop + radius + PLATFORM_HEIGHT) {
            position.z = platformTop + radius + PLATFORM_HEIGHT;

            velocity.x -= GRAVITY * platform.dxDZ();
            println(platform.dxDZ());
            position.x += velocity.x;

            velocity.y -= GRAVITY * platform.dyDZ();
            position.y += velocity.y;
        } else {
            velocity.x = 0;
            velocity.y = 0;
        }

    }

    // Draws the ball to the screen
    public void draw() {
        fill(150);
        noStroke();

        pushMatrix();
        translate(position.x, position.y, position.z);
        sphere(radius);
        popMatrix();
    }
}
//TODO integrate this into the main file

// The {x, y, z, roll, pitch, yaw} that we want to end up at
//float pos[6] = {0, 0, 0, radians(0), radians(0), radians(0) };




/*void getmatrix(float pos[]) {
    float phi = pos[3];     // Roll
    float theta = pos[4];   // Pitch
    float psi = pos[5];     // Yaw
    M[0][0] = cos(psi)*cos(theta);
    M[1][0] = -sin(psi)*cos(phi)+cos(psi)*sin(theta)*sin(phi);
    M[2][0] = sin(psi)*sin(phi)+cos(psi)*cos(phi)*sin(theta);

    M[0][1] = sin(psi)*cos(theta);
    M[1][1] = cos(psi)*cos(phi)+sin(psi)*sin(theta)*sin(phi);
    M[2][1] = cos(theta)*sin(phi);

    M[0][2] = -sin(theta);
    M[1][2] = -cos(psi)*sin(phi)+sin(psi)*sin(theta)*cos(phi);
    M[2][2] = cos(theta)*cos(phi);
}
*/


public float getAlpha() {
    // return arcsin(L / sqrt(M * M + N * N) ) ;
    return 0.1f;
}
class Platform {
    // D is based off of anchor A
    private float d;
    private PVector v1 = new PVector(0, 0, 0);  //HEX_AX - HEX_BX, HEX_AY - HEX_BY, 0
    private PVector v2 = new PVector(0, 0, 0);  //HEX_CX - HEX_BX, HEX_CY - HEX_BY, 0
    private PVector v3 = new PVector(0, 0, 0);
    private int PLATFORM_LENGTH;
    private int PLATFORM_WIDTH;
    private int PLATFORM_HEIGHT;

    Platform(int l, int w, int h){
        PLATFORM_LENGTH = l;
        PLATFORM_WIDTH = w;
        PLATFORM_HEIGHT = h;
    }

    // Updates the plaftorm
    public void update(PVector pA, PVector pB, PVector pC){
        // Creates the first vector
        v1.x = pA.x - pB.x;
        v1.y = pA.y - pB.y;
        // v1.z = pA.z - pB.z;
        v1.z = 130;

        // Creates the second vector
        v2.x = pC.x - pB.x;
        v2.y = pC.y - pB.y;
        v2.z = pC.z - pB.z;

        // Creates the normal vector and solves for d
        v3.x = (v1.y * v2.z - v1.z * v2.y);
        v3.y = (v1.z * v2.x - v1.x * v2.z);
        v3.z = (v1.x * v2.y - v1.y * v2.x);
        d = (pA.x * v3.x) + (pA.y * v3.y) + (pA.z * v3.z);  //TODO if pA doesnt work add a pR
    }

    public PVector getPlaneVector() {
        return v3;
    }

    public int getZ(int x, int y) {
        // z = (-a/c)x + (-b/c)y + d/c
        // a = v.x
        // b = v.y
        // c = v.z

        float z = (-v3.x / v3.z) * x + (-v3.y / v3.z) * y + (d / v3.z);
        return (int)z;
    }


    // dx/dz = -a/c
    public float dxDZ() {
        return -v3.x / v3.z;
    }

    // dy/dz = -b/c
    public float dyDZ() {
        return -v3.y / v3.z;
    }

    // Draws the platform
    public void draw() {
        // Calculates the Z coordinates for each corner
        int z1_b = getZ(PLATFORM_LENGTH, PLATFORM_WIDTH);
        int z2_b = getZ(-PLATFORM_LENGTH, PLATFORM_WIDTH);
        int z3_b = getZ(-PLATFORM_LENGTH, -PLATFORM_WIDTH);
        int z4_b = getZ(PLATFORM_LENGTH, -PLATFORM_WIDTH);
        int z1_t = z1_b + PLATFORM_HEIGHT;
        int z2_t = z2_b + PLATFORM_HEIGHT;
        int z3_t = z3_b + PLATFORM_HEIGHT;
        int z4_t = z4_b + PLATFORM_HEIGHT;
        fill(0,100,100);
        stroke(255);

        beginShape(QUADS);
        // Bottom
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);

        // Sides
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);

        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_b);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);

        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_b);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);

        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_b);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_b);

        // Top
        vertex(PLATFORM_LENGTH, PLATFORM_WIDTH, z1_t);
        vertex(-PLATFORM_LENGTH, PLATFORM_WIDTH, z2_t);
        vertex(-PLATFORM_LENGTH, -PLATFORM_WIDTH, z3_t);
        vertex(PLATFORM_LENGTH, -PLATFORM_WIDTH, z4_t);
        endShape();
    }
}
  public void settings() {  size(1024, 1024, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "sim" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
