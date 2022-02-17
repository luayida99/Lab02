#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <fcntl.h>

int main() {

    printf("Be patient, the program will take around 7 seconds to run.\n");
    printf("At the end you can do \"cat results.out\" to see the result.\n");

    //
    // Add code here to pipe from ./slow 5 to ./talk and redirect
    // output of ./talk to results.out
    // I.e. your program should do the equivalent of ./slow 5 | talk > results.out
    // WITHOUT using | and > from the shell.
    //

    int p[2]; // p[0] is reading, p[1] is writing
    int fp_out = open("./results.out", O_CREAT | O_WRONLY, 0666);

    if (pipe(p) < 0) {
        perror("lab2p2f: ");
    }

    // exec slow 
    if (fork() == 0) {
        dup2(p[1], STDOUT_FILENO);
        close(p[0]);
        execlp("./slow", "slow", "5", (char *) 0);
        close(p[1]);
    } else {
        close(p[1]);
        // exec talk
        if (fork() == 0) {
            dup2(p[0], STDIN_FILENO);
            dup2(fp_out, STDOUT_FILENO);
            execlp("./talk", "talk", (char *) 0);
            close(p[0]);
        } else {
            wait(NULL);
            close(p[0]);
        }
    }
    close(fp_out);
}

