import 'package:myrscm/constant.dart';
import 'package:myrscm/src/model/billing_model.dart';
import 'package:myrscm/src/model/tab_model.dart';
import 'package:myrscm/src/view/widget/card_billing_with_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'dynamic_view_tab.dart';

class VerticalLayoutDraftBilling extends StatefulWidget {

  final BillingModel data;

  VerticalLayoutDraftBilling(this.data);

  @override
  _VerticalLayoutDraftBillingState createState() => _VerticalLayoutDraftBillingState();
}

class _VerticalLayoutDraftBillingState extends State<VerticalLayoutDraftBilling> with SingleTickerProviderStateMixin {

  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: widget.data.data.tab.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //backgroundColor: Colors.grey,
            floating: false,
            snap: false,
            pinned: true,
            //set icon on left side
            leading: Icon(Icons.arrow_back, color:defaultAppbarContentColor),
            expandedHeight: 200,
            centerTitle: true,
            //title on appbar
            title: Text('Tagihan', style: TextStyle(color:defaultAppbarContentColor)),
            //set icon on right side
            /*actions: <Widget>[
              Icon(Icons.person, color: Colors.black,),
              Icon(Icons.more_vert, color: Colors.black,),
              SizedBox(width: 10,)
            ],*/
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: AssetImage('assets/medical-billing-illustration.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(padding: EdgeInsets.fromLTRB(10, 20, 0, 0), child: Text('Rangkuman Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
              Container(padding: EdgeInsets.fromLTRB(10, 10, 0, 10), child: Text('Poin-poin infromasi mengenai tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
              Container(
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Icon(Icons.receipt, color: Colors.white,),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    child: Text(
                                      'Total',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'Rp 250000',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Icon(Icons.arrow_drop_up, color: Colors.white,),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    child: Text(
                                      'Deposit',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'Rp 250000',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Icon(Icons.arrow_drop_down, color: Colors.white,),
                                ),
                                Container(
                                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                    child: Text(
                                      'Tagihan',
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                    )
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'Rp 250000',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: ExpansionTile(
                          title: Text('More detail'),
                          children: <Widget>[
                            WidgetCardBillingDetail(widget.data.data.tab, widget.data.data.totalSummary),
                          ],
                        )
                      ),
                    ],
                  )
                ),
              ),
              Container(padding: EdgeInsets.fromLTRB(10, 20, 0, 0), child: Text('Detail Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
              Container(padding: EdgeInsets.fromLTRB(10, 10, 0, 10), child: Text('Rincian detil dari poin-poin informasi tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
            ]),
          ),
          SliverPersistentHeader(
            delegate:_SliverAppBarDelegate(
                TabBar(
                  isScrollable: true,
                  controller: controller,
                  tabs: generateTabHeader(widget.data.data.tab),
                  indicatorColor: Colors.red,
                )
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: controller,
              children: generateTabView(widget.data.data.tab),
            ),
          ),
        ],
      ),
    );
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
      color: Colors.white24,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return true;
  }

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
              fontSize: 14
          ),
        ),
      ),
    ));
  }
  return widget;
}
List<Widget> generateTabView(List<TabModel> dataTabModel){
  List<Widget> widget = [];
  for(int i = 0; i < dataTabModel.length; i++){
    widget.add(SingleChildScrollView(child: DynamicViewTab(dataTabModel[i]), scrollDirection: Axis.vertical,));
  }
  return widget;
}

class HorizontalLayoutDraftBilling extends StatefulWidget {

  final BillingModel data;

  HorizontalLayoutDraftBilling(this.data);

  @override
  _HorizontalLayoutDraftBillingState createState() => _HorizontalLayoutDraftBillingState();
}

class _HorizontalLayoutDraftBillingState extends State<HorizontalLayoutDraftBilling> with SingleTickerProviderStateMixin {

