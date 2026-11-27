Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781144;
	b=WoxjcG8eFTm/cpjmYiBCXY5RrMXilJ5tbvFs2LjD+SM0BTCeLaYKYZHJY6BMaSERrJrI
	 NldtleRxaHOViEpShIhcCzUskTpKSJC5d+yQzlTsXS5ECduSTZ7nUwir6k9Z/QGRkk5yW
	 mnX4j6gAf63cGOUIJWyZ/l1fufJlUzmtr+mmrVloFwDpwNsRxKOm+3OPc0ACiQNgOg/EF
	 JTGHYdKxyIhTeqRYHKpUbQbljqQgSpaJ/rymPTYPEU28TmeIbmmRHwnK1OfAVJSWp/py0
	 sqctzYcPV3tIcPFlyTgrtUKjqG4ZcsOfKXeWyBVMvu4etUL4Neg/GNtaqDXA0ul/FcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781144;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:
	 Content-Language:In-Reply-To:Content-Transfer-Encoding:X-CMS-MailID:
	 X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:X-CMS-RootMailID:
	 References;
	bh=a9fm/uk5JQ3HNfgBODpdCWOALyft9Wz+Y8nV7YiTAZ4=;
	b=Avd9Xp4RIuzeZrRG6fH1Us9QhvoTAWsBjwpL4j5i9RfiP0VxQ2/n3jivzRe3r7R7B115
	 pWzF/mMOuQA3GqfvYsElgVY+v6OprUzRbhZ4EnBGYq6x+LegeNxJTFzsLd6RDtFjaETXu
	 VH+icijSO1p3yS2QlDIxS/0DZKitd/Z+NuiIdm3bbYzipXR5hvngFCPtMT0gF7rWrTp3s
	 lD+3Ti9tb1F8wlv8PTE4qGLcbMTf0c6Dq6sVcEhR+gvAkVe1DqmGs1NzW0drJ8WxzWBiz
	 SihjaYRa5So7wKvCkmSMM4KS/QNFj2AduTeiD7y9oUYXLwDsfzylTOwRPcq3ToxV+Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b="KNGq0ZK/";
	arc=none smtp.remote-ip=210.118.77.11
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46404606A332
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:05:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46404606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=KNGq0ZK/
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20261127120540euoutp01e06b8907cfee57c6213fa23027610e41~r5W65sRae0459004590euoutp01e
	for <iommu@lists.linux.dev>; Fri, 27 Nov 2026 12:05:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20261127120540euoutp01e06b8907cfee57c6213fa23027610e41~r5W65sRae0459004590euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1795781140;
	bh=a9fm/uk5JQ3HNfgBODpdCWOALyft9Wz+Y8nV7YiTAZ4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=KNGq0ZK/A1D5c2Ml3AhUtZiXqmbgvORs6wpuuj660jbSCbmTazbj4gDyBZi+xLwiI
	 jtaDAZpE0HohUhdFj0gD50kJaET1JfCEre56TVD/k5h5NcXWHcg/VQdC+xwKgQDRQI
	 TeRudICmUo1K+W5W9nkh2uKF3tVqVniMXYWMtP4M=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261127120539eucas1p10b2e005bf38fd3ff3ca53b48bf531777~r5W6fzJTf0959809598eucas1p11;
	Fri, 27 Nov 2026 12:05:39 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261127120538eusmtip27bba0cf597c14302cb8417c82729e000~r5W5u8fKU2205822058eusmtip2X;
	Fri, 27 Nov 2026 12:05:38 +0000 (GMT)
Message-ID: <d1660922-e3a1-4d13-8824-f0525f88f723@samsung.com>
Date: Fri, 27 Nov 2026 13:05:38 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] Revert
 "iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper"
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sibi Sankar <sibi.sankar@oss.qualcomm.com>, will@kernel.org,
	robin.murphy@arm.com, honghuan@amd.com, Jason Gunthorpe <jgg@ziepe.ca>,
	joro@8bytes.org, prakash.gupta@oss.qualcomm.com, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
