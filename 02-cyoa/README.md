# Helper Methods
With CommandBox commands, only the `run` method is exposed to the CLI, but it's just a CFC and can/should be organized using coding best practices.  Think of this file as your handler/controller.

In this example we've added a new method `game` and moved most of the logic into that method. 
> Later examples will show how to leverage modules and DI

## Note
To run this command without installing, don't forget to cd into this directory and run:
```
box package link
```
