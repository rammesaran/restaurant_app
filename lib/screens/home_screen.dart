import 'package:flutter/material.dart';
import 'package:resturent_app/model/dish_model.dart';
import 'package:resturent_app/services/get_dishlist.dart';

class TabDream11 extends StatefulWidget {
  @override
  _TabDream11State createState() => _TabDream11State();
}

class _TabDream11State extends State<TabDream11> {
  GetDishes getDishes = GetDishes();
  DishModel models = DishModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getDishes.getlistofdishes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ReceipeList(model: snapshot.data)
                : Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class ReceipeList extends StatefulWidget {
  final List<DishModel> model;
  ReceipeList({this.model});
  @override
  _ReceipeListState createState() => _ReceipeListState();
}

class _ReceipeListState extends State<ReceipeList> {
  int tabIndex = 0;

  final List<Tab> myTabs = <Tab>[];

  getTabMenus() {
    for (var item in widget.model[0].tableMenuList) {
      myTabs.add(Tab(
        text: item.menuCategory,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    getTabMenus();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.keyboard_arrow_left),
          title: Text(widget.model[0].restaurantName),
          actions: <Widget>[
            Row(
              children: <Widget>[
                Text('My Orders'),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 8.0),
                  child: GestureDetector(
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          size: 36.0,
                        ),
                        if (myTabs.length > 0)
                          Padding(
                            padding: const EdgeInsets.only(left: 2.0),
                            child: CircleAvatar(
                              radius: 8.0,
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              child: Text(
                                myTabs.length.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.0,
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.red,
              tabs: myTabs,
              onTap: (int myIndex) {
                setState(() {
                  tabIndex = myIndex;
                });
              }),
        ),
        body: TabBarView(
          children: myTabs.map((Tab tab) {
            return ListView.builder(
              itemCount:
                  widget.model[0].tableMenuList[tabIndex].categoryDishes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.5, 0.0, 0.5),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.model[0].tableMenuList[tabIndex]
                                .categoryDishes[index].dishName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'SAP ${widget.model[0].tableMenuList[tabIndex].categoryDishes[index].dishPrice.toString()}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15.0),
                              ),
                              Text(
                                '${widget.model[0].tableMenuList[tabIndex].categoryDishes[index].dishCalories.round().toString()} calories',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 12.0, 0.0, 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.model[0].tableMenuList[tabIndex]
                                        .categoryDishes[index].dishDescription,
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  ),
                                  flex: 3,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                      height: 80.0,
                                      width: 80.0,
                                      child: Image.network(
                                        widget.model[0].tableMenuList[tabIndex]
                                            .categoryDishes[index].dishImage,
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ],
                            ),
                          ),
                         //ToDo : Button to be added
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

