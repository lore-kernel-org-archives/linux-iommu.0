Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BBC432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:11:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9303660F4B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:11:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9303660F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5497A60A62;
	Fri, 30 Jul 2021 06:11:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ljfmgcGFBu8w; Fri, 30 Jul 2021 06:11:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 48A79606EB;
	Fri, 30 Jul 2021 06:11:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24422C001A;
	Fri, 30 Jul 2021 06:11:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A26D7C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:11:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 84C6B606F9
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:11:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-x5trw_9Ssk for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:11:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D35A0606EB
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:11:32 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="276814790"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="276814790"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345019"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:11:29 -0700
Subject: Re: [PATCH v2 17/24] iommu/vt-d: Prepare for multiple DMA domain types
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <3cf1ab93d3a4868db3b2e60c7c9781619e449694.1627468309.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ad334873-b148-b9b7-efc7-e1c753937f85@linux.intel.com>
Date: Fri, 30 Jul 2021 14:09:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <3cf1ab93d3a4868db3b2e60c7c9781619e449694.1627468309.git.robin.murphy@arm.com>
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

On 7/28/21 11:58 PM, Robin Murphy wrote:
> In preparation for the strict vs. non-strict decision for DMA domains
> to be expressed in the domain type, make sure we expose our flush queue
> awareness by accepting the new domain type, and test the specific
> feature flag where we want to identify DMA domains in general. The DMA
> ops reset/setup can simply be made unconditional, since iommu-dma
> already knows only to touch DMA domains.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 15 ++++++---------
>   1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7e168634c433..8fc46c9d6b96 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -582,7 +582,7 @@ struct intel_iommu *domain_get_iommu(struct dmar_domain *domain)
>   	int iommu_id;
>   
>   	/* si_domain and vm domain should not get here. */
> -	if (WARN_ON(domain->domain.type != IOMMU_DOMAIN_DMA))
> +	if (WARN_ON(!iommu_is_dma_domain(&domain->domain)))
>   		return NULL;
>   
>   	for_each_domain_iommu(iommu_id, domain)
> @@ -1034,7 +1034,7 @@ static struct dma_pte *pfn_to_dma_pte(struct dmar_domain *domain,
>   			pteval = ((uint64_t)virt_to_dma_pfn(tmp_page) << VTD_PAGE_SHIFT) | DMA_PTE_READ | DMA_PTE_WRITE;
>   			if (domain_use_first_level(domain)) {
>   				pteval |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
> -				if (domain->domain.type == IOMMU_DOMAIN_DMA)
> +				if (iommu_is_dma_domain(&domain->domain))
>   					pteval |= DMA_FL_PTE_ACCESS;
>   			}
>   			if (cmpxchg64(&pte->val, 0ULL, pteval))
> @@ -2345,7 +2345,7 @@ __domain_mapping(struct dmar_domain *domain, unsigned long iov_pfn,
>   	if (domain_use_first_level(domain)) {
>   		attr |= DMA_FL_PTE_XD | DMA_FL_PTE_US;
>   
> -		if (domain->domain.type == IOMMU_DOMAIN_DMA) {
> +		if (iommu_is_dma_domain(&domain->domain)) {
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
> @@ -5197,12 +5198,8 @@ static void intel_iommu_release_device(struct device *dev)
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
> +	iommu_setup_dma_ops(dev, 0, U64_MAX);
>   }
>   
>   static void intel_iommu_get_resv_regions(struct device *device,
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
