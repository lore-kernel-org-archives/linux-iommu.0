Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B0C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:11:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F02F2078B
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 20:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F02F2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 03891864D6;
	Tue,  1 Sep 2020 20:11:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y28XZ3HkJ7iw; Tue,  1 Sep 2020 20:11:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0814C864EC;
	Tue,  1 Sep 2020 20:11:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9547C07FF;
	Tue,  1 Sep 2020 20:11:41 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 45742C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:11:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 345B886F6D
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V-+0qtlQY9EH for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 20:11:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 020A086EC8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 20:11:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6F28D1FB;
 Tue,  1 Sep 2020 13:11:39 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73CC33F66F;
 Tue,  1 Sep 2020 13:11:37 -0700 (PDT)
Subject: Re: [PATCH v9 18/32] drm: tegra: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063538eucas1p2a9fe42c2ccee634c41ba9f3dd43dc3c4@eucas1p2.samsung.com>
 <20200826063316.23486-19-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <35eb8693-9fee-1fd7-d6ae-a8f3e0d263d7@arm.com>
Date: Tue, 1 Sep 2020 21:11:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-19-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-tegra@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
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

On 2020-08-26 07:33, Marek Szyprowski wrote:
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

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/tegra/gem.c   | 27 ++++++++++-----------------
>   drivers/gpu/drm/tegra/plane.c | 15 +++++----------
>   2 files changed, 15 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index 723df142a981..01d94befab11 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -98,8 +98,8 @@ static struct sg_table *tegra_bo_pin(struct device *dev, struct host1x_bo *bo,
>   		 * the SG table needs to be copied to avoid overwriting any
>   		 * other potential users of the original SG table.
>   		 */
> -		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl, obj->sgt->nents,
> -					     GFP_KERNEL);
> +		err = sg_alloc_table_from_sg(sgt, obj->sgt->sgl,
> +					     obj->sgt->orig_nents, GFP_KERNEL);
>   		if (err < 0)
>   			goto free;
>   	} else {
> @@ -196,8 +196,7 @@ static int tegra_bo_iommu_map(struct tegra_drm *tegra, struct tegra_bo *bo)
>   
>   	bo->iova = bo->mm->start;
>   
> -	bo->size = iommu_map_sg(tegra->domain, bo->iova, bo->sgt->sgl,
> -				bo->sgt->nents, prot);
> +	bo->size = iommu_map_sgtable(tegra->domain, bo->iova, bo->sgt, prot);
>   	if (!bo->size) {
>   		dev_err(tegra->drm->dev, "failed to map buffer\n");
>   		err = -ENOMEM;
> @@ -264,8 +263,7 @@ static struct tegra_bo *tegra_bo_alloc_object(struct drm_device *drm,
>   static void tegra_bo_free(struct drm_device *drm, struct tegra_bo *bo)
>   {
>   	if (bo->pages) {
> -		dma_unmap_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
> -			     DMA_FROM_DEVICE);
> +		dma_unmap_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
>   		drm_gem_put_pages(&bo->gem, bo->pages, true, true);
>   		sg_free_table(bo->sgt);
>   		kfree(bo->sgt);
> @@ -290,12 +288,9 @@ static int tegra_bo_get_pages(struct drm_device *drm, struct tegra_bo *bo)
>   		goto put_pages;
>   	}
>   
> -	err = dma_map_sg(drm->dev, bo->sgt->sgl, bo->sgt->nents,
> -			 DMA_FROM_DEVICE);
> -	if (err == 0) {
> -		err = -EFAULT;
> +	err = dma_map_sgtable(drm->dev, bo->sgt, DMA_FROM_DEVICE, 0);
> +	if (err)
>   		goto free_sgt;
> -	}
>   
>   	return 0;
>   
> @@ -571,7 +566,7 @@ tegra_gem_prime_map_dma_buf(struct dma_buf_attachment *attach,
>   			goto free;
>   	}
>   
> -	if (dma_map_sg(attach->dev, sgt->sgl, sgt->nents, dir) == 0)
> +	if (dma_map_sgtable(attach->dev, sgt, dir, 0))
>   		goto free;
>   
>   	return sgt;
> @@ -590,7 +585,7 @@ static void tegra_gem_prime_unmap_dma_buf(struct dma_buf_attachment *attach,
>   	struct tegra_bo *bo = to_tegra_bo(gem);
>   
>   	if (bo->pages)
> -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> +		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>   
>   	sg_free_table(sgt);
>   	kfree(sgt);
> @@ -609,8 +604,7 @@ static int tegra_gem_prime_begin_cpu_access(struct dma_buf *buf,
>   	struct drm_device *drm = gem->dev;
>   
>   	if (bo->pages)
> -		dma_sync_sg_for_cpu(drm->dev, bo->sgt->sgl, bo->sgt->nents,
> -				    DMA_FROM_DEVICE);
> +		dma_sync_sgtable_for_cpu(drm->dev, bo->sgt, DMA_FROM_DEVICE);
>   
>   	return 0;
>   }
> @@ -623,8 +617,7 @@ static int tegra_gem_prime_end_cpu_access(struct dma_buf *buf,
>   	struct drm_device *drm = gem->dev;
>   
>   	if (bo->pages)
> -		dma_sync_sg_for_device(drm->dev, bo->sgt->sgl, bo->sgt->nents,
> -				       DMA_TO_DEVICE);
> +		dma_sync_sgtable_for_device(drm->dev, bo->sgt, DMA_TO_DEVICE);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.c
> index 4cd0461cc508..539d14935728 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -131,12 +131,9 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
>   		}
>   
>   		if (sgt) {
> -			err = dma_map_sg(dc->dev, sgt->sgl, sgt->nents,
> -					 DMA_TO_DEVICE);
> -			if (err == 0) {
> -				err = -ENOMEM;
> +			err = dma_map_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
> +			if (err)
>   				goto unpin;
> -			}
>   
>   			/*
>   			 * The display controller needs contiguous memory, so
> @@ -144,7 +141,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
>   			 * map its SG table to a single contiguous chunk of
>   			 * I/O virtual memory.
>   			 */
> -			if (err > 1) {
> +			if (sgt->nents > 1) {
>   				err = -EINVAL;
>   				goto unpin;
>   			}
> @@ -166,8 +163,7 @@ static int tegra_dc_pin(struct tegra_dc *dc, struct tegra_plane_state *state)
>   		struct sg_table *sgt = state->sgt[i];
>   
>   		if (sgt)
> -			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
> -				     DMA_TO_DEVICE);
> +			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
>   
>   		host1x_bo_unpin(dc->dev, &bo->base, sgt);
>   		state->iova[i] = DMA_MAPPING_ERROR;
> @@ -186,8 +182,7 @@ static void tegra_dc_unpin(struct tegra_dc *dc, struct tegra_plane_state *state)
>   		struct sg_table *sgt = state->sgt[i];
>   
>   		if (sgt)
> -			dma_unmap_sg(dc->dev, sgt->sgl, sgt->nents,
> -				     DMA_TO_DEVICE);
> +			dma_unmap_sgtable(dc->dev, sgt, DMA_TO_DEVICE, 0);
>   
>   		host1x_bo_unpin(dc->dev, &bo->base, sgt);
>   		state->iova[i] = DMA_MAPPING_ERROR;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
