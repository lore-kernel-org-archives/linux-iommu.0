Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C0BC433F5
	for <iommu@archiver.kernel.org>; Mon,  2 May 2022 21:28:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E8D78188A;
	Mon,  2 May 2022 21:28:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDEjNSnto_DB; Mon,  2 May 2022 21:28:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3E34C828F2;
	Mon,  2 May 2022 21:28:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11B92C0032;
	Mon,  2 May 2022 21:28:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D403C002D
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:28:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EDDF3405B6
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:28:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLDl2-1X4Q1a for <iommu@lists.linux-foundation.org>;
 Mon,  2 May 2022 21:28:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 366A140621
 for <iommu@lists.linux-foundation.org>; Mon,  2 May 2022 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651526894; x=1683062894;
 h=date:from:to:cc:subject:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7yBpQAIpUfRJwgMGT0q/fayuN5S9gX0zx6AUvjTG+bk=;
 b=Es42mceBT6HsXmzGbBHihO6il6vOjyvFxjg4I7Y2Jwp+Zzj1PrpiH25D
 PTZGbB4s5FImobbFVS4GIZeLu3cv7qAbQ+dalwCGak1+NmAqfeYEVW1B8
 YyDAnxkwAqp7hC0WZJzwGWSODNILtI5yhk+BkdunJfd1t8x0BBGkB6QsK
 MnQFklSt+rQxlOglprgnEHXSdaCThZZMC/b+ENFakRh+P/QN+3yJKKS2Z
 aFjB/LdORSaA43bhMLs2mT44nXKKYYIXxByGmyNwWRfo0iphN0AFayuZZ
 dkcIDG4/ptwa2bVrivoFxS2kGVcPcJXWuAWsrtVQxI+czjAM6B5mdJMAU g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="267208405"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; d="scan'208";a="267208405"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 14:28:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; d="scan'208";a="733632021"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2022 14:28:12 -0700
Date: Mon, 2 May 2022 14:31:54 -0700
From: Jacob Pan <jacob.jun.pan@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/5] iommu/vt-d: Check domain force_snooping against
 attached devices
Message-ID: <20220502143154.444dd1dd@jacob-builder>
In-Reply-To: <20220501112434.874236-4-baolu.lu@linux.intel.com>
References: <20220501112434.874236-1-baolu.lu@linux.intel.com>
 <20220501112434.874236-4-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Alex
 Williamson <alex.williamson@redhat.com>, jacob.jun.pan@intel.com,
 Jason Gunthorpe <jgg@nvidia.com>
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

Hi BaoLu,

On Sun, 1 May 2022 19:24:32 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> As domain->force_snooping only impacts the devices attached with the
> domain, there's no need to check against all IOMMU units. At the same
> time, for a brand new domain (hasn't been attached to any device), the
> force_snooping field could be set, but the attach_dev callback will
> return failure if it wants to attach to a device which IOMMU has no
> snoop control capability.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/pasid.h |  2 ++
>  drivers/iommu/intel/iommu.c | 50 ++++++++++++++++++++++++++++++++++++-
>  drivers/iommu/intel/pasid.c | 18 +++++++++++++
>  3 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index ab4408c824a5..583ea67fc783 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -123,4 +123,6 @@ void intel_pasid_tear_down_entry(struct intel_iommu
> *iommu, bool fault_ignore);
>  int vcmd_alloc_pasid(struct intel_iommu *iommu, u32 *pasid);
>  void vcmd_free_pasid(struct intel_iommu *iommu, u32 pasid);
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 98050943d863..3c1c228f9031 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4554,13 +4554,61 @@ static phys_addr_t
> intel_iommu_iova_to_phys(struct iommu_domain *domain, return phys;
>  }
>  
> +static bool domain_support_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +	bool support = true;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out;
> +
> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!ecap_sc_support(info->iommu->ecap)) {
> +			support = false;
> +			break;
> +		}
> +	}
why not just check the flag dmar_domain->force_snooping? devices wouldn't
be able to attach if !ecap_sc, right?

> +out:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +	return support;
> +}
> +
> +static void domain_set_force_snooping(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	unsigned long flags;
> +
> +	/*
> +	 * Second level page table supports per-PTE snoop control. The
> +	 * iommu_map() interface will handle this by setting SNP bit.
> +	 */
> +	if (!domain_use_first_level(domain))
> +		return;
> +
> +	spin_lock_irqsave(&device_domain_lock, flags);
> +	if (list_empty(&domain->devices))
> +		goto out_unlock;
> +
> +	list_for_each_entry(info, &domain->devices, link)
> +		intel_pasid_setup_page_snoop_control(info->iommu,
> info->dev,
> +						     PASID_RID2PASID);
> +
I guess other DMA API PASIDs need to have sc bit set as well. I will keep
this in mind for my DMA API PASID patch.

> +out_unlock:
> +	spin_unlock_irqrestore(&device_domain_lock, flags);
> +}
> +
>  static bool intel_iommu_enforce_cache_coherency(struct iommu_domain
> *domain) {
>  	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>  
> -	if (!domain_update_iommu_snooping(NULL))
> +	if (!domain_support_force_snooping(dmar_domain))
>  		return false;
> +
> +	domain_set_force_snooping(dmar_domain);
>  	dmar_domain->force_snooping = true;
> +
nit: spurious change
>  	return true;
>  }
>  
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index f8d215d85695..815c744e6a34 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -762,3 +762,21 @@ int intel_pasid_setup_pass_through(struct
> intel_iommu *iommu, 
>  	return 0;
>  }
> +
> +/*
> + * Set the page snoop control for a pasid entry which has been set up.
> + */
> +void intel_pasid_setup_page_snoop_control(struct intel_iommu *iommu,
> +					  struct device *dev, u32 pasid)
> +{
> +	struct pasid_entry *pte;
> +	u16 did;
> +
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (WARN_ON(!pte || !pasid_pte_is_present(pte)))
> +		return;
> +
> +	pasid_set_pgsnp(pte);
> +	did = pasid_get_domain_id(pte);
> +	pasid_flush_caches(iommu, pte, pasid, did);
> +}


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
