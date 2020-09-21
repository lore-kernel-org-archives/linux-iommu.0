Return-Path: <SRS0=nwur=C6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92DCC4727D
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 23:36:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B43B23A6B
	for <iommu@archiver.kernel.org>; Mon, 21 Sep 2020 23:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rf6FnvPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B43B23A6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C5C4C864E0;
	Mon, 21 Sep 2020 23:36:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cLCa7AXd3EjY; Mon, 21 Sep 2020 23:36:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id AEC81864E5;
	Mon, 21 Sep 2020 23:36:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98960C0889;
	Mon, 21 Sep 2020 23:36:46 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65953C0051
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 23:15:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 52F3C86499
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 23:15:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TkI-sWaVDsxZ for <iommu@lists.linux-foundation.org>;
 Mon, 21 Sep 2020 23:15:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from hqnvemgate25.nvidia.com (hqnvemgate25.nvidia.com
 [216.228.121.64])
 by whitealder.osuosl.org (Postfix) with ESMTPS id BD29D860CD
 for <iommu@lists.linux-foundation.org>; Mon, 21 Sep 2020 23:15:34 +0000 (UTC)
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B5f6933e80000>; Mon, 21 Sep 2020 16:14:48 -0700
Received: from [10.20.170.18] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 21 Sep
 2020 23:15:23 +0000
Date: Mon, 21 Sep 2020 18:15:20 -0500
From: Alex Goins <agoins@nvidia.com>
X-X-Sender: agoins@agoins-DiGiTS
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v5 05/38] drm: prime: use sgtable iterators in
 drm_prime_sg_to_page_addr_arrays()
In-Reply-To: <20200513133245.6408-5-m.szyprowski@samsung.com>
Message-ID: <alpine.DEB.2.20.2009211803580.19454@agoins-DiGiTS>
References: <20200513132114.6046-1-m.szyprowski@samsung.com>
 <20200513133245.6408-1-m.szyprowski@samsung.com>
 <CGME20200513133259eucas1p273f0e05005b7b1158d884295d35745fd@eucas1p2.samsung.com>
 <20200513133245.6408-5-m.szyprowski@samsung.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-NVConfidentiality: public
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1600730088; bh=66tErcQJxEuwrDfkE9u3WIgJy30Uod3BawGWzkjWP5A=;
 h=Date:From:X-X-Sender:To:CC:Subject:In-Reply-To:Message-ID:
 References:User-Agent:X-NVConfidentiality:MIME-Version:
 Content-Type:X-Originating-IP:X-ClientProxiedBy;
 b=rf6FnvPj/RQ6DhhRn2zM91taxS0SC2vW4kcTfvTh8k4ZjT7BzbxVevFz9dZdg+bGC
 j++tgTstP46mOWpfr5idvoNya016BR2T5Hxi7VeCQWSY0Xt4R1/nApLt4HjVHrziU3
 J3tOIvaJrPtq5Mgwzgw7Gw9Tb07hp/UHg2mXB8OH2JDvjWMPQzJRHGQEvsod/fKBrC
 EvatL0nW8wWVYFpVQNFKkan8SkpbOcKZV2ip9BmiN/XZzag6NdJrm48UOOvhT8qGFL
 ke3jjODO+LybTUa+aMMhEcqoxlC0LAJaGnW/41logx+zupgnipBi5umEKbtF2A0HRj
 xeZg1nGkTElAw==
X-Mailman-Approved-At: Mon, 21 Sep 2020 23:36:45 +0000
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Robin Murphy <robin.murphy@arm.com>,
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

Tested-by: Alex Goins <agoins@nvidia.com>

This change fixes a regression with drm_prime_sg_to_page_addr_arrays() and
AMDGPU in v5.9.

Commit 39913934 similarly revamped AMDGPU to use sgtable helper functions. When
it changed from dma_map_sg_attrs() to dma_map_sgtable(), as a side effect it
started correctly updating sgt->nents to the return value of dma_map_sg_attrs().
However, drm_prime_sg_to_page_addr_arrays() incorrectly uses sgt->nents to
iterate over pages, rather than sgt->orig_nents, resulting in it now returning
the incorrect number of pages on AMDGPU.

I had written a patch that changes drm_prime_sg_to_page_addr_arrays() to use
for_each_sgtable_sg() instead of for_each_sg(), iterating using sgt->orig_nents:

-       for_each_sg(sgt->sgl, sg, sgt->nents, count) {
+       for_each_sgtable_sg(sgt, sg, count) {

This patch takes it further, but still has the effect of fixing the number of
pages that drm_prime_sg_to_page_addr_arrays() returns. Something like this
should be included in v5.9 to prevent a regression with AMDGPU.

Thanks,
Alex

On Wed, 13 May 2020, Marek Szyprowski wrote:

> Replace the current hand-crafted code for extracting pages and DMA
> addresses from the given scatterlist by the much more robust
> code based on the generic scatterlist iterators and recently
> introduced sg_table-based wrappers. The resulting code is simple and
> easy to understand, so the comment describing the old code is no
> longer needed.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v5 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/linux-iommu/20200513132114.6046-1-m.szyprowski@samsung.com/T/
> ---
>  drivers/gpu/drm/drm_prime.c | 47 ++++++++++++++-------------------------------
>  1 file changed, 14 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 1d2e5fe..dfdf4d4 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -985,45 +985,26 @@ struct drm_gem_object *drm_gem_prime_import(struct drm_device *dev,
>  int drm_prime_sg_to_page_addr_arrays(struct sg_table *sgt, struct page **pages,
>  				     dma_addr_t *addrs, int max_entries)
>  {
> -	unsigned count;
> -	struct scatterlist *sg;
> -	struct page *page;
> -	u32 page_len, page_index;
> -	dma_addr_t addr;
> -	u32 dma_len, dma_index;
> +	struct sg_dma_page_iter dma_iter;
> +	struct sg_page_iter page_iter;
> +	struct page **p = pages;
> +	dma_addr_t *a = addrs;
>  
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
> +	if (pages) {
> +		for_each_sgtable_page(sgt, &page_iter, 0) {
> +			if (p - pages >= max_entries)
>  				return -1;
> -			pages[page_index] = page;
> -			page++;
> -			page_len -= PAGE_SIZE;
> -			page_index++;
> +			*p++ = sg_page_iter_page(&page_iter);
>  		}
> -		while (addrs && dma_len > 0) {
> -			if (WARN_ON(dma_index >= max_entries))
> +	}
> +	if (addrs) {
> +		for_each_sgtable_dma_page(sgt, &dma_iter, 0) {
> +			if (a - addrs >= max_entries)
>  				return -1;
> -			addrs[dma_index] = addr;
> -			addr += PAGE_SIZE;
> -			dma_len -= PAGE_SIZE;
> -			dma_index++;
> +			*a++ = sg_page_iter_dma_address(&dma_iter);
>  		}
>  	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL(drm_prime_sg_to_page_addr_arrays);
> -- 
> 1.9.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
