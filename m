Return-Path: <SRS0=7pZu=EE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E07C2D0A3
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 21:39:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F353720754
	for <iommu@archiver.kernel.org>; Thu, 29 Oct 2020 21:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F353720754
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9119586BE9;
	Thu, 29 Oct 2020 21:39:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x1N5PY4NXDRO; Thu, 29 Oct 2020 21:39:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 607F085FF2;
	Thu, 29 Oct 2020 21:39:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E360C088B;
	Thu, 29 Oct 2020 21:39:12 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F2C6C0051
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:39:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C56A859BA
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffdNwPI96F3r for <iommu@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 21:39:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8DDC286B9D
 for <iommu@lists.linux-foundation.org>; Thu, 29 Oct 2020 21:39:05 +0000 (UTC)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4CMf2s3Mb8zVhYX;
 Fri, 30 Oct 2020 05:39:01 +0800 (CST)
Received: from dggemi711-chm.china.huawei.com (10.3.20.110) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 30 Oct 2020 05:39:01 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi711-chm.china.huawei.com (10.3.20.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 30 Oct 2020 05:39:01 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Fri, 30 Oct 2020 05:39:01 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA
 APIs
Thread-Topic: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA
 APIs
Thread-Index: AQHWrBVIy05LyAA+tkyd0F6o0ziCMamud8IAgACcg7A=
Date: Thu, 29 Oct 2020 21:39:01 +0000
Message-ID: <8fe90795064d4373b4af32959c4e9781@hisilicon.com>
References: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
 <20201027035330.29612-2-song.bao.hua@hisilicon.com>
 <f9aebee4-5081-da8c-930c-c36617ab57c4@arm.com>
In-Reply-To: <f9aebee4-5081-da8c-930c-c36617ab57c4@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.202.117]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Cc: "shuah@kernel.org" <shuah@kernel.org>, "will@kernel.org" <will@kernel.org>,
 Linuxarm <linuxarm@huawei.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>



> -----Original Message-----
> From: Robin Murphy [mailto:robin.murphy@arm.com]
> Sent: Friday, October 30, 2020 8:38 AM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> iommu@lists.linux-foundation.org; hch@lst.de; m.szyprowski@samsung.com
> Cc: joro@8bytes.org; will@kernel.org; shuah@kernel.org; Linuxarm
> <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org
> Subject: Re: [PATCH 1/2] dma-mapping: add benchmark support for streaming
> DMA APIs
> 
> On 2020-10-27 03:53, Barry Song wrote:
> > Nowadays, there are increasing requirements to benchmark the performance
> > of dma_map and dma_unmap particually while the device is attached to an
> > IOMMU.
> >
> > This patch enables the support. Users can run specified number of threads
> > to do dma_map_page and dma_unmap_page on a specific NUMA node with
> the
> > specified duration. Then dma_map_benchmark will calculate the average
> > latency for map and unmap.
> >
> > A difficulity for this benchmark is that dma_map/unmap APIs must run on
> > a particular device. Each device might have different backend of IOMMU or
> > non-IOMMU.
> >
> > So we use the driver_override to bind dma_map_benchmark to a particual
> > device by:
> > echo dma_map_benchmark > /sys/bus/platform/devices/xxx/driver_override
> > echo xxx > /sys/bus/platform/drivers/xxx/unbind
> > echo xxx > /sys/bus/platform/drivers/dma_map_benchmark/bind
> >
> > For this moment, it supports platform device only, PCI device will also
> > be supported afterwards.
> 
> Neat! This is something I've thought about many times, but never got
> round to attempting :)

I am happy you have the same needs. When I came to IOMMU area a half year ago,
the first thing I've done was writing a rough benchmark. At that time, I hacked kernel
to get a device behind an IOMMU.

Recently, I got some time to think about how to get "device" without ugly hacking and
then clean up code for sending patches out to provide a common benchmark in order
that everybody can use.

> 
> I think the basic latency measurement for mapping and unmapping pages is
> enough to start with, but there are definitely some more things that
> would be interesting to look into for future enhancements:
> 
>   - a choice of mapping sizes, both smaller and larger than one page, to
> help characterise stuff like cache maintenance overhead and bounce
> buffer/IOVA fragmentation.
>   - alternative allocation patterns like doing lots of maps first, then
> all their corresponding unmaps (to provoke things like the worst-case
> IOVA rcache behaviour).
>   - ways to exercise a range of those parameters at once across
> different threads in a single test.
> 

