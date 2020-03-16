Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4917FC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 12:12:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1660820658
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 12:12:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1660820658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C510D88DBF;
	Mon, 16 Mar 2020 12:12:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 19CBW39joGaX; Mon, 16 Mar 2020 12:12:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CFA5F86C02;
	Mon, 16 Mar 2020 12:12:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6138C18DA;
	Mon, 16 Mar 2020 12:12:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BBF03C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 12:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 96DD9883E0
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 12:12:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fBx8ArnuSRne for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 12:12:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by hemlock.osuosl.org (Postfix) with ESMTP id 5BA1D87118
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 12:12:14 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A81F930E;
 Mon, 16 Mar 2020 05:12:13 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2393F52E;
 Mon, 16 Mar 2020 05:12:12 -0700 (PDT)
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
To: Nicolin Chen <nicoleotsuka@gmail.com>, m.szyprowski@samsung.com, hch@lst.de
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
Date: Mon, 16 Mar 2020 12:12:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200314000007.13778-1-nicoleotsuka@gmail.com>
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

On 2020-03-14 12:00 am, Nicolin Chen wrote:
> More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> only a handful of drivers call dma_set_seg_boundary(). This means
> that most drivers have a 4GB segmention boundary because DMA API
> returns DMA_BIT_MAKS(32) as a default value, though they might be
> able to handle things above 32-bit.

Don't assume the boundary mask and the DMA mask are related. There do 
exist devices which can DMA to a 64-bit address space in general, but 
due to descriptor formats/hardware design/whatever still require any 
single transfer not to cross some smaller boundary. XHCI is 64-bit yet 
requires most things not to cross a 64KB boundary. EHCI's 64-bit mode is 
an example of the 4GB boundary (not the best example, admittedly, but it 
undeniably exists).

> This might result in a situation that iommu_map_sg() cuts an IOVA
> region, larger than 4GB, into discontiguous pieces and creates a
> faulty IOVA mapping that overlaps some physical memory being out
> of the scatter list, which might lead to some random kernel panic
> after DMA overwrites that faulty IOVA space.

If that's really a problem, then what about users who set a non-default 
mask?

Furthermore, scatterlist segments are just DMA duffers - if there is no 
IOMMU and a device accesses outside a buffer, Bad Things can and will 
happen; if the ends of the buffer don't line up exactly to page 
boundaries even with an IOMMU, if the device accesses outside the buffer 
then Bad Things can happen; even if an IOMMU can map a buffer perfectly, 
accesses outside it will either hit other buffers or generate unexpected 
faults, which are both - you guessed it - Bad Things.

In short, if this is happening then something is certainly broken, but 
it isn't the DMA layer.

> We have CONFIG_DMA_API_DEBUG_SG in kernel/dma/debug.c that checks
> such situations to prevent bad things from happening. However, it
> is not a mandatory check. And one might not think of enabling it
> when debugging a random kernel panic until figuring out that it's
> related to iommu_map_sg().
> 
> A safer solution may be to align the default segmention boundary
> with the configured dma_mask, so DMA API may create a contiguous
> IOVA space as a device "expect" -- what tries to make sense is:
> Though it's device driver's responsibility to set dma_parms, it
> is not fair or even safe to apply a 4GB boundary here, which was
> added a decade ago to work for up-to-4GB mappings at that time.
> 
> This patch updates the default segment_boundary_mask by aligning
> it with dma_mask.

Why bother even interrogating the device? You can trivially express "no 
limit" as "~0UL", which is arguably less confusing than pretending this 
bears any relation to DMA masks. However, like Christoph I'm concerned 
that we don't know how many drivers are relying on the current default 
(and to a lesser extent that it leads to a subtle difference in 
behaviour between 32-bit PAE and 'proper' 64-bit builds).

And in the specific case of iommu-dma, this only comes into the picture 
at all if a single scatterlist maps more than 4GB at once, which isn't 
exactly typical streaming DMA behaviour - given that that implies a 
rather absurd figure of more than 65536 entries at the default 
max_segment_size, the relevant device probably doesn't want to be 
relying on the default dma_parms in the first place.

[ I though I'd replied to your previous mail already; let me go see what 
happened to that... ]

Robin.

> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> ---
>   include/linux/dma-mapping.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 330ad58fbf4d..0df0ee92eba1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -736,7 +736,7 @@ static inline unsigned long dma_get_seg_boundary(struct device *dev)
>   {
>   	if (dev->dma_parms && dev->dma_parms->segment_boundary_mask)
>   		return dev->dma_parms->segment_boundary_mask;
> -	return DMA_BIT_MASK(32);
> +	return (unsigned long)dma_get_mask(dev);
>   }
>   
>   static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
