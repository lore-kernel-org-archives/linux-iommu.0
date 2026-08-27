Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C7F2EDD78
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 07:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815359; cv=none; b=Jt8dRyWfgbrhV9cnIgjBOH1Dpbp5OQaZtijraJKFgy5mmaEr0Eue3soO6X1DBRimk4ZkmqZ8Y8YQ4J5vVasPO2orllbXu4HAG0+iGT97an3nf9hF86/vGe1aGD9mC1jPr9YhPP2qTSw/k5uI+rdIUzsiWIgMTqpx30a5xlK8eTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815359; c=relaxed/simple;
	bh=3tV7qGA1nYvHeA0DhkjOetoQYV6wl7gKDBvMfhd0xxU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGapaKXgB5CInWLpR05p2ZUhWJpRv7WEJp3ffLZaTp14ydg3x9UMhoKdNNyuzUk+syVJqT8tq0J48juOwdRqyhyIfHhUWtYKgvQwQQkPsiLiuI0b4Y+DuaRk6vDme8xUX766JmRC0kl79zDrgCFzZpZmOJFWFSzAeJbfcF63pac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DqV3RX45; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DqV3RX45"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787815356; x=1819351356;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3tV7qGA1nYvHeA0DhkjOetoQYV6wl7gKDBvMfhd0xxU=;
  b=DqV3RX45WuBI6xdBza0xQgiPwnZICFq4d++M/7tilMfLCySBiOT9JZc8
   I9RVlg6V8eQCYtxR9KKPTswFuIPG5DQx1DS86hkm2NZb9tZ24a9h3zuc9
   NZBQQpVklPYJqzGrE8GA3k8iDgj8a3P59QMet4RRJmlKbUkgCIXH6hUV0
   65+bAUHOJa6HvcA7zk/70x4ax6nj+Mqgmg4i8JZoeRGYcv+VHzVJymcwK
   HRMAYYV9fsvaHhJAPm7iT2EDFafPpt/G0rMxKiQHTjCkOH75ewJ9VKz/i
   B4yPByod8XGtJYlrvvKPepRnRvpJRuygeO/0ytojNJ0OzWrupXQUPqkGk
   w==;
X-CSE-ConnectionGUID: 34UnFxL9Tp2njN4+hznOwQ==
X-CSE-MsgGUID: IbPCXKH6RMyb73xr4YcEcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88326418"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88326418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:22:35 -0700
X-CSE-ConnectionGUID: IqC5x+sNQBO2RPQJ+oRgXw==
X-CSE-MsgGUID: eWUQ4qmERdGkarDX5FzriQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="266490692"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:22:29 -0700
Message-ID: <5f8963c4-f6b1-44b3-ab2c-ed658822efb4@linux.intel.com>
Date: Thu, 27 Aug 2026 15:22:26 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
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
 <20260808022723.3893618-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260808022723.3893618-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/8/26 10:27, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>    devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      | 111 +++++++++++++++++++------------
