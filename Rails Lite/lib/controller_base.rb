require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res)
    @req = req
    @res = res
    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Double render error" if already_built_response?
    # already_built_response?
    @already_built_response = true
    @res.status = 302
    @res['Location'] = url  
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type = 'text/html')
    raise "Double render error" if already_built_response?
    @already_built_response = true
    # already_built_response?
    @res['Content-Type'] = content_type
    @res.write(content)
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name) #template_name :new, :edit, :create
    dir_path =  File.dirname(__FILE__) # lib
    temp_path = File.join(
      ".",
      "views",
      "#{self.class.to_s.underscore}",
      "#{template_name}.html.erb"
    )
    temp_code = File.read(temp_path)
    render_content(ERB.new(temp_code).result(binding))
  end

  # method exposing a `Session` object
  def session
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    
  end
end

