Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE1C48BE5
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:19:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACE57613BF
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACE57613BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7FB9E41596;
	Thu, 17 Jun 2021 07:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZV3DLYz4gamQ; Thu, 17 Jun 2021 07:19:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6A71041579;
	Thu, 17 Jun 2021 07:19:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C4FFC000E;
	Thu, 17 Jun 2021 07:19:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 230AAC000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:19:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F96F41579
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8IRn_Zb1Y44J for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:19:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp4.osuosl.org (Postfix) with ESMTPS id DD19D405FF
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:19:33 +0000 (UTC)
IronPort-SDR: /2cr6cK7/9RNCaTBMRtZhwFMFKemauRv5xH/qvlSxU++j/VRgNxFlErsRk5Kst4AjTpTkOCuqV
 8nGf6/xlIQvQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="204488157"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="204488157"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 00:19:33 -0700
IronPort-SDR: 4208CIkwC6S+691a5DBLW9+0D4NjiPL+joRWtB185dL7teYQSJYN5f4tubIu2cTlp4b+dxbs2f
 wn2GiQiSEX0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="472326350"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:19:30 -0700
Subject: Re: [PATCH v7 07/15] iommu: Hook up '->unmap_pages' driver callback
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-8-git-send-email-quic_c_gdjako@quicinc.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0cb188c0-defd-e179-ad0e-471f48dfb54e@linux.intel.com>
Date: Thu, 17 Jun 2021 15:18:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-8-git-send-email-quic_c_gdjako@quicinc.com>
Content-Language: en-US
Cc: isaacm@codeaurora.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, djakov@kernel.org, pratikp@codeaurora.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 6/16/21 9:38 PM, Georgi Djakov wrote:
> From: Will Deacon <will@kernel.org>
> 
> Extend iommu_pgsize() to populate an optional 'count' parameter so that
> we can direct unmapping operation to the ->unmap_pages callback if it
> has been provided by the driver.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 59 +++++++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 50 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 80e14c139d40..725622c7e603 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2376,11 +2376,11 @@ phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   EXPORT_SYMBOL_GPL(iommu_iova_to_phys);
>   
>   static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
> -			   phys_addr_t paddr, size_t size)
> +			   phys_addr_t paddr, size_t size, size_t *count)
>   {
> -	unsigned int pgsize_idx;
> +	unsigned int pgsize_idx, pgsize_idx_next;
>   	unsigned long pgsizes;
> -	size_t pgsize;
> +	size_t offset, pgsize, pgsize_next;
>   	unsigned long addr_merge = paddr | iova;
>   
>   	/* Page sizes supported by the hardware and small enough for @size */
> @@ -2396,7 +2396,36 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>   	/* Pick the biggest page size remaining */
>   	pgsize_idx = __fls(pgsizes);
>   	pgsize = BIT(pgsize_idx);
> +	if (!count)
> +		return pgsize;
>   
> +	/* Find the next biggest support page size, if it exists */
> +	pgsizes = domain->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
> +	if (!pgsizes)
> +		goto out_set_count;
> +
> +	pgsize_idx_next = __ffs(pgsizes);
> +	pgsize_next = BIT(pgsize_idx_next);
> +
> +	/*
> +	 * There's no point trying a bigger page size unless the virtual
> +	 * and physical addresses are similarly offset within the larger page.
> +	 */
> +	if ((iova ^ paddr) & (pgsize_next - 1))
> +		goto out_set_count;
> +
> +	/* Calculate the offset to the next page size alignment boundary */
> +	offset = pgsize_next - (addr_merge & (pgsize_next - 1));
> +
> +	/*
> +	 * If size is big enough to accommodate the larger page, reduce
> +	 * the number of smaller pages.
> +	 */
> +	if (offset + pgsize_next <= size)
> +		size = offset;
> +
> +out_set_count:
> +	*count = size >> pgsize_idx;
>   	return pgsize;
>   }
>   
> @@ -2434,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, paddr, size);
> +		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
>   
>   		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
>   			 iova, &paddr, pgsize);
> @@ -2485,6 +2514,19 @@ int iommu_map_atomic(struct iommu_domain *domain, unsigned long iova,
>   }
>   EXPORT_SYMBOL_GPL(iommu_map_atomic);
>   
> +static size_t __iommu_unmap_pages(struct iommu_domain *domain,
> +				  unsigned long iova, size_t size,
> +				  struct iommu_iotlb_gather *iotlb_gather)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	size_t pgsize, count;
> +
> +	pgsize = iommu_pgsize(domain, iova, iova, size, &count);
> +	return ops->unmap_pages ?
> +	       ops->unmap_pages(domain, iova, pgsize, count, iotlb_gather) :
> +	       ops->unmap(domain, iova, pgsize, iotlb_gather);
> +}
> +
>   static size_t __iommu_unmap(struct iommu_domain *domain,
>   			    unsigned long iova, size_t size,
>   			    struct iommu_iotlb_gather *iotlb_gather)
> @@ -2494,7 +2536,7 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	unsigned long orig_iova = iova;
>   	unsigned int min_pagesz;
>   
> -	if (unlikely(ops->unmap == NULL ||
> +	if (unlikely(!(ops->unmap || ops->unmap_pages) ||
>   		     domain->pgsize_bitmap == 0UL))
>   		return 0;
>   
> @@ -2522,10 +2564,9 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   	 * or we hit an area that isn't mapped.
>   	 */
>   	while (unmapped < size) {
> -		size_t pgsize;
> -
> -		pgsize = iommu_pgsize(domain, iova, iova, size - unmapped);
> -		unmapped_page = ops->unmap(domain, iova, pgsize, iotlb_gather);
> +		unmapped_page = __iommu_unmap_pages(domain, iova,
> +						    size - unmapped,
> +						    iotlb_gather);
>   		if (!unmapped_page)
>   			break;
>   
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
