Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E949C279DAD
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791510280; cv=none; b=UhtZeyMAwXH00h7O57/prYBcEHFesdCdxfkZosFGujU5v1gfMqux54b8Sama+0pumnla0dttUi1BxshjxeFPQOFggdhhioXVhk2qpb8csRGnyx+iA05oSpQmRMvOcmuIhY7u5AwbqzAgzQ1UWu/3xLopfD/VeegvuyG+JmIELB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791510280; c=relaxed/simple;
	bh=JVxlh5mpY5VeOT5/Vjg+uytQbzmKCMej0PHpXO72v+s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BUtA5Zfy/AsitJ0mzu26gmnuIKJYopYIa0mN2gI9R9b82wPFWYV/FYf+IpMafQFNlpwyr2gzCBnS7H6+QBsfWkslreeVZqb1L4/3aEnhsGPkm1RhV9DbyLangvUiuX5fYqbjXEpXCfdDwD0JvQlnKeXqQdrQyenjV6cGWTCG7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IYII//k1; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IYII//k1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791510278; x=1823046278;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JVxlh5mpY5VeOT5/Vjg+uytQbzmKCMej0PHpXO72v+s=;
  b=IYII//k1sxeEKORkA5FEDAzQUGzuAaT+ICQ6chDY2UweHD/vBOA1fPWI
   3uwks/4C4i3JTaXD2oWlaKD8i0KV/1H3S+yUgM66k2/Y7/eVjCP69AL6K
   bdnwSsHzZu7oE6bAZWIpM2AXxoqbNRpc0dEpAtmFiSg6Nob9UtJhM4OK4
   3mvlODoaqe0GavUt2jpcO73AxXrtFoh2txCIuBuAOkjHkbE3rtAFgcUft
   9UXJ5ZNtVALd0fuMrartLcT7+JDd/tHvpIj4mlz5xvygdN294UATkWyNd
   TwGYXnQQxqNxhz7pQTPWt+idSAUngLXUtvDRaRmTpro4cLrAmru64YPhS
   A==;
X-CSE-ConnectionGUID: k/kGxUkxQMG0mUDZatbnwg==
X-CSE-MsgGUID: ku86kcrKSQeRrIqMNS57zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="190300"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="190300"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:44:37 -0700
X-CSE-ConnectionGUID: v2+ituUyT7WG7hyWg1wyUA==
X-CSE-MsgGUID: O7RxfvX2TUqptEv8K74bvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="636667"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 18:44:34 -0700
Message-ID: <2f42037f-b7b8-4ced-a945-d1d12eb70249@linux.intel.com>
Date: Fri, 9 Oct 2026 09:44:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
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
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260921004834.2601285-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 08:48, Samiullah Khawaja wrote:
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
>   drivers/iommu/intel/liveupdate.c |  79 ++++++++++++++++++++++
>   3 files changed, 154 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 474c926172c5..c5044e834337 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -987,28 +987,30 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>   }
>   
> -static void disable_dmar_iommu(struct intel_iommu *iommu)
> +static void release_dmar_iommu(struct intel_iommu *iommu)

Can we put the code refactor in a separate patch? Mixing it with a
feature patch makes it hard for review.

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
> @@ -1632,12 +1634,19 @@ static int copy_translation_tables(struct intel_iommu *iommu)
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
> @@ -1655,7 +1664,9 @@ static int __init init_dmars(void)
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
> @@ -1664,14 +1675,18 @@ static int __init init_dmars(void)
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
> @@ -1707,7 +1722,10 @@ static int __init init_dmars(void)
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
> @@ -1752,10 +1770,8 @@ static int __init init_dmars(void)
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
> @@ -2136,17 +2152,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
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
> @@ -2165,23 +2192,23 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
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
> @@ -2195,12 +2222,10 @@ int dmar_iommu_hotplug(struct dmar_drhd_unit *dmaru, bool insert)
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
> index 4feb5bd76b18..3a2cb08c0ac1 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1308,10 +1308,17 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
>   void clear_unpreserved_context_entries(struct intel_iommu *iommu);
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_hw_ser *iommu_ser);
>   #else
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
> index 501dc0e9cc0a..c9e553379683 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -272,6 +272,85 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
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

Why not use the serialized context_tables_bitmap as the source of truth,
and check it against the present bits?

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
> +	int ret;
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
> +	guard(mutex)(&iommu->did_lock);
> +
> +	/*
> +	 * The domain IDs are reclaimed while the IOMMU HW unit is being
> +	 * restored and not registered with the IOMMU core. So if the ID already
> +	 * exists, it is safe to assume that a preserved device sharing the same
> +	 * domain ID reclaimed it.
> +	 */
> +	if (ida_exists(&iommu->domain_ida, id))
> +		return 0;
> +
> +	ret = ida_alloc_range(&iommu->domain_ida, id, id, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;

Commit 12a2ea2d91be ("iommu/vt-d: Handle DID reservation errors when
copying context tables") on the iommu/next branch introduced a new
helper named reserve_domain_id() for reserving a domain ID inherited
from the previous kernel. Could it be reused here?

> +
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

This restores the preserved root table without checking the new
environment. Is it possible that kexec has a different kernel command
line (say intel_iommu=sm_off) for the new kernel than the previous
kernel? sm_supported(iommu) will then return a value different from the
real hardware configuration.

> +	if (!iommu_ser->intel.restored)
> +		iommu_restore_pages(iommu_ser->intel.root_table);
> +
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);

Why does the above line execute no matter the value of
iommu_ser->intel.restored? It would be more readable if the code looked
like...

	if (iommu_ser->intel.restored)
		return;

	iommu_restore_pages(iommu_ser->intel.root_table);
	... ...

Or I overlooked anything?

> +
> +	if (!iommu_ser->intel.restored)
> +		restore_iommu_context(iommu);
> +
> +	iommu_ser->intel.restored = 1;
> +	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
> +}
> +
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device

Thanks,
baolu
