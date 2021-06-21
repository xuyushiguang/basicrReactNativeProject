//
//  QRedView.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/21.
//

#import "QRedView.h"

@interface QRedView ()

@property(nonatomic,strong)UILabel *label;

@end

@implementation QRedView

- (instancetype)init
{
  self = [super init];
  if (self) {
    self.label = [[UILabel alloc] init];
    self.label.backgroundColor = [UIColor blueColor];
    self.label.text = @"111111";
    [self addSubview:self.label];
    
    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:100]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
  }
  return self;
}

- (void)setStr:(NSString *)str
{
  _str = str;
  self.label.text = str;
}

@end
