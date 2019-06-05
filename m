Return-Path: <SRS0=DEPd=UE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF800C28D18
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:08 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0B9B206BA
	for <iommu@archiver.kernel.org>; Wed,  5 Jun 2019 12:22:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B9B206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 8239CB7D;
	Wed,  5 Jun 2019 12:22:08 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 561D7B7A
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 12:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id C353634F
	for <iommu@lists.linux-foundation.org>;
	Wed,  5 Jun 2019 12:22:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AD2815A2;
	Wed,  5 Jun 2019 05:22:06 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC6753F246;
	Wed,  5 Jun 2019 05:22:04 -0700 (PDT)
Subject: Re: [RFC PATCH v5 3/8] iommu: add a new capable IOMMU_CAP_MERGING
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com, hch@lst.de,
	m.szyprowski@samsung.com, joro@8bytes.org
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <7dfeb7d8-b777-b4af-d892-2829cd05241b@arm.com>
Date: Wed, 5 Jun 2019 13:21:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1559733114-4221-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-GB
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	linux-mmc@vger.kernel.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 05/06/2019 12:11, Yoshihiro Shimoda wrote:
> This patch adds a new capable IOMMU_CAP_MERGING to check whether
> the IOVA would be contiguous strictly if a device requires and
> the IOMMU driver has the capable.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/iommu/dma-iommu.c | 26 ++++++++++++++++++++++++--
>   include/linux/iommu.h     |  1 +
>   2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 034caae..ecf1a04 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -847,11 +847,16 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	dma_addr_t iova;
>   	size_t iova_len = 0;
>   	unsigned long mask = dma_get_seg_boundary(dev);
> -	int i;
> +	int i, ret;
> +	bool iova_contiguous = false;
>   
>   	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
>   		iommu_dma_sync_sg_for_device(dev, sg, nents, dir);
>   
> +	if (dma_get_iova_contiguous(dev) &&
> +	    iommu_capable(dev->bus, IOMMU_CAP_MERGING))
> +		iova_contiguous = true;
> +
>   	/*
>   	 * Work out how much IOVA space we need, and align the segments to
>   	 * IOVA granules for the IOMMU driver to handle. With some clever
> @@ -867,6 +872,13 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   		sg_dma_len(s) = s_length;
>   		s->offset -= s_iova_off;
>   		s_length = iova_align(iovad, s_length + s_iova_off);
> +		/*
> +		 * Check whether the IOVA would be contiguous strictly if
> +		 * a device requires and the IOMMU driver has the capable.
> +		 */
> +		if (iova_contiguous && i > 0 &&
> +		    (s_iova_off || s->length != s_length))
> +			return 0;
>   		s->length = s_length;
>   
>   		/*
> @@ -902,8 +914,18 @@ static int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg,
>   	if (iommu_map_sg(domain, iova, sg, nents, prot) < iova_len)
>   		goto out_free_iova;
>   
> -	return __finalise_sg(dev, sg, nents, iova);
> +	ret = __finalise_sg(dev, sg, nents, iova);
> +	/*
> +	 * Check whether the sg entry is single if a device requires and
> +	 * the IOMMU driver has the capable.
> +	 */
> +	if (iova_contiguous && ret != 1)
> +		goto out_unmap_sg;

I don't see that just failing really gives this option any value. 
Clearly the MMC driver has to do *something* to handle the failure (plus 
presumably the case of not having IOMMU DMA ops at all), which begs the 
question of why it couldn't just do whatever that is anyway, without all 
this infrastructure. For starters, it would be a far simpler and less 
invasive patch:

	if (dma_map_sg(...) > 1) {
		dma_unmap_sg(...);
		/* split into multiple requests and try again */
	}

But then it would make even more sense to just have the driver be 
proactive about its special requirement in the first place, and simply 
validate the list before it even tries to map it:

	for_each_sg(sgl, sg, n, i)
		if ((i > 0 && sg->offset % PAGE_SIZE) ||
		    (i < n - 1 && sg->length % PAGE_SIZE))
			/* segment will not be mergeable */

For reference, I think v4l2 and possibly some areas of DRM already do 
something vaguely similar to judge whether they get contiguous buffers 
or not.

> +
> +	return ret;
>   
> +out_unmap_sg:
> +	iommu_dma_unmap_sg(dev, sg, nents, dir, attrs);
>   out_free_iova:
>   	iommu_dma_free_iova(cookie, iova, iova_len);
>   out_restore_sg:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 91af22a..f971dd3 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -104,6 +104,7 @@ enum iommu_cap {
>   					   transactions */
>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_MERGING,		/* IOMMU supports segments merging */

This isn't a 'capability' of the IOMMU - "segment merging" equates to 
just remapping pages, and there's already a fundamental assumption that 
IOMMUs are capable of that. Plus it's very much a DMA API concept, so 
hardly belongs in the IOMMU API anyway.

All in all, I'm struggling to see the point of this. Although it's not a 
DMA API guarantee, iommu-dma already merges scatterlists as aggressively 
as it is allowed to, and will continue to do so for the foreseeable 
future (since it avoids considerable complication in the IOVA 
allocation), so if you want to make sure iommu_dma_map_sg() merges an 
entire list, just don't give it a non-mergeable list. And if you still 
really really want dma_map_sg() to have a behaviour of "merge to a 
single segment or fail", then that should at least be a DMA API 
attribute, which could in principle be honoured by bounce-buffering 
implementations as well.

And if the problem is really that you're not getting merging because of 
exposing the wrong parameters to the DMA API and/or the block layer, or 
that you just can't quite express your requirement to the block layer in 
the first place, then that should really be tackled at the source rather 
than worked around further down in the stack.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
