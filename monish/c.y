
%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);

extern int yylineno;
%}

%token INT MAIN RETURN PRINTF SCANF
%token ID NUMBER STRING_LITERAL INVALID

%left '+' '-'
%left '*' '/'

%%

program:
    INT MAIN '(' ')' block
    {
        printf("Valid C syntax\n");
    }
    ;

block:
    '{' statements '}'
    ;

statements:
      /* empty */
    | statements statement
    ;

statement:
      declaration ';'
    | assignment ';'
    | PRINTF '(' arguments ')' ';'
    | SCANF '(' arguments ')' ';'
    | RETURN expression ';'
    ;

declaration:
      INT ID
    | INT ID '=' expression
    ;

assignment:
    ID '=' expression
    ;

arguments:
      argument
    | arguments ',' argument
    ;

argument:
      expression
    | STRING_LITERAL
    | '&' ID
    ;

expression:
      expression '+' expression
    | expression '-' expression
    | expression '*' expression
    | expression '/' expression
    | '(' expression ')'
    | ID
    | NUMBER
    ;

%%

void yyerror(const char *s)
{
    fprintf(stderr, "Syntax error at line %d: %s\n",
            yylineno, s);
}

int main(void)
{
    printf("Enter C source code (Ctrl+D to finish):\n\n");

    if (yyparse() != 0)
        return 1;

    return 0;
}
