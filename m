Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E8C433E6
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825B2087D
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 17:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825B2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 813011FEED;
	Tue,  1 Sep 2020 17:24:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MxY3Bc41VKY; Tue,  1 Sep 2020 17:24:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2FDE71FE0A;
	Tue,  1 Sep 2020 17:24:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1AC7FC07FF;
	Tue,  1 Sep 2020 17:24:24 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A22F2C0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:24:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9148D870AE
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:24:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lekefWORbBcS for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 17:24:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id B15ED870A0
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 17:24:21 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 266601FB;
 Tue,  1 Sep 2020 10:24:21 -0700 (PDT)
Received: from [10.57.40.122] (unknown [10.57.40.122])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F3B3F71F;
 Tue,  1 Sep 2020 10:24:18 -0700 (PDT)
Subject: Re: [PATCH v9 02/32] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20200826063316.23486-1-m.szyprowski@samsung.com>
 <CGME20200826063528eucas1p1502c849c0fd337245541e1b31352d87f@eucas1p1.samsung.com>
 <20200826063316.23486-3-m.szyprowski@samsung.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <484582f2-b027-8406-b6ff-f50c0d1ba7b0@arm.com>
Date: Tue, 1 Sep 2020 18:24:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200826063316.23486-3-m.szyprowski@samsung.com>
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
> Replace the current hand-crafted code for extracting pages and DMA
> addresses from the given scatterlist by the much more robust
> code based on the generic scatterlist iterators and recently
> introduced sg_table-based wrappers. The resulting code is simple and
> easy to understand, so the comment describing the old code is no
> longer needed.

Is removing the WARN_ON()s intentional? It certainly seems like it would 
be a genuine driver bug if the caller asked for addresses but didn't 
allocate appropriately-sized arrays. Might be worth noting either way. 
I'm also assuming this isn't called in performance-critical paths with 
massive lists such that the two separate iterations might have a 
noticeable impact.

Nits aside,

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>   drivers/gpu/drm/drm_prime.c | 49 ++++++++++++-------------------------
>   1 file changed, 15 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 4ed5ed1f078c..5d181bf60a44 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -990,45 +990,26 @@ EXPORT_SYMBOL(drm_gem_prime_import);
>   int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>   				     dma_addr_t *addrs, int max_entries)
>   {
> -	unsigned count;
> -	struct scatterlist *sg;
> -	struct page *page;
> -	u32 page_len, page_index;
> -	dma_addr_t addr;
> -	u32 dma_len, dma_index;
> -
> -	/*
> -	 * Scatterlist elements contains both pages and DMA addresses, but
> -	 * one shoud not assume 1:1 relation between them. The sg->length is
> -	 * the size of the physical memory chunk described by the sg->page,
> -	 * while sg_dma_len(sg) is the size of the DMA (IO virtual) chunk
> -	 * described by the sg_dma_address(sg).
> -	 */
> -	page_index = 0;
> -	dma_index = 0;
> -	for_each_sg(sgt->sgl, sg, sgt->nents, count) {
> -		page_len = sg->length;
> -		page = sg_page(sg);
> -		dma_len = sg_dma_len(sg);
> -		addr = sg_dma_address(sg);
> -
> -		while (pages && page_len > 0) {
> -			if (WARN_ON(page_index >= max_entries))
> +	struct sg_dma_page_iter dma_iter;
> +	struct sg_page_iter page_iter;
> +	struct page **p = pages;
> +	dma_addr_t *a = addrs;
> +
> +	if (pages) {
> +		for_each_sgtable_page(sgt, &page_iter, 0) {
> +			if (p - pages >= max_entries)
>   				return -1;
> -			pages[page_index] = page;
> -			page++;
> -			page_len -= PAGE_SIZE;
> -			page_index++;
> +			*p++ = sg_page_iter_page(&page_iter);
>   		}
> -		while (addrs && dma_len > 0) {
> -			if (WARN_ON(dma_index >= max_entries))
> +	}
> +	if (addrs) {
> +		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +			if (a - addrs >= max_entries)
>   				return -1;
> -			addrs[dma_index] = addr;
> -			addr += PAGE_SIZE;
> -			dma_len -= PAGE_SIZE;
> -			dma_index++;
> +			*a++ = sg_page_iter_dma_address(&dma_iter);
>   		}
>   	}
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
