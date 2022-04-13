#include <iostream>
using namespace std; 
extern FILE *yyin;

int tokenizer(char* fileName){
    try{
    yyin = fopen(fileName, "r");
    if(!yyin){
        cerr << "ERROR: file with name "<< fileName << " not found" << endl;
        return 0;
    }
    yylineno = 1;
    //|| token == TK_ELSE || token == TK_ENDIF
    int token = yylex();
    while (token!=0)
    {  
        if(token == DIRECTIVE || token == TK_DEFINE || token == TK_UNDEF || token == TK_IFDEF || token == TK_IFNDEF ||token == TK_ELSE || token == TK_ENDIF){
            cerr << "WARNING: ignoring "<< yytext <<" in "<< fileName << " at line " << yylineno << endl;
        }
        else if(token == CCOMMENT){
            cerr << "ERROR: Unclosed comment in "<< fileName << " at line " << line_number << endl;
            exit(1);
        }
        else if(token!=ERROR){
            cout << fileName << " line " << yylineno << " text '" << yytext << "' token " << tokenName << endl;
        }
        else{
        cerr << "ERROR: Unexpected token or character: "<< tokenName << " at line " << yylineno << endl;
        }
        token = yylex();
    }
    cout << "--------------end of file-----------------" << endl;
    }
    catch(exception& e){
        cerr << "An exception occured :" << e.what() << endl;
    }
    fclose(yyin);
    return 0;
}
