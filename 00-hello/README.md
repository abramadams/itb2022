# Hello Command Demo
This CommandBox module will expose a single command that simply takes a string argument of name and says hello to that name.

## Anatomy of a Command
The meat of a CommandBox Command really boils down to a CFC that lives inside a `commands/` directory named `<command name>.cfc` with a public method named `run()`; this is where all the magic happens.

OK, maybe that was an oversimplification.  Besides the `<command name>.cfc` file, the command will also need to live in a Commandbox Module, which is defined by a `ModuleConfig.cfc` and will need a box.json file detailing things like
```json
{
    "name": "Say Hello CommandBox",
    "version": "1.0.0",
    "author": "Abram Adams",
    "type": "commandbox-modules",
    "slug": "hello-commands"
}
```
The file structure needs to be 
```
/<project name>
    /commands/
        /<optional namespace folder>/
            <command name>.cfc
        <command name>.cfc
    /box.json
    /ModuleConfig.cfc
```
> More documentation can be found at [https://commandbox.ortusbooks.com/developing-for-commandbox](https://commandbox.ortusbooks.com/developing-for-commandbox)
## Key points
* CommandBox Commands are defined in a Module.  The Module is defined by ModuleConfig.cfc
* Commandbox expects commands to be in a folder named "commands" at the root of your module
* Commands are just CFC's that expose a "run" method.  The name of the cfc file is the command that will be installed
* Namespaces can be made using folders (i.e. say/hello.cfc ==`say hello` where `say` can have many commands)
* JavaDoc style comments to generate contextual help
