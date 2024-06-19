Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC39A80BE5
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718793355; cv=none; b=mvQ2i1rqyxewmNM64ettkriyMfuCuv7yEUU/mweR9Ce0MkUTVGwKpa9SgHa22FiNOjXIDlScvlBY8FNhYhESu/QG4kJ6hbjfI2wpeAKY8fXhpX4jEaG3YWS4ivOvItepQBiNjE44eEHh6oKZJBbqLQi7OK3pZzIX+oUo0U+Fado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718793355; c=relaxed/simple;
	bh=fgyCnP3qXShl7wfpqmt+wRPrDUtyovAtEM7NSslvPQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctOhIx8xXIe09P4UbkZYYtGcTkqirhCKSrr+hHYpy/OCQh+1QCUaIvLpCPydI5IpcH9IJAbwxxRGvTOCnQAOBCMYvHGhVFfYoQ2UO7rLKRdqGjp2nZZJ4gCF2VHWPBIbGL7pX1wQxJv1W1tshKmeS4lbGMWS/go0RjAgnsvd464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7F3FDA7;
	Wed, 19 Jun 2024 03:36:17 -0700 (PDT)
Received: from [10.57.71.86] (unknown [10.57.71.86])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BCDE43F64C;
	Wed, 19 Jun 2024 03:35:51 -0700 (PDT)
Message-ID: <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
Date: Wed, 19 Jun 2024 11:35:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA
 support
To: Alberto Secondi <albertosecondi@gmail.com>, hch@lst.de,
 m.szyprowski@samsung.com
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
References: <20240619091737.669040-1-albertosecondi@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240619091737.669040-1-albertosecondi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-19 10:17 am, Alberto Secondi wrote:
> ------ Tessian Warning ------
> 
> Be careful, the email's sending address "albertosecondi@gmail[.]com" has never been seen on your company's network before today
> 
> This warning message will be removed if you reply to or forward this email to a recipient outside of your organization.
> 
> ---- Tessian Warning End ----
> 
> From: Alberto Secondi <alberto.secondi@abinsula.com>
> 
> The kernel assumes that 64-bit systems have 64-bit DMA support through
> CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, several
> iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit support.
> This results in several drivers requesting DMA_BIT_MASK(64), which causes
> malfunctions, particularly when systems have more than 3GB of DRAM (verified
> with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a new
> config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with 32-bit
> DMA, which adjusts DMA_BIT_MASK(n) accordingly.

No. If a system has devices naturally capable of >32-bit DMA, and memory 
at >32-bit system physical addresses, but only a 32-bit interconnect in 
between, that needs to be described properly in Devicetree/ACPI, not 
hacked around with completely non-portable kernel bodges.

Thanks,
Robin.

> Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> ---
>   include/linux/dma-mapping.h | 4 ++++
>   kernel/dma/Kconfig          | 8 ++++++++
>   2 files changed, 12 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f693aafe221f..629220a777e3 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -74,7 +74,11 @@
>    */
>   #define DMA_MAPPING_ERROR		(~(dma_addr_t)0)
>   
> +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> +#define DMA_BIT_MASK(n)	(((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<(n))-1))
> +#else
>   #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> +#endif
>   
>   #ifdef CONFIG_DMA_API_DEBUG
>   void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c06e56be0ca1..0a27eafed808 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
>   config ARCH_DMA_ADDR_T_64BIT
>   	def_bool 64BIT || PHYS_ADDR_T_64BIT
>   
> +config ARCH_64BIT_HAS_DMA32_ONLY
> +        bool "64bit System has DMA32 only"
> +        depends on ARCH_DMA_ADDR_T_64BIT
> +        default n
> +	help
> +	  This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> +	  64-bit systems that have DMA support limited to 32 bits.
> +
>   config ARCH_HAS_DMA_SET_MASK
>   	bool
>   
