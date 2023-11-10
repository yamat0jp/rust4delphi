rust4delphiにご興味を持っていただいた方のために

本リポジトリの目指すところは純粋関数とオブジェクトの融合です。

pureObjectの宣言は以下のようにするつもりでした

type
  PObject = pure(TObject)
  public
    class function plus(a,b: integer): integer;
    class function mul(a,b: integer): integer;
    ...
  end;

この点で気を付けるべきことはただ、関数のパラメータにポインタを渡さないことです。

実際の運用に関してはDelphiの作法に従えばForm1がグローバル宣言されているユニットで

アプリケーション独自のクラスを継承することです。

ちなみにTPureObjectではvirtual宣言されていませんでしたが基底クラス以外では

仮想メソッドで宣言するのがよいでしょう。


ソースコードでは動的配列というポインタを渡してしまっているあたり定義からうまくいっていません。

KIMという正解が安定して出るようになりました。初版のはコーディングミスです。感覚で打っていました。