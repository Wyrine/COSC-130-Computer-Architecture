////////////////////////////////////////
// COSC 130, Lab 2 Template File
// Modify the functions below
//
////////////////////////////////////////

String decimal_to_bin(int input)
{
  String output;

  for(int i = 31; i >= 0; i--)
    output += (input & (1 << i)) ? '1' : '0';

  return output;
}

String decimal_to_hex(int input)
{
  String output;
  int v;
  char charOutput;
  for(int i = 7; i >= 0; i--){
    v = ((input >> (4*i)) & 0b1111);
    charOutput = (v>=10) ?  (v - 10) + 'a':  v + '0';
    output += charOutput;
  }
  return output;
}

String decimal_to_oct(int input)
{
  String output;
  int v = (input >> 30) & 0b111;
  output += v;
  for(int i = 10; i >= 0; i--){
    v = (input >> (3*i)) & 0b111;
    output += v;
  }
  return output;
}

////////////////////////////////////////
//
// DO NOT MODIFY ANY FUNCTIONS BELOW
//
////////////////////////////////////////
void setup() {
  // put your setup code here, to run once:
  Serial.begin(115200);
}

void loop() {
  // put your main code here, to run repeatedly:
  if (Serial && (Serial.available() > 0)) {
    String input = Serial.readString();
    int i_input = input.toInt();

    Serial.println("Dec: " + input);
    Serial.println("Bin: " + decimal_to_bin(i_input));
    Serial.println("Oct: " + decimal_to_oct(i_input));
    Serial.println("Hex: " + decimal_to_hex(i_input));
    Serial.print("\n");

  }
  else {
    delay(115);
  }
}
