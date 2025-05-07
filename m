Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADDC239E97
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609293; cv=none; b=mL5AkGo9ANhEWyIZjtO2zL4a9p8nNjRqIxKJ881EAOXTGtNyKtt/AJyRG5jaCZK7AY2EJFdpqzjzsQHhoKS4nHquNUFd9GqOFCjczaS0CBSnk9WV+84wGPj5D7bYDRvb0FsOJVnZP0fPm5fG8qJrrjTqHMf4++bauHdnb4ZxdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609293; c=relaxed/simple;
	bh=ILju9IWF+HLUzQbAqYkzUNiVqYwQ/8n9JZEQhbn15zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Yl2Q8nfZkfTwFjtA/0myad3YgGGa00bgOZVTXFE075jo/Wx7vVkfesw1Wr9OhleGsMuci7rWl2HdKmq2JPabdRMztfOdvo5BnoCHT8Imb45CoeKZ5N2i4fbQl2dx73iSrcx1VgMhQcbhN3bE7Fszm+1QDe1KK4A76OQBlOeI1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZsqLg52nPz1d10k;
	Wed,  7 May 2025 17:13:31 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A94021800B2;
	Wed,  7 May 2025 17:14:48 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:14:48 +0800
Message-ID: <2f6b9715-b25a-47e3-b2d1-6852ba1038d2@huawei.com>
Date: Wed, 7 May 2025 17:14:47 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dma mapping benchmark: modify the framework to
 adapt to more map modes
To: Barry Song <21cnbao@gmail.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
 <20250506030100.394376-3-xiaqinxin@huawei.com>
 <CAGsJ_4wgxgXs6pyYUTNFmNmqHSWtPbKSUnMCzf8=rvOdhgJ04Q@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4wgxgXs6pyYUTNFmNmqHSWtPbKSUnMCzf8=rvOdhgJ04Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/5/7 10:30, Barry Song 写道:
