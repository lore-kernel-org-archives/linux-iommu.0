Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_RED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA879C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 23:31:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DC6A613B4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 23:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DC6A613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6325F401F3;
	Thu, 17 Jun 2021 23:31:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T5Jc9sUsTyU0; Thu, 17 Jun 2021 23:31:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2B6774014D;
	Thu, 17 Jun 2021 23:31:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07F00C000D;
	Thu, 17 Jun 2021 23:31:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9CBB1C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:31:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 89B0B415E8
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:31:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cef3aMptxwyJ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 23:30:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 008DE415B8
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 23:30:57 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8E526120A;
 Thu, 17 Jun 2021 23:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1623972657;
 bh=4/LSkdFzmkpBIqOs2lik6bFTOLfsE1vFp3pSPvsIAqo=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=KabHsUuSd3hUeQkH5QL2Sast+Pt6XMU4ZN9i3oUCsqYyVMK9whYkZKwQyJXODJVNc
 TzO5tFR1BNLnZQ5KkIoC5rq/vVgcjDuaAF80/HtiNb1wOVxm3CppaxT2xY/I4dzpYB
 M+Aev1dOzNNy3oC1+YCccgFClj9tP/zQxcmXw1XC5VbZG80dLVkb8zSynKXi4NVwyn
 0SJkjSwb2Rhj6hcwYba0AuLzEBy00TQw8hBr3kM6sBHZR9h/6pIWY0zm3Vq8KbPM5Z
 6BOc0hRZnL9tnUFnAutTcMrNXIzinS4Gk728uyb268u6n8vujkFE/QAFXn20IgjiLI
 HE4nztpznGM9g==
Date: Thu, 17 Jun 2021 16:30:55 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Claire Chang <tientzu@chromium.org>
Subject: Re: [PATCH v13 04/12] swiotlb: Update is_swiotlb_buffer to add a
 struct device argument
In-Reply-To: <20210617062635.1660944-5-tientzu@chromium.org>
Message-ID: <alpine.DEB.2.21.2106171445110.24906@sstabellini-ThinkPad-T480s>
References: <20210617062635.1660944-1-tientzu@chromium.org>
 <20210617062635.1660944-5-tientzu@chromium.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: heikki.krogerus@linux.intel.com, thomas.hellstrom@linux.intel.com,
 peterz@infradead.org, benh@kernel.crashing.org,
 joonas.lahtinen@linux.intel.com, dri-devel@lists.freedesktop.org,
 chris@chris-wilson.co.uk, grant.likely@arm.com, paulus@samba.org,
 Frank Rowand <frowand.list@gmail.com>, mingo@kernel.org,
 sstabellini@kernel.org, Saravana Kannan <saravanak@google.com>,
 mpe@ellerman.id.au, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Christoph Hellwig <hch@lst.de>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>, bskeggs@redhat.com,
 linux-pci@vger.kernel.org, xen-devel@lists.xenproject.org,
 Thierry Reding <treding@nvidia.com>, intel-gfx@lists.freedesktop.org,
 matthew.auld@intel.com, linux-devicetree <devicetree@vger.kernel.org>,
 jxgao@google.com, daniel@ffwll.ch, Will Deacon <will@kernel.org>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 maarten.lankhorst@linux.intel.com, airlied@linux.ie,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 jani.nikula@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
 rodrigo.vivi@intel.com, bhelgaas@google.com, boris.ostrovsky@oracle.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jgross@suse.com,
 Nicolas Boichat <drinkcat@chromium.org>, Greg KH <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Jim Quinlan <james.quinlan@broadcom.com>, xypron.glpk@gmx.de,
 Robin Murphy <robin.murphy@arm.com>, bauerman@linux.ibm.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, 17 Jun 2021, Claire Chang wrote:
