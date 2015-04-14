#include <stdio.h>
#include <unistd.h>
#include "ssem.h"
#include "sshm.h"

#define MUTEX1KEY 485971

int main(){
  //Creating Semaphores
  int mutex1 = sem_creat(MUTEX1KEY, 0);
  if(mutex1<0){
    printf("Semaphore mutex1 failed to be created.");
  }

  int fd[2];
  pid_t childpid1;
  pid_t childpid2;

  pipe(fd);

  childpid1 = fork();
  if(childpid2 != 0){
    childpid2 = fork();
  }

  int i;

  //Code for child process 1
  if(childpid1 == 0){
    for(i=0; i<500; i++){
      sem_wait(mutex1);
      write(fd[1], "aaa", 6);
      sem_signal(mutex1);
    }
  }else if(childpid2 == 0){ //Code for child process 2
    for(i=0; i<260; i++){
      sem_wait(mutex1);
      write(fd[1], "",3)
      sem_signal(mutex1);
    }
  }else{ //Code for main parent process
    char[100] buff;
    int return1, return2;
    //wait for both child processes to close
    wait(&return1);
    wait(&return2);

    int numberRead = 1;
    while(numberRead != 0){
      numberRead = read(fd[0], buff, 100);
      printf("%s", buff);
    }
  }

  close(fd[0]);
  close(fd[1]);
  sem_rm(mutex1);
}
