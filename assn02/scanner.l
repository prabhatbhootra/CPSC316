/*
 * scanner.l - a lexical analyzer for P-
 *
 * Prabhat Bhootra
 *
 * Date: 09/29/19
 * Modification History:
 *
 */

%{

/* Include files and global variables go here */

#include <stdio.h>
#include "msg.h"
#define MAX_STR_CONST 500
int cLine = 1;
extern int cErrors;
extern char *infile;

%}

%x comment

DIGIT 	[0-9]
WS	[ \r\t]*
IDENT   [A-Za-z_][A-Za-z0-9_]*
STRING  "\"".*[^\\]"\""

%%

"/*"	        BEGIN(comment);
<comment>[^*\n]*	/* eat anything that's not a '*' */
<comment>\n		cLine++;
<comment>"*/"	BEGIN(INITIAL);

{STRING}	{
		fprintf(stderr, message[mnLegalString], infile, cLine, yytext);
		}

"&&"|"||"|">="|"<="|"=="|"!="|".."	{
		fprintf(stderr, message[mnCompoundOperator], infile, cLine, yytext);
		}

"&"|"="|"!"|":"|","|"."|">"|"<"|"["|"]"|"("|")"|"+"|"-"|"*"|";"|"/"	{
		fprintf(stderr, message[mnSimpleOperator], infile, cLine, yytext);
		}

{WS}		{/* Skip whitespace */}

                /* Local variables go here */

"\n"            cLine++;

array|ARRAY    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

begin|BEGIN    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

bool|BOOL      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

else|ELSE      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

elif|ELIF      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

end|END        {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

false|FALSE    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

for|FOR        {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

float|FLOAT    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

function|FUNCTION    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

if|IF          {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

in|IN          {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

int|INT        {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

of|OF          {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

procedure|PROCEDURE    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

program|PROGRAM    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

read|READ      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

record|RECORD  {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

return|RETURN  {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

then|THEN      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

true|TRUE      {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

while|WHILE    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

write|WRITE    {
                fprintf(stderr, message[mnKeywordFound], infile, cLine, yytext);
               }

{IDENT}		{
		fprintf(stderr, message[mnLegalIdentifier], infile, cLine, yytext); 
		}

{DIGIT}+	{
		fprintf(stderr, message[mnLegalInteger], infile, cLine, yytext);
		}

{DIGIT}*"."{DIGIT}+	{
		fprintf(stderr, message[mnLegalFloat], infile, cLine, yytext);
		}

  .            {
                fprintf(stderr, message[mnUnknownChar], infile, cLine, yytext[0]);
                cErrors++;
               }

%%

/* User routines go here */
