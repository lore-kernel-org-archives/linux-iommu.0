Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C553803FD
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 08:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731560; cv=none; b=HCmixP2ERdTyVEj9ndrrSx6Tm2ydGFvBbCRJcMUQEAK7JBFO8Gg4BXtwciL4dxLNMg5JF66TWUf4cCOfX9o/liGcPIqF4vN1A7kF/ifm+mUgIza5zps58+geVKU7ODa6aPlxAdWNUn/cHyaCfn2Jh44AnnvgRbnOAOj7/kJQ364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731560; c=relaxed/simple;
	bh=bkjiUmi4q16nO656UkaZfuh/7jbNbfvJjs6cLNisWVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5roQFxNAA25uK+zjg++Q4XAKGX/+oG7tx73mPPhgwsae2FfMNiPkzRWly7pSPcCn8gEYgi5JYNlfYm3Oc0HmVhQzsJsNK65r5z/MqutpALGlIr8XeGvBl2lo/dYBP6DwPt1l+N5PzKS/040WCih2NEUXQ1y+hc6RqTZrvYGmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrktiOE9; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrktiOE9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787731559; x=1819267559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bkjiUmi4q16nO656UkaZfuh/7jbNbfvJjs6cLNisWVs=;
  b=TrktiOE9lSqtUPveWJbjTMdVL7op0EzZsL405NYLQmQlQxm9bajkWhWG
   IkUcE7LWwv+ZkfAVSzn9LtAoKxzDc7QadxCTmc+AQOXg/wUMS/qnJQL3t
   NQPvjXyyN0JCdUIip+xmOzI0MD7PhEpPR0OOYsAqpNO3z+DEpC5E4/zut
   xwMyg/tT8/mLlySNlGUw0yr8cEqeOdnlP/G/+i7m+U/caFhRpEx5XMWMl
   V31GQ8i7yytrp8IstHCUVX3+imdnZP5IS7TP9JPSN7NhxpZ0tlwVil0un
   +t7CO5gKEn8jD0Yv/iuJ39C3P0/G6osvb0uSg7h9o+Bhjue/N8lV8apsr
   w==;
X-CSE-ConnectionGUID: R5EwEa9OQheXB40bORft9w==
X-CSE-MsgGUID: yulh1S+1RBWIlah83p6nZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="88235483"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="88235483"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:05:58 -0700
X-CSE-ConnectionGUID: QDdWVPiFQEyfhCtzESp+3g==
X-CSE-MsgGUID: IK2Sz66uTFOu21+4qTcFzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="291037790"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:05:53 -0700
Message-ID: <446684d8-44d0-47c5-9301-172c55efd950@linux.intel.com>
Date: Wed, 26 Aug 2026 16:05:51 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-9-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260808022723.3893618-9-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/26 10:27, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices and root entries for the
> unpreserved context tables need to be cleared.

The key assumption here seems to be that, during a live-update kexec,
most devices do not go through the normal iommu release path. Otherwise,
their context entries should already be torn down in the
iommu_release_device path.

Could you please confirm this assumption and add some short note in the
comments or commit message?

> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  15 +++-
>   drivers/iommu/intel/iommu.h      |   5 ++
>   drivers/iommu/intel/liveupdate.c | 140 +++++++++++++++++++++++++++++++
>   3 files changed, 158 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index aeae0563dfd0..eca3944d9cf5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1832,6 +1832,14 @@ static int iommu_suspend(void *data)
>   
>   	iommu_flush_all();
>   
> +	/*
> +	 * Note that IOMMU suspend doesn't affect live update. The state
> +	 * preserved during live update is not released and remains valid during
> +	 * suspend and reused during IOMMU resume.
> +	 *
> +	 * Also note deployment of suspend/resume and live updated use case
> +	 * should be mostly mutually exclusive.
> +	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_disable_translation(iommu);
>   
> @@ -2377,8 +2385,11 @@ void intel_iommu_shutdown(void)
>   		/* Disable PMRs explicitly here. */
>   		iommu_disable_protect_mem_regions(iommu);
>   
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		/* Make sure the IOMMUs are switched off if not preserved. */
> +		if (iommu_preserved_state(&iommu->iommu))
> +			clear_unpreserved_context_entries(iommu);
> +		else
> +			iommu_disable_translation(iommu);
>   	}
>   }
>   
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 4906cce1e66e..6c971f04ead3 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1306,6 +1306,7 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   			 struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
> +void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>   #else
>   static inline int intel_iommu_preserve_device(struct device *dev,
>   					      struct iommu_device_ser *device_ser)
> @@ -1328,6 +1329,10 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
>   					  struct iommu_hw_ser *iommu_ser)
>   {
>   }
> +
> +static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index ffdcebf2b773..b5aaebeeb5c1 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -77,6 +77,146 @@ static int preserve_context_table(struct intel_iommu *iommu,
>   	return 0;
>   }
>   
> +static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
> +						   struct iommu_hw_ser *ser)
> +{
> +	struct root_entry *root;
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		root = &iommu->root_entry[i];
> +
> +		if (!is_context_table_preserved(iommu, ser, i, 0) && (root->lo & 1)) {
> +			root->lo = 0;
> +			__iommu_flush_cache(iommu,
> +					    &root->lo,
> +					    sizeof(root->lo));
> +		}
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		if (!is_context_table_preserved(iommu, ser, i, 0x80) && (root->hi & 1)) {
> +			root->hi = 0;
> +			__iommu_flush_cache(iommu,
> +					    &root->hi,
> +					    sizeof(root->hi));
> +		}
> +	}
> +}
> +
> +static void clear_unpreserved_context(struct device_domain_info *info, u8 bus, u8 devfn)
> +{
> +	struct context_entry *context;
> +
> +	/*
> +	 * This cleanup is done during shutdown, so it should be fine to only
> +	 * clear the entries here and issue one global invalidation later to
> +	 * invalidate all cleared entries.
> +	 *
> +	 * Note that the device IOTLB invalidation for unpreserved devices is
> +	 * skipped this way, but that should not be needed as the devices are
> +	 * quiesced at this point. This should improve the performance of the
> +	 * cleanup process and avoids any invalidation timeouts because drivers
> +	 * might have moved devices to D3 state.
> +	 */
> +	context = iommu_context_addr(info->iommu, bus, devfn, 0);
> +	if (context) {
> +		context_clear_entry(context);
> +		__iommu_flush_cache(info->iommu, context, sizeof(*context));

For tearing down a present context entry, please follow the VT-d
recommended sequence:

- clear only the Present bit,
- flush the updated entry to memory if necessary,
- issue the required cache invalidations,
- then clear the remaining fields of the entry.

> +	}
> +}
> +
> +static int clear_unpreserved_alias_cb(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct device_domain_info *info = data;
> +
> +	clear_unpreserved_context(info, PCI_BUS_NUM(alias), alias & 0xff);
> +	return 0;
> +}
> +
> +static int clear_unpreserve_context_entry_fn(struct device *dev,
> +					     struct iommu_device *iommu_dev,
> +					     void *arg)
> +{
> +	struct device_domain_info *info;
> +	struct context_entry *context;
> +
> +	info = dev_iommu_priv_get(dev);
> +	if (!info)
> +		return 0;
> +
> +	if (!dev_is_pci(dev) || !dev_iommu_preserved_state(dev))
> +		goto out_unpreserved;
> +
> +	/*
> +	 * PRE use cases are not supported with Live Update and a preservation
> +	 * attempt on such domains returns an error. But Intel IOMMU driver
> +	 * enables PRE by default on all devices that support it. For preserved
> +	 * entries, the PRE needs to be disabled so preserved PCI devices do not
> +	 * generate PRQs, during kexec, as translations are kept enabled during
> +	 * live update. There is no need to disable these for DMA aliases.
> +	 */
> +	if (sm_supported(info->iommu)) {
> +		context = iommu_context_addr(info->iommu, info->bus, info->devfn, 0);

Nit: please add a brief comment explaining why locking is not needed at
this call site.

> +		if (context) {
> +			context_clear_sm_pre(context);

For cache invalidation considerations when changing the PRE bit in a
present context entry, please follow the VT-d spec guidance (Table 28,
“Guidance to Software for Invalidations”).

> +			__iommu_flush_cache(info->iommu, context, sizeof(*context));
 > +		}> +	}
> +
> +	return 0;
> +
> +out_unpreserved:
> +	if (dev_is_pci(dev))
> +		pci_for_each_dma_alias(to_pci_dev(dev),
> +					clear_unpreserved_alias_cb, info);
> +	else
> +		clear_unpreserved_context(info, info->bus, info->devfn);
> +
> +	return 0;
> +}
> +
> +/**
> + * clear_unpreserved_context_entries() - Clear context entries for unpreserved devices
> + * @iommu: Target IOMMU
> + *
> + * Clear the context entries of unpreserved devices during shutdown before kexec.
> + */
> +void clear_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +	struct iommu_dev_iter iter = {
> +		.fn = clear_unpreserve_context_entry_fn,
> +		.iommu = &iommu->iommu,
> +		.arg = NULL,
> +
> +	};
> +
> +	/*
> +	 * Clear context entries for unpreserved devices.
> +	 *
> +	 * Note that the error can be ignored as the iterator function does not
> +	 * fail.
> +	 */
> +	iommu_for_each_dev(&iter);
> +
> +	/* Clear reference to unpreserved context tables */
> +	clear_unpreserved_context_root_entries(iommu,
> +					       iommu_preserved_state(&iommu->iommu));
> +
> +	/*
> +	 * Some devices might not have teardown/detached properly depending on
> +	 * whether a proper device remove is done before kexec is triggered.
> +	 * Also unpreserved context tables and entries are removed during
> +	 * shutdown. So issue global invalidations to remove references to
> +	 * unpreserved tables and entries.
> +	 */
> +	iommu->flush.flush_context(iommu, 0, 0, 0, DMA_CCMD_GLOBAL_INVL);
> +	if (sm_supported(iommu))
> +		qi_flush_pasid_cache(iommu, 0, QI_PC_GLOBAL, 0);
> +	iommu->flush.flush_iotlb(iommu, 0, 0, 0, DMA_TLB_GLOBAL_FLUSH);
> +}
> +
>   static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
>   					    struct iommu_hw_ser *ser)
>   {

Thanks,
baolu
