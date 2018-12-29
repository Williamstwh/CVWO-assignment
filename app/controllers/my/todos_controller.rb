class My::TodosController < ApplicationController
    before_action :find_todo, only: [:show, :edit, :update, :destroy]

    def index
        @todos = current_user.todos.where("title LIKE ?", params[:search])
        if params[:includeRange]
            @todos = @todos.select do |todo|
                todo.due > convert_to_datetime("startRange", params) && todo.due < convert_to_datetime("endRange", params)
            end
        elsif @todos.length == 0
            @todos = current_user.todos.all
        else
        end
    end

    def show
    end

    def new
        @todo = current_user.todos.new
    end

    def create
        @todo = current_user.todos.new(todo_params)
        if @todo.save
            redirect_to my_todos_path
        else
            render new_my_todo_path
        end
    end

    def edit
    end

    def update
        if @todo.update(todo_params)
            redirect_to my_todo_path(@todo)
        else
            render edit_my_todo_path(@todo)
        end
    end

    def destroy
        @todo.destroy
        redirect_to my_todos_path
    end

    private

    def find_todo
        @todo = current_user.todos.find(params[:id])
    end

    def todo_params
        params.require('todo').permit(:title, :description, :due)
    end

    def convert_to_datetime(name, params)
        params[name + "(1i)"] + "-" +
        params[name + "(2i)"] + "-" +
        params[name + "(3i)"] + " " +
        params[name + "(4i)"] + ":" +
        params[name + "(5i)"]
    end
end
