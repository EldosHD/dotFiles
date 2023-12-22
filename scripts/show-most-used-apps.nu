history | get command | split words | collect { |block| for e in $block {if ($e | is-empty) {print ""} else {print $e.0}} }
