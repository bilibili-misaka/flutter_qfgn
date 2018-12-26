import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_page_recommend_model.dart';
import 'package:flutter_app/ui/api.dart';
import 'package:flutter_app/ui/homepage/home_comm_list_item.dart';
import 'package:flutter_app/ui/homepage/searchpage/search_category_page.dart';
import 'package:flutter_app/ui/homepage/searchpage/search_user_page.dart';
import 'package:flutter_app/utils/http_util.dart';

class CommSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CommSearchPageState();
  }
}

class CommSearchPageState extends State<CommSearchPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int pageIndex;
  String searchText = "";
  SearchViewPage _searchViewPage;
  SearchCategoryPage _searchCategoryPage;
  SearchUserPage _searchUserPage;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener((){
      setState(() {
      });
    });

    _searchViewPage = SearchViewPage(searchText: searchText,);
    _searchCategoryPage = SearchCategoryPage(searchText: searchText,);
    _searchUserPage = SearchUserPage(searchText: searchText,);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      appBar: PreferredSize(child: Container(), preferredSize: Size(0, 0)),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Container(
            height: 40,
            margin: EdgeInsets.only(top: 35, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(6)),
              border: Border.all(
                color: Colors.white70,
                width: 0
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                  spreadRadius: 0
                )
              ]
            ),
            child: TextField(

              cursorColor: Theme.of(context).accentColor,
              cursorWidth: 1,
              onChanged: (text){
                searchText = text;
              },

              onSubmitted: (text){
                searchText = text;
                switch(_tabController.index){
                  case 0:
                    _searchViewPage.searchState.getData(searchText);
                    break;
                  case 1:
                    _searchCategoryPage.state.getData(searchText);
                    break;
                  case 2:
                    _searchUserPage.state.getData(searchText);
                    break;
                }

                setState(() {

                });
              },
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600]
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 0, style: BorderStyle.none
                  )
                ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70, width: 0),
                  ),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,style: BorderStyle.none
                      )
                  ),

                  contentPadding: EdgeInsets.only(left: 10),
                  hintText: "请输入你想搜索的内容",
                  suffixIcon: Hero(
                    tag: "home_search_btn",
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                          icon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            switch(_tabController.index){
                              case 0:
                                _searchViewPage.searchState.getData(searchText);
                                break;
                              case 1:
                                _searchCategoryPage.state.getData(searchText);
                                break;
                              case 2:
                                _searchUserPage.state.getData(searchText);
                                break;
                            }
                            setState(() {

                            });
                          }),
                    ),
                  )),
            ),
          ),
          TabBar(
              controller: _tabController,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              indicatorColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.only(bottom: 3),
              indicator: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/ic_rectangle.png"),
                  ),
              ),
              tabs: [
                Tab(
                  child: Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: Text(
                      "帖子",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: Text(
                      "话题",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.only(bottom: 5),
                    alignment: Alignment.center,
                    child: Text(
                      "用户",
                      style: TextStyle(fontSize: 13),
                    ),
                  ),
                )
              ]),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              _searchViewPage,
              _searchCategoryPage,
              _searchUserPage,
            ]),
          )
        ],
      ),
    );
  }


}

class SearchViewPage extends StatefulWidget {
  final searchText;
  SearchViewPageState searchState;
  SearchViewPage({Key key, this.searchText}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return searchState = SearchViewPageState(searchText);
  }

}

class  SearchViewPageState extends State<SearchViewPage> with AutomaticKeepAliveClientMixin{

  HomeRecommendData mData;
  String searchText;
  SearchViewPageState(this.searchText);

  Future getData(searchText) async{
    this.searchText = searchText;
    var response = await HttpUtil.getInstance().get(Api.SEARCH_POST,data: {"keyword":searchText});
    mData = HomeRecommendData.fromJson(response);
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    getData(searchText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: searchText!=""?ListView.builder(
          itemBuilder: (BuildContext context,int index){
            if(mData!=null&&mData.data!=null&&index<mData.data.length){
              return CommListItem(mData.data[index]);
            }else if(index == mData.data.length){
              return Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(14),
                child: Text("已加载全部"),
              );
            }
          }
      ):Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Spacer(flex: 1,),
            Image.asset("images/no_data.png",width: 120,height: 120,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("空空如也",style: TextStyle(color: Colors.grey,fontSize: 16),),
            ),
            Spacer(flex: 2,),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}