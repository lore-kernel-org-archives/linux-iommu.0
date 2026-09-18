Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C44F96A2
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746235; cv=none; b=Ydz1QU+UAs1utPGrw4bNK6ej1cKkXAmYtvTSrAgfFly39HGDbWKGqDZMvaauklwRTVhaPtpjvoZnPUsP74F3wMZG2+H6bO71KzF34n5Srux5jxfANmAUFawdJiHLmequORnpkfHB+RujlIN4xyVOBMXwz5gGIWCrB0o/AV2NBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746235; c=relaxed/simple;
	bh=7Dh9Y0nv+LiYZ8pue7OgfGIuG+rnljMeagzvREQ6whc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=RTC61L6qacDEKtq0tdMSWOEEsUg+4FIzC0OM+movsrtWV9FryamwPbVGjUbg91V6Ys9ynASo6y9Wbum3CUUKFkKC0nQrtuigS8BQk4Zjtth+yPZpDfvjfSdfcevT+cPHqusgsXFofCsXtwpCaDYr/tD88gbwaLV9zr0WA/VpxNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IUL7CjHj; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IUL7CjHj"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260918154350euoutp01e05502958b8bfc369bd675f1c4cbaf33~WdLa6BxDv3026430264euoutp01E
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 15:43:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260918154350euoutp01e05502958b8bfc369bd675f1c4cbaf33~WdLa6BxDv3026430264euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1789746230;
	bh=FkgqxxyQJ4n9EEccZ2uoqpxYUHuS8uCVszSzBVFosd8=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=IUL7CjHjdrdsj507LyPW5toMb5iHVqF3/uGWZ6Q4TvNxJ90IJSGVDpGiDcRw6ZRYr
	 4dWSgBvqVQ4JFXyfCd9gE2rwuKkgTE4lB4FXsUhxz/hRl04rBWK5/AQ5XZx6EBgNqW
	 NCAcJv7USNDhAuExpXVdgrkGCVwv1uAwHWrzX+Ew=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260918154349eucas1p22281b383a4c3795b2b60b86e4a87a56d~WdLavyB5t2573425734eucas1p2u;
	Fri, 18 Sep 2026 15:43:49 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260918154348eusmtip140f57867049c46dc8361bccc3ceb9083~WdLZ5luZr1768717687eusmtip1F;
	Fri, 18 Sep 2026 15:43:48 +0000 (GMT)
Message-ID: <e66fc610-c174-4295-b15d-d82589a646d4@samsung.com>
Date: Fri, 18 Sep 2026 17:43:48 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH RFC 0/2] iommu/dma: Fix DMA_ATTR_MMIO swiotlb rejection
To: Peng Fan <peng.fan@oss.nxp.com>, Leon Romanovsky <leon@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Jason Gunthorpe
	<jgg@ziepe.ca>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Peng
	Fan <peng.fan@nxp.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aq1GyO3vv8W6Adlr@shlinux89>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260918154349eucas1p22281b383a4c3795b2b60b86e4a87a56d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260918140812eucas1p28a4d680f405cc3a8e1a4f1a8d1bcfb70
X-EPHeader: CA
X-CMS-RootMailID: 20260918140812eucas1p28a4d680f405cc3a8e1a4f1a8d1bcfb70
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
	<20260918123736.GW13683@unreal>
	<CGME20260918140812eucas1p28a4d680f405cc3a8e1a4f1a8d1bcfb70@eucas1p2.samsung.com>
	<aq1GyO3vv8W6Adlr@shlinux89>

On 18.09.2026 16:12, Peng Fan wrote:
> On Fri, Sep 18, 2026 at 03:37:36PM +0300, Leon Romanovsky wrote:
>> On Wed, Sep 16, 2026 at 11:23:32PM +0800, Peng Fan (OSS) wrote:
>>> Commit f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for
>>> iommu_dma_(un)map_phys()") and commit c288d657dd515 ("iommu/dma: implement
>>> DMA_ATTR_MMIO for dma_iova_link().") added DMA_ATTR_MMIO support to skip
>>> swiotlb bouncing and cache flushing for MMIO resources. However, both
>>> implementations placed the DMA_ATTR_MMIO check inside the swiotlb bounce block,
>>> causing non-page-aligned MMIO mappings to be rejected outright instead of
>>> skipping the bounce and proceeding to create the IOVA mapping.
>>>
>>> This breaks dma_map_resource() for any non-page-aligned device register when
>>> behind an IOMMU: DMA controllers that map peripheral FIFO addresses
>>> (e.g. SPI controller TX/RX data registers) through an IOMMU for per-channel
>>> isolation.
>>>
>>> Both patches move the DMA_ATTR_MMIO check before the swiotlb block so MMIO,
>>> resources skip the entire bounce path and fall through directly to the IOMMU
>>> mapping function.
>> While I understand the rationale behind the first patch, why do we need the
>> second one? Do we want to allow unaligned addresses for the _link_ as well?
>> Current users don't need it.
> My intention with the second patch was to make the DMA_ATTR_MMIO handling
> consistent with iommu_dma_map_phys(), since MMIO cannot be bounced by
> SWIOTLB in either case.
>
> However, I don't have a dma_iova_link() user that requires an
> unaligned MMIO address, so no need to relax the existing restriction there.
>  
> I'll drop the second patch and keep this fix scoped to iommu_dma_map_phys()
> in v2. Does that sounds good to you?
>
> BTW, does patch 1 look good to you?


The first patch looks good, I will apply it as is. For the link case I think that
it needs to be properly documented that non-aligned mapping is not supported.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

