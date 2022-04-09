Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4061C433F5
	for <iommu@archiver.kernel.org>; Sat,  9 Apr 2022 12:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8F84241E1D;
	Sat,  9 Apr 2022 12:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 46w_DvAjae0o; Sat,  9 Apr 2022 12:51:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B80E41E07;
	Sat,  9 Apr 2022 12:51:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01A9FC0033;
	Sat,  9 Apr 2022 12:51:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D75E6C002C
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5C9484401
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1a2ommFn7_vk for <iommu@lists.linux-foundation.org>;
 Sat,  9 Apr 2022 12:51:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 956A3843FE
 for <iommu@lists.linux-foundation.org>; Sat,  9 Apr 2022 12:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649508712; x=1681044712;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=vKNsP9CYTAGaS5HpajXxFaZPForOvjGpm7RZm16QYGI=;
 b=RtpkU+SLjf/V3VCFD5uEfMtgXELsgFAUeZTTtI2eR9THzLUrtp6C547J
 eHd6hD99DQNMv76sa7tn9dFCiH9DrziG3WGjjY05vChT5BMriiDZqIQLe
 e2Kxv1afhcwbe/RoTELCS118CqX/gc00h7IhoghPUd2C89td2z1H8xUmB
 /byiwNZjn2hli7e3U2DQqyg2fCl7JiAcKFa5b85KtZpUxUFYcbW8bKa2u
 W31ARtCbMFPDRspM7tU17IOwc9ZNbX5rP2EkHFozpONdbdupISCb7P64Y
 U9UEl9H14/iQneWyAg7w7MoK9g+QK+y92Pk0l5MzU0dyTvErAPvTC3A8Q Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="242392610"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="242392610"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:51:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; d="scan'208";a="698639274"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.211])
 ([10.254.214.211])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2022 05:51:49 -0700
Message-ID: <a97bb5f5-3899-5ad7-7316-a612e8fde788@linux.intel.com>
Date: Sat, 9 Apr 2022 20:51:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] iommu: Redefine IOMMU_CAP_CACHE_COHERENCY as the
 cap flag for IOMMU_CACHE
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 kvm@vger.kernel.org, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>
References: <3-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v2-f090ae795824+6ad-intel_no_snoop_jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 Christoph Hellwig <hch@lst.de>
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

On 2022/4/7 23:23, Jason Gunthorpe wrote:
> While the comment was correct that this flag was intended to convey the
> block no-snoop support in the IOMMU, it has become widely implemented and
> used to mean the IOMMU supports IOMMU_CACHE as a map flag. Only the Intel
> driver was different.
> 
> Now that the Intel driver is using enforce_cache_coherency() update the
> comment to make it clear that IOMMU_CAP_CACHE_COHERENCY is only about
> IOMMU_CACHE.  Fix the Intel driver to return true since IOMMU_CACHE always
> works.
> 
> The two places that test this flag, usnic and vdpa, are both assigning
> userspace pages to a driver controlled iommu_domain and require
> IOMMU_CACHE behavior as they offer no way for userspace to synchronize
> caches.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/intel/iommu.c | 2 +-
>   include/linux/iommu.h       | 3 +--
>   2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8f3674e997df06..14ba185175e9ec 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4556,7 +4556,7 @@ static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
>   static bool intel_iommu_capable(enum iommu_cap cap)
>   {
>   	if (cap == IOMMU_CAP_CACHE_COHERENCY)
> -		return domain_update_iommu_snooping(NULL);
> +		return true;
>   	if (cap == IOMMU_CAP_INTR_REMAP)
>   		return irq_remapping_enabled == 1;
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index fe4f24c469c373..fd58f7adc52796 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -103,8 +103,7 @@ static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>   }
>   
>   enum iommu_cap {
> -	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU can enforce cache coherent DMA
> -					   transactions */
> +	IOMMU_CAP_CACHE_COHERENCY,	/* IOMMU_CACHE is supported */
>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
>   };

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
