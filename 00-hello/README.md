# Hello function
This CommandBox module will expose a single command that simply takes a string argument of name and says hello to that name.

## Key points
* CommandBox Commands are defined in a Module.  The Module is defined by ModuleConfig.cfc
* Commandbox expects commands to be in a folder named "commands" at the root of your module
* Commands are just CFC's that expose a "run" method.  The name of the cfc file is the command that will be installed
* Namespaces can be made using folders (i.e. say/hello.cfc ==`say hello` where `say` can have many commands)
* JavaDoc style comments to generate contextual help
