Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B17C433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:33:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6258C2087D
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6258C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 41C9A85BD3;
	Tue,  1 Sep 2020 19:33:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fqva_ip55F9U; Tue,  1 Sep 2020 19:33:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 769C185082;
	Tue,  1 Sep 2020 19:33:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5BB99C07FF;
	Tue,  1 Sep 2020 19:33:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A82A0C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:33:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 81A1120425
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:33:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZ3-cfdFMwAD for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 19:33:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 3FBA9204FD
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:33:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67D051FB;
 Tue,  1 Sep 2020 12:33:32 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ABCE13F71F;
 Tue,  1 Sep 2020 12:33:30 -0700 (PDT)
Subject: Re: [PATCH v9 14/32] drm: omapdrm: fix common struct sg_table related
 issues
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063536eucas1p2e29d2b061b8b74c06c9ea61ad6737ba2@eucas1p2.samsung.com>
 <20200826063316.23486-15-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7298cc55-c550-0b41-3f3c-8eebed845848@arm.com>
Date: Tue, 1 Sep 2020 20:33:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-15-m.szyprowski@samsung.com>
Content-Language: en-GB
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Daniel Vetter <daniel@ffwll.ch>, Christoph Hellwig <hch@lst.de>,
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
> Fix the code to refer to proper nents or orig_nents entries. This driver
> checks for a buffer contiguity in DMA address space, so it should test
> sg_table->nents entry.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_gem.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
> index ff0c4b0c3fd0..a7a9a0afe2b6 100644
> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
> @@ -48,7 +48,7 @@ struct omap_gem_object {
>   	 *   OMAP_BO_MEM_DMA_API flag set)
>   	 *
>   	 * - buffers imported from dmabuf (with the OMAP_BO_MEM_DMABUF flag set)
> -	 *   if they are physically contiguous (when sgt->orig_nents == 1)
> +	 *   if they are physically contiguous (when sgt->nents == 1)

Hmm, if this really does mean *physically* contiguous - i.e. if buffers 
might be shared between DMA-translatable and non-DMA-translatable 
devices - then these changes might not be appropriate. If not and it 
only actually means DMA-contiguous, then it would be good to clarify the 
comments to that effect.

Can anyone familiar with omapdrm clarify what exactly the case is here? 
I know that IOMMUs might be involved to some degree, and I've skimmed 
the interconnect chapters of enough OMAP TRMs to be scared by the 
reference to the tiler aperture in the context below :)

Robin.

>   	 *
>   	 * - buffers mapped through the TILER when dma_addr_cnt is not zero, in
>   	 *   which case the DMA address points to the TILER aperture
> @@ -1279,7 +1279,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   	union omap_gem_size gsize;
>   
>   	/* Without a DMM only physically contiguous buffers can be supported. */
> -	if (sgt->orig_nents != 1 && !priv->has_dmm)
> +	if (sgt->nents != 1 && !priv->has_dmm)
>   		return ERR_PTR(-EINVAL);
>   
>   	gsize.bytes = PAGE_ALIGN(size);
> @@ -1293,7 +1293,7 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   
>   	omap_obj->sgt = sgt;
>   
> -	if (sgt->orig_nents == 1) {
> +	if (sgt->nents == 1) {
>   		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
>   	} else {
>   		/* Create pages list from sgt */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
