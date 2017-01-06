//
//  TMSCollectionViewController.h
//  Tianmushan
//
//  Created by shushaoyong on 2016/10/26.
//  Copyright © 2016年 踏潮. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TMSBaseViewController.h"
#import "TMSHomeMode.h"

@interface TMSMYCollectionViewController : TMSBaseViewController

/**是否需要添加pan手势 以禁用右滑手势效果*/
@property(nonatomic,assign)BOOL panEabled;

@end

/***布局对象**/
@interface TMSMyContentViewLayout : UICollectionViewFlowLayout

@end


/***头部view*/
@interface TMSMYCollectionViewHeader : UICollectionReusableView

/**标题*/
@property(nonatomic,weak)UILabel *lable;

@end



@class TMSMYCollectionViewCell;

@protocol TMSMYCollectionViewCellDelegate <NSObject>

@optional
/***长按方法*/
- (void)mYCollectionViewCellDidLongpress:(TMSMYCollectionViewCell*)cell;

/***删除按钮的点击*/
- (void)mYCollectionViewCellDidDeleteClicked:(TMSMYCollectionViewCell*)cell item:(TMSHomeMode*)item;

@end

/***cell*/
@interface TMSMYCollectionViewCell : UICollectionViewCell

/**删除按钮*/
@property(nonatomic,weak)UIButton *deleteButton;

/**模型*/
@property(nonatomic,strong)TMSHomeMode *model;

/**delegate*/
@property(nonatomic,weak)id<TMSMYCollectionViewCellDelegate> delegate;


@end
