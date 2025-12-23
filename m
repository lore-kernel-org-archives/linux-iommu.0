Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C089A1BCA1C
	for <iommu@lists.linux.dev>; Tue, 23 Dec 2025 02:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766458298; cv=none; b=OdJoDX3HIAmBlR1WVDac/lnq5CVw14I83h8C22HprvmZr/6no4RK6nLcb5SzZdAjtLaxSGVAGziJfxwQv6LFZb+kEEhAyz4MGbDJW+DsLnDWPMB7mo0tE9x9raEX7C73PI42Y77Hl32KHIY9t9YORiGhLbf9U64H3srkM2LXrUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766458298; c=relaxed/simple;
	bh=XIvN41ilO8xDAbOSAd+13YIdpMurGEEt/FBYhc0yn1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tU2wGKMg47aM0RyovAaTHjLwIQeJRung1MHw4KygAYdJ0dIsd6gnhR4shIMoi73hN5pQyuL037gOl9tRqWyBN2C1WBduye6chCo8b7Mqu2eSdmOE4upGUWipNJPMZSHp1Cn1FdxlRkoolKYtsVOpWHhjWwoLkpjiHWabS/JKfHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=egK7phiZ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="egK7phiZ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qZSLX6LLipQSeiaYxp5uAgwVGKq32X6sb0QdSUSr2lE=;
	b=egK7phiZQMNG0Gh5lV2suX3xc5d/OzSIpGHcUJexOzMGTR9ytoRgOr2ijrFQjSgkFT4It79f+
	cHQhyF7ypY4FagNj163XQvKutIdFekvHPjVmFmZ2e5VvEHvyF1s61j0ga3Ynqm+0WjEXeBpMOr/
	Po9ZIGZTZe6V7dL5PR1q42g=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4dZzw80YY9z1prKB;
	Tue, 23 Dec 2025 10:48:24 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4AA1D201E8;
	Tue, 23 Dec 2025 10:51:32 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 23 Dec 2025 10:51:31 +0800
Message-ID: <7fd4101c-d778-468f-98be-43cccdb03b1a@huawei.com>
Date: Tue, 23 Dec 2025 10:51:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] dma-mapping: benchmark: modify the framework to
 adapt to more map modes
To: Barry Song <21cnbao@gmail.com>
CC: <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
	<iommu@lists.linux.dev>, <prime.zeng@huawei.com>, <fanghao11@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20251222153246.2220659-1-xiaqinxin@huawei.com>
 <20251222153246.2220659-2-xiaqinxin@huawei.com>
 <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4y_xTJJRBzvSszg0qOAX7tAahJYzLaKcTPuJg6ctJsyUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemj200003.china.huawei.com (7.202.194.15)



