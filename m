Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57E8C433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:36:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA992078E
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 13:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FA992078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5DFCD86C26;
	Fri,  4 Sep 2020 13:36:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HmDwi86ZAy_l; Fri,  4 Sep 2020 13:36:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2592D86A40;
	Fri,  4 Sep 2020 13:36:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0861FC0052;
	Fri,  4 Sep 2020 13:36:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DE2FBC0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:36:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id CA47220381
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4HULWxqRfAuN for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 13:36:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by silver.osuosl.org (Postfix) with ESMTPS id EB7AE20380
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 13:36:50 +0000 (UTC)
Received: from gallifrey.ext.pengutronix.de
 ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
 by metis.ext.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <l.stach@pengutronix.de>)
 id 1kEBtX-0007na-45; Fri, 04 Sep 2020 15:36:47 +0200
Message-ID: <81a021cc6b58d46b85bb65a368c3eb9f1568a16f.camel@pengutronix.de>
Subject: Re: [PATCH v10 05/30] drm: etnaviv: fix common struct sg_table
 related issues
From: Lucas Stach <l.stach@pengutronix.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Date: Fri, 04 Sep 2020 15:37:06 +0200
In-Reply-To: <20200904131711.12950-6-m.szyprowski@samsung.com>
References: <20200904131711.12950-1-m.szyprowski@samsung.com>
 <CGME20200904133456eucas1p10d0fe1628474fcd4803a7af4437be4e1@eucas1p1.samsung.com>
 <20200904131711.12950-6-m.szyprowski@samsung.com>
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: iommu@lists.linux-foundation.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, etnaviv@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org
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

On Fr, 2020-09-04 at 15:16 +0200, Marek Szyprowski wrote:
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
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gem.c | 12 +++++-------
>  drivers/gpu/drm/etnaviv/etnaviv_mmu.c | 15 ++++-----------
>  2 files changed, 9 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gem.c b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> index f06e19e7be04..eaf1949bc2e4 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gem.c
> @@ -27,7 +27,7 @@ static void etnaviv_gem_scatter_map(struct etnaviv_gem_object *etnaviv_obj)
>  	 * because display controller, GPU, etc. are not coherent.
>  	 */
>  	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
> -		dma_map_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_map_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  }
>  
>  static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj)
> @@ -51,7 +51,7 @@ static void etnaviv_gem_scatterlist_unmap(struct etnaviv_gem_object *etnaviv_obj
>  	 * discard those writes.
>  	 */
>  	if (etnaviv_obj->flags & ETNA_BO_CACHE_MASK)
> -		dma_unmap_sg(dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_unmap_sgtable(dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
>  }
>  
>  /* called with etnaviv_obj->lock held */
> @@ -404,9 +404,8 @@ int etnaviv_gem_cpu_prep(struct drm_gem_object *obj, u32 op,
>  	}
>  
>  	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
> -		dma_sync_sg_for_cpu(dev->dev, etnaviv_obj->sgt->sgl,
> -				    etnaviv_obj->sgt->nents,
> -				    etnaviv_op_to_dma_dir(op));
> +		dma_sync_sgtable_for_cpu(dev->dev, etnaviv_obj->sgt,
> +					 etnaviv_op_to_dma_dir(op));
>  		etnaviv_obj->last_cpu_prep_op = op;
>  	}
>  
> @@ -421,8 +420,7 @@ int etnaviv_gem_cpu_fini(struct drm_gem_object *obj)
>  	if (etnaviv_obj->flags & ETNA_BO_CACHED) {
>  		/* fini without a prep is almost certainly a userspace error */
>  		WARN_ON(etnaviv_obj->last_cpu_prep_op == 0);
> -		dma_sync_sg_for_device(dev->dev, etnaviv_obj->sgt->sgl,
> -			etnaviv_obj->sgt->nents,
> +		dma_sync_sgtable_for_device(dev->dev, etnaviv_obj->sgt,
>  			etnaviv_op_to_dma_dir(etnaviv_obj->last_cpu_prep_op));
>  		etnaviv_obj->last_cpu_prep_op = 0;
>  	}
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> index 3607d348c298..15d9fa3879e5 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_mmu.c
> @@ -73,13 +73,13 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>  			     struct sg_table *sgt, unsigned len, int prot)
>  {	struct scatterlist *sg;
>  	unsigned int da = iova;
> -	unsigned int i, j;
> +	unsigned int i;
>  	int ret;
>  
>  	if (!context || !sgt)
>  		return -EINVAL;
>  
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
>  		u32 pa = sg_dma_address(sg) - sg->offset;
>  		size_t bytes = sg_dma_len(sg) + sg->offset;
>  
> @@ -95,14 +95,7 @@ static int etnaviv_iommu_map(struct etnaviv_iommu_context *context, u32 iova,
>  	return 0;
>  
>  fail:
> -	da = iova;
> -
> -	for_each_sg(sgt->sgl, sg, i, j) {
> -		size_t bytes = sg_dma_len(sg) + sg->offset;
> -
> -		etnaviv_context_unmap(context, da, bytes);
> -		da += bytes;
> -	}
> +	etnaviv_context_unmap(context, iova, da - iova);
>  	return ret;
>  }
>  
> @@ -113,7 +106,7 @@ static void etnaviv_iommu_unmap(struct etnaviv_iommu_context *context, u32 iova,
>  	unsigned int da = iova;
>  	int i;
>  
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +	for_each_sgtable_dma_sg(sgt, sg, i) {
>  		size_t bytes = sg_dma_len(sg) + sg->offset;
>  
>  		etnaviv_context_unmap(context, da, bytes);

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
