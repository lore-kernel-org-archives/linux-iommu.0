Return-Path: <SRS0=9w/B=G7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3496C433E0
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:59:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A34A64DD9
	for <iommu@archiver.kernel.org>; Thu, 28 Jan 2021 13:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A34A64DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8E6922043A;
	Thu, 28 Jan 2021 13:59:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1Kwn0SZjAvwg; Thu, 28 Jan 2021 13:59:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id EAF40203C4;
	Thu, 28 Jan 2021 13:59:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC8F9C0FA7;
	Thu, 28 Jan 2021 13:59:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CD090C013A
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B40B084D41
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:59:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sqxgvb1VfN-6 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Jan 2021 13:59:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 765D686357
 for <iommu@lists.linux-foundation.org>; Thu, 28 Jan 2021 13:59:43 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FD8D106F;
 Thu, 28 Jan 2021 05:59:42 -0800 (PST)
Received: from [10.57.35.163] (unknown [10.57.35.163])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B60723F71B;
 Thu, 28 Jan 2021 05:59:41 -0800 (PST)
Subject: Re: [PATCH RFC 0/9] Possible set of VT-d optimizations
To: Chuck Lever <chuck.lever@oracle.com>, baolu.lu@linux.intel.com
References: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <1c89a1c1-4a2b-841e-c88f-cd08598a6546@arm.com>
Date: Thu, 28 Jan 2021 13:59:36 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <161177711359.1311.417185373365934204.stgit@manet.1015granger.net>
Content-Language: en-GB
Cc: isaacm@codeaurora.org, iommu@lists.linux-foundation.org, will@kernel.org
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

On 2021-01-27 20:00, Chuck Lever wrote:
> Hi-
> 
> This collection of patches seems to get the best throughtput results
> so far. The NFS WRITE result is fully restored, and the NFS READ
> result is very close to fully restored.
> 
> 	Children see throughput for 12 initial writers  = 5008474.03 kB/sec
> 	Parent sees throughput for 12 initial writers   = 4996927.80 kB/sec
> 	Min throughput per process                      = 416956.88 kB/sec
> 	Max throughput per process                      = 417910.22 kB/sec
> 	Avg throughput per process                      = 417372.84 kB/sec
> 	Min xfer                                        = 1046272.00 kB
> 	CPU Utilization: Wall time    2.515    CPU time    1.996    CPU utilization  79.37 %
> 
> 
> 	Children see throughput for 12 rewriters        = 5020584.59 kB/sec
> 	Parent sees throughput for 12 rewriters         = 5012539.29 kB/sec
> 	Min throughput per process                      = 417799.00 kB/sec
> 	Max throughput per process                      = 419082.22 kB/sec
> 	Avg throughput per process                      = 418382.05 kB/sec
> 	Min xfer                                        = 1046528.00 kB
> 	CPU utilization: Wall time    2.507    CPU time    2.024    CPU utilization  80.73 %
> 
> 
> 	Children see throughput for 12 readers          = 5805484.25 kB/sec
> 	Parent sees throughput for 12 readers           = 5799535.68 kB/sec
> 	Min throughput per process                      = 482888.16 kB/sec
> 	Max throughput per process                      = 484444.16 kB/sec
> 	Avg throughput per process                      = 483790.35 kB/sec
> 	Min xfer                                        = 1045760.00 kB
> 	CPU utilization: Wall time    2.167    CPU time    1.964    CPU utilization  90.63 %
> 
> 
> 	Children see throughput for 12 re-readers       = 5812227.16 kB/sec
> 	Parent sees throughput for 12 re-readers        = 5803793.06 kB/sec
> 	Min throughput per process                      = 483242.97 kB/sec
> 	Max throughput per process                      = 485724.41 kB/sec
> 	Avg throughput per process                      = 484352.26 kB/sec
> 	Min xfer                                        = 1043456.00 kB
> 	CPU utilization: Wall time    2.161    CPU time    1.976    CPU utilization  91.45 %
> 
> I've included a simple-minded implementation of a map_sg op for
> the Intel IOMMU. This is nothing more than a copy of the loop in
> __iommu_map_sg() with the call to __iommu_map() replaced with a
> call to intel_iommu_map().

...which is the main reason I continue to strongly dislike patches #4-#9 
(#3 definitely seems to makes sense either way, now that #1 and #2 are 
going to land). If a common operation is worth optimising anywhere, then 
it deserves optimising everywhere, so we end up with a dozen diverging 
copies of essentially the same code - particularly when the 
driver-specific functionality *is* already in the drivers, so what gets 
duplicated is solely the "generic" parts.

And if there's justification for pushing iommu_map_sg() entirely into 
drivers, then it's verging on self-contradictory not to do the same for 
iommu_map() and iommu_unmap(). Some IOMMU drivers - mainly intel-iommu, 
as it happens - are already implementing hacks around the "one call per 
page" interface being inherently inefficient, so the logical thing to do 
here is take a step back and reconsider the fundamental design of the 
whole map/unmap interface. Implementing hacks on top of hacks to make 
particular things faster on particular systems that particular people 
care about is not going to do us any favours in the long run.

As it stands, I can easily see a weird anti-pattern emerging where 
people start adding code to fake up scatterlists in random drivers 
because they see dma_map_sg() performing paradoxically better than 
dma_map_page().

Robin.

> ---
> 
> Chuck Lever (1):
>        iommu/vt-d: Introduce map_sg() for Intel IOMMUs
> 
> Isaac J. Manjarres (5):
>        iommu/io-pgtable: Introduce map_sg() as a page table op
>        iommu/io-pgtable-arm: Hook up map_sg()
>        iommu/io-pgtable-arm-v7s: Hook up map_sg()
>        iommu: Introduce map_sg() as an IOMMU op for IOMMU drivers
>        iommu/arm-smmu: Hook up map_sg()
> 
> Lu Baolu (1):
>        iommu/vt-d: Add iotlb_sync_map callback
> 
> Yong Wu (2):
>        iommu: Move iotlb_sync_map out from __iommu_map
>        iommu: Add iova and size as parameters in iotlb_sync_map
> 
> 
>   drivers/iommu/arm/arm-smmu/arm-smmu.c |  19 ++++
>   drivers/iommu/intel/iommu.c           | 131 ++++++++++++++++++++------
>   drivers/iommu/io-pgtable-arm-v7s.c    |  90 ++++++++++++++++++
>   drivers/iommu/io-pgtable-arm.c        |  86 +++++++++++++++++
>   drivers/iommu/iommu.c                 |  47 +++++++--
>   drivers/iommu/tegra-gart.c            |   7 +-
>   include/linux/iommu.h                 |  16 +++-
>   7 files changed, 353 insertions(+), 43 deletions(-)
> 
> --
> Chuck Lever
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
