Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0A4204C35
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 13:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096599; cv=none; b=ANJF22gHmq8HVA2lbuN7MJZfNxQWJS7GwWXPkAsEcgUdNLHGxeqQQbwP+N3a9Io35Z4dSxgmC6QCJOhxyz4qHrBy3JXA72J6qIBvwLR3OTqmC1Us+GINHxRWddrT8gS/RDbOcPkFKNgD+3t43m8ib2oau8Q76sKlaOwackKk5Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096599; c=relaxed/simple;
	bh=B1HhjIwvey1c5ezYoPA1l5ZccU/01rKBuPoMwstDUJ8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=ecGjgvcLlVwFI0kf7idSnpB6rgVahfd9ng0w/QgTbVTrZ45u3xWaBN68d1s8T3O5vg+q1A5f1+2xfHL1okQoAbCsIRLEbzrFow88vO+q7Tg81W8jz1hSdX2yHzKe2SynnTHaZg+iRsYjMSlABTOVJz+LqCLnguKAS4Glcu6RZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Z6cXz4wvlzwXNs;
	Tue,  4 Mar 2025 21:51:31 +0800 (CST)
Received: from kwepemj200003.china.huawei.com (unknown [7.202.194.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C7131400CD;
	Tue,  4 Mar 2025 21:56:25 +0800 (CST)
Received: from [10.67.120.170] (10.67.120.170) by
 kwepemj200003.china.huawei.com (7.202.194.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Mar 2025 21:56:24 +0800
Message-ID: <de7966bb-dbf1-4f41-9e25-561ab8c3afc0@huawei.com>
Date: Tue, 4 Mar 2025 21:56:23 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dma-mapping: benchmark: add support for dma_map_sg
From: Qinxin Xia <xiaqinxin@huawei.com>
To: Barry Song <21cnbao@gmail.com>
CC: yangyicong <yangyicong@huawei.com>, "hch@lst.de" <hch@lst.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"fanghao (A)" <fanghao11@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
References: <20250212022718.1995504-1-xiaqinxin@huawei.com>
 <20250212022718.1995504-3-xiaqinxin@huawei.com>
 <CAGsJ_4yDBT4rJyG4-Ow4T3xLq8VujBjG+-uxjnWUm_vW1nzT_A@mail.gmail.com>
 <43618c9167654c68945ec5e7d9bf69d5@huawei.com>
 <CAGsJ_4zNTYsMkeBav7z=AKdm5CjB=Y73P1QBzq+9FS--z9t9Cw@mail.gmail.com>
 <66470ea1-668a-418a-bcf6-c8702be799ce@huawei.com>
In-Reply-To: <66470ea1-668a-418a-bcf6-c8702be799ce@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemj200003.china.huawei.com (7.202.194.15)


在 2025/3/4 21:49, Qinxin Xia 写道:
>
> 在 2025/2/22 14:36, Barry Song 写道:
>> On Fri, Feb 21, 2025 at 4:16 PM xiaqinxin <xiaqinxin@huawei.com> wrote:
>>>
>>>
>>> -----邮件原件-----
>>> 发件人: Barry Song <21cnbao@gmail.com>
>>> 发送时间: 2025年2月18日 4:59
>>> 收件人: xiaqinxin <xiaqinxin@huawei.com>
>>> 抄送: chenxiang66@hisilicon.com; yangyicong <yangyicong@huawei.com>; 
>>> hch@lst.de; iommu@lists.linux.dev; Jonathan Cameron 
>>> <jonathan.cameron@huawei.com>; Zengtao (B) 
>>> <prime.zeng@hisilicon.com>; fanghao (A) <fanghao11@huawei.com>; 
>>> linux-kernel@vger.kernel.org
>>> 主题: Re: [PATCH 2/3] dma-mapping: benchmark: add support for 
>>> dma_map_sg
>>>
>>> On Wed, Feb 12, 2025 at 3:27 PM Qinxin Xia <xiaqinxin@huawei.com> 
>>> wrote:
>>>> Support for dma scatter-gather mapping and is intended for testing
>>>> mapping performance. It achieves by introducing the dma_sg_map_param
>>>> structure and related functions, which enable the implementation of
>>>> scatter-gather mapping preparation, mapping, and unmapping operations.
>>>> Additionally, the dma_map_benchmark_ops array is updated to include
>>>> operations for scatter-gather mapping. This commit aims to provide a
>>>> wider range of mapping performance test  to cater to different 
>>>> scenarios.
>>> This benchmark is mainly designed to debug contention issues, such 
>>> as IOMMU TLB flushes or IOMMU driver bottlenecks. I don't fully 
>>> understand how SG or single will impact the evaluation of the IOMMU 
>>> driver, making it unclear if the added complexity is justified.
>>>
>>> Can you add some explanation on why single mode is not sufficient 
>>> for profiling and improving IOMMU drivers?
>>>
>>> Hello Barry ! 😊
>>> Currently, the HiSilicon accelerator service uses the dma_map_sg 
>>> interface. We want to evaluate the performance of the entire DMA map 
>>> process. (including not only the iommu, but also the map framework). 
>>> In addition, for scatterlist, __iommu_map is executed for each nent. 
>>> This increases the complexity and time overhead of mapping. The 
>>> effect of this fragmentation is not obvious in dma_map_single, which 
>>> only handles a single contiguous block of memory.
>>>
>> Thanks!
>> Please update your editor to ensure it doesn't respond with such long 
>> sentences
>> without line breaks in the future :-)
>
> Hello Barry !
>
> Thank you for your advice, I will I'll pay attention. Leon

A little mistake, sorry for it...

I will I'll pay attention. Leon  ==> I will pay attention.

>
>> Can you provide concrete examples or data showing how the newly added 
>> mode
>> improves profiling of the entire DMA map process? For instance, what 
>> limitations
>> exist without this mode? What performance issues cannot be identified 
>> without
>> it?
>
> You can see this patch 
> :https://lore.kernel.org/all/cover.1738765879.git.leonro@nvidia.com/
>
> Leon provides new interface for scatterlist scenarios to improve 
> performance and gives some
>
> application instance in rdma and vfio. Users can use dma_map_sg 
> benchmark to measure
>
> the performance improvement of the optimized interface compared with 
> the previous one.
>
> Thanks!
>
>>
>>>> Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
>>>> ---
>>>>   include/linux/map_benchmark.h |   1 +
>>>>   kernel/dma/map_benchmark.c    | 102 
>>>> ++++++++++++++++++++++++++++++++++
>>>>   2 files changed, 103 insertions(+)
>>>>
>>>> diff --git a/include/linux/map_benchmark.h
>>>> b/include/linux/map_benchmark.h index 054db02a03a7..a9c1a104ba4f
>>>> 100644
>>>> --- a/include/linux/map_benchmark.h
>>>> +++ b/include/linux/map_benchmark.h
>>>> @@ -17,6 +17,7 @@
>>>>
>>>>   enum {
>>>>          DMA_MAP_SINGLE_MODE,
>>>> +       DMA_MAP_SG_MODE,
>>>>          DMA_MAP_MODE_MAX
>>>>   };
>>>>
>>>> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
>>>> index d8ec0ce058d8..b5828eeb3db7 100644
>>>> --- a/kernel/dma/map_benchmark.c
>>>> +++ b/kernel/dma/map_benchmark.c
>>>> @@ -17,6 +17,7 @@
>>>>   #include <linux/module.h>
>>>>   #include <linux/pci.h>
>>>>   #include <linux/platform_device.h>
>>>> +#include <linux/scatterlist.h>
>>>>   #include <linux/slab.h>
>>>>   #include <linux/timekeeping.h>
>>>>
>>>> @@ -111,8 +112,109 @@ static struct map_benchmark_ops 
>>>> dma_single_map_benchmark_ops = {
>>>>          .do_unmap = dma_single_map_benchmark_do_unmap,
>>>>   };
>>>>
>>>> +struct dma_sg_map_param {
>>>> +       struct sg_table sgt;
>>>> +       struct device *dev;
>>>> +       void **buf;
>>>> +       u32 npages;
>>>> +       u32 dma_dir;
>>>> +};
>>>> +
>>>> +static void *dma_sg_map_benchmark_prepare(struct map_benchmark_data
>>>> +*map) {
>>>> +       struct scatterlist *sg;
>>>> +       int i = 0;
>>>> +
>>>> +       struct dma_sg_map_param *mparam __free(kfree) = 
>>>> kzalloc(sizeof(*mparam), GFP_KERNEL);
>>>> +       if (!mparam)
>>>> +               return NULL;
>>>> +
>>>> +       mparam->npages = map->bparam.granule;
>>>> +       mparam->dma_dir = map->bparam.dma_dir;
>>>> +       mparam->dev = map->dev;
>>>> +       mparam->buf = kmalloc_array(mparam->npages, 
>>>> sizeof(*mparam->buf),
>>>> +                                   GFP_KERNEL);
>>>> +       if (!mparam->buf)
>>>> +               goto err1;
>>>> +
>>>> +       if (sg_alloc_table(&mparam->sgt, mparam->npages, GFP_KERNEL))
>>>> +               goto err2;
>>>> +
>>>> +       for_each_sgtable_sg(&mparam->sgt, sg, i) {
>>>> +               mparam->buf[i] = (void *)__get_free_page(GFP_KERNEL);
>>>> +               if (!mparam->buf[i])
>>>> +                       goto err3;
>>>> +
>>>> +               if (mparam->dma_dir != DMA_FROM_DEVICE)
>>>> +                       memset(mparam->buf[i], 0x66, PAGE_SIZE);
>>>> +
>>>> +               sg_set_buf(sg, mparam->buf[i], PAGE_SIZE);
>>>> +       }
>>>> +
>>>> +       return_ptr(mparam);
>>>> +
>>>> +err3:
>>>> +       while (i-- > 0)
>>>> +               free_page((unsigned long)mparam->buf[i]);
>>>> +
>>>> +       pr_err("dma_map_sg failed get free page on %s\n", 
>>>> dev_name(mparam->dev));
>>>> +       sg_free_table(&mparam->sgt);
>>>> +err2:
>>>> +       pr_err("dma_map_sg failed alloc sg table on %s\n", 
>>>> dev_name(mparam->dev));
>>>> +       kfree(mparam->buf);
>>>> +err1:
>>>> +       pr_err("dma_map_sg failed alloc mparam buf on %s\n", 
>>>> dev_name(mparam->dev));
>>>> +       return NULL;
>>>> +}
>>>> +
>>>> +static void dma_sg_map_benchmark_unprepare(void *arg) {
>>>> +       struct dma_sg_map_param *mparam = arg;
>>>> +       int i;
>>>> +
>>>> +       for (i = 0; i < mparam->npages; i++)
>>>> +               free_page((unsigned long)mparam->buf[i]);
>>>> +
>>>> +       sg_free_table(&mparam->sgt);
>>>> +
>>>> +       kfree(mparam->buf);
>>>> +       kfree(mparam);
>>>> +}
>>>> +
>>>> +static int dma_sg_map_benchmark_do_map(void *arg) {
>>>> +       struct dma_sg_map_param *mparam = arg;
>>>> +
>>>> +       int sg_mapped = dma_map_sg(mparam->dev, mparam->sgt.sgl,
>>>> +                                  mparam->npages, mparam->dma_dir);
>>>> +       if (!sg_mapped) {
>>>> +               pr_err("dma_map_sg failed on %s\n", 
>>>> dev_name(mparam->dev));
>>>> +               return -ENOMEM;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static int dma_sg_map_benchmark_do_unmap(void *arg) {
>>>> +       struct dma_sg_map_param *mparam = arg;
>>>> +
>>>> +       dma_unmap_sg(mparam->dev, mparam->sgt.sgl, mparam->npages,
>>>> +                    mparam->dma_dir);
>>>> +
>>>> +       return 0;
>>>> +}
>>>> +
>>>> +static struct map_benchmark_ops dma_sg_map_benchmark_ops = {
>>>> +       .prepare = dma_sg_map_benchmark_prepare,
>>>> +       .unprepare = dma_sg_map_benchmark_unprepare,
>>>> +       .do_map = dma_sg_map_benchmark_do_map,
>>>> +       .do_unmap = dma_sg_map_benchmark_do_unmap, };
>>>> +
>>>>   static struct map_benchmark_ops 
>>>> *dma_map_benchmark_ops[DMA_MAP_MODE_MAX] = {
>>>>          [DMA_MAP_SINGLE_MODE] = &dma_single_map_benchmark_ops,
>>>> +       [DMA_MAP_SG_MODE] = &dma_sg_map_benchmark_ops,
>>>>   };
>>>>
>>>>   static int map_benchmark_thread(void *data)
>>>> -- 
>>>> 2.33.0
>>>>
>> Thanks
>> Barry
