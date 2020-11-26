Return-Path: <SRS0=3/Zu=FA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73980C56202
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:25:51 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC76A206B7
	for <iommu@archiver.kernel.org>; Thu, 26 Nov 2020 11:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC76A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 8ABC9203A7;
	Thu, 26 Nov 2020 11:25:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NC5XKlTA1cjP; Thu, 26 Nov 2020 11:25:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E4D9D2039D;
	Thu, 26 Nov 2020 11:25:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C31EEC0891;
	Thu, 26 Nov 2020 11:25:46 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C383C0052
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:25:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1A94E20415
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:25:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SfKGFDIjiJHr for <iommu@lists.linux-foundation.org>;
 Thu, 26 Nov 2020 11:25:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by silver.osuosl.org (Postfix) with ESMTPS id EED232039D
 for <iommu@lists.linux-foundation.org>; Thu, 26 Nov 2020 11:25:43 +0000 (UTC)
IronPort-SDR: wSrXGluQIK0ce7Mgw5w80ikttTJgVUm5je11Bb/JvdIKLnHomDHFnWbU/0xuQZiPC03l1TOYQd
 6UXu+BCsedNw==
X-IronPort-AV: E=McAfee;i="6000,8403,9816"; a="256981503"
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="256981503"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 03:25:43 -0800
IronPort-SDR: ZDe5wQuiXoqnHNL9e4SSQvkbpLDRt7yN7NloaHHfX5Oj4KwuGZJRBj0n++9x8TmFwGvuO5kAiq
 yZCVhMHC8ulA==
X-IronPort-AV: E=Sophos;i="5.78,371,1599548400"; d="scan'208";a="479322412"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.39])
 ([10.254.208.39])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2020 03:25:41 -0800
Subject: Re: [PATCH] iommu/vt-d: Don't read VCCAP register unless it exists
To: David Woodhouse <dwmw2@infradead.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>
References: <de32b150ffaa752e0cff8571b17dfb1213fbe71c.camel@infradead.org>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5617b4d2-938b-15b2-a9f9-3cd52c788d58@linux.intel.com>
Date: Thu, 26 Nov 2020 19:25:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <de32b150ffaa752e0cff8571b17dfb1213fbe71c.camel@infradead.org>
Content-Language: en-US
Cc: iommu <iommu@lists.linux-foundation.org>
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

On 2020/11/26 19:13, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> My virtual IOMMU implementation is whining that the guest is reading a
> register that doesn't exist. Only read the VCCAP_REG if the corresponding
> capability is set in ECAP_REG to indicate that it actually exists.
> 
> Fixes: 3375303e8287 ("iommu/vt-d: Add custom allocator for IOASID")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> Reviewed-by: Liu Yi L <yi.l.liu@intel.com>
> Cc: stable@vger.kernel.org # v5.7+

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c  | 3 ++-
>   drivers/iommu/intel/iommu.c | 4 ++--
>   2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 404b40af31cb..38d1d40cfe34 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -967,7 +967,8 @@ static int map_iommu(struct intel_iommu *iommu, u64 phys_addr)
>   		warn_invalid_dmar(phys_addr, " returns all ones");
>   		goto unmap;
>   	}
> -	iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
> +	if (ecap_vcs(iommu->ecap))
> +		iommu->vccap = dmar_readq(iommu->reg + DMAR_VCCAP_REG);
>   
>   	/* the registers might be more than one page */
>   	map_size = max_t(int, ecap_max_iotlb_offset(iommu->ecap),
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 8651f6d4dfa0..0823761f3a7c 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1833,7 +1833,7 @@ static void free_dmar_iommu(struct intel_iommu *iommu)
>   		if (ecap_prs(iommu->ecap))
>   			intel_svm_finish_prq(iommu);
>   	}
> -	if (ecap_vcs(iommu->ecap) && vccap_pasid(iommu->vccap))
> +	if (vccap_pasid(iommu->vccap))
>   		ioasid_unregister_allocator(&iommu->pasid_allocator);
>   
>   #endif
> @@ -3209,7 +3209,7 @@ static void register_pasid_allocator(struct intel_iommu *iommu)
>   	 * is active. All vIOMMU allocators will eventually be calling the same
>   	 * host allocator.
>   	 */
> -	if (!ecap_vcs(iommu->ecap) || !vccap_pasid(iommu->vccap))
> +	if (!vccap_pasid(iommu->vccap))
>   		return;
>   
>   	pr_info("Register custom PASID allocator\n");
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
