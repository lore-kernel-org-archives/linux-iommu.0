Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F36D49D5A1
	for <iommu@lists.linux.dev>; Fri, 18 Sep 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742249; cv=none; b=q+msHdcjooTDJwhEj37bdloi/cbv+ndkxNPMu1t5BS7Nw7X1+DOoWnXVrv1YCHV6JtzW6petjeJdRP6Ek4jeq/VpXIEAqbabYs1e40UNFb7wMlpdUA9w6za2NQwXVZMipOKEJZtewRUiIWN8UnJRSmTo7IGHaFm5uqmR/nnjdd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742249; c=relaxed/simple;
	bh=nacEL1uGwpxZuinjCmReWWulVFg0ZqGJwfhAlGL5iaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvSLaVuH8Qpl1dgwwz5BLtz6YqIYUDD6l64n8PWeB78ABoLDzgZKNNul1tA+eDXCfkC0LiZbjsp0wOutfTXTLGEwcvlyATd98OLa36Z8C8b6GzszaSJCCTaKCv8zYGHFPztIajQGwzJppOs8zr1SLDaA3g45ZsxIqNEo1cDr0Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=f7mfK3yi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="f7mfK3yi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8EDD168F;
	Fri, 18 Sep 2026 07:37:22 -0700 (PDT)
Received: from [10.2.212.23] (unknown [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42FB43F86F;
	Fri, 18 Sep 2026 07:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789742246; bh=nacEL1uGwpxZuinjCmReWWulVFg0ZqGJwfhAlGL5iaU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f7mfK3yiL3US/L7PJH89zOj7e+kubNDSs2tsIQLAa2xE7vCLh+ldz0Tj32zdpLX5R
	 VDSZh2KGicd7d87mRx73q1p8yjdDhiucgsDS7dcnP0zm/m9CkVIaySavYbm6KRk+Ri
	 F+IokM6Xu/S09LC+TUlZIN8tQSiZHOI/WtDeaxhc=
Message-ID: <8f449ded-b4ca-401d-9225-6d1f9ac93e08@arm.com>
Date: Fri, 18 Sep 2026 15:37:14 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] iommu/dma: skip swiotlb bounce for DMA_ATTR_MMIO
 in iommu_dma_map_phys
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Peng Fan <peng.fan@nxp.com>
References: <20260916-iommu-dma-fix-v1-0-a59a0c45ec5b@nxp.com>
 <20260916-iommu-dma-fix-v1-1-a59a0c45ec5b@nxp.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260916-iommu-dma-fix-v1-1-a59a0c45ec5b@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/09/2026 4:23 pm, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> MMIO resources mapped via dma_map_resource() carry DMA_ATTR_MMIO. These
> never need swiotlb bounce buffering, but the current code enters the
> swiotlb path when the physical address is not page-aligned, then rejects
> the mapping because MMIO cannot be bounced.
> 
> Move the DMA_ATTR_MMIO check before the swiotlb block so the entire bounce
> path is skipped for MMIO, falling through directly to __iommu_dma_map()
> which creates the IOVA mapping.

Acked-by: Robin Murphy <robin.murphy@arm.comn>

I'd agree that we shouldn't need patch #2 - I don't see any good reason 
to ever try to use dma_iova_link() instead of dma_map_resource() for 
mapping actual device data registers, and for the link API use-cases 
where the "MMIO" is peer device memory and IOMMU isolation is more 
relevant, it seems sensible to keep the alignment constraint unless and 
until there is a definite compelling need to do otherwise.

Thanks,
Robin.

> Fixes: f9374de14c0e8 ("iommu/dma: implement DMA_ATTR_MMIO for iommu_dma_(un)map_phys()")
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/iommu/dma-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 65d692ec7fced..26b9c2d71cd30 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1228,9 +1228,9 @@ dma_addr_t iommu_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
>   	 * If both the physical buffer start address and size are page aligned,
>   	 * we don't need to use a bounce page.
>   	 */
> -	if (dev_use_swiotlb(dev, size, dir) &&
> +	if (!(attrs & DMA_ATTR_MMIO) && dev_use_swiotlb(dev, size, dir) &&
>   	    iova_unaligned(iovad, phys, size)) {
> -		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
> +		if (attrs & DMA_ATTR_REQUIRE_COHERENT)
>   			return DMA_MAPPING_ERROR;
>   
>   		phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
> 