>   drivers/iommu/intel/iommu.h      |   7 ++
>   drivers/iommu/intel/liveupdate.c |  69 +++++++++++++++++++
>   3 files changed, 144 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index eca3944d9cf5..42d3ff6db281 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -980,28 +980,30 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>   }
>   
> -static void disable_dmar_iommu(struct intel_iommu *iommu)
> +static void release_dmar_iommu(struct intel_iommu *iommu)
>   {
> -	/*
> -	 * All iommu domains must have been detached from the devices,
> -	 * hence there should be no domain IDs in use.
> -	 */
> -	if (WARN_ON(!ida_is_empty(&iommu->domain_ida)))
> -		return;
> +	struct iommu_hw_ser *iommu_ser;
>   
> -	if (iommu->gcmd & DMA_GCMD_TE)
> -		iommu_disable_translation(iommu);
> -}
> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +	if (!iommu_ser) {
> +		/*
> +		 * All iommu domains must have been detached from the devices,
> +		 * hence there should be no domain IDs in use.
> +		 */
> +		WARN_ON(!ida_is_empty(&iommu->domain_ida));
> +
> +		if ((iommu->gcmd & DMA_GCMD_TE))
> +			iommu_disable_translation(iommu);
> +	}
>   
> -static void free_dmar_iommu(struct intel_iommu *iommu)
> -{
>   	if (iommu->copied_tables) {
>   		bitmap_free(iommu->copied_tables);
>   		iommu->copied_tables = NULL;
>   	}
>   
> -	/* free context mapping */
> -	free_context_table(iommu);
> +	/* free context mapping if there is no serialized state. */
> +	if (!iommu_ser)
> +		free_context_table(iommu);
>   
>   	if (ecap_prs(iommu->ecap))
>   		intel_iommu_finish_prq(iommu);
> @@ -1612,12 +1614,19 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   
>   static int __init init_dmars(void)
>   {
> +	struct iommu_hw_ser *iommu_ser;
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu;
>   	int ret;
>   
>   	for_each_iommu(iommu, drhd) {
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
>   		if (drhd->ignored) {
> +			if (WARN_ON(iommu_ser)) {
> +				ret = -EINVAL;
> +				goto free_iommu;
> +			}
> +
>   			iommu_disable_translation(iommu);
>   			continue;
>   		}
> @@ -1635,7 +1644,9 @@ static int __init init_dmars(void)
>   		}
>   
>   		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +
> +		if (!iommu_ser)
> +			init_translation_status(iommu);
>   
>   		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>   			iommu_disable_translation(iommu);
> @@ -1644,14 +1655,18 @@ static int __init init_dmars(void)
>   				iommu->name);
>   		}
>   
> -		/*
> -		 * TBD:
> -		 * we could share the same root & context tables
> -		 * among all IOMMU's. Need to Split it later.
> -		 */
> -		ret = iommu_alloc_root_entry(iommu);
> -		if (ret)
> -			goto free_iommu;
> +		if (iommu_ser) {
> +			intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
> +		} else {
> +			/*
> +			 * TBD:
> +			 * we could share the same root & context tables
> +			 * among all IOMMU's. Need to Split it later.
> +			 */
> +			ret = iommu_alloc_root_entry(iommu);
> +			if (ret)
> +				goto free_iommu;
> +		}
>   
>   		if (translation_pre_enabled(iommu)) {
>   			pr_info("Translation already enabled - trying to copy translation structures\n");
> @@ -1687,7 +1702,10 @@ static int __init init_dmars(void)
>   	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_flush_write_buffer(iommu);
> -		iommu_set_root_entry(iommu);
> +
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +		if (!iommu_ser)
> +			iommu_set_root_entry(iommu);
>   	}
>   
>   	check_tylersburg_isoch();
> @@ -1732,10 +1750,8 @@ static int __init init_dmars(void)
>   	return 0;
>   
>   free_iommu:
> -	for_each_active_iommu(iommu, drhd) {
> -		disable_dmar_iommu(iommu);
> -		free_dmar_iommu(iommu);
> -	}
> +	for_each_active_iommu(iommu, drhd)
> +		release_dmar_iommu(iommu);
>   
>   	return ret;
>   }
> @@ -2116,17 +2132,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>   static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   {
>   	struct intel_iommu *iommu = dmaru->iommu;
> +	struct iommu_hw_ser *iommu_ser;
>   	int ret;
>   
> +	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
>   	/*
>   	 * Disable translation if already enabled prior to OS handover.
>   	 */
> -	if (iommu->gcmd & DMA_GCMD_TE)
> +	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>   		iommu_disable_translation(iommu);
>   
> -	ret = iommu_alloc_root_entry(iommu);
> -	if (ret)
> -		goto out;
> +	if (iommu_ser) {
> +		if (WARN_ON(dmaru->ignored))
> +			return -EINVAL;
> +
> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
> +	} else {
> +		ret = iommu_alloc_root_entry(iommu);
> +		if (ret)
> +			goto out;
> +	}
>   
>   	intel_svm_check(iommu);
>   
> @@ -2145,23 +2172,23 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   	if (ecap_prs(iommu->ecap)) {
>   		ret = intel_iommu_enable_prq(iommu);
>   		if (ret)
> -			goto disable_iommu;
> +			goto out;
>   	}
>   
>   	ret = dmar_set_interrupt(iommu);
>   	if (ret)
> -		goto disable_iommu;
> +		goto out;
> +
> +	if (!iommu_ser)
> +		iommu_set_root_entry(iommu);
>   
> -	iommu_set_root_entry(iommu);
>   	iommu_enable_translation(iommu);
>   
>   	iommu_disable_protect_mem_regions(iommu);
>   	return 0;
>   
> -disable_iommu:
> -	disable_dmar_iommu(iommu);
>   out:
> -	free_dmar_iommu(iommu);
> +	release_dmar_iommu(iommu);
>   	return ret;
>   }
>   
> @@ -2175,12 +2202,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
>   	if (iommu == NULL)
>   		return -EINVAL;
>   
> -	if (insert) {
> +	if (insert)
>   		ret = intel_iommu_add(dmaru);
> -	} else {
> -		disable_dmar_iommu(iommu);
> -		free_dmar_iommu(iommu);
> -	}
> +	else
> +		release_dmar_iommu(iommu);
>   
>   	return ret;
>   }
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 6c971f04ead3..b33a12528066 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1307,6 +1307,8 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
>   void clear_unpreserved_context_entries(struct intel_iommu *iommu);
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_hw_ser *iommu_ser);
>   #else
>   static inline int intel_iommu_preserve_device(struct device *dev,
>   					      struct iommu_device_ser *device_ser)
> @@ -1333,6 +1335,11 @@ static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
>   static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>   {
>   }
> +
> +static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +							     struct iommu_hw_ser *iommu_ser)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index b5aaebeeb5c1..480eab2d966b 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -273,6 +273,75 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
>   	return 0;
>   }
>   
> +static void restore_iommu_context(struct intel_iommu *iommu)
> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		context = iommu_context_addr(iommu, i, 0, 0);
> +		if (context)
> +			iommu_restore_pages(virt_to_phys(context));
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		context = iommu_context_addr(iommu, i, 0x80, 0);
> +		if (context)
> +			iommu_restore_pages(virt_to_phys(context));
> +	}
> +}
> +
> +static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
> +{
> +	int id = ser->domain_iommu_ser.attachment_id;
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	struct intel_iommu *iommu = arg;
> +
> +	if (WARN_ON(!ser->domain_iommu_ser.iommu_phys))
> +		return 0;
> +
> +	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);
> +	if (iommu_hw_ser->type != IOMMU_INTEL)
> +		return 0;
> +
> +	/* Only allocate domain ID from associated IOMMU HW unit */
> +	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
> +		return 0;
> +
> +	/*
> +	 * This can fail as multiple preserved devices can share the same domain
> +	 * ID. Since this is done during DMAR init so these failures can be
> +	 * ignored.
> +	 */
> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);

