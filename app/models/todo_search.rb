class TodoSearch
    attr_reader :datetime_from, :datetime_to

    def initialize(params, user_id)
        params ||= {}
        @datetime_from = stringify_datetime("datetime_from", params)
        @datetime_to = stringify_datetime("datetime_to", params)
        @include_datetime = params[:include_datetime].to_i == 1

        @search = params[:search]
        @include_search = params[:include_search].to_i == 1

        @sort_by = params[:sort_by]

        @user_id = user_id
    end

    def scope
        todos = Todo.where('user_id = ?', @user_id)

        if @include_search
            todos = todos.where('title LIKE ?', @search)
        end

        if @include_datetime
            todos = todos.where('due BETWEEN ? AND ?', @datetime_from, @datetime_to)
        end

        if @sort_by == 'Date - Latest first' || @sort_by == ''
            todos = (todos.sort_by{ |e| e.due.to_i }).reverse!
        elsif @sort_by == 'Date - Oldest first'
            todos = todos.sort_by{ |e| e.due.to_i }
        elsif @sort_by == 'A - Z'
            todos = todos.sort_by{ |e| e.title.downcase }
        elsif @sort_by == 'Z - A'
            todos = (todos.sort_by{ |e| e.title.downcase }).reverse!
        end

        return todos
    end

    private

    def stringify_datetime(datetime_name, params)
        DateTime.civil(params[datetime_name + "(1i)"].to_i,
                       params[datetime_name + "(2i)"].to_i,
                       params[datetime_name + "(3i)"].to_i,
                       params[datetime_name + "(4i)"].to_i,
                       params[datetime_name + "(5i)"].to_i,
                       params[datetime_name + "(6i)"].to_i,
                       0).to_formatted_s(:db)
    end
end
