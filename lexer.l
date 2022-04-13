
%{

#include "part2.tab.h"

char* tokenName;
int line_number;

%}

%option noyywrap
%option yylineno
%x COMMENT
%x CPPCOMMENT
%x INCLUDE_STATE
%x DEFINE_STATE
%x UNDEF_STATE
%x IFDEF_STATE
%x IFNDEF_STATE
%x ELSE_STATE
%x ENDIF_STATE
%%

"/*"                            { line_number = yylineno; BEGIN(COMMENT); }
<COMMENT>"*/"                   { BEGIN(INITIAL); }
<COMMENT>.|\n                   {/* ignore */}
<COMMENT><<EOF>>                { return CCOMMENT;}

"//"                            { BEGIN(CPPCOMMENT); }
<CPPCOMMENT>\n                  { BEGIN(INITIAL); }
<CPPCOMMENT>[^\n]*              {/* ignore */}

"#include"                      {BEGIN(INCLUDE_STATE); return DIRECTIVE;}
<INCLUDE_STATE>\n               {BEGIN(INITIAL);}
<INCLUDE_STATE>[^\n]*           {/* ignore */}

"#define"                       {BEGIN(DEFINE_STATE); return TK_DEFINE;}
<DEFINE_STATE>\n                {BEGIN(INITIAL);}
<DEFINE_STATE>.*                {/* ignore */}

"#undef"                        {BEGIN(UNDEF_STATE); return TK_UNDEF;}
<UNDEF_STATE>\n                 {BEGIN(INITIAL);}
<UNDEF_STATE>[^\n]*             {/* ignore */}

"#ifdef"                        {BEGIN(IFDEF_STATE); return TK_IFDEF;}
<IFDEF_STATE>"#endif"           {BEGIN(INITIAL);}
<IFDEF_STATE>\n                 {/* ignore */}
<IFDEF_STATE>.*                 {/* ignore */}

"#ifndef"                       {BEGIN(IFNDEF_STATE); return TK_IFNDEF;}
<IFNDEF_STATE>"#endif"          {BEGIN(INITIAL);}
<IFNDEF_STATE>\n                 {/* ignore */}
<IFNDEF_STATE>.*                {/* ignore */}

"#else"                         {BEGIN(ELSE_STATE); return TK_ELSE;}
<ELSE_STATE>"#endif"            {BEGIN(INITIAL);}
<ELSE_STATE>\n                 {/* ignore */}
<ELSE_STATE>.*                  {yylineno++;}

"#endif"                        {BEGIN(ENDIF_STATE); return TK_ENDIF;}
<ENDIF_STATE>\n                 {BEGIN(INITIAL);}
<ENDIF_STATE>.*                 {yylineno++;}

"void"                  {tokenName = (char*) "TYPE";return TYPE;}
"char"                  {tokenName = (char*) "TYPE";return TYPE;}
"int"                   {tokenName = (char*) "TYPE";return TYPE;}
"float"                 {tokenName = (char*) "TYPE";return TYPE;}
"const"                 {tokenName = (char*) "CONST";return CONST;}
"struct"                {tokenName = (char*) "STRUCT";return STRUCT;}
"for"                   {tokenName = (char*) "FOR";return FOR;}
"while"                 {tokenName = (char*) "WHILE";return WHILE;}
"do"                    {tokenName = (char*) "DO";return DO;}
"if"                    {tokenName = (char*) "IF";return IF;}
"else"                  {tokenName = (char*) "ELSE";return ELSE;}
"break"                 {tokenName = (char*) "BREAK";return BREAK;}
"continue"              {tokenName = (char*) "CONTINUE";return CONTINUE;}
"return"                {tokenName = (char*) "RETURN";return RETURN;}

[a-zA-Z_][a-zA-Z_0-9]*                  {tokenName = (char*) "IDENT";return IDENT;}
[0-9]+                                  {tokenName = (char*) "INTCONST";return INTCONST;}
[+-]?[0-9]*[.][0-9]+([eE][+-]?[0-9]+)?  {tokenName = (char*) "REALCONST";return REALCONST;}
["](.*)["]                              {tokenName = (char*) "STRCONST";return STRCONST;}
['](.*)[']                              {tokenName = (char*) "CHARCONST";return CHARCONST;}

"("                     {tokenName = (char*) "LPAR";return LPAR;}
")"                     {tokenName = (char*) "RPAR";return RPAR;}
"["                     {tokenName = (char*) "LBRACKET";return LBRACKET;}
"]"                     {tokenName = (char*) "RBRACKET";return RBRACKET;}
"{"                     {tokenName = (char*) "LBRACE";return LBRACE;}
"}"                     {tokenName = (char*) "RBRACE";return RBRACE;}
"."                     {tokenName = (char*) "DOT";return DOT;}
","                     {tokenName = (char*) "COMMA";return COMMA;}
";"                     {tokenName = (char*) "SEMI";return SEMI;}
"?"                     {tokenName = (char*) "QUEST";return QUEST;}
":"                     {tokenName = (char*) "COLON";return COLON;}

"+="                    {tokenName = (char*) "PLUSASSIGN";return PLUSASSIGN;}  
"-="                    {tokenName = (char*) "MINUSASSIGN";return MINUSASSIGN;}
"*="                    {tokenName = (char*) "STARASSIGN";return STARASSIGN;}
"/="                    {tokenName = (char*) "SLASHASSIGN";return SLASHASSIGN;}
"++"                    {tokenName = (char*) "INCR";return INCR;}
"--"                    {tokenName = (char*) "DECR";return DECR;}
"=="                    {tokenName = (char*) "EQUALS";return EQUALS;}
"!="                    {tokenName = (char*) "NEQUAL";return NEQUAL;}
">="                    {tokenName = (char*) "GE";return GE;}
"<="                    {tokenName = (char*) "LE";return LE;}

"="                     {tokenName = (char*) "ASSIGN";return ASSIGN;}
">"                     {tokenName = (char*) "GT";return GT;}
"<"                     {tokenName = (char*) "LT";return LT;}     
"+"                     {tokenName = (char*) "PLUS";return PLUS;}
"-"                     {tokenName = (char*) "MINUS";return MINUS;}
"*"                     {tokenName = (char*) "STAR";return STAR;}
"/"                     {tokenName = (char*) "SLASH";return SLASH;}
"%"                     {tokenName = (char*) "MOD";return MOD;}
"~"                     {tokenName = (char*) "TILDE";return TILDE;}

"||"                    {tokenName = (char*) "DPIPE";return DPIPE;}   
"&&"                    {tokenName = (char*) "DAMP";return DAMP;}
"&"                     {tokenName = (char*) "AMP";return AMP;}
"!"                     {tokenName = (char*) "BANG";return BANG;}                     
"|"                     {tokenName = (char*) "PIPE";return PIPE;}
[ \t\r\n]*              {/* do nothing */  } 
.                {printf("Bad character: %s\n",yytext); return ERROR;}
<<EOF>>          { return 0;}
%%



