#include <iostream>
#include <string>
#include <fstream>
#include <vector>

/*
Tokenizer Class

Takes string block and parses it character by character.
Outputs token number when token is found.

*/
class Tokenizer{
public:
  std::string block;
  int currentIndex;
  char currentChar;
  
  void nextChar(); //Moves the finite automata to the next character in the string
  int analyzeChar(); //Analyzes the current character and outputs proper number to output stream 
  
};

int main(int argc, char* argv[]){
  
  //Making sure there is only one command line argument
  if(argc < 2){
    std::cout << "Error: Please enter file name"<< std::endl;
    return 1;
  }else if(argc > 2){
    std::cout << "Error: Too many arguments given" << std::endl;
    return 1;
  }
  
  //Opening file stream
  std::ifstream inputFile(argv[1]);

  //Checking file opened properly
  if(!inputFile.is_open()){
    std::cout << "Error: File failed to open" << std::endl;
    std::cout << "Check file name and file permissions" << std::endl;
    return 1;
  }

  //making token object
  int done = 0;
  Tokenizer* tok = new Tokenizer;
  
  //Getting string from file line by line
  //Tokenizer parses line printing out token number when token is found
  while(getline(inputFile,tok->block)){
    tok->currentIndex = 0;
    tok->currentChar = tok->block[0];
    done = 0;
    while(!done){
      done = tok->analyzeChar();
    }
  }

  inputFile.close();
  return 0;
}

void Tokenizer::nextChar(){
  //If not at end of string, increment index and assign character at index to currentChar
  if(!(block.size() == (currentIndex+1))){
    currentIndex++;
    currentChar = block[currentIndex];
  }
}

int Tokenizer::analyzeChar(){
  int done = 0;
  std::string token = "";
  std::string error = "Error: Illegal token encountered.";

  //Goes through character by character to find tokens.
  if(currentChar >= 'a' && currentChar <= 'z'){
    while((!(block.size() == (currentIndex+1))) && (currentChar >= 'a' && currentChar <= 'z')){
      
      nextChar();
    }
    if((block.size() == (currentIndex+1)) && (currentChar >= 'a' && currentChar <= 'z')){
      std::cout << "1\n";
      done = 1;
    }else if ((currentChar >= 'A' && currentChar <= 'Z') || (currentChar >= '0' && currentChar <= '9')){
      std::cout << error;
      done = 1;
    }else {
      std::cout << "1\n";
    }
  }else if(currentChar == ';'){
    if(!(block.size() == (currentIndex+1))){
      nextChar();
      std::cout << "12\n";
    }else{
      std::cout << "12\n";
      done = 1;
    }
  }else if(currentChar == '='){
    if(!(block.size() == (currentIndex+1))){
      nextChar();
      if(!(block.size() == (currentIndex+1)) && currentChar == '='){
	nextChar();
	std::cout << "26\n";
      }else if((block.size() == (currentIndex+1)) && currentChar == '='){
	std::cout << "26\n";
	done = 1;
      }else {
	std::cout << "14\n";
      }
    }else{
      std::cout << "14\n";
      done = 1;
    }
  }else if(currentChar == '|'){
    if(!(block.size() == (currentIndex+1))){
      nextChar();
      if(!(block.size() == (currentIndex+1)) && currentChar == '|'){
	std::cout << "19\n";
	nextChar();
      }else if ((block.size() == (currentIndex+1)) && currentChar == '|'){
	std::cout << "19\n";
	done = 1;
      }else{
	std::cout << error;
	done = 1;
      }
    }else{
      std::cout << error;
      done = 1;
    }
  }else if(currentChar >= '0' && currentChar <= '9'){
    while((!(block.size() == (currentIndex+1))) && (currentChar >= '0' && currentChar <= '9')){
      nextChar();
    }
    if((block.size() == (currentIndex+1)) && (currentChar >= '0' && currentChar <= '9')){
      std::cout << "31\n";
      done = 1;
    }else if((currentChar >= 'A' && currentChar <= 'Z') || (currentChar >= 'a' && currentChar <= 'z')){
      std::cout << error;
      done = 1;
    }else{
      std::cout << "31\n";
    }
  }else if(currentChar >= 'A' && currentChar <= 'Z'){
    while((!(block.size() == (currentIndex+1))) && (currentChar >= 'A' && currentChar <= 'Z')){
      nextChar();
    }
    if((block.size() == (currentIndex+1)) && (currentChar >= 'A' && currentChar <= 'Z')){
      std::cout << "32\n";
      done = 1;
    }else if(currentChar >= 'a' && currentChar <= 'z'){
      std::cout << error;
      done = 1;
    }else if(currentChar >= '0' && currentChar <= '9'){
      while((!(block.size() == (currentIndex+1))) && (currentChar >= '0' && currentChar <= '9')){
	nextChar();
      }
      if((block.size() == (currentIndex+1)) && (currentChar >= '0' && currentChar <= '9')){
	std::cout << "32\n";
	done = 1;
      }else if((currentChar >= 'A' && currentChar <= 'Z') || (currentChar >= 'a' && currentChar <= 'z')){
	std::cout << error;
	done = 1;
      }else{
	std::cout << "32\n";
      }
    }else{
      std::cout << "32\n";
    }
  }else if(currentChar == char(32) || currentChar == char(9) || currentChar == char(10) || currentChar == char(13)){
    if(!(block.size() == (currentIndex+1))){
      nextChar();
    }else{
      done = 1;
    }
  }else if(currentChar == char(0)){
    done = 1;
  }else if(!(currentChar >= 'A' && currentChar <= 'Z') || !(currentChar >= 'a' && currentChar <= 'z') || !(currentChar >= '0' && currentChar <= '9') || !(currentChar == ';') || !(currentChar == '=') || !(currentChar == '|') || !(currentChar == char(32)) || !(currentChar == char(9)) || !(currentChar == char(10)) || !(currentChar == char(13)) || !(currentChar == char(0))){
    std::cout << error;
    done = 1;
  }
  return done;
}
