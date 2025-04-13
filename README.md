# Action Controller Sample

このプロジェクトは、Flutter アプリケーションにおける効率的な状態管理と関心事の分離を実現するための実装サンプルです。従来の画面単位の ViewModel による実装から、機能単位のアクションコントローラーパターンへの移行を示しています。

## 設計コンセプト

### 従来の課題

従来の実装では、各画面の ViewModel が data 層や application 層のロジックをブリッジする役割を果たしていました。この方法には以下の課題がありました：

- 画面ごとに似たようなロジックが重複する
- 特定の機能に関連するコードが複数の場所に散在する
- エラーハンドリングのパターンが統一されていない

### 新しいアプローチ

このサンプルでは以下の改善を導入しています：

1. **機能単位のブリッジング**：
   - 画面単位ではなく、機能（ユーザー作成、更新など）ごとにロジックを集約
   - 再利用可能なコントローラーにより、同じ機能を異なる画面で簡単に使用可能

2. **UseCase 層の導入**：
   - Flutter 公式の推奨に基づき、UseCase パターンを採用
   - データ層とプレゼンテーション層の間の明確な橋渡し役として機能
   - ビジネスロジックを一貫した場所に集約

3. **統一されたエラーハンドリング**：
   - Riverpod の StateNotifier の guard 機能を活用
   - 例外処理を一元管理し、UIからの分離を実現
   - 呼び出し元（Caller）に応じたエラー表示の制御

## プロジェクト構造

```
lib/
├── application/          # アプリケーションサービス層
├── core/                 # コアユーティリティ
├── data/                 # データ層（リポジトリ実装）
├── domain/               # ドメイン層（モデル、列挙型）
├── presentation/         # プレゼンテーション層
│   ├── action_controller/  # アクションコントローラー
│   │   ├── _hooks/           # 共通フック
│   │   ├── create_user/      # ユーザー作成機能
│   │   └── update_user/      # ユーザー更新機能
│   ├── screen/            # 画面コンポーネント
│   └── shared/            # 共有UI要素
└── use_case/             # ユースケース層
    └── executors/          # 各機能のエグゼキューター
```

## 主要な機能

### Action Controller パターン

アクションコントローラーは、特定の機能に関連するUIロジックとビジネスロジックの仲介役です。各コントローラーは：

- 特定の機能（ユーザー作成など）に特化
- フック（hooks）として実装され、UIコンポーネントから簡単に使用可能
- エラーハンドリングを内包
- コンテキストに応じたフィードバックの表示（ダイアログ、スナックバーなど）

```dart
// 使用例
final createUser = useCreateUserController(ref, caller: Caller.homeScreen);
// ...
onPressed: () => createUser.action(user)
```

### UseCase Executors

UseCase層は、アプリケーションのビジネスロジックを担当します：

- データ層の操作を抽象化
- Riverpod StateNotifierとして実装
- AsyncValue.guardを使用した一貫したエラーハンドリング
- 再利用可能なビジネスロジックユニット

```dart
@riverpod
class CreateUserExecutor extends _$CreateUserExecutor implements ExecutorBase {
  // ...
  FutureOr<void> call(User user, {required bool throwException}) async {
    state = await AsyncValue.guard(() async {
      await ref.read(userRepositoryProvider).create(user, throwException: throwException);
    });
  }
}
```

#### Executorの引数（ファミリー）の意義

Executor（UseCase）に`Caller`のような引数を持たせる設計には、以下のような重要な利点があります：

1. **インスタンス分離によるエラー処理の独立性**：
   - 各呼び出し元（例: homeScreen, appleScreen）ごとに異なるExecutorインスタンスが生成される
   - 同一機能でも呼び出し元ごとに状態が独立して管理される
   - 一つの画面でエラーが発生しても、他の画面の状態には影響しない

2. **コンテキスト別の振る舞いの実現**：
   - 同じロジックでも呼び出し元に応じて異なる処理（UIフィードバックなど）が可能
   - 例えばHomeScreenではダイアログ表示、別の画面ではスナックバー表示など

3. **並行使用の安全性**：
   - 複数の画面で同時に同じ機能を使用しても、状態の競合が発生しない
   - それぞれの画面で独自のリスナーを持ち、個別に反応できる

4. **デバッグの容易性**：
   - エラーが発生した際に、どの呼び出し元から問題が起きたかを特定しやすい
   - ログやエラーメッセージにコンテキスト情報を含めることが可能

この設計により、「同じ機能を使いつつも、使用コンテキスト（画面や状況）ごとに適切な振る舞いを実現する」という柔軟性と堅牢性を両立しています。

```dart
// 使用例
// それぞれ別のインスタンスとして管理される
final homeCreateUser = useCreateUserController(ref, caller: Caller.homeScreen);
final appleCreateUser = useCreateUserController(ref, caller: Caller.appleScreen);
```

### エラーハンドリング戦略

統一されたエラーハンドリングアプローチ：

- AsyncValue.guardによる例外のキャプチャ
- コントローラーレベルでのエラーリスニング
- 呼び出し元（Caller）に基づく適切なUIフィードバック
- パターンマッチングを活用した例外タイプごとの処理

## 利点

- **関心事の分離**: ビジネスロジック、UIロジック、データ操作の明確な分離
- **再利用性**: 同じ機能を複数の画面で簡単に再利用可能
- **テスト容易性**: 各層が明確に分離されているため、単体テストが容易
- **一貫したエラーハンドリング**: 全機能で統一されたエラー処理パターン
- **メンテナンス性**: 機能ごとにコードが整理されているため変更の影響範囲が明確

---
忌憚なきご意見お待ちしております！
