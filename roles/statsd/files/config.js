{
    influxdb: {
        database: 'symfony',
        username: 'root',
        password: 'root',
        flush: { enable: true }
    },
    backends: [ 'statsd-influxdb-backend' ]
}
