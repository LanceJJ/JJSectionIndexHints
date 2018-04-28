# JJSectionIndexHints


## 自定义通讯录右侧字母索引
 
 
* 1.可以修改索引高度，填充整个tableview
* 2.滑动点击索引时，屏幕中间字母提示


## 使用方法

* 导入JJSectionIndexHints文件，tableview添加分类方法即可

```objc
    //添加索引显示
    //_contactData.contactIndex.allKeyArray 为索引的数据源（A-Z的字母）
    [self.tableView addSectionIndexWithAllKeyArray:_contactData.contactIndex.allKeyArray tintColor:nil font:nil];
```	

## 实现原理

* 实现原理还是比较简单的，给tableview添加分类，在分类中，给tableview的superview添加一个带有滑动手势的view，A-Z的字母索引添加到该view上，之后通过滑动手势，计算出手指的位置，再根据手指的位置找到相应的索引字母，最后将找到的字母在中间的label显示出来即可，抬起手指时，再隐藏中间的label


## 效果图

![](https://github.com/LanceJJ/JJSectionIndexHints/raw/master/JJSectionIndexHints/29B025749031BB7EAAE06009ADD9B267.png)
![](https://github.com/LanceJJ/JJSectionIndexHints/raw/master/JJSectionIndexHints/750C132F7317FE7DC7DBBE5E8CFF5460.png)
