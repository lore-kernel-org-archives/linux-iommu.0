Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B715D8BFA
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719879489; cv=none; b=Tm8wSpJrVY1+UK3pYv3I5sH1O1I1DF+RFcecv5P8YY+OxZPkarezMZ7BsIoa3pok6qBgO8swdhl1vj4JU/hp2JWCc+XJwpkJX+ZdQ697ygK0TcdJe0u7aJSZxQRrg1QYI2ikU6lHQ5gwIiv1ObjTtEiGQh1Nv1+1PD0EG3UMMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719879489; c=relaxed/simple;
	bh=zXHRxJfQ76pZA5jJuEeDkgW74LynXLABZeuPfCmaDGI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ArgG0DTDkf65Q3YsU1bYgty9aOX0cxSwoe+9ZttycYQuKIxJFju1jycleXgdQyBWaCVYq/PLiaL9ukLZT6D0aA5KeJZxktyqVl+tvRxN9pZ5J2ujtS6C0V/3+A7yALrgNl209kaQGubd5+AVNkZRiTbtJfvDR+IFCZBI8TNOOjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d+xss2fp; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d+xss2fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719879488; x=1751415488;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zXHRxJfQ76pZA5jJuEeDkgW74LynXLABZeuPfCmaDGI=;
  b=d+xss2fpeFMjdoP1gR0eiUPYfOJkaQcFGTg6hBbq2jLdf2TQGJpjXss7
   qY0fNxJv0CIrxFebKlJEgsJRH91g8jvFactcEKfy/OZ71kTqxxtgZggBq
   f0APiOsqfMSPEbY+mMM8t8W0j8iHn2VFYD5kERBELqryM9Ul96hi4qShj
   5D3abBFaf5EMqvqKtJAfBNZvO13PohcVC1h3wfHYcUAITVu+rgccMWyYb
   tYJT3P5YiHA1XzvT6K6Xu2ep9qm3BA2cdJ+KlgS4C8ZasKV7VO4qd9s0B
   wruy0DW+Ad0eFxTbMUdUZgWxEwbcBdoXRxtxAV9EtoQdGiE26WuLdMGu9
   g==;
X-CSE-ConnectionGUID: MfkhNfnKTL6yzIuAvnVNkA==
X-CSE-MsgGUID: BV0XIb9tSV+BkGACg2tNPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="16987087"
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="16987087"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 17:18:08 -0700
X-CSE-ConnectionGUID: YY4/KY8YSIqWsHANr3ImDA==
X-CSE-MsgGUID: TN8Xm8u8Tp6Bt/zNut4/ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,177,1716274800"; 
   d="scan'208";a="68912610"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2024 17:18:07 -0700
Date: Mon, 1 Jul 2024 17:23:19 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
 <kevin.tian@intel.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v2 1/2] iommu/vt-d: Add helper to flush caches for
 context change
Message-ID: <20240701172319.264e718c@jacob-builder>
In-Reply-To: <20240627023121.50166-2-baolu.lu@linux.intel.com>
References: <20240627023121.50166-1-baolu.lu@linux.intel.com>
	<20240627023121.50166-2-baolu.lu@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


On Thu, 27 Jun 2024 10:31:20 +0800, Lu Baolu <baolu.lu@linux.intel.com>
wrote:

> +/*
> + * Cache invalidations after change in a context table entry that was
> present
> + * according to the Spec 6.5.3.3 (Guidance to Software for
> Invalidations). If
> + * IOMMU is in scalable mode and all PASID table entries of the device
> were
> + * non-present, set affect_domains to true. Otherwise, false.
> + */
The spec says:
"Domain-selective PASID-cache invalidation to affected domains (can be
skipped if all PASID entries were not-present and CM=0)"

So we should skip PASID cache invalidation if affect_domain is true
according to this comment.

> +void intel_context_flush_present(struct device_domain_info *info,
> +				 struct context_entry *context,
> +				 bool affect_domains)
> +{
> +	struct intel_iommu *iommu = info->iommu;
> +	u16 did = context_domain_id(context);
> +	struct pasid_entry *pte;
> +	int i;
> +
> +	assert_spin_locked(&iommu->lock);
> +
> +	/*
> +	 * Device-selective context-cache invalidation. The Domain-ID
> field
> +	 * of the Context-cache Invalidate Descriptor is ignored by
> hardware
> +	 * when operating in scalable mode. Therefore the @did value
> doesn't
> +	 * matter in scalable mode.
> +	 */
> +	iommu->flush.flush_context(iommu, did, PCI_DEVID(info->bus,
> info->devfn),
> +				   DMA_CCMD_MASK_NOBIT,
> DMA_CCMD_DEVICE_INVL); +
> +	/*
> +	 * For legacy mode:
> +	 * - Domain-selective IOTLB invalidation
> +	 * - Global Device-TLB invalidation to all affected functions
> +	 */
> +	if (!sm_supported(iommu)) {
> +		iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		__context_flush_dev_iotlb(info);
> +
> +		return;
> +	}
> +
> +	/*
> +	 * For scalable mode:
> +	 * - Domain-selective PASID-cache invalidation to affected
> domains
> +	 * - Domain-selective IOTLB invalidation to affected domains
> +	 * - Global Device-TLB invalidation to affected functions
> +	 */
> +	if (affect_domains) {
> +		for (i = 0; i < info->pasid_table->max_pasid; i++) {
> +			pte = intel_pasid_get_entry(info->dev, i);
> +			if (!pte || !pasid_pte_is_present(pte))
> +				continue;
> +
> +			did = pasid_get_domain_id(pte);
> +			qi_flush_pasid_cache(iommu, did,
> QI_PC_ALL_PASIDS, 0);
This is conflicting with the comments above where PASID cache flush can be
skipped if affect_domain==true, no?

> +			iommu->flush.flush_iotlb(iommu, did, 0, 0,
> DMA_TLB_DSI_FLUSH);
> +		}
> +	}

Thanks,

Jacob
