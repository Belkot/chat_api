json.array!(@messages) { |message| json.message message, :id, :text, :user_name, :create_time }
