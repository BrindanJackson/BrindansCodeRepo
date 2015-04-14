//gcc -o PipeW2 PipeW2.c ssem.o sshm.o

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "ssem.h"
#include "sshm.h"

#define MUTEX1KEY 485971

int main(){
  int i;
  char buff2[3];
  char letter[1];
  char number2[1];
  int num = 0;
  char a = 'A';
  for(i=0; i<260; i++){
    memset(buff2, 0, sizeof(buff2));
    memset(letter, 0 ,sizeof(letter));
    memset(number2, 0, sizeof(number2));
    if(a<'Z'){
      sprintf(letter, "%c", a);
      sprintf(number2, "%d", num);
      a++;
    }else{
      sprintf(letter, "%c", a);
      sprintf(number2, "%d", num);
      a = 'A';
      num++;
      if(num == 10){
        num = 0;
      }
    }
    strcpy(buff2, letter);
    strcat(buff2, "x");
    strcat(buff2, number2);

    sem_wait(mutex1);
    write(fd[1], buff2, 3);
    sem_signal(mutex1);
    if(i%60 == 0){
      usleep(300000);
    }
  }
}
