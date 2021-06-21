//
//  QRedView.m
//  BasicReactNativeProject
//
//  Created by xingye yang on 2021/6/21.
//

#import "QRedView.h"

@interface QRedView ()

@property(nonatomic,strong)UILabel *label;

@property(nonatomic,strong)UIButton *button;

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
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:@"button" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClock) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    self.button.backgroundColor = [UIColor blueColor];
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.5 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:self.button attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    
  }
  return self;
}

-(void)buttonClock
{
  if (_onClick) {
    _onClick(@{@"press":@"yes"});
  }
}

- (void)setStr:(NSString *)str
{
  _str = str;
  self.label.text = str;
}
- (void)setAge:(NSString *)age
{
  _age = age;
}
@end
