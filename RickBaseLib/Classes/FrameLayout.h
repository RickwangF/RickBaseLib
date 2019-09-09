//
//  FrameLayout.h
//  StringDemo
//
//  Created by Rick on 2019/9/9.
//  Copyright © 2019 Rick. All rights reserved.
//

#ifndef FrameLayout_h
#define FrameLayout_h

#include <CoreGraphics/CGGeometry.h>

CG_INLINE CGRect
CGRectCenterMake(CGFloat centerX, CGFloat centerY, CGFloat width, CGFloat height)
{
    CGRect rect;
    rect.origin.x = centerX - width * 0.5;
    rect.origin.y = centerY - height * 0.5;
   rect.size.width = width; rect.size.height = height;
    return rect;
}


#endif /* FrameLayout_h */
