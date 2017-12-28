# Jail scripts for running untrusted code in safe environment
## Introduction
Creates an environment for running untrusted code. It involves creating a user on
the system and putting him inside a jail directory from where he can't
access files that aren't in the jail, can't use more system resources then specified and
can't access the network.

This project uses the Jailkit tool developed by Olivier Sessink.  
[Jailkit webiste](https://olivier.sessink.nl/jailkit/)

## Usage
### Installation 
To install the Jailkit tool needed for the other 
scripts to run properly you can install it from the official 
[Jailkit webiste](https://olivier.sessink.nl/jailkit/) or run 
the `jailinstall.sh` script from the cloned repository 
(make sure it is executable).
````
$ ./jailinstall.sh
````
#### Removal
To remove the Jailkit tool and all of its dependencies run the
`jailuninstall.sh` script from the cloned repository
(make sure it is executable).
````
$ ./jailuninstall.sh
````
### Setup
To create a jail folder run the script `jailcreate.sh` (make sure it is executable)
from the cloned repository. Provide a name for the jail directory
and by default the jail directory is placed inside the root directory /. Specify the full
path to the requirements file if it is not inside the same folder as the script.   
The requirements file contains all the 
tools that are necessary in order to run code inside the jail.
````
$ JAIL_FILENAME=name REQUIREMENTS=requirements ./jailcreate.sh
````

To jail a user inside the jail directory run the `jailusers.sh` 
script (make sure it is executable). Enter the jail name and the 
number of users to jail. The script will create the specified number
of users,jail them and disable access to the network for those users.
This script can be called multiple times with 
the same jail directory. Usernames for the jailed users are constructed
by appending the name of the jail directory and the ordinal number of insertion into the jail.
````
$ JAIL_FILENAME=name USER_NUM=user_num ./jailusers.sh
````

#### Example setup
The repository contains some examples you can run to see how 
it works. There is a default requirements file called requirements.txt
that contains all the requirements to run python3 code inside the jail.

This part will walk you through the process of setting up a jail for running
untrusted python code.

Create the jail with the command
````
$ JAIL_FILENAME=jail REQUIREMENTS=requirements.txt ./jailcreate.sh
````

Create for example two users and jail them
````
$ JAIL_FILENAME=jail USER_NUM=2 ./jailusers.sh
````
This creates the users jail1 and jail2.
If you decide to run the command again it would create the users
jail3 and jail4.

To check if it all works run the `jailtest.sh` (make sure it is executable) script which runs the 
`proc_test.py` to check if the jailed users can fork processes
and the `TCPclient.py` and `TCPserver.py` to check if
the jailed users can make network connections. If the users can't do any of
the above mentioned the tests will pass and the users are jailed.
````
$ JAIL_FILENAME=jail ./jailtest.sh
````
To remove the example jail directory, all of its users and 
configurations run
````
$ JAIL_FILENAME=jail ./jailremove.sh
````
#### Remove setup
To remove the jail directory run the `jailremove.sh` 
(make sure it is executable) script from the cloned repository. Specify the 
name of the jail directory to remove and the script will remove the jail directory, 
all the jailed users and all the configurations made during the process of jailing the users.
````
$ JAIL_FILENAME=name ./jailremove.sh
````
### Running processes in jail
To run a command inside the jail the `chroot` command is used.
Run the `chroot` command as sudo, specify the username of the jailed
user with whom you wish to execute the command, specify the jail directory
in which the user is jailed and specify the command you wish to run.
````
$ sudo chroot --userspec=username /jail_name command_to_run
````
For example you can run untrusted python3 **code located inside the jail 
directory** named `alcatraz` with the user named `prisoner` located inside the jail
by executing 
````
$ sudo chroot --userspec=prisoner /alcatraz python3 path_to_untrusted_code
````
This is possible only if you specify inside the requirements file to 
copy python3 inside the jail directory upon creation.
## Hazards
### Fork Bombing
To prevent a code inside the jail to fork multiple processes and thereby
execute a malicious attack called fork bomb the code is run using the prlimit
command 
````
$ sudo prlimit --noproc=max_num_of_processes chroot --userspec=username /jail_name command_to_run
````
For example you can run untrusted python3 **code located inside the jail 
directory** named `alcatraz` with the user named `prisoner` located inside the jail
with a maximum of 1 process by executing
````
$ sudo prlimit --noproc=1 chroot --userspec=prisoner /alcatraz python3 path_to_untrusted_code
````
### Network Connection
Network connection is disabled by default when jailing users 
with the `jailusers.sh` script. 
If you wish to grant the jailed users the ability to gain network 
access **which is not advised** when executing untrusted code 
comment out the lines 37, 38 and 39 in the `jailusers.sh` script.

### Filesystem access
The jailed user can only move around the files inside the jail and 
doesn't have access to the files beyond the jail. The user can only
modify files in his home directory and can read all the other files 
in the jail but can't modify them.

### System tools usage
It is strongly advised to provide the jailed user with only the
necessary tools to execute his code.

## License
MIT

