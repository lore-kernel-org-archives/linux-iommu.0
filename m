Return-Path: <SRS0=xflu=WZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E76C3A59F
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:43:46 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A11921874
	for <iommu@archiver.kernel.org>; Thu, 29 Aug 2019 22:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LG+7fN41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A11921874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C1D1259C5;
	Thu, 29 Aug 2019 22:43:43 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6A64C59B7
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:42:12 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 3EFECE6
	for <iommu@lists.linux-foundation.org>;
	Thu, 29 Aug 2019 22:42:11 +0000 (UTC)
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
	bits)) (No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A39D32189D;
	Thu, 29 Aug 2019 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567118531;
	bh=xHkEUC70NyhQrdUtUwDNpqvFabXbH4FNTzDPXPE1tqY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=LG+7fN41BbkQDRJj56NLA6759Otnvnf3nvVutDii10+eEzLBlDeRKXwPCpCclCsiA
	Cl7GH+XwZzjeaHNfXrbRV8R+5ceePqFPWCu9iGGxmTfFsCxbnOr/pXW9XZEEsWSbYn
	rrnwK2ejARhZqSJAQfOT6+NQJikZVzm+uVGT9078=
Date: Thu, 29 Aug 2019 15:42:10 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 04/11] xen/arm: remove xen_dma_ops
In-Reply-To: <20190826121944.515-5-hch@lst.de>
Message-ID: <alpine.DEB.2.21.1908281458070.8175@sstabellini-ThinkPad-T480s>
References: <20190826121944.515-1-hch@lst.de> <20190826121944.515-5-hch@lst.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Cc: Julien Grall <julien.grall@arm.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
	xen-devel@lists.xenproject.org, linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Mon, 26 Aug 2019, Christoph Hellwig wrote:
> arm and arm64 can just use xen_swiotlb_dma_ops directly like x86, no
> need for a pointer indirection.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Julien Grall <julien.grall@arm.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  arch/arm/mm/dma-mapping.c    | 3 ++-
>  arch/arm/xen/mm.c            | 4 ----
>  arch/arm64/mm/dma-mapping.c  | 3 ++-
>  include/xen/arm/hypervisor.h | 2 --
>  4 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index 738097396445..2661cad36359 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -35,6 +35,7 @@
>  #include <asm/mach/map.h>
>  #include <asm/system_info.h>
>  #include <asm/dma-contiguous.h>
> +#include <xen/swiotlb-xen.h>
>  
>  #include "dma.h"
>  #include "mm.h"
> @@ -2360,7 +2361,7 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  #ifdef CONFIG_XEN
>  	if (xen_initial_domain())
> -		dev->dma_ops = xen_dma_ops;
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  	dev->archdata.dma_ops_setup = true;
>  }
> diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
> index 14210ebdea1a..9b3a6c0ca681 100644
> --- a/arch/arm/xen/mm.c
> +++ b/arch/arm/xen/mm.c
> @@ -163,16 +163,12 @@ void xen_destroy_contiguous_region(phys_addr_t pstart, unsigned int order)
>  }
>  EXPORT_SYMBOL_GPL(xen_destroy_contiguous_region);
>  
> -const struct dma_map_ops *xen_dma_ops;
> -EXPORT_SYMBOL(xen_dma_ops);
> -
>  int __init xen_mm_init(void)
>  {
>  	struct gnttab_cache_flush cflush;
>  	if (!xen_initial_domain())
>  		return 0;
>  	xen_swiotlb_init(1, false);
> -	xen_dma_ops = &xen_swiotlb_dma_ops;
>  
>  	cflush.op = 0;
>  	cflush.a.dev_bus_addr = 0;
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index bd2b039f43a6..4b244a037349 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -8,6 +8,7 @@
>  #include <linux/cache.h>
>  #include <linux/dma-noncoherent.h>
>  #include <linux/dma-iommu.h>
> +#include <xen/swiotlb-xen.h>
>  
>  #include <asm/cacheflush.h>
>  
> @@ -64,6 +65,6 @@ void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  
>  #ifdef CONFIG_XEN
>  	if (xen_initial_domain())
> -		dev->dma_ops = xen_dma_ops;
> +		dev->dma_ops = &xen_swiotlb_dma_ops;
>  #endif
>  }
> diff --git a/include/xen/arm/hypervisor.h b/include/xen/arm/hypervisor.h
> index 2982571f7cc1..43ef24dd030e 100644
> --- a/include/xen/arm/hypervisor.h
> +++ b/include/xen/arm/hypervisor.h
> @@ -19,8 +19,6 @@ static inline enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
>  	return PARAVIRT_LAZY_NONE;
>  }
>  
> -extern const struct dma_map_ops *xen_dma_ops;
> -
>  #ifdef CONFIG_XEN
>  void __init xen_early_init(void);
>  #else
> -- 
> 2.20.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
