Return-Path: <SRS0=9Lhb=MH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850E2C12002
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:40:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7A761374
	for <iommu@archiver.kernel.org>; Thu, 15 Jul 2021 01:40:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7A761374
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B5FE860763;
	Thu, 15 Jul 2021 01:40:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QYd7oNkO9du9; Thu, 15 Jul 2021 01:40:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9ECBD6062A;
	Thu, 15 Jul 2021 01:40:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72A4BC0010;
	Thu, 15 Jul 2021 01:40:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 49B15C000E
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:40:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 317DD6072A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:40:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KjcgGC1pNzUO for <iommu@lists.linux-foundation.org>;
 Thu, 15 Jul 2021 01:40:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 64BF56062A
 for <iommu@lists.linux-foundation.org>; Thu, 15 Jul 2021 01:40:27 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10045"; a="232278211"
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="232278211"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2021 18:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,240,1620716400"; d="scan'208";a="466324733"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2021 18:40:25 -0700
Subject: Re: [PATCH] iommu: Unify iova_to_phys for identity domains
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <e701030cbf91b441f60d2d6788885f679317fad6.1626283714.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <eaa44be7-5c83-6d11-5efb-5ba4707b683b@linux.intel.com>
Date: Thu, 15 Jul 2021 09:38:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <e701030cbf91b441f60d2d6788885f679317fad6.1626283714.git.robin.murphy@arm.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org
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

On 7/15/21 1:28 AM, Robin Murphy wrote:
> If people are going to insist on calling iommu_iova_to_phys()
> pointlessly and expecting it to work, we can at least do ourselves a
> favour by handling those cases in the core code, rather than repeatedly
> across an inconsistent handful of drivers.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/amd/io_pgtable.c              | 3 ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c       | 3 ---
>   drivers/iommu/iommu.c                       | 6 +++++-
>   4 files changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/amd/io_pgtable.c b/drivers/iommu/amd/io_pgtable.c
> index bb0ee5c9fde7..182c93a43efd 100644
> --- a/drivers/iommu/amd/io_pgtable.c
> +++ b/drivers/iommu/amd/io_pgtable.c
> @@ -493,9 +493,6 @@ static phys_addr_t iommu_v1_iova_to_phys(struct io_pgtable_ops *ops, unsigned lo
>   	unsigned long offset_mask, pte_pgsize;
>   	u64 *pte, __pte;
>   
> -	if (pgtable->mode == PAGE_MODE_NONE)
> -		return iova;
> -
>   	pte = fetch_pte(pgtable, iova, &pte_pgsize);
>   
>   	if (!pte || !IOMMU_PTE_PRESENT(*pte))
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 3e87a9cf6da3..c9fdd0d097be 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2481,9 +2481,6 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   {
>   	struct io_pgtable_ops *ops = to_smmu_domain(domain)->pgtbl_ops;
>   
> -	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> -		return iova;
> -
>   	if (!ops)
>   		return 0;
>   
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 0f181f76c31b..0d04eafa3fdb 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1317,9 +1317,6 @@ static phys_addr_t arm_smmu_iova_to_phys(struct iommu_domain *domain,
>   	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
>   	struct io_pgtable_ops *ops = smmu_domain->pgtbl_ops;
>   
> -	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> -		return iova;
> -
>   	if (!ops)
>   		return 0;
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 43a2041d9629..7c16f977b5a6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2371,7 +2371,11 @@ EXPORT_SYMBOL_GPL(iommu_detach_group);
>   
>   phys_addr_t iommu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
>   {
> -	if (unlikely(domain->ops->iova_to_phys == NULL))
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +		return iova;
> +
> +	if (unlikely(domain->ops->iova_to_phys == NULL) ||
> +	    domain->type == IOMMU_DOMAIN_BLOCKED)
>   		return 0;

Nit:
Logically we only needs ops->iova_to_phys for DMA and UNMANAGED domains,
so it looks better if we have

	if (domain->type == IOMMU_DOMAIN_BLOCKED ||
	    unlikely(domain->ops->iova_to_phys == NULL))
		return 0;

Anyway,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

>   
>   	return domain->ops->iova_to_phys(domain, iova);
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
