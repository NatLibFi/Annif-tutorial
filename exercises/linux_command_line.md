# A Short Introduction to the Linux Command Line
During the Tutorial Annif will mainly be controlled from Linux command line.
This document provides an overview of the functionalities used.
You can return to the examples in this document to better understand the commands used during the tutorial.
You get access to the commandline by opening the __Terminal__ application.

## Directories
Files in Linux are organized in a hiearchy of directories.
You can navigate through the hierarchy from the commandline.
This is simmilar to clicking through folders in a graphical file explorer (i.e., Windows Explorer or Finder on Mac OS).

### The Current Directory
Commands are usually executed relative to a directory.
To show the current directory the `pwd` command can be used.
```
pwd
```

### Contents of a Directory
The `ls` command, shorthand for _list_, lists the contents of the directory.
```
ls
```
You can modify the output of the directory listing with arguments.
The option `-l` prints each item on a new line.
```
ls -l
```

### Changing a Directory
You can switch a directory using the change directory (`cd`) command.
```
pwd
cd folder
pwd
```
There are some special arguments to `cd`:
* `cd ..` will navigate to the parent directory, i.e., the directory containing the current one.
* `cd` without an argument will navigate to a users home folder. This is where your personal files and configurations are located.
* `cd -` Will go to the directory you previously used.

### Absolute Paths
The previous examples used relative paths as the argument to `cd`.
I.e., they were either a subdirectory of the current directory or its parent.
You can also use absolute paths that refrence the root of the file hierarchy.
These are called absolute paths and start with a `/`.

## Output Redirection
Some of the programs used during the tutorial will print output to the terminal.
After the programs have terminated it is hard to use the output in other programs.
However it is possible to write the output of a program to a file.
This is done using the redirection operators:
* `cmd_1 > itermediate.txt` will write the output of the command `cmd_1` to a file called `intermediate.txt`
* `cmd_2 < intermediate.txt` will use the contents of the file `intermediate.txt` as input to command `cmd_2`

It is also possible to skip the intermediate file.
When running `cmd_1 | cmd_2` the output of `cmd_1` is used as input to `cmd_2`.

## Text Editor
There are many different text editors for the commandline.
If you are new to the commandline `nano` is an easy to use choice.

### Open a File
You can give an editor program the file you want to edit as an argument.

`nano projects.cfg` will open the file `projects.cfg` in the current directory for editing.
If it does not exist it, will be created.

### Saving changes
In `nano` pressing `ctrl` and the `o` key at the same time saves the modifications you made.
The program will ask for the location where the file should be saved.
If you want to apply the changes to the existing file, hit enter.

### Exiting Nano
Pressing `ctrl` and the `x` key at the same time will close `nano`.
If you have unsafed modifications to the file you are editing, nano will prompt you to save the changes.
You can answer the prompt by pressing the `y` or `n` key.

