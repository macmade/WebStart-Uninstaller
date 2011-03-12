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

#define NSSTR( str )        [ NSString stringWithCString: str encoding: NSASCIIStringEncoding ]
#define CSTR( str )         ( char * )[ str cStringUsingEncoding: NSASCIIStringEncoding ]
#define CSTR_UTF8( str )    ( char * )[ str cStringUsingEncoding: NSUTF8StringEncoding ]
#define STRF( ... )         [ NSString stringWithFormat: __VA_ARGS__ ]
#define L10N( label )       NSLocalizedString( label, nil )
