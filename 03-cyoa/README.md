# Shell and Filesystem
CommandBox has many helpers that make it dead simple to run shell commands, or work with the local filesystem.  

The code in this example adds things like
```javascript
variables.story = deserializeJSON( fileRead( 'assets/stories/spaceFight.json' ) );
```
to read the game's story into a variable so we can use it and the adventure choices to present to the user.

It also uses various shell commands that are delegated to your CLI such as 
```bash
command( '!clear' ).run();
```
to clear the terminal, and 
```bash
command('!#sayCommand# "#cleanString( text )#"').run();
```
which runs the say (wsay on Windows) command to vocalize the story.

In addtion, there's also use of the `FileSystem` module that comes baked into CommandBox to detect the operating system so we can determine which "say" command to use:
```javascript
filesystem.isWindows()
```
> more on injecting modules in the next demo
## Note
To run this command without installing, don't forget to cd into this directory and run:
```
box package link
```