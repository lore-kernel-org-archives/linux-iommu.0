Return-Path: <SRS0=BbwH=5W=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21670C2BA19
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 13:48:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0B7523341
	for <iommu@archiver.kernel.org>; Mon,  6 Apr 2020 13:48:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0B7523341
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9F024882BE;
	Mon,  6 Apr 2020 13:48:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6okChyFajdM2; Mon,  6 Apr 2020 13:48:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 414E18829F;
	Mon,  6 Apr 2020 13:48:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20D8EC1AE2;
	Mon,  6 Apr 2020 13:48:19 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 98578C0177
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9098086027
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:48:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zU4bBRxUv_BD for <iommu@lists.linux-foundation.org>;
 Mon,  6 Apr 2020 13:48:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id B3FA685FE6
 for <iommu@lists.linux-foundation.org>; Mon,  6 Apr 2020 13:48:16 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E289106F;
 Mon,  6 Apr 2020 06:48:16 -0700 (PDT)
Received: from [10.57.55.221] (unknown [10.57.55.221])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 309FB3F73D;
 Mon,  6 Apr 2020 06:48:15 -0700 (PDT)
Subject: Re: [RFC/RFT][PATCH] dma-mapping: set default segment_boundary_mask
 to ULONG_MAX
To: Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com, hch@lst.de
References: <20200405005157.1318-1-nicoleotsuka@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <c984d2ea-6036-a8ae-97df-b5178a2a9ab9@arm.com>
Date: Mon, 6 Apr 2020 14:48:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405005157.1318-1-nicoleotsuka@gmail.com>
Content-Language: en-GB
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 2020-04-05 1:51 am, Nicolin Chen wrote:
> The default segment_boundary_mask was set to DMA_BIT_MAKS(32)
> a decade ago by referencing SCSI/block subsystem, as a 32-bit
> mask was good enough for most of the devices.
> 
> Now more and more drivers set dma_masks above DMA_BIT_MAKS(32)
> while only a handful of them call dma_set_seg_boundary(). This
> means that most drivers have a 4GB segmention boundary because
> DMA API returns a 32-bit default value, though they might not
> really have such a limit.
> 
> The default segment_boundary_mask should mean "no limit" since
> the device doesn't explicitly set the mask. But a 32-bit mask
> certainly limits those devices capable of 32+ bits addressing.
> 
> And this 32-bit boundary mask might result in a situation that
> when dma-iommu maps a DMA buffer (size > 4GB), iommu_map_sg()
> cuts the IOVA region into discontiguous pieces, and creates a
> faulty IOVA mapping that overlaps some physical memory outside
> the scatter list, which might lead to some random kernel panic
> after DMA overwrites that faulty IOVA space.

Once again, get rid of this paragraph - it doesn't have much to do with 
the *default* value since it describes a behaviour general to any 
boundary mask. Plus it effectively says "if a driver uses a DMA-mapped 
scatterlist incorrectly, this change can help paper over the bug", which 
is rather the opposite of a good justification.

(for example most SATA devices end up with a 64KB boundary mask, such 
that padding the IOVAs to provide the appropriate alignment happens very 
frequently, and they've been working just fine for years now)

Robin.

> So this patch sets default segment_boundary_mask to ULONG_MAX.
> 
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..ff8cefe85f30 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>   {
>   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>   		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return ULONG_MAX;
>   }
>   
>   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
