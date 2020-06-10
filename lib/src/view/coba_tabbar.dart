import 'package:myrscm/src/view/layout/dynamic_view_tab.dart';
import 'package:myrscm/src/model/card_example_model.dart';
import 'package:myrscm/src/model/tab_model.dart';
import 'package:myrscm/src/view/widget/card_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CobaTabBar extends StatefulWidget {
  @override
  _CobaTabBarState createState() => _CobaTabBarState();
}

class _CobaTabBarState extends State<CobaTabBar> with SingleTickerProviderStateMixin {

  TabController controller;
  List<TabModel> data = [];

  @override
  void initState() {
    for(int i = 1; i <= 10; i++){
      data.add(new TabModel(id: i.toString(), content: 'Page $i', data: generateData(i)));
    }
    controller = new TabController(length: data.length, vsync: this,);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return newRender2();
  }

  Widget newRender(){
    return Scaffold(
      appBar: AppBar(
        title: SafeArea(
          child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                CardProfile('1','k'),
                Container(
                  padding: EdgeInsets.fromLTRB(4,8,4,4),
                  child: Text('Rangkuman tagihan'),
                ),
              ]
          ),
        ),
        //Text('Titlebar'),
        bottom: TabBar(
          isScrollable: true,
          controller: controller,
          tabs: generateTabHeader(),
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: generateTabView(),
      ),
    );
  }

  Widget newRender2(){
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.grey,
            floating: false,
            snap: false,
            pinned: true,
            //set icon on left side
            leading: Icon(Icons.arrow_back, color:Colors.black),
            //title on appbar
            title: Text('CustomScrollView Sliver', style: TextStyle(color: Colors.black), textAlign: TextAlign.center,),
            //set icon on right side
            actions: <Widget>[
              Icon(Icons.person, color: Colors.black,),
              Icon(Icons.more_vert, color: Colors.black,),
              SizedBox(width: 10,)
            ],
          ),
          SliverPersistentHeader(
            delegate: CustomSliverDelegate(
              expandedHeight: (MediaQuery.of(context).size.height * .3) - kToolbarHeight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: CardProfile('1','k'),
                color: Colors.grey,),
            ),
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate: CustomSliverDelegate(
              expandedHeight: (MediaQuery.of(context).size.height * .3) - kToolbarHeight,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: CardProfile('1','k'),
                color: Colors.grey,),
            ),
            pinned: true,
          ),
          SliverPersistentHeader(
            delegate:_SliverAppBarDelegate(
                TabBar(
                  isScrollable: true,
                  controller: controller,
                  tabs: generateTabHeader(),
                  onTap: (index){
                    print(index);
                  },
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
      ),
    );
  }

  Widget allRender(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Titlebar'),
      ),
      body: halfRender(),
    );
  }

  Widget halfRender(){
    return Container(
      padding: EdgeInsets.all(16),
      child:
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
              padding: EdgeInsets.all(16),
              child: Text('Title')),
          Container(
            padding: EdgeInsets.all(8),
            child: TabBar(
                isScrollable: true,
                controller: controller,
                tabs: generateTabHeader()
            ),
          ),
          Expanded(
            //padding: EdgeInsets.all(8),
            child: TabBarView(
              controller: controller,
              children: generateTabView(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> generateTabHeader(){
    List<Widget> widget = [];
    for(int i = 0; i < data.length; i++){
      widget.add(Tab(
        child: Container(
          child: Text(
            data[i].content,
            style: TextStyle(
                color: Colors.blue[900],
                fontSize: 18
            ),
          ),
        ),
      ));
    }


    return widget;
  }

  List<Widget> generateTabView(){
    List<Widget> widget = [];
    for(int i = 0; i < data.length; i++){
      widget.add( SingleChildScrollView(child: DynamicViewTab(data[i]), scrollDirection: Axis.vertical,));
      //widget.add( DynamicViewTab(data[i]) );
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

class CustomSliverDelegate extends SliverPersistentHeaderDelegate{

  final double expandedHeight;
  final Widget child;

  CustomSliverDelegate({this.expandedHeight, this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => expandedHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
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
      color: Colors.grey,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }

}