Return-Path: <SRS0=3ib5=D2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68ECC433E7
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 02:33:30 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0DB22269
	for <iommu@archiver.kernel.org>; Mon, 19 Oct 2020 02:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.b="nyHrX6Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0DB22269
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id A59188760C;
	Mon, 19 Oct 2020 02:33:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oitgOlS+6Fna; Mon, 19 Oct 2020 02:33:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CF46987606;
	Mon, 19 Oct 2020 02:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ADB31C088B;
	Mon, 19 Oct 2020 02:33:26 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2DFEEC0051
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 02:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 16FB0236B5
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 02:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RghQf4y3VVxV for <iommu@lists.linux-foundation.org>;
 Mon, 19 Oct 2020 02:33:22 +0000 (UTC)
X-Greylist: delayed 00:08:12 by SQLgrey-1.7.6
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com
 [209.85.216.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 9D43123504
 for <iommu@lists.linux-foundation.org>; Mon, 19 Oct 2020 02:33:22 +0000 (UTC)
Received: by mail-pj1-f66.google.com with SMTP id gm14so4502751pjb.2
 for <iommu@lists.linux-foundation.org>; Sun, 18 Oct 2020 19:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=oycxUIbLy+GIbZrwsw2OQtaFMAps2/oYqPAOhn7npOA=;
 b=nyHrX6Bz4WwkqbqiR/vRLgDN5Nf2qD+eCq/9RPg69Z+QDLI3x3zRHiK2coez0exlv6
 zdHELzx/XATemLh2Q2AzRWCPBzw+46geJ9K+P99PzY2InT4dguRLN6KrFiXrxnkqU4WX
 8yRXFTLV4qkK4Kp1C3xTjMApVgGns6nZYWGsAcMNY6vQIphSydfEX6Ea/dnPK/F9Cur6
 P8CTuTWQ1iWdEkEM0vREzQmH6Z0VEWL746fqxnWZzcNK70UX857l0NwM1ZTpjirWYqzM
 rZROGJ2BE0TI+r/g8IA/2sfI59Uxeuw6+qBVrNvTzkXgb8DMDsVh8DIq4sdg2SHPo6FN
 i7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oycxUIbLy+GIbZrwsw2OQtaFMAps2/oYqPAOhn7npOA=;
 b=UNoNQgkyHC0I5aeXKH7augKunzZM1iJG9lw+pctYRH7H015fzXxBlqAyKGgWsAU+06
 9d5lGxHyCDSDVAjNSTFWqePinpkEp0OMqbWgdDLXyTMy+6r1bncsrlAybrI1uqgBoHQd
 ZTwnVhJ4q9kbLlxkbEj4LaM5rzly/BmUKERmzt/iTBaDN3oWNTlMMfp/1LWfv6PFkDGP
 nR0HnmMtMQY0Ldi0DdwxmRx+I3BojGN4377wESVvAZ10GZkR+4/A6QVMD5IYkwo9VlhP
 uITVKwoXJxnIScYJsVJD2FNlpWz8G5hnLm3Bp3yt2HTmJwh9nHwt8oKZq++3H2RWrspx
 +RRw==
X-Gm-Message-State: AOAM533fi+qEgOp6bvx3lM5Ce1nRU8FocCq/C3LSV89IC5ccpF3jlLPz
 aAEDFdYki5ngwAHv/OxF3DgJusID0o2RttSS
X-Google-Smtp-Source: ABdhPJxPKX080BiV5v4tnkaa4400x4k3rK1j5sWpdbJiqRkeH+/9Uq3FM5Vb9dMKmDOh5ZtI6PGX5A==
X-Received: by 2002:a17:902:bb8c:b029:d2:2503:e458 with SMTP id
 m12-20020a170902bb8cb02900d22503e458mr14936892pls.18.1603074309433; 
 Sun, 18 Oct 2020 19:25:09 -0700 (PDT)
Received: from [192.168.10.88] (124-171-83-152.dyn.iinet.net.au.
 [124.171.83.152])
 by smtp.gmail.com with UTF8SMTPSA id fh19sm6948594pjb.38.2020.10.18.19.25.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Oct 2020 19:25:08 -0700 (PDT)
Subject: Re: [PATCH 8/9] dma-mapping: move large parts of <linux/dma-direct.h>
 to kernel/dma
To: Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
References: <20200930085548.920261-1-hch@lst.de>
 <20200930085548.920261-9-hch@lst.de>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <afaf49d9-5465-4b1a-dac1-91688ba4abbf@ozlabs.ru>
Date: Mon, 19 Oct 2020 13:25:02 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <20200930085548.920261-9-hch@lst.de>
Content-Language: en-US
Cc: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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



On 30/09/2020 18:55, Christoph Hellwig wrote:
> Most of the dma_direct symbols should only be used by direct.c and
> mapping.c, so move them to kernel/dma.  In fact more of dma-direct.h
> should eventually move, but that will require more coordination with
> other subsystems.

Because of this change, 
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200713062348.100552-1-aik@ozlabs.ru/ 
does not work anymore.

Should I send a patch moving 
dma_direct_map_sg/dma_direct_map_page/+unmap back to include/ or there 
is a better idea? thanks,


> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   include/linux/dma-direct.h | 106 ---------------------------------
>   kernel/dma/direct.c        |   2 +-
>   kernel/dma/direct.h        | 119 +++++++++++++++++++++++++++++++++++++
>   kernel/dma/mapping.c       |   2 +-
>   4 files changed, 121 insertions(+), 108 deletions(-)
>   create mode 100644 kernel/dma/direct.h
> 
> diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
> index 38ed3b55034d50..a2d6640c42c04e 100644
> --- a/include/linux/dma-direct.h
> +++ b/include/linux/dma-direct.h
> @@ -120,114 +120,8 @@ struct page *dma_direct_alloc_pages(struct device *dev, size_t size,
>   void dma_direct_free_pages(struct device *dev, size_t size,
>   		struct page *page, dma_addr_t dma_addr,
>   		enum dma_data_direction dir);
> -int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs);
> -bool dma_direct_can_mmap(struct device *dev);
> -int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs);
>   int dma_direct_supported(struct device *dev, u64 mask);
> -bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
> -int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> -		enum dma_data_direction dir, unsigned long attrs);
>   dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>   		size_t size, enum dma_data_direction dir, unsigned long attrs);
> -size_t dma_direct_max_mapping_size(struct device *dev);
>   
> -#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> -    defined(CONFIG_SWIOTLB)
> -void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> -		int nents, enum dma_data_direction dir);
> -#else
> -static inline void dma_direct_sync_sg_for_device(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> -{
> -}
> -#endif
> -
> -#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> -    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
> -    defined(CONFIG_SWIOTLB)
> -void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> -		int nents, enum dma_data_direction dir, unsigned long attrs);
> -void dma_direct_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
> -#else
> -static inline void dma_direct_unmap_sg(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
> -		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> -{
> -}
> -#endif
> -
> -static inline void dma_direct_sync_single_for_device(struct device *dev,
> -		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> -{
> -	phys_addr_t paddr = dma_to_phys(dev, addr);
> -
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> -		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
> -
> -	if (!dev_is_dma_coherent(dev))
> -		arch_sync_dma_for_device(paddr, size, dir);
> -}
> -
> -static inline void dma_direct_sync_single_for_cpu(struct device *dev,
> -		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> -{
> -	phys_addr_t paddr = dma_to_phys(dev, addr);
> -
> -	if (!dev_is_dma_coherent(dev)) {
> -		arch_sync_dma_for_cpu(paddr, size, dir);
> -		arch_sync_dma_for_cpu_all();
> -	}
> -
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> -		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
> -
> -	if (dir == DMA_FROM_DEVICE)
> -		arch_dma_mark_clean(paddr, size);
> -}
> -
> -static inline dma_addr_t dma_direct_map_page(struct device *dev,
> -		struct page *page, unsigned long offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	phys_addr_t phys = page_to_phys(page) + offset;
> -	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> -
> -	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> -		return swiotlb_map(dev, phys, size, dir, attrs);
> -
> -	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> -		if (swiotlb_force != SWIOTLB_NO_FORCE)
> -			return swiotlb_map(dev, phys, size, dir, attrs);
> -
> -		dev_WARN_ONCE(dev, 1,
> -			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> -			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> -		return DMA_MAPPING_ERROR;
> -	}
> -
> -	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		arch_sync_dma_for_device(phys, size, dir);
> -	return dma_addr;
> -}
> -
> -static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	phys_addr_t phys = dma_to_phys(dev, addr);
> -
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> -		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> -
> -	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
> -}
>   #endif /* _LINUX_DMA_DIRECT_H */
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 87697c86f0b82a..bf9f77623022bb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -7,13 +7,13 @@
>   #include <linux/memblock.h> /* for max_pfn */
>   #include <linux/export.h>
>   #include <linux/mm.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/scatterlist.h>
>   #include <linux/pfn.h>
>   #include <linux/vmalloc.h>
>   #include <linux/set_memory.h>
>   #include <linux/slab.h>
> +#include "direct.h"
>   
>   /*
>    * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use it
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> new file mode 100644
> index 00000000000000..b9861557873768
> --- /dev/null
> +++ b/kernel/dma/direct.h
> @@ -0,0 +1,119 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2018 Christoph Hellwig.
> + *
> + * DMA operations that map physical memory directly without using an IOMMU.
> + */
> +#ifndef _KERNEL_DMA_DIRECT_H
> +#define _KERNEL_DMA_DIRECT_H
> +
> +#include <linux/dma-direct.h>
> +
> +int dma_direct_get_sgtable(struct device *dev, struct sg_table *sgt,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs);
> +bool dma_direct_can_mmap(struct device *dev);
> +int dma_direct_mmap(struct device *dev, struct vm_area_struct *vma,
> +		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> +		unsigned long attrs);
> +bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr);
> +int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
> +		enum dma_data_direction dir, unsigned long attrs);
> +size_t dma_direct_max_mapping_size(struct device *dev);
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE) || \
> +    defined(CONFIG_SWIOTLB)
> +void dma_direct_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir);
> +#else
> +static inline void dma_direct_sync_sg_for_device(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> +{
> +}
> +#endif
> +
> +#if defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU) || \
> +    defined(CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU_ALL) || \
> +    defined(CONFIG_SWIOTLB)
> +void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
> +void dma_direct_sync_sg_for_cpu(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir);
> +#else
> +static inline void dma_direct_unmap_sg(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +}
> +static inline void dma_direct_sync_sg_for_cpu(struct device *dev,
> +		struct scatterlist *sgl, int nents, enum dma_data_direction dir)
> +{
> +}
> +#endif
> +
> +static inline void dma_direct_sync_single_for_device(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (unlikely(is_swiotlb_buffer(paddr)))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_DEVICE);
> +
> +	if (!dev_is_dma_coherent(dev))
> +		arch_sync_dma_for_device(paddr, size, dir);
> +}
> +
> +static inline void dma_direct_sync_single_for_cpu(struct device *dev,
> +		dma_addr_t addr, size_t size, enum dma_data_direction dir)
> +{
> +	phys_addr_t paddr = dma_to_phys(dev, addr);
> +
> +	if (!dev_is_dma_coherent(dev)) {
> +		arch_sync_dma_for_cpu(paddr, size, dir);
> +		arch_sync_dma_for_cpu_all();
> +	}
> +
> +	if (unlikely(is_swiotlb_buffer(paddr)))
> +		swiotlb_tbl_sync_single(dev, paddr, size, dir, SYNC_FOR_CPU);
> +
> +	if (dir == DMA_FROM_DEVICE)
> +		arch_dma_mark_clean(paddr, size);
> +}
> +
> +static inline dma_addr_t dma_direct_map_page(struct device *dev,
> +		struct page *page, unsigned long offset, size_t size,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	phys_addr_t phys = page_to_phys(page) + offset;
> +	dma_addr_t dma_addr = phys_to_dma(dev, phys);
> +
> +	if (unlikely(swiotlb_force == SWIOTLB_FORCE))
> +		return swiotlb_map(dev, phys, size, dir, attrs);
> +
> +	if (unlikely(!dma_capable(dev, dma_addr, size, true))) {
> +		if (swiotlb_force != SWIOTLB_NO_FORCE)
> +			return swiotlb_map(dev, phys, size, dir, attrs);
> +
> +		dev_WARN_ONCE(dev, 1,
> +			     "DMA addr %pad+%zu overflow (mask %llx, bus limit %llx).\n",
> +			     &dma_addr, size, *dev->dma_mask, dev->bus_dma_limit);
> +		return DMA_MAPPING_ERROR;
> +	}
> +
> +	if (!dev_is_dma_coherent(dev) && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		arch_sync_dma_for_device(phys, size, dir);
> +	return dma_addr;
> +}
> +
> +static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	phys_addr_t phys = dma_to_phys(dev, addr);
> +
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
> +
> +	if (unlikely(is_swiotlb_buffer(phys)))
> +		swiotlb_tbl_unmap_single(dev, phys, size, size, dir, attrs);
> +}
> +#endif /* _KERNEL_DMA_DIRECT_H */
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 335ba183e0956a..51bb8fa8eb8948 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -7,7 +7,6 @@
>    */
>   #include <linux/memblock.h> /* for max_pfn */
>   #include <linux/acpi.h>
> -#include <linux/dma-direct.h>
>   #include <linux/dma-map-ops.h>
>   #include <linux/export.h>
>   #include <linux/gfp.h>
> @@ -15,6 +14,7 @@
>   #include <linux/slab.h>
>   #include <linux/vmalloc.h>
>   #include "debug.h"
> +#include "direct.h"
>   
>   /*
>    * Managed DMA API
> 

-- 
Alexey
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
