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
    char number[3]
    char buff[6]
    for(i=0; i<500; i++){
      memset(number, 0, sizeof(number));
      memset(buff, 0, sizeof(buff));
      sprint(number, "%d", i);
      if(i<9){
        strcpy(buff, "00");
      }else if(i>=9 && i<99){
        strcpy(buff, "0");
      }
      strcat(buff, number);
      strcat(buff, "aaa");
      sem_wait(mutex1);
      write(fd[1], buff, 6);
      sem_signal(mutex1);
      if(i%100 == 0){
        usleep(100000);
      }
    }
  }else if(childpid2 == 0){ //Code for child process 2
    char buff[3];
    char letter[1];
    char number[1];
    int num = 0;
    char a = 'A';
    for(i=0; i<260; i++){
      memset(buff, 0, sizeof(buff));
      memset(letter, 0 ,sizeof(letter));
      memset(number, 0, sizeof(number));
      if(a<'Z'){
        sprintf(letter, %c, a);
        a++;
      }else{
        sprintf(letter, %c, a);
        a = 'A';
        num++;
        if(num == 10){
          num = 0;
        }
      }

      sprintf(number, "%d", num);
      strcpy(buff, letter);
      strcat(buff, "x");
      strcat(buff, number);

      sem_wait(mutex1);
      write(fd[1], "",3)
      sem_signal(mutex1);
      if(i%60 == 0){
        usleep(300000);
      }
    }
  }else{ //Code for main parent process
    char buff[100];
    int return1, return2;
    //wait for both child processes to close
    wait(&return1);
    wait(&return2);

    int numberRead = 1;
    int reads = 0;
    while(numberRead != 0){

      numberRead = read(fd[0], buff, 100);
      printf("%s", buff);
      reads++;
      if(reads%50 == 0){
        usleep(200000);
      }
    }

    close(fd[0]);
    close(fd[1]);
    sem_rm(mutex1);
  }


}
