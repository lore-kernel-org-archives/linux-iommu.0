Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C1233715
	for <iommu@lists.linux.dev>; Wed,  7 May 2025 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746609464; cv=none; b=EJ1iWMRt61fJIhZcq73V6Ad7Y2f4ojOHiEcMW1LwTXoKRoDyyqPAJkP+j19NWD6Kb4tlGROrFdcfxhcbdSPZUqFVcVqfvDEgbDzApWO6kB6dJJIH0Xt4PfgynMfV+PACXJbCO9AZrf6uTWh4O5RKZI6ebMvwf8Phn6l8uIirNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746609464; c=relaxed/simple;
	bh=sy71j0bbT64XqK/gzwP2t1yu6mzvf3eZ1md/fxLj1vU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jVLmJmbc2/wckity6TMtWGed/ou8NzcHGi0TNa5C1GtvWNg3FbCpBVALuj/y9B6hux8/nbPPmcMegWtlpPNsua3uPYqPr6/sNVSZXgtbzpiTEIJkR8pfBvyeKQ6VfbeifF73ms7v5H1dEwKYgUhz+pmdiK0MihQpKzxXPk27Fog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZsqP12HSrz1R7hF;
	Wed,  7 May 2025 17:15:33 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 4420514010D;
	Wed,  7 May 2025 17:17:39 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 7 May 2025 17:17:38 +0800
Message-ID: <afd1f19b-61ee-489b-9a7f-8e48d4e6ccd0@huawei.com>
Date: Wed, 7 May 2025 17:17:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] dma-mapping: benchmark: add support for dma_map_sg
To: Barry Song <21cnbao@gmail.com>
CC: <yangyicong@huawei.com>, <hch@lst.de>, <iommu@lists.linux.dev>,
	<jonathan.cameron@huawei.com>, <prime.zeng@huawei.com>,
	<fanghao11@huawei.com>, <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
References: <20250506030100.394376-1-xiaqinxin@huawei.com>
 <20250506030100.394376-4-xiaqinxin@huawei.com>
 <CAGsJ_4zBHVwc3A67Wff3u0aypuPv6h25B_YdDqG5j9FmBOXn8g@mail.gmail.com>
