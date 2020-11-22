pidfile ENV.fetch("PIDFILE") { "tmp/pids/server.pid" }
preload_app!
wait_for_less_busy_worker
nakayoshi_fork

require "barnes"
before_fork do 
  Barnes.start 
end