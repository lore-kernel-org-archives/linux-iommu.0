Return-Path: <SRS0=K0Me=LL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E8C2B9F4
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:20:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31483613B9
	for <iommu@archiver.kernel.org>; Thu, 17 Jun 2021 07:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31483613B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0991583DE6;
	Thu, 17 Jun 2021 07:20:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id B0GlpjvwZWaC; Thu, 17 Jun 2021 07:20:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id AD7F583DC7;
	Thu, 17 Jun 2021 07:20:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81A2BC000E;
	Thu, 17 Jun 2021 07:20:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 142C6C000B
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E4ADC83DE7
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:20:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Evw0lDjan4mb for <iommu@lists.linux-foundation.org>;
 Thu, 17 Jun 2021 07:20:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B7BA183DC4
 for <iommu@lists.linux-foundation.org>; Thu, 17 Jun 2021 07:20:09 +0000 (UTC)
IronPort-SDR: 12On6J9oGG0Ar06ieXTpCzC+YjcdsKFBqXqmh/kVpFobUbfravrsF/L9JK3HJ18ZLO+jIfT6Al
 Ni9jdb6h3pvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="206273502"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="206273502"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Jun 2021 00:20:09 -0700
IronPort-SDR: f5uyLCePA4vQedp0tG3ISxCOvFjgXxQLmtIdc/4UlSvhvwSV1D1ygdcsL/yeyrAgdrl+LIWqsE
 s/z3BhsOKRXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; d="scan'208";a="472326493"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga004.fm.intel.com with ESMTP; 17 Jun 2021 00:20:06 -0700
Subject: Re: [PATCH v7 08/15] iommu: Add support for the map_pages() callback
To: Georgi Djakov <quic_c_gdjako@quicinc.com>, will@kernel.org,
 robin.murphy@arm.com
References: <1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <bc003ab7-5067-53de-a94e-815462991f8f@linux.intel.com>
Date: Thu, 17 Jun 2021 15:18:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1623850736-389584-9-git-send-email-quic_c_gdjako@quicinc.com>
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
> From: "Isaac J. Manjarres" <isaacm@codeaurora.org>
> 
> Since iommu_pgsize can calculate how many pages of the
> same size can be mapped/unmapped before the next largest
> page size boundary, add support for invoking an IOMMU
> driver's map_pages() callback, if it provides one.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>   drivers/iommu/iommu.c | 43 +++++++++++++++++++++++++++++++++++--------
>   1 file changed, 35 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 725622c7e603..70a729ce88b1 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2429,6 +2429,30 @@ static size_t iommu_pgsize(struct iommu_domain *domain, unsigned long iova,
>   	return pgsize;
>   }
>   
> +static int __iommu_map_pages(struct iommu_domain *domain, unsigned long iova,
> +			     phys_addr_t paddr, size_t size, int prot,
> +			     gfp_t gfp, size_t *mapped)
> +{
> +	const struct iommu_ops *ops = domain->ops;
> +	size_t pgsize, count;
> +	int ret;
> +
> +	pgsize = iommu_pgsize(domain, iova, paddr, size, &count);
> +
> +	pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx count %zu\n",
> +		 iova, &paddr, pgsize, count);
> +
> +	if (ops->map_pages) {
> +		ret = ops->map_pages(domain, iova, paddr, pgsize, count, prot,
> +				     gfp, mapped);
> +	} else {
> +		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
> +		*mapped = ret ? 0 : pgsize;
> +	}
> +
> +	return ret;
> +}
> +
>   static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   		       phys_addr_t paddr, size_t size, int prot, gfp_t gfp)
>   {
> @@ -2439,7 +2463,7 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	phys_addr_t orig_paddr = paddr;
>   	int ret = 0;
>   
> -	if (unlikely(ops->map == NULL ||
> +	if (unlikely(!(ops->map || ops->map_pages) ||
>   		     domain->pgsize_bitmap == 0UL))
>   		return -ENODEV;
>   
> @@ -2463,18 +2487,21 @@ static int __iommu_map(struct iommu_domain *domain, unsigned long iova,
>   	pr_debug("map: iova 0x%lx pa %pa size 0x%zx\n", iova, &paddr, size);
>   
>   	while (size) {
> -		size_t pgsize = iommu_pgsize(domain, iova, paddr, size, NULL);
> +		size_t mapped = 0;
>   
> -		pr_debug("mapping: iova 0x%lx pa %pa pgsize 0x%zx\n",
> -			 iova, &paddr, pgsize);
> -		ret = ops->map(domain, iova, paddr, pgsize, prot, gfp);
> +		ret = __iommu_map_pages(domain, iova, paddr, size, prot, gfp,
> +					&mapped);
> +		/*
> +		 * Some pages may have been mapped, even if an error occurred,
> +		 * so we should account for those so they can be unmapped.
> +		 */
> +		size -= mapped;
>   
>   		if (ret)
>   			break;
>   
> -		iova += pgsize;
> -		paddr += pgsize;
> -		size -= pgsize;
> +		iova += mapped;
> +		paddr += mapped;
>   	}
>   
>   	/* unroll mapping in case something went wrong */
> 

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
