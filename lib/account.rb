# frozen_string_literal: true

require 'pry'
require 'csv'
require 'bigdecimal'
require 'tty-table'

# This class is responsible for the accounts
class Account
  TYPES = {
    payable: 1,
    receivable: 2
  }.freeze

  CATEGORIES = {
    habitation: 1,
    'supermarket': 2,
    transportation: 3,
    credit_card: 4,
    pet: 5,
    health: 6,
    investments: 7,
    'phone and internet': 8,
    recreation: 9,
    eletronics: 10,
    personal: 11,
    gas: 12,
    delivery: 13
  }.freeze

  STATUSES = {
    opened: 1,
    finished: 2
  }.freeze

  def initialize
    @file = './history.csv'

    return if File.exist?(@file)

    puts 'File does not exist'

    CSV.open(@file, 'w') do |csv|
      csv << %w[type description amount deadline category status create_at]
    end
  end

  def add_payable(params)
    CSV.open(@file, 'a') do |csv|
      csv << [
        '1',
        params[:description],
        BigDecimal(params[:amount]),
        Time.new(params[:deadline_year], params[:deadline_month], params[:deadline_day]).to_i,
        params[:category],
        params[:status],
        Time.now
      ]
    end
  end

  def add_receivable; end

  def balance; end

  def month_budget(month, year)
    file = CSV.read(@file)

    payables_in_range = file.select do |a|
      a[0] == '1' && Time.at(a[3].to_i).month == month && Time.at(a[3].to_i).year == year
    end

    table = TTY::Table.new(file.first, payables_in_range.each do |a|
      a[2] = BigDecimal(a[2]).to_f
      a[3] = Time.at(a[3].to_i).strftime('%y-%m-%d')
    end)
    puts table.render(:ascii)
  end
end
