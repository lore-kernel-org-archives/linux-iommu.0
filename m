Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF988C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 02:02:27 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 548E9206A5
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 02:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 548E9206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CE1B68700A;
	Wed, 27 Jan 2021 02:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wI1qxOgPcxim; Wed, 27 Jan 2021 02:02:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E9DD86F8F;
	Wed, 27 Jan 2021 02:02:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88146C08A1;
	Wed, 27 Jan 2021 02:02:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA448C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 02:02:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id D8F5685722
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 02:02:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fgbWZughU6vC for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 02:02:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BC9608574F
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 02:02:20 +0000 (UTC)
IronPort-SDR: dMFAx5Ll5siiY22guyn7CTObr5BwjoCoq1aq1VNFuMDpCQqOjZXZ+wO95a0sq5MDwsr/rq0Pbu
 W2LYKfr5hzMQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9876"; a="180083778"
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="180083778"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jan 2021 18:02:18 -0800
IronPort-SDR: vDArbV7yQDBrNN+eF9wak9exUNPPGLieCNxWjH4X1B2ymelOPZnj771FWQT1XeH4bUiImItjp0
 zPTw2NJD6pIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,378,1602572400"; d="scan'208";a="402939270"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 26 Jan 2021 18:02:16 -0800
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
To: Chuck Lever <chuck.lever@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
 <7937bfa5-5cb9-0a23-176c-e91e5e9ac962@linux.intel.com>
 <C70D7EE4-C84C-421C-818A-F13403E99B33@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <c8bbeb07-92a8-cacf-7106-512aafe02921@linux.intel.com>
Date: Wed, 27 Jan 2021 09:53:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <C70D7EE4-C84C-421C-818A-F13403E99B33@oracle.com>
Content-Language: en-US
Cc: isaacm@codeaurora.org, Robin Murphy <robin.murphy@arm.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Will Deacon <will@kernel.org>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Chuck,

