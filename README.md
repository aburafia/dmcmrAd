# dmcmrAd

tutayaに設置してwebviewを表示する側です。

ペリフェラルを検知すると、UUIDをBLE経由で取得して、それをパラーメターとしてwebを表示します。現在は仮にキーワードをgoogle検索しています。

検知後、30病間はそのまま表示して、その後再度検知を行います。
同じユーザだと処理をキャンセルしています。
