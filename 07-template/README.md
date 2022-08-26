# Templating via System Variable Expansion
CommandBox has a pretty slick way to expand system variables (variables set into SystemSettings) by way of System Variable Expansion (interpolation).  This allows you to set up templates with placeholders using the `${name here}` syntax and have those replaced at runtime with values from SystemSettings.

Simply define your template file (any file you wish to "hydrate" with values) and call 
```javascript
SystemSettings.expandDeepSystemSettings(template);
```
on it.

This makes creating things like config files, buildspec files, build scripts, .env files, CFConfig files, etc... dead simple.

To get values into SystemSettings you either use the `dotenv` to pull those `.env` files into environment variables, or use the `SystemSettings.setSystemSetting(name,value)` method.  i.e:
```javascript
systemSettings.setSystemSetting('itb2022.hi','!! Hola from ITB2022 !!');
```
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