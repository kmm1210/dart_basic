# Dart 공부

## Variables
함수나 메소드 안에서는 var(=dynamic) 선언
클래스에서는 String 타입 선언

String? null 가능
String? name
name?.isNotEmpty : null이 아니면 비어있는지 확인해줌
final 상수선언자
late final String name; 나중에 데이터를 넣을 수 있게 해줌(데이터 fetching할 때 유용)
const 앱스토어에 올리기전에 고정된 상수 , 컴파일 단계에 값을 인식
api로부터 받은 api키값을 사용하려면 final 이용

<br>

## Comments
### Single-line comments
~~~ dart
void main() {
  // TODO: refactor into an AbstractLlamaGreetingFactory?
  print('Welcome to my Llama farm!');
}
~~~
---

### Multi-line comments
~~~ dart
void main() {
  /*
   * This is a lot of work. Consider raising chickens.

  Llama larry = Llama();
  larry.feed();
  larry.exercise();
  larry.clean();
   */
}
~~~
---

### Documentation comments
~~~ dart
/// A domesticated South American camelid (Lama glama).
///
/// Andean cultures have used llamas as meat and pack
/// animals since pre-Hispanic times.
///
/// Just like any other animal, llamas need to eat,
/// so don't forget to [feed] them some [Food].
class Llama {
  String? name;

  /// Feeds your llama [food].
  ///
  /// The typical llama eats one bale of hay per week.
  void feed(Food food) {
    // ...
  }

  /// Exercises your llama with an [activity] for
  /// [timeLimit] minutes.
  void exercise(Activity activity, int timeLimit) {
    // ...
  }
}
~~~
<br>

## Collections
### List
~~~ dart
var giveMeFive = true
var numbers = [1, 2, 3, 4, if(giveMeFive ) 5];

var name = 'mimi';
var age = 10;
var greeting = "hello , $name and I'm ${age + 2}" ;


var oldFriends = ['lee', 'kim']
var numbers = ['ggg', 'test', for(var friend in oldFriends) '💕 friend '];
~~~

- Dart에서 [] 은 optional, positional parameter를 명시할 때 사용된다.
- name, age는 필수값이고 []를 통해 country를 optional값으로 지정해줄 수 있다.

~~~ dart
String sayHello(String name, int age, [String? country = ""]) {
    return 'Hello ${name}, You are ${age} from the ${country}';
}

void main() {
    var result = sayHello("sugar", 10);
    print(result);
}
~~~

### TypeDef
- 자료형에 사용자가 원하는 alias를 붙일 수 있게 해준다. (자료형 이름의 별명을 만들 때 사용)
~~~ dart
typedef ListOfInts = List;

ListOfInts reverseListOfNumbers(ListOfInts list) {
var reversedList = list.reversed.toList();
return reversedList;
}
~~~

### property를 선언
- dart에서 property를 선언할 때는 타입을 사용해서 정의한다.
~~~ dart
class Player {
    final String name = 'jisoung';
    final int age = 17;
    void sayName(){
        // class method안에서는 this를 쓰지 않는 것을 권장한다.
        print("Hi my name is $name")
    }
}

void main(){
    // new를 꼭 붙이지 않아도 된다.
    var player =Player();
}
~~~
<br>

## 생성자(constructor)
- dart에서 생성자(constructor) 함수는 클래스 이름과 같아야 한다.

~~~ dart
class Player {
    // 이럴 때 late를 사용한다.
    late final String name;
    late final int age;
    // 클래스 이름과 같아야한다!
    Player(String name){
        this.name = name;
    }
}

void main(){
    // Player 클래스의 인스턴스 생성!
    var player = Player("jisoung", 1500);
~~~

- 위의 생성자 함수는 다음과 같이 줄일 수 있다.
~~~ dart
// 생략
Player(this.name, this.age);
~~~
- 첫 번째 인자는 this.name으로 두 번째 인자는 this.age로 갈 것이다.


- 많은 인자를 받을 경우 name parameter를 사용
~~~ dart
class Team {
    final String name;
    int age;
    String description;

    //Team({this.name, this.age, this.description});

    //required를 사용하여 변수의 null방지
    Team({
    required this.name,
    required this.age,
    required this.description,
    });,

}

void main(){
    var player = Player(
        name: "jisoung",
        age: 17,
        description: "Happy coding is end coding"
        }
}
~~~

✅ Named parameters
~~~ dart
// 일반적인 방법
Player.createBlue({
    required String name,
    required int xp
}) : this.name = name,
this.xp = xp,
this.team = 'blue';

// 간소화된 방법(dart는 간소화된 방법을 추천)
Player.createRed({
    required this.name,
    required this.xp,
    this.team = 'red',
});
~~~

✅ positional parameters
// 일반적인 방법
~~~ dart
Player.createRed(String name, int xp)
: this.name = name,
this.xp = xp,
this.team = 'red';

// 간소화된 방법
Player.createRed(
    this.name,
    this.xp,
    [this.team = 'red']
);
~~~

~~~ dart
// 생략
void main(){
var jisoung = Player(name: "jisoung", age: 17, description: "Happy code is end coding");
jisoung.name = "nico";
jisoung = 20;
jisoung.description = "Best Project is End Project";
}
~~~
위를 보면 반복되는 부분이 있다. dart에서는 이걸 간단하게 ..으로 해결할 수 있다.
~~~ dart
// 생략
void main(){
var jisoung = Player(name: "jisoung", age: 17, description: "Happy code is end coding");
...name = "nico"
..age = 20
..description = "Best Project is End Project";
}
~~~
각 '..'들은 jisoung을 가리킨다. 매우 유용한 operator이다.
앞에 class가 있다면 그 클래스를 가리킨다.

상속을 하고 super를 이용해 부모 클래스의 생성자를 호출할 수 있다.
~~~ dart
class Human {
final String name;
Human(this.name); // 호출 받는다.
void sayHello(){
print("Hello! $name");
}
}

class Player extends Human {
Player({
required this.team,
required String name
}) : super(name: name);
// Human의 생성자 함수를 호출한다.
}
~~~
@override를 이용해 부모 클래스의 객체를 받아올 수 있다.
~~~ dart
// 생략
@override
void sayHello(){
    super.sayHello();
}
~~~
---
## Mixins
Mixin은 생성자가 없는 클래스를 의미한다.
Mixin 클래스는 상속을 할 때 extends를 하지 않고 with 를 사용한다.
Mixin의 핵심은 여러 클래스에 재사용이 가능하다는 점이다.
~~~ dart
class Tall {
final double tall = "190.00"
}

class Human with Tail {
// 생략
}
~~~ 
extends와 차이점은 extend를 하게 되면 확장한 그 클래스는 부모 클래스가 되지만 with는 부모의 인스턴스 관계가 된다. 단순하게 mixin 내부의 프로퍼티를 갖고 오는 거라고 생각하면 쉽다.
