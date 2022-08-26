/**
* This command will launch a Choose Your Own Adventure game
* This is how you call it:
*
* {code:bash}
* 05-cyoa Bob true blue
* {code} 
* 
**/
component extends="commandbox.system.BaseCommand" {

   /**
     * 05-cyoa
     *
     * @name.hint The name you wish 05-cyoa to refer to you as
     * @play.hint Whether or not you want to play
     * @color.hint The color you want the text to print (at the end)
    */
    function run( string name, play, color = "red" ) {
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

        print.line("Oooh, nice choice", color).toConsole();
        
    }

}
