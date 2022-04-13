#include <iostream>
using namespace std; 
extern FILE *yyin;

int syntax_check(char* fileName){
    extern FILE* yyin;
    try{
    yyin = fopen(fileName, "r");
    if(!yyin){
        cerr << "ERROR: file with name "<< fileName << " not found" << endl;
        return 0;
    }
    else{
        execute();
    }
    //cout << "--------------end of file-----------------" << endl;
    }
    catch(exception& e){
        cerr << "An exception occured :" << e.what() << endl;
    }
    fclose(yyin);
    return 0;
}
