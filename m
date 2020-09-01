Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95B2C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:17:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F7C820767
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 19:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F7C820767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 607DD86542;
	Tue,  1 Sep 2020 19:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FliVtnQ81xwc; Tue,  1 Sep 2020 19:17:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AEC07861F0;
	Tue,  1 Sep 2020 19:17:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93141C07FF;
	Tue,  1 Sep 2020 19:17:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4A1BEC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:17:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 38C65870EE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:17:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2B6-7U0iDVxa for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 19:17:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6F623870E8
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 19:17:22 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0A3B1FB;
 Tue,  1 Sep 2020 12:17:21 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EC9D3F71F;
 Tue,  1 Sep 2020 12:17:20 -0700 (PDT)
Subject: Re: [PATCH v9 13/32] drm: omapdrm: use common helper for extracting
 pages array
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063535eucas1p1a98e3295a64f14d475371ac0b003782f@eucas1p1.samsung.com>
 <20200826063316.23486-14-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f1474b67-eca5-d115-82a6-e7e74cccaf9f@arm.com>
Date: Tue, 1 Sep 2020 20:17:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-14-m.szyprowski@samsung.com>
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
> Use common helper for converting a sg_table object into struct
> page pointer array.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>   drivers/gpu/drm/omapdrm/omap_gem.c | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
> index d0d12d5dd76c..ff0c4b0c3fd0 100644
> --- a/drivers/gpu/drm/omapdrm/omap_gem.c
> +++ b/drivers/gpu/drm/omapdrm/omap_gem.c
> @@ -1297,10 +1297,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   		omap_obj->dma_addr = sg_dma_address(sgt->sgl);
>   	} else {
>   		/* Create pages list from sgt */
> -		struct sg_page_iter iter;
>   		struct page **pages;
>   		unsigned int npages;
> -		unsigned int i = 0;
> +		unsigned int ret;
>   
>   		npages = DIV_ROUND_UP(size, PAGE_SIZE);
>   		pages = kcalloc(npages, sizeof(*pages), GFP_KERNEL);
> @@ -1311,14 +1310,9 @@ struct drm_gem_object *omap_gem_new_dmabuf(struct drm_device *dev, size_t size,
>   		}
>   
>   		omap_obj->pages = pages;
> -
> -		for_each_sg_page(sgt->sgl, &iter, sgt->orig_nents, 0) {
> -			pages[i++] = sg_page_iter_page(&iter);
> -			if (i > npages)
> -				break;
> -		}
> -
> -		if (WARN_ON(i != npages)) {
> +		ret = drm_prime_sg_to_page_addr_arrays(sgt, pages, NULL,
> +						       npages);
> +		if (WARN_ON(ret)) {

Again, I'm inclined to think the WARN_ON should remain in 
drm_prime_sg_to_page_addr_arrays() itself such that it could be removed 
here, but either way,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

>   			omap_gem_free_object(obj);
>   			obj = ERR_PTR(-ENOMEM);
>   			goto done;
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
