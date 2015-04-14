//gcc -o PipeR PipeR.c ssem.o sshm.o

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "ssem.h"
#include "sshm.h"

#define MUTEX1KEY 485971

int main(){
  char buff3[100];
  int return1, return2;
  //wait for both child processes to close
  wait(&return1);
  wait(&return2);

  int numberRead = 1;
  int reads = 0;
  while(numberRead != 0){
    memset(buff3, 0, sizeof(buff3));
    numberRead = read(fd[0], buff3, 100);
    printf("%s", buff3);
    reads++;
    if(reads%50 == 0){
      usleep(200000);
    }
  }

  close(fd[0]);
  close(fd[1]);
  sem_rm(mutex1);
}
