Return-Path: <SRS0=CJHf=KH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F8EC433ED
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 17:04:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8D361376
	for <iommu@archiver.kernel.org>; Wed, 12 May 2021 17:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8D361376
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 92A156088E;
	Wed, 12 May 2021 17:04:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nZJk9ZZX0Fu0; Wed, 12 May 2021 17:04:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6148C605D0;
	Wed, 12 May 2021 17:04:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28DE1C000D;
	Wed, 12 May 2021 17:04:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CE9EC0001
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:03:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B5E740409
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:03:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IsOKr_xmSsTh for <iommu@lists.linux-foundation.org>;
 Wed, 12 May 2021 17:03:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 48CF840197
 for <iommu@lists.linux-foundation.org>; Wed, 12 May 2021 17:03:56 +0000 (UTC)
IronPort-SDR: NxSohGENWcd5sCjxRBBR24IGKnrVSnVOi8m82A7RxgJcKbUNMAfW20yrVchl9OLzeoD1//zbJ4
 cOvN41n5SoSw==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="197782467"
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="197782467"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 10:03:52 -0700
IronPort-SDR: EZnuhS0IuWujoEwn2ARLWM9dR+Ej2WeYFGDec7GJnuonITU50yOOwT9KnPIB3ISjn7rz4ZBs+8
 Bw32tv6jxK3g==
X-IronPort-AV: E=Sophos;i="5.82,293,1613462400"; d="scan'208";a="610015657"
Received: from otc-nc-03.jf.intel.com (HELO otc-nc-03) ([10.54.39.36])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2021 10:03:51 -0700
Date: Wed, 12 May 2021 10:03:49 -0700
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RESEND PATACH 1/1] iommu/vt-d: Use user privilege for RID2PASID
 translation
Message-ID: <20210512170349.GB102348@otc-nc-03>
References: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512064426.3440915-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Cc: kevin.tian@intel.com, Ashok Raj <ashok.raj@intel.com>,
 sanjay.k.kumar@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com,
 Will Deacon <will@kernel.org>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, May 12, 2021 at 02:44:26PM +0800, Lu Baolu wrote:
> When first-level page tables are used for IOVA translation, we use user
> privilege by setting U/S bit in the page table entry. This is to make it
> consistent with the second level translation, where the U/S enforcement
> is not available. Clear the SRE (Supervisor Request Enable) field in the
> pasid table entry of RID2PASID so that requests requesting the supervisor
> privilege are blocked and treated as DMA remapping faults.
> 
> Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Fixes: b802d070a52a1 ("iommu/vt-d: Use iova over first level")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 7 +++++--
>  drivers/iommu/intel/pasid.c | 3 ++-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 708f430af1c4..f1742da42478 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2525,9 +2525,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>  				    struct device *dev,
>  				    u32 pasid)
>  {
> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>  	struct dma_pte *pgd = domain->pgd;
>  	int agaw, level;
> +	int flags = 0;
>  
>  	/*
>  	 * Skip top levels of page tables for iommu which has
> @@ -2543,7 +2543,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>  	if (level != 4 && level != 5)
>  		return -EINVAL;
>  
> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
> +	if (pasid != PASID_RID2PASID)
> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
> +	if (level == 5)
> +		flags |= PASID_FLAG_FL5LP;

Given that we are still not bought into the supervisor PASID, should we make this an 
explicit request before turning on SUPERVISOR mode always? Since
pasid_set_sre() has no return, we have no way to fail it.



>  
>  	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
>  		flags |= PASID_FLAG_PAGE_SNOOP;
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 72646bafc52f..72dc84821dad 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -699,7 +699,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>  	 * Since it is a second level only translation setup, we should
>  	 * set SRE bit as well (addresses are expected to be GPAs).
>  	 */
> -	pasid_set_sre(pte);
> +	if (pasid != PASID_RID2PASID)
> +		pasid_set_sre(pte);
>  	pasid_set_present(pte);
>  	pasid_flush_caches(iommu, pte, pasid, did);
>  
> -- 
> 2.25.1
> 

-- 
Cheers,
Ashok

[Forgiveness is the attribute of the STRONG - Gandhi]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
