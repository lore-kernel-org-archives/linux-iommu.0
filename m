Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC3719FA9F
	for <iommu@lists.linux.dev>; Tue, 27 Aug 2024 10:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753495; cv=none; b=OAadMuKBiEN8xFaSXUAPjSTZE/JsYeggLz0OUpiJ0dvIrsIqF+zs7uUtUwPe3Pts2MuImRi7lJ71TA/BObN0mw/8Ha3LWorT1aPba6wDl3Q5/kaUsFftNkbhZffdnPCBBnvxeLg4tg3z52+ATCF1/hWUBHvQ1wanZQ/+9jOsi2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753495; c=relaxed/simple;
	bh=VSFzBJj1bvterE5/fUtnTBQQKzUUXMsyKFyThYrbn3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VT3mwI39GRITK5KDpErifkOQJME/9dHt7PwV2XZAUApIk/QDNKdliHYq849f6Kuf7FCKHNY7ZEtVBhxWIz3XOMRd43zViUEPMQ59S22a6cHgfDnILnp83SKjc+Mn+pO+OuQIek1JdFArLxveoGrz2klCtHuUFNOQ9eNH7SymUro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14034C8B7AA;
	Tue, 27 Aug 2024 10:11:31 +0000 (UTC)
Date: Tue, 27 Aug 2024 13:11:42 +0300
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH] arm64: mm: fix DMA zone when dma-ranges is missing
Message-ID: <Zs2mXlPtTftIqXhm@arm.com>
References: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <731d204f5f556ad61bbaf004b1d984f83c90b4f5.1724748249.git.baruch@tkos.co.il>

On Tue, Aug 27, 2024 at 11:44:09AM +0300, Baruch Siach wrote:
> Some platforms, like Rockchip RK3568 based Odroid M1, do not provide DMA
> limits information in device-tree dma-ranges property. Still some device
> drivers set DMA limit that relies on DMA zone at low 4GB memory area.
> Until commit ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by
> zone_dma_limit"), zone_sizes_init() restricted DMA zone to low 32-bit
> when there is RAM there.
> 
> Restore DMA zone 32-bit limit for platforms that have RAM in this area.
> 
> Fixes: ba0fb44aed47 ("dma-mapping: replace zone_dma_bits by zone_dma_limit")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> This should go via the dma-mapping tree that contains the fixed commit.
> ---
>  arch/arm64/mm/init.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bfb10969cbf0..7fcd0aaa9bb6 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -116,6 +116,9 @@ static void __init arch_reserve_crashkernel(void)
>  
>  static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
>  {
> +	if (memblock_start_of_DRAM() < U32_MAX)
> +		zone_limit = min(zone_limit, U32_MAX);
> +
>  	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
>  }

Thanks both Baruch and Marek for digging into this and finding a
solution.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
