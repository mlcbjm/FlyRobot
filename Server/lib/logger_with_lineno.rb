# -*- encoding : utf-8 -*-

if ENV['OS'] == 'Windows_NT'
  def _l param, logtype = "LOG", caller = 1
    _p  = caller(0)[caller].split("/")[-1]
    p = "#{_p.split(":")[0]}:#{_p.split(":")[1]}"
    str = "[#{Time.now.strftime("%y-%m-%d %H:%M:%S.%-3N")}] [#{logtype}][#{p}] #{param}"
    puts str
    $stdout.flush
  end

  #debug
  def d param
    _l "\x1b[0;32;40m#{param}\x1b[0m", "DBG", 2
  end

  def l param
#    return
    _l "\x1b[0;36;40m#{param}\x1b[0m", "LOG", 2
  end


  def w param
    _l "\x1b[0;33;40m#{param}\x1b[0m", "WNG", 2
    $stderr.puts param
    $stderr.flush
  end

  # error
  def e param
    _l "\x1b[0;31;40m#{param}\x1b[0m", "ERR", 2
    $stderr.puts Time.now.strftime("%y-%m-%d %H:%M:%S.%-3N")
    $stderr.puts param
    $stderr.flush
  end

  # flashing!
  def f param
#    _l "\x1b[0;33;5m\x1b[1;33;44m#{param}  \n  \n\x1b[0m", "FLH", 2
    _l "\x1b[1;33;29m#{param}  \n  \n\x1b[0m", "FLH", 2
  end

  # blink!
  def b param
    #  _l "\x1b[0;100;93m#{param}\x1b[0m", "BLK", 2
    _l "\x1b[5;40;95m#{param}\x1b[0m", "BLK", 2
  end

  # send /recv log
  def _lrg r1, r2, r3
    _l r1, r2, r3
  end # def _lg r1, r2


  def ___l_send_log param
    _lrg "\x1b[1;44;36m#{param}\x1b[0m", "l_send", 3
  end

  def ___r_send_log param
    _lrg "\x1b[1;44;32m#{param}\x1b[0m", "r_send", 3
  end

  def ___b_send_log param
    _lrg "\x1b[1;44;35m#{param}\x1b[0m", "b_send", 3
  end

  def ___recv_log param
    _lrg "\x1b[1;30;47m#{param}\x1b[0m", "recv", 3
  end

else
  def _l param, logtype = "LOG", caller = 1
    _p  = caller(0)[caller].split(":")
    p = "#{_p[0].split("/")[-1]}:#{_p[1]}"
    str = "[#{Time.now.strftime("%y-%m-%d %H:%M:%S.%-3N")}] [#{logtype}][#{p}] #{param}"
    puts str
    $stdout.flush
  end

  #debug
  def d param
    _l "\x1b[0;32;40m#{param}\x1b[0m", "DBG", 2
#    Obsidian.log ["DBG"], "\x1b[1;32;40m#{param}\x1b[0m", "Base", "Jadeite", false
  end

  def l param
#    return
    _l "\x1b[0;36;40m#{param}\x1b[0m", "LOG", 2
  end


  def w param
    _l "\x1b[0;33;40m#{param}\x1b[0m", "WNG", 2
    # $stderr.puts param
    # $stderr.flush
  end

  # error
  def e param
    _l "\x1b[0;31;40m#{param}\x1b[0m", "ERR", 2
    # $stderr.puts Time.now.strftime("%y-%m-%d %H:%M:%S.%-3N")
    # $stderr.puts param
    $stderr.flush
  end

  # flashing!
  def f param
#    _l "\x1b[0;33;5m\x1b[1;33;44m#{param}  \n  \n\x1b[0m", "FLH", 2
    _l "\x1b[1;33;29m#{param}  \n  \n\x1b[0m", "FLH", 2
  end

  # blink!
  def b param
    #  _l "\x1b[0;100;93m#{param}\x1b[0m", "BLK", 2
    _l "\x1b[5;40;95m#{param}\x1b[0m", "BLK", 2
  end

  # send /recv log
  def _lrg r1, r2, r3
    _l r1, r2, r3
  end # def _lg r1, r2


  def ___l_send_log param
    _lrg "\x1b[1;44;36m#{param}\x1b[0m", "l_send", 3
  end

  def ___r_send_log param
    _lrg "\x1b[1;44;32m#{param}\x1b[0m", "r_send", 3
  end

  def ___b_send_log param
    _lrg "\x1b[1;44;35m#{param}\x1b[0m", "b_send", 3
  end

  def ___recv_log param
    _lrg "\x1b[1;30;47m#{param}\x1b[0m", "recv", 3
  end

end
