Return-Path: <SRS0=RhgY=WP=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBAEC3A5A1
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 12:55:05 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4958120851
	for <iommu@archiver.kernel.org>; Mon, 19 Aug 2019 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4958120851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 15D68D9E;
	Mon, 19 Aug 2019 12:55:05 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7A8E08DC
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 12:55:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 1C79867F
	for <iommu@lists.linux-foundation.org>;
	Mon, 19 Aug 2019 12:55:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9C3D28;
	Mon, 19 Aug 2019 05:55:02 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6507D3F246;
	Mon, 19 Aug 2019 05:55:01 -0700 (PDT)
Subject: Re: [PATCH v9 2/5] iommu/dma: Add a new dma_map_ops of
	get_merge_boundary()
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
	joro@8bytes.org, axboe@kernel.dk
References: <1564129876-28261-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <312d6e38-5143-fb07-1efb-01e60cafa2c9@arm.com>
Date: Mon, 19 Aug 2019 13:54:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1564129876-28261-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-GB
Cc: linux-block@vger.kernel.org, wsa+renesas@sang-engineering.com,
	iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
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

On 26/07/2019 09:31, Yoshihiro Shimoda wrote:
> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   drivers/iommu/dma-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3e..2992ce4 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	return ret;
>   }
>   
> +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA)

Did you actually need this check? In principle, if the default domain is 
not of type IOMMU_DOMAIN_DMA then the device should be assigned 
dma_direct_ops rather than iommu_dma_ops, thus it shouldn't be possible 
to get here. If you did manage to hit a case where the domain type 
didn't match the ops it would be interesting to figure out how.

Robin.

> +		return 0;	/* can't merge */
> +
> +	return (1UL << __ffs(domain->pgsize_bitmap)) - 1;
> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
> @@ -1100,6 +1110,7 @@ static const struct dma_map_ops iommu_dma_ops = {
>   	.sync_sg_for_device	= iommu_dma_sync_sg_for_device,
>   	.map_resource		= iommu_dma_map_resource,
>   	.unmap_resource		= iommu_dma_unmap_resource,
> +	.get_merge_boundary	= iommu_dma_get_merge_boundary,
>   };
>   
>   /*
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
