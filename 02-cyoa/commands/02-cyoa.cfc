/**
* This command will launch a Choose Your Own Adventure game
* This is how you call it:
*
* {code:bash}
* 02-cyoa
* {code} 
* 
**/
component extends="commandbox.system.BaseCommand" {

   /**
     * 02-cyoa
     *
    */
    function run() {
        var name = ask("What is your name?");
        print.boldBlueLine("Well #name#, it's nice to meet you. I'm #getFileFromPath(getCurrentTemplatePath()).listFirst('.')#, your friendly game bot.").toConsole();
        var play = confirm("Would you like to play a game?");
    
        gameLoop(play);

        return;
    }

    function gameLoop( play ){
        if( !play ){
            print.boldRedLink(":( ok, whatever...").toConsole();
            return;
        }
        print.boldLine("GREAT!").toConsole();
        
        var color = multiselect( 'What is your favorite color? ' )
                    .setOptions( [
                        { display='Green', value='green' },
                        { display='Red', value='red' },
                        { display='Blue', value='blue' }
                    ] )
                    .ask();
        print.line("Oooh, nice choice", color).toConsole();
        
    }

}
