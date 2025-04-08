Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2061CAA86
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 09:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744105376; cv=none; b=gGji2sa7+4QQQ8yAKnTmLySZfeYcKZziJIQjCYS7Z94/ENDzRnuSfcIIqRdXVSz48URBNArWzLugOSXTFBwjyFOgrlytZZ1zf82JHat2ueKMMZucbfJZfwQUsH1XD5FE+ZbwBmuEoVJgSKgCtLIb+5yN0JA2yKA9qOz1RdPr6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744105376; c=relaxed/simple;
	bh=+81PGJSgNzOkg5RPBDu0ASqN0buf8wiRfhG8ESfO2Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dFRPqmzpp64Ng8yVbZ7gVeqDeoc4ig5JEtEm4DomgM4eK/TOZnUqBJokSRf3H5G++bldhPCEvb7ZYCynYclJ58NNsfPNDWNKIzHoJAslzSwi/+NFjNaW4yoCBDIHIwusqhmMTAkUn8DgC4zU/mNjOKtAvSG3gyS/GURGpZ2wgbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZX1Hz6b4xz2CdgP;
	Tue,  8 Apr 2025 17:39:27 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A08FC1401F3;
	Tue,  8 Apr 2025 17:42:50 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 17:42:50 +0800
Message-ID: <ab20d545-7dc8-4dd0-bd05-256089034ec3@huawei.com>
Date: Tue, 8 Apr 2025 17:42:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma mapping benchmark: modify the framework to adapt
 to more map modes
To: Barry Song <21cnbao@gmail.com>
CC: <chenxiang66@hisilicon.com>, <yangyicong@huawei.com>, <hch@lst.de>,
	<iommu@lists.linux.dev>, <jonathan.cameron@huawei.com>,
	<prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
 <20250212022718.1995504-2-xiaqinxin@huawei.com>
 <CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJqZyxyJTcEop2A@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4waiZ2+NBJG+SCnbNk+nQ_ZF13_Q5FHJqZyxyJTcEop2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/4/7 13:28, Barry Song 写道:
> On Wed, Feb 12, 2025 at 3:27 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> In this patch map_benchmark abstract in four interface: prepare, unprepare,
>> do_map, do_unmap. When there's a new mode to add, need four steps:
>> 1) Add the mode in map_benchmark.h
>>
>> 2) Defines the mode param, like struct dma_xxx_map_param, and this object
>>     will be return in prepare and as input parameter in other ops;
>>
>> 3) Defines the ops functions:prepare, unprepare, do_map, do_unmap.
>>
>> 4) Add the new mode in dma_map_benchmark_ops.
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   include/linux/map_benchmark.h |   6 ++
>>   kernel/dma/map_benchmark.c    | 122 +++++++++++++++++++++++++++-------
>>   2 files changed, 105 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>> index 62674c83bde4..054db02a03a7 100644
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
>> @@ -27,5 +32,6 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> +       __u8  map_mode; /* the mode of dma map */
> We previously added some padding to ensure the uABI remained consistent.
> I just noticed that Tiantao’s commit (8ddde07a3d285a0f3cec, "dma-mapping:
> benchmark: extract a common header file for map_benchmark definition")
> accidentally removed that padding, which has completely broken the ABIs.
>
> Could you send a patch to fix this regression, and CC it to
> stable@vger.kernel.org before adding the new field which should
> use the expansion[] instead.
OK, I will send a patch to fix this regression in next version.
>
>>   };
>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index cc19a3efea89..d8ec0ce058d8 100644
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
>> @@ -31,17 +32,98 @@ struct map_benchmark_data {
>>          atomic64_t loops;
>>   };
>>
>> +struct map_benchmark_ops {
>> +       void *(*prepare)(struct map_benchmark_data *map);
>> +       void (*unprepare)(void *arg);
>> +       int (*do_map)(void *arg);
>> +       int (*do_unmap)(void *arg);
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
>> +static int dma_single_map_benchmark_do_unmap(void *arg)
>> +{
>> +       struct dma_single_map_param *mparam = arg;
>> +
>> +       dma_unmap_single(mparam->dev, mparam->addr,
>> +                        mparam->npages * PAGE_SIZE, mparam->dma_dir);
>> +       return 0;
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
>> +
>> +       if (!arg)
>>                  return -ENOMEM;
>>
>>          while (!kthread_should_stop())  {
>> @@ -49,23 +131,10 @@ static int map_benchmark_thread(void *data)
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
>> @@ -73,7 +142,9 @@ static int map_benchmark_thread(void *data)
>>                  ndelay(map->bparam.dma_trans_ns);
>>
>>                  unmap_stime = ktime_get();
>> -               dma_unmap_single(map->dev, dma_addr, size, map->dir);
>> +               ret = dma_map_benchmark_ops[map_mode]->do_unmap(arg);
>> +               if (ret)
>> +                       goto out;
>>                  unmap_etime = ktime_get();
>>                  unmap_delta = ktime_sub(unmap_etime, unmap_stime);
>>
>> @@ -108,7 +179,7 @@ static int map_benchmark_thread(void *data)
>>          }
>>
>>   out:
>> -       free_pages_exact(buf, size);
>> +       dma_map_benchmark_ops[map_mode]->unprepare(arg);
>>          return ret;
>>   }
>>
>> @@ -209,6 +280,11 @@ static long map_benchmark_ioctl(struct file *file, unsigned int cmd,
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
