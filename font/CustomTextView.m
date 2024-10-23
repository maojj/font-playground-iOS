#import "CustomTextView.h"

@implementation CustomTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueColor]; // 确保背景颜色是透明的，以便我们可以自定义背景颜色
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    float ratio = 20.f;
    
    
    // 加载自定义字体
    UIFont *font = [UIFont fontWithName:@"Gasoek One" size:10.f];
    if (!font) {
        NSLog(@"Failed to load font: CustomFontName");
        return;
    }
    
    // 创建文本属性
    NSString *text = @"Rag";
    UIColor *textColor = [UIColor blackColor];
    NSDictionary *attributes = @{
        NSFontAttributeName: font,
        NSForegroundColorAttributeName: textColor
    };
    
    // 计算文本尺寸
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    // 计算文本绘制位置
    CGPoint textPosition = CGPointMake(5, (rect.size.height - textSize.height * ratio) / 2);
    
    // 设置浅灰色背景，仅填充放大后的文本区域
    UIColor *lightGrayColor = [UIColor lightGrayColor];
    CGRect textBackgroundRect = CGRectMake(textPosition.x, textPosition.y, textSize.width * ratio, textSize.height * ratio);
    [lightGrayColor setFill];
    UIRectFill(textBackgroundRect);
    
    // 获取当前图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 保存当前图形上下文状态
    CGContextSaveGState(context);
    
    // 应用缩放变换
    CGContextTranslateCTM(context, textPosition.x, textPosition.y);
    CGContextScaleCTM(context, ratio, ratio);
    CGContextTranslateCTM(context, -textPosition.x, -textPosition.y);
    
    // 绘制文本
    [text drawAtPoint:textPosition withAttributes:attributes];
    
    // 恢复图形上下文状态
    CGContextRestoreGState(context);
    
    // 绘制 textBackgroundRect 内每 10 像素的一条横线
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextSetLineWidth(context, 1.0);
    
    for (CGFloat y = textBackgroundRect.origin.y; y <= CGRectGetMaxY(textBackgroundRect); y += ratio) {
        CGContextMoveToPoint(context, textBackgroundRect.origin.x, y);
        CGContextAddLineToPoint(context, CGRectGetMaxX(textBackgroundRect), y);
        CGContextStrokePath(context);
    }
    
    
    // 重新计算基线的位置（注意转换坐标系）
    CGFloat baselineY = textPosition.y + font.ascender * ratio;
    CGContextMoveToPoint(context, textPosition.x, baselineY);
    CGContextAddLineToPoint(context, textPosition.x + textSize.width * ratio, baselineY);
    [[UIColor blueColor] setStroke];
    
    CGContextStrokePath(context);
}


@end
