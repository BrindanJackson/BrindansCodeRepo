//gcc -o PipeC PipeC.c ssem.o sshm.o

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "ssem.h"
#include "sshm.h"

#define MUTEX1KEY 485971

int main(){
  //Creating Semaphore
  int mutex1 = sem_create(MUTEX1KEY, 1);
  if(mutex1<0){
    printf("Semaphore mutex1 failed to be created.");
  }

  int fd[2];
  pid_t childpid1;
  pid_t childpid2;
  pid_t childpid3;

  pipe(fd);

  char arg[1];

  childpid1 = fork();
  if(childpid1 == 0){
    execv("PipeW1", arg);
  }

  childpid2 = fork();
  if(childpid2 == 0){
    execv("PipeW2", arg);
  }

  childpid3 = fork();
  if(childpid3 == 0){
    execv("PipeR", arg);
  }
}
