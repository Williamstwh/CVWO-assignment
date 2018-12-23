class My::TodosController < ApplicationController
    before_action :find_todo, only: [:show, :edit, :update, :destroy]

    def index
        @todos = current_user.todos.all
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
end
