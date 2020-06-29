import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/card_example_model.dart';
import 'package:myrscm/src/model/tab_model.dart';
import 'package:myrscm/src/view/widget/card_billing_status.dart';
import 'package:myrscm/src/view/widget/card_billing_with_detail.dart';
import 'package:myrscm/src/view/widget/circle_point_detail_billing.dart';
import 'package:myrscm/src/view/widget/widget_no_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import 'layout_billing_detail.dart';

class VerticalLayoutBilling extends StatefulWidget {

  final BillingModel data;

  VerticalLayoutBilling(this.data);

  @override
  _VerticalLayoutBillingState createState() => _VerticalLayoutBillingState(data);
}

class _VerticalLayoutBillingState extends State<VerticalLayoutBilling> with SingleTickerProviderStateMixin {
  final BillingModel data;
  TabController controller;
  NumberFormat formatter = new NumberFormat("#,###");
  int tabLength;
  
  _VerticalLayoutBillingState(this.data);

  @override
  void initState() {
    tabLength = data.data.tab.length;
    controller = new TabController(length: tabLength, vsync: this);
    print('tablength $tabLength');
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: defaultAppbarColor,
        title: Text('Tagihan', style: TextStyle(color: defaultAppbarContentColor)),
      ),
      body: tabLength > 0 ?
        NestedScrollView(
          headerSliverBuilder: (context, isScrolled){
            return <Widget>[
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(padding: EdgeInsets.fromLTRB(15, 20, 0, 0), child: Text('Rangkuman', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
                  Container(padding: EdgeInsets.fromLTRB(15, 10, 0, 10), child: Text('Poin-poin informasi mengenai tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Card(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  CirclePointDetailBilling(title: 'Total', content: 'Rp ${formatter.format(int.parse(data.data.totalSummary))}', icon: Icons.receipt, color: Colors.blueAccent),
                                  CirclePointDetailBilling(title: 'Deposit', content: 'Rp ${formatter.format(int.parse(data.data.totalDeposit))}', icon: Icons.arrow_upward, color: Colors.greenAccent),
                                  CirclePointDetailBilling(title: 'Tagihan', content: 'Rp ${formatter.format(int.parse(data.data.totalTagihan))}', icon: Icons.arrow_downward, color: Colors.deepOrangeAccent),
                                ],
                              ),
                            ),
                            Container(
                                child: ExpansionTile(
                                  title: Text(
                                      'More detail',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 14
                                    ),
                                  ),
                                  children: <Widget>[
                                    WidgetCardBillingDetail(data.data.tab, data.data.totalSummary),
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                  Container(padding: EdgeInsets.fromLTRB(15, 20, 0, 0), child: Text('Detail Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
                  Container(padding: EdgeInsets.fromLTRB(15, 10, 0, 10), child: Text('Rincian detail dari poin-poin informasi tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
                ]),
              ),
              SliverPersistentHeader(
                delegate:_SliverAppBarDelegate(
                    TabBar(
                      isScrollable: true,
                      controller: controller,
                      tabs: generateTabHeader(data.data.tab),
                      indicatorColor: Colors.red,
                    )
                ),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
              controller: controller,
              children: generateTabView(data.data.tab),
            ),
      )
          :
      ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Container(padding: EdgeInsets.fromLTRB(15, 20, 0, 0), child: Text('Rangkuman', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
          Container(padding: EdgeInsets.fromLTRB(15, 10, 0, 10), child: Text('Poin-poin informasi mengenai tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          CirclePointDetailBilling(title: 'Total', content: 'Rp ${formatter.format(int.parse(data.data.totalSummary))}', icon: Icons.receipt, color: Colors.white),
                          CirclePointDetailBilling(title: 'Deposit', content: 'Rp ${formatter.format(int.parse(data.data.totalDeposit))}', icon: Icons.arrow_upward, color: Colors.greenAccent),
                          CirclePointDetailBilling(title: 'Tagihan', content: 'Rp ${formatter.format(int.parse(data.data.totalTagihan))}', icon: Icons.arrow_downward, color: Colors.deepOrangeAccent),
                        ],
                      ),
                    ),
                  ],
                )
            ),
          ),
          Container(padding: EdgeInsets.fromLTRB(15, 20, 0, 0), child: Text('Detail Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
          Container(padding: EdgeInsets.fromLTRB(15, 10, 0, 10), child: Text('Rincian detail dari poin-poin informasi tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
          WidgetNoData(title: "Data tidak ditemukan", subtitle: "Kami tidak dapat menemukan detail tagihan anda", isBack: true)
        ],
      )
    );
  }

  List<Widget> generateTabHeader(List<TabModel> dataTabModel){
    List<Widget> widget = [];
    for(int i = 0; i < dataTabModel.length; i++){
      widget.add(Tab(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            dataTabModel[i].content,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w300,
              letterSpacing: 0.5
            ),
          ),
        ),
      ));
    }
    return widget;
  }

