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
the jailinstall.sh script from the cloned repository 
(make sure it is executable).
````
$ ./jailinstall.sh
````
#### Removal
To remove the Jailkit tool and all of its dependencies run the
jailuninstall.sh script from the cloned repository
(make sure it is executable).
````
$ ./jailuninstall.sh
````
### Setup
To create a jail folder run the script jailcreate.sh (make sure it is executable)
from the cloned repository. Provide a name for the jail directory
and by default the jail directory is placed inside the root directory /. Specify the full
path to the requirements file if it is not inside the same folder as the script.   
The requirements file contains all the 
tools that are necessary in order to run code inside the jail.
````
$ JAIL_FILENAME=name REQUIREMENTS=requirements ./jailcreate.sh
````

To jail a user inside the jail directory run the jailusers.sh 
script (make sure it is executable). Enter the jail name and the 
number of users to jail. The script will create the specified number
of users,jail them and disable access to the network for those users.
This script can be called multiple times with 
the same jail directory.  
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
To check if it all works run the jailtest.sh script which runs the 
proc_test.py to check if the jailed users can fork processes
and the TCPclient.py and TCPserver.py to check if
the jailed users can make network connections. If the users can't do any of
the above mentioned the tests will pass and the users are jailed.
````
$ JAIL_FILENAME=jail ./jailtest.sh
````
#### Remove setup


### Running processes in jail
[todo]

## Hazards
### Fork Bombing
[todo]

### Network Connection
[todo]

### Filesystem access
[todo]

### System tools usage
[todo]

## License
MIT

