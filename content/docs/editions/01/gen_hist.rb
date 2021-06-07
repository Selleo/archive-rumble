folders = %w[go-gorilla javascript-express typescript-deno typescript-nest-express]
rates = [100,500,750,1000,1250,1500,1750,2000,2250,2500,2750,3000,3250,3500,3750,4000,4250,4500,4750,5000,5250,5500,5750,6000]
hist = %w[0 100ms 200ms 300ms 500ms 1s 2s 3s 5s 10s Inf]
ranges = hist[0..-2].zip(hist[1..-1]).map { |(from, to)| "[#{from} , #{to})" }
cutlen = "Bucket           ".size


res = {}
rates.each do |rate|
  folders.each do |folder|
    output = `cat results/#{folder}/results_dur-60s_rate-#{rate}.bin | vegeta report -type="hist[0,100ms,200ms,300ms,500ms,1s,2s,3s,5s,10s]"`
    lines = output.split("\n")
    lines.shift

    lines.each_with_index do |line, i|
      res[folder] ||= {}
      res[folder][rate] ||= {}

      line = line[cutlen..-1]
      _reqs, percent = line.split(/\s+/)[0..1]
      res[folder][rate][ranges[i]] = percent
    end
  end
end

rates.each do |rate|
  puts "| <b>rate #{rate}</b> | | | | |"
  ranges.each do |range|
    print "| "
    print range.ljust(15)
    print " | "
    folders.each do |folder|
      print res[folder][rate][range] 
      print " | "
    end
    puts
  end
end
