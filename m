Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171676;
	b=MuDmV8soeb9aBf8wOy+0O1FC4Io808+24ka59/Y9tnV+b7f6pPbZi+BazZk5eMwTszWy
	 1xkl+Y8IRtaJGCgnqWOZWKHDgjQwmB2CTv4b1t68FuJpe3UxZCLuJhiJ9yNOu8WvZMs9T
	 gzPeLSRN4eQLUfuTmlQDj2VB7EFCzbejpnUW5g91/7meQtQfj0IZ3yEftW+Fj4wXT/zUO
	 eJ3yawnzflsZuQLPcQ85p6NjRa/qRgFFE9ywtP+l2Utj7UnrRzoNYwtsM1DeXpaYxEpUI
	 tIxc+IPFVQLHj1978m8fj0cviRaFaHIJ1F9EpboUKpAYc0prla31hrRhs+wWDqSqn9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=nWvZ3TM+SO8+XPvG+XWKa0let6l7VYIlGYjlYFnH3+M=;
	b=yLD2e7tY+SndKXy+/mPETr9p46lnRY7FRDeDRFRLrQhCZuvrmxwiVWhz+o6RhszjTu7D
	 HN4MJX7nQOZrf8JLRMIvh4GLKHEK5tRugZA7HPYCcjaw5G6hGeV+dU+V24e1NxvpBs3/s
	 bvsKHBhmkYHPg1BBSiDMJ9pU2Jt+KZ7XAEdZtNqNZEvq2CcNZMWUUUovX6//TyJDeUz7c
	 0Lb80V8SMlG5mntNFdm/ctOmccDKeq9ljk4KvvXCCRCAthG9SkYWH6yDPTS37UZUW+H5b
	 WMW3m6ktrgzkPhOYm2xq6b4OQZiDAt9nmVp8vRgNpDlJbn4l0fowjTECBFPjz3AwdoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvbBERdx;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF202606A320
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 07:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF202606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kvbBERdx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793171676; x=1824707676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V++wtxYvvFtv+QXNQW1GugFJXMKwwFidjcD9QJCz6O8=;
  b=kvbBERdxMHVMytsEc9n8QWO3VQ55+YlV83ooyWOkoF6DD5Q4BT1zcLRX
   DdFkHVMXQ0/b9msUKkEtd+L+CVxXcjThMVTxzru+It0zw9zVwiI49PxuF
   q92DG7c6Rf7n6Epe1tD+BJcbHTGQV5nHFwtHeNci5+0Xn6AyqZbk4/aUj
   qqcELFWoCjhQ/O4HapfgHmoYYTuJd/r5bEb/ZpLqkm+yoL5y7Jp4XoYfa
   UpSgM7v9QYrDNsyW2LwatdhqFJRdfhAYRQFY+6UqouQeJP7NSCUKaitRo
   Wmp6sYVMSvaJ0kCjE1GMTzFeaPnYtOqsOplk16QCm0qsSja0DH4afiEDZ
   g==;
X-CSE-ConnectionGUID: PzA6j1YlRQiDzmiP6M/VGQ==
X-CSE-MsgGUID: XgVuG4yMQUCOU/J99WSssQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1914697"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1914697"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:14:35 -0700
X-CSE-ConnectionGUID: EZYw30CpTfG8IRpiQz3tHw==
X-CSE-MsgGUID: FJcdkkdcTLioWet2HjwKRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4743439"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:14:29 -0700
Message-ID: <e86c855a-bad8-4909-ae88-a7cdca2837a7@linux.intel.com>
Date: Wed, 28 Oct 2026 15:14:26 +0800
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
Subject: Re: [PATCH v6 10/18] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
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
 <20261025021930.674647-11-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-11-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 10:19, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>    devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  71 ++++++++++++------
