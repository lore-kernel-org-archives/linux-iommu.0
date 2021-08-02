Return-Path: <SRS0=vo+x=MZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25976C4338F
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:54:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE3AD61165
	for <iommu@archiver.kernel.org>; Mon,  2 Aug 2021 13:54:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE3AD61165
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93D0C8322E;
	Mon,  2 Aug 2021 13:54:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kUatbLoFRfm9; Mon,  2 Aug 2021 13:54:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7F875831F8;
	Mon,  2 Aug 2021 13:54:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F559C0010;
	Mon,  2 Aug 2021 13:54:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC8F9C000E
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:54:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AC1FE40249
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:54:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4jezkpRDjrNa for <iommu@lists.linux-foundation.org>;
 Mon,  2 Aug 2021 13:54:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F7774022C
 for <iommu@lists.linux-foundation.org>; Mon,  2 Aug 2021 13:54:51 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9D13161155;
 Mon,  2 Aug 2021 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627912490;
 bh=ffsZcqleS2Msj4hKWIBmJ4DPBk3NI1GngO6NeU0SeTU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VtSmunYUXbIIrXS3l/nVkmZXkowH6vo/7g7EKVHyGGAP/bs4NpsweEv1bYURFTDYP
 hPZkudv6Q+a1gVJLvSugGrJCXJGILZJXjQzxFBTiIxO+EwtizHV5Ph4vUtdeyue8i9
 dkMBvitTmr3l0I5+q7p3nWeLK1b9uacCWjCeefWIm0rWNNa/2bRiT4DpgiNkpZkaKH
 uAJrliut8ve2C7rQIIMqyP5sSiyd+sOv9LtAQruboXcyd32Tn6PLVeBXRY3Ob2RSc8
 n/n92HXPgxrkA9a9JptQmeZKFf4CSCofpomOhAAx+xF4xqHHhJZHAVliePCKrTO2Nf
 6KwI1rx3CS2ag==
Date: Mon, 2 Aug 2021 14:54:46 +0100
From: Will Deacon <will@kernel.org>
To: David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH v2 3/4] dma-iommu: pass SKIP_CPU_SYNC to swiotlb unmap
Message-ID: <20210802135446.GE28547@willie-the-truck>
References: <20210709033502.3545820-1-stevensd@google.com>
 <20210709033502.3545820-4-stevensd@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210709033502.3545820-4-stevensd@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Fri, Jul 09, 2021 at 12:35:01PM +0900, David Stevens wrote:
> From: David Stevens <stevensd@chromium.org>
> 
> If SKIP_CPU_SYNC isn't already set, then iommu_dma_unmap_(page|sg) has
> already called iommu_dma_sync_(single|sg)_for_cpu, so there is no need
> to copy from the bounce buffer again.
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  drivers/iommu/dma-iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index e79e274d2dc5..0a9a9a343e64 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -505,7 +505,8 @@ static void __iommu_dma_unmap_swiotlb(struct device *dev, dma_addr_t dma_addr,
>  	__iommu_dma_unmap(dev, dma_addr, size);
>  
>  	if (unlikely(is_swiotlb_buffer(phys)))
> -		swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> +		swiotlb_tbl_unmap_single(dev, phys, size, dir,
> +					 attrs | DMA_ATTR_SKIP_CPU_SYNC);
>  }

I think it would be cleaner to drop DMA_ATTR_SKIP_CPU_SYNC in the callers
once they've called iommu_dma_sync_*_for_cpu().

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
