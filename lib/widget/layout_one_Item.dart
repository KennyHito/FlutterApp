import 'dart:math';

import 'package:flutter/material.dart';

Widget LayoutOneItem() {
  return Container(
    margin: EdgeInsets.only(top: 10, left: 10, right: 10),

    ///卡片包装
    child: Card(
        color: Colors.white, //背景色

        ///增加点击效果
        child: FlatButton(
            onPressed: () {
              print("点击了哦");
            },
            child: Padding(
              padding: EdgeInsets.only(
                  left: 0.0, top: 10.0, right: 10.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ///文本描述
                  Container(
                      child: Text(
                        "追寻红色足迹，感悟初心使命。即日起，本报推出“新思想引领新征程·红色足迹”专栏，"
                        "跟随习近平总书记的红色足迹，访当事人、忆当年事，重温总书记的重要论述和重要指示精神，"
                        "生动回顾红色圣地光荣的革命历史、优秀的革命传统、伟大的革命精神，充分反映当地干部群众牢记总书记嘱托，"
                        "大力发扬红色传统、传承红色基因，艰苦奋斗改变发展面貌、不断创造更加幸福美好生活的生动实践，凝聚迈进新征程、奋进新时代的强大力量。",
                        style: TextStyle(
                          color: Colors.black, //文字颜色
                          fontSize: 16.0, //文字大小
                        ),

                        ///最长三行，超过 ... 显示
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                      ),
                      margin: EdgeInsets.only(top: 6.0, bottom: 2.0),
                      alignment: Alignment.topLeft),
                  Padding(padding: EdgeInsets.all(10.0)),

                  ///三个平均分配的横向图标文字
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      getBottomItem(
                          Icons.star, "1000", MainAxisAlignment.start),
                      getBottomItem(
                          Icons.link, "1000", MainAxisAlignment.center),
                      getBottomItem(
                          Icons.subject, "1000", MainAxisAlignment.end),
                    ],
                  ),
                ],
              ),
            ))),
  );
}

///返回一个居中带图标和文本的Item
Widget getBottomItem(
    IconData icon, String text, MainAxisAlignment mainAxisAlignment) {
  ///充满 Row 横向的布局
  return Expanded(
    flex: 1,
    child: Container(
      ///横向布局
      child: Row(
        ///主轴居中,即是横向居中
        mainAxisAlignment: mainAxisAlignment,

        ///大小按照最大充满
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          ///一个图标，大小16.0，灰色
          Icon(
            icon,
            size: 16.0,
            color: Colors.grey,
          ),

          ///间隔
          Padding(padding: EdgeInsets.only(left: 5.0)),

          ///显示文本
          Text(
            text,
            //设置字体样式：颜色灰色，字体大小14.0
            style: new TextStyle(color: Colors.grey, fontSize: 14.0),
            //超过的省略为...显示
            overflow: TextOverflow.ellipsis,
            //最长一行
            maxLines: 1,
          ),
        ],
      ),
    ),
  );
}
