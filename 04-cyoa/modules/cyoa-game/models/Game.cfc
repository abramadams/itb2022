component extends="commandbox.system.BaseCommand"{
    property name="ConsolePretty" inject="ConsolePretty@ConsolePretty";
	property name="fileSystem" inject="FileSystem";
    
    property gameComplete;
    property voice;
    

    function onDIComplete(){
        this.gameComplete = false;
        this.voice = false;
    }

    function gameLoop( story = getStory(), voice = false, choice = "initial story" ){
        this.voice = voice;
        // Parse out the current scene (based on previous choice)
        var scene = story.filter( ( section )=>{
            return section.story == choice;
        });

        scene = scene.len() ? scene[1] : {};
        this.gameComplete = isGameComplete( story, scene, choice );
        

        if ( scene.image.len() )
            renderSceneImage( scene.image );

        // If this was the first scene, set the choice to "0" so future choices can build on that
        // This refers to the "story" key in the json.  Each scene has 2 choices, 1 and 2.  The user
        // choses and that number is appended to the current "story" key to determine the next scene to load.
        if( choice == "initial story" ) choice = "0";

        if( choice != 0 ) shell.clearScreen();
        printFormattedSceneText( scene.text );
        
        if( this.gameComplete )
            return endGame( scene );

        // No?, well prompt the next choices
        var answer = question( "What would you like to do?", [{ display: cleanString( scene.button1 ), value: "1"},{ display: cleanString( scene.button2 ), value: "2"}]  );
        // recurse to next scene (choice & answer, i.e. User chose second option on the first scene = "012", first option on the second scene = "0121", etc...)
        gameLoop( story, voice, choice & answer );

        return;
    }
    

    function getStory(){
        return deserializeJSON( fileRead( '../assets/stories/spaceFight.json' ) );
    }

    function endGame( scene ){
        
        if( scene.success ){
            say( "YOU WIN!");
            renderSceneImage( 'images/success.png' )
        } else {
            say( "YOU LOSE!");
            renderSceneImage( 'images/failure.png' )
        }

        var playAgain = question( "That's it! You want to do it again?", [{ display: "I have nothing better to do! YES! Let's play!!!", value: "1"},{ display: "Time for standup - no time!", value: "0"}]  );
        
        if( playAgain ){
            return gameLoop();
        }

        gameOverASCII();
    }

    function isGameComplete( story, struct currentScene, selectedChoice ){

        if ( !currentScene.len() )
            return true;

        if( currentScene.display == 'none' )
            return true;

        return false;

    }

    function sayQuestion( question, options ){
        say( cleanString( question ) );
        var speakOptions = options.reduce( (prev,cur)=>{
            prev.append( cleanString( cur.display ) );
                return prev;
        }, []).toList(" or ");
        say( speakOptions );
    }

    function say( text ){
        var sayCommand = filesystem.isWindows() 
            ? "#getDirectoryFromPath(getCurrentTemplatePath())#\assets\bin\wsay.exe"
            : "say";
        if( this.voice )
            command('!#sayCommand# "#cleanString( text )#"').run();
    }

    function question( string question, array options ){
        sayQuestion( question, options );
        return multiselect()
                    .setQuestion( question )
                    .setOptions( options )
                    .setRequired( true )
                    .setMultiple( false ).ask();
    }
    function cleanString( text ){
        return text
            .reReplace("<[^>]*>", "","all")
            .reReplace('"', "'","all")
            .reReplace("&##39;", '"',"all")
            .reReplace("&##34;", '"',"all");
    }
    function printFormattedSceneText( text ){
        var formattedText = cleanString( text.replaceNoCase('<br>'," " & chr(999),'all') );
        var message = formattedText;
       
        // ConsolePretty.printMessageBox( message = formattedText.listToArray(chr(999)), border = "👾", color="PaleTurquoise1", borderColor="blue", columns = 100, wordWrap =true, textAlign="left" );
        formattedText.listToArray(chr(999)).each( (line)=>{
            print.boldGreenLine( line ).toConsole();            
        });
        try{
            say( cleanString( text ) );
        }catch (any e) {}

        return;
    }

    function gameOverASCII(){
        renderSceneImage( 'images/itb-2022.png' );
    }

    function renderSceneImage( path ){

        var uniqueImagePath = getTempDirectory() & createUUID() & "." & listLast( path, "." );
       
        fileCopy( '../assets/' & path, uniqueImagePath );

        command( 'ImageToASCII' )
            .params( uniqueImagePath ).run();

    }
}