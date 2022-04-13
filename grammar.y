
%{

#include <stdio.h>
#include<string.h>

extern int yylineno;
extern char* yytext;
extern char* tokenName;
extern int line_number;
int yylex();      // flex builds this for us
int success = 1;
int execute();
char** v;
int v_count = 0;
int fun_count = 0;
void yyerror(const char *msg);
%}
%defines

%union {
  char *sval;
}

%nonassoc <sval> TYPE IDENT SEMI FOR BREAK ELSE ERROR IF DO CONTINUE WHILE CONST RETURN INTCONST LBRACE RBRACE  
%token DIRECTIVE TK_DEFINE TK_UNDEF TK_IFDEF TK_IFNDEF TK_ELSE TK_ENDIF STRUCT CCOMMENT REALCONST STRCONST CHARCONST
%type <sval> cprog vdec typeName fdec fdef fparam funp ofparam varseq stmt stmtblock ostmtb stmtseq
%type <sval> key_else oexpr expr exprseq lvalue bnop unop asngop ovdec mident ident_type

%left <sval> COMMA 
%right <sval> ASSIGN PLUSASSIGN MINUSASSIGN STARASSIGN SLASHASSIGN
%right <sval> QUEST COLON
%left <sval> DPIPE
%left <sval> DAMP
%left <sval> PIPE
%left <sval> AMP
%left <sval> EQUALS NEQUAL
%left <sval> LT LE GE GT
%left <sval> PLUS MINUS
%left <sval> STAR SLASH MOD
%right <sval> BANG TILDE UMINUS DECR INCR
%left <sval> LPAR RPAR LBRACKET RBRACKET DOT


%%
//c-program subset
cprog : ovdec funp fdef            
      ;
//optional variable declaration 
ovdec	:     {/*do nothing*/}
      |     ovdec vdec
      ;
//variable declaration sequence
varseq	:	varseq	vdec
            |	vdec
            ;
//variable declaration
vdec : typeName mident SEMI                {printf("at vdec\n");}          
     ;
//multiple identifiers
mident : ident_type                 {printf("At ident type\n");}
       | mident COMMA ident_type    {printf("At ident type comma ident type %s\n",yytext);}
       ;
//type of identifier
ident_type  : IDENT                               {printf("at ident %s\n",$$);}         
            | IDENT LBRACKET INTCONST RBRACKET    {printf("at ident array%s\n",$$);}   
            ;
//type name
typeName : TYPE         {printf("at typeName '%s'\n",$1);}
         ;
//function prototype
funp	:	fdec	SEMI
      ;
//function definition
fdef  :	fdec	LBRACE varseq stmtseq RBRACE
      |     fdec	LBRACE stmtseq RBRACE
      |     fdec	LBRACE varseq RBRACE
      |     fdec	LBRACE RBRACE
      ;
//statements sequence
stmtseq	:	stmtseq	stmt
            |	stmt
            ;
//function declaration
fdec :	typeName IDENT LPAR ofparam RPAR
     ;

//optional multiple function parameters
ofparam :                           {/* do nothing */}
        | ofparam COMMA fparam
        | fparam
        ;
//function parameter
fparam :	typeName	IDENT	
       |	typeName	IDENT	LBRACKET RBRACKET
       ;
//statement
stmt	:	expr SEMI
      |	BREAK SEMI
      |	CONTINUE SEMI
      |	RETURN SEMI
      |     RETURN expr SEMI
      |	IF LPAR expr RPAR ostmtb key_else
      |	FOR LPAR oexpr SEMI oexpr SEMI oexpr RPAR ostmtb 
      |	WHILE LPAR expr RPAR ostmtb 
      |	DO ostmtb WHILE LPAR expr RPAR SEMI
      ;
//optional expression
oexpr	:	  {/* do nothing */}
      |	expr
      ;
//optional statement block/statement
ostmtb	:     stmtblock 
            |     stmt SEMI
            ;
//optional else statement
key_else    :           {/* do nothing */}
            |     ELSE ostmtb
            ;
//statement block
stmtblock	:	LBRACE  stmtseq	RBRACE
            |     LBRACE RBRACE
            ;
//expression
expr	:	CONST
      |	IDENT LPAR exprseq RPAR
      |	lvalue
      |	lvalue asngop expr
      |	lvalue INCR
      |	INCR lvalue
      |	lvalue DECR
      |	DECR lvalue 
      |	unop expr
      |	expr bnop expr
      |	expr QUEST expr COLON expr
      |	LPAR typeName RPAR expr
      |	LPAR expr RPAR
      ;
//expression sequence
exprseq	:     {/* do nothing */}
            |     exprseq COMMA expr
            |     expr
            ;
//l-value
lvalue      :	IDENT 
            |	IDENT LBRACKET expr RBRACKET
            ;
//binary operator
bnop	:	EQUALS
      |	NEQUAL
      |	GT
      |	GE
      |	LT
      |	LE
      |	PLUS
      |	MINUS
      |	STAR
      |	SLASH
      |	MOD
      |	PIPE
      |	AMP
      |	DPIPE
      |	DAMP
      ;
//unary operator
unop	:     MINUS %prec UMINUS
      |	BANG
      |	TILDE
      ;
//assignment operator
asngop	:	ASSIGN
            |	PLUSASSIGN
            |	MINUSASSIGN
            |	STARASSIGN
            |	SLASHASSIGN
            ;
%%
int execute()
{
    v = (char**)malloc(sizeof(char*)*100);
    int token = yyparse();
      if(token == 0){
            return 0;
            exit(1);
      }
    if( v_count!=0){
    printf("Global variables :\n");
    for (int i = 0; i < v_count; i++){
    	printf("%s ", v[i]);
	if(i+1<v_count)
		printf(",");
	}
	}
      
      if(success)
    	printf("\n--------------end of file-----------------\n");
      return 0;
}
void yyerror(const char *msg)
      {
	fprintf(stderr,"Error at '%s' in line %d \nwith error message '%s'\n",yytext,yylineno,msg);
	success = 0;
	
      }

