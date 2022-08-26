# Environment Variables
Arguments are great, and provide a way to fashion automated processes that pass in commandline arguments. However, in many CI/CD systems out there the preferred method is using environment variables.  This is more secure, and provides an easy way to use the same build for many environments without having to have that logic built into the CI/CD process.

This demo makes use of another external module named [dotenv](https://forgebox.io/view/commandbox-dotenv) to automatically find and load the `.env` file then parse it's key/value pairs into system environment variables to be consumed in your CommandBox command.

This demo also uses the CommandBox provided `SystemSettings` module to allow us to tap into the environment variables (and other system variables we can define)
```javascript
property name="systemSettings" inject="SystemSettings";
```

As with the previous demo, it's up to you on how to handle overriding the arguments.  In the last example we used the elvis operator to favor the commandline provided arguments (if they existed), then to default to either the argumnent's default or the prompt for user input.  In this example, we want environment variables to override prompts, but we want commandline arguments to override environment variables (taking the stance that if a user passed in via commandline that should take priority), so we can simply begin our function with
```javascript
arguments.append(systemSettings.getCurrentEnvironment(),false);
```
This will essentially merge the arguments scope wtih the environment variables in the SystemSettings module, but not overwrite anything in the arguments scope if the value already exists.

That's it.

You could alternatively handle each argument/env variable individually using something like 
```javascript
systemSettings.getSystemSetting("name",arguments?.name)
``` 
which will get the setting from environment variables, but default to the arguments if not found.

## Demo setup
Copy `.env.example` as `.env` and fill in the values for each of the keys

### Note
To run this command without installing, don't forget to cd into this directory and run:
```
box package link
```
### Install dependencies
You'll also need to install the dependencies to get the dotenv module.
```
box install
```
