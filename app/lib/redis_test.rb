class RedisTest
  REDIS.multi do |r|
    r.set('test', 'value')
    r.set('test:time', Time.now)
  end
end
