//
//  XLTDDMineSettingFeedBackVC.m
//  XLTaoMall
//
//  Created by Hawky on 2018/6/5.
//  Copyright © 2018年 Hawky. All rights reserved.
//

#import "XLTDDMineSettingFeedBackVC.h"

@interface XLTDDMineSettingFeedBackVC ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIScrollView *_scroll;

    UIView *_feedBackView;
    UILabel *_placeHodleLab;
    UITextView *_feedBackTV;
    UILabel *_stringLengthLab;

    UIView *_photoView;

    UIButton *_commitBut;
    NSMutableArray *_PhotoMArr;
    NSInteger imgcount;
}
@property (nonatomic,strong)NSMutableArray *PhotoMArr;
@end

@implementation XLTDDMineSettingFeedBackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUI];
}

#pragma mark - network
/*****  上传反馈意见 *****/
-(void)upLoadImage
{
    NSDictionary *params=@{@"sigen":[UserDefaultsManager getSigen],@"content":_feedBackTV.text};
    [XLNetworkManager POST:@"userFeedback_mob.shtml" WithParams:params AndView:self.navigationController.view constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (int i=0; i<self.PhotoMArr.count; i++) {
            UIImage *img=self.PhotoMArr[i];
            NSData *imageData=UIImageJPEGRepresentation(img, 0.5);
            NSString *key;
            if (i==0) {
                key=@"feedback_img1";
            }else if(i==1)
            {
                key=@"feedback_img2";
            }
            else if (i==2)
            {
                key=@"feedback_img3";
            }
            [formData appendPartWithFileData:imageData name:key fileName:key mimeType:@"image/png"];
        }
    } ForSuccess:^(NSDictionary *response) {
        [XLMBProgressHudTools showText:response[@"message"]];
        if ([response[@"status"] isEqualToString:@"10000"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self QurtButClick:nil];
            });
        }
    } AndFaild:^(NSError *error) {

    }];

}
#pragma mark - UI

