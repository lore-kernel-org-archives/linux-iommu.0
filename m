Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845114F7969
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772555625; cv=none; b=kPa+8+h8xo4NnTA4v1UrtCJpE3AjqZGsf/aLoUiSQzNRRflz42KCdavGJs3cU1In+P9sGcyU/nWkdTYjfVIcSaM3wIVsdlGFyEM1mLLvq46e3GNlIIB1FEkAuJQbj4tClEwyM2zeJup6d19hd3e0J1UnqPPtp5toNoyM4UvJfWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772555625; c=relaxed/simple;
	bh=BEvSQ4sJbmadIM7wlvK6w2JxDCh6PTtlZhQBCz94OiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=mnQ+eLh0htWXz7h3gkqh6jAuRjzIMgwcJeCvMtnzJEjT9W1UaUdsmwMw+x4vFuMbg3+d7lSNKuf87ouu3nehtKM9LdELJkME9kAAeymnOZzgBflIuxwNctLxq7w2PuPBVuZggMcmgQLG7uIEhtJg+FCdOBo8r6AbVf6IMB7lAvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YUe+Za49; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YUe+Za49"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260303163340euoutp01d78540033f5cc14bf96bde1117516c80~ZYfIXU_5C1585615856euoutp014
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 16:33:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260303163340euoutp01d78540033f5cc14bf96bde1117516c80~ZYfIXU_5C1585615856euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1772555620;
	bh=JvN6j8wU9zM77atlq+FD8qGOACA5TsD/SoRj5ZTahzg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=YUe+Za49ig+DGc1U0Fb2742N3pNwHgR+kQozsfTPu6ds6K4p4TNzjKQ6thGpoOcZ6
	 Tbqspbs3cmIXNcgU1mZf/q1SjpPj9q35zhS0pzx0QXptI2B5VGk0YX4+e3Nx9pL3Hy
	 mEq6adR56QF2Q2EnQl5fd7H2AYoQHuIs6es6YtpM=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260303163340eucas1p198411742f93caae84e07182e4c58ee55~ZYfH5vbBl1139311393eucas1p1W;
	Tue,  3 Mar 2026 16:33:40 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260303163338eusmtip1e4021c2cdb48747497661a6110830024~ZYfF5s5260803808038eusmtip1R;
	Tue,  3 Mar 2026 16:33:38 +0000 (GMT)
Message-ID: <3ece80c7-697e-4d46-a6f8-49c07b0117a1@samsung.com>
Date: Tue, 3 Mar 2026 17:33:37 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v3 0/5] dma-mapping: arm64: support batched cache sync
To: Barry Song <21cnbao@gmail.com>, catalin.marinas@arm.com,
	robin.murphy@arm.com, will@kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>, Leon
	Romanovsky <leon@kernel.org>, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Anshuman
	Khandual <anshuman.khandual@arm.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>, Joerg Roedel <joro@8bytes.org>,
	Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Tangquan Zheng <zhengtangquan@oppo.com>,
	Huacai Zhou <zhouhuacai@oppo.com>, Xueyuan Chen <xueyuan.chen21@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260228221125.59863-1-21cnbao@gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260303163340eucas1p198411742f93caae84e07182e4c58ee55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5
X-EPHeader: CA
X-CMS-RootMailID: 20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5
References: <CGME20260228221143eucas1p12a276d4216b6ce0f3c374b093f73acd5@eucas1p1.samsung.com>
	<20260228221125.59863-1-21cnbao@gmail.com>

