List<List<String>> transpose(arr){

  List<List<String>> boardTranspose = [['','',''],['','',''],['','','']];

  // Transpose
  for (int row = 0; row < 3; row++) {
    for (int col = 0; col < 3; col++) {
      boardTranspose[col][row] = arr[row][col];
    }
  }
  return boardTranspose;
}

bool isFull(List<List<String>> arr){
  for(var item in arr){
   if( item.any((x) => x == '')){
     return false;
   }
  }
  return true;
}

int doneAsRow(List<List<String>> arr){
  for (int row = 0; row < 3; row++) {
    if( arr[row].every((col) => col == 'X') ||   arr[row].every((col) => col == 'O')) return row;
  }
  return -1;
}

int doneAsColumn(List<List<String>> arr){
  return doneAsRow(transpose(arr));
}

int doneAsCross(List<List<String>> arr){
  List<String> list = [];
  for(int i = 0;i<3;i++) {
    list.add(arr[i][i]);
  }
  if(list.every((element) => element == 'X') || list.every((element) => element == 'O')) return 0;

  list = [];
  list.addAll([arr[0][2] , arr[1][1] ,  arr[2][0]]);
  if(list.every((element) => element == 'X') || list.every((element) => element == 'O')) return 1;

  return -1;

}