>   drivers/iommu/intel/iommu.h      |  14 ++++
>   drivers/iommu/intel/liveupdate.c | 121 +++++++++++++++++++++++++++++++
>   3 files changed, 185 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 35ec2ae0c8d5..991ad9b2456e 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -987,6 +987,8 @@ static void iommu_disable_translation(struct intel_iommu *iommu)
>   
>   static void release_dmar_iommu(struct intel_iommu *iommu)
>   {
> +	intel_iommu_handle_drhd_restore_failure(iommu);
> +
>   	/*
>   	 * All iommu domains must have been detached from the devices,
>   	 * hence there should be no domain IDs in use.
> @@ -1452,7 +1454,7 @@ static void intel_iommu_init_qi(struct intel_iommu *iommu)
>    * Returns 0 when the ID is reserved, was already reserved, or cannot be
>    * re-assigned, and a negative errno for a genuine allocation failure.
>    */
> -static int reserve_domain_id(struct intel_iommu *iommu, int did)
> +int reserve_domain_id(struct intel_iommu *iommu, int did)
>   {
>   	int ret;
>   
> @@ -1743,12 +1745,16 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>   
>   static int __init init_dmars(void)
>   {
> +	struct iommu_hw_ser *iommu_ser;
>   	struct dmar_drhd_unit *drhd;
>   	struct intel_iommu *iommu;
>   	int ret;
>   
>   	for_each_iommu(iommu, drhd) {
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
> +						     IOMMU_SER_TYPE_INTEL);
>   		if (drhd->ignored) {
> +			intel_iommu_handle_drhd_restore_failure(iommu);
>   			iommu_disable_translation(iommu);
>   			continue;
>   		}
> @@ -1766,7 +1772,9 @@ static int __init init_dmars(void)
>   		}
>   
>   		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +
> +		if (!iommu_ser)
> +			init_translation_status(iommu);

Why skipping init_translation_status() for a preserved iommu? The final
step of intel_iommu_init() does the following:

         /* Finally, we enable the DMA remapping hardware. */
         for_each_iommu(iommu, drhd) {
                 if (!drhd->ignored && !translation_pre_enabled(iommu))
                         iommu_enable_translation(iommu);

                 iommu_disable_protect_mem_regions(iommu);
         }

That touches the gcmd register of a preserved iommu.
VTD_FLAG_TRANS_PRE_ENABLED should be set for all preserved iommu. Or
not?

>   
>   		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>   			iommu_disable_translation(iommu);
> @@ -1775,14 +1783,18 @@ static int __init init_dmars(void)
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
> @@ -1818,7 +1830,11 @@ static int __init init_dmars(void)
>   	 */
>   	for_each_active_iommu(iommu, drhd) {
>   		iommu_flush_write_buffer(iommu);
> -		iommu_set_root_entry(iommu);
> +
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
> +						     IOMMU_SER_TYPE_INTEL);
> +		if (!iommu_ser)
> +			iommu_set_root_entry(iommu);
>   	}
>   
>   	check_tylersburg_isoch();
> @@ -2245,17 +2261,28 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>   static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   {
>   	struct intel_iommu *iommu = dmaru->iommu;
> +	struct iommu_hw_ser *iommu_ser;
>   	int ret;
>   
> -	/*
> -	 * Disable translation if already enabled prior to OS handover.
> -	 */
> -	if (iommu->gcmd & DMA_GCMD_TE)
> -		iommu_disable_translation(iommu);
> +	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys,
> +					     IOMMU_SER_TYPE_INTEL);
> +	if (iommu_ser) {
> +		if (dmaru->ignored)
> +			intel_iommu_handle_drhd_restore_failure(iommu);

intel_iommu_add() runs during runtime ACPI hot-add, not during boot.
It's unclear whether an preserved IOMMU can reach this path. By the time
a hot-add event occurs, the preserved data may already be gone because
the LUO session has ended.

I would suggest starting from simple by not supporting IOMMUs with
preserved state in the hot-plug case. Returning -EBUSY here would be
enough?

>   
> -	ret = iommu_alloc_root_entry(iommu);
> -	if (ret)
> -		goto out;
> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
> +	} else {
> +		/*
> +		 * Disable translation if already enabled prior to OS handover.
> +		 */
> +		if (iommu->gcmd & DMA_GCMD_TE)
> +			iommu_disable_translation(iommu);
> +
> +		ret = iommu_alloc_root_entry(iommu);
> +		if (ret)
> +			goto out;
> +	}
>   
>   	intel_svm_check(iommu);
>   
> @@ -2281,7 +2308,8 @@ static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>   	if (ret)
>   		goto out;
>   
> -	iommu_set_root_entry(iommu);
> +	if (!iommu_ser)
> +		iommu_set_root_entry(iommu);
>   	iommu_enable_translation(iommu);
>   
>   	iommu_disable_protect_mem_regions(iommu);
> @@ -2797,7 +2825,8 @@ int __init intel_iommu_init(void)
>   		 * to avoid unnecessary lock order splat.
>   		 */
>   		up_read(&dmar_global_lock);
> -		iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL);
> +		if (iommu_device_register(&iommu->iommu, &intel_iommu_ops, NULL))
> +			intel_iommu_handle_drhd_restore_failure(iommu);
>   		down_read(&dmar_global_lock);
>   
>   		iommu_pmu_register(iommu);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 16ab103d308a..260c7a5b1240 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1307,6 +1307,8 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>   	return 0;
>   }
>   
> +int reserve_domain_id(struct intel_iommu *iommu, int did);
> +
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   int intel_iommu_preserve_device(struct device *dev,
>   				struct iommu_device_ser *device_ser);
> @@ -1317,10 +1319,22 @@ int intel_iommu_preserve(struct iommu_device *iommu,
>   void intel_iommu_unpreserve(struct iommu_device *iommu,
>   			    struct iommu_hw_ser *iommu_ser);
>   void clear_unpreserved_context_entries(struct intel_iommu *iommu);
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_hw_ser *iommu_ser);
> +void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
>   #else
>   static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>   {
>   }
> +
> +static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +							     struct iommu_hw_ser *iommu_ser)
> +{
> +}
> +
> +static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
> +{
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index f92cb774cc99..cf98b95bf8d2 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -272,6 +272,127 @@ static int preserve_iommu_context_tables(struct device_domain_info *info)
>   	return 0;
>   }
>   
> +static int restore_context_table(struct intel_iommu *iommu,
> +				 struct iommu_hw_ser *ser,
> +				 u8 bus, u8 devfn, u64 root_val)
> +{
> +	bool present = root_val & 1;
> +
> +	/*
> +	 * The root entries of unpreserved context tables are cleared during
> +	 * shutdown, so the preserved bitmap must match the present bits.
> +	 */
> +	if (is_context_table_preserved(iommu, ser, bus, devfn) != present)
> +		return -EINVAL;
> +
> +	if (present)
> +		iommu_restore_pages(root_val & VTD_PAGE_MASK);
> +
> +	return 0;
> +}
> +
> +static int restore_iommu_context(struct intel_iommu *iommu,
> +				 struct iommu_hw_ser *ser)
> +{
> +	struct root_entry *root;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		root = &iommu->root_entry[i];
> +
> +		ret = restore_context_table(iommu, ser, i, 0, root->lo);
> +		if (ret)
> +			return ret;
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		ret = restore_context_table(iommu, ser, i, 0x80, root->hi);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
> +{
> +	int id = ser->attachment.attachment_id;
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	struct intel_iommu *iommu = arg;
> +
> +	if (WARN_ON(!ser->iommu_phys))
> +		return 0;
> +
> +	iommu_hw_ser = phys_to_virt(ser->iommu_phys);
> +	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL)
> +		return 0;
> +
> +	/* Only allocate domain ID from associated IOMMU HW unit */
> +	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
> +		return 0;

Unlike kdump case, where out-of-range did is ignored.

	/* For live update, an out-of-range did means corrupt state. */
	if (id < 0 || id >= iommu->max_domain_id)
		return -EINVAL;

> +
> +	return reserve_domain_id(iommu, id);
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
> + *
> + * The preserved devices keep doing DMA through the preserved translation
> + * tables, so a failure to restore them is fatal.
> + */
> +void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
> +					       struct iommu_hw_ser *iommu_ser)
> +{
> +	int ret;
> +
> +	/*
> +	 * The kernel command line might have changed across kexec, e.g.
> +	 * intel_iommu=sm_off, so make sure the preserved tables are in the
> +	 * format this kernel is going to use.
> +	 */
> +	if (iommu_ser->intel.sm_enabled != sm_supported(iommu))
> +		panic("%s: preserved scalable mode %u does not match current %u\n",
> +		      iommu->name, iommu_ser->intel.sm_enabled,
> +		      sm_supported(iommu));

I'm not clear on the trust model for the preserved data. What if it does
not match the hardware's current configuration? Should we verify that
the preserved data matches the hardware state here? Would the following
check help detect such mismatches?

	u64 rtaddr = readq(iommu->reg + DMAR_RTADDR_REG);
	u32 gsts = readl(iommu->reg + DMAR_GSTS_REG);

	if (!(gsts & DMA_GSTS_TES) ||
	    (rtaddr & VTD_PAGE_MASK) != iommu_ser->intel.root_table ||
	    !!(rtaddr & DMA_RTADDR_SMT) != !!iommu_ser->intel.sm_enabled)
		panic(...);

> +
> +	iommu_restore_pages(iommu_ser->intel.root_table);
> +	iommu->root_entry = __va(iommu_ser->intel.root_table);

__va() is used here while other places use phys_to_virt(). Why?

> +
> +	ret = restore_iommu_context(iommu, iommu_ser);
> +	if (ret)
> +		panic("%s: failed to restore preserved context tables\n",
> +		      iommu->name);
> +
> +	ret = iommu_for_each_preserved_device(_restore_used_domain_ids, iommu);
> +	if (ret)
> +		panic("%s: failed to reclaim preserved domain IDs: %d\n",
> +		      iommu->name, ret);
> +}
> +
> +/**
> + * intel_iommu_handle_drhd_restore_failure() - Handle DRHD restore failure
> + * @iommu: Target IOMMU
> + */
> +void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
> +{
> +	/*
> +	 * The preserved devices keep doing DMA through the preserved
> +	 * translation tables, so a failure to restore and register the IOMMU
> +	 * is fatal.
> +	 */
> +	if (iommu_get_preserved_data(iommu->reg_phys, IOMMU_SER_TYPE_INTEL))
> +		panic("%s: failed to restore IOMMU with preserved state\n",
> +		      iommu->name);
> +}
> +
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device

Thanks,
baolu
