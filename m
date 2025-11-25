Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C5531B833
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073229; cv=none; b=W1btMEMHQ9BsnKcqr1KiIbJIVXHxPBqUz4VMeq+FWzotbvkjRb5+wNWWOzcVSk1zjq8b7DC9ClL42CladVj1qpPASfk1GaP/R40eAru1OtRs0iafVdUUMrooV4rS8NOaPPsWdQDuA2n8pv/g+PhUYOgtyoilxdLM6MXBfdTfKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073229; c=relaxed/simple;
	bh=GzcVinwaftNxCi4QNi4ACaQRyXgr3LiBA/5QCfyUTeQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=gvZnWhNRikSf8+H9qIUgA3iOE2VtSPIjiMGRVzsP7AvddqaxZkV4WUXdHoJCupGhk1gyNNghmEdbdxCCuZPRl7jM/KlJTsFHdD1t1k4bgVINTdIFaWrUxdBq4aHpN9ZP5NJ79/3HfiKvCNSj4iQZFUGgFZSqArSyl2JTKrz2izc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uT4u6I+G; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="uT4u6I+G"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251125122024euoutp0143184feaaa0eedf57aa0e08ffbd3d1fc~7P0BUP0hQ1963319633euoutp01D
	for <iommu@lists.linux.dev>; Tue, 25 Nov 2025 12:20:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251125122024euoutp0143184feaaa0eedf57aa0e08ffbd3d1fc~7P0BUP0hQ1963319633euoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764073224;
	bh=VGVL6jH+cfsN6E/RG/DNDJl9qK7gyfU7OZ28BKtUTvk=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=uT4u6I+GRTMjyBBF8LI6AwUxfoBf/pJG7qeeLs6SIvIWd+Vh+RP6AzKuOq2VVXNym
	 aArrnUwQXvmR9tPdgjF01oZIxI2X7u3c2Pz8bfvr1VUp3pE5F4W6CIxwPXdE8sCnkt
	 GMbygddg5tu+kM4PicThMt36KEdLdvtrk9Gx33vQ=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251125122024eucas1p1b11fd80c28e1d11ff839db6ea5152778~7P0BKw_7i1843218432eucas1p1X;
	Tue, 25 Nov 2025 12:20:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20251125122024eusmtip181472ea669440d5a2cc7fd86bf693e27~7P0Azf04s1902319023eusmtip1M;
	Tue, 25 Nov 2025 12:20:23 +0000 (GMT)
Message-ID: <0d195d46-c409-484e-a3c8-1dac0ecc376f@samsung.com>
Date: Tue, 25 Nov 2025 13:20:23 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] iommu/dma: add missing support for DMA_ATTR_MMIO for
 dma_iova_unlink()
To: Leon Romanovsky <leon@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Robin Murphy
	<robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
	<will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20251124172627.GE12483@unreal>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251125122024eucas1p1b11fd80c28e1d11ff839db6ea5152778
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
X-EPHeader: CA
X-CMS-RootMailID: 20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951
References: <CGME20251124171014eucas1p21d3a0f2c10b43bfdb7861ee804f09951@eucas1p2.samsung.com>
	<20251124170955.3884351-1-m.szyprowski@samsung.com>
	<20251124172627.GE12483@unreal>

On 24.11.2025 18:26, Leon Romanovsky wrote:
> On Mon, Nov 24, 2025 at 06:09:55PM +0100, Marek Szyprowski wrote:
>> Commit c288d657dd51 added support for DMA_ATTR_MMIO attribute in the
>> dma_iova_link() code path, but missed that the CPU cache is being also
>> touched in the dma_iova_unlink() path. Fix this.
>>
>> Fixes: c288d657dd51 ("iommu/dma: implement DMA_ATTR_MMIO for dma_iova_link().")
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   drivers/iommu/dma-iommu.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
> Reviewed-by: Leon Romanovsky <leon@kernel.org>

Applied to dma-mapping-fixes.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

