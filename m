Return-Path: <SRS0=GV0T=MW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C14C432BE
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:09:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736416101C
	for <iommu@archiver.kernel.org>; Fri, 30 Jul 2021 06:09:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 736416101C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 48A28606EB;
	Fri, 30 Jul 2021 06:09:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0pdE9e7mBq54; Fri, 30 Jul 2021 06:09:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3285460685;
	Fri, 30 Jul 2021 06:09:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CF0AC001A;
	Fri, 30 Jul 2021 06:09:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 60F60C000E
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50E4E606EB
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CViBE88FTzU5 for <iommu@lists.linux-foundation.org>;
 Fri, 30 Jul 2021 06:09:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BC59460685
 for <iommu@lists.linux-foundation.org>; Fri, 30 Jul 2021 06:09:23 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10060"; a="276814609"
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="276814609"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jul 2021 23:09:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,281,1620716400"; d="scan'208";a="465344760"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 29 Jul 2021 23:09:20 -0700
Subject: Re: [PATCH v2 04/24] iommu/vt-d: Drop IOVA cookie management
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
References: <cover.1627468308.git.robin.murphy@arm.com>
 <6630ae3191be428135a7269c15b17d03c90573c1.1627468309.git.robin.murphy@arm.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <1cc3a65c-15b6-f971-3ea3-668ebb0b20f5@linux.intel.com>
Date: Fri, 30 Jul 2021 14:07:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <6630ae3191be428135a7269c15b17d03c90573c1.1627468309.git.robin.murphy@arm.com>
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
> The core code bakes its own cookies now.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/intel/iommu.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c12cc955389a..7e168634c433 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1979,10 +1979,6 @@ static void domain_exit(struct dmar_domain *domain)
>   	/* Remove associated devices and clear attached or cached domains */
>   	domain_remove_dev_info(domain);
>   
> -	/* destroy iovas */
> -	if (domain->domain.type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&domain->domain);
> -
>   	if (domain->pgd) {
>   		struct page *freelist;
>   
> @@ -4544,10 +4540,6 @@ static struct iommu_domain *intel_iommu_domain_alloc(unsigned type)
>   			return NULL;
>   		}
>   
> -		if (type == IOMMU_DOMAIN_DMA &&
> -		    iommu_get_dma_cookie(&dmar_domain->domain))
> -			return NULL;
> -
>   		domain = &dmar_domain->domain;
>   		domain->geometry.aperture_start = 0;
>   		domain->geometry.aperture_end   =
> 


Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
