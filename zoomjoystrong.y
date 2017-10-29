%{
	#include <stdio.h>
	#include "zoomjoystrong.h"

void yyerror(const char *str) {
	printf(stderr, "error: %s\n", str);
}

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
	statement_list END END_STATEMENT
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
		point($2, $3); 
	}
	;

line:
	LINE INT INT INT INT END_STATEMENT
	{
		line($2, $3, $4, $5);
	}
	;

circle:
	CIRCLE INT INT INT END_STATEMENT
	{
		circle($2, $3, $4);
	}
	;

rectangle:
	RECTANGLE INT INT INT INT END_STATEMENT
	{
		rectangle($2, $3, $4, $5);
	}
	;

set_color:
	SET_COLOR INT INT INT END_STATEMENT
	{
		set_color($2, $3, $4);
	}
	;

%%

extern FILE *yyin;

int main(int argc, char** argv) {
	setup();
	yyin = fopen(argv[1], "r");
	yyparse();
}	
