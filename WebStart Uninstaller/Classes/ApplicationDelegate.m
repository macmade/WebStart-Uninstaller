/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @file        
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

#import "ApplicationDelegate.h"
#import "MainWindowController.h"

@implementation ApplicationDelegate

@synthesize window;
@synthesize uninstalling;

- ( void )applicationDidFinishLaunching: ( NSNotification * )notification
{
    mainWindowController = [ MainWindowController new ];
    
    ( void )notification;
    
    [ mainWindowController.window center  ];
    [ mainWindowController showWindow: nil ];
    [ NSApp activateIgnoringOtherApps: YES ];
}

- ( NSApplicationTerminateReply )applicationShouldTerminate: ( NSApplication * )sender
{
    NSAlert * alert;
    
    if( uninstalling == YES )
    {
        alert = [ [ NSAlert alloc ] init ];
        
        [ alert addButtonWithTitle:  L10N( @"OK" ) ];
        [ alert setMessageText:      L10N( @"UninstallProgress" ) ];
        [ alert setInformativeText:  L10N( @"UninstallProgressText" ) ];
        [ alert setAlertStyle: NSCriticalAlertStyle ];
        
        NSBeep();
        
        [ alert runModal ];
        [ alert release ];
        
        return NSTerminateCancel;
    }
    
    ( void )sender;
    
    [ mainWindowController release ];
    
    return NSTerminateNow;
}

@end
