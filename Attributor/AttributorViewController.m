//
//  AttributorViewController.m
//  Attributor
//
//  Created by Horace Williams on 3/28/14.
//  Copyright (c) 2014 WoracesWorkshop. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *header;
@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self styleOutlineButton];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addTextChangeListener];
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self usePreferredFontSettings]; //sync up with the world vis a vis font settings
    [self removeTextChangeListener];
    
}

- (void) styleOutlineButton
{
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:self.outlineButton.currentTitle];
    [title setAttributes: @{NSStrokeWidthAttributeName: @6,
                            NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0, [title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];

}

- (void) addTextChangeListener
{
    NSNotificationCenter *settingsNotifCenter = [NSNotificationCenter defaultCenter];
    [settingsNotifCenter addObserver:self
                            selector:@selector(preferredFontSizeDidChange:)
                                name:UIContentSizeCategoryDidChangeNotification
                              object:nil];
}

- (void) removeTextChangeListener
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (void) preferredFontSizeDidChange: (NSNotification *)notification
{
    [self usePreferredFontSettings];
}

- (void) usePreferredFontSettings
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    self.header.font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}


- (IBAction)changeBodySelectionColor:(UIButton *)sender
{
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
}
- (IBAction)outlineBodySelection {
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]} range:self.body.selectedRange];
}
- (IBAction)removeOutlineFromBodySelection {
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName range:self.body.selectedRange];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