  TabController controller;
  @override
  void initState() {
    controller = new TabController(length: widget.data.data.tab.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:  CustomScrollView(
       slivers: <Widget>[
         SliverAppBar(
           //backgroundColor: Colors.grey,
           floating: false,
           snap: false,
           pinned: true,
           //set icon on left side
           leading: Icon(Icons.arrow_back, color:Colors.white),
           expandedHeight: 125,
           centerTitle: true,
           //title on appbar
           title: Text('Tagihan', style: TextStyle(color: Colors.white),),
           //set icon on right side
           /*actions: <Widget>[
              Icon(Icons.person, color: Colors.black,),
              Icon(Icons.more_vert, color: Colors.black,),
              SizedBox(width: 10,)
            ],*/
           flexibleSpace: FlexibleSpaceBar(
             background: Image(
               image: AssetImage('assets/medical-billing-illustration.png'),
               fit: BoxFit.cover,
             ),
           ),
         ),
         SliverFillRemaining(
           child:  Row(
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
                           Container(padding: EdgeInsets.fromLTRB(10, 20, 0, 0), child: Text('Rangkuman Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
                           Container(padding: EdgeInsets.fromLTRB(10, 10, 0, 10), child: Text('Poin-poin infromasi mengenai tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
                           Container(
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
                                           Column(
                                             mainAxisSize: MainAxisSize.min,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Container(
                                                 padding: EdgeInsets.all(15),
                                                 decoration: BoxDecoration(
                                                     color: Colors.blueAccent,
                                                     borderRadius: BorderRadius.circular(30)
                                                 ),
                                                 child: Icon(Icons.receipt, color: Colors.white,),
                                               ),
                                               Container(
                                                   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                   child: Text(
                                                     'Total',
                                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                   )
                                               ),
                                               Container(
                                                 padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                 child: Text(
                                                   'Rp 250000',
                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                                 ),
                                               )
                                             ],
                                           ),
                                           Column(
                                             mainAxisSize: MainAxisSize.min,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Container(
                                                 padding: EdgeInsets.all(15),
                                                 decoration: BoxDecoration(
                                                     color: Colors.greenAccent,
                                                     borderRadius: BorderRadius.circular(30)
                                                 ),
                                                 child: Icon(Icons.arrow_drop_up, color: Colors.white,),
                                               ),
                                               Container(
                                                   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                   child: Text(
                                                     'Deposit',
                                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                   )
                                               ),
                                               Container(
                                                 padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                 child: Text(
                                                   'Rp 250000',
                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                                 ),
                                               )
                                             ],
                                           ),
                                           Column(
                                             mainAxisSize: MainAxisSize.min,
                                             crossAxisAlignment: CrossAxisAlignment.center,
                                             mainAxisAlignment: MainAxisAlignment.center,
                                             children: <Widget>[
                                               Container(
                                                 padding: EdgeInsets.all(15),
                                                 decoration: BoxDecoration(
                                                     color: Colors.redAccent,
                                                     borderRadius: BorderRadius.circular(30)
                                                 ),
                                                 child: Icon(Icons.arrow_drop_down, color: Colors.white,),
                                               ),
                                               Container(
                                                   padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                                                   child: Text(
                                                     'Tagihan',
                                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                                                   )
                                               ),
                                               Container(
                                                 padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                                 child: Text(
                                                   'Rp 250000',
                                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                                 ),
                                               )
                                             ],
                                           ),
                                         ],
                                       ),
                                     ),
                                     Container(
                                         child: ExpansionTile(
                                           title: Text('More detail'),
                                           children: <Widget>[
                                             WidgetCardBillingDetail(widget.data.data.tab, widget.data.data.totalSummary),
                                           ],
                                         )
                                     ),
                                   ],
                                 )
                             ),
                           ),
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
                             Container(padding: EdgeInsets.fromLTRB(10, 20, 0, 0), child: Text('Detail Tagihan', style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),),
                             Container(padding: EdgeInsets.fromLTRB(10, 10, 0, 10), child: Text('Rincian detil dari poin-poin informasi tagihan anda', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w300),),),
                           ]),
                         ),
                         SliverPersistentHeader(
                           delegate:_SliverAppBarDelegate(
                               TabBar(
                                 isScrollable: true,
                                 controller: controller,
                                 tabs: generateTabHeader(widget.data.data.tab),
                                 indicatorColor: Colors.red,
                               )
                           ),
                           pinned: true,
                         ),
                         SliverFillRemaining(
                           child: TabBarView(
                             controller: controller,
                             children: generateTabView(widget.data.data.tab),
                           ),
                         ),
                       ],
                     )
                 )
               ]
           )
         ),
       ],
     ),
    );
  }
}