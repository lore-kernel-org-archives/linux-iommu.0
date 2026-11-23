Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447250;
	b=W1VCvr+T0KfOtp6O/jTxZKJnDDb6BGRXPSWzOZ/8A/A88jraSWNMjOvkj+a/F2e3fMVW
	 181SlIcuJ824U4pHucnYiU1ltImpp+Y2ZJEcccyFIovvTbjslE2JLQWdMXh7lQ1m7ESv0
	 k4bwK/UynMp9/xKP4rZK8yFVvS7AzpMexm7MqRzxL+ya6DbL1r27mldAQYuJ2mTk2b5C1
	 iAli7ViL1sBWmjZsgEWzNghqFQxzTcgp6PgKYUluB/mZwPtkmQFY+oRa2e9Ygybwc+hMn
	 k0T8u++CbVaA7IfnQojpTqH4HX6wPuid5TbOggMtRcWhbTQ5Lcq/iXRUDZDIrbgJPvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447250;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=KnHPy1hhJFM96Jur6TKylq8tiIqT2jgnnLbxXbR2WEA=;
	b=r8qPc9LSpozFvtdRtWFEE0SnOFEH1TPDs3irAnSoZEg5H/2EZUKSDy2SShEGGtMi8rPs
	 rH9ylBNrcrsVQ+T36OMd/BJnX4RudrTpbcypRzNB1T0yOIhntrAXNGsQffpK9VwLVFCUs
	 n91gLDpR+/ql0P5FcodCYI31uUaym7o/KeosjQKF4tmHOzdwfT5dZ6zHVShZwMy0kaaTo
	 y1NFwRCnj6gWndNztXw+g6nZiia6V2PziRtbYMzlbrgD7DPATDvIYDYAbPIDrFPXKbc04
	 eXwYxFA+ffbp41sRCeeo72Hth+bEwBz/QOV7ExuOlpj4LAXy7uoD+9QIqmWlfKRh0yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eM5cupxw;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBF3606A321;
	Mon, 23 Nov 2026 15:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEBF3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eM5cupxw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795447250; x=1826983250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jEhltNhYqHsmjiCu7dIjRvqg/4zmhsCr7YHqofX1yDo=;
  b=eM5cupxwEPk8HfJd4+Da27sPZW5WRsoDzy8g01iL5Q19GaJnSbKZhnFD
   PgMLwKpPo6gKAV6trnUFVyQjHXfe6wBFMBHc0c536J+MdlmiDeUSrhS4v
   UMX+aOrW2XjR2G6eiZmhuDCwOk7aNFhpj9fI+noNarj8S2ABmIScGfiSR
   bYbpFkuRWQmAEsR5oISCCTtdH+3h2OAl0hTZ2k9JxsPG4F76c2PCZr9ZX
   ujU4f4PVGlM6ThrbKr2gmalajAixKRlkVnSsIuWpSixCpIXrHLaGKTzyy
   /BbeTrTqNg9IVWai24XYno5zUU0h17AZduWTaSw8nX2pYes878elYwdl4
   A==;
X-CSE-ConnectionGUID: ROWbQygSRDyFcRC9Pc+2eA==
X-CSE-MsgGUID: Y7Whf/AcRqWM6e9GOwFt/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4292271"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4292271"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 07:17:56 -0800
X-CSE-ConnectionGUID: CeKYDNsLTKeqsA654pVU/w==
X-CSE-MsgGUID: N6b6/JfDTT6hqzBIDYN4UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11523457"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa002.fm.intel.com with ESMTP; 23 Nov 2026 07:17:53 -0800
Date: Mon, 23 Nov 2026 23:08:12 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, x86@kernel.org, linux-coco@lists.linux.dev,
	kvm@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>, xiaoyao.li@intel.com,
	Chao Gao <chao.gao@intel.com>,
	Binbin Wu <binbin.wu@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] iommu/vt-d: Add interface for tdx-host when
 enabling trusted DMA
Message-ID: <awRW3ESp3sBoxtJ9@yilunxu-OptiPlex-7050>
References: <20261112043054.2664857-1-baolu.lu@linux.intel.com>
 <20261112043054.2664857-5-baolu.lu@linux.intel.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112043054.2664857-5-baolu.lu@linux.intel.com>

> Add a per-device interface so that an IOMMU is put into Secure TDX Mode
> only when a device behind it needs trusted DMA. tdx-host tracks how many
> devices use each IOMMU and calls into the VT-d driver only for the first
> and the last of them:
> 
> - dmar_tdxc_get_params() looks up the DMAR unit translating the device

I think tdxc is not a good name since "TDX Connect" is not preferred as
a technical term. These APIs would be used by x86/tdx, so can we at
least avoid using tdxc for these APIs?

