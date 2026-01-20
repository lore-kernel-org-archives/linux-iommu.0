Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5AB3446B1;
	Tue, 20 Jan 2026 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768903154; cv=none; b=GRza8ndW6QpUaYfCIwXlsf6EqUKK1cYNUGuhZqMtchkKXOVsQt2LBzgG0CLDtZoQKs/J8mrWgqaj3ol9CGbZ1J7k1Wsp1CqgiScdoprRx2mkV5Mxyt8YAbmalmKMyWOKgcra6BkooF/He/MiA5aEgFZaniBX/7IvX4TxWVL2ZH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768903154; c=relaxed/simple;
	bh=ufgaQJhMIjHXfFldXrvOK44Dq9IQ1XCoP3XLOPGTLsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TXbTrq3pr1xQ9OVPs17yDaCWmO0KkO2NWpMdhtD2Us4LtRlVG5WUfrY7U+pPfOd9jNrNnvHU0iGgvMKgBppU34ygWk869b7qk7dJdK1vdvB1ZLGAeqaeBADKqjuhl8al5p67EJCjBcoEELSoPX3OF8rC+Vtqu9vBYXh9BL3rYNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EE67E1476;
	Tue, 20 Jan 2026 01:59:03 -0800 (PST)
Received: from [10.1.31.58] (Suzukis-MBP.cambridge.arm.com [10.1.31.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1FBC83F694;
	Tue, 20 Jan 2026 01:59:08 -0800 (PST)
Message-ID: <2a0b6d1b-875a-4075-8fc9-a8534afc9168@arm.com>
Date: Tue, 20 Jan 2026 09:59:07 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dma-direct: Validate DMA mask against canonical DMA
 addresses
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@ziepe.ca, steven.price@arm.com,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <20260120064255.179425-1-aneesh.kumar@kernel.org>
Content-Language: en-GB
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260120064255.179425-1-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 20/01/2026 06:42, Aneesh Kumar K.V (Arm) wrote:
> On systems that apply an address encryption tag or mask to DMA addresses,
> DMA mask validation must be performed against the canonical DMA address.
> Using a non-canonical (e.g. encrypted or unencrypted) DMA address
> can incorrectly fail capability checks, since architecture-specific
> encryption bits are not part of the device’s actual DMA addressing
> capability. For example, arm64 adds PROT_NS_SHARED to unencrypted DMA
> addresses.
> 
> Fix this by validating device DMA masks against __phys_to_dma(), ensuring
> that the architecture encryption mask does not influence the check.
> 
> Fixes: b66e2ee7b6c8 ("dma: Introduce generic dma_addr_*crypted helpers")


> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   kernel/dma/direct.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 8e04f72baaa3..a5639e9415f5 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -580,12 +580,12 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   
>   	/*
>   	 * This check needs to be against the actual bit mask value, so use
> -	 * phys_to_dma_unencrypted() here so that the SME encryption mask isn't
> +	 * __phys_to_dma() here so that the arch specific encryption mask isn't
>   	 * part of the check.
>   	 */
>   	if (IS_ENABLED(CONFIG_ZONE_DMA))
>   		min_mask = min_t(u64, min_mask, zone_dma_limit);
> -	return mask >= phys_to_dma_unencrypted(dev, min_mask);
> +	return mask >= __phys_to_dma(dev, min_mask);

This is wrong, isn't it ? For e.g., for CCA, even though the "Flag" is
added to the PA, it is really part of the actual "PA" and thus must be
checked against the full PA ?

Suzuki


>   }
>   
>   static const struct bus_dma_region *dma_find_range(struct device *dev,

