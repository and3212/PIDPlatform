class Hexagon {

    // Draws the base hexagon
    void drawBase(int top, int bottom) {
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

    // Draws the hex plate
    void drawPlate() {
        int zA = platform.getZ(HEX_AX, HEX_AY);
        int zB = platform.getZ(HEX_BX, HEX_BY);
        int zC = platform.getZ(HEX_CX, HEX_CY);
        int zD = platform.getZ(HEX_DX, HEX_DY);
        int zE = platform.getZ(HEX_EX, HEX_EY);
        int zF = platform.getZ(HEX_FX, HEX_FY);
        noStroke();
        fill(100, 100, 0);

        // Bottom
        beginShape();
        vertex(HEX_AX, HEX_AY, zA);
        vertex(HEX_BX, HEX_BY, zB);
        vertex(HEX_CX, HEX_CY, zC);
        vertex(HEX_DX, HEX_DY, zD);
        vertex(HEX_EX, HEX_EY, zE);
        vertex(HEX_FX, HEX_FY, zF);
        vertex(HEX_AX, HEX_AY, zA);
        endShape();

        // Top
        beginShape();
        vertex(HEX_AX, HEX_AY, zA - HEXPLATE_HEIGHT);
        vertex(HEX_BX, HEX_BY, zB - HEXPLATE_HEIGHT);
        vertex(HEX_CX, HEX_CY, zC - HEXPLATE_HEIGHT);
        vertex(HEX_DX, HEX_DY, zD - HEXPLATE_HEIGHT);
        vertex(HEX_EX, HEX_EY, zE - HEXPLATE_HEIGHT);
        vertex(HEX_FX, HEX_FY, zF - HEXPLATE_HEIGHT);
        vertex(HEX_AX, HEX_AY, zA - HEXPLATE_HEIGHT);
        endShape();

        // Walls
        stroke(255);
        beginShape(QUADS);
        vertex(HEX_AX, HEX_AY, zA - HEXPLATE_HEIGHT);
        vertex(HEX_AX, HEX_AY, zA);
        vertex(HEX_BX, HEX_BY, zB);
        vertex(HEX_BX, HEX_BY, zB - HEXPLATE_HEIGHT);

        vertex(HEX_BX, HEX_BY, zB - HEXPLATE_HEIGHT);
        vertex(HEX_BX, HEX_BY, zB);
        vertex(HEX_CX, HEX_CY, zC);
        vertex(HEX_CX, HEX_CY, zC - HEXPLATE_HEIGHT);

        vertex(HEX_CX, HEX_CY, zC - HEXPLATE_HEIGHT);
        vertex(HEX_CX, HEX_CY, zC);
        vertex(HEX_DX, HEX_DY, zD);
        vertex(HEX_DX, HEX_DY, zD - HEXPLATE_HEIGHT);

        vertex(HEX_DX, HEX_DY, zD - HEXPLATE_HEIGHT);
        vertex(HEX_DX, HEX_DY, zD);
        vertex(HEX_EX, HEX_EY, zE);
        vertex(HEX_EX, HEX_EY, zE - HEXPLATE_HEIGHT);

        vertex(HEX_EX, HEX_EY, zE - HEXPLATE_HEIGHT);
        vertex(HEX_EX, HEX_EY, zE);
        vertex(HEX_FX, HEX_FY, zF);
        vertex(HEX_FX, HEX_FY, zF - HEXPLATE_HEIGHT);

        vertex(HEX_FX, HEX_FY, zF - HEXPLATE_HEIGHT);
        vertex(HEX_FX, HEX_FY, zF);
        vertex(HEX_AX, HEX_AY, zA);
        vertex(HEX_AX, HEX_AY, zA - HEXPLATE_HEIGHT);
        endShape();
    }
}
