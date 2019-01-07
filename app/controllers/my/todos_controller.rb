class My::TodosController < ApplicationController
    #before every action, find the todo belonging with the given todo id
    before_action :find_todo, only: [:show, :edit, :update, :destroy]

    def index
        #set @todos to be a new TodoSearch with the scope defined under the todo_search model
        @todos = TodoSearch.new(todosearch_params, current_user.id).scope
    end

    def show
    end

    def new
        #set @todos to be a new todo under the current user
        @todo = current_user.todos.new
    end

    def create
        #set @todos to have the params of the submitted form
        @todo = current_user.todos.new(todo_params)
        #if the todo item saves, redirect to index of todos, else render new todo
        if @todo.save
            redirect_to my_todos_path
        else
            render new_my_todo_path
        end
    end

    def edit
    end

    def update
        #if todo updates, redirect to show page of the todo, else render edit todo
        if @todo.update(todo_params)
            redirect_to my_todo_path(@todo)
        else
            render edit_my_todo_path(@todo)
        end
    end

    def destroy
        #destroy the todo and redirect to index
        @todo.destroy
        redirect_to my_todos_path
    end

    private

    def find_todo
        #find the todo with the given todo id
        @todo = current_user.todos.find(params[:id])
    end

    def todo_params
        #strong params for creating a new todo
        params.require(:todo).permit(:title, :description, :due)
    end

    def todosearch_params
        #strong params for a todo search
        params[:todosearch] ||= { is_empty: true }
        params.require(:todosearch).permit(:include_search, :search, :include_datetime, :sort_by,
                                     "datetime_from(1i)", "datetime_from(2i)", "datetime_from(3i)",
                                     "datetime_from(4i)", "datetime_from(5i)", "datetime_from(6i)",
                                     "datetime_to(1i)", "datetime_to(2i)", "datetime_to(3i)",
                                     "datetime_to(4i)", "datetime_to(5i)", "datetime_to(6i)")
    end
end
