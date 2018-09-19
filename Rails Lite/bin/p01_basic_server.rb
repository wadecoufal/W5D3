require 'rack'

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  res['Content-Type'] = 'text/html'
  res.write("#{req.path}")
  res.finish
end

Rack::Server.start(
  app: app,
  Port: 3000
)

#creating an app with a proc to accept the call method
#creating new req and res objects
#req takes in the environment hash
#manipulates response, saves it and returns it back to the server

#in the server we are calling the app we created and pushing it up to Port: 3000
