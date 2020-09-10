Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7626FC07548
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 18:02:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9B0C21D79
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 18:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B0C21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1BC432E1C4;
	Thu, 10 Sep 2020 18:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9FKX02iqjtSI; Thu, 10 Sep 2020 18:02:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2861D2000D;
	Thu, 10 Sep 2020 18:02:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C1B8C0052;
	Thu, 10 Sep 2020 18:02:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65AB7C0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 18:02:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 4D9CC87680
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 18:02:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LZkSN-CBACcC for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 18:02:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id DED0887667
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 18:02:31 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A17106F;
 Thu, 10 Sep 2020 11:02:31 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6FEF3F66E;
 Thu, 10 Sep 2020 11:02:27 -0700 (PDT)
Subject: Re: [PATCH 1/3] ARM/dma-mapping: move various helpers from
 dma-mapping.h to dma-direct.h
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
 Russell King <linux@armlinux.org.uk>, Santosh Shilimkar <ssantosh@kernel.org>
References: <20200910054038.324517-1-hch@lst.de>
 <20200910054038.324517-2-hch@lst.de>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <42497691-ec93-1e93-d3e5-e841eaf8247a@arm.com>
Date: Thu, 10 Sep 2020 19:02:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200910054038.324517-2-hch@lst.de>
Content-Language: en-GB
Cc: devicetree@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linux-sh@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Jim Quinlan <james.quinlan@broadcom.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Frank Rowand <frowand.list@gmail.com>, linux-arm-kernel@lists.infradead.org
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

On 2020-09-10 06:40, Christoph Hellwig wrote:
> Move the helpers to translate to and from direct mapping DMA addresses
> to dma-direct.h.  This not only is the most logical place, but the new
> placement also avoids dependency loops with pending commits.

For the straightforward move as it should be,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

However I do wonder how much of this could be cleaned up further...

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   arch/arm/common/dmabounce.c        |  2 +-
>   arch/arm/include/asm/dma-direct.h  | 70 ++++++++++++++++++++++++++++++
>   arch/arm/include/asm/dma-mapping.h | 70 ------------------------------
>   3 files changed, 71 insertions(+), 71 deletions(-)
> 
> diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
> index f4b719bde76367..d3e00ea9208834 100644
> --- a/arch/arm/common/dmabounce.c
> +++ b/arch/arm/common/dmabounce.c
> @@ -24,7 +24,7 @@
>   #include <linux/slab.h>
>   #include <linux/page-flags.h>
>   #include <linux/device.h>
> -#include <linux/dma-mapping.h>
> +#include <linux/dma-direct.h>
>   #include <linux/dmapool.h>
>   #include <linux/list.h>
>   #include <linux/scatterlist.h>
> diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
> index 7c3001a6a775bf..de0f4ff9279615 100644
> --- a/arch/arm/include/asm/dma-direct.h
> +++ b/arch/arm/include/asm/dma-direct.h
> @@ -2,6 +2,76 @@
>   #ifndef ASM_ARM_DMA_DIRECT_H
>   #define ASM_ARM_DMA_DIRECT_H 1
>   
> +#include <asm/memory.h>
> +
> +#ifdef __arch_page_to_dma
> +#error Please update to __arch_pfn_to_dma
> +#endif

This must be long, long dead by now.

> +
> +/*
> + * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
> + * functions used internally by the DMA-mapping API to provide DMA
> + * addresses. They must not be used by drivers.
> + */
> +#ifndef __arch_pfn_to_dma
> +static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> +{
> +	if (dev)
> +		pfn -= dev->dma_pfn_offset;
> +	return (dma_addr_t)__pfn_to_bus(pfn);
> +}
> +
> +static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
> +{
> +	unsigned long pfn = __bus_to_pfn(addr);
> +
> +	if (dev)
> +		pfn += dev->dma_pfn_offset;
> +
> +	return pfn;
> +}

These are only overridden for OMAP1510, and it looks like it wouldn't 
take much for the platform code or ohci-omap driver to set up a generic 
DMA offset for the relevant device.

> +
> +static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
> +{
> +	if (dev) {
> +		unsigned long pfn = dma_to_pfn(dev, addr);
> +
> +		return phys_to_virt(__pfn_to_phys(pfn));
> +	}
> +
> +	return (void *)__bus_to_virt((unsigned long)addr);
> +}

This appears entirely unused.

> +
> +static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> +{
> +	if (dev)
> +		return pfn_to_dma(dev, virt_to_pfn(addr));
> +
> +	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
> +}

And this is only used for some debug prints in dmabounce.

Similarly the __bus_to_*()/__*_to_bus() calls themselves only appear 
significant to mach-footbridge any more, and could probably also be 
evolved into regular DMA offsets now that all API calls must have a 
non-NULL device. I think I might come back and take a closer look at all 
this at some point in future... :)

Robin.

> +
> +#else
> +static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> +{
> +	return __arch_pfn_to_dma(dev, pfn);
> +}
> +
> +static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
> +{
> +	return __arch_dma_to_pfn(dev, addr);
> +}
> +
> +static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
> +{
> +	return __arch_dma_to_virt(dev, addr);
> +}
> +
> +static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> +{
> +	return __arch_virt_to_dma(dev, addr);
> +}
> +#endif
> +
>   static inline dma_addr_t __phys_to_dma(struct device *dev, phys_addr_t paddr)
>   {
>   	unsigned int offset = paddr & ~PAGE_MASK;
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index bdd80ddbca3451..0a1a536368c3a4 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -8,8 +8,6 @@
>   #include <linux/scatterlist.h>
>   #include <linux/dma-debug.h>
>   
> -#include <asm/memory.h>
> -
>   #include <xen/xen.h>
>   #include <asm/xen/hypervisor.h>
>   
> @@ -23,74 +21,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
>   	return NULL;
>   }
>   
> -#ifdef __arch_page_to_dma
> -#error Please update to __arch_pfn_to_dma
> -#endif
> -
> -/*
> - * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
> - * functions used internally by the DMA-mapping API to provide DMA
> - * addresses. They must not be used by drivers.
> - */
> -#ifndef __arch_pfn_to_dma
> -static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	if (dev)
> -		pfn -= dev->dma_pfn_offset;
> -	return (dma_addr_t)__pfn_to_bus(pfn);
> -}
> -
> -static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
> -{
> -	unsigned long pfn = __bus_to_pfn(addr);
> -
> -	if (dev)
> -		pfn += dev->dma_pfn_offset;
> -
> -	return pfn;
> -}
> -
> -static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
> -{
> -	if (dev) {
> -		unsigned long pfn = dma_to_pfn(dev, addr);
> -
> -		return phys_to_virt(__pfn_to_phys(pfn));
> -	}
> -
> -	return (void *)__bus_to_virt((unsigned long)addr);
> -}
> -
> -static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> -{
> -	if (dev)
> -		return pfn_to_dma(dev, virt_to_pfn(addr));
> -
> -	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
> -}
> -
> -#else
> -static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
> -{
> -	return __arch_pfn_to_dma(dev, pfn);
> -}
> -
> -static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
> -{
> -	return __arch_dma_to_pfn(dev, addr);
> -}
> -
> -static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
> -{
> -	return __arch_dma_to_virt(dev, addr);
> -}
> -
> -static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
> -{
> -	return __arch_virt_to_dma(dev, addr);
> -}
> -#endif
> -
>   /**
>    * arm_dma_alloc - allocate consistent memory for DMA
>    * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
