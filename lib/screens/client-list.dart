import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hipoclientapp/models/hipomodel.dart';
import 'package:hipoclientapp/widgets/user-info.dart';


class clientListPage extends StatefulWidget {
  const clientListPage({Key? key}) : super(key: key);

  @override
  State<clientListPage> createState() => _clientListPageState();
}
class _clientListPageState extends State<clientListPage> {
  TextEditingController editingController = TextEditingController();
  List<HipoClient> clientList=[],copyList=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Members"),),
      /*
      In body part of the project, I used future builder method for calling the object "readHipoJson".
      Then I expect to get all client list. If my program did not find ".json" file, then my "snapshot" will throw
      error at the beginning of the application.   
      */
      body: FutureBuilder<List<HipoClient>>(
        future: readHipoJson(),
        builder: (context,snapshot){
          if(snapshot.hasData){
            if(clientList.isEmpty){
              //I create two empty list and add "snapshot.data"
              clientList=snapshot.data!;
              copyList.addAll(clientList);
            }
            return Container(
              padding: const EdgeInsets.fromLTRB(20.0,20.0,20.0,10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12.0,4.0,12.0,12.0),
                    child: TextField(
                      /*
                      In the searchbar problem, I tried different approaches and finally this solution worked the way I expect :)

                      - When the searchbar isnotEmpty
                        - I create an empty "dummyListData" for adding clients which has same characters with the given input value.
                        - Then I used "for loop" for reading all members and added to "dummyListData" with respect to given input.
                        - After that I used setState method for refresh the UI with the given "dummyListData"
                        - In this part of the project I delete all the clients in "copyList" then i add "dummyListData" 
                        - Therefore I get only search results on UI

                      - When the searchbar isEmpty
                        -In the case of our user end his/her query, We should show our original user list on UI.
                        -Therefore, I clear copyList again and add our original clientlist data. 
                      */
                      onChanged: (value) {
                        if(value.isNotEmpty) {
                          List<HipoClient> dummyListData = [];
                          for (var item in clientList) {
                            if(item.name.toLowerCase().toString().contains(value.toLowerCase().toString())) {
                              dummyListData.add(item);
                            }
                          }
                          setState(() {
                              copyList.clear();
                              copyList.addAll(dummyListData);
                            });
                        }
                        else {
                          setState(() {
                            copyList.clear();
                            copyList.addAll(clientList);
                          });
                        }
                      },
                      controller: editingController,
                      decoration: const InputDecoration(prefixIcon: Icon(Icons.search)),
                    ),
                  ),
                  /*
                  In this part of the  project, I create listView builder with card widget for listing the objects.
                  I also add alert dialog widget for showing the object details   
                  */
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: copyList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(copyList[index].name),
                            onTap: (){
                              FocusManager.instance.primaryFocus!.unfocus();
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {return BlurryDialog(copyList, index);},
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  /*
                  When the user pressed "Add New Member button, I create a new object from HipoClient element. 
                  Then I add this object to the end of "clientList".
                  -We can also write this object to our ".json" file and create a new list by calling "readHipoJson" method again.
                  -However this approach would be inefficient since we call some methods again which is already created.
                  */
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: OutlinedButton(
                      onPressed: (){
                        setState(() {
                          clientList.add(createMe());
                          copyList.add(createMe());
                        });
                      }, 
                      child: const Text("ADD NEW MEMBER",style: TextStyle(color:Colors.white,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
                    ),
                  ),
                ],
              ),
            );
          }
          else if(snapshot.hasError){return Center(child: Text(snapshot.hasError.toString()),);}
          else{return const Center(child: CircularProgressIndicator(),);}
        },
      ),
    );
  }

  /*
  In this part of the project, I read the json file from assets/hipo.json and convert the variables from map() to string.
  Since we dont used company and team info in the project, I create my list with members
  */
  Future<List<HipoClient>> readHipoJson() async{
    String readJson=await DefaultAssetBundle.of(context).loadString('assets/hipo.json');
    var hipoObject=jsonDecode(readJson);
    List<HipoClient> allClients = (hipoObject["members"] as List).map((clientMap) => HipoClient.fromMap(clientMap)).toList();
    return allClients;
  }

  //When user pressed the "Add New Member" button, This code will construct "ME" with respect to HipoClient object :)
  HipoClient createMe(){
    HipoClient newUserObject = HipoClient(
      name: "Kutay Onder", 
      age: 24, 
      location: "Kocaeli", 
      github: "kutayonder", 
      hipo: Hipo(
        position: "Intern", 
        yearsInHipo: 0,
      ),
    );
    return newUserObject;
  }
}