Content-Language: en-US
In-Reply-To: <c5e4fc4e-0e63-47cf-8b88-93ecfb3646de@samsung.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261127120539eucas1p10b2e005bf38fd3ff3ca53b48bf531777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261125135138eucas1p141ba6b5e09623562e2033e290fba811c
X-EPHeader: CA
X-CMS-RootMailID: 20261125135138eucas1p141ba6b5e09623562e2033e290fba811c
References: <CGME20261125135138eucas1p141ba6b5e09623562e2033e290fba811c@eucas1p1.samsung.com>
	<20261125135120.1126571-1-sibi.sankar@oss.qualcomm.com>
	<a3722347-4b88-41ad-926b-455530020c6b@samsung.com>
	<20261125183419.GB774860@unreal>
	<c5e4fc4e-0e63-47cf-8b88-93ecfb3646de@samsung.com>

On 27.11.2026 12:28, Marek Szyprowski wrote:
> On 25.11.2026 19:34, Leon Romanovsky wrote:
>> On Wed, Nov 25, 2026 at 06:21:06PM +0100, Marek Szyprowski wrote:
>>> On 25.11.2026 14:51, Sibi Sankar wrote:
>>>> This reverts commit 1acce29926d93f3eba427696fe3da6451504dae2.
>>>>
>>>> Before this commit, dma_iova_destroy() unmapped through
>>>> __iommu_dma_iova_unlink(..., free_iova=true), which set
>>>> iotlb_gather.queued from cookie->fq_domain, skipped iommu_iotlb_sync()
>>>> and freed the IOVA with the queued gather, exactly like
>>>> __iommu_dma_unmap(). After it, dma_iova_destroy() calls
>>>> dma_iova_unlink() and then dma_iova_free():
>>>>
>>>>   - dma_iova_unlink() never marks its gather as queued and always calls
>>>>     iommu_iotlb_sync() after iommu_unmap_fast().
>>>>   - dma_iova_free() passes a NULL gather to iommu_dma_free_iova(), so
>>>>     the IOVA goes straight back to the allocator through
>>>>     free_iova_fast() and never through queue_iova().
>>>>
>>>> DMA-FQ domains therefore get strict invalidation on this path. That
>>>> includes the block layer's blk_rq_dma_map() path, which NVMe uses for
>>>> all data transfers, so iommu.strict=0 has no effect on NVMe I/O.
>>>>
>>>> hw/sw details: Qualcomm Glymur CRD: SMMUv3 with no RANGE_INV,
>>>> 	       4K pages; NVMe SSD on PCIe Gen5 x4
>>>>
>>>> Fio sequential read/write numbers:
>>>>   Domain                          seq write    seq read
>>>>   DMA (strict)                    2694 MiB/s   2693 MiB/s
>>>>   DMA-FQ (lazy), flush queue      2707 MiB/s   2803 MiB/s
>>>>     bypassed (this regression)
>>>>   DMA-FQ (lazy), flush queue      10.6 GiB/s   11.9 GiB/s
>>>>     used by dma_iova_destroy()
>>>>
>>>> Fixes: 1acce29926d9 ("iommu/dma: simplify dma_iova_destroy() and drop the free_iova helper")
>>>> Cc: stable@vger.kernel.org # v7.3+
>>>> Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
>>> The performance data clearly shows that the flush queue was there for
>>> the reason. Together with this revert it would probably make sense to
>>> apply the v1 of the reverted patch:
>>>
>>> https://lore.kernel.org/all/20260701092033.422867-1-honghuan@amd.com/
>>>
>>> Leon, do You see any other option?
>> These numbers shows clearly that we had iotlb_gather.queued != 0
>> and never performed iommu_iotlb_sync(domain, &iotlb_gather); while
>> destroying mapped IOVA.
>>
>> I agree with you, v1 is the easiest solution, however my preferred one
>> is to cache gather when it is created and keep it in dma_iova_state 
>> structure for whole life cycle of that struct.
> I've played with the code (using LLM ;) and there are some issues with this
> approach:
>
> 1. tso_dma_map_completion_save() copies the struct dma_iova_state by value,
> what breaks internals of the struct iommu_iotlb_gather.
> 2. adding iommu_iotlb_gather to dma_iova_state increase the struct size
> from 16 to 64 bytes, what lands in every NVMe request, RDMA rw contexts,
> TSO maps and HMM.
>
> I've decided to put only the 'use_fq' bit in the __size entry and baked the
> fix. It looks quite nice. This approach solves both above issues, although
> it requires to also fix some drivers which already pokes __size directly
> instead of calling dma_iova_size().
>
> I will post this in a few minutes.

For the reference:

https://lore.kernel.org/all/20261127115849.2780625-1-m.szyprowski@samsung.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