[...]

> +static void dmar_tdxc_fill_params(struct dmar_drhd_unit *drhd,
> +				  struct dmar_tdxc_params *params)
> +{
> +	params->reg_base_addr = drhd->reg_base_addr;
> +	params->node = drhd->iommu->node;
> +	/*
> +	 * params->drhd stays valid because trusted DMA-capable units are
> +	 * never hot-removed.
> +	 */
> +	params->drhd = drhd;

Why we store drhd in the params, any information to expose to TDX via
drhd?

[...]

> +/*
> + * dmar_tdxc_get_params() - Get the IOMMU information for a device
> + * @dev: PCI device that will use trusted DMA
> + * @params: Filled in on success
> + *
> + * Look up the IOMMU that translates @dev and return what tdx-host needs
> + * to issue TDH.IOMMU.SETUP and TDH.IOMMU.CLEAR on it. This only reads
> + * information and doesn't change any state. Devices behind the same
> + * IOMMU get the same @params->reg_base_addr.
> + *
> + * Return 0 on success and error code on failure.
> + */
> +int dmar_tdxc_get_params(struct pci_dev *pdev, struct dmar_tdxc_params *params)
> +{
> +	struct dmar_drhd_unit *drhd = dmar_tdxc_find_drhd(pdev);
> +
> +	if (IS_ERR(drhd))
> +		return PTR_ERR(drhd);
> +
> +	dmar_tdxc_fill_params(drhd, params);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_get_params, "tdx-host");
> +
> +/*
> + * dmar_tdxc_acquire() - Acquire an IOMMU for TDH.IOMMU.SETUP
> + * @dev: PCI device that will use trusted DMA
> + * @params: Returned by dmar_tdxc_get_params() for @dev
> + *
> + * Call this right before issuing TDH.IOMMU.SETUP for the first user of
> + * the IOMMU. On success, the caller must issue TDH.IOMMU.SETUP and call
> + * dmar_tdxc_release() if it fails. The caller owns the per-IOMMU refcount
> + * and must serialize all calls for the same IOMMU.
> + *
> + * Return: 0 on success and error code on failure.
> + */
> +int dmar_tdxc_acquire(struct pci_dev *pdev,
> +		      const struct dmar_tdxc_params *params)
> +{
> +	struct dmar_drhd_unit *drhd = params->drhd;
> +	struct intel_iommu *iommu = drhd->iommu;
> +	int ret;
> +
> +	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))

We can get drhd via pci_dev, then why we require callers to input
this info and judge? Like an intelligence test?

Thanks,
Yilun

> +		return -EINVAL;
> +
> +	guard(mutex)(&drhd->tdxc_lock);
> +	/* Still set if TDH.IOMMU.CLEAR failed and tdx-host was reloaded. */
> +	if (iommu->tdxc_acquired)
> +		return -EBUSY;
> +
> +	/*
> +	 * TDH.IOMMU.SETUP requires DMA translation, queued invalidation and
> +	 * scalable mode to be enabled. Catch these here so the error is
> +	 * -EINVAL rather than an opaque TDX_IOMMU_INVALID_STATE.
> +	 */
> +	if (!(iommu->gcmd & DMA_GCMD_TE) || !iommu->qi || !sm_supported(iommu))
> +		return -EINVAL;
> +
> +	ret = dmar_tdxc_reserve_did(iommu);
> +	if (ret)
> +		return ret;
> +
> +	dmar_tdxc_set_acquired(iommu, true);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_acquire, "tdx-host");
> +
> +/*
> + * dmar_tdxc_release() - Take an IOMMU out of Secure TDX Mode
> + * @dev: PCI device whose IOMMU was acquired via dmar_tdxc_acquire()
> + * @params: Returned by dmar_tdxc_get_params() for @dev
> + *
> + * Call this if TDH.IOMMU.SETUP fails, or for the last user of the IOMMU
> + * after TDH.IOMMU.CLEAR has succeeded.
> + */
> +void dmar_tdxc_release(struct pci_dev *pdev,
> +		       const struct dmar_tdxc_params *params)
> +{
> +	struct dmar_drhd_unit *drhd = params->drhd;
> +
> +	if (WARN_ON(dmar_tdxc_find_drhd(pdev) != drhd))
> +		return;
> +
> +	guard(mutex)(&drhd->tdxc_lock);
> +	if (WARN_ON(!drhd->iommu->tdxc_acquired))
> +		return;
> +
> +	dmar_tdxc_set_acquired(drhd->iommu, false);
> +	dmar_tdxc_unreserve_did(drhd->iommu);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(dmar_tdxc_release, "tdx-host");
> -- 
> 2.43.0
> 