Yes, sure. Once we have a basic framework, we can add more benchmark patterns
by using different parameters in the userspace tool:
testing/selftests/dma/dma_map_benchmark.c

Similar function extensions have been carried out in GUP_BENCHMARK.

> But let's get a basic framework nailed down first...

Sure.

> 
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Shuah Khan <shuah@kernel.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> > ---
> >   kernel/dma/Kconfig         |   8 ++
> >   kernel/dma/Makefile        |   1 +
> >   kernel/dma/map_benchmark.c | 202
> +++++++++++++++++++++++++++++++++++++
> >   3 files changed, 211 insertions(+)
> >   create mode 100644 kernel/dma/map_benchmark.c
> >
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c99de4a21458..949c53da5991 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -225,3 +225,11 @@ config DMA_API_DEBUG_SG
> >   	  is technically out-of-spec.
> >
> >   	  If unsure, say N.
> > +
> > +config DMA_MAP_BENCHMARK
> > +	bool "Enable benchmarking of streaming DMA mapping"
> > +	help
> > +	  Provides /sys/kernel/debug/dma_map_benchmark that helps with
> testing
> > +	  performance of dma_(un)map_page.
> > +
> > +	  See tools/testing/selftests/dma/dma_map_benchmark.c
> > diff --git a/kernel/dma/Makefile b/kernel/dma/Makefile
> > index dc755ab68aab..7aa6b26b1348 100644
> > --- a/kernel/dma/Makefile
> > +++ b/kernel/dma/Makefile
> > @@ -10,3 +10,4 @@ obj-$(CONFIG_DMA_API_DEBUG)		+= debug.o
> >   obj-$(CONFIG_SWIOTLB)			+= swiotlb.o
> >   obj-$(CONFIG_DMA_COHERENT_POOL)		+= pool.o
> >   obj-$(CONFIG_DMA_REMAP)			+= remap.o
> > +obj-$(CONFIG_DMA_MAP_BENCHMARK)		+= map_benchmark.o
> > diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> > new file mode 100644
> > index 000000000000..16a5d7779d67
> > --- /dev/null
> > +++ b/kernel/dma/map_benchmark.c
> > @@ -0,0 +1,202 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Hisilicon Limited.
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/device.h>
> > +#include <linux/kthread.h>
> > +#include <linux/slab.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/timekeeping.h>
> > +#include <linux/delay.h>
> > +#include <linux/platform_device.h>
> 
> Nit: alphabetical order is always nice, when there's not an existing
> precedent of a complete mess...
> 
> > +
> > +#define DMA_MAP_BENCHMARK	_IOWR('d', 1, struct map_benchmark)
> > +
> > +struct map_benchmark {
> > +	__u64 map_nsec;
> > +	__u64 unmap_nsec;
> > +	__u32 threads; /* how many threads will do map/unmap in parallel */
> > +	__u32 seconds; /* how long the test will last */
> > +	int node; /* which numa node this benchmark will run on */
> > +	__u64 expansion[10];	/* For future use */
> > +};
> 
> I'm no expert on userspace ABIs (and what little experience I do have is
> mostly of Win32...), so hopefully someone else will comment if there's
> anything of concern here. One thing I wonder is that there's a fair
> likelihood of functionality evolving here over time, so might it be
> appropriate to have some sort of explicit versioning parameter for
> robustness?

I copied that from gup_benchmark. There is no this kind of code to
compare version.
I believe there is a likelihood that kernel module is changed but users
are still using old userspace tool, this might lead to the incompatible
data structure.
But not sure if it is a big problem :-)

