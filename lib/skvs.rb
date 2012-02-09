require "skvs/version"
require "sinatra"
require "redis"
require "cgi"

get "/" do
  keys = redis.keys("skvs:#{params[:q]}*").sort
  @count = keys.count
  keys = keys.first(load_count + 1)

  if keys.size > load_count
    keys.pop
    @oversized = true
  end

  if keys.any?
    values = redis.mget(*keys)
    @data = keys.map{|k| k.split(":", 2).last }.zip(values)
  else
    @data = []
  end

  erb :index
end

get "/*" do
  content_type "text/plain"
  redis_get params[:splat]
end

put "/*" do
  redis_set params[:splat], request.body.read
  nil
end

post "/_set" do
  redis_set params[:key], params[:value]
  redirect url("/")
end

helpers do
  def load_count
    [params[:load_count].to_i, 5].max
  end

  def h(v)
    CGI.escapeHTML(v)
  end

  def hbr(v)
    CGI.escapeHTML(v).gsub("\n", "\n<br/>")
  end

  def key(*k)
    "skvs:#{k.flatten.join("/")}"
  end

  def redis
    @redis ||= Redis.new
  end

  def redis_set(k, v)
    if v.to_s == ""
      redis.del key(*k)
    else
      redis.set key(*k), v
    end
  end

  def redis_get(k)
    redis.get key(k)
  end
end
