# Initialize
```
box package init name="Choose Your Own Adventure Game via CommandBox" version=1.0.0 slug="01-cyoa-commands"
box package set type=commandbox-modules
```
## Create ModuleConfig.cfc
```
component {
    this.title 				= "01 CYOA";
	this.modelNamespace		= "01-cyoa-commands";
	this.cfmapping			= "01-cyoa-commands";
	this.autoMapModels		= true;

    function configure(){
    }    
}
```
## Link it up
```
box package link
```