  List<Widget> generateTabView(List<TabModel> dataTabModel ){
    List<Widget> widget = [];
    for(int i = 0; i < dataTabModel.length; i++){
      widget.add(LayoutBillingDetail(dataTabModel[i]));
    }
    return widget;
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return _tabBar != oldDelegate._tabBar;
  }

}

class HorizontalLayoutBilling extends StatefulWidget {

  final BillingModel data;

  HorizontalLayoutBilling(this.data);

  @override
  _HorizontalLayoutBillingState createState() => _HorizontalLayoutBillingState();
}

class _HorizontalLayoutBillingState extends State<HorizontalLayoutBilling> with SingleTickerProviderStateMixin {

  TabController controller;
  List<TabModel> dataTabModel = [];

  @override
  void initState() {
    controller = new TabController(length: dataTabModel.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tagihan'),),
      body: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                flex: 1,
                child:  CustomScrollView(
                  slivers: <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        Container(padding: EdgeInsets.all(10), child: Text('Rangkuman:'),),
                        WidgetCardBillingDetail(widget.data.data.tab, widget.data.data.totalSummary),
                        WidgetCardBillingStatus(widget.data.data.totalDeposit,widget.data.data.totalTagihan),
                        //Container(padding: EdgeInsets.all(10), child: Text('Detail Tagihan:'),),
                      ]),
                    ),
                  ],
                ),
            ),
            Expanded(
              flex:1,
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      // Container(padding: EdgeInsets.all(10), child: Text('Rangkuman:'),),
                      // WidgetCardBillingDetail(dataTabModel),
                      //WidgetCardBillingStatus(data.paid,data.unpaid),
                      Container(padding: EdgeInsets.all(10), child: Text('Detail Tagihan:'),),
                    ]),
                  ),
                   SliverPersistentHeader(
                      delegate:_SliverAppBarDelegate(
                          TabBar(
                            isScrollable: true,
                            controller: controller,
                            tabs: generateTabHeader(),
                            indicatorColor: Colors.red,
                          )
                      ),
                      pinned: true,
                    ),
                    SliverFillRemaining(
                      child: TabBarView(
                        controller: controller,
                        children: generateTabView(),
                      ),
                    ),
                ],
              )
            )
          ]
      ),
    );
  }

  List<Widget> generateTabHeader(){
    List<Widget> widget = [];
    for(int i = 0; i < dataTabModel.length; i++){
      widget.add(Tab(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue[900],
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            dataTabModel[i].content,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14
            ),
          ),
        ),
      ));
    }
    return widget;
  }
  List<Widget> generateTabView(){
    List<Widget> widget = [];
    for(int i = 0; i < dataTabModel.length; i++){
      widget.add(LayoutBillingDetail(dataTabModel[i]));
    }
    return widget;
  }
  List<CardExample> generateData(int limit){
    List<CardExample> list = [];
    for(var i = 1; i <= limit; i++){
      list.add(new CardExample(title: 'Content $i', description: 'Lorem ipsum dolor sir amet', price: '350000',date: '27-07-02'));
    }
    return list;
  }
}
