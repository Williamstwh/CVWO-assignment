class TodoSearch
    #create getter methods for @datetime_from and @datetime_to
    attr_reader :datetime_from, :datetime_to

    def initialize(params, user_id)
        #params is nil, set it to an empty object as functions below expect an object from params
        params ||= {}
        #convert datetime_from to string in database format
        @datetime_from = stringify_datetime("datetime_from", params)
        #convert datetime_to to string in database format
        @datetime_to = stringify_datetime("datetime_to", params)
        #A boolean which determines whether datetime should be included
        @include_datetime = params[:include_datetime].to_i == 1

        #contents of search result
        @search = params[:search]
        #A boolean which determines whether the search reuslt should be included
        @include_search = params[:include_search].to_i == 1

        #Option for how the resulting table should be sorted by - alphabetical/due and ascending/descending
        @sort_by = params[:sort_by]

        #current user id
        @user_id = user_id
    end

    def scope
        #Finds all the todos belonging to the current user
        todos = Todo.where('user_id = ?', @user_id)

        #if included, narrows all the todos to those that are like the content of the search result
        if @include_search
            todos = todos.where('title LIKE ?', @search)
        end

        #if included, narrows all todos within the datetime range specified by the user
        if @include_datetime
            todos = todos.where('due BETWEEN ? AND ?', @datetime_from, @datetime_to)
        end

        #If selection is to 'sort by date' with latest at the top of the table, or no selection is made
        if @sort_by == 'Date - Latest first' || @sort_by == ''
            #converts datetime of each 'due' field of todos array to an integer, sorts it, then reverses it
            todos = (todos.sort_by{ |e| e.due.to_i }).reverse!
        #If selection is to 'sort by date' with oldest at the top of the table
        elsif @sort_by == 'Date - Oldest first'
            #converts datetime of each 'due' field of todos array to an integer then sorts it
            todos = todos.sort_by{ |e| e.due.to_i }
        #If selection is to sort by alphabetical order from A - Z
        elsif @sort_by == 'A - Z'
            #downcases the title of each todoitem then sorts it
            todos = todos.sort_by{ |e| e.title.downcase }
        #If selection is to sort by alphabetical order from z - A
        elsif @sort_by == 'Z - A'
            #downcases the title of each todoitem, sorts it, then reverses it
            todos = (todos.sort_by{ |e| e.title.downcase }).reverse!
        end

        return todos
    end

    private
    #Converts a datetime in params to a string in database format
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
