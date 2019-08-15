Return-Path: <SRS0=B4OP=WL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C647C31E40
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:20:22 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B61206C2
	for <iommu@archiver.kernel.org>; Thu, 15 Aug 2019 11:20:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B61206C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 238A210AB;
	Thu, 15 Aug 2019 11:20:22 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DC1F0D48
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:20:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id A605667F
	for <iommu@lists.linux-foundation.org>;
	Thu, 15 Aug 2019 11:20:18 +0000 (UTC)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
	by Forcepoint Email with ESMTP id 3F00EC0EA5B982637774;
	Thu, 15 Aug 2019 19:20:16 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS405-HUB.china.huawei.com
	(10.3.19.205) with Microsoft SMTP Server id 14.3.439.0;
	Thu, 15 Aug 2019 19:20:09 +0800
Subject: Re: [PATCH 00/13] Rework IOMMU API to allow for batching of
	invalidation
To: Will Deacon <will@kernel.org>, <iommu@lists.linux-foundation.org>
References: <20190814175634.21081-1-will@kernel.org>
From: John Garry <john.garry@huawei.com>
Message-ID: <78d366b7-590f-b114-1a9a-91dea01cde4d@huawei.com>
Date: Thu, 15 Aug 2019 12:19:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
	Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190814175634.21081-1-will@kernel.org>
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Vijay Kilary <vkilari@codeaurora.org>,
	Jon Masters <jcm@redhat.com>, Jan Glauber <jglauber@marvell.com>, Alex
	Williamson <alex.williamson@redhat.com>,
	Jayachandran Chandrasekharan Nair <jnair@marvell.com>,
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>
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

On 14/08/2019 18:56, Will Deacon wrote:
> Hi everybody,
>
> These are the core IOMMU changes that I have posted previously as part
> of my ongoing effort to reduce the lock contention of the SMMUv3 command
> queue. I thought it would be better to split this out as a separate
> series, since I think it's ready to go and all the driver conversions
> mean that it's quite a pain for me to maintain out of tree!
>
> The idea of the patch series is to allow TLB invalidation to be batched
> up into a new 'struct iommu_iotlb_gather' structure, which tracks the
> properties of the virtual address range being invalidated so that it
> can be deferred until the driver's ->iotlb_sync() function is called.
> This allows for more efficient invalidation on hardware that can submit
> multiple invalidations in one go.
>
> The previous series was included in:
>
>   https://lkml.kernel.org/r/20190711171927.28803-1-will@kernel.org
>
> The only real change since then is incorporating the newly merged
> virtio-iommu driver.
>
> If you'd like to play with the patches, then I've also pushed them here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/unmap
>
> but they should behave as a no-op on their own.

Hi Will,

As anticipated, my storage testing scenarios roughly give parity 
throughput and CPU loading before and after this series.

Patches to convert the
> Arm SMMUv3 driver to the new API are here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=iommu/cmdq

I quickly tested this again and now I see a performance lift:

			before (5.3-rc1)		after
D05 8x SAS disks	907K IOPS			970K IOPS
D05 1x NVMe		450K IOPS			466K IOPS
D06 1x NVMe		467K IOPS			466K IOPS

The CPU loading seems to track throughput, so nothing much to say there.

Note: From 5.2 testing, I was seeing >900K IOPS from that NVMe disk for 
!IOMMU.

BTW, what were your thoughts on changing 
arm_smmu_atc_inv_domain()->arm_smmu_atc_inv_master() to batching? It 
seems suitable, but looks untouched. Were you waiting for a resolution 
to the performance issue which Leizhen reported?

Thanks,
John

>
> Cheers,
>
> Will
>
> --->8
>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
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
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
>
> Will Deacon (13):
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
>
>  drivers/gpu/drm/panfrost/panfrost_mmu.c |  24 +++++---
>  drivers/iommu/amd_iommu.c               |  11 ++--
>  drivers/iommu/arm-smmu-v3.c             |  52 +++++++++++-----
>  drivers/iommu/arm-smmu.c                | 103 ++++++++++++++++++++++++--------
>  drivers/iommu/dma-iommu.c               |   9 ++-
>  drivers/iommu/exynos-iommu.c            |   3 +-
>  drivers/iommu/intel-iommu.c             |   3 +-
>  drivers/iommu/io-pgtable-arm-v7s.c      |  57 +++++++++---------
>  drivers/iommu/io-pgtable-arm.c          |  48 ++++++++-------
>  drivers/iommu/iommu.c                   |  24 ++++----
>  drivers/iommu/ipmmu-vmsa.c              |  28 +++++----
>  drivers/iommu/msm_iommu.c               |  42 +++++++++----
>  drivers/iommu/mtk_iommu.c               |  45 +++++++++++---
>  drivers/iommu/mtk_iommu_v1.c            |   3 +-
>  drivers/iommu/omap-iommu.c              |   2 +-
>  drivers/iommu/qcom_iommu.c              |  44 +++++++++++---
>  drivers/iommu/rockchip-iommu.c          |   2 +-
>  drivers/iommu/s390-iommu.c              |   3 +-
>  drivers/iommu/tegra-gart.c              |  12 +++-
>  drivers/iommu/tegra-smmu.c              |   2 +-
>  drivers/iommu/virtio-iommu.c            |   5 +-
>  drivers/vfio/vfio_iommu_type1.c         |  27 +++++----
>  include/linux/io-pgtable.h              |  57 ++++++++++++------
>  include/linux/iommu.h                   |  92 +++++++++++++++++++++-------
>  24 files changed, 483 insertions(+), 215 deletions(-)
>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
