/**
 * This command will launch a Choose Your Own Adventure game
 * This is how you call it:
 *
 * {code:bash}
 * 03-docker-containers
 * {code} 
 * 
 **/
component extends = "commandbox.system.BaseCommand" {
    /**
     * 03-docker-containers
     *
     */
    function run(boolean voice = false) {
        print.line('starting up docker instance ortussolutions/commandbox:lucee5....').toConsole();
        command('!docker run -d -p 8080:8080 -p 8443:8443 ortussolutions/commandbox:lucee5').run();
        print.boldLine('waiting for server to come up').toConsole();
        sleep(30000);

        var dockerContainerIds = command('!docker ps').params('-a','-q').run(returnOutput = true);
        print.line('Done!  Got container ID #dockerContainerIds.listFirst(chr(10))#').toConsole();
        
        print.line(dockerContainerIds).toConsole();
        cfhttp(url="http://127.0.0.1:8080",method="GET",result="local.content");
        print.boldGreenLine('Got http response from docker:').line(local.content.fileContent).toConsole();
        print.boldRedLine('Stopping docker container: #dockerContainerIds.listFirst(chr(10))#').toConsole();

        command('!docker stop').params(dockerContainerIds.listFirst(chr(10) )).run();
        print.boldGreenLine('DONE!').toConsole();

        print.line('Removing contianer').toConsole();
        command('!docker container prune').params('-f').run();
        print.boldGreenLine('DONE!').toConsole();

    
        


    }
}