This mixes two different cases:

- another preserved device has already reserved the same DID.
- the DID is not reserved because ida_alloc_range() failed (for example,
   memory allocation failure).

Case #1 is expected. Case #2 must not be ignored, because it means
restore failed. So this should probably be something like (not tested):

	mutex_lock(&iommu->did_lock);
	if (ida_find_first_range(&iommu->domain_ida, id, id) >= 0)
		BUG_ON(ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL) < 0)
	mutex_unlock(&iommu->did_lock);

?

By the way, why GFP_ATOMIC here at all?

> +	return 0;
> +}
> +
> +/**
> + * intel_iommu_liveupdate_restore_root_table() - Restore root table and reclaim domain IDs
> + * @iommu: Target IOMMU
> + * @iommu_ser: Serialized IOMMU hardware state from previous kernel
> + *
> + * Restores the preserved root table and context tables for the IOMMU hardware
> + * instance across Live Update, and reclaims all domain IDs previously allocated
> + * to preserved devices so they are not reused.
> + */
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_hw_ser *iommu_ser)
> +{
> +	if (!iommu_ser->intel.restored)
> +		iommu_restore_pages(iommu_ser->intel.root_table);
> +
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);
> +
> +	if (!iommu_ser->intel.restored)
> +		restore_iommu_context(iommu);
> +
> +	iommu_ser->intel.restored = 1;

This uses iommu_ser->intel.restored to prevent restoring the root and
context tables multiple times. For this to work safely, iommu_ser-
 >intel.restored must be 0 the first time restore runs after kexec.

The problem is: this field is inside struct iommu_hw_ser, and that
struct is allocated in the old kernel. How to ensure that the previous
kernel has zeroed this out? Maybe I’m overthinking this.

> +	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
> +}
> +
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device

Thanks,
baolu
