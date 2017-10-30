/**
 * Creates a drawable window.
 *
 * @author Ira Woodring
 */

#ifndef            __SMART_TURTLE__
#define            __SMART_TURTLE__

#include <SDL2/SDL.h>

#define            HEIGHT    768
#define            WIDTH    1024

/// Red value, green value, and blue value to generate color.
struct color{
    int r;
    int g;
    int b;
};

SDL_Texture* texture;
SDL_Renderer* renderer;
SDL_Window* window;

/// Set up graphics window at size 1024x768 for drawing.
void setup();
/// Sets the color of current drawn image to the RGB values given.
void set_color( int r, int g, int b);
/// Draws a point at the x and y value.
void point( int x, int y );
/// Draws a line at the x and y start value and ends it at the x and y end value.
void line( int x1, int y1, int x2, int y2 );
/// Draws a circle at the x and y value with a radius set by the pixels given.
void circle( int x, int y, int r);
/// Draws a rectangle at the x and y value with a width and height set by the pixels given.
void rectangle( int x, int y, int w, int h);
/// Safely closes the graphics screen.
void finish();
 
#endif
