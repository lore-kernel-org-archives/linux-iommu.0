Return-Path: <SRS0=IJZW=OS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230F6C433EF
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:09:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F50161361
	for <iommu@archiver.kernel.org>; Tue, 28 Sep 2021 19:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9F50161361
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7200C80D59;
	Tue, 28 Sep 2021 19:09:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vYvR2v5w_ICi; Tue, 28 Sep 2021 19:09:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 216408002A;
	Tue, 28 Sep 2021 19:09:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F3084C000F;
	Tue, 28 Sep 2021 19:09:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 16C45C000D
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:09:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 05D604157E
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:09:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=ziepe.ca
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lsyhCVN_5Gh7 for <iommu@lists.linux-foundation.org>;
 Tue, 28 Sep 2021 19:08:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DCF8640802
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 19:08:58 +0000 (UTC)
Received: by mail-il1-x136.google.com with SMTP id k13so112302ilo.7
 for <iommu@lists.linux-foundation.org>; Tue, 28 Sep 2021 12:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
 b=T7zH3yMi0g6yEhgmUnd7mO+Ur7OBh77wHEh6ggvhef5YbyC4wX4RRbWTB44KDdyQtC
 f+qApcKyr3n5Kl16eVfFgQ9tfeyRrR6Elwq6FGHKyACe8YimAJpy7cusTx0oBV41JMIt
 0Hs8ot7T3se64OIay27dLlQhOUiTQMVr0mnUblHvHoq8r+teZ7l8U9BnX5pxcEi+Yk7z
 s5RWLMvLxN8MPYR7eAYwtVLxanwLKsVahoBd3UvKp/b3/2FYvFg85dCO3UV5z34pnkRJ
 KVDkFetoYUVS2clKM8AdqWOtNoT0d0PPUr+04NJyaKP+HVSyA1Hg4mIqDJ4dKgMV/XBl
 XsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EfElY477shD06prhcbkdx9dsGqBCwQCmB0C4j8bm7NE=;
 b=ZXQ26CWwyiun8OGjq0kFvVqK73AcP98i5yzEkpmPAdMjHay3xL6vaBZGg6E2OTew3V
 CRLrwRIq+YfKy8Cjrl1X0VkJGrWXMesYwT3Nn5nGDZI4tOncdZ+wLlj7JQFy2xvC5VAQ
 V+wwfWeyy4h4Z8KjZWOSjD7J3JS/oFE8sOApUDcNKlmE650qtDdG8GxlqsbMhjlzul32
 YoTK+E8Xme90GU+EmjCRK7i/6tO7VYuNuykCppGu/+41vOpQIl3SmWZlFfzn51wuPFZH
 KcM7w/EnE4ZJQucFpUyPLDc46cYVGYJFx32P6FVfABb1lKlEarE8oxdpzvz24618BlaP
 +H0A==
X-Gm-Message-State: AOAM532PpSg3PwWWq3V5y3hNjAZn9pOGwVWMssz9Dbb+id21qVzcKio7
 NmrcEqwJ5y9NItsYqwoENvHSVw==
X-Google-Smtp-Source: ABdhPJwirdzukaEVpQtEHLEaN9P3HDIpr/EdIl+V+c/21A4I82mQWg8qeJs2PajODuEvNoAg4jE0MQ==
X-Received: by 2002:a05:6e02:1a6b:: with SMTP id
 w11mr5790685ilv.21.1632856137729; 
 Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id r13sm12324375ilh.80.2021.09.28.12.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:08:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVITI-007Fut-4V; Tue, 28 Sep 2021 16:08:56 -0300
Date: Tue, 28 Sep 2021 16:08:56 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v3 06/20] dma-direct: support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210928190856.GN3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-7-logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-mm@kvack.org, Jason Ekstrand <jason@jlekstrand.net>,
 Ira Weiny <ira.weiny@intel.com>, Christoph Hellwig <hch@lst.de>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Matthew Wilcox <willy@infradead.org>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, linux-block@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
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

On Thu, Sep 16, 2021 at 05:40:46PM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through the
>      root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally, as though it were a CPU physical address
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_dma_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 44 ++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4c6c5e0635e3..fa8317e8ff44 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -421,29 +422,60 @@ void dma_direct_sync_sg_for_cpu(struct device *dev,
>  		arch_sync_dma_for_cpu_all();
>  }
>  
> +/*
> + * Unmaps segments, except for ones marked as pci_p2pdma which do not
> + * require any further action as they contain a bus address.
> + */
>  void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  		int nents, enum dma_data_direction dir, unsigned long attrs)
>  {
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> -		dma_direct_unmap_page(dev, sg->dma_address, sg_dma_len(sg), dir,
> -			     attrs);
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_dma_pci_p2pdma(sg)) {
> +			sg_dma_unmark_pci_p2pdma(sg);
> +		} else  {
> +			dma_direct_unmap_page(dev, sg->dma_address,
> +					      sg_dma_len(sg), dir, attrs);
> +		}

If the main usage of this SGL bit is to indicate if it has been DMA
mapped, or not, I think it should be renamed to something clearer.

p2pdma is being used for lots of things now, it feels very
counter-intuitive that P2PDMA pages are not flagged with
something called sg_is_dma_pci_p2pdma().

How about sg_is_dma_unmapped_address() ?
>  
>  	for_each_sg(sgl, sg, nents, i) {
> +		if (is_pci_p2pdma_page(sg_page(sg))) {
> +			map = pci_p2pdma_map_segment(&p2pdma_state, dev, sg);
> +			switch (map) {
> +			case PCI_P2PDMA_MAP_BUS_ADDR:
> +				continue;
> +			case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +				/*
> +				 * Mapping through host bridge should be
> +				 * mapped normally, thus we do nothing
> +				 * and continue below.
> +				 */
> +				break;
> +			default:
> +				ret = -EREMOTEIO;
> +				goto out_unmap;
> +			}
> +		}
> +
>  		sg->dma_address = dma_direct_map_page(dev, sg_page(sg),
>  				sg->offset, sg->length, dir, attrs);

dma_direct_map_page() can trigger swiotlb and I didn't see this series
dealing with that?

It would probably be fine for now to fail swiotlb_map() for p2p pages?

Jason
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
