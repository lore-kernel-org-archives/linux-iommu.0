Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC6AC433ED
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:07:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 928C4613EF
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C4613EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 627B484AFE;
	Tue,  6 Apr 2021 01:07:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w6_SJnZvfdSy; Tue,  6 Apr 2021 01:07:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2E95284AB8;
	Tue,  6 Apr 2021 01:07:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBBC7C000C;
	Tue,  6 Apr 2021 01:07:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5FE1CC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:07:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 47DA084AF3
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8J2S9SOIzBdF for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 01:07:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0031D84AB8
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:07:37 +0000 (UTC)
IronPort-SDR: FtvBiWRkVlKi5oGvl7kWdHMj/hWbUj9eHMrE6p0/s7j3B/jg/KqYRciCIBxTNi54/0PjfkGNGy
 wLeNds3oWvag==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="256942306"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="256942306"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:07:36 -0700
IronPort-SDR: Wtwhc4FlTpvJsuXZDx/ruo9zOYrdhP9yb/4kWwe7nLyGVLSKtTejyMTw8aQadzl5gMAJGAKmyB
 +fG8nCb/dG4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="440713227"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga004.fm.intel.com with ESMTP; 05 Apr 2021 18:07:34 -0700
Subject: Re: [PATCH v2 4/5] iommu/vt-d: Use user privilege for RID2PASID
 translation
To: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <20210320025415.641201-1-baolu.lu@linux.intel.com>
 <20210320025415.641201-5-baolu.lu@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <84f0ca29-04e0-446b-745a-73e2f9e49f3b@linux.intel.com>
Date: Tue, 6 Apr 2021 08:58:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210320025415.641201-5-baolu.lu@linux.intel.com>
Content-Language: en-US
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On 3/20/21 10:54 AM, Lu Baolu wrote:
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

We found some devices still require SRE to be set during internal tests.
I will drop this patch from my queue for v5.13 for now.

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 7 +++++--
>   drivers/iommu/intel/pasid.c | 3 ++-
>   2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 868f195f55ff..7354f9ce47d8 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2494,9 +2494,9 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   				    struct device *dev,
>   				    u32 pasid)
>   {
> -	int flags = PASID_FLAG_SUPERVISOR_MODE;
>   	struct dma_pte *pgd = domain->pgd;
>   	int agaw, level;
> +	int flags = 0;
>   
>   	/*
>   	 * Skip top levels of page tables for iommu which has
> @@ -2512,7 +2512,10 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
>   	if (level != 4 && level != 5)
>   		return -EINVAL;
>   
> -	flags |= (level == 5) ? PASID_FLAG_FL5LP : 0;
> +	if (pasid != PASID_RID2PASID)
> +		flags |= PASID_FLAG_SUPERVISOR_MODE;
> +	if (level == 5)
> +		flags |= PASID_FLAG_FL5LP;
>   
>   	return intel_pasid_setup_first_level(iommu, dev, (pgd_t *)pgd, pasid,
>   					     domain->iommu_did[iommu->seq_id],
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 0bf7e0a76890..dd69df5a188a 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -673,7 +673,8 @@ int intel_pasid_setup_second_level(struct intel_iommu *iommu,
>   	 * Since it is a second level only translation setup, we should
>   	 * set SRE bit as well (addresses are expected to be GPAs).
>   	 */
> -	pasid_set_sre(pte);
> +	if (pasid != PASID_RID2PASID)
> +		pasid_set_sre(pte);
>   	pasid_set_present(pte);
>   	pasid_flush_caches(iommu, pte, pasid, did);
>   
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
