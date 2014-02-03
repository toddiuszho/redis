
case "$1" in
    start)
        if [ -f "$PIDFILE" ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                echo "Starting Redis server on port $REDISPORT ..."
                $EXEC $CONF
        fi
        ;;
    status)
        if [ -f "$PIDFILE" ]
        then
                echo "Redis is running on port $REDISPORT"
        else
                echo "Redis is NOT running on port $REDISPORT"
        fi
        ;;
    stop)
        if [ ! -f "$PIDFILE" ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                PID=$(cat "$PIDFILE")
                echo "Stopping on port $REDISPORT ..."
                $CLIEXEC -h $REDISBIND -p $REDISPORT shutdown
                while [ -x /proc/${PID} ]
                do
                    echo "Waiting for Redis to shutdown on port $REDISPORT ..."
                    sleep 2
                done
                echo "Redis stopped on port $REDISPORT"
        fi
        ;;
    *)
        echo "Please use start, stop, or status as first argument"
        ;;
esac

