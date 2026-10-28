
%option noyywrap yylineno

%{
#include <stdio.h>
#include "y.tab.h"
%}

ID      [a-zA-Z_][a-zA-Z0-9_]*
NUMBER  [0-9]+
STRING  \"([^\\\"]|\\.)*\"

%%

"int"           { return INT; }
"main"          { return MAIN; }
"return"        { return RETURN; }
"cout"          { return COUT; }
"cin"           { return CIN; }

"<<"            { return INSERT; }
">>"            { return EXTRACT; }

"//"[^\n]*      ;
"/*"([^*]|\*+[^*/])*\*+"/" ;

[ \t\r\n]+      ;

{STRING}        { return STRING_LITERAL; }
{ID}            { return ID; }
{NUMBER}        { return NUMBER; }

"+"             { return '+'; }
"-"             { return '-'; }
"*"             { return '*'; }
"/"             { return '/'; }
"="             { return '='; }

"("             { return '('; }
")"             { return ')'; }
"{"             { return '{'; }
"}"             { return '}'; }
";"             { return ';'; }

. {
    fprintf(stderr, "Lexical error at line %d: %s\n",
            yylineno, yytext);
    return INVALID;
}

%%
