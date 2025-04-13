part of 'hooks.dart';

typedef CacheAndContext = ({
  AsyncCache<void> cache,
  BuildContext context,
});

/// CacheとContextを取得するためのカスタムフック
///
/// ```dart
/// final (:cache, :context) = useCacheAndContext();
/// ```
CacheAndContext useCacheAndContext() {
  final cache = AsyncCache<void>.ephemeral();
  final context = useContext();

  return (cache: cache, context: context);
}
