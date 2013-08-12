import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import processing.opengl.*;

// vars

Minim minim;
AudioOutput out;
AudioPlayer player;
Oscil osc;

SineWave sine;
SawWave saw;
TestEffect testEffect;

HashMap<Integer, color[]> colors2;
Integer colorScheme;

Sphere[] spheres;

//control vars
float lfo;


void setup() {
  // display
  size(displayWidth, displayHeight, OPENGL);
  // size(10,10, OPENGL);
  background(0);
  smooth();

  // audio
  minim = new Minim(this);
  out = minim.getLineOut(minim.STEREO);
  
  // testEffect = new TestEffect();

  // visual objects
  spheres = new Sphere[(int)out.sampleRate()/2];
  for (int i = 0; i < spheres.length; i++) {
    spheres[i] = new Sphere();
  }
  
  // colors schemes
  colorScheme = 0;
  color[] colors = {color(255, 128, 0), color(191, 120, 48), color(146, 67, 0), color(251, 145, 30), color(252, 174, 86), color(252, 167, 0), color(253, 189, 12)};
  colors2 = new HashMap<Integer, color[]>();
  colors2.put(0, colors );
  colors = null;
  color[] colors_ = {color(9,65,98),color(50,108,124),color(80,224,223),color(83,105,183),color(72,111,247),color(109,72,149),color(90,72,149)};
  colors2.put(1,colors_); 
}



void draw() {
  lights();
  background(0);

  // println(getRandomColor());

  pushMatrix();
  translate(200, height/2);
  //rotateZ(radians(frameCount));
  float[] samples = out.mix.toArray();
  for (int i = 0; i < samples.length; i++) {

    float y1 = samples[i] *1000;
    float y2 = samples[i] *100;

    // Sphere sp = new Sphere(i+1.0*3, height/2+y1, 5.0, getRandomColor() );
    if (i%3 == 0) {
    // rotateY(radians(frameCount));
      spheres[i].setPosX(i+3.0).setPosY(y1).setSize(y2/random(1, 10)).setColor(getRandomColor());
      spheres[i].setPosZ(random(y2*random(-100, 50))).draw();
    }
    // stroke(0);
    // point(i, y1);
    //stroke(255,0,0);
    //point(i, y2);
  }

  popMatrix();
  /*
  fill(0, 25);
   rect(0, 0, width, height);
   */
}


void keyPressed() {

  switch(key) {
  case 'w':
  case 'W':
    {
      // colorScheme = colorScheme^1;
      colorScheme = 0;
      out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "B2" ).asHz(),0.9, lfo, out));
      break;
      
    }
  case 'q':
  case 'Q':
    {
      /*
      sine.setFreq(130.813);
       saw.setFreq(65.4064);
       */
       colorScheme = 0;
    //  out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "C3" ).asHz(),0.9, lfo, out));
      out.playNote(0.0, 2.0, new WobbleInstrument(396.0,0.9, lfo, out));
      break;
    }
  case 's':
  case 'S':
    {
      colorScheme = 1;
      // out.playNote(0.0, 2.0, "D3");
    //  out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "D3" ).asHz(),0.9, lfo, out));
    out.playNote(0.0, 2.0, new WobbleInstrument(417.0,0.9, lfo, out));
      break;
    }
  case 'd':
  case 'D':
    {
      // out.playNote(0.0, 2.0, "E3");
      //out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "E3" ).asHz(),0.9, lfo, out));
      out.playNote(0.0, 2.0, new WobbleInstrument(528.0,0.9, lfo, out));
      break;
    }
  case 'f':
  case 'F':
    {
      // out.playNote(0.0, 2.0, "F3");
      // out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "F3" ).asHz(),0.9, lfo, out));
      out.playNote(0.0, 2.0, new WobbleInstrument(639.0,0.9, lfo, out));
      break;
    }
  case 'g':
  case 'G':
    {
      // out.playNote(0.0, 2.0, "G3");
      // out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "G3" ).asHz(),0.9, lfo, out));
      out.playNote(0.0, 2.0, new WobbleInstrument(741.0,0.9, lfo, out));
      break;
    }
  case 'a':
  case 'A':
    {
      // out.playNote(0.0, 2.0, "A3");
      out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "A3" ).asHz(),0.9, lfo, out));
      break;
    }
  case 'j':
  case 'J':
    {
      // out.playNote(0.0, 2.0, "B3");
      // out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "B3" ).asHz(),0.9, lfo, out));
      out.playNote(0.0, 2.0, new WobbleInstrument(852.0,0.9, lfo, out));
      break;
    }
    case 'k':
  case 'K':
    {
      // out.playNote(0.0, 2.0, "C4");
      out.playNote(0.0, 2.0, new WobbleInstrument(Frequency.ofPitch( "C4" ).asHz(),0.9, lfo, out));
      break;
    }
  case ' ':
    {
      if ( out.isMuted() ) 
      {
        out.unmute();
      }
      else 
      {
        out.mute();
      }
      break;
    }

  case CODED:
    {
      switch(keyCode) {
      case UP:
        {
          out.playNote(0.0, 1.0, new WobbleInstrument( 110.0f, 0.7, lfo, out ));
          break;
        }
      case DOWN:
      case LEFT:
      case RIGHT:
      } 
      break;
    }
  default:
    {
    }
  }
}


color getRandomColor() {
  // return colors2.get[(int)random(colors.length)] ;
  color[] c = colors2.get(colorScheme);
  return c[(int)random(c.length)];
}

void stop() {
  out.close();
  minim.stop();
  super.stop();
}

class TestEffect implements AudioEffect {

  void process(float[] samp) {
    float[] test = new float[samp.length];
    for (int i = 0; i < test.length; i+=30) {
      if (i > 0 && i % 3 == 0) {
        test[i] = samp[i-1];
      }

      if (i % (int)random(1, 157)+1 == 0) {
        test[i]*=157;
      }
    }
    arraycopy(test, samp);
  }

  void process(float[] left, float[] right)
  {
    process(left);
    process(right);
  }
}

void mouseMoved(){
  lfo = map(mouseY, 0, height, 0.00, 50.0+random(22.0));
  
  
}
