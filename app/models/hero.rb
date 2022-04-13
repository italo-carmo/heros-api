class Hero < ApplicationRecord
    validates :name, :token, presence: true
    #criando um scope chamado sorted_by_name
    scope :sorted_by_name, -> {order(:name)}
    #poderia ser:
    #scope :sorted_by_name, -> {order(name: :desc)} isso é igual a :name => :desc
    #scope para filtrar por nome
    scope :search_by_name, ->(term) {where('LOWER(name) LIKE ?', "%#{term.downcase}%") if term.present?}
    #filtrar por token
    scope :by_token, ->(token) {where(token: token)}
end
