typedef DicMap = Map<String, dynamic>;
typedef TermList = List<String>;
typedef DicList = List<Dictionary>;

DicList list = [];

void main() {
  addJson({"term":"dart", "definition":"숙제 숙제~"});
  add(term: "배고파", definition:  "밥먹자~");
  showAll();

  delete("dart");
  print(exists("dart"));
  showAll();

  update(term: "배고파", definition: "삼겹살 ㅎㅎㅎ");

  upsert(term: "upsert", definition: "test");

  bulkAdd([
    {"term": "김치", "definition": "대박이네~"},
    {"term": "아파트", "definition": "비싸네~"}
  ]);
  showAll();

  bulkDelete(["김치", "dart"]);
  showAll();
}

class Dictionary {
  String term;
  String definition;

  Dictionary.fromJson(DicMap json)
      : term = json["term"],
        definition = json["definition"];

  Dictionary({
    required this.term,
    required this.definition,
  });

  @override
  String toString() {
    return "$term : $definition \n";
  }
}


///단어를 추가함
void add({required String term, required String definition}) {
  var dic = Dictionary(term: term, definition: definition);
  list.add(dic);
}

void addJson(DicMap json) {
  var dic = Dictionary.fromJson(json);
  list.add(dic);
}

///단어의 정의를 리턴함
String get(String term) {
  for (var element in list) {
    // if element.term
    if (element.term == term) {
      return element.definition;  
    }
  }
  return "";
}

///단어를 삭제함
void delete(String term) {
  list.removeWhere((e) => e.term == term);
}

///단어를 업데이트 함
void update({required String term, required String definition}) {
  var dic = Dictionary(term: term, definition: definition);
  for (var element in list) {
    if (element.term == dic.term) {
      element = dic;
      break;  
    }
  }
}

///사전 단어를 모두 보여줌
void showAll() {
  print(list.toString());
}

///사전 단어들의 총 갯수를 리턴함
int count() {
  return list.length;
}

///단어를 업데이트 함. 존재하지 않을시. 이를 추가함. (update + insert = upsert)
void upsert({required String term,required String definition}) {
  var isExists = exists(term);
  if (isExists) {
    update(term: term, definition: definition);
  } else {
    add(term: term, definition: definition);
  }
}

///해당 단어가 사전에 존재하는지 여부를 알려줌
bool exists(String term) {
  for (var element in list) {
    if (element.term == term) {
      return true;
    }
  }
  return false;
}

///다음과 같은 방식으로. 여러개의 단어를 한번에 추가할 수 있게 해줌. [{"term":"김치", "definition":"대박이네~"}, {"term":"아파트", "definition":"비싸네~"}]
void bulkAdd(List<DicMap> bulkList) {
  bulkList.forEach((element) {
    addJson(element);
  });
}

///다음과 같은 방식으로. 여러개의 단어를 한번에 삭제할 수 있게 해줌. ["김치", "아파트"]
void bulkDelete(TermList bulkList) {
  bulkList.forEach((element) {
    delete(element);
  });
}