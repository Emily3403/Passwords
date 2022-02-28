#/bin/bash

if [ ! -f "secret.png" ]; then
    echo "The file \"secret.png\" was not found."
    exit 1
fi

if [ ! -f "pubkey.asc" ];  then
    echo "The file \"pubkey.asc\" was not found."
    exit 1
fi

read -p "Password please: " -s password

zbarimg -1 --raw -q -Sbinary secret.png  | openssl enc -d -aes-256-cbc -md sha512 -pbkdf2 -iter 100000 -pass file:<(echo -n $password) | paperkey --pubring pubkey.asc | gpg --import
