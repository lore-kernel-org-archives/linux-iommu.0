Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFF117EA
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 02:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHA50cln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697423122; x=1728959122;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kqObKHVKDXZxUOrFR8Ow5sVbkniBlMyVsc2Q+Z/Wwbw=;
  b=GHA50clnL8aUe6vimpykaaVsbGd0sGUfgTK2PHL2A3dBlJQBO8WF4ahj
   Z3zM697OHcDhh9yHidxViuQhs2I3CIF3p1fXUVuhoFXDxacbS4BBkFv4V
   8G9K3N3YTVMHdAUrr+iCyC8FfJ0/uiRJ6lwhhlNbfVVLnSh8wHAgMJ4Gj
   eJX7Xd5Zqjn1/gHvoXos4O/cMRNa5RjQNDONalxbjLrfHxEGVRJ1BiN+2
   bLp/OaGmOuOybHTfe/EgmsNXR54Mjy6YREPeVa84yVi/t0iEsAoweNuBm
   e+0GUU47WeDXuq6LtJ+cGOkqDrwGKWUSz2myrKn67uirWi5FCsst0lTsi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="385270841"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="385270841"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 19:25:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="705430736"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="705430736"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Oct 2023 19:25:17 -0700
Message-ID: <6859c129-7366-423c-9348-96c5fff0d3a0@linux.intel.com>
Date: Mon, 16 Oct 2023 10:21:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Yi Liu <yi.l.liu@intel.com>, Yi Y Sun <yi.y.sun@intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v3 19/19] iommu/intel: Access/Dirty bit support for SL
 domains
Content-Language: en-US
To: Joao Martins <joao.m.martins@oracle.com>, iommu@lists.linux.dev
References: <20230923012511.10379-1-joao.m.martins@oracle.com>
 <20230923012511.10379-20-joao.m.martins@oracle.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230923012511.10379-20-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/23/23 9:25 AM, Joao Martins wrote:
[...]
> +/*
> + * Set up dirty tracking on a second only translation type.

Set up dirty tracking on a second only or nested translation type.

> + */
> +int intel_pasid_setup_dirty_tracking(struct intel_iommu *iommu,
> +				     struct dmar_domain *domain,
> +				     struct device *dev, u32 pasid,
> +				     bool enabled)
> +{
> +	struct pasid_entry *pte;
> +	u16 did, pgtt;
> +
> +	spin_lock(&iommu->lock);
> +
> +	did = domain_id_iommu(domain, iommu);
> +	pte = intel_pasid_get_entry(dev, pasid);
> +	if (!pte) {
> +		spin_unlock(&iommu->lock);
> +		dev_err(dev, "Failed to get pasid entry of PASID %d\n", pasid);

Use dev_err_ratelimited() to avoid user DOS attack.

> +		return -ENODEV;
> +	}

Can we add a check to limit this interface to second-only and nested
translation types? These are the only valid use cases currently and for
the foreseeable future.

And, return directly if the pasid bit matches the target state.

[...]
         spin_lock(&iommu->lock);
         pte = intel_pasid_get_entry(dev, pasid);
         if (!pte) {
                 spin_unlock(&iommu->lock);
                 dev_err_ratelimited(dev, "Failed to get pasid entry of 
PASID %d\n", pasid);
                 return -ENODEV;
         }

         did = domain_id_iommu(domain, iommu);
         pgtt = pasid_pte_get_pgtt(pte);

         if (pgtt != PASID_ENTRY_PGTT_SL_ONLY && pgtt != 
PASID_ENTRY_PGTT_NESTED) {
                 spin_unlock(&iommu->lock);
                 dev_err_ratelimited(dev,
                                     "Dirty tracking not supported on 
translation type %d\n",
                                     pgtt);
                 return -EOPNOTSUPP;
         }

         if (pasid_get_ssade(pte) == enabled) {
                 spin_unlock(&iommu->lock);
                 return 0;
         }

         if (enabled)
                 pasid_set_ssade(pte);
         else
                 pasid_clear_ssade(pte);
         spin_unlock(&iommu->lock);
[...]

> +
> +	pgtt = pasid_pte_get_pgtt(pte);
> +
> +	if (enabled)
> +		pasid_set_ssade(pte);
> +	else
> +		pasid_clear_ssade(pte);
> +	spin_unlock(&iommu->lock);


Add below here:

         if (!ecap_coherent(iommu->ecap))
                 clflush_cache_range(pte, sizeof(*pte));

> +
> +	/*
> +	 * From VT-d spec table 25 "Guidance to Software for Invalidations":
> +	 *
> +	 * - PASID-selective-within-Domain PASID-cache invalidation
> +	 *   If (PGTT=SS or Nested)
> +	 *    - Domain-selective IOTLB invalidation
> +	 *   Else
> +	 *    - PASID-selective PASID-based IOTLB invalidation
> +	 * - If (pasid is RID_PASID)
> +	 *    - Global Device-TLB invalidation to affected functions
> +	 *   Else
> +	 *    - PASID-based Device-TLB invalidation (with S=1 and
> +	 *      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions
> +	 */
> +	pasid_cache_invalidation_with_pasid(iommu, did, pasid);
> +
> +	if (pgtt == PASID_ENTRY_PGTT_SL_ONLY || pgtt == PASID_ENTRY_PGTT_NESTED)
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
> +	else
> +		qi_flush_piotlb(iommu, did, pasid, 0, -1, 0);

Only "Domain-selective IOTLB invalidation" is needed here.

> +
> +	/* Device IOTLB doesn't need to be flushed in caching mode. */
> +	if (!cap_caching_mode(iommu->cap))
> +		devtlb_invalidation_with_pasid(iommu, dev, pasid);

For the device IOTLB invalidation, need to follow what spec requires.

   If (pasid is RID_PASID)
    - Global Device-TLB invalidation to affected functions
   Else
    - PASID-based Device-TLB invalidation (with S=1 and
      Addr[63:12]=0x7FFFFFFF_FFFFF) to affected functions

> +
> +	return 0;
> +}
> +

Best regards,
baolu
