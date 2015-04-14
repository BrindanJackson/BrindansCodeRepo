//gcc -o PipeRW PipeRW.c ssem.o sshm.o

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

  pipe(fd);

  childpid1 = fork();
  if(childpid1 != 0){
    childpid2 = fork();
  }

  int i;

  //Code for child process 1
  if(childpid1 == 0){
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
  }else if(childpid2 == 0){ //Code for child process 2
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
  }else{ //Code for main parent process
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


}