On 2025/12/23 05:03:46, Barry Song <21cnbao@gmail.com> wrote:
> On Tue, Dec 23, 2025 at 4:33 AM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>>
>> This patch adjusts the DMA map benchmark framework to make the DMA
>> map benchmark framework more flexible and adaptable to other mapping
>> modes in the future. By abstracting the framework into four interfaces:
>> prepare, unprepare, prepare_data, do_map, and do_unmap.
>> The new map schema can be introduced more easily
>> without major modifications to the existing code structure.
>>
>> Reviewed-by: Barry Song <baohua@kernel.org>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   include/uapi/linux/map_benchmark.h |   8 +-
>>   kernel/dma/map_benchmark.c         | 130 ++++++++++++++++++++++++-----
>>   2 files changed, 115 insertions(+), 23 deletions(-)
>>
>> diff --git a/include/uapi/linux/map_benchmark.h b/include/uapi/linux/map_benchmark.h
>> index c2d91088a40d..e076748f2120 100644
>> --- a/include/uapi/linux/map_benchmark.h
>> +++ b/include/uapi/linux/map_benchmark.h
>> @@ -17,6 +17,11 @@
>>   #define DMA_MAP_TO_DEVICE       1
>>   #define DMA_MAP_FROM_DEVICE     2
>>
>> +enum {
>> +       DMA_MAP_BENCH_SINGLE_MODE,
>> +       DMA_MAP_BENCH_MODE_MAX
>> +};
>> +
>>   struct map_benchmark {
>>          __u64 avg_map_100ns; /* average map latency in 100ns */
>>          __u64 map_stddev; /* standard deviation of map latency */
>> @@ -29,7 +34,8 @@ struct map_benchmark {
>>          __u32 dma_dir; /* DMA data direction */
>>          __u32 dma_trans_ns; /* time for DMA transmission in ns */
>>          __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> -       __u8 expansion[76]; /* For future use */
>> +       __u8 map_mode;  /* the mode of dma map */
>> +       __u8 expansion[75]; /* For future use */
>>   };
>>
>>   #endif /* _UAPI_DMA_BENCHMARK_H */
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index 794041a39e65..a6345c10901c 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -5,6 +5,7 @@
>>
>>   #define pr_fmt(fmt)    KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/cleanup.h>
> 
> Are you still using scope-api and need cleanup.h?
> 
Yes, in dma_single_map_benchmark_prepare:
struct dma_single_map_param *params __free(kfree)
>>   #include <linux/debugfs.h>
>>   #include <linux/delay.h>
>>   #include <linux/device.h>
>> @@ -31,17 +32,105 @@ struct map_benchmark_data {
>>          atomic64_t loops;
>>   };
>>
>> +struct map_benchmark_ops {
>> +       void *(*prepare)(struct map_benchmark_data *map);
>> +       void (*unprepare)(void *mparam);
>> +       void (*prepare_data)(void *mparam);
>> +       int (*do_map)(void *mparam);
>> +       void (*do_unmap)(void *mparam);
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
>> +       struct dma_single_map_param *params __free(kfree) = kzalloc(sizeof(*params),
>> +                                                                   GFP_KERNEL);
>> +       if (!params)
>> +               return NULL;
>> +
>> +       params->npages = map->bparam.granule;
>> +       params->dma_dir = map->bparam.dma_dir;
>> +       params->dev = map->dev;
>> +       params->xbuf = alloc_pages_exact(params->npages * PAGE_SIZE, GFP_KERNEL);
>> +       if (!params->xbuf)
>> +               return NULL;
>> +
>> +       return_ptr(params);
>> +}
>> +
>> +static void dma_single_map_benchmark_unprepare(void *mparam)
>> +{
>> +       struct dma_single_map_param *params = mparam;
>> +
>> +       free_pages_exact(params->xbuf, params->npages * PAGE_SIZE);
>> +       kfree(params);
>> +}
>> +
>> +static void dma_single_map_benchmark_prepare_data(void *mparam)
>> +{
>> +       struct dma_single_map_param *params = mparam;
>> +
>> +       /*
>> +        * for a non-coherent device, if we don't stain them in the
>> +        * cache, this will give an underestimate of the real-world
>> +        * overhead of BIDIRECTIONAL or TO_DEVICE mappings;
>> +        * 66 means evertything goes well! 66 is lucky.
>> +        */
>> +       if (params->dma_dir != DMA_FROM_DEVICE)
>> +               memset(params->xbuf, 0x66, params->npages * PAGE_SIZE);
>> +}
>> +
>> +static int dma_single_map_benchmark_do_map(void *mparam)
>> +{
>> +       struct dma_single_map_param *params = mparam;
>> +
>> +       params->addr = dma_map_single(params->dev, params->xbuf,
>> +                                     params->npages * PAGE_SIZE, params->dma_dir);
>> +       if (unlikely(dma_mapping_error(params->dev, params->addr))) {
>> +               pr_err("dma_map_single failed on %s\n", dev_name(params->dev));
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void dma_single_map_benchmark_do_unmap(void *mparam)
>> +{
>> +       struct dma_single_map_param *params = mparam;
>> +
>> +       dma_unmap_single(params->dev, params->addr,
>> +                        params->npages * PAGE_SIZE, params->dma_dir);
>> +}
>> +
>> +static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>> +       .prepare = dma_single_map_benchmark_prepare,
>> +       .unprepare = dma_single_map_benchmark_unprepare,
>> +       .prepare_data = dma_single_map_benchmark_prepare_data,
>> +       .do_map = dma_single_map_benchmark_do_map,
>> +       .do_unmap = dma_single_map_benchmark_do_unmap,
>> +};
>> +
>> +static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_BENCH_MODE_MAX] = {
>> +       [DMA_MAP_BENCH_SINGLE_MODE] = &dma_single_map_benchmark_ops,
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
>> +       struct map_benchmark_ops *mb_ops = dma_map_benchmark_ops[map_mode];
>> +       void *mparam = mb_ops->prepare(map);
>> +
>> +       if (!mparam)
>>                  return -ENOMEM;
>>
>>          while (!kthread_should_stop())  {
>> @@ -49,23 +138,14 @@ static int map_benchmark_thread(void *data)
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
>> +               if (!mb_ops->prepare_data)
>> +                       mb_ops->prepare_data(mparam);
> 
> Did you actually test it? and why don't you need prepare_data() sometimes?
> 
> Thanks
> Barry
'if (mb_ops->prepare_data)' is correct.
If you want to do some tests before I release the next version, you can
modify it in this way. I have tested it and it is work.

To be compatible with other modes that in the future, 'prepare_data' may
not be necessary. So, I add a judgment here.We can delete it in the
current version and add it after this scenario occurs.

-- 
Thanks,
Qinxin

