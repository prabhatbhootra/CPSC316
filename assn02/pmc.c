/*
 * pmc.c -- main driver for P- compiler
 *
 * <Your name here>
 *
 * Date:
 * Modification History:
 *
 */

#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
int cErrors;
char *infile;

int main(int argc, char *argv[])
{
    int yylex();

    if (argc != 2) {
        fprintf(stderr, "Usage: pmc filename\n");
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL) {
        fprintf(stderr, "%s: cannot open\n", argv[1]);
        exit(1);
    }
    infile = argv[1];
    cErrors = 0;
    yylex();
    if (cErrors == 0) 
        fprintf(stderr, "\nno errors\n");
    else
        fprintf(stderr, "\n%d error(s)\n", cErrors);
    exit(0);
}
