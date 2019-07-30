Return-Path: <SRS0=JEM9=V3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67331C433FF
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 13:58:44 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 395F82089E
	for <iommu@archiver.kernel.org>; Tue, 30 Jul 2019 13:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="iPy1JeRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 395F82089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id EE4D42DE9;
	Tue, 30 Jul 2019 13:58:33 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 62E482DD3
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 13:50:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
	[213.167.242.64])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id EEE84F1
	for <iommu@lists.linux-foundation.org>;
	Tue, 30 Jul 2019 13:50:54 +0000 (UTC)
Received: from pendragon.ideasonboard.com
	(p443174-ipngn12901marunouchi.tokyo.ocn.ne.jp [153.201.242.174])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 32557CC;
	Tue, 30 Jul 2019 15:50:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1564494652;
	bh=yXsA4lQrDxWLRkikj1nrZdK3Kmxtui4EhkpZyACr6yE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iPy1JeRrk8mVG5FvMJNU6zdJm/7JpfLibA4+/WJQnWBwNA4NLRUwj7yuiVPgb7cet
	Xj6LkV4c5kqSO259vtm+pmccbU1m+oL+Uk3cGYzsBcr6FrA0RSkplFdZGF50B8CbDR
	xrf9Wc8F+UGSbbQLOPgIAEhwmYIkibFKJujlWykg=
Date: Tue, 30 Jul 2019 16:50:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] dma-mapping: remove dma_{alloc,free,mmap}_writecombine
Message-ID: <20190730135045.GA4806@pendragon.ideasonboard.com>
References: <20190730061849.29686-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190730061849.29686-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: iommu@lists.linux-foundation.org, tomi.valkeinen@ti.com,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

Hi Christoph,

Thank you for the patch.

On Tue, Jul 30, 2019 at 09:18:49AM +0300, Christoph Hellwig wrote:
> We can already use DMA_ATTR_WRITE_COMBINE or the _wc prefixed version,
> so remove the third way of doing things.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 11 +++++------
>  include/linux/dma-mapping.h         |  9 ---------
>  2 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index 785c5546067a..c70f3246a552 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -4609,11 +4609,10 @@ static int dispc_errata_i734_wa_init(struct dispc_device *dispc)
>  	i734_buf.size = i734.ovli.width * i734.ovli.height *
>  		color_mode_to_bpp(i734.ovli.fourcc) / 8;
>  
> -	i734_buf.vaddr = dma_alloc_writecombine(&dispc->pdev->dev,
> -						i734_buf.size, &i734_buf.paddr,
> -						GFP_KERNEL);
> +	i734_buf.vaddr = dma_alloc_wc(&dispc->pdev->dev, i734_buf.size,
> +			&i734_buf.paddr, GFP_KERNEL);

I would have indented this line to match the rest. Apart from that,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  	if (!i734_buf.vaddr) {
> -		dev_err(&dispc->pdev->dev, "%s: dma_alloc_writecombine failed\n",
> +		dev_err(&dispc->pdev->dev, "%s: dma_alloc_wc failed\n",
>  			__func__);
>  		return -ENOMEM;
>  	}
> @@ -4626,8 +4625,8 @@ static void dispc_errata_i734_wa_fini(struct dispc_device *dispc)
>  	if (!dispc->feat->has_gamma_i734_bug)
>  		return;
>  
> -	dma_free_writecombine(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
> -			      i734_buf.paddr);
> +	dma_free_wc(&dispc->pdev->dev, i734_buf.size, i734_buf.vaddr,
> +		    i734_buf.paddr);
>  }
>  
>  static void dispc_errata_i734_wa(struct dispc_device *dispc)
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f7d1eea32c78..633dae466097 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -786,9 +786,6 @@ static inline void *dma_alloc_wc(struct device *dev, size_t size,
>  
>  	return dma_alloc_attrs(dev, size, dma_addr, gfp, attrs);
>  }
> -#ifndef dma_alloc_writecombine
> -#define dma_alloc_writecombine dma_alloc_wc
> -#endif
>  
>  static inline void dma_free_wc(struct device *dev, size_t size,
>  			       void *cpu_addr, dma_addr_t dma_addr)
> @@ -796,9 +793,6 @@ static inline void dma_free_wc(struct device *dev, size_t size,
>  	return dma_free_attrs(dev, size, cpu_addr, dma_addr,
>  			      DMA_ATTR_WRITE_COMBINE);
>  }
> -#ifndef dma_free_writecombine
> -#define dma_free_writecombine dma_free_wc
> -#endif
>  
>  static inline int dma_mmap_wc(struct device *dev,
>  			      struct vm_area_struct *vma,
> @@ -808,9 +802,6 @@ static inline int dma_mmap_wc(struct device *dev,
>  	return dma_mmap_attrs(dev, vma, cpu_addr, dma_addr, size,
>  			      DMA_ATTR_WRITE_COMBINE);
>  }
> -#ifndef dma_mmap_writecombine
> -#define dma_mmap_writecombine dma_mmap_wc
> -#endif
>  
>  #ifdef CONFIG_NEED_DMA_MAP_STATE
>  #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)        dma_addr_t ADDR_NAME

-- 
Regards,

Laurent Pinchart
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
