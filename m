Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82185C433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 10:43:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20E4840862;
	Thu, 10 Feb 2022 10:43:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uSJRV3f9FSZy; Thu, 10 Feb 2022 10:43:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF3614025D;
	Thu, 10 Feb 2022 10:43:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CA923C0011;
	Thu, 10 Feb 2022 10:43:27 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F375C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 10:43:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 51A4181B9D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 10:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mcHX3QwP8tHn for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 10:43:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 652BD81B35
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 10:43:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 622D9ED1;
 Thu, 10 Feb 2022 02:43:24 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 845013F718;
 Thu, 10 Feb 2022 02:43:23 -0800 (PST)
Message-ID: <b090141f-0822-609f-429d-ea790d7fc828@arm.com>
Date: Thu, 10 Feb 2022 10:43:17 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH] iommu: explicitly check for NULL in
 iommu_dma_get_resv_regions()
Content-Language: en-GB
To: Aleksandr Fedorov <sanekf@nxt.ru>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
References: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <5481021644415780@myt5-a5512e99e394.qloud-c.yandex.net>
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

On 2022-02-09 14:09, Aleksandr Fedorov wrote:
> iommu_dma_get_resv_regions() assumes that iommu_fwspec field for
> corresponding device is set which is not always true.  Since
> iommu_dma_get_resv_regions() seems to be a future-proof generic API
> that can be used by any iommu driver, add an explicit check for NULL.

Except it's not a "generic" interface for drivers to call at random, 
it's a helper for retrieving common firmware-based information 
specifically for drivers already using the fwspec mechanism for common 
firmware bindings. If any driver calls this with a device *without* a 
valid fwnode, it deserves to crash because it's done something 
fundamentally wrong.

I concur that it's not exactly obvious that "non-IOMMU-specific" means 
"based on common firmware bindings, thus implying fwspec".

Robin.

> Currently it can work by accident since compiler can eliminate
> the 'iommu_fwspec' check altogether when CONFIG_ACPI_IORT=n, but
> code elimination from optimizations is not reliable.
> 
> Signed-off-by: Aleksandr Fedorov <halcien@gmail.com>
> ---
> A compilation failure has been observed on a gcc-compatible compiler based on EDG.
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index d85d54f2b549..474b1b7211d7 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -382,10 +382,10 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>    */
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
>   {
> +	struct iommu_fwspec *iommu_fwspec = dev_iommu_fwspec_get(dev);
>   
> -	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
> +	if (iommu_fwspec && !is_of_node(iommu_fwspec->iommu_fwnode))
>   		iort_iommu_msi_get_resv_regions(dev, list);
> -
>   }
>   EXPORT_SYMBOL(iommu_dma_get_resv_regions);
>   
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
