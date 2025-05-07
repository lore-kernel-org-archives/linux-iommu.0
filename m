Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC47230BC6
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609528; cv=none; b=pe22EfiPoqL0L4VW9F84xSY8Q+rE2TLB0xsVVOcrMM0PvFwGGN5ZYa9c6MF/5na8XrSzxSZfmMFGn+Yc+ZfIygWoSKHYo5kk8bxbDCmdp/D/h39Wmx+J6RpVSIUqpJF6qfWf41+L4pEzlRoKZMuiPRgm/0sMImyfonRvey79wfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609528; c=relaxed/simple;
	bh=SBTM+97yj7LnuC02Bf+irApFxk8LmWEENlllYyjkA9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QT0eUazXjjLUUgJYAIbtoIJWbG5HxjuzfTqzcrhM2e4UefZfORqE1Pd63V79xuyOJKwNZurKNK4X+vtOEBdoLPfZ49OeuDJ3VMMGF28rmZy5iIRb+bzrLL1ETj0TidFlSn3Xtcehn3n8n/Ay7Tso0yRbbB1+a6dIUzp4Jr2IIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4ZsqR76b9Pznfdf;
	Wed,  7 May 2025 17:17:23 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 3E86B1402C7;
	Wed,  7 May 2025 17:18:42 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:18:41 +0800
Message-ID: <ddee8f35-0bf9-44e3-b84d-f1a833032da5@huawei.com>
Date: Wed, 7 May 2025 17:18:41 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dma mapping benchmark:add support for dma_map_sg
To: Barry Song <21cnbao@gmail.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
 <20250506030100.394376-5-xiaqinxin@huawei.com>
 <CAGsJ_4z9oYtCkdXqk=s+F4ZFrjCan+-AuGqRQDeQcXcswPzaHw@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4z9oYtCkdXqk=s+F4ZFrjCan+-AuGqRQDeQcXcswPzaHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/5/7 10:44, Barry Song 写道:
> On Tue, May 6, 2025 at 3:01 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> Support for dma_map_sg, add option '-m' to distinguish mode.
>>
>> i) Users can set option '-m' to select mode:
>>     DMA_MAP_SINGLE_MODE=0, DMA_MAP_SG_MODE:=1
>>     (The mode is also show in the test result).
>> ii) Users can set option '-g' to set sg_nents
>>      (total count of entries in scatterlist)
>>      the maximum number is 1024. Each of sg buf size is PAGE_SIZE.
>>      e.g
>>      [root@localhost]# ./dma_map_benchmark -m 1 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_SG_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.4 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.3
>>      [root@localhost]# ./dma_map_benchmark -m 0 -g 8 -t 8 -s 30 -d 2
>>      dma mapping mode: DMA_MAP_SINGLE_MODE
>>      dma mapping benchmark: threads:8 seconds:30 node:-1
>>      dir:FROM_DEVICE granule/sg_nents: 8
>>      average map latency(us):1.0 standard deviation:0.3
>>      average unmap latency(us):1.3 standard deviation:0.5
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
> Either merge this into the previous patch or use the correct prefix in the
> subject to differentiate patch 3 from patch 4. For example: selftests/dma

Okay, I'll fix this in the next version.

Thanks!

>> ---
>>   tools/testing/selftests/dma/dma_map_benchmark.c | 16 ++++++++++++++--
>>   1 file changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
>> index b12f1f9babf8..036ddb5ac862 100644
>> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
>> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
>> @@ -27,6 +27,7 @@ int main(int argc, char **argv)
>>          int fd, opt;
>>          /* default single thread, run 20 seconds on NUMA_NO_NODE */
>>          int threads = 1, seconds = 20, node = -1;
>> +       int map_mode = DMA_MAP_SINGLE_MODE;
>>          /* default dma mask 32bit, bidirectional DMA */
>>          int bits = 32, xdelay = 0, dir = DMA_MAP_BIDIRECTIONAL;
>>          /* default granule 1 PAGESIZE */
>> @@ -34,7 +35,7 @@ int main(int argc, char **argv)
>>
>>          int cmd = DMA_MAP_BENCHMARK;
>>
>> -       while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>> +       while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:m:")) != -1) {
>>                  switch (opt) {
>>                  case 't':
>>                          threads = atoi(optarg);
>> @@ -57,11 +58,20 @@ int main(int argc, char **argv)
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
>> +       if (map_mode >= DMA_MAP_MODE_MAX) {
>> +               fprintf(stderr, "invalid map mode, DMA_MAP_SINGLE_MODE:%d, DMA_MAP_SG_MODE:%d\n",
>> +                       DMA_MAP_SINGLE_MODE, DMA_MAP_SG_MODE);
>> +               exit(1);
>> +       }
>> +
>>          if (threads <= 0 || threads > DMA_MAP_MAX_THREADS) {
>>                  fprintf(stderr, "invalid number of threads, must be in 1-%d\n",
>>                          DMA_MAP_MAX_THREADS);
>> @@ -111,13 +121,15 @@ int main(int argc, char **argv)
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
>>                          threads, seconds, node, dir[directions], granule);
>>          printf("average map latency(us):%.1f standard deviation:%.1f\n",
>>                          map.avg_map_100ns/10.0, map.map_stddev/10.0);
>> --
>> 2.33.0
>>
> Thanks
> Barry
