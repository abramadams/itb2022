/**
* This command will launch a Choose Your Own Adventure game
* This is how you call it:
*
* {code:bash}
* 04-cyoa --voice
* {code} 
* 
**/
component extends="commandbox.system.BaseCommand" {
    property name="game" inject="Game@cyoa-game";

   /**
     * 04-cyoa
     *
     * @voice.hint True tells CYOA to voice the text as well as display
    */
    function run( boolean voice = false ) {
        
        command( '!clear' ).run();
        // Let the game begin!
        game.gameLoop( voice=voice );
        
        return;
    }

    

}
