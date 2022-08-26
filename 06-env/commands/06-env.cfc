/**
* This command will launch a Choose Your Own Adventure game
* This is how you call it:
*
* {code:bash}
* 06-env
* 06-env name=Bob
* 06-env color=green
* {code} 
* 
**/
component extends="commandbox.system.BaseCommand" {
    property name="systemSettings" inject="SystemSettings";

   /**
     * 06-env
     *
     * @name.hint The name you wish 06-env to refer to you as
     * @play.hint Whether or not you want to play
     * @color.hint The color you want the text to print (at the end)
    */
    function run( string name, boolean play, string color ) {
        // For this example we used the commandbox-dotenv module to read our
        // .env file (in the /06-env/ directory) and automagically load the 
        // environment variables defined there into the java server.


        // This will get the environment variables that were set into 
        // the java system and use them as default argument values.  
        // Arguments passed in on the CLI will override.
        arguments.append(systemSettings.getCurrentEnvironment(),false);
        
        // Another way to map java system environment variables to setup defaults
        // var envVars = {
        //     name: systemSettings.getSystemSetting("name",arguments?.name),
        //     play: systemSettings.getSystemSetting("play",arguments?.play),
        //     color: systemSettings.getSystemSetting("color",arguments?.color)
        // }
        // arguments.append(envVars,false);

        // Or you could shell out to your os and grab all the env variables and parse them yourself
        // var envVars = command('!env').run(returnOutput=true);
        // print.line(envVars).toConsole();

        var name = arguments.name?:ask("What is your name?");

        print.boldBlueLine("Well #name#, it's nice to meet you. I'm #getFileFromPath(getCurrentTemplatePath()).listFirst('.')#, your friendly game bot.").toConsole();
        var play = arguments.play?:confirm("Would you like to play a game?");
    
        game(play,color);

        return;
    }

    function game( play, color ){
        if( !play ){
            print.boldRedLink(":( ok, whatever...").toConsole();
            return;
        }
        print.boldLine("GREAT!").toConsole();
        
        var color = arguments.color?:multiselect( "What is your favorite color?" )
                    .setOptions( [
                        { display="Green", value="green" },
                        { display="Red", value="red" },
                        { display="Blue", value="blue" }
                    ] )
                    .ask();

        print.line("Oooh, #color#, that's a nice choice", color).toConsole();
        
    }

}
