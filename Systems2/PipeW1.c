//gcc -o PipeW1 PipeW1.c ssem.o sshm.o

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "ssem.h"
#include "sshm.h"

#define MUTEX1KEY 485971

int main(){
  int i;
  char number1[3];
  char buff1[6];
  for(i=0; i<500; i++){
    memset(number1, 0, sizeof(number1));
    memset(buff1, 0, sizeof(buff1));
    sprintf(number1, "%d", i+1);
    if(i<9){
      strcpy(buff1, "00");
    }else if(i>=9 && i<99){
      strcpy(buff1, "0");
    }
    strcat(buff1, number1);
    strcat(buff1, "aaa");
    sem_wait(mutex1);
    write(fd[1], buff1, 6);
    sem_signal(mutex1);
    if(i%100 == 0){
      usleep(100000);
    }
  }
}
