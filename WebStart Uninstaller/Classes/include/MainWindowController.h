/*******************************************************************************
 * Copyright (c) 2011, Jean-David Gadina <macmade@eosgarden.com>
 * All rights reserved
 ******************************************************************************/
 
/* $Id$ */

/*!
 * @header      MainWindowController.h
 * @copyright   eosgarden 2011 - Jean-David Gadina <macmade@eosgarden.com>
 * @abstract    ...
 */

/*!
 * @class       MainWindowController
 * @abstract    ...
 */
@interface MainWindowController: NSWindowController
{
@protected
    
    NSProgressIndicator * progress;
    NSProgressIndicator * activateProgress;
    NSButton            * uninstallButton;
    NSButton            * quitButton;
    NSButton            * keepWebData;
    NSPanel             * serialPanel;
    NSTextField         * serialField;
    
@private
    
    id r1;
    id r2;
}

@property( nonatomic, retain ) IBOutlet NSProgressIndicator * progress;
@property( nonatomic, retain ) IBOutlet NSProgressIndicator * activateProgress;
@property( nonatomic, retain ) IBOutlet NSButton            * uninstallButton;
@property( nonatomic, retain ) IBOutlet NSButton            * quitButton;
@property( nonatomic, retain ) IBOutlet NSButton            * keepWebData;
@property( nonatomic, retain ) IBOutlet NSPanel             * serialPanel;
@property( nonatomic, retain ) IBOutlet NSTextField         * serialField;

- ( IBAction )uninstall: ( id )sender;
- ( IBAction )enterSerial: ( id )sender;
- ( IBAction )cancelDeactivate: ( id )sender;
- ( IBAction )deactivate: ( id )sender;

@end
