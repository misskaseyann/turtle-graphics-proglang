%{
	#include <stdio.h>
%}

%option noyywrap

%%

end			printf("END ");
;			printf("END_STATEMENT ");
point			printf("POINT ");
line			printf("LINE ");
circle			printf("CIRCLE ");
rectangle		printf("RECTANGLE ");
set_color		printf("SET_COLOR ");
[0-9]+			printf("INT ");
[0-9]+\.[0-9]+		printf("FLOAT ");
[ \t]+			/* ignore whitespace */;
\n			/* ignore end of line */;
.			printf("MISTAKE ");

%%

int main(int argc, char** argv) {
	yylex();
	return 0;
}
