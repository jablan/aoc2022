#include <Arduino.h>
#include <U8g2lib.h>

#define BUZZER_PIN 6
#define DISPLAY_CS_PIN 10
#define DISPLAY_DC_PIN 9
#define DISPLAY_RS_PIN 8

U8G2_PCD8544_84X48_F_4W_HW_SPI u8g2(U8G2_R0, DISPLAY_CS_PIN, DISPLAY_DC_PIN, DISPLAY_RS_PIN);

const char input[] PROGMEM = "addx 15\n"
"addx -11\n"
"addx 6\n"
"addx -3\n"
"addx 5\n"
"addx -1\n"
"addx -8\n"
"addx 13\n"
"addx 4\n"
"noop\n"
"addx -1\n"
"addx 5\n"
"addx -1\n"
"addx 5\n"
"addx -1\n"
"addx 5\n"
"addx -1\n"
"addx 5\n"
"addx -1\n"
"addx -35\n"
"addx 1\n"
"addx 24\n"
"addx -19\n"
"addx 1\n"
"addx 16\n"
"addx -11\n"
"noop\n"
"noop\n"
"addx 21\n"
"addx -15\n"
"noop\n"
"noop\n"
"addx -3\n"
"addx 9\n"
"addx 1\n"
"addx -3\n"
"addx 8\n"
"addx 1\n"
"addx 5\n"
"noop\n"
"noop\n"
"noop\n"
"noop\n"
"noop\n"
"addx -36\n"
"noop\n"
"addx 1\n"
"addx 7\n"
"noop\n"
"noop\n"
"noop\n"
"addx 2\n"
"addx 6\n"
"noop\n"
"noop\n"
"noop\n"
"noop\n"
"noop\n"
"addx 1\n"
"noop\n"
"noop\n"
"addx 7\n"
"addx 1\n"
"noop\n"
"addx -13\n"
"addx 13\n"
"addx 7\n"
"noop\n"
"addx 1\n"
"addx -33\n"
"noop\n"
"noop\n"
"noop\n"
"addx 2\n"
"noop\n"
"noop\n"
"noop\n"
"addx 8\n"
"noop\n"
"addx -1\n"
"addx 2\n"
"addx 1\n"
"noop\n"
"addx 17\n"
"addx -9\n"
"addx 1\n"
"addx 1\n"
"addx -3\n"
"addx 11\n"
"noop\n"
"noop\n"
"addx 1\n"
"noop\n"
"addx 1\n"
"noop\n"
"noop\n"
"addx -13\n"
"addx -19\n"
"addx 1\n"
"addx 3\n"
"addx 26\n"
"addx -30\n"
"addx 12\n"
"addx -1\n"
"addx 3\n"
"addx 1\n"
"noop\n"
"noop\n"
"noop\n"
"addx -9\n"
"addx 18\n"
"addx 1\n"
"addx 2\n"
"noop\n"
"noop\n"
"addx 9\n"
"noop\n"
"noop\n"
"noop\n"
"addx -1\n"
"addx 2\n"
"addx -37\n"
"addx 1\n"
"addx 3\n"
"noop\n"
"addx 15\n"
"addx -21\n"
"addx 22\n"
"addx -6\n"
"addx 1\n"
"noop\n"
"addx 2\n"
"addx 1\n"
"noop\n"
"addx -10\n"
"noop\n"
"noop\n"
"addx 20\n"
"addx 1\n"
"addx 2\n"
"addx 2\n"
"addx -6\n"
"addx -11\n"
"noop\n"
"noop\n"
"noop\n";

int x = 1;
unsigned int c = 1;
unsigned long sum = 0;
byte xpos = 1;
byte ypos = 0;

void tick(unsigned int c, int x) {
  if (xpos >= x && xpos < x + 3) {
    u8g2.drawBox(xpos * 2, ypos * 2, 2, 2);
  }
  xpos++;
  if (xpos > 40) {
    ypos++;
    xpos = 1;
  }

  if ((c+20) % 40 == 0) {
    sum += x * c;
  }

  u8g2.setDrawColor(0);
  u8g2.drawBox(0, 30, 84, 12);
  u8g2.setDrawColor(1);
  char buf[20];
  itoa(c, buf, 10);
  u8g2.drawStr(3, 40, buf);
  itoa(sum, buf, 10);
  u8g2.drawStr(30, 40, buf);
  itoa(x, buf, 10);
  u8g2.drawStr(70, 40, buf);
  u8g2.sendBuffer();  
}

void setup(void) {
  u8g2.begin();
  u8g2.setFont(u8g2_font_simple1_tf);
  Serial.begin(9600);
  String line, val;

  unsigned int pos = 0;
  char chr, buf[20], *str;
  str = input;

  while (chr = pgm_read_byte(str++)) {
    if (chr == '\n') {
      buf[pos] = '\0';
      pos = 0;
    } else {
      buf[pos++] = chr;
      continue;
    }

    line = String(buf);

    if (line.equals("noop")) {
      tick(c, x);
      c++;
    } else if (line.startsWith("addx")) {
      tick(c, x);
      c++;
      tick(c, x);
      c++;
      val = line.substring(5);
      x += val.toInt();
    }
  }
}

void loop(void) {
}
