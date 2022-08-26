# Modules and Dependency Injection
Modules are essentially little applications that conform to a "contract" in order to be injected into the parent application.  In the case of CommandBox, which is built on the Coldbox framework, that means it has at least a `ModulesConfig.cfc` that describes the module:
```javascript
component {
    this.title 				= "CYOA Game";
	this.modelNamespace		= "cyoa-game";
	this.cfmapping			= "cyoa-game";
	this.autoMapModels		= true;

    function configure(){
    }    
}
```

In this demo we've moved much of what was in the main command's CFC into a module named `Game.cfc` and namespaced it `cyoa-game`.  Now we can inject this into any CFC using the built-in WireBox DI framework conventions:
```javascript
property name="game" inject="Game@cyoa-game";
```

Modules Don't have to be something you wrote.  There are many modules on [ForgeBox](Forgebox.io) that you can directly install.  

For example, in this example the `./modules/cyoa-game/models/Game.cfc` file we leverage two external modules:
```javascript
property name="ConsolePretty" inject="ConsolePretty@ConsolePretty";
property name="fileSystem" inject="FileSystem"; 
```
The first of these [ConsolePretty](https://forgebox.io/view/ConsolePretty) is a commandbox module published to ForgeBox.  This provides a slick way to spice up the text by adding a border around text block (as well as word wrapping and alignment options).

The second `FileSystem` is simply injecting CommandBox's baked in module so we can leverage it in our code.

Lastly, this demo also provides another external CommandBox module for us to use, though not as a library, but as an executable command: the [ImageToASCII](https://forgebox.io/view/CommandBox-ImageToASCII) command.  
Instead of injecting this into our command, we simply install it (via box.json dependency) and call it using CommandBox's `command()` method:
```javascript
command( 'ImageToASCII' ).params( uniqueImagePath ).run();
``` 
This command provides all the ascii art goodness in this game.
## Note:
You must run `box install` to install dependencies before using this command. 

Also, to run this command without installing, don't forget to cd into this directory and run:
```
box package link
```