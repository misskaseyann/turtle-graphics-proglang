%{
#include <stdio.h>
#include "zoomjoystrong.h"

/* Token/value pairs for yyparse() to read. */
int yylex();

/**
 * Handles error reporting by closing the program and printing out the error.
 *
 * @param str pointer to characters for a string.
 */
void yyerror(const char *str) {
	printf("error: %s\n", str);
}

/**
 * Called when input is exhausted.
 * 
 * @return 1 to state we are done.
 */
int yywrap() {
	return 1;
}

%}

%union {
	int iVal;
	float fVal;
}

%token <iVal> INT
%token <fVal> FLOAT
%token END
%token END_STATEMENT
%token POINT
%token LINE
%token CIRCLE
%token RECTANGLE
%token SET_COLOR

%%

program:
	statement_list end
	;

statement_list:
	statement
	| statement statement_list
	;

statement:
	point
	| line
	| circle
	| rectangle
	| set_color
	;

point:
	POINT INT INT END_STATEMENT
	{
		// Check if our point is within the bounds of the screen.
		if ($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0) {
			// If the point is outside the drawable area, tell the user.
			printf("Out of bounds.");
		} else {
			// Draw the point on our screen in x,y coordinates.
			point($2, $3); 
		}
	}
	;

line:
	LINE INT INT INT INT END_STATEMENT
	{
		// Check if our line is within the bounds of the screen.
		if ($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 < 0 || $5 < 0) {
			// If the line is outside the drawable area, tell the user.
			printf("Out of bounds.");
		} else {
			// Draw the line on our screen in x,y coordinates.
			line($2, $3, $4, $5);
		}
	}
	;

circle:
	CIRCLE INT INT INT END_STATEMENT
	{
		// Check if our circle is within the bounds of the screen.
		if ($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 < 1) {
			// If the circle is outside the drawable area, tell the user.
			printf("Out of bounds.");
		} else {
			// Draw the circle on our screen in x,y coordinates.
			circle($2, $3, $4);
		}
	}
	;

rectangle:
	RECTANGLE INT INT INT INT END_STATEMENT
	{
		// Check if our rectangle is within the bounds of the screen.
		if ($2 > 1024 || $2 < 0 || $3 > 768 || $3 < 0 || $4 < 1 || $5 < 1) {
			// If the rectangle is outside the drawable area, tell the user.
                        printf("Out of bounds.");
                } else {
			// Draw the rectangle on our screen in x,y coordinates.
			rectangle($2, $3, $4, $5);
		}
	}
	;

set_color:
	SET_COLOR INT INT INT END_STATEMENT
	{
		// Check if our color is a valid RGB value.
		if ($2 > 255 || $2 < 0 || $3 > 255 || $3 < 0 || $4 > 255 || $4 < 0) {
			// If it is not a valid RGB value, then tell the user.
			printf("Not a valid rgb set of values.");
		} else {
			// Set the color of the last drawable image.
			set_color($2, $3, $4);
		}
	}
	;

end:
	END END_STATEMENT
	{
		// Close our renderable screen and finish the program.
		finish();
		return 0;
	}
	;

%%

/* Input stream from reading a file. */
extern FILE *yyin;

/**
 * Main function for our program.
 *
 * @param argc value of command line arguments.
 * @param argv pointer to a pointer of a string of characters that are our arguments.
 */
int main(int argc, char** argv) {
	// Set up our rendering screen in SDL2.
	setup();
	// Check if there is a readable file and set it to the input stream.
	yyin = fopen(argv[1], "r");
	// Parse whats on our screen.
	yyparse();
}	