/*****  初始化UI界面 *****/
-(void)SetUI
{
    _PhotoMArr=[NSMutableArray new];
    XLNaviView *navi=[[XLNaviView alloc] initWithMessage:@"反馈" ImageName:nil];
    typeof(self) weakSelf=self;
    navi.qurtBlock = ^{
        [weakSelf QurtButClick:nil];
    };
    [self.view addSubview:navi];

    _scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, KSafeAreaTopNaviHeight, KScreen_Width, KScreen_Height-KSafeAreaTopNaviHeight-KSafeAreaBottomHeight)];
    _scroll.backgroundColor=RGB(242, 242, 242);
    [self.view addSubview:_scroll];

    _feedBackView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 170)];
    _feedBackView.backgroundColor=[UIColor whiteColor];

    [_scroll addSubview:_feedBackView];

    _feedBackTV=[[UITextView alloc] initWithFrame:CGRectMake(CWidth(15), 8, KScreen_Width-CWidth(30), 124)];
    _feedBackTV.delegate=self;
    UIView *customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreen_Width, 0.01)];
    _feedBackTV.inputAccessoryView=customView;

    _feedBackTV.font=KNSFONT(14);
    [_feedBackView addSubview:_feedBackTV];

    _placeHodleLab=[[UILabel alloc] initWithFrame:CGRectMake(CWidth(15), 15, KScreen_Width-CWidth(30), 14)];
    _placeHodleLab.font=KNSFONT(14);
    _placeHodleLab.textColor=RGB(155, 155, 155);
    _placeHodleLab.text=@"请尽可能详细描述您的问题或建议，不少于10字。";
    [_feedBackView addSubview:_placeHodleLab];

    _stringLengthLab=[[UILabel alloc] initWithFrame:CGRectMake(0, 144, KScreen_Width-CWidth(15), 12)];
    _stringLengthLab.text=@"0/500";
    _stringLengthLab.font=KNSFONT(11);
    _stringLengthLab.textColor=RGB(102, 102, 102);
    _stringLengthLab.textAlignment=NSTextAlignmentRight;
    [_feedBackView addSubview:_stringLengthLab];

    _photoView=[[UIView alloc] initWithFrame:CGRectMake(0, 180, KScreen_Width, 110)];
    _photoView.backgroundColor=[UIColor whiteColor];
    [_scroll addSubview:_photoView];

    [self setPhotoView];

    _commitBut =[UIButton buttonWithType:UIButtonTypeCustom];
    _commitBut.frame=CGRectMake(CWidth(10), 320, KScreen_Width-CWidth(20), 44);
    _commitBut.userInteractionEnabled=NO;
    _commitBut.backgroundColor=RGBA(221, 172, 68,0.5);

    [_commitBut setTitle:@"提交" forState:UIControlStateNormal];
    [_commitBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _commitBut.titleLabel.font=KNSFONT(17);
    [_commitBut addTarget:self action:@selector(upLoadImage) forControlEvents:UIControlEventTouchUpInside];


    CALayer *layer = [CALayer layer];

    layer.frame = CGRectMake(CWidth(10), 320, KScreen_Width-CWidth(20), 44);

    layer.backgroundColor = RGBA(0, 0, 0,0.18).CGColor;

    layer.shadowOffset = CGSizeMake(5, 5);

    layer.shadowOpacity = 0.8;

    layer.cornerRadius = 22;
    [_scroll.layer addSublayer:layer];

    _commitBut.layer.cornerRadius=22;
    [_scroll addSubview:_commitBut];
}
/*****  设置凭证 *****/
-(void)setPhotoView
{
    [_photoView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    CGFloat width=CWidth(15);
    for (int i=0; i<_PhotoMArr.count; i++) {
        UIButton *but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame= CGRectMake(width, 15, 80, 80);
        [but setImage:_PhotoMArr[i] forState:UIControlStateNormal];
        [_photoView addSubview:but];
        UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame=CGRectMake(65, -5, 20, 20);
        [delete setImage:KImage(@"XL_Setting_FeedBack_btnClear") forState:UIControlStateNormal];
        delete.tag=i+1000;
        [delete addTarget:self action:@selector(deletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [but addSubview:delete];
        width+=80+15;
    }
    if (_PhotoMArr.count<3) {
        UIButton * but=[UIButton buttonWithType:UIButtonTypeCustom];
        but.frame=CGRectMake(width, 15, 80, 80);
        [but setBackgroundImage:KImage(@"XL_Setting_FeedBack_kuang") forState:UIControlStateNormal];
        [_photoView addSubview:but];
        [but setImage:KImage(@"XL_Setting_FeedBack_camara") forState:UIControlStateNormal];
        [but setTitleColor:RGB(155, 155, 155) forState:UIControlStateNormal];
        [but setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 10, 0)];
        [but setTitleEdgeInsets:UIEdgeInsetsMake(30, 0, 0, 23)];
        but.titleLabel.font=KNSFONT(11);
        [but setTitle:[NSString stringWithFormat:@"%lu/3",_PhotoMArr.count] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(addPhoto:) forControlEvents:UIControlEventTouchUpInside];

    }
}

#pragma mark - events
/*****  添加图片 *****/
-(void)addPhoto:(UIButton *)sender
{
    //创建UIAlertController是为了让用户去选择照片来源,拍照或者相册.
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:0];
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;

    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction *action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];

    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"从相册选取" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action)
                                   {
                                       //这里可以不写代码
                                   }];

    //用来判断来源 Xcode中的模拟器是没有拍摄功能的,当用模拟器的时候我们不需要把拍照功能加速
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])

    {

        [alertController addAction:okAction];
        [alertController addAction:cancelAction];
        [alertController addAction:photoAction];

    }

    else
    {
        [alertController addAction:photoAction];
        [alertController addAction:cancelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

/*****  删除某一张图片 *****/
-(void)deletePhoto:(UIButton *)sender
{
    [_PhotoMArr removeObjectAtIndex:sender.tag-1000];
    [self setPhotoView];
}


-(void)textViewDidChange:(UITextView *)textView
{
    _placeHodleLab.hidden=YES;

    _stringLengthLab.text=[NSString stringWithFormat:@"%lu/500",textView.text.length];
    if (textView.text.length>=500) {
        textView.text=[textView.text substringToIndex:500];
        _stringLengthLab.text=@"500/500";
    }

    if (textView.text.length<10) {
        _commitBut.userInteractionEnabled=NO;
        _commitBut.backgroundColor=RGBA(221, 172, 68,0.5);
    }else
    {
        _commitBut.backgroundColor = RGB(221, 172, 68);
        _commitBut.userInteractionEnabled = YES;
    }

}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _placeHodleLab.hidden=YES;

}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if (textView.text.length==0) {
        _placeHodleLab.hidden=NO;
    }else
    {
        _placeHodleLab.hidden=YES;
    }

}

/*****  重写父类的返回方法 *****/
-(void)QurtButClick:(UIButton *)sender
{
    if (_feedBackTV.text.length==0&&_PhotoMArr.count==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else
    {
        UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:@"马上就填写完了， 确定要离开？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"我不填了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"继续填写" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - 选择图片协议
/*****
 *
 *  Description  info中保存着选择的图片信息，拍照完成选中也走这个方法
 *
 ******/
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //UIImagePickerControllerOriginalImage; //原图
    //UIImagePickerControllerEditedImage;//裁剪的图
    //UIImagePickerControllerCropRect;//获取图片裁剪后 剩下的图

    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [self.PhotoMArr addObject:image];
    NSLog(@"======image======%@======%@",image,info);
    [self setPhotoView];
    [picker dismissViewControllerAnimated:YES completion:^{

    }];
}
/*****
 *
 *  Description 没有选择图片直接取消走的这个方法
 *
 ******/
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消");
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark - lazyLoading
-(NSMutableArray *)PhotoMArr
{
    if (!_PhotoMArr) {
        _PhotoMArr=[NSMutableArray new];
    }
    return _PhotoMArr;
}


@end
