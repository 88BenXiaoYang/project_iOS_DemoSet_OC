//
//  CommonDefine.h
//  project_iOS_DemoSet_OC
//
//  Created by srt on 2019/1/27.
//  Copyright © 2019 by. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define Ref_WeakSelf(type) __weak typeof(type) weak##type = type;

#define BLOCK_EXEC(block, ...) if (block) { block(__VA_ARGS__); };
#define SIZE_ONE_PX (1.0f / [UIScreen mainScreen].scale)

#define kRandomColor [UIColor colorWithRed:random()%256/255.0 green:random()%256/255.0 blue:random()%256/255.0 alpha:1.0];

#endif /* CommonDefine_h */
