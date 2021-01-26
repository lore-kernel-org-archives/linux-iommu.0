Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E95C433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ACD72220B
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 16:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ACD72220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 15F658700A;
	Tue, 26 Jan 2021 16:05:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6qrzG5wkRp7I; Tue, 26 Jan 2021 16:05:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DADA884C3E;
	Tue, 26 Jan 2021 16:05:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2F06C08A1;
	Tue, 26 Jan 2021 16:05:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B462C013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6FB2D8674E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:05:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZFaucTGWh5Kt for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 16:05:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id DB9498674D
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 16:05:47 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0328E31B;
 Tue, 26 Jan 2021 08:05:47 -0800 (PST)
Received: from [10.57.43.46] (unknown [10.57.43.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4BE83F66E;
 Tue, 26 Jan 2021 08:05:45 -0800 (PST)
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
To: Chuck Lever <chuck.lever@oracle.com>, Lu Baolu <baolu.lu@linux.intel.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <8fd70fb7-6865-1b11-2a16-9bf473004662@arm.com>
Date: Tue, 26 Jan 2021 16:05:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
Content-Language: en-GB
Cc: Will Deacon <will@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
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

On 2021-01-25 19:31, Chuck Lever wrote:
> 
> 
>> On Jan 25, 2021, at 12:39 PM, Chuck Lever <chuck.lever@oracle.com> wrote:
>>
>> Hello Lu -
>>
>> Many thanks for your prototype.
>>
>>
>>> On Jan 24, 2021, at 9:38 PM, Lu Baolu <baolu.lu@linux.intel.com> wrote:
>>>
>>> This patch series is only for Request-For-Testing purpose. It aims to
>>> fix the performance regression reported here.
>>>
>>> https://lore.kernel.org/linux-iommu/D81314ED-5673-44A6-B597-090E3CB83EB0@oracle.com/
>>>
>>> The first two patches are borrowed from here.
>>>
>>> https://lore.kernel.org/linux-iommu/20210107122909.16317-1-yong.wu@mediatek.com/
>>>
>>> Please kindly help to verification.
>>>
>>> Best regards,
>>> baolu
>>>
>>> Lu Baolu (1):
>>> iommu/vt-d: Add iotlb_sync_map callback
>>>
>>> Yong Wu (2):
>>> iommu: Move iotlb_sync_map out from __iommu_map
>>> iommu: Add iova and size as parameters in iotlb_sync_map
>>>
>>> drivers/iommu/intel/iommu.c | 86 +++++++++++++++++++++++++------------
>>> drivers/iommu/iommu.c       | 23 +++++++---
>>> drivers/iommu/tegra-gart.c  |  7 ++-
>>> include/linux/iommu.h       |  3 +-
>>> 4 files changed, 83 insertions(+), 36 deletions(-)
>>
>> Here are results with the NFS client at stock v5.11-rc5 and the
>> NFS server at v5.10, showing the regression I reported earlier.
>>
>> 	Children see throughput for 12 initial writers  = 4534582.00 kB/sec
>> 	Parent sees throughput for 12 initial writers   = 4458145.56 kB/sec
>> 	Min throughput per process                      = 373101.59 kB/sec
>> 	Max throughput per process                      = 382669.50 kB/sec
>> 	Avg throughput per process                      = 377881.83 kB/sec
>> 	Min xfer                                        = 1022720.00 kB
>> 	CPU Utilization: Wall time    2.787    CPU time    1.922    CPU utilization  68.95 %
>>
>>
>> 	Children see throughput for 12 rewriters        = 4542003.12 kB/sec
>> 	Parent sees throughput for 12 rewriters         = 4538024.19 kB/sec
>> 	Min throughput per process                      = 374672.00 kB/sec
>> 	Max throughput per process                      = 383983.78 kB/sec
>> 	Avg throughput per process                      = 378500.26 kB/sec
>> 	Min xfer                                        = 1022976.00 kB
>> 	CPU utilization: Wall time    2.733    CPU time    1.947    CPU utilization  71.25 %
>>
>>
>> 	Children see throughput for 12 readers          = 4568632.03 kB/sec
>> 	Parent sees throughput for 12 readers           = 4563672.02 kB/sec
>> 	Min throughput per process                      = 376727.56 kB/sec
>> 	Max throughput per process                      = 383783.91 kB/sec
>> 	Avg throughput per process                      = 380719.34 kB/sec
>> 	Min xfer                                        = 1029376.00 kB
>> 	CPU utilization: Wall time    2.733    CPU time    1.898    CPU utilization  69.46 %
>>
>>
>> 	Children see throughput for 12 re-readers       = 4610702.78 kB/sec
>> 	Parent sees throughput for 12 re-readers        = 4606135.66 kB/sec
>> 	Min throughput per process                      = 381532.78 kB/sec
>> 	Max throughput per process                      = 387072.53 kB/sec
>> 	Avg throughput per process                      = 384225.23 kB/sec
>> 	Min xfer                                        = 1034496.00 kB
>> 	CPU utilization: Wall time    2.711    CPU time    1.910    CPU utilization  70.45 %
>>
>> Here's the NFS client at v5.11-rc5 with your series applied.
>> The NFS server remains at v5.10:
>>
>> 	Children see throughput for 12 initial writers  = 4434778.81 kB/sec
>> 	Parent sees throughput for 12 initial writers   = 4408190.69 kB/sec
>> 	Min throughput per process                      = 367865.28 kB/sec
>> 	Max throughput per process                      = 371134.38 kB/sec
>> 	Avg throughput per process                      = 369564.90 kB/sec
>> 	Min xfer                                        = 1039360.00 kB
>> 	CPU Utilization: Wall time    2.842    CPU time    1.904    CPU utilization  66.99 %
>>
>>
>> 	Children see throughput for 12 rewriters        = 4476870.69 kB/sec
>> 	Parent sees throughput for 12 rewriters         = 4471701.48 kB/sec
>> 	Min throughput per process                      = 370985.34 kB/sec
>> 	Max throughput per process                      = 374752.28 kB/sec
>> 	Avg throughput per process                      = 373072.56 kB/sec
>> 	Min xfer                                        = 1038592.00 kB
>> 	CPU utilization: Wall time    2.801    CPU time    1.902    CPU utilization  67.91 %
>>
>>
>> 	Children see throughput for 12 readers          = 5865268.88 kB/sec
>> 	Parent sees throughput for 12 readers           = 5854519.73 kB/sec
>> 	Min throughput per process                      = 487766.81 kB/sec
>> 	Max throughput per process                      = 489623.88 kB/sec
>> 	Avg throughput per process                      = 488772.41 kB/sec
>> 	Min xfer                                        = 1044736.00 kB
>> 	CPU utilization: Wall time    2.144    CPU time    1.895    CPU utilization  88.41 %
>>
>>
>> 	Children see throughput for 12 re-readers       = 5847438.62 kB/sec
>> 	Parent sees throughput for 12 re-readers        = 5839292.18 kB/sec
>> 	Min throughput per process                      = 485835.03 kB/sec
>> 	Max throughput per process                      = 488702.12 kB/sec
>> 	Avg throughput per process                      = 487286.55 kB/sec
>> 	Min xfer                                        = 1042688.00 kB
>> 	CPU utilization: Wall time    2.148    CPU time    1.909    CPU utilization  88.84 %
>>
>> NFS READ throughput is almost fully restored. A normal-looking throughput
>> result, copied from the previous thread, is:
>>
>> 	Children see throughput for 12 readers 		= 5921370.94 kB/sec
>> 	Parent sees throughput for 12 readers 		= 5914106.69 kB/sec
>>
>> The NFS WRITE throughput result appears to be unchanged, or slightly
>> worse than before. I don't have an explanation for this result. I applied
>> your patches on the NFS server also without noting improvement.
> 
> Function-boundary tracing shows some interesting results.
> 
> # trace-cmd record -e rpcrdma -e iommu -p function_graph --max-graph-depth=5 -g dma_map_sg_attrs
> 
> Some 120KB SGLs are DMA-mapped in a single call to __iommu_map(). Other SGLs of
> the same size need as many as one __iommu_map() call per SGL element (which
> would be 30 for a 120KB SGL).
> 
> In v5.10, intel_map_sg() was structured such that an SGL is always handled with
> a single call to domain_mapping() and thus always just a single TLB flush.

Implementing .iotlb_sync_map means that a single top-level 
iommu_map()/iommu_map_sg() call should still only invoke a single "TLB 
flush" (really, any maintenance required for the IOMMU to start using 
the new mapping) at the end, regardless of how many internal 
__iommu_map() calls are made to satisfy the overall request. If you're 
seeing something other than that behaviour (with this series), that 
implies we've not got things quite right yet.

> My amateur theorizing suggests that the SGL element coalescing done in
> __iommu_map_sg() is not working as well as intel_map_sg() used to, which results
> in more calls to domain_mapping(). Not only does that take longer, but it creates
> many more DMA maps. Could that also have some impact on device TLB resources?

FWIW the old __domain_mapping() code just did a dumb iteration over the 
scatterlist segments internally, so __iommu_map_sg() should be no worse 
in that regard, and could in principle even be better if it's able to 
coalesce things far enough to start fitting large page mappings. The 
only appreciable difference *should* be any additional self-time in 
__iommu_map() due to the iteration now being performed one layer up.

Is there any significant difference between how the NFS read and write 
paths make their DMA API calls and/or get their scatterlists in the 
first place, that might help shed some light on the curious 
half-recovery you got?

Thanks,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
