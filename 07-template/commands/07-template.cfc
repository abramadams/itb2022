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
     * 07-template
     *
    */
    function run( string name, boolean play, string color ) {
        systemSettings.setSystemSetting('itb2022.hi','!! Hola from ITB2022 !!');
        systemSettings.setSystemSetting('now',now());

        var template = fileRead('../template.txt');
        print.boldLine(systemSettings.expandDeepSystemSettings(template)).toConsole();      
    }

}
