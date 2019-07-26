Return-Path: <SRS0=gbr8=VX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABF5C76191
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 06:28:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F168D218DA
	for <iommu@archiver.kernel.org>; Fri, 26 Jul 2019 06:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F168D218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 990BEB5F;
	Fri, 26 Jul 2019 06:28:55 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 813F03EE
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 06:28:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id CE28F709
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Jul 2019 06:28:53 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA18068B02; Fri, 26 Jul 2019 08:28:49 +0200 (CEST)
Date: Fri, 26 Jul 2019 08:28:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH 1/2] dma-contiguous: do not overwrite align in
	dma_alloc_contiguous()
Message-ID: <20190726062849.GE22881@lst.de>
References: <20190725233959.15129-1-nicoleotsuka@gmail.com>
	<20190725233959.15129-2-nicoleotsuka@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190725233959.15129-2-nicoleotsuka@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: dafna.hirschfeld@collabora.com, linux-kernel@vger.kernel.org,
	iommu@lists.linux-foundation.org, robin.murphy@arm.com, hch@lst.de
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

On Thu, Jul 25, 2019 at 04:39:58PM -0700, Nicolin Chen wrote:
> The dma_alloc_contiguous() limits align at CONFIG_CMA_ALIGNMENT for
> cma_alloc() however it does not restore it for the fallback routine.
> This will result in a size mismatch between the allocation and free
> when running in the fallback routines, if the align is larger than
> CONFIG_CMA_ALIGNMENT.
> 
> This patch adds a cma_align to take care of cma_alloc() and prevent
> the align from being overwritten.
> 
> Fixes: fdaeec198ada ("dma-contiguous: add dma_{alloc,free}_contiguous() helpers")
> Reported-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>  kernel/dma/contiguous.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index bfc0c17f2a3d..fa8cd0f0512e 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -233,6 +233,7 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	int node = dev ? dev_to_node(dev) : NUMA_NO_NODE;
>  	size_t count = PAGE_ALIGN(size) >> PAGE_SHIFT;
>  	size_t align = get_order(PAGE_ALIGN(size));
> +	size_t cma_align = CONFIG_CMA_ALIGNMENT;
>  	struct page *page = NULL;
>  	struct cma *cma = NULL;
>  
> @@ -241,11 +242,11 @@ struct page *dma_alloc_contiguous(struct device *dev, size_t size, gfp_t gfp)
>  	else if (count > 1)
>  		cma = dma_contiguous_default_area;
>  
> +	cma_align = min_t(size_t, align, cma_align);
> +
>  	/* CMA can be used only in the context which permits sleeping */
> -	if (cma && gfpflags_allow_blocking(gfp)) {
> -		align = min_t(size_t, align, CONFIG_CMA_ALIGNMENT);
> -		page = cma_alloc(cma, count, align, gfp & __GFP_NOWARN);
> -	}
> +	if (cma && gfpflags_allow_blocking(gfp))
> +		page = cma_alloc(cma, count, cma_align, gfp & __GFP_NOWARN);

Shouldn't cma_align be confined to the block guarded by
"if (cma && gfpflags_allow_blocking(gfp))" so that we can optimize it
away for configurations that do not support CMA?
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
