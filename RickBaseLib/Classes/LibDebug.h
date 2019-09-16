//
//  LibDebug.h
//  StringDemo
//
//  Created by Rick on 2019/9/16.
//  Copyright © 2019 Rick. All rights reserved.
//

#ifndef LibDebug_h
#define LibDebug_h

#ifdef DEBUG
# define Log(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define Log(...);
#endif

#endif /* LibDebug_h */
