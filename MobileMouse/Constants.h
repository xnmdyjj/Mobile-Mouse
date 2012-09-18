//
//  Constants.h
//  MobileMouse
//
//  Created by Yu Jianjun on 8/29/12.
//  Copyright (c) 2012 Yu Jianjun. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SERVER_PORT 1987

#define SERVER_DESKTOP_PORT 1988

#define TAG_SERVER_SCREEN_INFO 0

#define TAG_WRITE_MOBILE_INFO 1

#define TAG_WRITE_MOVEADD_MESSAGE 2

#define TAG_WRITE_TAP_MESSAGE 3

#define TAG_WRITE_DOSORSHELL_MESSAGE 4

#define TAG_WRITE_LOCKSCREEN_MESSAGE 5

#define TAG_WRITE_KEYDOWN_MESSAGE 6

#define TAG_WRITE_PHONE_DIMEN 7

#define TAG_READ_IMAGE_SIZE 8

#define TAG_WRITE_MOVE_MOUSE_MESSAGE 9

#define NO_TIME_OUT -1

extern NSString *const COMMAND_TAG;

extern NSString *const DOS_COMMANT_TAG;

extern NSString *const STRING_COMMAND_PPT_F5;
extern NSString *const STRING_COMMAND_PPT_ESC;
extern NSString *const STRING_COMMAND_PPT_PRE;
extern NSString *const STRING_COMMAND_PPT_NEX;
extern NSString *const STRING_COMMAND_PPT_UP;
extern NSString *const STRING_COMMAND_PPT_DOWN;
extern NSString *const STRING_COMMAND_LOCK_SCREEN;


extern NSString *const STRING_COMMAND_ENTER;
extern NSString *const STRING_COMMAND_CLOSE;
extern NSString *const STRING_COMMAND_RIGHT_CLICK;
extern NSString *const STRING_COMMAND_STOP_IMG_SEND;
extern NSString *const STRING_COMMMAND_START_IMG_SEND;
extern NSString *const STRING_COMMAND_DOUBLE_CLICK;


@interface Constants : NSObject

@end