From: Qinxin Xia <xiaqinxin@huawei.com>
In-Reply-To: <CAGsJ_4zBHVwc3A67Wff3u0aypuPv6h25B_YdDqG5j9FmBOXn8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/5/7 10:39, Barry Song 写道:
> On Tue, May 6, 2025 at 3:01 PM Qinxin Xia <xiaqinxin@huawei.com> wrote:
>> Support for dma scatter-gather mapping and is intended for testing
>> mapping performance. It achieves by introducing the dma_sg_map_param
>> structure and related functions, which enable the implementation of
>> scatter-gather mapping preparation, mapping, and unmapping operations.
>> Additionally, the dma_map_benchmark_ops array is updated to include
>> operations for scatter-gather mapping. This commit aims to provide
>> a wider range of mapping performance test to cater to different scenarios.
>>
>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>> ---
>>   include/linux/map_benchmark.h |  43 ++++++++++----
>>   kernel/dma/map_benchmark.c    | 102 ++++++++++++++++++++++++++++++++++
>>   2 files changed, 133 insertions(+), 12 deletions(-)
>>
>> diff --git a/include/linux/map_benchmark.h b/include/linux/map_benchmark.h
>> index 5294dfd1870f..bf8c9ade43fd 100644
>> --- a/include/linux/map_benchmark.h
>> +++ b/include/linux/map_benchmark.h
>> @@ -17,22 +17,41 @@
>>
>>   enum {
>>          DMA_MAP_SINGLE_MODE,
>> +       DMA_MAP_SG_MODE,
>>          DMA_MAP_MODE_MAX
>>   };
>>
>> +/**
>> + * struct map_benchmark - Benchmarking data for DMA mapping operations.
>> + * @avg_map_100ns: Average map latency in 100ns.
>> + * @map_stddev: Standard deviation of map latency.
>> + * @avg_unmap_100ns: Average unmap latency in 100ns.
>> + * @unmap_stddev: Standard deviation of unmap latency.
>> + * @threads: Number of threads performing map/unmap operations in parallel.
>> + * @seconds: Duration of the test in seconds.
>> + * @node: NUMA node on which this benchmark will run.
>> + * @dma_bits: DMA addressing capability.
>> + * @dma_dir: DMA data direction.
>> + * @dma_trans_ns: Time for DMA transmission in ns.
>> + * @granule: Number of PAGE_SIZE units to map/unmap at once.
>> +            In SG mode, this represents the number of scatterlist entries.
>> +            In single mode, this represents the total size of the mapping.
>> + * @map_mode: Mode of DMA mapping.
>> + * @expansion: Reserved for future use.
>> + */
>>   struct map_benchmark {
>> -       __u64 avg_map_100ns; /* average map latency in 100ns */
>> -       __u64 map_stddev; /* standard deviation of map latency */
>> -       __u64 avg_unmap_100ns; /* as above */
>> +       __u64 avg_map_100ns;
>> +       __u64 map_stddev;
>> +       __u64 avg_unmap_100ns;
>>          __u64 unmap_stddev;
>> -       __u32 threads; /* how many threads will do map/unmap in parallel */
>> -       __u32 seconds; /* how long the test will last */
>> -       __s32 node; /* which numa node this benchmark will run on */
>> -       __u32 dma_bits; /* DMA addressing capability */
>> -       __u32 dma_dir; /* DMA data direction */
>> -       __u32 dma_trans_ns; /* time for DMA transmission in ns */
>> -       __u32 granule;  /* how many PAGE_SIZE will do map/unmap once a time */
>> -       __u8  map_mode; /* the mode of dma map */
>> -       __u8 expansion[75];     /* For future use */
>> +       __u32 threads;
>> +       __u32 seconds;
>> +       __s32 node;
>> +       __u32 dma_bits;
>> +       __u32 dma_dir;
>> +       __u32 dma_trans_ns;
>> +       __u32 granule;
>> +       __u8  map_mode;
>> +       __u8 expansion[75];
>>   };
>>   #endif /* _KERNEL_DMA_BENCHMARK_H */
>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>> index f04973eba1d8..72cd2c5f839e 100644
>> --- a/kernel/dma/map_benchmark.c
>> +++ b/kernel/dma/map_benchmark.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/module.h>
>>   #include <linux/pci.h>
>>   #include <linux/platform_device.h>
>> +#include <linux/scatterlist.h>
>>   #include <linux/slab.h>
>>   #include <linux/timekeeping.h>
>>
>> @@ -110,8 +111,109 @@ static struct map_benchmark_ops dma_single_map_benchmark_ops = {
>>          .do_unmap = dma_single_map_benchmark_do_unmap,
>>   };
>>
>> +struct dma_sg_map_param {
>> +       struct sg_table sgt;
>> +       struct device *dev;
>> +       void **buf;
>> +       u32 npages;
>> +       u32 dma_dir;
>> +};
>> +
>> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data *map)
>> +{
>> +       struct scatterlist *sg;
>> +       int i = 0;
> I'm not sure we need `i = 0`; perhaps just `int i` would be sufficient.
You're right, 'int i' is more appropriate.
>
>> +
>> +       struct dma_sg_map_param *mparam __free(kfree) = kzalloc(sizeof(*mparam), GFP_KERNEL);
>> +       if (!mparam)
>> +               return NULL;
>> +
>> +       /*
>> +        * Set the number of scatterlist entries based on the granule.
>> +        * In SG mode, 'granule' represents the number of scatterlist entries.
>> +        * Each scatterlist entry corresponds to a single page.
>> +        */
>> +       mparam->npages = map->bparam.granule;
>> +       mparam->dma_dir = map->bparam.dma_dir;
>> +       mparam->dev = map->dev;
>> +       mparam->buf = kmalloc_array(mparam->npages, sizeof(*mparam->buf),
>> +                                   GFP_KERNEL);
>> +       if (!mparam->buf)
>> +               goto out;
>> +
>> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
>> +               goto free_buf;
>> +
>> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
>> +               mparam->buf[i] = (void *)__get_free_page(GFP_KERNEL);
>> +               if (!mparam->buf[i])
>> +                       goto free_page;
>> +
>> +               if (mparam->dma_dir != DMA_FROM_DEVICE)
>> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
>> +
>> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
>> +       }
>> +
>> +       return_ptr(mparam);
>> +
>> +free_page:
>> +       while (i-- > 0)
>> +               free_page((unsigned long)mparam->buf[i]);
>> +
>> +       sg_free_table(&mparam->sgt);
>> +free_buf:
>> +       kfree(mparam->buf);
>> +out:
>> +       return NULL;
>> +}
>> +
>> +static void dma_sg_map_benchmark_unprepare(void *arg)
> The term "arg" is meaningless for a function argument, as it's already implied
> that it is an argument.
Okay, I'm going to modify this in the next version.
>> +{
>> +       struct dma_sg_map_param *mparam = arg;
>> +       int i;
>> +
>> +       for (i = 0; i < mparam->npages; i++)
>> +               free_page((unsigned long)mparam->buf[i]);
>> +
>> +       sg_free_table(&mparam->sgt);
>> +
>> +       kfree(mparam->buf);
>> +       kfree(mparam);
>> +}
>> +
>> +static int dma_sg_map_benchmark_do_map(void *arg)
>> +{
>> +       struct dma_sg_map_param *mparam = arg;
>> +
>> +       int sg_mapped = dma_map_sg(mparam->dev, mparam->sgt.sgl,
>> +                                  mparam->npages, mparam->dma_dir);
> int ret.

Okay, I'm going to modify this in the next version.

Thanks!

>> +       if (!sg_mapped) {
>> +               pr_err("dma_map_sg failed on %s\n", dev_name(mparam->dev));
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void dma_sg_map_benchmark_do_unmap(void *arg)
>> +{
>> +       struct dma_sg_map_param *mparam = arg;
>> +
>> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
>> +                    mparam->dma_dir);
>> +}
>> +
>> +static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
>> +       .prepare = dma_sg_map_benchmark_prepare,
>> +       .unprepare = dma_sg_map_benchmark_unprepare,
>> +       .do_map = dma_sg_map_benchmark_do_map,
>> +       .do_unmap = dma_sg_map_benchmark_do_unmap,
>> +};
>> +
>>   static struct map_benchmark_ops *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
>>          [DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
>> +       [DMA_MAP_SG_MODE] = &dma_sg_map_benchmark_ops,
>>   };
>>
>>   static int map_benchmark_thread(void *data)
>> --
>> 2.33.0
>>
> Thanks
> barry
