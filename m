Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6360AC433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 367472078B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 18:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 367472078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E52FB86B71;
	Tue,  1 Sep 2020 18:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0lvGSHdSTxKE; Tue,  1 Sep 2020 18:39:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A8BD38507B;
	Tue,  1 Sep 2020 18:39:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A01EC0052;
	Tue,  1 Sep 2020 18:39:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 869BCC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:39:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6CB0F8507B
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7kidQCHnfm7j for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 18:39:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3260886B71
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 18:39:39 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 662D11FB;
 Tue,  1 Sep 2020 11:39:38 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D9C8F3F71F;
 Tue,  1 Sep 2020 11:39:34 -0700 (PDT)
Subject: Re: [PATCH v9 05/32] drm: etnaviv: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063530eucas1p16acb847d7da0ea734bef507688a76c5a@eucas1p1.samsung.com>
 <20200826063316.23486-6-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <57a23432-87f3-c6b3-0623-1ddd3c569e90@arm.com>
Date: Tue, 1 Sep 2020 19:39:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-6-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>,
 linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
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

On 2020-08-26 07:32, Marek Szyprowski wrote:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
> 
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
> 
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 +++++-------
>   drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 13 +++----------
>   2 files changed, 8 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index f06e19e7be04..eaf1949bc2e4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -27,7 +27,7 @@ static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
>   	 * because display controller, GPU, etc. are not coherent.
>   	 */
>   	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
> -		dma_map_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>   }
>   
>   static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj)
> @@ -51,7 +51,7 @@ static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj
>   	 * discard those writes.
>   	 */
>   	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
> -		dma_unmap_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_unmap_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>   }
>   
>   /* called with etnaviv_obj->lock held */
> @@ -404,9 +404,8 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>   	}
>   
>   	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> -		dma_sync_sg_for_cpu(dev->dev, etnaviv_obj->sgt->sgl,
> -				    etnaviv_obj->sgt->nents,
> -				    etnaviv_op_to_dma_dir(op));
> +		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
> +					 etnaviv_op_to_dma_dir(op));
>   		etnaviv_obj->last_cpu_prep_op = op;
>   	}
>   
> @@ -421,8 +420,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>   	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
>   		/* fini without a prep is almost certainly a userspace error */
>   		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
> -		dma_sync_sg_for_device(dev->dev, etnaviv_obj->sgt->sgl,
> -			etnaviv_obj->sgt->nents,
> +		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
>   			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
>   		etnaviv_obj->last_cpu_prep_op = 0;
>   	}
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index 3607d348c298..13b100553a0b 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -79,7 +79,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>   	if (!context || !sgt)
>   		return -EINVAL;
>   
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
>   		u32 pa = sg_dma_address(sg) - sg->offset;
>   		size_t bytes = sg_dma_len(sg) + sg->offset;
>   
> @@ -95,14 +95,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>   	return 0;
>   
>   fail:
> -	da = iova;
> -
> -	for_each_sg(sgt->sgl, sg, i, j) {
> -		size_t bytes = sg_dma_len(sg) + sg->offset;
> -
> -		etnaviv_context_unmap(context, da, bytes);
> -		da += bytes;
> -	}
> +	etnaviv_context_unmap(context, iova, da - iova);

I had to take a closer look to figure this out, but AFAICS it does 
indeed work out as a simpler way of achieving the exact same result, and 
in fact neatly mirrors how etnaviv_context_map() itself cleans up.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   	return ret;
>   }
>   
> @@ -113,7 +106,7 @@ static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
>   	unsigned int da = iova;
>   	int i;
>   
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
>   		size_t bytes = sg_dma_len(sg) + sg->offset;
>   
>   		etnaviv_context_unmap(context, da, bytes);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
