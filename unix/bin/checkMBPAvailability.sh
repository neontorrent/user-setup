#!/bin/bash

function notify {
  sendmail me@brucezhao.com <<EOF
Subject: $1

$2
EOF
}

lastStatus31=0
lastStatus35=0

while true; do

  #MBP 3.1GHz
  res=$(curl -s 'https://www.apple.com/ca/shop/delivery-message?parts.0=G0UQ0LL%2FA&_=1507050636487' -XGET -H 'DNT: 1' -H 'Referer: https://www.apple.com/ca/shop/product/G0UQ0LL/A/Refurbished-133-inch-MacBook-Pro-31GHz-dual-core-Intel-Core-i5-with-Retina-display-Silver' -H 'Accept: */*' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4' -H 'X-Requested-With: XMLHttpRequest' | perl -MJSON -e 'my $h=from_json(<>); print $h->{"body"}{"content"}{"deliveryMessage"}{"G0UQ0LL/A"}{"deliveryOptionMessages"}->[0]')
  if [[ ${res,,} == 'in stock' ]]; then
    if [[ $lastStatus31 -ne 1 ]]; then
      notify "MacBook Pro 3.1GHz" "MacBook Pro 3.1GHZ Available"
      lastStatus31=1
    fi
  elif [[ ${res,,} == 'out of stock' ]]; then
    if [[ $lastStatus31 -ne 2 ]]; then
      echo $(date) 'Macbook Pro 3.1GHz Still not available'
      lastStatus31=2
    fi
  else
    if [[ $lastStatus31 -ne 3 ]]; then
      notify "MacBook Pro 3.1GHz" "Script Error. Please check server."
      lastStatus31=3
    fi
  fi

  #MBP 3.5GHz
  res=$(curl -s 'https://www.apple.com/ca/shop/delivery-message?parts.0=G0UQ4LL%2FA&_=1507050859330' -XGET -H 'DNT: 1' -H 'Referer: https://www.apple.com/ca/shop/product/G0UQ4LL/A/Refurbished-133-inch-MacBook-Pro-35GHz-dual-core-Intel-Core-i7-with-Retina-display-Silver' -H 'Accept: */*' -H 'Cache-Control: max-age=0' -H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_5) AppleWebKit/603.2.4 (KHTML, like Gecko) Version/10.1.1 Safari/603.2.4' -H 'X-Requested-With: XMLHttpRequest' | perl -MJSON -e 'my $h=from_json(<>); print $h->{"body"}{"content"}{"deliveryMessage"}{"G0UQ4LL/A"}{"deliveryOptionMessages"}->[0]')
  if [[ ${res,,} == 'in stock' ]]; then
    if [[ $lastStatus35 -ne 1 ]]; then
      notify "MacBook Pro 3.5GHz" "MacBook Pro 3.5GHZ Available"
      lastStatus35=1
    fi
  elif [[ ${res,,} == 'out of stock' ]]; then
    if [[ $lastStatus35 -ne 2 ]]; then
      echo $(date) 'Macbook Pro 3.5GHz Still not available'
      lastStatus35=2
    fi
  else
    if [[ $lastStatus35 -ne 3 ]]; then
      notify "MacBook Pro 3.5GHz" "Script Error. Please check server."
      lastStatus35=3
    fi
  fi

  sleep 3600

done