> 
> > +struct map_benchmark_data {
> > +	struct map_benchmark bparam;
> > +	struct device *dev;
> > +	struct dentry  *debugfs;
> > +	atomic64_t total_map_nsecs;
> > +	atomic64_t total_map_loops;
> > +	atomic64_t total_unmap_nsecs;
> > +	atomic64_t total_unmap_loops;
> > +};
> > +
> > +static int map_benchmark_thread(void *data)
> > +{
> > +	struct page *page;
> > +	dma_addr_t dma_addr;
> > +	struct map_benchmark_data *map = data;
> > +	int ret = 0;
> > +
> > +	page = alloc_page(GFP_KERNEL);
> > +	if (!page)
> > +		return -ENOMEM;
> > +
> > +	while (!kthread_should_stop())  {
> > +		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
> > +
> > +		map_stime = ktime_get();
> > +		dma_addr = dma_map_page(map->dev, page, 0, PAGE_SIZE,
> DMA_BIDIRECTIONAL);
> 
> Note that for a non-coherent device, this will give an underestimate of
> the real-world overhead of BIDIRECTIONAL or TO_DEVICE mappings, since
> the page will never be dirty in the cache (except possibly the very
> first time through).

Agreed. I'd like to add a DIRECTION parameter like "-d 0", "-d 1" after we have
this basic framework.

> 
> > +		if (unlikely(dma_mapping_error(map->dev, dma_addr))) {
> > +			dev_err(map->dev, "dma_map_page failed\n");
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +		map_etime = ktime_get();
> > +
> > +		unmap_stime = ktime_get();
> > +		dma_unmap_single(map->dev, dma_addr, PAGE_SIZE,
> DMA_BIDIRECTIONAL);
> 
> Ahem, dma_map_page() pairs with dma_unmap_page(). Unfortunately
> DMA_API_DEBUG is unable to shout at you for that...

This is a typo. At the beginning, we used dma_map_single and dma_unmap_single.
After that, I changed to alloc_page so moved to dma_map_page. But I missed
the unmap part.

> 
> However, maybe changing the other end to dma_map_single() might make
> more sense, since you're not allocating highmem pages or anything wacky,
> and that'll be easier to expand in future.
> 

Yes. I can either change both to map_page/unmap_page or both to map_single/
unmap_single.

> > +		unmap_etime = ktime_get();
> > +
> > +		atomic64_add((long long)ktime_to_ns(ktime_sub(map_etime,
> map_stime)),
> > +				&map->total_map_nsecs);
> 
> ktime_to_ns() returns s64, which is already long long.

Got it.

> 
> > +		atomic64_add((long long)ktime_to_ns(ktime_sub(unmap_etime,
> unmap_stime)),
> > +				&map->total_unmap_nsecs);
> > +		atomic64_inc(&map->total_map_loops);
> > +		atomic64_inc(&map->total_unmap_loops);
> 
> I think it would be worth keeping track of the variances as well - it
> can be hard to tell if a reasonable-looking average is hiding terrible
> worst-case behaviour.

This is a sensible requirement. I believe it is better to be handled by the
existing kernel tracing method.

Maybe we need a histogram like:
Delay   sample count
1-2us   1000              ***
2-3us   2000              *******
3-4us   100               *
.....
This will be more precise than the maximum latency in the worst
case.

I'd believe this can be handled by:
tracepoint  A
Map
Tracepoint  B

Tracepoint   C
Unmap
Tracepoint   D

Let the userspace ebpf to draw the histogram for the delta of B-A and D-C.

So I am planning to put this requirement into todo list and write an userspace
ebpf/bcc script for histogram and put in tools/ directory.

Please give your comments on this.

> 
> > +	}
> > +
> > +out:
> > +	__free_page(page);
> > +	return ret;
> > +}
> > +
> > +static int do_map_benchmark(struct map_benchmark_data *map)
> > +{
> > +	struct task_struct **tsk;
> > +	int threads = map->bparam.threads;
> 
> I know it's debugfs, but maybe a bit of parameter validation wouldn't go
> amiss? I'm already imaginging that sinking feeling when the SSH
> connection stops responding and you realise you've just inadvertently
> launched INT_MAX threads...

Agreed.

> 
> > +	int node = map->bparam.node;
> > +	const cpumask_t *cpu_mask = cpumask_of_node(node);
> > +	int ret = 0;
> > +	int i;
> > +
> > +	tsk = kmalloc_array(threads, sizeof(tsk), GFP_KERNEL);
> > +	if (!tsk)
> > +		return -ENOMEM;
> > +
> > +	get_device(map->dev);
> > +
> > +	for (i = 0; i < threads; i++) {
> > +		tsk[i] = kthread_create_on_node(map_benchmark_thread, map,
> > +				map->bparam.node, "dma-map-benchmark/%d", i);
> > +		if (IS_ERR(tsk[i])) {
> > +			dev_err(map->dev, "create dma_map thread failed\n");
> > +			return PTR_ERR(tsk[i]);
> > +		}
> > +
> > +		if (node != NUMA_NO_NODE && node_online(node))
> > +			kthread_bind_mask(tsk[i], cpu_mask);
> > +
> > +		wake_up_process(tsk[i]);
> 
> Might it be better to create all the threads first, *then* start kicking
> them?

The difficulty is that we don't know how many threads we should create as
the thread number is a parameter to test the contention of IOMMU driver.
In my test case, I'd like to test things like
One thread
Two threads
....
8 threads
12 threads
16 threads...

On the other hand, I think it is better to drop the memory of task_struct of those
test threads while we are not testing dma map.

> 
> > +	}
> > +
> > +	ssleep(map->bparam.seconds);
> > +
> > +	/* wait for the completion of benchmark threads */
> > +	for (i = 0; i < threads; i++) {
> > +		ret = kthread_stop(tsk[i]);
> > +		if (ret)
> > +			goto out;
> > +	}
> > +
> > +	/* average map nsec and unmap nsec */
> > +	map->bparam.map_nsec = atomic64_read(&map->total_map_nsecs) /
> > +				atomic64_read(&map->total_map_loops);
> > +	map->bparam.unmap_nsec = atomic64_read(&map->total_unmap_nsecs)
> /
> > +				atomic64_read(&map->total_unmap_loops);
> > +
> > +out:
> > +	put_device(map->dev);
> > +	kfree(tsk);
> > +	return ret;
> > +}
> > +
> > +static long map_benchmark_ioctl(struct file *filep, unsigned int cmd,
> > +		unsigned long arg)
> > +{
> > +	struct map_benchmark_data *map = filep->private_data;
> > +	int ret;
> > +
> > +	if (copy_from_user(&map->bparam, (void __user *)arg,
> sizeof(map->bparam)))
> > +		return -EFAULT;
> > +
> > +	switch (cmd) {
> > +	case DMA_MAP_BENCHMARK:
> > +		ret = do_map_benchmark(map);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (copy_to_user((void __user *)arg, &map->bparam,
> sizeof(map->bparam)))
> > +		return -EFAULT;
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct file_operations map_benchmark_fops = {
> > +	.open = simple_open,
> > +	.unlocked_ioctl = map_benchmark_ioctl,
> > +};
> > +
> > +static int map_benchmark_probe(struct platform_device *pdev)
> > +{
> > +	struct dentry *entry;
> > +	struct map_benchmark_data *map;
> > +
> > +	map = devm_kzalloc(&pdev->dev, sizeof(*map), GFP_KERNEL);
> > +	if (!map)
> > +		return -ENOMEM;
> > +
> > +	map->dev = &pdev->dev;
> > +	platform_set_drvdata(pdev, map);
> > +
> > +	/*
> > +	 * we only permit a device bound with this driver, 2nd probe
> > +	 * will fail
> > +	 */
> > +	entry = debugfs_create_file("dma_map_benchmark", 0600, NULL, map,
> > +			&map_benchmark_fops);
> > +	if (IS_ERR(entry))
> > +		return PTR_ERR(entry);
> > +	map->debugfs = entry;
> > +
> > +	return 0;
> > +}
> > +
> > +static int map_benchmark_remove(struct platform_device *pdev)
> > +{
> > +	struct map_benchmark_data *map = platform_get_drvdata(pdev);
> > +
> > +	debugfs_remove(map->debugfs);
> 
> Consider a trivial 3-line wrapper plus a devm_add_action() call ;)
> 
Yes, I will.

> Robin.
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver map_benchmark_driver = {
> > +	.driver		= {
> > +		.name	= "dma_map_benchmark",
> > +	},
> > +	.probe		= map_benchmark_probe,
> > +	.remove		= map_benchmark_remove,
> > +};
> > +
> > +module_platform_driver(map_benchmark_driver);
> > +
> > +MODULE_AUTHOR("Barry Song <song.bao.hua@hisilicon.com>");
> > +MODULE_DESCRIPTION("dma_map benchmark driver");
> > +MODULE_LICENSE("GPL");

Thanks
Barry

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
