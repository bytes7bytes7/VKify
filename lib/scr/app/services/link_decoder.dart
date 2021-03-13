class LinkDecoder{
  String n ='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMN0PQRSTUVWXYZO123456789+/=';
  int uid = 0;

  LinkDecoder(int userID){
    if(userID<1)
      throw Exception('Invalid uid!');
    uid=userID;
  }



  static List<int> sortObject(Map<int,int> e){

    String getPrice(List<int> lst){
      String a=lst[0].toString(),b = lst[1].toString();
      while(a.length<3)
        a='0'+a;
      while(b.length<3)
        b='0'+b;
      return a+b;
    }

    List<List<int>> items=[];
    e.forEach((key, value) {
      items.add([key,value]);
    });
    items.sort((a, b) => getPrice(a).compareTo(getPrice(b)));
    return List.generate(items.length, (i) => items[i][1]);
  }

}