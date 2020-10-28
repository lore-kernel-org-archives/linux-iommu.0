Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBEC388F7
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 17:22:10 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 084D8247CC
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 17:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 084D8247CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8104186A46;
	Wed, 28 Oct 2020 17:22:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07IxtHnBBQtt; Wed, 28 Oct 2020 17:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5643286A4F;
	Wed, 28 Oct 2020 17:22:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3E5FAC0859;
	Wed, 28 Oct 2020 17:22:08 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9099FC0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7D26F204E1
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VMl7ZHERdk4J for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 17:22:04 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by silver.osuosl.org (Postfix) with ESMTPS id 7F58620380
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 17:22:04 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8D0A568BEB; Wed, 28 Oct 2020 18:22:01 +0100 (CET)
Date: Wed, 28 Oct 2020 18:22:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v3 1/2] dma: Allow mixing bypass and mapped DMA
 operation
Message-ID: <20201028172201.GB10015@lst.de>
References: <20201028070030.60643-1-aik@ozlabs.ru>
 <20201028070030.60643-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201028070030.60643-2-aik@ozlabs.ru>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Michael Ellerman <mpe@ellerman.id.au>, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 linux-kernel@vger.kernel.org
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

On Wed, Oct 28, 2020 at 06:00:29PM +1100, Alexey Kardashevskiy wrote:
> At the moment we allow bypassing DMA ops only when we can do this for
> the entire RAM. However there are configs with mixed type memory
> where we could still allow bypassing IOMMU in most cases;
> POWERPC with persistent memory is one example.
> 
> This adds an arch hook to determine where bypass can still work and
> we invoke direct DMA API. The following patch checks the bus limit
> on POWERPC to allow or disallow direct mapping.
> 
> This adds a CONFIG_ARCH_HAS_DMA_SET_MASK config option to make arch_xxxx
> hooks no-op by default.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  kernel/dma/mapping.c | 24 ++++++++++++++++++++----
>  kernel/dma/Kconfig   |  4 ++++
>  2 files changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 51bb8fa8eb89..a0bc9eb876ed 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -137,6 +137,18 @@ static inline bool dma_map_direct(struct device *dev,
>  	return dma_go_direct(dev, *dev->dma_mask, ops);
>  }
>  
> +#ifdef CONFIG_ARCH_HAS_DMA_MAP_DIRECT
> +bool arch_dma_map_page_direct(struct device *dev, phys_addr_t addr);
> +bool arch_dma_unmap_page_direct(struct device *dev, dma_addr_t dma_handle);
> +bool arch_dma_map_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
> +bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg, int nents);
> +#else
> +#define arch_dma_map_page_direct(d, a) (0)
> +#define arch_dma_unmap_page_direct(d, a) (0)
> +#define arch_dma_map_sg_direct(d, s, n) (0)
> +#define arch_dma_unmap_sg_direct(d, s, n) (0)
> +#endif

A bunch of overly long lines here.  Except for that this looks ok to me.
If you want me to queue up the series I can just fix it up.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
