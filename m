Return-Path: <SRS0=WqUy=VV=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91109C7618B
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 09:58:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F2A3229F3
	for <iommu@archiver.kernel.org>; Wed, 24 Jul 2019 09:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2A3229F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 19060CAA;
	Wed, 24 Jul 2019 09:58:49 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D2AD22C
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 09:58:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id D9BAE224
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Jul 2019 09:58:46 +0000 (UTC)
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
	by Forcepoint Email with ESMTP id 933CCE03C30576A54128;
	Wed, 24 Jul 2019 17:58:44 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS409-HUB.china.huawei.com
	(10.3.19.209) with Microsoft SMTP Server id 14.3.439.0;
	Wed, 24 Jul 2019 17:58:34 +0800
Subject: Re: [RFC PATCH v2 00/19] Try to reduce lock contention on the SMMUv3
	command queue
To: Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>
References: <20190711171927.28803-1-will@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <c8dcc53f-8afa-0966-dcfd-ca79b099893f@huawei.com>
Date: Wed, 24 Jul 2019 10:58:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190711171927.28803-1-will@kernel.org>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Vijay Kilary <vkilari@codeaurora.org>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>, Alex
	Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 11/07/2019 18:19, Will Deacon wrote:
> Hi everyone,
>
> This is a significant rework of the RFC I previously posted here:
>
>   https://lkml.kernel.org/r/20190611134603.4253-1-will.deacon@arm.com
>
> But this time, it looks like it might actually be worthwhile according
> to my perf profiles, where __iommu_unmap() falls a long way down the
> profile for a multi-threaded netperf run. I'm still relying on others to
> confirm this is useful, however.
>
> Some of the changes since last time are:
>
>   * Support for constructing and submitting a list of commands in the
>     driver
>
>   * Numerous changes to the IOMMU and io-pgtable APIs so that we can
>     submit commands in batches
>
>   * Removal of cmpxchg() from cmdq_shared_lock() fast-path
>
>   * Code restructuring and cleanups
>
> This current applies against my iommu/devel branch that Joerg has pulled
> for 5.3. If you want to test it out, I've put everything here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq
>
> Feedback welcome. I appreciate that we're in the merge window, but I
> wanted to get this on the list for people to look at as an RFC.
>

I tested storage performance on this series, which I think is a better 
scenario to test than network performance, that being generally limited 
by the network link speed.

Results:

Baseline performance (will/iommu/devel, commit 9e6ea59f3)
8x SAS disks D05	839K IOPS
1x NVMe D05		454K IOPS
1x NVMe D06		442k IOPS

Patchset performance (will/iommu/cmdq)
8x SAS disk D05		835K IOPS
1x NVMe D05		472K IOPS
1x NVMe D06		459k IOPS

So we see a bit of an NVMe boost, but about the same for 8x disks. No 
iommu performance is about 918K IOPs for 8x disks, so it is not limited 
by the medium.

The D06 is a bit memory starved, so that may account for generally lower 
NVMe performance.

John

> Cheers,
>
> Will
>
> --->8
>
> Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jayachandran Chandrasekharan Nair <jnair@marvell.com>
> Cc: Jan Glauber <jglauber@marvell.com>
> Cc: Jon Masters <jcm@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Zhen Lei <thunder.leizhen@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Vijay Kilary <vkilari@codeaurora.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: John Garry <john.garry@huawei.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
>
> Will Deacon (19):
>   iommu: Remove empty iommu_tlb_range_add() callback from iommu_ops
>   iommu/io-pgtable-arm: Remove redundant call to io_pgtable_tlb_sync()
>   iommu/io-pgtable: Rename iommu_gather_ops to iommu_flush_ops
>   iommu: Introduce struct iommu_iotlb_gather for batching TLB flushes
>   iommu: Introduce iommu_iotlb_gather_add_page()
>   iommu: Pass struct iommu_iotlb_gather to ->unmap() and ->iotlb_sync()
>   iommu/io-pgtable: Introduce tlb_flush_walk() and tlb_flush_leaf()
>   iommu/io-pgtable: Hook up ->tlb_flush_walk() and ->tlb_flush_leaf() in
>     drivers
>   iommu/io-pgtable-arm: Call ->tlb_flush_walk() and ->tlb_flush_leaf()
>   iommu/io-pgtable: Replace ->tlb_add_flush() with ->tlb_add_page()
>   iommu/io-pgtable: Remove unused ->tlb_sync() callback
>   iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->unmap()
>   iommu/io-pgtable: Pass struct iommu_iotlb_gather to ->tlb_add_page()
>   iommu/arm-smmu-v3: Separate s/w and h/w views of prod and cons indexes
>   iommu/arm-smmu-v3: Drop unused 'q' argument from Q_OVF macro
>   iommu/arm-smmu-v3: Move low-level queue fields out of arm_smmu_queue
>   iommu/arm-smmu-v3: Operate directly on low-level queue where possible
>   iommu/arm-smmu-v3: Reduce contention during command-queue insertion
>   iommu/arm-smmu-v3: Defer TLB invalidation until ->iotlb_sync()
>
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  24 +-
>  drivers/iommu/amd_iommu.c               |  11 +-
>  drivers/iommu/arm-smmu-v3.c             | 856 ++++++++++++++++++++++++--------
>  drivers/iommu/arm-smmu.c                | 103 +++-
>  drivers/iommu/dma-iommu.c               |   9 +-
>  drivers/iommu/exynos-iommu.c            |   3 +-
>  drivers/iommu/intel-iommu.c             |   3 +-
>  drivers/iommu/io-pgtable-arm-v7s.c      |  57 +--
>  drivers/iommu/io-pgtable-arm.c          |  48 +-
>  drivers/iommu/iommu.c                   |  24 +-
>  drivers/iommu/ipmmu-vmsa.c              |  28 +-
>  drivers/iommu/msm_iommu.c               |  42 +-
>  drivers/iommu/mtk_iommu.c               |  45 +-
>  drivers/iommu/mtk_iommu_v1.c            |   3 +-
>  drivers/iommu/omap-iommu.c              |   2 +-
>  drivers/iommu/qcom_iommu.c              |  44 +-
>  drivers/iommu/rockchip-iommu.c          |   2 +-
>  drivers/iommu/s390-iommu.c              |   3 +-
>  drivers/iommu/tegra-gart.c              |  12 +-
>  drivers/iommu/tegra-smmu.c              |   2 +-
>  drivers/vfio/vfio_iommu_type1.c         |  27 +-
>  include/linux/io-pgtable.h              |  57 ++-
>  include/linux/iommu.h                   |  92 +++-
>  23 files changed, 1090 insertions(+), 407 deletions(-)
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
