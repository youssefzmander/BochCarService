
class LookUp{

String IconeService(String inputString) {
  List<String> FindList = ['BOUGIE' , 'AMORTISSEUR' , 'EMBRAYAGE'   , 'POMPE', 'SOUPAPE'  , 'BOBINE'  , 'COMPRESSEUR' , 'LAMPE'  , 'FREIN'  , 'CHAINE'  , 'HUILE'   , 'TURBO'  , 'DIAGNOSTIC'  , 'BATTERIE'  , 'FILTRE'  , 'ROTULE' ];
  

  String containedWord = findContainedWord(FindList, inputString);
  return containedWord;
}


String findContainedWord(List<String> list, String inputString) {
  List<String> words = inputString.split(' ');
  for (String word in words) {
    if (list.contains(word)) {
      var _world=word+".png";
          return word;
    }
  }
  return "service.png";
}
}