/* 
 * File:   main.c
 * Author: Tim
 *
 * Created on September 11, 2015, 2:10 PM
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/*
 * 
 */
char ch; char java[4096]; char java2[4096]; char file_name[256]; char braces[128];
int i = 0; int sloc = 0; char charcount = 0; int arrayindex = 0;
FILE *fp;

int main(int argc, char** argv) {
    getFile();
    countLines(java);
    determineScope(java);
    return (EXIT_SUCCESS);
}


int getFile() {
    //getting the file
    printf("Enter the name of file, with extension\n");
    gets(file_name);
    fp = fopen(file_name, "r");
    if (fp == NULL) {
        perror("Error while opening the file.\n");
        exit(EXIT_FAILURE);
    }

    //save content of file
    while ((ch = fgetc(fp)) != EOF) {
        java[arrayindex] = ch;
        java2[arrayindex] = ch;
        arrayindex++;
    }
    printf("\n");
    fclose(fp);
    
}

int countLines(char * sourceCode){
    char *token; char *test;
    token = strtok(sourceCode, "\n");
    while (token != NULL){
        //count lines of comments (assumes all comments are significant, either for readability or clarification)
        if ((test = strstr(token,"/")) || (test = strstr(token,"*"))){
            sloc++;
        }
        //count lines of selection statements
        else if ((test = strstr(token,"if")) || (test = strstr(token,"else")) || (test = strstr(token,"try")) || (test = strstr(token,"catch")) || (test = strstr(token,"switch"))) {
            sloc++;
        } 
        //count lines of iteration statements
        else if ((test = strstr(token,"for")) || (test = strstr(token,"while")) || (test = strstr(token,"do"))){
            sloc++;
        }
        //count lines of jump statements
        else if((test = strstr(token,"return")) || (test = strstr(token,"break")) || (test = strstr(token,"continue")) || (test = strstr(token,"exit")) || (test = strstr(token,"throw"))){
            sloc++;
        } 
        //count remaining lines of expressions by counting ';' we exclude semi-colons within iteration statements
        else if(test = strstr(token, ";")){
            sloc++;
        }
        //finally count class declaration, function declarations, etc
        else if ((test = strstr(token,"public")) || (test = strstr(token,"private"))){
            sloc++;
        }
        printf("%s\n",token);
        token = strtok(NULL, "\n");
        
    }
    printf("Number of logical lines of code: %i \n\n", sloc);
    
}

int determineScope(char * sourceCode){
    int i = 0; int b = 0; int braceindex = 0; int currentScope = 0;
    while (java2[i]){
        if (java2[i] == '{' || java2[i] == '}'){
            braces[b] = java2[i];
            b++;
        }
        i++;
    }
    while (braces[braceindex]){
        if(braces[braceindex] == '{'){
            currentScope++;           
        }
        else if (braces[braceindex] == '}'){
            currentScope--;
        }
        printf("current scope is %i\n", currentScope);
        braceindex++;
    }
}

