Return-Path: <SRS0=mUms=NC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA8C4338F
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 06:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2FB860F55
	for <iommu@archiver.kernel.org>; Wed, 11 Aug 2021 06:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2FB860F55
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ACDA404B2;
	Wed, 11 Aug 2021 06:08:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uPjePptvq8X2; Wed, 11 Aug 2021 06:08:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EDADE4038A;
	Wed, 11 Aug 2021 06:08:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6C11C001A;
	Wed, 11 Aug 2021 06:08:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD10C000E
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:08:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B8D6404B2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:08:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Z-p5m-Uu5c_T for <iommu@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 06:08:17 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4E60B40213
 for <iommu@lists.linux-foundation.org>; Wed, 11 Aug 2021 06:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ho6/AeZ5c1e6H7tCddsJ5x23ZKaDp8UDRhTSPgHPvu0=; b=cZJRapbbrIvpgLvOp7/1uAXVx5
 dUxcxMYN8KjE8/1aIb4A1gTXnPj/PCrV39losPl6E2htv9/fydbXUf/YByRpUt3Gxxmzwo86jmo7+
 f8/Fk0dONTrPS8qOO9ogUq9y3ZQy4P+hn/BJ3ZeudBRF9l+cMu2AD82AlwSSMs0ju2mixWhnMbyU3
 jxO8eMH97woKOLErPaAXI5dt7g635pg0SXEQcjEvJE5wwmu8CJPfuKI8KlG6lYScP490vN8rugRDx
 +zNFkOXyjv6tAJitWfjSzsmHjN13O3Pd0lwwJx4xn5Eh/pVLL/vDznokXwU+5wPRbvNqOuhsV22cE
 N82GXKbg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1mDhOf-00D2xK-2R; Wed, 11 Aug 2021 06:07:33 +0000
Date: Wed, 11 Aug 2021 07:07:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v3 3/5] dma-iommu: add SKIP_CPU_SYNC after syncing
Message-ID: <YRNpHcskc0Vv1ofa@infradead.org>
References: <20210811024247.1144246-1-stevensd@google.com>
 <20210811024247.1144246-4-stevensd@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210811024247.1144246-4-stevensd@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Tom Murphy <murphyt7@tcd.ie>
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

> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 4f0cc4a0a61f..be0214b1455c 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -859,8 +859,11 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
>  static void iommu_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> +	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>  		iommu_dma_sync_single_for_cpu(dev, dma_handle, size, dir);
> +		attrs |= DMA_ATTR_SKIP_CPU_SYNC;
> +	}
> +
>  	__iommu_dma_unmap_swiotlb(dev, dma_handle, size, dir, attrs);

I don't think this is the correct way to go.  Instead just call the
raw cache sync helper instead of iommu_dma_sync_single_for_cpu, similar
to what dma-direct does.  Same for the map side.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
