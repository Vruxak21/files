
%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);

extern int yylineno;
%}

%token INT MAIN RETURN COUT CIN
%token INSERT EXTRACT
%token ID NUMBER STRING_LITERAL INVALID

%left '+' '-'
%left '*' '/'

%%

program:
    INT MAIN '(' ')' block
    {
        printf("Valid C++ syntax\n");
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
    | COUT output_list ';'
    | CIN input_list ';'
    | RETURN expression ';'
    ;

declaration:
      INT ID
    | INT ID '=' expression
    ;

assignment:
    ID '=' expression
    ;

output_list:
      INSERT output_value
    | output_list INSERT output_value
    ;

output_value:
      expression
    | STRING_LITERAL
    ;

input_list:
      EXTRACT ID
    | input_list EXTRACT ID
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
    printf("Enter C++ source code (Ctrl+D to finish):\n\n");

    if (yyparse() != 0)
        return 1;

    return 0;
}
