Return-Path: <SRS0=sT52=MQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C99C4338F
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 05:23:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4632A60EAF
	for <iommu@archiver.kernel.org>; Sat, 24 Jul 2021 05:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4632A60EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DD776405C9;
	Sat, 24 Jul 2021 05:23:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APgMuBKek4iN; Sat, 24 Jul 2021 05:23:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 92461405C8;
	Sat, 24 Jul 2021 05:23:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55411C0010;
	Sat, 24 Jul 2021 05:23:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC03FC000E
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 05:23:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E6E43405C9
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 05:23:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27cXnfNoZrUS for <iommu@lists.linux-foundation.org>;
 Sat, 24 Jul 2021 05:23:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B530E405C8
 for <iommu@lists.linux-foundation.org>; Sat, 24 Jul 2021 05:23:38 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10054"; a="297564638"
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; d="scan'208";a="297564638"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 22:23:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,265,1620716400"; d="scan'208";a="502965794"
Received: from yuhaipen-mobl.ccr.corp.intel.com (HELO [10.254.209.247])
 ([10.254.209.247])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2021 22:23:35 -0700
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1626888444.git.robin.murphy@arm.com>
 <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 17/23] iommu/vt-d: Prepare for multiple DMA domain types
Message-ID: <7599b48f-169d-283f-782b-e54c667346e8@linux.intel.com>
Date: Sat, 24 Jul 2021 13:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <11efdfa4ee223d12769d17459fcf789c626d7b82.1626888445.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

Hi Robin,

On 2021/7/22 2:20, Robin Murphy wrote:
> In preparation for the strict vs. non-strict decision for DMA domains to
> be expressed in the domain type, make sure we expose our flush queue
> awareness by accepting the new domain type, and test the specific
> feature flag where we want to identify DMA domains in general. The DMA
> ops setup can simply be made unconditional, since iommu-dma already
> knows not to touch identity domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e2add5a0caef..77d322272743 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -601,7 +601,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>   	int iommu_id;
>   
>   	/* si_domain and vm domain should not get here. */
> -	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
> +	if (WARN_ON(!(domain->domain.type & __IOMMU_DOMAIN_DMA)))
>   		return NULL;
>   
>   	for_each_domain_iommu(iommu_id, domain)
> @@ -1035,7 +1035,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
>   			if (domain_use_first_level(domain)) {
>   				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
> -				if (domain->domain.type == IOMMU_DOMAIN_DMA)
> +				if (domain->domain.type & __IOMMU_DOMAIN_DMA_API)
>   					pteval |= DMA_FL_PTE_ACCESS;
>   			}
>   			if (cmpxchg64(&pte->val, 0ULL, pteval))
> @@ -2346,7 +2346,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   	if (domain_use_first_level(domain)) {
>   		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
>   
> -		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
> +		if (domain->domain.type & __IOMMU_DOMAIN_DMA_API) {
>   			attr |= DMA_FL_PTE_ACCESS;
>   			if (prot & DMA_PTE_WRITE)
>   				attr |= DMA_FL_PTE_DIRTY;
> @@ -4528,6 +4528,7 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   
>   	switch (type) {
>   	case IOMMU_DOMAIN_DMA:
> +	case IOMMU_DOMAIN_DMA_FQ:
>   	case IOMMU_DOMAIN_UNMANAGED:
>   		dmar_domain = alloc_domain(0);
>   		if (!dmar_domain) {
> @@ -5164,12 +5165,8 @@ static void intel_iommu_release_device(struct device *dev)
>   
>   static void intel_iommu_probe_finalize(struct device *dev)
>   {
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -
> -	if (domain && domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_setup_dma_ops(dev, 0, U64_MAX);
> -	else
> -		set_dma_ops(dev, NULL);
> +	set_dma_ops(dev, NULL);

Is it reasonable to remove above line? The idea is that vendor iommu
driver should not override the dma_ops if device doesn't have a DMA
domain.

> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
>   static void intel_iommu_get_resv_regions(struct device *device,
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
