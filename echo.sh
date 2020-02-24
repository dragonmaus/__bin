case "$KSH_VERSION" in
(*'LEGACY KSH'*|*'MIRBSD KSH'*|*'PD KSH'*)
  echo() {
    print -R "$@"
  }
  ;;
(*)
  echo() {
    case "$1" in
    (-n)
      shift
      printf '%s' "$*"
      ;;
    (*)
      printf '%s\n' "$*"
      ;;
    esac
  }
  ;;
esac

warn() {
  echo "$@" 1>&2
}

die() {
  e="$1"
  shift
  warn "$@"
  exit "$e"
}
