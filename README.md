# APiI-PasswordManager
This is a tiny bash script that can hash your password and save it locally. It can also verify the password.  

### Why make this?
This file aims to provide a secure password management for project [APiI](https://github.com/Catboy96/APiI).   
APiI is a simple WebAPI that runs on a Raspberry Pi and use bash script as CGI.  
For the performance concern, the password management:
* NO DEPENDENCIES!
* Must be implemented by the programs already installed.
* Must be effective and secure.

### Usage
#### Interactively
* To set the password: `bash pwmgr.sh -s`
* To verify: `bash pwmgr.sh -v`
#### Uninteractively
* To set the password: `bash pwmgr.sh -s <<< "PASSWORD"`
* To verify: `bash pwmgr.sh -v <<< "PASSWORD"`

