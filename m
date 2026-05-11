Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72342D877B;
	Mon, 11 May 2026 05:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476500; cv=none; b=sW9UvkLvvtY35W14j9YRZe6lfwqwEjMtusB66YmkTnE40aUXo69wAWxPeV6JGklTnQmtkBAg0wkOGhv4Epn3E7HInjkgVUSmpYVT88HZPoSjbwDrnpCfGrACh0+LUJHurhkQzkOH09LIlHvAzmokkyBYB4em7hYDB6lFcDklxe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476500; c=relaxed/simple;
	bh=Lx1L1XiYiatj00PhfBXvbbTj3N61IeIgBX0Si438Um8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B/CFItK8BFRdMKJbgBUcHP1iRzABGOCQAYWJvnnLW6uxGyHBEWErZpWpPmzH2Bm5aR5zOyQwiTkeHwmIOQ0IDT3a0a/oiiTRosDiqDDJGl8BWB5MUe8N0w2MdjltxYVu00n4p0L6xJGYjV7TE/ycmY2IKmsLLtUbh69cdYrXm5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glwx+r4p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glwx+r4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08081C2BCB0;
	Mon, 11 May 2026 05:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476500;
	bh=Lx1L1XiYiatj00PhfBXvbbTj3N61IeIgBX0Si438Um8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Glwx+r4p8ucSQ8/tXhDs+BvNoUq48cjxoWRJN0x6ikrnVhHRYiB0bWvYq0YdHU6Po
	 SeHM7h0w7ZDIAGyyxpfrup/ZP6RxeE88nO0KzfN8INEnrqM+NYAEnMc4sduDjG4jV6
	 JrGCauOT3l/7OPo3L8As466MFkvab9U/bswQvl/EQMdrlPoqov2rSDPGqXfk5S1xRv
	 OaCJeyj/oB3ydNIBUpYeX8Iz192m5/IcceFR9yR33ZOWhvcInrNU0Uwzu0lDjwyKTX
	 60X7btH6W8NtMF8+ybcUQBINFHYQFn+5+Dpg8O5eR7b7BVy4UxBW55x76vfn2w6C90
	 703O/dvcxnOmg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 4/9] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
In-Reply-To: <af4UDEp-pbRRJffQ@arm.com>
References: <20260427055509.898190-1-aneesh.kumar@kernel.org>
 <20260427055509.898190-5-aneesh.kumar@kernel.org>
 <af4UDEp-pbRRJffQ@arm.com>
Date: Mon, 11 May 2026 10:44:52 +0530
Message-ID: <yq5aik8uttmb.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Apr 27, 2026 at 11:25:04AM +0530, Aneesh Kumar K.V (Arm) wrote:
>> @@ -1408,6 +1429,17 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
>>  	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
>>  		pr_warn_once("Memory encryption is active and system is using DMA bounce buffers\n");
>>  
>> +	/*
>> +	 * if we are trying to swiotlb map a decrypted paddr or the paddr is encrypted
>> +	 * but the device is forcing decryption, use decrypted io_tlb_mem
>> +	 */
>> +	if ((attrs & DMA_ATTR_CC_SHARED) ||
>> +	    (!(attrs & DMA_ATTR_CC_SHARED) && force_dma_unencrypted(dev)))
>> +		require_decrypted = true;
>
> Nit: just this should do:
>
> 	if ((attrs & DMA_ATTR_CC_SHARED) || force_dma_unencrypted(dev))
>

I will update this in the next version.

>> +	if (require_decrypted != mem->decrypted)
>> +		return (phys_addr_t)DMA_MAPPING_ERROR;
>
> I wonder whether io_tlb_mem should store the attrs that were used when
> created (just DMA_ATTR_CC_SHARED for now) and use that to check here. In
> patch 7, this hunk in swiotlb_map() confused me:
>

We already added io_tlb_mem->decrypted. Are you suggesting that this
should instead be io_tlb_mem->attrs and use DMA_ATTR_CC_SHARED? Do we
foresee the need to use any other attributes (other than shared) with
respect to io_tlb_mem?

>
> 	if (dev->dma_io_tlb_mem->decrypted) {
> 		dma_addr = phys_to_dma_unencrypted(dev, swiotlb_addr);
> 		attrs |= DMA_ATTR_CC_SHARED;
> 	} else {
> 		dma_addr = phys_to_dma_encrypted(dev, swiotlb_addr);
> 	}
>
> as I thought we'd not update the attributes on the streaming API path.
> But what you meant here is for dma_capable() to be checked against the
> device with the actual io_tlb_mem attributes.
>

if we allocated/mapped from a decrypted iot_tlb_mem, we should return an
unencrypted dma_addr_t. 

> Anyway, the new swiotlb_tbl_map_single() rejects kmalloc-minalign
> bouncing if the device is private while the bounce buffer is shared.
> Unlikely we'll need such bouncing if the devices are coherent but it's
> good as a safety check.
>

-aneesh
