/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        MainWindowController.m
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "MainWindowController.h"
#import "ApplicationController.h"
#import "ApplicationDelegate.h"

@implementation MainWindowController

@synthesize progress;
@synthesize activateProgress;
@synthesize uninstallButton;
@synthesize quitButton;
@synthesize keepWebData;
@synthesize serialPanel;
@synthesize serialField;

- ( id )init
{
    if( ( self = [ super initWithWindowNibName: @"MainWindow" ] ) )
    {}
    
    return self;
}

- ( void )dealloc
{
    [ progress        release ];
    [ uninstallButton release ];
    [ quitButton      release ];
    [ keepWebData     release ];
    [ serialPanel     release ];
    [ serialField     release ];
    
    [ super dealloc ];
}

- ( void )removeFiles: ( id )sender
{
    ApplicationController * app;
    ApplicationDelegate   * appDelegate;
    char                  * args[ 3 ];
    
    app                      = ( ApplicationController * )NSApp;
    appDelegate              = ( ApplicationDelegate * )app.delegate;
    appDelegate.uninstalling = YES;
    
    [ uninstallButton setEnabled: NO ];
    [ quitButton      setEnabled: NO ];
    [ progress        setIndeterminate: YES ];
    [ progress        startAnimation: sender ];
    
    args[ 0 ] = "-rf";
    args[ 1 ] = "/Applications/WebStart.app";
    args[ 2 ] = NULL;
    
    [ app.execution executeWithPrivileges: "/bin/rm" arguments: args io: NULL ];
    
    if( [ keepWebData integerValue ] == 0 )
    {
        args[ 1 ] = "/Library/WebStart";
        
        [ app.execution executeWithPrivileges: "/bin/rm" arguments: args io: NULL ];
    }
    
    args[ 1 ] = "/usr/local/webstart";
    
    [ app.execution executeWithPrivileges: "/bin/rm" arguments: args io: NULL ];
    [ progress stopAnimation: sender ];
    [ quitButton setEnabled: YES ];
    
    appDelegate.uninstalling = NO;
}

- ( void )sheetDidEnd: ( NSWindow * )sheet returnCode: ( int )returnCode contextInfo: ( void * )contextInfo
{
    ( void )sheet;
    ( void )contextInfo;
    ( void )returnCode;
}

- ( IBAction )enterSerial: ( id )sender
{
    ( void )sender;
    
    [ NSApp beginSheet:     serialPanel
            modalForWindow: self.window
            modalDelegate:  self
            didEndSelector: @selector( sheetDidEnd: returnCode: contextInfo: )
            contextInfo:    nil
    ];
}

- ( IBAction )deactivate: ( id )sender
{
    NSAlert * alert;
    
    [ activateProgress setHidden: NO ];
    [ activateProgress startAnimation: nil ];
    
    alert  = [ [ NSAlert alloc ] init ];
    
    [ activateProgress setHidden: YES ];
    [ activateProgress stopAnimation: sender ];
    
    [ alert addButtonWithTitle:  L10N( @"OK" ) ];
    [ alert setMessageText:      L10N( @"Error" ) ];
    [ alert setAlertStyle:       NSCriticalAlertStyle ];
    [ alert setMessageText:      L10N( @"Success" ) ];
    [ alert setInformativeText:  L10N( @"DeactivateSuccess" ) ];
        
    NSBeep();
    
    [ alert runModal ];
    [ alert release ];
    
    [ serialPanel orderOut: sender ];
    [ NSApp endSheet: serialPanel returnCode: 0 ];
}

- ( IBAction )cancelDeactivate: ( id )sender
{
    [ serialPanel orderOut: sender ];
    [ NSApp endSheet: serialPanel returnCode: 1 ];
}

- ( IBAction )uninstall: ( id )sender
{
    [ self performSelectorOnMainThread: @selector( removeFiles: ) withObject: sender waitUntilDone: YES ];
}

@end
