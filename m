Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E605D26F
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 05:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="SuUObiBl"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 149FF1853C7;
	Thu,  9 Nov 2023 06:57:57 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1699509477; bh=MqstqUFo3qRv+8y+mXLmx8o+smjOl1Gu/3uTh1tvguk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuUObiBlSA+XEm5UZOimSToNBpZfq9DztUUstHKz+4/E2RThJkDBa2wJufa9yW/HU
	 IRzuGND92QCaB3roo+xW9l59udkTQ+vMAdqp1NMWmB41bypMbv5gTpZ8bmyXJ/ouQv
	 NIDg5Jh8vp1wc5dzJdOQjKptEmd7hX5NtS6uvsE9Ae4voxU89AZyj1hUR6/ICJ7NDv
	 wlWAEJ3928JqvdcpAkW0kUgixAApSBDpgwqwwXLvOI0xZT4rsjO6ruwAC/tW3yGekW
	 bDIjGR/pk7hxzcRT5xTpSPA1oZdfSDVKbzYHAIS5GGz+Z/CwAB/XbCjMOlHVdOr9hq
	 iYkfvEQokAKew==
Date: Thu, 9 Nov 2023 06:57:56 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Ramon
 Fried <ramon@neureality.ai>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] arm64: DMA zone above 4GB
Message-ID: <20231109065756.01e7272a@meshulam.tesarici.cz>
In-Reply-To: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
References: <9af8a19c3398e7dc09cfc1fbafed98d795d9f83e.1699464622.git.baruch@tkos.co.il>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Baruch,

On Wed,  8 Nov 2023 19:30:22 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> My platform RAM starts at 32GB. It has no RAM under 4GB. zone_sizes_init()
> puts the entire RAM in the DMA zone as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x00000008bfffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   empty
> 
> Consider a bus with this 'dma-ranges' property:
> 
>   #address-cells = <2>;
>   #size-cells = <2>;
>   dma-ranges = <0x00000000 0xc0000000 0x00000008 0x00000000 0x0 0x40000000>;
> 
> Devices under this bus can see 1GB of DMA range between 3GB-4GB. This
> range is mapped to CPU memory at 32GB-33GB.

Thank you for this email. I have recently expressed my concerns about
the possibility of such setups in theory (physical addresses v. DMA
addresses). Now it seems we have a real-world example where this is
actually happening.

> Current zone_sizes_init() code considers 'dma-ranges' only when it maps
> to RAM under 4GB, because zone_dma_bits is limited to 32. In this case
> 'dma-ranges' is ignored in practice, since DMA/DMA32 zones are both
> assumed to be located under 4GB. The result is that the stmmac driver
> DMA buffers allocation GFP_DMA32 flag has no effect. As a result DMA
> buffer allocations fail.
> 
> The patch below is a crude workaround hack. It makes the  DMA zone
> cover the 1GB memory area that is visible to stmmac DMA as follows:
> 
> [    0.000000] Zone ranges:
> [    0.000000]   DMA      [mem 0x0000000800000000-0x000000083fffffff]
> [    0.000000]   DMA32    empty
> [    0.000000]   Normal   [mem 0x0000000840000000-0x0000000bffffffff]
> ...
> [    0.000000] software IO TLB: mapped [mem 0x000000083bfff000-0x000000083ffff000] (64MB)
> 
> With this hack the stmmac driver works on my platform with no
> modification.
> 
> Clearly this can't be the right solutions. zone_dma_bits is now wrong for
> one. It probably breaks other code as well.
> 
> Is there any better suggestion to make DMA buffer allocations work on
> this hardware?

Yes, but not any time soon. My idea was to abandon the various DMA
zones in the MM subsystem and replace them with a more flexible system
based on "allocation constraints".

I'm afraid there's not much the current Linux kernel can do for you.

Petr T

> Thanks
> ---
>  arch/arm64/mm/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 74c1db8ce271..5fe826ac3a5f 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -136,13 +136,13 @@ static void __init zone_sizes_init(void)
>  	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
>  	unsigned int __maybe_unused acpi_zone_dma_bits;
>  	unsigned int __maybe_unused dt_zone_dma_bits;
> -	phys_addr_t __maybe_unused dma32_phys_limit = max_zone_phys(32);
> +	phys_addr_t __maybe_unused dma32_phys_limit = DMA_BIT_MASK(32) + 1;
>  
>  #ifdef CONFIG_ZONE_DMA
>  	acpi_zone_dma_bits = fls64(acpi_iort_dma_get_max_cpu_address());
>  	dt_zone_dma_bits = fls64(of_dma_get_max_cpu_address(NULL));
>  	zone_dma_bits = min3(32U, dt_zone_dma_bits, acpi_zone_dma_bits);
> -	arm64_dma_phys_limit = max_zone_phys(zone_dma_bits);
> +	arm64_dma_phys_limit = of_dma_get_max_cpu_address(NULL) + 1;
>  	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
>  #endif
>  #ifdef CONFIG_ZONE_DMA32

