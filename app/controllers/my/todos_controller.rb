class My::TodosController < ApplicationController
    before_action :find_todo, only: [:show, :edit, :update, :destroy]

    def index
        @todos = current_user.todos.all
    end

    def show
    end

    def new

    end

    def create
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def find_todo
        @todo = Todo.find(params[:id])
    end

    def todo_params
        params.require('todo').permit(:title, :text, :datetime)
    end
end
