# frozen_string_literal: true

require 'readline'
require_relative './lib/account'

@account = Account.new

MENU = [
  '> menu or 0 -> Show options',
  '> payable or 1 -> Add a payable account',
  '> receivable or 2 -> Add a receivable account',
  '> balance or 3 -> Show the current balance of the month',
  '> report or 4 -> Show a month budget report',
  '> exit or 5 -> Quit the CLI'
].freeze

CATEGORIES = Account::CATEGORIES.map { |key, value| "#{value} => #{key}" }.freeze

def add_payable
  params = {}
  params[:description] = Readline.readline('Payable description > ')
  params[:amount] = Readline.readline('Amount > ')
  params[:deadline_year] = Readline.readline('Deadline month (2021..) > ')
  params[:deadline_month] = Readline.readline('Deadline month (1-12) > ')
  params[:deadline_day] = Readline.readline('Deadline day (1-31) > ')
  puts 'Choose one one these categories'
  puts CATEGORIES
  params[:category] = Readline.readline(
    '> '
  )
  params[:status] = Readline.readline('Status (Opened/Finished) > ')
  @account.add_payable(params)
  puts 'Added a payable account.'
end

loop do
  puts 'Type "menu" to see all the options'
  line = Readline.readline('> ')
  break if line.nil? || line == 'exit'

  case line
  when 'menu', '0'
    puts MENU
  when 'payable', '1'
    add_payable
  when 'receivable', '2'
    account.add_receivable
  when 'balance', '3'
    account.balance
  when 'report', '4'
    month = Readline.readline('Type the month > ')
    year = Readline.readline('Type the year > ')
    puts "Relatório do mês #{month}, de #{year}"
    @account.month_budget(month.to_i, year.to_i)
  when '5'
    puts 'Goodbye, see you soon'
    break
  else
    puts 'Opção não encontrada'
  end
end

private
