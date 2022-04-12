class Hero < ApplicationRecord
    validates :name, presence: true
    #criando um scope chamado sorted_by_name
    scope :sorted_by_name, -> {order(:name)}
    #poderia ser:
    #scope :sorted_by_name, -> {order(name: :desc)} isso é igual a :name => :desc
end
