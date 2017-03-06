#include <iostream>
#include <fstream>

using namespace std;

//A bitmap file is laid out like:
//BMPFileHeader
//BMPInfoHeader
//Pixel array

struct BMPFileHeader {
	unsigned short type;
	unsigned int size;
	unsigned short reserved1, reserved2;
	unsigned int offset;
} __attribute__((packed));

struct BMPInfoHeader {
	unsigned int size;
	int width;
	int height;
	unsigned short planes;
	unsigned short bitcount;
	unsigned int compression;
	unsigned int imagesize;
	int x_pixels_per_meter;
	int y_pixels_per_meter;
	unsigned int color_used;
	unsigned int color_important;
} __attribute__((packed));


struct Pixel {
	unsigned char blue;
	unsigned char green;
	unsigned char red;
} __attribute__((packed));


void invertImage(Pixel *p, int size);
void flipImage(Pixel *p, int height, int width);

int main(int argc, char *argv[])
{
	if (argc < 3) {
		cout << "Usage: " << argv[0] << " <bmp file> <output bmp file>" << endl;
		return -1;
	}
  BMPFileHeader fileHeader;
  BMPInfoHeader infoHeader;
  Pixel *p;

  ifstream input(argv[1], ios::binary);
  input.read(reinterpret_cast<char*>(&fileHeader), sizeof(fileHeader));
  input.read(reinterpret_cast<char*>(&infoHeader), sizeof(infoHeader));
  int numPixels = infoHeader.width * infoHeader.height;
  p = new Pixel[numPixels];
  input.read(reinterpret_cast<char*>(p), sizeof(Pixel) * numPixels);
  input.close();

  invertImage(p, numPixels);
  flipImage(p, infoHeader.height, infoHeader.width);

  ofstream output(argv[2], ios::binary);
  output.write(reinterpret_cast<char*>(&fileHeader), sizeof(fileHeader));
  output.write(reinterpret_cast<char*>(&infoHeader), sizeof(infoHeader));
  output.write(reinterpret_cast<char*>(p), sizeof(Pixel) * numPixels);
  output.close();


  delete [] p;
	return 0;
}

void invertImage(Pixel *p, int size){
  for(int i = 0; i < size; i++){
    p[i].blue = 255 - p[i].blue;
    p[i].green = 255 - p[i].green;
    p[i].red = 255 - p[i].red;
  }
}

void flipImage(Pixel *p, int height, int width){
  Pixel temp;
  int index;
  for(int i = 0; i < height; i++)
    for(int j = 0; j < width/2; j++){
      index = i*width;
      temp = p[index+j];
      p[index+j] = p[index+width-j-1];

      p[index+width-j-1] = temp;
    }
}
