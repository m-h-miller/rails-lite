module Phase2
  class ControllerBase
    attr_reader :req, :res

    # Setup the controller
    def initialize(req, res)
      @req, @res = req, res
      @already_built_response = false
    end

    # Helper method to alias @already_built_response
    def already_built_response?
      @already_built_response
    end

    # Set the response status code and header
    def redirect_to(url)
      raise "Error: double render or redirect" if already_built_response?

      @res.status = 302
      @res['Location'] = url

      @already_built_response = true
      nil
    end

    # Populate the response with content.
    # Set the response's content type to the given type.
    # Raise an error if the developer tries to double render.
    def render_content(content, content_type)
      raise "Error: already built response" if already_built_response?

      @res.body = content
      @res.content_type = content_type

      @already_built_response = true
      nil
    end
  end
end
