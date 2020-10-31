Return-Path: <SRS0=4X9E=EG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04DAC388F7
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 21:42:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E364D2065C
	for <iommu@archiver.kernel.org>; Sat, 31 Oct 2020 21:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E364D2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BC55287671;
	Sat, 31 Oct 2020 21:42:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DJ592Jp1PSP0; Sat, 31 Oct 2020 21:42:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4C28287627;
	Sat, 31 Oct 2020 21:42:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F4CBC088B;
	Sat, 31 Oct 2020 21:42:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C07CC0051
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 21:42:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 040BD8686D
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 21:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Te794rguSFYb for <iommu@lists.linux-foundation.org>;
 Sat, 31 Oct 2020 21:42:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by whitealder.osuosl.org (Postfix) with ESMTPS id F0DF286723
 for <iommu@lists.linux-foundation.org>; Sat, 31 Oct 2020 21:42:09 +0000 (UTC)
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.55])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CNt1N6zQ5z13Nqp;
 Sun,  1 Nov 2020 05:42:00 +0800 (CST)
Received: from dggemi709-chm.china.huawei.com (10.3.20.108) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Sun, 1 Nov 2020 05:42:04 +0800
Received: from dggemi761-chm.china.huawei.com (10.1.198.147) by
 dggemi709-chm.china.huawei.com (10.3.20.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Sun, 1 Nov 2020 05:42:03 +0800
Received: from dggemi761-chm.china.huawei.com ([10.9.49.202]) by
 dggemi761-chm.china.huawei.com ([10.9.49.202]) with mapi id 15.01.1913.007;
 Sun, 1 Nov 2020 05:42:03 +0800
From: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To: "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>, Robin Murphy
 <robin.murphy@arm.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
Subject: RE: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA
 APIs
Thread-Topic: [PATCH 1/2] dma-mapping: add benchmark support for streaming DMA
 APIs
Thread-Index: AQHWrBVIy05LyAA+tkyd0F6o0ziCMamud8IAgACcg7CAALWOgIABrebggADJHNA=
Date: Sat, 31 Oct 2020 21:42:03 +0000
Message-ID: <5dd05e18df4a4c09961a501da021e131@hisilicon.com>
References: <20201027035330.29612-1-song.bao.hua@hisilicon.com>
 <20201027035330.29612-2-song.bao.hua@hisilicon.com>
 <f9aebee4-5081-da8c-930c-c36617ab57c4@arm.com>
 <8fe90795064d4373b4af32959c4e9781@hisilicon.com>
 <472cf21a-5196-dbb5-caef-c1c0d982fe1c@arm.com>
 <ebf48b2c57384f37aaaeb02ea0d3beff@hisilicon.com>
In-Reply-To: <ebf48b2c57384f37aaaeb02ea0d3beff@hisilicon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.203.131]
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
> From: Song Bao Hua (Barry Song) [mailto:song.bao.hua@hisilicon.com]
> Sent: Saturday, October 31, 2020 10:45 PM
> To: Robin Murphy <robin.murphy@arm.com>;
> iommu@lists.linux-foundation.org; hch@lst.de; m.szyprowski@samsung.com
> Cc: joro@8bytes.org; will@kernel.org; shuah@kernel.org; Linuxarm
> <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org
> Subject: RE: [PATCH 1/2] dma-mapping: add benchmark support for streaming
> DMA APIs
> 
> 
> 
> > -----Original Message-----
> > From: Robin Murphy [mailto:robin.murphy@arm.com]
> > Sent: Saturday, October 31, 2020 4:48 AM
> > To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>;
> > iommu@lists.linux-foundation.org; hch@lst.de; m.szyprowski@samsung.com
> > Cc: joro@8bytes.org; will@kernel.org; shuah@kernel.org; Linuxarm
> > <linuxarm@huawei.com>; linux-kselftest@vger.kernel.org
> > Subject: Re: [PATCH 1/2] dma-mapping: add benchmark support for
> streaming
> > DMA APIs
> >
> > On 2020-10-29 21:39, Song Bao Hua (Barry Song) wrote:
> > [...]
> > >>> +struct map_benchmark {
> > >>> +	__u64 map_nsec;
> > >>> +	__u64 unmap_nsec;
> > >>> +	__u32 threads; /* how many threads will do map/unmap in parallel
> > */
> > >>> +	__u32 seconds; /* how long the test will last */
> > >>> +	int node; /* which numa node this benchmark will run on */
> > >>> +	__u64 expansion[10];	/* For future use */
> > >>> +};
> > >>
> > >> I'm no expert on userspace ABIs (and what little experience I do have
> > >> is mostly of Win32...), so hopefully someone else will comment if
> > >> there's anything of concern here. One thing I wonder is that there's
> > >> a fair likelihood of functionality evolving here over time, so might
> > >> it be appropriate to have some sort of explicit versioning parameter
> > >> for robustness?
> > >
> > > I copied that from gup_benchmark. There is no this kind of code to
> > > compare version.
> > > I believe there is a likelihood that kernel module is changed but
> > > users are still using old userspace tool, this might lead to the
> > > incompatible data structure.
> > > But not sure if it is a big problem :-)
> >
> > Yeah, like I say I don't really have a good feeling for what would be best here,
> > I'm just thinking of what I do know and wary of the potential for a "640 bits
> > ought to be enough for anyone" issue ;)
> >
> > >>> +struct map_benchmark_data {
> > >>> +	struct map_benchmark bparam;
> > >>> +	struct device *dev;
> > >>> +	struct dentry  *debugfs;
> > >>> +	atomic64_t total_map_nsecs;
> > >>> +	atomic64_t total_map_loops;
> > >>> +	atomic64_t total_unmap_nsecs;
> > >>> +	atomic64_t total_unmap_loops;
> > >>> +};
> > >>> +
> > >>> +static int map_benchmark_thread(void *data) {
> > >>> +	struct page *page;
> > >>> +	dma_addr_t dma_addr;
> > >>> +	struct map_benchmark_data *map = data;
> > >>> +	int ret = 0;
> > >>> +
> > >>> +	page = alloc_page(GFP_KERNEL);
> > >>> +	if (!page)
> > >>> +		return -ENOMEM;
> > >>> +
> > >>> +	while (!kthread_should_stop())  {
> > >>> +		ktime_t map_stime, map_etime, unmap_stime, unmap_etime;
> > >>> +
> > >>> +		map_stime = ktime_get();
> > >>> +		dma_addr = dma_map_page(map->dev, page, 0, PAGE_SIZE,
> > >> DMA_BIDIRECTIONAL);
> > >>
> > >> Note that for a non-coherent device, this will give an underestimate
> > >> of the real-world overhead of BIDIRECTIONAL or TO_DEVICE mappings,
> > >> since the page will never be dirty in the cache (except possibly the
> > >> very first time through).
> > >
> > > Agreed. I'd like to add a DIRECTION parameter like "-d 0", "-d 1"
> > > after we have this basic framework.
> >
> > That wasn't so much about the direction itself, just that if it's anything other
> > than FROM_DEVICE, we should probably do something to dirty the buffer by
> a
> > reasonable amount before each map. Otherwise the measured performance
> is
> > going to be unrealistic on many systems.
> 
> Maybe put a memset(buf, 0, PAGE_SIZE) before dma_map will help ?
> 
> >
> > [...]
> > >>> +		atomic64_add((long long)ktime_to_ns(ktime_sub(unmap_etime,
> > >> unmap_stime)),
> > >>> +				&map->total_unmap_nsecs);
> > >>> +		atomic64_inc(&map->total_map_loops);
> > >>> +		atomic64_inc(&map->total_unmap_loops);
> > >>
> > >> I think it would be worth keeping track of the variances as well - it
> > >> can be hard to tell if a reasonable-looking average is hiding
> > >> terrible worst-case behaviour.
> > >
> > > This is a sensible requirement. I believe it is better to be handled
> > > by the existing kernel tracing method.
> > >
> > > Maybe we need a histogram like:
> > > Delay   sample count
> > > 1-2us   1000              ***
> > > 2-3us   2000              *******
> > > 3-4us   100               *
> > > .....
> > > This will be more precise than the maximum latency in the worst case.
> > >
> > > I'd believe this can be handled by:
> > > tracepoint  A
> > > Map
> > > Tracepoint  B
> > >
> > > Tracepoint   C
> > > Unmap
> > > Tracepoint   D
> > >
> > > Let the userspace ebpf to draw the histogram for the delta of B-A and D-C.
> > >
> > > So I am planning to put this requirement into todo list and write an
> > > userspace ebpf/bcc script for histogram and put in tools/ directory.
> > >
> > > Please give your comments on this.
> >
> > Right, I wasn't suggesting trying to homebrew a full data collection system
> here
> > - I agree there are better tools for that already - just that it's basically free to
> > track a sum of squares alongside a sum, so that we can trivially calculate a
> > useful variance (or standard
> > deviation) figure alongside the mean at the end.
> 
> For this case, I am not sure if it is true. Unless we expose more data such as
> min, max etc. to userspace, it makes no difference whether
> total_(un)map_nsecs
> and total_(un)map_loops are exposed or not.
> 
> As
> total loops = seconds / (avg_map_latency + avg_unmap_latency);
> total_map_nsecs = total loop count * avg_map_latency
> total_unmap_nsecs = total loop count * avg_unmap_latency
> 
> all of seconds, avg_unmap_latency, avg_unmap_latency are known by
> userspace tool.
> 

After second thought, it seems you mean the kernel code can output the below
to userspace:
1. total loops
2. sum of map and unmap latencies
3. sum of square of map and unmap latencies

+struct map_benchmark {
+	__u64 total_loops;
+	__u64 sum_map_nsec;
+	__u64 sum_unmap_nsec;
+	__u64 sum_of_square_map_nsec;
+	__u64 sum_of_square_unmap_nsec;
+	__u32 threads; /* how many threads will do map/unmap in parallel */
+	__u32 seconds; /* how long the test will last */
+	int node; /* which numa node this benchmark will run on */
+	__u64 expansion[10];	/* For future use */
+};

Then we calculate average map/unmap nsec and variance in the userspace
tool.

> >
> > [...]
> > >>> +	for (i = 0; i < threads; i++) {
> > >>> +		tsk[i] = kthread_create_on_node(map_benchmark_thread, map,
> > >>> +				map->bparam.node, "dma-map-benchmark/%d", i);
> > >>> +		if (IS_ERR(tsk[i])) {
> > >>> +			dev_err(map->dev, "create dma_map thread failed\n");
> > >>> +			return PTR_ERR(tsk[i]);
> > >>> +		}
> > >>> +
> > >>> +		if (node != NUMA_NO_NODE && node_online(node))
> > >>> +			kthread_bind_mask(tsk[i], cpu_mask);
> > >>> +
> > >>> +		wake_up_process(tsk[i]);
> > >>
> > >> Might it be better to create all the threads first, *then* start
> > >> kicking them?
> > >
> > > The difficulty is that we don't know how many threads we should create
> > > as the thread number is a parameter to test the contention of IOMMU
> driver.
> > > In my test case, I'd like to test things like One thread Two threads
> > > ....
> > > 8 threads
> > > 12 threads
> > > 16 threads...
> > >
> > > On the other hand, I think it is better to drop the memory of
> > > task_struct of those test threads while we are not testing dma map.
> >
> > I simply meant splitting the loop here into two - one to create the threads and
> > set their affinity, then another to wake them all up - so we don't start
> > unnecessarily thrashing the system while we're still trying to set up the rest
> of
> > the test ;)
> 
> Agreed.
> 
> >
> > Robin.
>

Thanks
Barry
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
