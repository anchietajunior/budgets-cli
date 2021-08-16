# frozen_string_literal: true

require 'pry'
require 'csv'
require 'bigdecimal'
require 'terminal-table'

# This class is responsible for the accounts
class Account
  TYPES = {
    payable: 1,
    receivable: 2
  }.freeze

  HEADERS = [:type, :description, :amount, :deadline, :category, :created_at].freeze

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

  def initialize
    @file = './history.csv'

    return if File.exist?(@file)

    puts 'File does not exist'

    CSV.open(@file, 'w')
  end

  def reload_file
    @file = './history.csv'
  end

  def add_payable(params)
    write_to_csv('1', params)
  end

  def add_receivable(params)
    write_to_csv('2', params)
  end

  def balance; end

  def month_budget(date)
    year, month = date.split("-")
    file = CSV.read(@file)

    accounts = file.select do |a|
      Time.at(a[3].to_i).month == month.to_i && Time.at(a[3].to_i).year == year.to_i
    end

    if accounts.empty?
      puts "No accounts found for #{date}"
      return
    end

    mount_table(accounts.sort_by { |item| [item[3], item[0]] })
  end

  def year_budget(year)
    file = CSV.read(@file)

    accounts = file.select do |a|
      Time.at(a[3].to_i).year == year
    end

    mount_table(accounts.sort_by { |item| [item[3], item[0]] })
  end

  def categories_table
    table = Terminal::Table.new :title => 'Categories', :headings => ['Category', 'Code'], :rows => CATEGORIES.map do |k, v|
      [v, k]
    end

    puts table
  end

  private

  def write_to_csv(type, params)
    CSV.open(@file, 'a') do |csv|
      csv << format_params(type, params)
    end
  end

  def format_params(type, params)
    year, month, day = params[:deadline].split('-')
    [
      type,
      params[:description],
      BigDecimal(params[:amount]),
      Time.new(year.to_i, month.to_i, day.to_i).to_i,
      params[:category],
      Time.now.to_i
    ]
  end

  def to_bigdecimal(number)
    (BigDecimal(number).truncate(2).to_s('F') + '00')[ /.*\..{2}/ ]
  end

  def string_to_bigdecimal(number)
    BigDecimal(number)
  end

  def mount_table(accounts)
    table = Terminal::Table.new do |t|
      t.title = 'Report'
      t.headings = HEADERS
      accounts.each do |a|
        a[0] = a[0] == '1' ? 'payable' : 'receivable'
        a[2] = to_bigdecimal(a[2])
        a[3] = Time.at(a[3].to_i).strftime('%Y-%m-%d')
        a[4] = a[4] = CATEGORIES.key(a[4].to_i) || a[4]
        a[5] = Time.at(a[5].to_i).strftime('%Y-%m-%d')
        t.add_row a
      end
      t.add_separator
      receivale_values = accounts.select { |a| a[0] == 'receivable' }.sum { |a| string_to_bigdecimal(a[2]) }
      payable_values = accounts.select { |a| a[0] == 'payable' }.sum { |a| string_to_bigdecimal(a[2]) }
      balance = receivale_values - payable_values
      t.add_row ['Balance: ', to_bigdecimal(balance), nil, nil, nil, nil]
    end

    puts table
  end
end
