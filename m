Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D73C54E4A
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 12:18:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1BC206F5
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 12:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1BC206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 39B3987261;
	Tue, 12 May 2020 12:18:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 937AjWR3oSIT; Tue, 12 May 2020 12:18:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 54D3A86CD7;
	Tue, 12 May 2020 12:18:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2CFBBC0178;
	Tue, 12 May 2020 12:18:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14573C016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 12:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 03B1488291
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 12:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sZ54q50ZdkKs for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 12:18:13 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6363088246
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 12:18:13 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8F23F68BEB; Tue, 12 May 2020 14:18:08 +0200 (CEST)
Date: Tue, 12 May 2020 14:18:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v4 01/38] dma-mapping: add generic helpers for mapping
 sgtable objects
Message-ID: <20200512121808.GA20393@lst.de>
References: <20200512085710.14688-1-m.szyprowski@samsung.com>
 <CGME20200512090107eucas1p13a38ce5ce4c15cd0033acaea7b26c9b0@eucas1p1.samsung.com>
 <20200512090058.14910-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200512090058.14910-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 iommu@lists.linux-foundation.org, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue, May 12, 2020 at 11:00:21AM +0200, Marek Szyprowski wrote:
> struct sg_table is a common structure used for describing a memory
> buffer. It consists of a scatterlist with memory pages and DMA addresses
> (sgl entry), as well as the number of scatterlist entries: CPU pages
> (orig_nents entry) and DMA mapped pages (nents entry).
> 
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg
> function.
> 
> To avoid such issues, lets introduce a common wrappers operating directly
> on the struct sg_table objects, which take care of the proper use of
> the nents and orig_nents entries.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> For more information, see '[PATCH v4 00/38] DRM: fix struct sg_table nents
> vs. orig_nents misuse' thread:
> https://lore.kernel.org/dri-devel/20200512085710.14688-1-m.szyprowski@samsung.com/T/
> ---
>  include/linux/dma-mapping.h | 79 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index b43116a..88f01cc 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -609,6 +609,85 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
>  	return dma_sync_single_for_device(dev, addr + offset, size, dir);
>  }
>  
> +/**
> + * dma_map_sgtable - Map the given buffer for the DMA operations
> + * @dev:	The device to perform a DMA operation
> + * @sgt:	The sg_table object describing the buffer
> + * @dir:	DMA direction
> + * @attrs:	Optional DMA attributes for the map operation
> + *
> + * Maps a buffer described by a scatterlist stored in the given sg_table
> + * object for the @dir DMA operation by the @dev device. After success
> + * the ownership for the buffer is transferred to the DMA domain. One has
> + * to call dma_sync_sgtable_for_cpu() or dma_unmap_sgtable() to move the
> + * ownership of the buffer back to the CPU domain before touching the
> + * buffer by the CPU.
> + * Returns 0 on success or -EINVAL on error during mapping the buffer.
> + */
> +static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int n = dma_map_sg_attrs(dev, sgt->sgl, sgt->orig_nents, dir, attrs);
> +
> +	if (n > 0) {
> +		sgt->nents = n;
> +		return 0;
> +	}
> +	return -EINVAL;

Nit:  code tend to be a tad easier to read if the the exceptional
condition is inside the branch block, so:

	if (n <= 0)
		return -EINVAL;
	sgt->nents = n;
	return 0;

Otherwise this looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
