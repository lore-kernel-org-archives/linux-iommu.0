Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF70C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:14:37 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7ED9C20767
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7ED9C20767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4F68386C75;
	Tue,  1 Sep 2020 19:14:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iE+-O7KZ5BCR; Tue,  1 Sep 2020 19:14:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3BE0C86C66;
	Tue,  1 Sep 2020 19:14:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 203F8C07FF;
	Tue,  1 Sep 2020 19:14:36 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 275C3C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:14:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 1991786C6F
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:14:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7dOYBaL2Vth7 for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 19:14:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8CB3386C66
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:14:32 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F21C51FB;
 Tue,  1 Sep 2020 12:14:31 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4A93F71F;
 Tue,  1 Sep 2020 12:14:29 -0700 (PDT)
Subject: Re: [PATCH v9 12/32] drm: msm: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063535eucas1p10cef37d8364216cf57c97e96d3959dd2@eucas1p1.samsung.com>
 <20200826063316.23486-13-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <fe224152-b621-d96e-b432-bf837d320210@arm.com>
Date: Tue, 1 Sep 2020 20:14:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-13-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: freedreno@lists.freedesktop.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>,
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
> Acked-by: Rob Clark <robdclark@gmail.com>
> ---
>   drivers/gpu/drm/msm/msm_gem.c    | 13 +++++--------
>   drivers/gpu/drm/msm/msm_gpummu.c | 14 ++++++--------
>   drivers/gpu/drm/msm/msm_iommu.c  |  2 +-
>   3 files changed, 12 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index b2f49152b4d4..8c7ae812b813 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -53,11 +53,10 @@ static void sync_for_device(struct msm_gem_object *msm_obj)
>   	struct device *dev = msm_obj->base.dev->dev;
>   
>   	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
> -		dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
> -			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_sync_sgtable_for_device(dev, msm_obj->sgt,
> +					    DMA_BIDIRECTIONAL);
>   	} else {
> -		dma_map_sg(dev, msm_obj->sgt->sgl,
> -			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
>   	}
>   }
>   
> @@ -66,11 +65,9 @@ static void sync_for_cpu(struct msm_gem_object *msm_obj)
>   	struct device *dev = msm_obj->base.dev->dev;
>   
>   	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
> -		dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
> -			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_sync_sgtable_for_cpu(dev, msm_obj->sgt, DMA_BIDIRECTIONAL);
>   	} else {
> -		dma_unmap_sg(dev, msm_obj->sgt->sgl,
> -			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
> +		dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
>   	}
>   }
>   
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index 310a31b05faa..319f06c28235 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -30,21 +30,19 @@ static int msm_gpummu_map(struct msm_mmu *mmu, uint64_t iova,
>   {
>   	struct msm_gpummu *gpummu = to_msm_gpummu(mmu);
>   	unsigned idx = (iova - GPUMMU_VA_START) / GPUMMU_PAGE_SIZE;
> -	struct scatterlist *sg;
> +	struct sg_dma_page_iter dma_iter;
>   	unsigned prot_bits = 0;
> -	unsigned i, j;
>   
>   	if (prot & IOMMU_WRITE)
>   		prot_bits |= 1;
>   	if (prot & IOMMU_READ)
>   		prot_bits |= 2;
>   
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> -		dma_addr_t addr = sg->dma_address;
> -		for (j = 0; j < sg->length / GPUMMU_PAGE_SIZE; j++, idx++) {
> -			gpummu->table[idx] = addr | prot_bits;
> -			addr += GPUMMU_PAGE_SIZE;
> -		}
> +	for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +		dma_addr_t addr = sg_page_iter_dma_address(&dma_iter);
> +
> +		BUILD_BUG_ON(GPUMMU_PAGE_SIZE != PAGE_SIZE);
> +		gpummu->table[idx++] = addr | prot_bits;

Given that the BUILD_BUG_ON might prevent valid arm64 configs from 
building, how about a simple tweak like:

		for (i = 0; i < PAGE_SIZE; i += GPUMMU_PAGE_SIZE)
			gpummu->table[idx++] = i + addr | prot_bits;
?

Or alternatively perhaps some more aggressive #ifdefs or makefile tweaks 
to prevent the GPUMMU code building for arm64 at all if it's only 
relevant to 32-bit platforms (which I believe might be the case).

Robin.

>   	}
>   
>   	/* we can improve by deferring flush for multiple map() */
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 3a381a9674c9..6c31e65834c6 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -36,7 +36,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>   	struct msm_iommu *iommu = to_msm_iommu(mmu);
>   	size_t ret;
>   
> -	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
> +	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
>   	WARN_ON(!ret);
>   
>   	return (ret == len) ? 0 : -EINVAL;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
