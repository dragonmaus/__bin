#!/data/data/com.termux/files/usr/bin/mksh

set -e

. echo.sh

name="$( basename "$0" .sh )"
usage="Usage: $name [-hqv] command [args...]"
help="$usage

  -h   display this help
  -q   suppress command error output
  -v   print directory names as they are processed"

# cargo passes its arguments unchanged to subcommands
[[ "$1" = foreach ]] && shift

quiet=false
verbose=false
while getopts :hqv opt
do
  case "$opt" in
  (h)
    die 0 "$help"
    ;;
  (q)
    quiet=true
    ;;
  (v)
    verbose=true
    ;;
  (:)
    warn "$name: Option '$OPTARG' requires an argument"
    die 100 "$usage"
    ;;
  (\?)
    warn "$name: Unknown option '$OPTARG'"
    die 100 "$usage"
    ;;
  esac
done
shift $(( OPTIND - 1 ))

IFS='
'
for dir in $( ls -A )
do
  [[ -d "$dir" && -f "$dir/Cargo.toml" ]] || continue
  $verbose && echo ">> $dir"
  if ! ( cd "$dir"; $quiet && exec 2> /dev/null; exec "$@" ) && ! $quiet
  then
    warn "command '$( echo $* )' failed in directory '$dir'"
  fi
done
