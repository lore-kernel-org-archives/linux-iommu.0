Return-Path: <SRS0=UfkB=G5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E267BC433E0
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:18:49 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E3122B37
	for <iommu@archiver.kernel.org>; Tue, 26 Jan 2021 06:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E3122B37
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D0764865D0;
	Tue, 26 Jan 2021 06:18:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HlD0FYpZoyiE; Tue, 26 Jan 2021 06:18:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 76C1C865C1;
	Tue, 26 Jan 2021 06:18:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41DE0C08A1;
	Tue, 26 Jan 2021 06:18:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 922EBC013A
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:18:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 6D5472033E
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:18:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5wDr3L+g0GIF for <iommu@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 06:18:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id BC83C20029
 for <iommu@lists.linux-foundation.org>; Tue, 26 Jan 2021 06:18:44 +0000 (UTC)
IronPort-SDR: AbO1asdS4TGsrIuTAnfnLetlGB9FT1BzjM4KwPYnqwc35ZKGnPyfFtFKITt4AFFFdxWA5TUm6Y
 ZTCWV9I5iTiQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="243935273"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="243935273"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 22:18:41 -0800
IronPort-SDR: 0Z5YCz0YPeEjQJ8UNYDg9bl2dQX2/Bz7B9lzLTvVp6irbXBPyWiyW72i4sFMDZiQQCyqEBFN8A
 NBboZtl9iSVQ==
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; d="scan'208";a="387703385"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.255.28.93])
 ([10.255.28.93])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 22:18:39 -0800
Subject: Re: [RFT PATCH 0/3] Performance regression noted in v5.11-rc after
 c062db039f40
To: Chuck Lever <chuck.lever@oracle.com>
References: <20210125023858.570175-1-baolu.lu@linux.intel.com>
 <BDAEAC42-15F2-4C75-A28C-8E580F0CFF01@oracle.com>
 <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7937bfa5-5cb9-0a23-176c-e91e5e9ac962@linux.intel.com>
Date: Tue, 26 Jan 2021 14:18:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <83EE54C6-F654-4D1D-92F7-F442ACEC8D70@oracle.com>
Content-Language: en-US
Cc: Robin Murphy <robin.murphy@arm.com>,
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

On 2021/1/26 3:31, Chuck Lever wrote:
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
> 
> My amateur theorizing suggests that the SGL element coalescing done in
> __iommu_map_sg() is not working as well as intel_map_sg() used to, which results
> in more calls to domain_mapping(). Not only does that take longer, but it creates
> many more DMA maps. Could that also have some impact on device TLB resources?

It seems that more domain_mapping() calls are not caused by
__iommu_map_sg() but __iommu_map().

Can you please test below changes? It call intel_iommu_map() directly
instead of __iommu_map().

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f5a236e63ded..660d5744a117 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4916,7 +4916,7 @@ intel_iommu_sva_invalidate(struct iommu_domain 
*domain, struct device *dev,
  }
  #endif

-static int intel_iommu_map(struct iommu_domain *domain,
+int intel_iommu_map(struct iommu_domain *domain,
                            unsigned long iova, phys_addr_t hpa,
                            size_t size, int iommu_prot, gfp_t gfp)
  {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3d099a31ddca..a1b41fd3fb4e 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -23,8 +23,13 @@
  #include <linux/property.h>
  #include <linux/fsl/mc.h>
  #include <linux/module.h>
+#include <linux/intel-iommu.h>
  #include <trace/events/iommu.h>

+extern int intel_iommu_map(struct iommu_domain *domain,
+                          unsigned long iova, phys_addr_t hpa,
+                          size_t size, int iommu_prot, gfp_t gfp);
+
  static struct kset *iommu_group_kset;
  static DEFINE_IDA(iommu_group_ida);

@@ -2553,8 +2558,7 @@ static size_t __iommu_map_sg(struct iommu_domain 
*domain, unsigned long iova,
                 phys_addr_t s_phys = sg_phys(sg);

                 if (len && s_phys != start + len) {
-                       ret = __iommu_map(domain, iova + mapped, start,
-                                       len, prot, gfp);
+                       ret = intel_iommu_map(domain, iova + mapped, 
start, len, prot, gfp);

                         if (ret)
                                 goto out_err;

Does it change anything?

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
