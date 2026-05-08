Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44516374758
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778258965; cv=none; b=ZNGUDWL3NOWUqbbp3uVIgVn5wNinUMvQ7sru4L1R8k5Chu32tMoxJGoU1jrviLYicxPIZIDKLYdilEzvEEuvQLnU2gK/iVAZr34EOpmRA9NF8GETL+d997EH37Kl3P+w0agLwOgWRYFLoS5BPfRNiq1vwj3itlqAxQdCH0ziNIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778258965; c=relaxed/simple;
	bh=aytjUkr0b3VoIYYlZZDpFWHNb6l+2dwbvAYqdAFMKDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPMB9x1b9/UBqykRn1ZXto+yz51ZW7WFzsOp+Kvc/5Ccpt3SNXJCNsDJn1hImtw2vj1AkiSQY13xmLu7EmaTa99cJBd8RiIIuRkzcRYk3MZNxTKtcQP6hT3kQvseMsKqcLJ4UocXbo72vLRwYg2SKVQHD0iQvR/AO54bwGc6ICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=P2QtToNJ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="P2QtToNJ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1153B22D7;
	Fri,  8 May 2026 09:49:16 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019D33FB3E;
	Fri,  8 May 2026 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778258961; bh=aytjUkr0b3VoIYYlZZDpFWHNb6l+2dwbvAYqdAFMKDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P2QtToNJZ6HfpSu0j8L200oY5OAtZT4lreuar+GMoeluGxLj16dxUwF8pil4rbj2Y
	 uR5p9ryrs1Hr8tpG8uixQJpZhRq8qJ7McHL+JpPAcaEY+cDreWkBLc9ZCp18EAp7pb
	 4clsAqJR8k6krSVVvCUxcttPkMPVljif7eX98EzQ=
Date: Fri, 8 May 2026 17:49:16 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 4/9] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <af4UDEp-pbRRJffQ@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <20260427055509.898190-5-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427055509.898190-5-aneesh.kumar@kernel.org>

On Mon, Apr 27, 2026 at 11:25:04AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -1408,6 +1429,17 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>  		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
>  
> +	/*
> +	 * if we are trying to swiotlb map a decrypted paddr or the paddr is encrypted
> +	 * but the device is forcing decryption, use decrypted io_tlb_mem
> +	 */
> +	if ((attrs & DMA_ATTR_CC_SHARED) ||
> +	    (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev)))
> +		require_decrypted = true;

Nit: just this should do:

	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))

> +	if (require_decrypted != mem->decrypted)
> +		return (phys_addr_t)DMA_MAPPING_ERROR;

I wonder whether io_tlb_mem should store the attrs that were used when
created (just DMA_ATTR_CC_SHARED for now) and use that to check here. In
patch 7, this hunk in swiotlb_map() confused me:

	if (dev->dma_io_tlb_mem->decrypted) {
		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
		attrs |= DMA_ATTR_CC_SHARED;
	} else {
		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
	}

as I thought we'd not update the attributes on the streaming API path.
But what you meant here is for dma_capable() to be checked against the
device with the actual io_tlb_mem attributes.

Anyway, the new swiotlb_tbl_map_single() rejects kmalloc-minalign
bouncing if the device is private while the bounce buffer is shared.
Unlikely we'll need such bouncing if the devices are coherent but it's
good as a safety check.

-- 
Catalin