> On Tue, May 6, 2025 at 3:01 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> In this patch map_benchmark abstract in four interface: prepare, unprepare,
>> do_map, do_unmap. When there's a new mode to add, need four steps:
>> 1) Add the mode in map_benchmark.h
>> 2) Defines the mode param, like struct dma_xxx_map_param, and this object
>>     will be return in prepare and as input parameter in other ops;
>> 3) Defines the ops functions:prepare, unprepare, do_map, do_unmap.
>> 4) Add the new mode in dma_map_benchmark_ops.
> There are too many irrelevant details.
>
> We're more interested in the reasoning behind this change than just the change
> itself. There should be some explanation of the purpose.
Okay, I'm going to add some purposeful commit information.
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   include/linux/map_benchmark.h |   8 ++-
>>   kernel/dma/map_benchmark.c    | 120 +++++++++++++++++++++++++++-------
>>   2 files changed, 104 insertions(+), 24 deletions(-)
>>
>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>> index 2ac2fe52f248..5294dfd1870f 100644
>> --- a/include/linux/map_benchmark.h
>> +++ b/include/linux/map_benchmark.h
>> @@ -15,6 +15,11 @@
>>   #define DMA_MAP_TO_DEVICE       1
>>   #define DMA_MAP_FROM_DEVICE     2
>>
>> +enum {
>> +       DMA_MAP_SINGLE_MODE,
>> +       DMA_MAP_MODE_MAX
>> +};
>> +
>>   struct map_benchmark {
>>          __u64 avg_map_100ns; /* average map latency in 100ns */
>>          __u64 map_stddev; /* standard deviation of map latency */
>> @@ -27,6 +32,7 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> -       __u8 expansion[76];     /* For future use */
>> +       __u8  map_mode; /* the mode of dma map */
>> +       __u8 expansion[75];     /* For future use */
>>   };
>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index cc19a3efea89..f04973eba1d8 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -5,6 +5,7 @@
>>
>>   #define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/cleanup.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>> @@ -31,17 +32,97 @@ struct map_benchmark_data {
>>          atomic64_t loops;
>>   };
>>
>> +struct map_benchmark_ops {
>> +       void *(*prepare)(struct map_benchmark_data *map);
>> +       void (*unprepare)(void *arg);
>> +       int (*do_map)(void *arg);
>> +       void (*do_unmap)(void *arg);
>> +};
>> +
>> +struct dma_single_map_param {
>> +       struct device *dev;
>> +       dma_addr_t addr;
>> +       void *xbuf;
>> +       u32 npages;
>> +       u32 dma_dir;
>> +};
>> +
>> +static void *dma_single_map_benchmark_prepare(struct map_benchmark_data *map)
>> +{
>> +       struct dma_single_map_param *mparam __free(kfree) = kzalloc(sizeof(*mparam),
>> +                                                                   GFP_KERNEL);
>> +       if (!mparam)
>> +               return NULL;
>> +
>> +       mparam->npages = map->bparam.granule;
>> +       mparam->dma_dir = map->bparam.dma_dir;
>> +       mparam->dev = map->dev;
>> +       mparam->xbuf = alloc_pages_exact(mparam->npages * PAGE_SIZE, GFP_KERNEL);
>> +       if (!mparam->xbuf)
>> +               return NULL;
>> +
>> +       /*
>> +        * for a non-coherent device, if we don't stain them in the
>> +        * cache, this will give an underestimate of the real-world
>> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
>> +        * 66 means evertything goes well! 66 is lucky.
>> +        */
>> +       if (mparam->dma_dir != DMA_FROM_DEVICE)
>> +               memset(mparam->xbuf, 0x66, mparam->npages * PAGE_SIZE);
>> +
>> +       return_ptr(mparam);
>> +}
>> +
>> +static void dma_single_map_benchmark_unprepare(void *arg)
>> +{
>> +       struct dma_single_map_param *mparam = arg;
>> +
>> +       free_pages_exact(mparam->xbuf, mparam->npages * PAGE_SIZE);
>> +       kfree(mparam);
>> +}
>> +
>> +static int dma_single_map_benchmark_do_map(void *arg)
>> +{
>> +       struct dma_single_map_param *mparam = arg;
>> +
>> +       mparam->addr = dma_map_single(mparam->dev, mparam->xbuf,
>> +                                     mparam->npages * PAGE_SIZE, mparam->dma_dir);
>> +       if (unlikely(dma_mapping_error(mparam->dev, mparam->addr))) {
>> +               pr_err("dma_map_single failed on %s\n", dev_name(mparam->dev));
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void dma_single_map_benchmark_do_unmap(void *arg)
>> +{
>> +       struct dma_single_map_param *mparam = arg;
>> +
>> +       dma_unmap_single(mparam->dev, mparam->addr,
>> +                        mparam->npages * PAGE_SIZE, mparam->dma_dir);
>> +}
>> +
>> +static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>> +       .prepare = dma_single_map_benchmark_prepare,
>> +       .unprepare = dma_single_map_benchmark_unprepare,
>> +       .do_map = dma_single_map_benchmark_do_map,
>> +       .do_unmap = dma_single_map_benchmark_do_unmap,
>> +};
>> +
>> +static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
>> +       [DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
>> +};
>> +
>>   static int map_benchmark_thread(void *data)
>>   {
>> -       void *buf;
>> -       dma_addr_t dma_addr;
>>          struct map_benchmark_data *map = data;
>> -       int npages = map->bparam.granule;
>> -       u64 size = npages * PAGE_SIZE;
>> +       __u8 map_mode = map->bparam.map_mode;
>>          int ret = 0;
>>
>> -       buf = alloc_pages_exact(size, GFP_KERNEL);
>> -       if (!buf)
>> +       void *arg = dma_map_benchmark_ops[map_mode]->prepare(map);
> It's a bit awkward. Let's try something like this instead:
>
> struct map_benchmark_ops *mb_ops = &dma_map_benchmark_ops[map_mode];
>
> then
> mb_ops->prepare()/map/unmap/unprepare etc.
>
> And can you find a better name than "arg" which is meaningless, mparam?

OK, I'll change it in the next version according to your suggestion.

Thanks!

>> +
>> +       if (!arg)
>>                  return -ENOMEM;
>>
>>          while (!kthread_should_stop())  {
>> @@ -49,23 +130,10 @@ static int map_benchmark_thread(void *data)
>>                  ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
>>                  ktime_t map_delta, unmap_delta;
>>
>> -               /*
>> -                * for a non-coherent device, if we don't stain them in the
>> -                * cache, this will give an underestimate of the real-world
>> -                * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
>> -                * 66 means evertything goes well! 66 is lucky.
>> -                */
>> -               if (map->dir != DMA_FROM_DEVICE)
>> -                       memset(buf, 0x66, size);
>> -
>>                  map_stime = ktime_get();
>> -               dma_addr = dma_map_single(map->dev, buf, size, map->dir);
>> -               if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
>> -                       pr_err("dma_map_single failed on %s\n",
>> -                               dev_name(map->dev));
>> -                       ret = -ENOMEM;
>> +               ret = dma_map_benchmark_ops[map_mode]->do_map(arg);
>> +               if (ret)
>>                          goto out;
>> -               }
>>                  map_etime = ktime_get();
>>                  map_delta = ktime_sub(map_etime, map_stime);
>>
>> @@ -73,7 +141,8 @@ static int map_benchmark_thread(void *data)
>>                  ndelay(map->bparam.dma_trans_ns);
>>
>>                  unmap_stime = ktime_get();
>> -               dma_unmap_single(map->dev, dma_addr, size, map->dir);
>> +               dma_map_benchmark_ops[map_mode]->do_unmap(arg);
>> +
>>                  unmap_etime = ktime_get();
>>                  unmap_delta = ktime_sub(unmap_etime, unmap_stime);
>>
>> @@ -108,7 +177,7 @@ static int map_benchmark_thread(void *data)
>>          }
>>
>>   out:
>> -       free_pages_exact(buf, size);
>> +       dma_map_benchmark_ops[map_mode]->unprepare(arg);
>>          return ret;
>>   }
>>
>> @@ -209,6 +278,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
>>
>>          switch (cmd) {
>>          case DMA_MAP_BENCHMARK:
>> +               if (map->bparam.map_mode >= DMA_MAP_MODE_MAX) {
>> +                       pr_err("invalid map mode\n");
>> +                       return -EINVAL;
>> +               }
>> +
>>                  if (map->bparam.threads == 0 ||
>>                      map->bparam.threads > DMA_MAP_MAX_THREADS) {
>>                          pr_err("invalid thread number\n");
>> --
>> 2.33.0
>>
> Thanks
> Barry
