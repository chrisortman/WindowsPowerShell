#$callTimes = ('00:01:09','00:00:07','00:07:22','01:21:16','00:07:03','00:00:06','00:00:11','00:00:06','01:21:28')
$callTimes = ('00:01:19','00:00:55','00:06:02')
$totalTicks = 0
$callTimes | %{
    $ts = [System.TimeSpan]::Parse($_);
    $totalTicks += $ts.Ticks;
}

$tsTotal = new-object -TypeName System.TimeSpan -ArgumentList ($totalTicks / $callTimes.Length)

$tsTotal
