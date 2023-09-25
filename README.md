## Build the environment
```
make remove_environment ; make install_dependencies
```

## Environment variables
```
DBT_HOST=<DBT_HOST>
DBT_USERNAME=<DBT_USERNAME>
DBT_PASSWORD=<DBT_PASSWORD>
DBT_DB_NAME=<DBT_DB_NAME>
```

## Example model run
```
bash run.sh 'tag:annotation_output+ --threads 1'
```