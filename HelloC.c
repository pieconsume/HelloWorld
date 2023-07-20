//unistd.h could be included instead but this lets you easily view function prototypes you use
extern int write(int fd, char* buffer, int count);

//You don't need to define command line arguments if you aren't going to use them
int main()
{
 //If I only need to print a regular char[] with no special formatting I like to use write()
 write(1, "hello!\n", 7);
 //It's not necessary to include a return value for main(), the compiler will handle that for you
}