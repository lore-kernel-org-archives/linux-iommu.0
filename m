Return-Path: <SRS0=+KdK=3D=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB36C33C9E
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:52 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E402084D
	for <iommu@archiver.kernel.org>; Tue, 14 Jan 2020 18:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E402084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 668F887702;
	Tue, 14 Jan 2020 18:19:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tVHSuS07h4Mw; Tue, 14 Jan 2020 18:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 736AB84845;
	Tue, 14 Jan 2020 18:19:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58E6BC1D83;
	Tue, 14 Jan 2020 18:19:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9AA4C077D
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 18:19:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C56C520006
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 18:19:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k3VDr61SBoF1 for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jan 2020 18:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 8389120000
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jan 2020 18:19:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE0D51396;
 Tue, 14 Jan 2020 10:19:39 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FB073F68E;
 Tue, 14 Jan 2020 10:19:38 -0800 (PST)
Subject: Re: [PoC] arm: dma-mapping: direct: Apply dma_pfn_offset only when it
 is valid
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, hch@lst.de
References: <8eb68140-97b2-62ce-3e06-3761984aa5b1@ti.com>
 <20200114164332.3164-1-peter.ujfalusi@ti.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f8121747-8840-e279-8c7c-75a9d4becce8@arm.com>
Date: Tue, 14 Jan 2020 18:19:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114164332.3164-1-peter.ujfalusi@ti.com>
Content-Language: en-GB
Cc: robh@kernel.org, vigneshr@ti.com, konrad.wilk@oracle.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org,
 rogerq@ti.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 14/01/2020 4:43 pm, Peter Ujfalusi wrote:
> The dma_pfn_offset should only be applied to an address which is within the
> dma-ranges range. Any address outside should have offset as 0.

No, that's wrong. If a non-empty dma-ranges is present, then addresses 
which do not fall within any specified range are invalid altogether.

The current long-term plan is indeed to try to move to some sort of 
internal "DMA range descriptor" in order to properly cope with the kind 
of esoteric integrations which have multiple disjoint windows, 
potentially even with different offsets, but as you point out there are 
still many hurdles between now and that becoming reality. So although 
this patch does represent the "right" thing, it's for entirely the wrong 
reason. AFAICT for your case it basically just works out as a very 
baroque way to hack dma_direct_supported() again - we shouldn't need a 
special case to map a bogus physical address to valid DMA address, we 
should be fixing the source of the bogus PA in the first place.

> This is a proof of concept patch which works on k2g where we have
> dma-ranges = <0x80000000 0x8 0x00000000 0x80000000>;
> for the SoC.

TBH it's probably extra-confusing that you're on Keystone 2, where 
technically this ends up closer-to-OK than most, since IIRC the 0-2GB 
MMIO region is the same on all 3(?) interconnect maps. Thus the 100% 
honest description would really be:

dma-ranges = <0x0 0x0 0x0 0x80000000>,
	     <0x80000000 0x8 0x00000000 0x80000000>;

but yeah, that would just go horribly wrong with Linux today. The 
subtelty that dma_map_resource() ignores the pfn_offset happens to be a 
"feature" in this regard ;)

Robin.

