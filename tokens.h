
enum yytokentype {
  //KEYWORDS
  TYPE = 260,
  CONST = 261,
  STRUCT = 262,
  FOR = 263,
  WHILE = 264,
  DO = 265,
  IF = 266,
  ELSE = 267,
  BREAK = 268,
  CONTINUE = 269,
  RETURN = 270,
  //IDENTIFIER
  IDENT = 271,
  //CONSTANTS
  INTCONST = 272,
  REALCONST = 273,
  STRCONST = 274,
  CHARCONST = 275,
  //SYMBOLS
  LPAR = 276,
  RPAR = 277,
  LBRACKET = 278,
  RBRACKET = 279,
  LBRACE = 280,
  RBRACE = 281,
  DOT = 282,
  COMMA = 283,
  SEMI = 284,
  QUEST = 285,
  COLON = 286,
  PIPE = 287,
  AMP = 288,
  BANG = 289,
  DPIPE = 290,
  DAMP = 291,
  MOD = 292,
  TILDE = 293,
  //MATHEMETICAL SYMBOLS
  PLUS = 294,
  MINUS = 295,
  STAR = 296,
  SLASH = 297,
  ASSIGN = 298,
  PLUSASSIGN = 299,
  MINUSASSIGN = 300,
  STARASSIGN = 301,
  SLASHASSIGN = 302,
  INCR = 303,
  DECR = 304,
  EQUALS = 305,
  NEQUAL = 306,
  GT = 307,
  GE = 308,
  LT = 309,
  LE = 310,
  DIRECTIVE = 311,
  TK_DEFINE = 312,
  TK_UNDEF = 313,
  TK_IFDEF = 314,
  TK_IFNDEF = 315,
  TK_ELSE = 316,
  TK_ENDIF = 317,
  ERROR = 333,
  CCOMMENT = 334
};

extern int yylval;  // token attribute
extern char* yytext;  // generated by lex/flex
extern int yylineno;
extern char* tokenName;
extern int line_number;

int yylex();    /* will be generated by lex/flex */

