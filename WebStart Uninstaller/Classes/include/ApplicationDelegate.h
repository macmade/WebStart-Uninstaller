/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

@class MainWindowController;

@interface ApplicationDelegate: NSObject < NSApplicationDelegate >
{
@protected
    
    MainWindowController * mainWindowController;
    BOOL                   uninstalling;
    
@private
    
    NSWindow * window;
}

@property( assign                          ) IBOutlet NSWindow * window;
@property( assign, getter = isUninstalling )          BOOL       uninstalling;

@end
