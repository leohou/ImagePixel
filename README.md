# ImagePixel
根据图片获取区域获取反色值 并把反色值赋值给其他图片
使用demo 

  
    UIImageView * _view = [[UIImageView alloc]initWithFrame:CGRectMake(_x,  _y , _img.size.width, _img.size.height)]; 
    UIImage *image = [Utils ct_imageFromImage:self.bgImage.image inRect:CGRectMake(_x, _y, _bottomWidth, _bottomHeight)];
    [Utils getPix:image andPixArray:pixArray];
    UIImage *resltImag = [Utils getResultImageWit:pixArray andBeginImage:_img];
    _view.image = resltImag;
    [self.view addSubview:_view];