> Update is_swiotlb_buffer to add a struct device argument. This will be
> useful later to allow for different pools.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Stefano Stabellini <sstabellini@kernel.org>
> Tested-by: Will Deacon <will@kernel.org>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/iommu/dma-iommu.c | 12 ++++++------
>  drivers/xen/swiotlb-xen.c |  2 +-
>  include/linux/swiotlb.h   |  7 ++++---
>  kernel/dma/direct.c       |  6 +++---
>  kernel/dma/direct.h       |  6 +++---
>  5 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 3087d9fa6065..10997ef541f8 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -507,7 +507,7 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>  
>  	__iommu_dma_unmap(dev, dma_addr, size);
>  
> -	if (unlikely(is_swiotlb_buffer(phys)))
> +	if (unlikely(is_swiotlb_buffer(dev, phys)))
>  		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>  }
>  
> @@ -578,7 +578,7 @@ static dma_addr_t __iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
>  	}
>  
>  	iova = __iommu_dma_map(dev, phys, aligned_size, prot, dma_mask);
> -	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(phys))
> +	if (iova == DMA_MAPPING_ERROR && is_swiotlb_buffer(dev, phys))
>  		swiotlb_tbl_unmap_single(dev, phys, org_size, dir, attrs);
>  	return iova;
>  }
> @@ -749,7 +749,7 @@ static void iommu_dma_sync_single_for_cpu(struct device *dev,
>  	if (!dev_is_dma_coherent(dev))
>  		arch_sync_dma_for_cpu(phys, size, dir);
>  
> -	if (is_swiotlb_buffer(phys))
> +	if (is_swiotlb_buffer(dev, phys))
>  		swiotlb_sync_single_for_cpu(dev, phys, size, dir);
>  }
>  
> @@ -762,7 +762,7 @@ static void iommu_dma_sync_single_for_device(struct device *dev,
>  		return;
>  
>  	phys = iommu_iova_to_phys(iommu_get_dma_domain(dev), dma_handle);
> -	if (is_swiotlb_buffer(phys))
> +	if (is_swiotlb_buffer(dev, phys))
>  		swiotlb_sync_single_for_device(dev, phys, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev))
> @@ -783,7 +783,7 @@ static void iommu_dma_sync_sg_for_cpu(struct device *dev,
>  		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_cpu(sg_phys(sg), sg->length, dir);
>  
> -		if (is_swiotlb_buffer(sg_phys(sg)))
> +		if (is_swiotlb_buffer(dev, sg_phys(sg)))
>  			swiotlb_sync_single_for_cpu(dev, sg_phys(sg),
>  						    sg->length, dir);
>  	}
> @@ -800,7 +800,7 @@ static void iommu_dma_sync_sg_for_device(struct device *dev,
>  		return;
>  
>  	for_each_sg(sgl, sg, nelems, i) {
> -		if (is_swiotlb_buffer(sg_phys(sg)))
> +		if (is_swiotlb_buffer(dev, sg_phys(sg)))
>  			swiotlb_sync_single_for_device(dev, sg_phys(sg),
>  						       sg->length, dir);
>  
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 4c89afc0df62..0c6ed09f8513 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -100,7 +100,7 @@ static int is_xen_swiotlb_buffer(struct device *dev, dma_addr_t dma_addr)
>  	 * in our domain. Therefore _only_ check address within our domain.
>  	 */
>  	if (pfn_valid(PFN_DOWN(paddr)))
> -		return is_swiotlb_buffer(paddr);
> +		return is_swiotlb_buffer(dev, paddr);
>  	return 0;
>  }
>  
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 216854a5e513..d1f3d95881cd 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -2,6 +2,7 @@
>  #ifndef __LINUX_SWIOTLB_H
>  #define __LINUX_SWIOTLB_H
>  
> +#include <linux/device.h>
>  #include <linux/dma-direction.h>
>  #include <linux/init.h>
>  #include <linux/types.h>
> @@ -101,9 +102,9 @@ struct io_tlb_mem {
>  };
>  extern struct io_tlb_mem *io_tlb_default_mem;
>  
> -static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> +static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
> -	struct io_tlb_mem *mem = io_tlb_default_mem;
> +	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
>  
>  	return mem && paddr >= mem->start && paddr < mem->end;
>  }
> @@ -115,7 +116,7 @@ bool is_swiotlb_active(void);
>  void __init swiotlb_adjust_size(unsigned long size);
>  #else
>  #define swiotlb_force SWIOTLB_NO_FORCE
> -static inline bool is_swiotlb_buffer(phys_addr_t paddr)
> +static inline bool is_swiotlb_buffer(struct device *dev, phys_addr_t paddr)
>  {
>  	return false;
>  }
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index f737e3347059..84c9feb5474a 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -343,7 +343,7 @@ void dma_direct_sync_sg_for_device(struct device *dev,
>  	for_each_sg(sgl, sg, nents, i) {
>  		phys_addr_t paddr = dma_to_phys(dev, sg_dma_address(sg));
>  
> -		if (unlikely(is_swiotlb_buffer(paddr)))
> +		if (unlikely(is_swiotlb_buffer(dev, paddr)))
>  			swiotlb_sync_single_for_device(dev, paddr, sg->length,
>  						       dir);
>  
> @@ -369,7 +369,7 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		if (!dev_is_dma_coherent(dev))
>  			arch_sync_dma_for_cpu(paddr, sg->length, dir);
>  
> -		if (unlikely(is_swiotlb_buffer(paddr)))
> +		if (unlikely(is_swiotlb_buffer(dev, paddr)))
>  			swiotlb_sync_single_for_cpu(dev, paddr, sg->length,
>  						    dir);
>  
> @@ -504,7 +504,7 @@ size_t dma_direct_max_mapping_size(struct device *dev)
>  bool dma_direct_need_sync(struct device *dev, dma_addr_t dma_addr)
>  {
>  	return !dev_is_dma_coherent(dev) ||
> -		is_swiotlb_buffer(dma_to_phys(dev, dma_addr));
> +	       is_swiotlb_buffer(dev, dma_to_phys(dev, dma_addr));
>  }
>  
>  /**
> diff --git a/kernel/dma/direct.h b/kernel/dma/direct.h
> index 50afc05b6f1d..13e9e7158d94 100644
> --- a/kernel/dma/direct.h
> +++ b/kernel/dma/direct.h
> @@ -56,7 +56,7 @@ static inline void dma_direct_sync_single_for_device(struct device *dev,
>  {
>  	phys_addr_t paddr = dma_to_phys(dev, addr);
>  
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> +	if (unlikely(is_swiotlb_buffer(dev, paddr)))
>  		swiotlb_sync_single_for_device(dev, paddr, size, dir);
>  
>  	if (!dev_is_dma_coherent(dev))
> @@ -73,7 +73,7 @@ static inline void dma_direct_sync_single_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  	}
>  
> -	if (unlikely(is_swiotlb_buffer(paddr)))
> +	if (unlikely(is_swiotlb_buffer(dev, paddr)))
>  		swiotlb_sync_single_for_cpu(dev, paddr, size, dir);
>  
>  	if (dir == DMA_FROM_DEVICE)
> @@ -113,7 +113,7 @@ static inline void dma_direct_unmap_page(struct device *dev, dma_addr_t addr,
>  	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>  		dma_direct_sync_single_for_cpu(dev, addr, size, dir);
>  
> -	if (unlikely(is_swiotlb_buffer(phys)))
> +	if (unlikely(is_swiotlb_buffer(dev, phys)))
>  		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
>  }
>  #endif /* _KERNEL_DMA_DIRECT_H */
> -- 
> 2.32.0.288.g62a8d224e6-goog
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
