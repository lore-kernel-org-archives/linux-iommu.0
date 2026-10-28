Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157530;
	b=FWakc7t7xXsK1LtoyyncdbcCyLn5mz/ox90XVtBeLta4J+R44CedWKQ60DTkxL5xwoqQ
	 zBgFTUhuFPII13rBVXuVHt2LwzxH08fO7XZRkhg2UEz8pD0AsIKbDFG4CYU2RlqsZUbkf
	 uAoq4C+wm/CBnoe/qLuQH66z1XEnyUuLGOUEVOKrMAXkz//EB1tTxXsXU9/YvIVtpPryP
	 mEGocR6j2WW88WvBGtidi11kD+jTkefR9fpdKmxnDl1BXoT5kslsdoue4MSPqwC7JR9UM
	 0bDTaCb4o/4CdsqQnDB3VK5UlZFxGLeYzifNZI47gCNWue1vHcua+xi3P6io6mLg/Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157530;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zcVRP60kSZ5drgSk7VT9YUdjauM1eQZNXX4ZdNEnKfg=;
	b=Wgh2Xuf4ZfcQkMaC9X2T2sigGdcohvL29Uo3D4ModyvjLperY7ppRwUk8Cm2f1fl0glO
	 z5y+Ev/bLS/4rflpXf5ip69LPoeNL2pX9tWF/JI0jI/afXiXKBUU4V/GEvXFqpkzRd0aQ
	 pEm0iPBGMc9T5T0PgPQM+jRUV4Xn6bco6wM/DlwtAIDtI2R9buFfmbYw1nxT1Y0P3T1ZR
	 UPNzEDAQJ1NEfHDDH4itxE/anawO6WVRYARmgdOLH4AJT8j4PkT2WTW8JwXzjNMG3qBbR
	 76+QZqMrzM5fjWs503KBFcciRd+e25WG2fyY7DfRxLYKi09Ogl3l7U9ToAMVchqDeSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M1RkfuVl;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BD3606A31D
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 03:18:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92BD3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M1RkfuVl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793157529; x=1824693529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HzF0gWj9SRl/iroW/XGN6OMcBOsxLK83/ID1AhzttR0=;
  b=M1RkfuVl1rfJFUE+gac3PNseuOdZMUCCMzLODdzaME2qEua+a+bKh1bi
   puasxRySCGIbncyAK4nHTbsPkJSm4Nxqfrtv4oqt7a6CO20Yv/2CjLauf
   tC+Bu78IHVkn7X9chImGWmXLyPxR+FmKI3pVdn5Zuk7FiTrNDfTTDehhB
   fkGTqljyh1FJY9MnZCFRt53WLEX/s+wcrPfF0z9+L8hwjj8wneUNTBSXY
   Gh/40XyGdJ/KzNBYLzgaMigrLE5McyXfTPTYfoaTPghb2t+5ZSXYhbFOV
   X7zIJdhuvIDvOn5XgDeckaGjYxuypnZZHF8droFjYSHbgjZLCTADXWtel
   A==;
X-CSE-ConnectionGUID: Wl0FC4PlQlyJ+BUZEMrUhw==
X-CSE-MsgGUID: 61+947DuTeq132RVwt92dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1763859"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1763859"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 20:18:48 -0700
X-CSE-ConnectionGUID: t8kKlqWqT/qvxHLrNwG8fA==
X-CSE-MsgGUID: gEheCPOOT8Gs6PdG+XPmnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="5059767"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 20:18:42 -0700
Message-ID: <3a31d343-68e2-4329-bd72-76a80b4edf81@linux.intel.com>
Date: Wed, 28 Oct 2026 11:18:40 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/18] iommu/vt-d: Clear unpreserved context entries
 during shutdown
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-8-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-8-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 10:19, Samiullah Khawaja wrote:
> During normal shutdown the iommu translation is disabled. Since the root
> table is preserved during live update, it needs to be cleaned up and the
> context entries of the unpreserved devices and root entries for the
> unpreserved context tables need to be cleared.
> 
> This is required because during kexec reboot and shutdown the devices do
> not go through the release flow, so there might be stale entries in the
> root table and context tables. Also note that new unpreserved context
> tables for unpreserved devices might have been added after preservation,
> so the root table entries for unpreserved context tables also need to
> removed.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  15 +++-
>   drivers/iommu/intel/iommu.h      |   5 ++
>   drivers/iommu/intel/liveupdate.c | 134 +++++++++++++++++++++++++++++++
>   3 files changed, 152 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 14bd1ca4fbd5..23a1da351ddf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1967,6 +1967,14 @@ static int iommu_suspend(void *data)
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
> @@ -2512,8 +2520,11 @@ void intel_iommu_shutdown(void)
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
> index a6c0ed55db30..16ab103d308a 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1316,6 +1316,11 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   			 struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
> +void clear_unpreserved_context_entries(struct intel_iommu *iommu);
> +#else
> +static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 0047f9d92cbc..f92cb774cc99 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -82,6 +82,140 @@ static int preserve_context_table(struct intel_iommu *iommu,
>   	return 0;
>   }
>   
> +static void clear_unpreserved_context_root_entries(struct intel_iommu *iommu,
> +						   struct iommu_hw_ser *ser)
> +{
> +	struct root_entry *root;
> +	int i;
> +
> +	/*
> +	 * Individual invalidations for each context table removal are not
> +	 * needed as we issue global invalidations later.
> +	 */
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
> +	 * skipped this way. This matches the normal kexec reboot, where the
> +	 * IOMMU translation is disabled without invalidating the device IOTLBs,
> +	 * and the unpreserved devices go through the same flow in the next
> +	 * kernel as they do after a normal kexec reboot. Issuing device IOTLB
> +	 * invalidations this late during shutdown could also cause invalidation
> +	 * timeouts, as drivers might have moved devices to a low power state,
> +	 * and would add to the shutdown time.
> +	 *
> +	 * The iommu lock is not needed as the context tables are never removed
> +	 * and the new ones are not added during shutdown.
> +	 */
> +	context = iommu_context_addr(info->iommu, bus, devfn, 0);
> +	if (context) {
> +		/*
> +		 * Individual invalidations are not needed as we issue global
> +		 * invalidations later once all the cleanups are done.
> +		 */
> +		context_clear_present(context);
> +		__iommu_flush_cache(info->iommu, context, sizeof(*context));
> +		context_clear_entry(context);
> +		__iommu_flush_cache(info->iommu, context, sizeof(*context));
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
> +					     struct iommu_device *iommu_dev)
> +{
> +	struct device_domain_info *info;
> +
> +	info = dev_iommu_priv_get(dev);
> +	if (!info)
> +		return 0;
> +
> +	if (dev_iommu_preserved_state(dev))
> +		return 0;
> +
> +	if (dev_is_pci(dev))
> +		pci_for_each_dma_alias(to_pci_dev(dev),
> +				       clear_unpreserved_alias_cb, info);
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
> +	/*
> +	 * Clear context entries for unpreserved devices because during kexec
> +	 * reboot and shutdown the devices do not go through the release flow,
> +	 * so there might be stale entries in the root table and context tables.
> +	 *
> +	 * Note that the error can be ignored as the iterator function does not
> +	 * fail.
> +	 */
> +	iommu_for_each_dev(&iommu->iommu, clear_unpreserve_context_entry_fn);
> +
> +	/*
> +	 * New unpreserved context tables for unpreserved devices might have
> +	 * been added after preservation, so the root table entries for
> +	 * unpreserved context tables need to be removed.
> +	 */
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

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
