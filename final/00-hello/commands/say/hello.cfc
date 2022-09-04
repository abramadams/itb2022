/**
* This command will say hello
* This is how you call it:
*
* {code:bash}
* say hello 'Your name'
* {code} 
* 
**/
component {
   
    function run( required string name ) {
        
        print.boldGreenLine( "Hello #name#!" ).toConsole();
        return;
    }
    
    
}