On 1/26/21 11:52 PM, Chuck Lever wrote:
> 
> 
>> On Jan 26, 2021, at 1:18 AM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>
>> On 2021/1/26 3:31, Chuck Lever wrote:
>>>> On Jan 25, 2021, at 12:39 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>>>
>>>> Hello Lu -
>>>>
>>>> Many thanks for your prototype.
>>>>
>>>>
>>>>> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>>>
>>>>> This patch series is only for Request-For-Testing purpose. It aims to
>>>>> fix the performance regression reported here.
>>>>>
>>>>> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
>>>>>
>>>>> The first two patches are borrowed from here.
>>>>>
>>>>> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
>>>>>
>>>>> Please kindly help to verification.
>>>>>
>>>>> Best regards,
>>>>> baolu
>>>>>
>>>>> Lu Baolu (1):
>>>>> iommu/vt-d: Add iotlb_sync_map callback
>>>>>
>>>>> Yong Wu (2):
>>>>> iommu: Move iotlb_sync_map out from __iommu_map
>>>>> iommu: Add iova and size as parameters in iotlb_sync_map
>>>>>
>>>>> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
>>>>> drivers/iommu/iommu.c       | 23 +++++++---
>>>>> drivers/iommu/tegra-gart.c  |  7 ++-
>>>>> include/linux/iommu.h       |  3 +-
>>>>> 4 files changed, 83 insertions(+), 36 deletions(-)
>>>>
>>>> Here are results with the NFS client at stock v5.11-rc5 and the
>>>> NFS server at v5.10, showing the regression I reported earlier.
>>>>
>>>> 	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
>>>> 	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
>>>> 	Min throughput per process                      = 373101.59 kB/sec
>>>> 	Max throughput per process                      = 382669.50 kB/sec
>>>> 	Avg throughput per process                      = 377881.83 kB/sec
>>>> 	Min xfer                                        = 1022720.00 kB
>>>> 	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %
>>>>
>>>>
>>>> 	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
>>>> 	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
>>>> 	Min throughput per process                      = 374672.00 kB/sec
>>>> 	Max throughput per process                      = 383983.78 kB/sec
>>>> 	Avg throughput per process                      = 378500.26 kB/sec
>>>> 	Min xfer                                        = 1022976.00 kB
>>>> 	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %
>>>>
>>>>
>>>> 	Children see throughput for 12 readers          = 4568632.03 kB/sec
>>>> 	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
>>>> 	Min throughput per process                      = 376727.56 kB/sec
>>>> 	Max throughput per process                      = 383783.91 kB/sec
>>>> 	Avg throughput per process                      = 380719.34 kB/sec
>>>> 	Min xfer                                        = 1029376.00 kB
>>>> 	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %
>>>>
>>>>
>>>> 	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
>>>> 	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
>>>> 	Min throughput per process                      = 381532.78 kB/sec
>>>> 	Max throughput per process                      = 387072.53 kB/sec
>>>> 	Avg throughput per process                      = 384225.23 kB/sec
>>>> 	Min xfer                                        = 1034496.00 kB
>>>> 	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %
>>>>
>>>> Here's the NFS client at v5.11-rc5 with your series applied.
>>>> The NFS server remains at v5.10:
>>>>
>>>> 	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
>>>> 	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
>>>> 	Min throughput per process                      = 367865.28 kB/sec
>>>> 	Max throughput per process                      = 371134.38 kB/sec
>>>> 	Avg throughput per process                      = 369564.90 kB/sec
>>>> 	Min xfer                                        = 1039360.00 kB
>>>> 	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %
>>>>
>>>>
>>>> 	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
>>>> 	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
>>>> 	Min throughput per process                      = 370985.34 kB/sec
>>>> 	Max throughput per process                      = 374752.28 kB/sec
>>>> 	Avg throughput per process                      = 373072.56 kB/sec
>>>> 	Min xfer                                        = 1038592.00 kB
>>>> 	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %
>>>>
>>>>
>>>> 	Children see throughput for 12 readers          = 5865268.88 kB/sec
>>>> 	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
>>>> 	Min throughput per process                      = 487766.81 kB/sec
>>>> 	Max throughput per process                      = 489623.88 kB/sec
>>>> 	Avg throughput per process                      = 488772.41 kB/sec
>>>> 	Min xfer                                        = 1044736.00 kB
>>>> 	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %
>>>>
>>>>
>>>> 	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
>>>> 	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
>>>> 	Min throughput per process                      = 485835.03 kB/sec
>>>> 	Max throughput per process                      = 488702.12 kB/sec
>>>> 	Avg throughput per process                      = 487286.55 kB/sec
>>>> 	Min xfer                                        = 1042688.00 kB
>>>> 	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %
>>>>
>>>> NFS READ throughput is almost fully restored. A normal-looking throughput
>>>> result, copied from the previous thread, is:
>>>>
>>>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>>>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>>>
>>>> The NFS WRITE throughput result appears to be unchanged, or slightly
>>>> worse than before. I don't have an explanation for this result. I applied
>>>> your patches on the NFS server also without noting improvement.
>>> Function-boundary tracing shows some interesting results.
>>> # trace-cmd record -e rpcrdma -e iommu -p function_graph --max-graph-depth=5 -g dma_map_sg_attrs
>>> Some 120KB SGLs are DMA-mapped in a single call to __iommu_map(). Other SGLs of
>>> the same size need as many as one __iommu_map() call per SGL element (which
>>> would be 30 for a 120KB SGL).
>>> In v5.10, intel_map_sg() was structured such that an SGL is always handled with
>>> a single call to domain_mapping() and thus always just a single TLB flush.
>>> My amateur theorizing suggests that the SGL element coalescing done in
>>> __iommu_map_sg() is not working as well as intel_map_sg() used to, which results
>>> in more calls to domain_mapping(). Not only does that take longer, but it creates
>>> many more DMA maps. Could that also have some impact on device TLB resources?
>>
>> It seems that more domain_mapping() calls are not caused by
>> __iommu_map_sg() but __iommu_map().
>>
>> Can you please test below changes? It call intel_iommu_map() directly
>> instead of __iommu_map().
>>
>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>> index f5a236e63ded..660d5744a117 100644
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4916,7 +4916,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
>> }
>> #endif
>>
>> -static int intel_iommu_map(struct iommu_domain *domain,
>> +int intel_iommu_map(struct iommu_domain *domain,
>>                            unsigned long iova, phys_addr_t hpa,
>>                            size_t size, int iommu_prot, gfp_t gfp)
>> {
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 3d099a31ddca..a1b41fd3fb4e 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -23,8 +23,13 @@
>> #include <linux/property.h>
>> #include <linux/fsl/mc.h>
>> #include <linux/module.h>
>> +#include <linux/intel-iommu.h>
>> #include <trace/events/iommu.h>
>>
>> +extern int intel_iommu_map(struct iommu_domain *domain,
>> +                          unsigned long iova, phys_addr_t hpa,
>> +                          size_t size, int iommu_prot, gfp_t gfp);
>> +
>> static struct kset *iommu_group_kset;
>> static DEFINE_IDA(iommu_group_ida);
>>
>> @@ -2553,8 +2558,7 @@ static size_t __iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
>>                 phys_addr_t s_phys = sg_phys(sg);
>>
>>                 if (len && s_phys != start + len) {
>> -                       ret = __iommu_map(domain, iova + mapped, start,
>> -                                       len, prot, gfp);
>> +                       ret = intel_iommu_map(domain, iova + mapped, start, len, prot, gfp);
>>
>>                         if (ret)
>>                                 goto out_err;
>>
>> Does it change anything?
> 
> I removed yesterday's 3-patch series, and applied the above.
> Not a full restoration, but interesting nonetheless.

Do you mind having a try with all 4 patches?

> 
> 	Children see throughput for 12 initial writers 	= 4852657.22 kB/sec
> 	Parent sees throughput for 12 initial writers 	= 4826730.38 kB/sec
> 	Min throughput per process 			=  403196.09 kB/sec
> 	Max throughput per process 			=  406071.47 kB/sec
> 	Avg throughput per process 			=  404388.10 kB/sec
> 	Min xfer 					= 1041408.00 kB
> 	CPU Utilization: Wall time    2.596    CPU time    2.047    CPU utilization  78.84 %
> 
> 
> 	Children see throughput for 12 rewriters 	= 4853900.22 kB/sec
> 	Parent sees throughput for 12 rewriters 	= 4848623.31 kB/sec
> 	Min throughput per process 			=  403380.81 kB/sec
> 	Max throughput per process 			=  405478.53 kB/sec
> 	Avg throughput per process 			=  404491.68 kB/sec
> 	Min xfer 					= 1042944.00 kB
> 	CPU utilization: Wall time    2.589    CPU time    2.048    CPU utilization  79.12 %
> 
> 
> 	Children see throughput for 12 readers 		= 4938124.12 kB/sec
> 	Parent sees throughput for 12 readers 		= 4932862.08 kB/sec
> 	Min throughput per process 			=  408768.81 kB/sec
> 	Max throughput per process 			=  413879.25 kB/sec
> 	Avg throughput per process 			=  411510.34 kB/sec
> 	Min xfer 					= 1036800.00 kB
> 	CPU utilization: Wall time    2.536    CPU time    1.906    CPU utilization  75.16 %
> 
> 
> 	Children see throughput for 12 re-readers 	= 4992115.16 kB/sec
> 	Parent sees throughput for 12 re-readers 	= 4986102.07 kB/sec
> 	Min throughput per process 			=  411103.00 kB/sec
> 	Max throughput per process 			=  420302.97 kB/sec
> 	Avg throughput per process 			=  416009.60 kB/sec
> 	Min xfer 					= 1025792.00 kB
> 	CPU utilization: Wall time    2.497    CPU time    1.887    CPU utilization  75.57 %
> 
> NFS WRITE throughput improves significantly. NFS READ throughput
> improves somewhat, but not to the degree it did with yesterday's
> patch series.
> 
> function_graph shows a single intel_iommu_map() is used more
> frequently, but the following happens on occasion:

This is because the pages are not physically contiguous, __iommu_map_sg
can't coalesce them.

If there's no full restoration with all four patches, it could be due to
ping-pongs between iommu core and the vendor iommu driver with indirect
calls. Hence a possible solution is to add an iommu_ops->map_sg() so
that all scatter gathered items could be handled in a single function as
before. This has already proposed by Isaac J. Manjarres.

https://lore.kernel.org/linux-iommu/1610376862-927-5-git-send-email-isaacm@codeaurora.org/

Best regards,
baolu

> 
> 395.678889: funcgraph_entry:                   |  dma_map_sg_attrs() {
> 395.678889: funcgraph_entry:                   |    iommu_dma_map_sg() {
> 395.678890: funcgraph_entry:        0.257 us   |      iommu_get_dma_domain();
> 395.678890: funcgraph_entry:        0.255 us   |      iommu_dma_deferred_attach();
> 395.678891: funcgraph_entry:                   |      iommu_dma_sync_sg_for_device() {
> 395.678891: funcgraph_entry:        0.253 us   |        dev_is_untrusted();
> 395.678891: funcgraph_exit:         0.773 us   |      }
> 395.678892: funcgraph_entry:        0.250 us   |      dev_is_untrusted();
> 395.678893: funcgraph_entry:                   |      iommu_dma_alloc_iova() {
> 395.678893: funcgraph_entry:                   |        alloc_iova_fast() {
> 395.678893: funcgraph_entry:        0.255 us   |          _raw_spin_lock_irqsave();
> 395.678894: funcgraph_entry:        0.375 us   |          __lock_text_start();
> 395.678894: funcgraph_exit:         1.435 us   |        }
> 395.678895: funcgraph_exit:         2.002 us   |      }
> 395.678895: funcgraph_entry:        0.252 us   |      dma_info_to_prot();
> 395.678895: funcgraph_entry:                   |      iommu_map_sg_atomic() {
> 395.678896: funcgraph_entry:                   |        __iommu_map_sg() {
> 395.678896: funcgraph_entry:        1.675 us   |          intel_iommu_map();
> 395.678898: funcgraph_entry:        1.365 us   |          intel_iommu_map();
> 395.678900: funcgraph_entry:        1.373 us   |          intel_iommu_map();
> 395.678901: funcgraph_entry:        1.378 us   |          intel_iommu_map();
> 395.678903: funcgraph_entry:        1.380 us   |          intel_iommu_map();
> 395.678905: funcgraph_entry:        1.380 us   |          intel_iommu_map();
> 395.678906: funcgraph_entry:        1.378 us   |          intel_iommu_map();
> 395.678908: funcgraph_entry:        1.380 us   |          intel_iommu_map();
> 395.678910: funcgraph_entry:        1.345 us   |          intel_iommu_map();
> 395.678911: funcgraph_entry:        1.342 us   |          intel_iommu_map();
> 395.678913: funcgraph_entry:        1.342 us   |          intel_iommu_map();
> 395.678915: funcgraph_entry:        1.395 us   |          intel_iommu_map();
> 395.678916: funcgraph_entry:        1.343 us   |          intel_iommu_map();
> 395.678918: funcgraph_entry:        1.350 us   |          intel_iommu_map();
> 395.678920: funcgraph_entry:        1.395 us   |          intel_iommu_map();
> 395.678921: funcgraph_entry:        1.342 us   |          intel_iommu_map();
> 395.678923: funcgraph_entry:        1.350 us   |          intel_iommu_map();
> 395.678924: funcgraph_entry:        1.345 us   |          intel_iommu_map();
> 395.678926: funcgraph_entry:        1.345 us   |          intel_iommu_map();
> 395.678928: funcgraph_entry:        1.340 us   |          intel_iommu_map();
> 395.678929: funcgraph_entry:        1.342 us   |          intel_iommu_map();
> 395.678931: funcgraph_entry:        1.335 us   |          intel_iommu_map();
> 395.678933: funcgraph_entry:        1.345 us   |          intel_iommu_map();
> 395.678934: funcgraph_entry:        1.337 us   |          intel_iommu_map();
> 395.678936: funcgraph_entry:        1.305 us   |          intel_iommu_map();
> 395.678938: funcgraph_entry:        1.380 us   |          intel_iommu_map();
> 395.678939: funcgraph_entry:        1.365 us   |          intel_iommu_map();
> 395.678941: funcgraph_entry:        1.370 us   |          intel_iommu_map();
> 395.678943: funcgraph_entry:        1.365 us   |          intel_iommu_map();
> 395.678945: funcgraph_entry:        1.482 us   |          intel_iommu_map();
> 395.678946: funcgraph_exit:       + 50.753 us  |        }
> 395.678947: funcgraph_exit:       + 51.348 us  |      }
> 395.678947: funcgraph_exit:       + 57.975 us  |    }
> 395.678948: funcgraph_exit:       + 58.700 us  |  }
> 395.678953: xprtrdma_mr_map:      task:64127@5 mr.id=104 nents=30 122880@0xc5e467fde9380000:0xc0011103 (TO_DEVICE)
> 395.678953: xprtrdma_chunk_read:  task:64127@5 pos=148 122880@0xc5e467fde9380000:0xc0011103 (more)
> 
> 
> --
> Chuck Lever
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
