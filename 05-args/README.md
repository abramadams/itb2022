# Arguments, Auto-Complete, Help (Oh my!)
Up until this point we've relied on user input to provide values to use in our command.  This doesn't really fit in with automation or CI/CD practices.  As a best practice, anything that you might prompt a user for input, provide a way to pass that in as an argument.

For simplicity, this demo will build on the simple version of our game from [02-cyoa](../01-cyoa/) and provide a simple way to provide the `inputs` as `arguments`.
## Arguments
With CommandBox, CLI arguments are simply function arguments.  So instead of 
```javascript
function run(){}
```
we can simply do
```javascript
function run( string name, play, color = "red" ) {}
```
and voilá, we can now pass in `name`, `play` and `color` as command line arguments:
```bash
box 05-args name=Bill play=true color=blue
``` 
> Arguments can be passed in positionally or by name as demonstrated above.

Identical as above, but passed in positionally
```bash
box 05-args Bill true blue
``` 
## Flags
Also, boolean typed arguments get special treatment in CommandBox and get automatically converted into flags.  So instead of `play=true`, we could also do `--play` to specify `play=true` or `--noplay` for `play=false`

### Input Overrides
So we can pass in arguments, but it's up to you to determine how that argument overrides the inputs that are prompted from the user.  For this, I like to use the elvis operator `?:`
```javascript
var name = arguments.name?:ask("What is your name?");
```
This is a clean way to say, if the `arguments.name` didn't exist, ask for it.

Same for other type of prompts:
```javascript
var color = arguments.color?:multiselect( "What is your favorite color?" )
                    .setOptions( [
                        { display="Green", value="green" },
                        { display="Red", value="red" },
                        { display="Blue", value="blue" }
                    ] )
                    .ask();
```
## Required Arguments
Lastly, CommandBox helps even further if you define an argument as required.  If for instance we set the argument `name` as required `function run( required string name,...){}` and we called the command without passing in that value, CommandBox will prompt the user for it.  It'll even go so far as to print the JavaDoc "hint" for the argument.
```javascript
   /**
     * 05-cyoa
     *
     * @name.hint The name you wish 05-cyoa to refer to you as
     * @play.hint Whether or not you want to play
     * @color.hint The color you want the text to print (at the end)
    */
    function run( required string name, play, color = "red" ) {
        ...
```
Calling that as `box 05-cyoa` would result in
```bash
Enter name (The name you wish 05-cyoa to refer to you as) :
```

## Auto-Complete
Since we're talking about JavaDoc comments, this is a good time to mention that CommandBox will use these special comments not only for user input as shown above, but in the auto-complete and help system.

So if you're in CommandBox cli and type `05-args` and hit tab` you'd get output like:
```bash
CommandBox> 05-args 
Parameters
color= (The color you want the text to print (at the end))   
name= (The name you wish 05-cyoa to refer to you as)   
play= (Whether or not you want to play)
```
which you can then continue to hit tab to cycle through the options.  Then hit enter to choose the option.  
## Help
You can also get help by calling `05-cyoa help`, which will return:
```bash
**************************************************
* CommandBox Help for 05-args
**************************************************


 05-args 

This command will launch a Choose Your Own Adventure game
This is how you call it:

05-cyoa Bob true blue



         Arguments:
                required string name (The name you wish 05-cyoa to refer to you as)
                play (Whether or not you want to play)
                color = "red" (The color you want the text to print (at the end))
```
## Note
To run this command without installing, don't forget to cd into this directory and run:
```
box package link
```
