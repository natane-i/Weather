# Weather

## アプリ概要
擬似天気予報APIを使用して、全国主要都市の天気と最高気温、最低気温を表示するアプリです。  
コレクションビューを利用して、項目を並べ、セルをクリックすると詳細画面に遷移します。

## 工夫したポイント
通信に時間がかかるバージョンのAPIを使用しているので、更新時には非同期処理を行うため、スレッドブロックを使用しています。  
その際更新中であることをわかりやすくするために、インジケータを表示してユーザビリティを向上させました。

## 苦労したポイント
このアプリの開発を通じてDelegateについても勉強しましたが、プロトコルを経由することで別ページに値を渡すという考え方に苦戦しました。  
関数でも良いのではないかと思っていましたが、ノートに自分の言葉でまとめて理解を深めたことで、高い柔軟性を持って処理を記述できることに気づきました。

## 使用したAPI
[YumemiWeather](https://yumemi-inc.github.io/ios-training/documentation/yumemiweather)


## アプリ画面
![](https://github.com/natane-i/Weather/assets/168057151/90a8ef52-b44c-4a80-849f-f676f667c878)
