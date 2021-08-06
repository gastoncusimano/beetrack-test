module Response
    def json_response messages, is_success, status
      render json: { 
        messages: messages,
        is_success: is_success,
      }, status: status
    end
end  