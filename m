Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F8BC4338F
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:13:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B239860F9B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B239860F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 80BC683B9E;
	Fri, 30 Jul 2021 06:13:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 394W3nQPxPp4; Fri, 30 Jul 2021 06:13:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4ECB483B98;
	Fri, 30 Jul 2021 06:13:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 271F7C001A;
	Fri, 30 Jul 2021 06:13:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F753C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 813B5414B9
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QZjFqV-Bf_Km for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:13:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E0365414B8
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:13:42 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="234944233"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="234944233"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465345314"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:13:39 -0700
Subject: Re: [PATCH v2 21/24] iommu/dma: Factor out flush queue init
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e7c0aeea-0e74-168c-170d-d627adfe6d6a@linux.intel.com>
Date: Fri, 30 Jul 2021 14:11:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <afdded2f32737757f2af3ee08e123798fa024cce.1627468310.git.robin.murphy@arm.com>
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
> Factor out flush queue setup from the initial domain init so that we
> can potentially trigger it from sysfs later on in a domain's lifetime.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 30 ++++++++++++++++++++----------
>   include/linux/dma-iommu.h |  9 ++++++---
>   2 files changed, 26 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 7f3968865387..304a3ec71223 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -310,6 +310,25 @@ static bool dev_is_untrusted(struct device *dev)
>   	return dev_is_pci(dev) && to_pci_dev(dev)->untrusted;
>   }
>   
> +int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	struct iommu_dma_cookie *cookie = domain->iova_cookie;
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA_FQ)
> +		return -EINVAL;
> +	if (cookie->fq_domain)
> +		return 0;
> +
> +	if (init_iova_flush_queue(&cookie->iovad, iommu_dma_flush_iotlb_all,
> +				  iommu_dma_entry_dtor)) {
> +		pr_warn("iova flush queue initialization failed\n");
> +		domain->type = IOMMU_DOMAIN_DMA;
> +		return -ENODEV;
> +	}
> +	cookie->fq_domain = domain;
> +	return 0;
> +}
> +
>   /**
>    * iommu_dma_init_domain - Initialise a DMA mapping domain
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
> @@ -362,16 +381,7 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
>   	}
>   
>   	init_iova_domain(iovad, 1UL << order, base_pfn);
> -
> -	if (domain->type == IOMMU_DOMAIN_DMA_FQ && !cookie->fq_domain) {
> -		if (init_iova_flush_queue(iovad, iommu_dma_flush_iotlb_all,
> -					  iommu_dma_entry_dtor)) {
> -			pr_warn("iova flush queue initialization failed\n");
> -			domain->type = IOMMU_DOMAIN_DMA;
> -		} else {
> -			cookie->fq_domain = domain;
> -		}
> -	}
> +	iommu_dma_init_fq(domain);
>   
>   	return iova_reserve_iommu_regions(dev, domain);
>   }
> diff --git a/include/linux/dma-iommu.h b/include/linux/dma-iommu.h
> index 758ca4694257..81ab647f1618 100644
> --- a/include/linux/dma-iommu.h
> +++ b/include/linux/dma-iommu.h
> @@ -20,6 +20,7 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
>   
>   /* Setup call for arch DMA mapping code */
>   void iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 dma_limit);
> +int iommu_dma_init_fq(struct iommu_domain *domain);
>   
>   /* The DMA API isn't _quite_ the whole story, though... */
>   /*
> @@ -37,9 +38,6 @@ void iommu_dma_compose_msi_msg(struct msi_desc *desc,
>   
>   void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
>   
> -void iommu_dma_free_cpu_cached_iovas(unsigned int cpu,
> -		struct iommu_domain *domain);
> -
>   extern bool iommu_dma_forcedac;
>   
>   #else /* CONFIG_IOMMU_DMA */
> @@ -54,6 +52,11 @@ static inline void iommu_setup_dma_ops(struct device *dev, u64 dma_base,
>   {
>   }
>   
> +static inline int iommu_dma_init_fq(struct iommu_domain *domain)
> +{
> +	return -EINVAL;
> +}
> +
>   static inline int iommu_get_dma_cookie(struct iommu_domain *domain)
>   {
>   	return -ENODEV;
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
