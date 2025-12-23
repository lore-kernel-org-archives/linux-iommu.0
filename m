Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E0298CB7
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766459661; cv=none; b=L1fa510SNTtJL8PRP5vLSAZ6DZpbJWBH6JnBGoWifgYaxiN6csLjGUnZhDMOyR7MjTbffk3hQcAmyE8j1l7SxiXRuiwzfJ9tfBZ2/9ISMv4SL6JUAXHLOOQ/y653s/sn5IwlxhPt4MIBrjYj5qbYaFVJfVA11v4Rg1ZJ4u7hMcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766459661; c=relaxed/simple;
	bh=48b209YfRYs31qbd4vjaPFxDJfGc+BacdpZKxBd3P44=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RX4GXDYdZ/MSVA7Jep09xuTScsOLrY/MQRocsopx8WfyRvlLW1/Z1Me4WFFrtfmCAERi/Q0irDw/fR0vnj2qBC46NCAUkS2BLMErZ+x+z/6wChdAh1cCpUEPz/NzWQD8e0t1UIA+pa+1KZmUKFkKAWiqLL86/2K6eYqJG6fkyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=YQCfeFb/; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="YQCfeFb/"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4Vk7xC2ig0b1ytsdJwh+khSE9JNEWNYJos7q5XCi9c8=;
	b=YQCfeFb/uSIWqmK+OH2B/5sOlCqMLKlJAagDNZPBfajesh8V07M6MYksDaRCzVY4OYBzHXM+3
	LJG5Sn+Pfc48bSmBa8w+7Rrizbz9T93wLmPPo4s79IpTN92iWktgzAh5MkwBYSaNc15Amgx58P0
	3VqFIGASNfPegNI4KqKcAX8=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4db0QH10vfz12LFs;
	Tue, 23 Dec 2025 11:11:03 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3F0544056B;
	Tue, 23 Dec 2025 11:14:16 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 11:14:15 +0800
Message-ID: <918dbc66-b8ed-4b38-b147-f271137c716a@huawei.com>
Date: Tue, 23 Dec 2025 11:14:15 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] tools/dma: Add dma_map_sg support
To: Barry Song <21cnbao@gmail.com>
CC: <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
 <20251222153246.2220659-4-xiaqinxin@huawei.com>
 <CAGsJ_4yyFXmeHKwb4E7PA9ndOrB79aQKAEKSTmJEVPO1OtiqnA@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4yyFXmeHKwb4E7PA9ndOrB79aQKAEKSTmJEVPO1OtiqnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/12/23 05:10:04, Barry Song <21cnbao@gmail.com> wrote:
> On Tue, Dec 23, 2025 at 4:33 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> Support for dma_map_sg, add option '-m' to distinguish mode.
>>
>> i) Users can set option '-m' to select mode:
>>     DMA_MAP_BENCH_SINGLE_MODE=0, DMA_MAP_BENCH_SG_MODE:=1
>>     (The mode is also show in the test result).
>> ii) Users can set option '-g' to set sg_nents
>>      (total count of entries in scatterlist)
>>      the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>>      e.g
>>      [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_BENCH_SG_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.4 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.3
>>      [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_BENCH_SINGLE_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.0 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.5
>>
>> Reviewed-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   tools/dma/dma_map_benchmark.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/dma/dma_map_benchmark.c b/tools/dma/dma_map_benchmark.c
>> index dd0ed528e6df..39102330a43f 100644
>> --- a/tools/dma/dma_map_benchmark.c
>> +++ b/tools/dma/dma_map_benchmark.c
>> @@ -26,6 +26,8 @@ int main(int argc, char **argv)
>>          int fd, opt;
>>          /* default single thread, run 20 seconds on NUMA_NO_NODE */
>>          int threads = 1, seconds = 20, node = -1;
>> +       /* default single map mode */
>> +       int map_mode = DMA_MAP_BENCH_SINGLE_MODE;
>>          /* default dma mask 32bit, bidirectional DMA */
>>          int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
>>          /* default granule 1 PAGESIZE */
>> @@ -33,7 +35,7 @@ int main(int argc, char **argv)
>>
>>          int cmd = DMA_MAP_BENCHMARK;
>>
>> -       while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>> +       while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:m:")) != -1) {
>>                  switch (opt) {
>>                  case 't':
>>                          threads = atoi(optarg);
>> @@ -56,11 +58,20 @@ int main(int argc, char **argv)
>>                  case 'g':
>>                          granule = atoi(optarg);
>>                          break;
>> +               case 'm':
>> +                       map_mode = atoi(optarg);
>> +                       break;
>>                  default:
>>                          return -1;
>>                  }
>>          }
>>
>> +       if (map_mode < 0 || map_mode >= DMA_MAP_BENCH_MODE_MAX) {
>> +               fprintf(stderr, "invalid map mode, SINGLE_MODE:%d, SG_MODE: %d\n",
>> +                       DMA_MAP_BENCH_SINGLE_MODE, DMA_MAP_BENCH_SG_MODE);
>> +               exit(1);
>> +       }
>> +
>>          if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
>>                  fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
>>                          DMA_MAP_MAX_THREADS);
>> @@ -110,13 +121,15 @@ int main(int argc, char **argv)
>>          map.dma_dir = dir;
>>          map.dma_trans_ns = xdelay;
>>          map.granule = granule;
>> +       map.map_mode = map_mode;
>>
>>          if (ioctl(fd, cmd, &map)) {
>>                  perror("ioctl");
>>                  exit(1);
>>          }
>>
>> -       printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
>> +       printf("dma mapping mode: %d\n", map_mode);
>> +       printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule/sg_nents: %d\n",
> 
> Why can’t we print mode on this line,
> and why isn’t the integer converted to a string
> like directions?
> 
> Thanks
> Barry

Agreed. I'll fix the print format in the next version.

-- 
Thanks,
Qinxin

