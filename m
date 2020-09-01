Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C38C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B732207D3
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B732207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 06DF2870E2;
	Tue,  1 Sep 2020 17:46:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8SQ7OEErTCrN; Tue,  1 Sep 2020 17:46:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id D4EE986DEE;
	Tue,  1 Sep 2020 17:46:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC7CAC07FF;
	Tue,  1 Sep 2020 17:46:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BF953C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:46:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 891CE220B2
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:46:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uwiaSeAJkEsZ for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 17:46:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 384F2204E7
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:46:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 679CC1FB;
 Tue,  1 Sep 2020 10:46:44 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A5AC3F71F;
 Tue,  1 Sep 2020 10:46:37 -0700 (PDT)
Subject: Re: [PATCH v9 03/32] drm: core: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063529eucas1p19d797cf74bf653bf68b0a0e860806dbf@eucas1p1.samsung.com>
 <20200826063316.23486-4-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <a96aefea-936a-e54d-1604-93902443b360@arm.com>
Date: Tue, 1 Sep 2020 18:46:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-4-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
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
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>   drivers/gpu/drm/drm_cache.c            |  2 +-
>   drivers/gpu/drm/drm_gem_shmem_helper.c | 14 +++++++++-----
>   drivers/gpu/drm/drm_prime.c            | 11 ++++++-----
>   3 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_cache.c b/drivers/gpu/drm/drm_cache.c
> index 03e01b000f7a..0fe3c496002a 100644
> --- a/drivers/gpu/drm/drm_cache.c
> +++ b/drivers/gpu/drm/drm_cache.c
> @@ -127,7 +127,7 @@ drm_clflush_sg(struct sg_table *st)
>   		struct sg_page_iter sg_iter;
>   
>   		mb(); /*CLFLUSH is ordered only by using memory barriers*/
> -		for_each_sg_page(st->sgl, &sg_iter, st->nents, 0)
> +		for_each_sgtable_page(st, &sg_iter, 0)
>   			drm_clflush_page(sg_page_iter_page(&sg_iter));
>   		mb(); /*Make sure that all cache line entry is flushed*/
>   
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index 4b7cfbac4daa..47d8211221f2 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -126,8 +126,8 @@ void drm_gem_shmem_free_object(struct drm_gem_object *obj)
>   		drm_prime_gem_destroy(obj, shmem->sgt);
>   	} else {
>   		if (shmem->sgt) {
> -			dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
> -				     shmem->sgt->nents, DMA_BIDIRECTIONAL);
> +			dma_unmap_sgtable(obj->dev->dev, shmem->sgt,
> +					  DMA_BIDIRECTIONAL, 0);
>   			sg_free_table(shmem->sgt);
>   			kfree(shmem->sgt);
>   		}
> @@ -424,8 +424,7 @@ void drm_gem_shmem_purge_locked(struct drm_gem_object *obj)
>   
>   	WARN_ON(!drm_gem_shmem_is_purgeable(shmem));
>   
> -	dma_unmap_sg(obj->dev->dev, shmem->sgt->sgl,
> -		     shmem->sgt->nents, DMA_BIDIRECTIONAL);
> +	dma_unmap_sgtable(obj->dev->dev, shmem->sgt, DMA_BIDIRECTIONAL, 0);
>   	sg_free_table(shmem->sgt);
>   	kfree(shmem->sgt);
>   	shmem->sgt = NULL;
> @@ -697,12 +696,17 @@ struct sg_table *drm_gem_shmem_get_pages_sgt(struct drm_gem_object *obj)
>   		goto err_put_pages;
>   	}
>   	/* Map the pages for use by the h/w. */
> -	dma_map_sg(obj->dev->dev, sgt->sgl, sgt->nents, DMA_BIDIRECTIONAL);
> +	ret = dma_map_sgtable(obj->dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
> +	if (ret)
> +		goto err_free_sgt;
>   
>   	shmem->sgt = sgt;
>   
>   	return sgt;
>   
> +err_free_sgt:
> +	sg_free_table(sgt);
> +	kfree(sgt);

Should this be a separate patch to add the missing error handling to the 
existing code first?

Otherwise the rest of the mechanical conversion looks straightforward 
enough, and I'm not the separation-of-concerns police (for this 
subsystem, at least), so either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   err_put_pages:
>   	drm_gem_shmem_put_pages(shmem);
>   	return ERR_PTR(ret);
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 5d181bf60a44..c45b0cc6e31d 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -617,6 +617,7 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
>   {
>   	struct drm_gem_object *obj = attach->dmabuf->priv;
>   	struct sg_table *sgt;
> +	int ret;
>   
>   	if (WARN_ON(dir == DMA_NONE))
>   		return ERR_PTR(-EINVAL);
> @@ -626,11 +627,12 @@ struct sg_table *drm_gem_map_dma_buf(struct dma_buf_attachment *attach,
>   	else
>   		sgt = obj->dev->driver->gem_prime_get_sg_table(obj);
>   
> -	if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -			      DMA_ATTR_SKIP_CPU_SYNC)) {
> +	ret = dma_map_sgtable(attach->dev, sgt, dir,
> +			      DMA_ATTR_SKIP_CPU_SYNC);
> +	if (ret) {
>   		sg_free_table(sgt);
>   		kfree(sgt);
> -		sgt = ERR_PTR(-ENOMEM);
> +		sgt = ERR_PTR(ret);
>   	}
>   
>   	return sgt;
> @@ -652,8 +654,7 @@ void drm_gem_unmap_dma_buf(struct dma_buf_attachment *attach,
>   	if (!sgt)
>   		return;
>   
> -	dma_unmap_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -			   DMA_ATTR_SKIP_CPU_SYNC);
> +	dma_unmap_sgtable(attach->dev, sgt, dir, DMA_ATTR_SKIP_CPU_SYNC);
>   	sg_free_table(sgt);
>   	kfree(sgt);
>   }
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
