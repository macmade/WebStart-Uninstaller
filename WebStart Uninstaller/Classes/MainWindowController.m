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
    {
        [ ESellerate setPublisherId:  @"PUB9310734649" ];
        [ ESellerate setActivationId: @"ACT7252581145:CT2UD7-PLFY-JN1TXT-0FWE-3QP1JK-5WQRF0-1Z0W-DAAU3V-J89E-EDCYRT" ];
        [ ESellerate setSerialKey:    @"NXJK-XYBM-VHH6-329P-XCY5" ];
    }
    
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
    OSStatus  status;
    
    [ activateProgress setHidden: NO ];
    [ activateProgress startAnimation: nil ];
    
    status = [ [ ESellerate sharedInstance ] deactivateSerialNumber: [ serialField stringValue ] ];
    alert  = [ [ NSAlert alloc ] init ];
    
    [ activateProgress setHidden: YES ];
    [ activateProgress stopAnimation: sender ];
    
    [ alert addButtonWithTitle:  L10N( @"OK" ) ];
    [ alert setMessageText:      L10N( @"Error" ) ];
    [ alert setAlertStyle: NSCriticalAlertStyle ];
    
    switch( status )
    {
        case E_SUCCESS:
            
            [ alert setMessageText:      L10N( @"Success" ) ];
            [ alert setInformativeText:  L10N( @"DeactivateSuccess" ) ];
            break;
            
        case E_ACTIVATESN_UNKNOWN_SERVER_ERROR:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_UNKNOWN_SERVER_ERROR" ) ];
            break;
            
        case E_ACTIVATESN_UNKNOWN_ACTIVATION_KEY:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_UNKNOWN_ACTIVATION_KEY" ) ];
            break;
            
        case E_ACTIVATESN_UNKNOWN_SN:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_UNKNOWN_SN" ) ];
            break;
            
        case E_ACTIVATESN_IMPROPER_USAGE:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_IMPROPER_USAGE" ) ];
            break;
            
        case E_ACTIVATESN_BLACKLISTED_SN:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_BLACKLISTED_SN" ) ];
            break;
            
        case E_ACTIVATESN_INVALID_ORDER:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_INVALID_ORDER" ) ];
            break;
            
        case E_ACTIVATESN_LIMIT_MET:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_LIMIT_MET" ) ];
            break;
            
        case E_ACTIVATESN_NOT_UNIQUE:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_NOT_UNIQUE" ) ];
            break;
            
        case E_ACTIVATESN_FINALIZATION_ERROR:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_FINALIZATION_ERROR" ) ];
            break;
            
        default:
            
            [ alert setInformativeText:  L10N( @"E_ACTIVATESN_UNKNOWN_SERVER_ERROR" ) ];
            break;
    }
    
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
