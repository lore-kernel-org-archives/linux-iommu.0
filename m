Return-Path: <SRS0=ZdmF=UN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CCFC31E4D
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:43 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42D221773
	for <iommu@archiver.kernel.org>; Fri, 14 Jun 2019 09:54:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42D221773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AE0D510CD;
	Fri, 14 Jun 2019 09:54:42 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 71326E2A
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:54:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id C4FEB174
	for <iommu@lists.linux-foundation.org>;
	Fri, 14 Jun 2019 09:54:40 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A9CA2B;
	Fri, 14 Jun 2019 02:54:40 -0700 (PDT)
Received: from [10.1.197.57] (e110467-lin.cambridge.arm.com [10.1.197.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB3343F718;
	Fri, 14 Jun 2019 02:56:22 -0700 (PDT)
Subject: Re: [RFC PATCH v6 3/5] block: add a helper function to merge the
	segments by an IOMMU
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, joro@8bytes.org,
	axboe@kernel.dk, ulf.hansson@linaro.org, wsa+renesas@sang-engineering.com
References: <1560421215-10750-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <039d7388-ed24-c7e7-dd6a-656c719a5ed9@arm.com>
Date: Fri, 14 Jun 2019 10:54:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1560421215-10750-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Language: en-GB
Cc: linux-renesas-soc@vger.kernel.org, linux-block@vger.kernel.org,
	iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org, hch@lst.de
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

On 13/06/2019 11:20, Yoshihiro Shimoda wrote:
> This patch adds a helper function whether a queue can merge
> the segments by an IOMMU.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   block/blk-settings.c   | 28 ++++++++++++++++++++++++++++
>   include/linux/blkdev.h |  2 ++
>   2 files changed, 30 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 45f2c52..4e4e13e 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -4,9 +4,11 @@
>    */
>   #include <linux/bio.h>
>   #include <linux/blkdev.h>
> +#include <linux/device.h>
>   #include <linux/gcd.h>
>   #include <linux/gfp.h>
>   #include <linux/init.h>
> +#include <linux/iommu.h>
>   #include <linux/jiffies.h>
>   #include <linux/kernel.h>
>   #include <linux/lcm.h>
> @@ -831,6 +833,32 @@ void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
>   }
>   EXPORT_SYMBOL_GPL(blk_queue_write_cache);
>   
> +/**
> + * blk_queue_can_use_iommu_merging - configure queue for merging segments.
> + * @q:		the request queue for the device
> + * @dev:	the device pointer for dma
> + *
> + * Tell the block layer about the iommu merging of @q.
> + */
> +bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> +				     struct device *dev)
> +{
> +	struct iommu_domain *domain;
> +
> +	/*
> +	 * If the device DMA is translated by an IOMMU, we can assume
> +	 * the device can merge the segments.
> +	 */
> +	if (!device_iommu_mapped(dev))

Careful here - I think this validates the comment I made when this 
function was introduced, in that that name doesn't necesarily mean what 
it sounds like it might mean - "iommu_mapped" was as close as we managed 
to get to a convenient shorthand for "performs DMA through an 
IOMMU-API-enabled IOMMU". Specifically, it does not imply that 
translation is *currently* active; if you boot with "iommu=pt" or 
equivalent this will still return true even though the device will be 
using direct/SWIOTLB DMA ops without any IOMMU translation.

Robin.

> +		return false;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	/* No need to update max_segment_size. see blk_queue_virt_boundary() */
> +	blk_queue_virt_boundary(q, iommu_get_minimum_page_size(domain) - 1);
> +
> +	return true;
> +}
> +
>   static int __init blk_settings_init(void)
>   {
>   	blk_max_low_pfn = max_low_pfn - 1;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 592669b..4d1f7dc 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1091,6 +1091,8 @@ extern void blk_queue_dma_alignment(struct request_queue *, int);
>   extern void blk_queue_update_dma_alignment(struct request_queue *, int);
>   extern void blk_queue_rq_timeout(struct request_queue *, unsigned int);
>   extern void blk_queue_write_cache(struct request_queue *q, bool enabled, bool fua);
> +extern bool blk_queue_can_use_iommu_merging(struct request_queue *q,
> +					    struct device *dev);
>   
>   /*
>    * Number of physical segments as sent to the device.
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
