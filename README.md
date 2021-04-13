# pagesindecator
rxdart(use extend opts)+ StreamProvider (provider v5) (data sample is model)

补充FutureProvider的用法
```
class UserProvider {
  final String _dataPath = "assets/data/users.json";
  List<User> users;

  Future<List<User>> loadUserData( ) async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    print('done loading user!' + jsonEncode(users));
    return users;
  }

  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 10), () async {
      return await rootBundle.loadString('assets/data/users.json');
    });
  }
}
//////
 MultiProvider(
        providers: [
          FutureProvider(builder: (_) => UserProvider().loadUserData()),
        ],
        child: MyApp()
    )

...

其他一致，就是要提供个future即可

```

另外备注future的几个初始化方法

```
Flutter Future 

单个future创建方法
丢个void函数
var future = Future(() {
  print("哈哈哈");
});

丢个值或者对象
Future.value(“dss”). 

延迟执行的创建函数
Future.delayed（）



 m 创建 方法

Future.forEach批量创建
Future.forEach({1,2,3}, (num){
  return Future.delayed(Duration(seconds: num),(){print(num);});
});

 Future.wait用来等待多个future完成，并收集它们的结果。
var future1 = new Future.delayed(new Duration(seconds: 1), () => 1); var future2 = new Future.delayed(new Duration(seconds: 2), () => 2); var future3 = new Future.delayed(new Duration(seconds: 3), () => 3); Future.wait({future1,future2,future3}).then(print).catchError(print); //运行结果： [1, 2, 3]


Future .any返回的是第一个执行完成的future的结果，不会管这个结果是正确的还是error的。
Future .any([1, 2, 5].map( (delay) => new Future.delayed(new Duration(seconds: delay), () => delay))) .then(print) .catchError(print);

DoWhile
void futureDoWhile(){ 
var random = new Random(); 
var totalDelay = 0; 

Future .doWhile(() {
 if (totalDelay > 10) { 
print('total delay: $totalDelay seconds'); 
return false; 
} 

var delay = random.nextInt(5) + 1; 
totalDelay += delay; 

return new 
Future.delayed(
new Duration(seconds: delay), (){ 
print('waited $delay seconds'); return true; 
}); })
 .then(print) 
.catchError(print); }

Future.microtask 创建一个在microtask队列运行的future。(优先执行)
Future.microtask((){
 print("microtask event");
});


===================================================================
处理Future结果

Future<R> then<R>(FutureOr<R> onValue(T value), {Function onError});
 Future<T> catchError(Function onError, {bool test(Object error)});
 Future<T> whenComplete(FutureOr action());

```
