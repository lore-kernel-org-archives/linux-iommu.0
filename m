Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0C5C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:10:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFF5E60F9B
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CFF5E60F9B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A9F1260685;
	Fri, 30 Jul 2021 06:10:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uI_Yb_q9Co4P; Fri, 30 Jul 2021 06:10:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 88B32600B6;
	Fri, 30 Jul 2021 06:10:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AFC0C001A;
	Fri, 30 Jul 2021 06:10:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66489C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:10:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5513883B98
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:10:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SqAW0O1LTsji for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:10:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ADB0E83B95
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:10:04 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="213070066"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="213070066"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:10:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465344820"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:10:01 -0700
Subject: Re: [PATCH v2 12/24] iommu/dma: Unexport IOVA cookie management
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fcd151ab-342e-cea4-a9d9-358635dd4a75@linux.intel.com>
Date: Fri, 30 Jul 2021 14:07:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <697a7c5da18c58e61e6b9a98b97775a2934a6358.1627468309.git.robin.murphy@arm.com>
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
> IOVA cookies are now got and put by core code, so we no longer need to
> export these to modular drivers. The export for getting MSI cookies
> stays, since VFIO can still be a module, but it was already relying on
> someone else putting them, so that aspect is unaffected.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/dma-iommu.c | 7 -------
>   drivers/iommu/iommu.c     | 3 +--
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 98ba927aee1a..10067fbc4309 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -98,9 +98,6 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>   /**
>    * iommu_get_dma_cookie - Acquire DMA-API resources for a domain
>    * @domain: IOMMU domain to prepare for DMA-API usage
> - *
> - * IOMMU drivers should normally call this from their domain_alloc
> - * callback when domain->type == IOMMU_DOMAIN_DMA.
>    */
>   int iommu_get_dma_cookie(struct iommu_domain *domain)
>   {
> @@ -113,7 +110,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>   
>   	return 0;
>   }
> -EXPORT_SYMBOL(iommu_get_dma_cookie);
>   
>   /**
>    * iommu_get_msi_cookie - Acquire just MSI remapping resources
> @@ -151,8 +147,6 @@ EXPORT_SYMBOL(iommu_get_msi_cookie);
>    * iommu_put_dma_cookie - Release a domain's DMA mapping resources
>    * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie() or
>    *          iommu_get_msi_cookie()
> - *
> - * IOMMU drivers should normally call this from their domain_free callback.
>    */
>   void iommu_put_dma_cookie(struct iommu_domain *domain)
>   {
> @@ -172,7 +166,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>   	kfree(cookie);
>   	domain->iova_cookie = NULL;
>   }
> -EXPORT_SYMBOL(iommu_put_dma_cookie);
>   
>   /**
>    * iommu_dma_get_resv_regions - Reserved region driver helper
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ea5a9ea8d431..fa8109369f74 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1947,8 +1947,7 @@ static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>   	/* Assume all sizes by default; the driver may override this later */
>   	domain->pgsize_bitmap  = bus->iommu_ops->pgsize_bitmap;
>   
> -	/* Temporarily ignore -EEXIST while drivers still get their own cookies */
> -	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain) == -ENOMEM) {
> +	if (type == IOMMU_DOMAIN_DMA && iommu_get_dma_cookie(domain)) {
>   		iommu_domain_free(domain);
>   		domain = NULL;
>   	}
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
