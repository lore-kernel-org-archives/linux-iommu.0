Return-Path: <SRS0=bVsO=I6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E96C433ED
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:35:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E1A61374
	for <iommu@archiver.kernel.org>; Thu,  1 Apr 2021 15:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E1A61374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2EB3C848ED;
	Thu,  1 Apr 2021 15:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wmYdt3F3ZTut; Thu,  1 Apr 2021 15:35:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id D01B884A12;
	Thu,  1 Apr 2021 15:35:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AF443C000B;
	Thu,  1 Apr 2021 15:35:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8CCD3C000A
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:35:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7AD3F40196
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:35:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EK-oSBaiCI9W for <iommu@lists.linux-foundation.org>;
 Thu,  1 Apr 2021 15:35:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9222E40122
 for <iommu@lists.linux-foundation.org>; Thu,  1 Apr 2021 15:35:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA783161B;
 Thu,  1 Apr 2021 08:35:02 -0700 (PDT)
Received: from [10.57.24.208] (unknown [10.57.24.208])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EF4D3F719;
 Thu,  1 Apr 2021 08:35:01 -0700 (PDT)
Subject: Re: [RFC PATCH 3/5] iommu: Add support for the unmap_pages IOMMU
 callback
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
References: <20210331030042.13348-1-isaacm@codeaurora.org>
 <20210331030042.13348-4-isaacm@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f57e2151-1199-46f0-21ed-e401be358857@arm.com>
Date: Thu, 1 Apr 2021 16:34:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210331030042.13348-4-isaacm@codeaurora.org>
Content-Language: en-GB
Cc: pratikp@codeaurora.org, will@kernel.org
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

On 2021-03-31 04:00, Isaac J. Manjarres wrote:
> The IOMMU framework currently unmaps memory one page block at a time,
> per the page block sizes that are supported by the IOMMU hardware.
> Now that IOMMU drivers can supply a callback for unmapping multiple
> in one call, add support in the IOMMU framework to calculate how many
> page mappings of the same size can be unmapped in one shot, and invoke the
> IOMMU driver's unmap_pages callback if it has one. Otherwise, the
> existing behavior will be used.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> ---
>   drivers/iommu/iommu.c | 44 +++++++++++++++++++++++++++++++++++++------
>   1 file changed, 38 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d0b0a15dba84..dc4295f6bc7f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2356,8 +2356,8 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   }
>   EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>   
> -static size_t iommu_pgsize(struct iommu_domain *domain,
> -			   unsigned long addr_merge, size_t size)
> +static size_t __iommu_pgsize(struct iommu_domain *domain,
> +			     unsigned long addr_merge, size_t size)
>   {
>   	unsigned int pgsize_idx;
>   	size_t pgsize;
> @@ -2388,6 +2388,24 @@ static size_t iommu_pgsize(struct iommu_domain *domain,
>   	return pgsize;
>   }
>   
> +static size_t iommu_pgsize(struct iommu_domain *domain,
> +			   unsigned long addr_merge, size_t size,
> +			   size_t *pgcount)
> +{
> +	size_t pgsize = __iommu_pgsize(domain, addr_merge, size);
> +	size_t pgs = 0;
> +
> +	do {
> +		pgs++;
> +		size -= pgsize;
> +		addr_merge += pgsize;
> +	} while (size && __iommu_pgsize(domain, addr_merge, size) == pgsize);

This looks horrifically inefficient. As part of calculating the best 
current page size it should then be pretty trivial to calculate "(size & 
next_pgsize_up - 1) >> pgsize_idx" for the number of current-size pages 
up to the next-better-size boundary (with next_pgsize_up being 0 if 
pgsize is already the largest possible for the relative alignment of 
physical and virtual address). A loop is just... yuck :(

> +
> +	*pgcount = pgs;
> +
> +	return pgsize;
> +}
> +
>   static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>   {
> @@ -2422,7 +2440,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova | paddr, size);
> +		size_t pgsize = __iommu_pgsize(domain, iova | paddr, size);
>   
>   		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>   			 iova, &paddr, pgsize);
> @@ -2473,6 +2491,21 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   }
>   EXPORT_SYMBOL_GPL(iommu_map_atomic);
>   
> +static size_t __iommu_unmap_pages(struct iommu_domain *domain, unsigned long iova,
> +				  size_t size, struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	size_t pgsize, pgcount;
> +
> +	if (ops->unmap_pages) {
> +		pgsize = iommu_pgsize(domain, iova, size, &pgcount);
> +		return ops->unmap_pages(domain, iova, pgsize, pgcount, iotlb_gather);
> +	}
> +
> +	pgsize = __iommu_pgsize(domain, iova, size);
> +	return ops->unmap(domain, iova, pgsize, iotlb_gather);
> +}
> +
>   static size_t __iommu_unmap(struct iommu_domain *domain,
>   			    unsigned long iova, size_t size,
>   			    struct iommu_iotlb_gather *iotlb_gather)
> @@ -2510,9 +2543,8 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	 * or we hit an area that isn't mapped.
>   	 */
>   	while (unmapped < size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, size - unmapped);
> -
> -		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
> +		unmapped_page = __iommu_unmap_pages(domain, iova, size - unmapped,
> +						    iotlb_gather);

I think it would make more sense to restructure the basic function 
around handling a page range, then just have a little inner loop to 
iterate over the individual pages if the driver doesn't provide the new 
callback.

Robin.

>   		if (!unmapped_page)
>   			break;
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