On 28.02.2026 23:11, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
>
> Many embedded ARM64 SoCs still lack hardware cache coherency support, which
> causes DMA mapping operations to appear as hotspots in on-CPU flame graphs.
>
> For an SG list with *nents* entries, the current dma_map/unmap_sg() and DMA
> sync APIs perform cache maintenance one entry at a time. After each entry,
> the implementation synchronously waits for the corresponding region’s
> D-cache operations to complete. On architectures like arm64, efficiency can
> be improved by issuing all entries’ operations first and then performing a
> single batched wait for completion.
>
> Tangquan's results show that batched synchronization can reduce
> dma_map_sg() time by 64.61% and dma_unmap_sg() time by 66.60% on an MTK
> phone platform (MediaTek Dimensity 9500). The tests were performed by
> pinning the task to CPU7 and fixing the CPU frequency at 2.6 GHz,
> running dma_map_sg() and dma_unmap_sg() on 10 MB buffers (10 MB / 4 KB
> sg entries per buffer) for 200 iterations and then averaging the
> results.
>
> Thanks to Xueyuan for volunteering to take on the testing tasks. He
> put significant effort into validating paths such as IOVA link/unlink
> and SWIOTLB on RK3588 boards with NVMe.

Catalin, Will, I would like to merge this to dma-mapping tree, give Your 
ack or comment if You are okay with ARM64 related parts.


> v3:
>   * Fold patches 5/8, 7/8, and 8/8 into patch 4/8 as suggested by Leon,
>     reducing the series from 8 patches to 5;
>   * Fix the SWIOTLB path by ensuring a sync is issued before memcpy;
>   * Add ARCH_HAS_BATCHED_DMA_SYNC Kconfig as suggested by Leon;
>   * Collect Reviewed-by tags from Leon and Juergen. Leon's tag is not
>     added to patch 4 since it has changed significantly since v2 and
>     requires re-review;
>   * Rename some asm macros and functions as suggested by Will;
>   * Add Xueyuan's Tested-by. His help is greatly appreciated!
>   v2 link:
>   https://lore.kernel.org/lkml/20251226225254.46197-1-21cnbao@gmail.com/
>
> v2:
>   * Refine a large amount of arm64 asm code based on feedback from
>     Robin, thanks!
>   * Drop batch_add APIs and always use arch_sync_dma_for_* + flush,
>     even for a single buffer, based on Leon’s suggestion, thanks!
>   * Refine a large amount of code based on feedback from Leon, thanks!
>   * Also add batch support for iommu_dma_sync_sg_for_{cpu,device}
> v1 link:
>   https://lore.kernel.org/lkml/20251219053658.84978-1-21cnbao@gmail.com/
>
> v1, diff with RFC:
>   * Drop a large number of #ifdef/#else/#endif blocks based on feedback
>     from Catalin and Marek, thanks!
>   * Also add batched iova link/unlink support, marked as RFC since I lack
>     the required hardware. This was suggested by Marek, thanks!
> RFC link:
>   https://lore.kernel.org/lkml/20251029023115.22809-1-21cnbao@gmail.com/
>
> Barry Song (5):
>    arm64: Provide dcache_by_myline_op_nosync helper
>    arm64: Provide dcache_clean_poc_nosync helper
>    arm64: Provide dcache_inval_poc_nosync helper
>    dma-mapping: Separate DMA sync issuing and completion waiting
>    dma-mapping: Support batch mode for dma_direct_{map,unmap}_sg
>
>   arch/arm64/Kconfig                  |  1 +
>   arch/arm64/include/asm/assembler.h  | 25 ++++++++++---
>   arch/arm64/include/asm/cache.h      |  5 +++
>   arch/arm64/include/asm/cacheflush.h |  2 +
>   arch/arm64/kernel/relocate_kernel.S |  3 +-
>   arch/arm64/mm/cache.S               | 57 +++++++++++++++++++++++------
>   arch/arm64/mm/dma-mapping.c         |  4 +-
>   drivers/iommu/dma-iommu.c           | 35 ++++++++++++++----
>   drivers/xen/swiotlb-xen.c           | 24 ++++++++----
>   include/linux/dma-map-ops.h         |  6 +++
>   kernel/dma/Kconfig                  |  3 ++
>   kernel/dma/direct.c                 | 23 +++++++++---
>   kernel/dma/direct.h                 | 21 ++++++++---
>   kernel/dma/mapping.c                |  6 +--
>   kernel/dma/swiotlb.c                |  7 +++-
>   15 files changed, 171 insertions(+), 51 deletions(-)
>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Cc: Huacai Zhou <zhouhuacai@oppo.com>
> Cc: Xueyuan Chen <xueyuan.chen21@gmail.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

