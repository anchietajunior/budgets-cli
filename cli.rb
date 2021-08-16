# frozen_string_literal: true

require 'readline'
require_relative './lib/account'

@times_to_show_message = 1
@account = Account.new

MENU = [
  '> (1 or menu) -> Show options',
  '> (2) -> Add a payable account',
  '> (3) -> Add a receivable account',
  '> (4) -> Show a report by month and year',
  '> (5) -> Show a report by year',
  '> (0) -> Quit the CLI'
].freeze

CATEGORIES = Account::CATEGORIES.map { |key, value| "#{value} => #{key}" }.freeze

def add_payable
  params = {}
  params[:description] = Readline.readline('Payable description > ')
  params[:amount] = Readline.readline('Amount > ')
  params[:deadline] = Readline.readline('Year-Month-Date like (2021-1-1) > ')
  @account.categories_table
  params[:category] = Readline.readline('Category > ')
  @account.add_payable(params)
  puts 'Ok!'
  @account.reload_file
end

def add_receivable
  params = {}
  params[:description] = Readline.readline('Receivable description > ')
  params[:amount] = Readline.readline('Amount > ')
  params[:deadline] = Readline.readline('Year-Month-Date like (2021-1-1) > ')
  params[:category] = 'receivable'
  @account.add_receivable(params)
  puts 'Ok!'
  @account.reload_file
end

loop do
  unless @times_to_show_message > 1
    puts 'Type menu or 1 to see the options'
    @times_to_show_message = 2
  end
  line = Readline.readline('> ')
  break if line.nil? || line == 'exit'

  case line
  when 'menu', '1'
    puts MENU
  when '2'
    add_payable
  when '3'
    add_receivable
  when '4'
    date = Readline.readline('Year-Month like (2021-1) > ')
    puts "Searching accounts.. \n\n"
    @account.month_budget(date)
  when '5'
    year = Readline.readline('Year like (2021) > ')
    puts "Searching accounts.. \n\n"
    @account.year_budget(year.to_i)
  when '0'
    puts 'Goodbye, see you soon'
    break
  else
    puts 'Type 1 to see menu with options'
  end
end