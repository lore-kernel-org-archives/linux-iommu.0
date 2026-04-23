Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFAD1EFF8D
	for <iommu@lists.linux.dev>; Thu, 23 Apr 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776952279; cv=none; b=oPcRl46tF9HNX4IkoV7wo9NLXhfI4C3hLH8xrwnvOUDjav/ETgyYV/tT4sFI5XB3G3+ARBtPavxKy7/Ah2lW8Rn2ltVD4DleEZpvJIRIvxPZQhAguz1BHRprHhbnaC/aodmHyHvayovz8Ee7OIs7xPOstA1sZhdm94Y1XAx3DW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776952279; c=relaxed/simple;
	bh=XfqOATxDwDI8LIBrL7cQRAF2Bu7r8V5j98kapDXzVSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAFOm+R1LN+44AA/x7S+vIJyYKX3YWM9r8ZTM0gwYUVV2eLHPKobkXlVkTsFtx7HzhFAPf3/SAUgFQwu6orffWmr9etcYLlJl97ENb1vU0tijh1s+KWADYOvEXk0nEKyZfWltspDSeF3PI4cd1B+O1z0OcxfdpxntDALg9obqcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tpxdKJvT; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tpxdKJvT"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B2441BF7;
	Thu, 23 Apr 2026 06:51:04 -0700 (PDT)
Received: from [10.1.196.85] (e121345-lin.cambridge.arm.com [10.1.196.85])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8651C3F641;
	Thu, 23 Apr 2026 06:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776952269; bh=XfqOATxDwDI8LIBrL7cQRAF2Bu7r8V5j98kapDXzVSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tpxdKJvTLYCEkqrH+jeteTGk28EVofx3aVEDwMupSduAK6dDkqcgo1RUzR6r4OnEP
	 QvY1tITRTY/DyPjixR80WDusW5lbUOtTrcUzp7JycPt8Cv/BOP+F5hkZq/Z3iQw1yF
	 XOwlPeYF1eGOuvt19EFTumEHNRz709ZKVaH77uTw=
Message-ID: <43c5301c-fe6a-41e4-9482-ccfc7b62f2a7@arm.com>
Date: Thu, 23 Apr 2026 14:51:06 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dma-contiguous: setup default pernuma cma area if not
 configured explicitly
To: Feng Tang <feng.tang@linux.alibaba.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Ying Huang <ying.huang@linux.alibaba.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
References: <20260423095243.14239-1-feng.tang@linux.alibaba.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260423095243.14239-1-feng.tang@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/04/2026 10:52 am, Feng Tang wrote:
> There was a report on a multi-numa-nodes ARM server that when IOMMU is
> disabled, the dma_alloc_coherent() function always returns memory from
> node 0 even for devices attaching to other nodes, while they can get
> local dma memory when IOMMU is on with the same API.
> 
> The reason is, when IOMMU is disabled, the dma_alloc_coherent() will
> go the direct way and call dma_alloc_contiguous(). The system doesn't
> have any explicit cma setting (like per-numa cma), and only has a
> default 64MB cma reserved area (on node 0), where kernel will try
> first to allocate memory from.
> 
> Robin Murphy suggested to setup pernuma cma or disable cma, which did
> solve the issue. While there is still concern that for customers
> which don't have much kernel knowledge, they could still suffer from
> this silently as some architectures enable cma area by default (not
> an issue for X86 though, which set CONFIG_CMA_SIZE_MBYTES to 0 by
> default) for most Linux distributions.
> 
> One thought is to follow the current cma reserving policy for platform
> with 'CONFIG_DMA_NUMA_CMA=y', that if the numa cma is not explicitly
> configured, set it up according to CONFIG_CMA_SIZE_MBYTES (The
> percentage kernel option is not considered yet as the number of NUMA
> nodes could be big).

IIRC, the main reason it's still an opt-in is that it doesn't 
necessarily interact all that well with the default CMA area, and what 
we definitely don't want to do is unexpectedly start allocating 
additional CMA areas on systems which don't need nor want them.

I guess what might be ideal would be to rearrange things such that when 
DMA_NUMA_CMA is enabled, we try to merge the "global" CMA area with a 
per-node area that can satisfy the necessary size, ZONE_DMA32, etc. 
constraints, such that unless explicitly configured otherwise, we don't 
end up making that extra n+1th allocation. Similarly I'm not sure about 
the usefulness of having two separate types of per-node area, especially 
given the apparent intent that users only want one _or_ the other, so 
probably dma_contiguous_numa_area[] should really have just been a 
generalisation of dma_contiguous_pernuma_area[] in the first place...

I can imagine that work being quite involved though, as all the 
interaction between default, command line and devicetree/platform 
controls is sure to be fiddly. As a compromise for now, I think rather 
than trying to imply a default "cma_pernuma" behaviour, it would be 
cleaner to instead imply "numa_cma" to only replicate the default area 
across nodes other than the one which has it already. That then would 
inherently avoid changing anything for single-node systems; otherwise at 
the very least any automatic fiddling with pernuma_size_bytes should 
depend on num_online_nodes() > 1.

Thanks,
Robin.

> 
> Suggested-by: Ying Huang <ying.huang@linux.alibaba.com>
> Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
> ---
> Changelog:
> 
> 	since v1
> 		* don't use the original way of adding alloc_pages_node()
> 		before trying default cma node (Robin Murphy)
> 
>   kernel/dma/contiguous.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index c56004d314dc..b2fd6789db85 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -107,6 +107,7 @@ static struct cma *dma_contiguous_numa_area[MAX_NUMNODES];
>   static phys_addr_t numa_cma_size[MAX_NUMNODES] __initdata;
>   static struct cma *dma_contiguous_pernuma_area[MAX_NUMNODES];
>   static phys_addr_t pernuma_size_bytes __initdata;
> +static bool numa_cma_configured;
>   
>   static int __init early_numa_cma(char *p)
>   {
> @@ -135,6 +136,7 @@ static int __init early_numa_cma(char *p)
>   			break;
>   	}
>   
> +	numa_cma_configured = true;
>   	return 0;
>   }
>   early_param("numa_cma", early_numa_cma);
> @@ -142,6 +144,7 @@ early_param("numa_cma", early_numa_cma);
>   static int __init early_cma_pernuma(char *p)
>   {
>   	pernuma_size_bytes = memparse(p, &p);
> +	numa_cma_configured = true;
>   	return 0;
>   }
>   early_param("cma_pernuma", early_cma_pernuma);
> @@ -181,6 +184,9 @@ static void __init dma_numa_cma_reserve(void)
>   			continue;
>   		}
>   
> +		if (!numa_cma_configured)
> +			pernuma_size_bytes = size_bytes;
> +
>   		if (pernuma_size_bytes) {
>   
>   			cma = &dma_contiguous_pernuma_area[nid];

