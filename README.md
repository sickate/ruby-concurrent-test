# ruby-concurrent-test
Test some web servers and different concurrent diagrams

# 1. Rack Test

Get into /rack directory first.

## To test with thin:
`bundle exec thin -R config.ru start --threaded --threadpool-size 100`

## To test with puma:
`bundle exec puma -t $min-thread:$max-thread`
