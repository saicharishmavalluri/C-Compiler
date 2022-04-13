#include <iostream>
#include <fstream>
#include <cstring>
#include "part2.tab.h"
#include "part2.tab.c"
#include "part1.cpp"
#include "part2.cpp"
using namespace std; 
ofstream mywritefile;

void output_stdout(string message,bool isOuttxt,bool iserror){
    if(isOuttxt){
        mywritefile << message; 
    }else{
        if(iserror){
            cerr << message;  
        }
        else{
            cout << message;
        }
    }
}

void usage_err(bool isOuttxt){
    output_stdout("\n",isOuttxt,true);
        output_stdout("Usage:\n",isOuttxt,true);
        output_stdout("mycc -mode [options] infile\n\n",isOuttxt,true);
        output_stdout("Valid Modes:\n",isOuttxt,true);
        output_stdout("-0: Version information\n",isOuttxt,true);
        output_stdout("-1: Part 1 (not implemented yet)\n",isOuttxt,true);
        output_stdout("-2: Part 2 (not implemented yet)\n",isOuttxt,true);
        output_stdout("-3: Part 3 (not implemented yet)\n",isOuttxt,true);
        output_stdout("-4: Part 4 (not implemented yet)\n",isOuttxt,true);
        output_stdout("-5: Part 5 (not implemented yet)\n\n",isOuttxt,true);
        output_stdout("Valid options:\n",isOuttxt,true);
        output_stdout("-o outfile: write to outfile instead of standard output\n\n",isOuttxt,true);
}


//main function
int main(int argc, char *argv[]) 
{ 
    //to check if output file is given
    bool isOuttxt;
    if(argc>=4 && strcmp("-o",argv[2])==0){
            isOuttxt = true;
            mywritefile.open(argv[3]);
        }
    // Usage message
    if(argc<=1){
        usage_err(isOuttxt);
    }
    else{
        //when no input file is provided for 1,2,3,4,5 parts
        if(argc ==2 && strcmp(argv[1], "-0") != 0){
            output_stdout("ERROR:Entered command is not supported!\n",isOuttxt,true);
            usage_err(isOuttxt);
            exit(1);
        }
        // version information
        if(strcmp(argv[1], "-0") == 0){
            output_stdout("\n",isOuttxt,false);
            output_stdout("NOTE: The input file is ignored on mode 0\n",isOuttxt,true); 
            output_stdout("My bare-bones C compiler (for COM 440/540)\n",isOuttxt,false); 
            output_stdout("written by Sai Charishma Valluri(svalluri@iastate.edu)\n",isOuttxt,false);
            output_stdout("version 0.1\n",isOuttxt,false);
            output_stdout("2 February, 2021\n",isOuttxt,false);  
            output_stdout("\n",isOuttxt,false);  
        }
        else if(strcmp(argv[1], "-1") == 0 && strcmp("-o",argv[2])!=0){
            output_stdout("\n",isOuttxt,false);
            tokenizer(argv[2]);
            output_stdout("\n",isOuttxt,false);
        }
        else if(strcmp(argv[1], "-2") == 0 && strcmp("-o",argv[2])!=0){
            output_stdout("\n",isOuttxt,false);
            syntax_check(argv[2]);
            output_stdout("\n",isOuttxt,false);
        }
        else if(strcmp(argv[1], "-3") == 0 && strcmp("-o",argv[2])!=0){
            output_stdout("\n",isOuttxt,false);
            //tokenizer(argv[2]);
            output_stdout("\n",isOuttxt,false);
        }
        else if(strcmp(argv[1], "-4") == 0 && strcmp("-o",argv[2])!=0){
            output_stdout("\n",isOuttxt,false);
            //tokenizer(argv[2]);
            output_stdout("\n",isOuttxt,false);
        }
        else if(strcmp(argv[1], "-5") == 0 && strcmp("-o",argv[2])!=0){
            output_stdout("\n",isOuttxt,false);
            //tokenizer(argv[2]);
            output_stdout("\n",isOuttxt,false);
        }
        else{
            usage_err(isOuttxt);
        }
    }
    mywritefile.close();
    return 0; 

} 

