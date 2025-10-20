if command -v nvim &> /dev/null; then
    export EDITOR="$(command -v nvim)"
elif command -v vi &> /dev/null; then
    export EDITOR="$(command -v vi)"
fi
