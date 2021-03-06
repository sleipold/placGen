/*
	Scanner fuer PLA
	J. Uhrmann, 12.11.2005
	M.Messerer , 2017
*/

/*	---- Definitionen ---- 		*/

%{
	/* Definitionen in C */

	#include "pla.tab.h"	/* Token-Konstanten des Parsers verwenden */
	#include <math.h>	/* fuer atoi */
	#include <stdio.h>
	#include <string.h>	/* fuer strcpy */
%}


/* Zeilennummern sollen ermittelt und in yylineno gespeichert werden */
%option yylineno

/* Definitionen fuer flex */
DIGIT	[0-9]
ID 	[a-zA-Z][a-zA-Z0-9]*

/*	---- Scanner-Regeln ----	*/
%%	

"const"		return CONST;
"var"		return VAR;
"procedure"	return PROCEDURE;
"call"		return CALL;
"begin"		return _BEGIN;
"end"		return END;   	
"if" 		return IF; 
"then"		return THEN; 
"else"		return ELSE;
"while"		return WHILE; 		
"do"		return DO;
"="		return EQ;
"!="		return NE;
"<"		return LT;
"<="		return LE;
">"		return GT;
">="		return GE;
":="		return ASS;
","		return KOMMA;
";"		return SEMICOLON;
"+"		return PLUS;
"-"		return MINUS;
"*"		return MULT;
"/"		return DIV;
"("		return KLAUF;
")"		return KLZU;
"."		return PUNKT;
":"		return COLON; 
"int"		return INT;
"real"		return REAL; 
"boolean"	return BOOL; 
"true"		return WAHR;
"false"		return FALSCH;
"$"		return PROGEND;
"fi"		return FI;

{DIGIT}+	{	
				    yylval.num = atoi(yytext);
		 		    return (INTNUMBER);
          	}

{DIGIT}+"."{DIGIT}+	{
						yylval.realnum = atof(yytext);
						return (REALNUMBER);
			  		}

{ID}	{
				strcpy(yylval.idname, yytext);
				return IDENT;
		}

[ \t\n\r]		/* Whitespaces ignorieren */


.		{	/* alle anderen Zeichen sind Fehler */
			fprintf(stderr, "Zeile %d: ungueltiges Zeichen erkannt: %s\n", yylineno, yytext);
			exit(1);
		}
%%
/*	Ende  ---- */
