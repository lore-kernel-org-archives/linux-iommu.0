Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF17223ABA9
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764193912; cv=none; b=efLT5S/yCVWctRK3oSJ2FHamcSPlMmnE5BppdADMO9ct/dI/1wtZVXixvnyEUKgDarhl1JxnO4GawHFXXAq1B6yhWmdj7RTuk2bp5ztEty24d/nRzTvG0UzkAUlum9Oi9UEGfRN7pgsd7swDk+aM1G9rxWvAL8NK18yLfR2M+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764193912; c=relaxed/simple;
	bh=v9mX4S68W0DGqBjN9bhFvmhP/kFdSTOe/8p7f2+BNDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=R7/C3FgaTW7ZSdG5onpvwPwOwgBx69G3Fwojt6omEwWK+yuaZ6YIUG0h4MN5GiSlXPQjncy9ojX5p1B8ETXN9MiBcQGubk2vsOpkASPzD8W9H8xxo6y7XOe1GnUn40fL6mWHXsV9vBDmmUEyFjIRBFJ7kIaOR/sdX+jb4mIuLsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ZpEH23w0; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ZpEH23w0"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251126215145euoutp014f3fe266712d98e011a073578f715473~7rQKdrrUG2816128161euoutp01Z
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 21:51:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251126215145euoutp014f3fe266712d98e011a073578f715473~7rQKdrrUG2816128161euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764193905;
	bh=dGFZTsj3Sr+rj0IQoGI2mVWM0k6sHYRGkdhzzWOPnCA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=ZpEH23w0XDgT88QEFe6mJbO7ISBMtElJqNykHPldTlxUvU94A0qDn8gq2KnecvB/o
	 WszHg6iOk1xDpU/DlmcZJ53vV+hlUHUudnufA5bbrG1dYeB2eSxOdHHBD1lWiy9Rip
	 DmLiQ7iVj4xqhbrTps6ORHhaitme+RSPyPH18F4I=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251126215145eucas1p1e201667806fb9f523cf398d1d67d874a~7rQKI3wlW2725827258eucas1p1w;
	Wed, 26 Nov 2025 21:51:45 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251126215144eusmtip28b6d386bba5f47b5cce8ada49f012b0b~7rQJFCD_-1778117781eusmtip2c;
	Wed, 26 Nov 2025 21:51:44 +0000 (GMT)
Message-ID: <56a087c5-e913-4cc5-b986-632b7c5e29dd@samsung.com>
Date: Wed, 26 Nov 2025 22:51:43 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Fix missing sg_dma_len assignment in P2PDMA
 bus mappings
To: Pranjal Shrivastava <praan@google.com>, iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	Leon Romanovsky <leon@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Logan Gunthorpe <logang@deltatee.com>, Will Deacon <will@kernel.org>,
	Shivaji Kant <shivajikant@google.com>, Jacob Moroni <jmoroni@google.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251126114112.3694469-1-praan@google.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251126215145eucas1p1e201667806fb9f523cf398d1d67d874a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251126114122eucas1p19e53eb68f957af3fbc87156f7ad73eff
X-EPHeader: CA
X-CMS-RootMailID: 20251126114122eucas1p19e53eb68f957af3fbc87156f7ad73eff
References: <CGME20251126114122eucas1p19e53eb68f957af3fbc87156f7ad73eff@eucas1p1.samsung.com>
	<20251126114112.3694469-1-praan@google.com>

On 26.11.2025 12:41, Pranjal Shrivastava wrote:
> Prior to commit a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping
> helpers"), P2P segments were mapped using the pci_p2pdma_map_segment()
> helper. This helper was responsible for populating sg->dma_address,
> marking the bus address, and also setting sg_dma_len(sg).
>
> The refactor[1] removed this helper and moved the mapping logic directly
> into the callers. While iommu_dma_map_sg() was correctly updated to set
> the length in the new flow, it was missed in dma_direct_map_sg().
>
> Thus, in dma_direct_map_sg(), the PCI_P2PDMA_MAP_BUS_ADDR case sets the
> dma_address and marks the segment, but immediately executes 'continue',
> which causes the loop to skip the standard assignment logic at the end:
>
>      sg_dma_len(sg) = sg->length;
>
> As a result, when CONFIG_NEED_SG_DMA_LENGTH is enabled, the dma_length
> field remains uninitialized (zero) for P2P bus address mappings. This
> breaks upper-layer drivers (for e.g. RDMA/IB) that rely on sg_dma_len()
> to determine the transfer size.
>
> Fix this by explicitly setting the DMA length in the
> PCI_P2PDMA_MAP_BUS_ADDR case before continuing to the next scatterlist
> entry.
>
> Fixes: a25e7962db0d7 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> Reported-by: Jacob Moroni <jmoroni@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

Applied to dma-mapping-fixes. Thanks!

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