> Without this patch everything which tries to set DMA_BIT_MASK(32) or less
> fails -> DMA and peripherals with built in DMA (SD with ADMA) will not
> probe or fall back to PIO mode.
> 
> With this patch EDMA probes, SD's ADMA is working.
> Audio and dma-test is working just fine with EDMA, mmc accesses with ADMA
> also operational.
> 
> The patch does not tried to address the incomplete handling of dma-ranges
> from DT and it is not fixing/updating arch code or drivers which uses
> dma_pfn_offset.
> Neither provides fallback support for kernel setting only dma_pfn_offset to
> arbitrary number without paddr/dma_addr/size.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
> Hi Christoph, Robin,
> 
> I know it is a bit more complicated, but with this patch k2g is working fine...
> 
> I wanted to test the concept I was describing and a patch speaks better than
> words.
> 
> Kind regards,
> Peter
> 
>   arch/arm/include/asm/dma-mapping.h | 25 ++++++++++++++++++++--
>   drivers/of/device.c                |  7 ++++++-
>   include/linux/device.h             |  8 ++++++++
>   include/linux/dma-direct.h         | 33 ++++++++++++++++++++++++++++--
>   kernel/dma/coherent.c              |  9 +++++---
>   5 files changed, 74 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index bdd80ddbca34..9bff6ad2d8c8 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -33,10 +33,31 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>    * addresses. They must not be used by drivers.
>    */
>   #ifndef __arch_pfn_to_dma
> +
> +static inline unsigned long __phys_to_dma_pfn_offset(struct device *dev,
> +						     phys_addr_t paddr)
> +{
> +	if (paddr >= dev->dma_ranges.paddr &&
> +	    paddr <= (dev->dma_ranges.paddr + dev->dma_ranges.size))
> +		return dev->dma_ranges.pfn_offset;
> +
> +	return 0;
> +}
> +
> +static inline unsigned long __dma_to_phys_pfn_offset(struct device *dev,
> +						     dma_addr_t dma_addr)
> +{
> +	if (dma_addr >= dev->dma_ranges.dma_addr &&
> +	    dma_addr <= (dev->dma_ranges.dma_addr + dev->dma_ranges.size))
> +		return dev->dma_ranges.pfn_offset;
> +
> +	return 0;
> +}
> +
>   static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
>   {
>   	if (dev)
> -		pfn -= dev->dma_pfn_offset;
> +		pfn -= __phys_to_dma_pfn_offset(dev, __pfn_to_phys(pfn));
>   	return (dma_addr_t)__pfn_to_bus(pfn);
>   }
>   
> @@ -45,7 +66,7 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
>   	unsigned long pfn = __bus_to_pfn(addr);
>   
>   	if (dev)
> -		pfn += dev->dma_pfn_offset;
> +		pfn += __dma_to_phys_pfn_offset(dev, addr);
>   
>   	return pfn;
>   }
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 27203bfd0b22..07a8cc1a7d7f 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -105,7 +105,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>   		if (!force_dma)
>   			return ret == -ENODEV ? 0 : ret;
>   
> -		dma_addr = offset = 0;
> +		dma_addr = offset = paddr = 0;
>   	} else {
>   		offset = PFN_DOWN(paddr - dma_addr);
>   
> @@ -144,6 +144,11 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>   
>   	dev->dma_pfn_offset = offset;
>   
> +	dev->dma_ranges.paddr = paddr;
> +	dev->dma_ranges.dma_addr = dma_addr;
> +	dev->dma_ranges.size = size;
> +	dev->dma_ranges.pfn_offset = offset;
> +
>   	/*
>   	 * Limit coherent and dma mask based on size and default mask
>   	 * set by the driver.
> diff --git a/include/linux/device.h b/include/linux/device.h
> index ce6db68c3f29..57006b51a989 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -293,6 +293,13 @@ struct device_dma_parameters {
>   	unsigned long segment_boundary_mask;
>   };
>   
> +struct dma_ranges {
> +	u64 paddr;
> +	u64 dma_addr;
> +	u64 size;
> +	unsigned long pfn_offset;
> +};
> +
>   /**
>    * struct device_connection - Device Connection Descriptor
>    * @fwnode: The device node of the connected device
> @@ -581,6 +588,7 @@ struct device {
>   					     allocations such descriptors. */
>   	u64		bus_dma_limit;	/* upstream dma constraint */
>   	unsigned long	dma_pfn_offset;
> +	struct dma_ranges dma_ranges;
>   
>   	struct device_dma_parameters *dma_parms;
>   
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 24b8684aa21d..4a46a15945ea 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -11,18 +11,47 @@ extern unsigned int zone_dma_bits;
>   #ifdef CONFIG_ARCH_HAS_PHYS_TO_DMA
>   #include <asm/dma-direct.h>
>   #else
> +
> +static inline unsigned long __phys_to_dma_pfn_offset(struct device *dev,
> +						     phys_addr_t paddr)
> +{
> +	if (!dev)
> +		return 0;
> +
> +	if (paddr >= dev->dma_ranges.paddr &&
> +	    paddr <= (dev->dma_ranges.paddr + dev->dma_ranges.size))
> +		return dev->dma_ranges.pfn_offset
> +
> +	return 0;
> +}
> +
> +static inline unsigned long __dma_to_phys_pfn_offset(struct device *dev,
> +						     dma_addr_t dma_addr)
> +{
> +	if (!dev)
> +		return 0;
> +
> +	if (dma_addr >= dev->dma_ranges.dma_addr &&
> +	    dma_addr <= (dev->dma_ranges.dma_addr + dev->dma_ranges.size))
> +		return dev->dma_ranges.pfn_offset
> +
> +	return 0;
> +}
> +
>   static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
>   	dma_addr_t dev_addr = (dma_addr_t)paddr;
> +	unsigned long offset = __phys_to_dma_pfn_offset(dev, paddr);
>   
> -	return dev_addr - ((dma_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
> +	return dev_addr - ((dma_addr_t)offset << PAGE_SHIFT);
>   }
>   
>   static inline phys_addr_t __dma_to_phys(struct device *dev, dma_addr_t dev_addr)
>   {
>   	phys_addr_t paddr = (phys_addr_t)dev_addr;
> +	unsigned long offset = __dma_to_phys_pfn_offset(dev, dev_addr);
>   
> -	return paddr + ((phys_addr_t)dev->dma_pfn_offset << PAGE_SHIFT);
> +	return paddr + ((phys_addr_t)offset << PAGE_SHIFT);
>   }
>   #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
>   
> diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
> index 551b0eb7028a..7a68fd09f5d0 100644
> --- a/kernel/dma/coherent.c
> +++ b/kernel/dma/coherent.c
> @@ -31,10 +31,13 @@ static inline struct dma_coherent_mem *dev_get_coherent_memory(struct device *de
>   static inline dma_addr_t dma_get_device_base(struct device *dev,
>   					     struct dma_coherent_mem * mem)
>   {
> -	if (mem->use_dev_dma_pfn_offset)
> -		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
> -	else
> +	if (mem->use_dev_dma_pfn_offset) {
> +		unsigned long offset = __phys_to_dma_pfn_offset(dev,
> +						__pfn_to_phys(mem->pfn_base));
> +		return (mem->pfn_base - offset) << PAGE_SHIFT;
> +	} else {
>   		return mem->device_base;
> +	}
>   }
>   
>   static int dma_init_coherent_memory(phys_addr_t phys_addr,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
