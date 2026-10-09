Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2E034EEFD
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 02:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791512676; cv=none; b=m/e4jzGucK5NrhNrN3RIDcR8Kb/Z4fRi2z+9cECdZbipxHkQzhioWksmF7JukG+VA4+9SCFjiah0J+qO8SG//EH1ZMFjLuP08IyP0jhI4lJViIn55HEdGz+V9fqkL+2kaDB7hnpxIpK4/ZmlFYn0+rbkNQ5tgJj9yklcY/ap/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791512676; c=relaxed/simple;
	bh=K50/PcpP8Qtz65E+Lgp8dSBTkqCqXw61G3kjlUVi/gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZsUHBx88qBeVmeZLUKVk/XNW6YPoiMFwhKIGEjSJsmTWpS0sNxVkvdfcNIaoCHTyfKdUtHCYqe4MNh+LGK5fPutmZ7jDM/7L0fO6sm55l4r89ZSIvaD5107/QFZDqdlmpmc3RAviq3tKP8EVeoh5Uz3SGPjqxY7enbsxNZ9asQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LFRBxf6o; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LFRBxf6o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791512674; x=1823048674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K50/PcpP8Qtz65E+Lgp8dSBTkqCqXw61G3kjlUVi/gk=;
  b=LFRBxf6oF0H7b5KsNy5e0WIlHWekt/WQfF9LgwikKNwOdLFYQ0R8pir6
   SXuZJ9vgoMII3IqkJKvP4BzlEEVtSFdG33QhuDTzV1une10uvEOW8Sp0X
   u7duRYyOGu/FI1IsW7Nsi2BbQCQjzFbrlFYvtWj7OshASlYGDyfNcesq6
   Fdca2cCvKOm7YFu6K2EmDFTFKsOHGGrO7OexFht6aMJihA99Ydz+QOMdt
   nH4H5rvF/X+nhyYnpoofeFJ0nI2KErVHjit7oz+6U7hTxsvAxCV3DdBe8
   FUMoU1I95MoMtNSfReJv54oJqqB+ieH/jw5VR6iov5QkAPv4E5uHT7/YY
   g==;
X-CSE-ConnectionGUID: rxjF8c7pSOuK2mNjJT8vDQ==
X-CSE-MsgGUID: TVzCr4/eQTWL6Pe4j9bzUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="311951"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="311951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 19:24:34 -0700
X-CSE-ConnectionGUID: djHuauNsQ+yIo/Saju4CSQ==
X-CSE-MsgGUID: 2Lo9SwOzTvGYs14EHdPaUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="291156"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 19:24:29 -0700
Message-ID: <5be26af3-9d0c-40ce-bf58-9e98ef4a8670@linux.intel.com>
Date: Fri, 9 Oct 2026 10:24:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/18] iommu/vt-d: Handle reattach of the restored
 domain
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
 <20260921004834.2601285-13-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260921004834.2601285-13-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 08:48, Samiullah Khawaja wrote:
> Reattach the restored domain to the preserved device using restored
> domain ID. While reattaching do not setup the context and PASID entries
> as those are preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  32 +++++--
>   drivers/iommu/intel/iommu.h      |  14 +++
>   drivers/iommu/intel/liveupdate.c | 159 +++++++++++++++++++++++++++++++
>   3 files changed, 197 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c5044e834337..6d3cbe0745c9 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2819,6 +2819,9 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   
> +	if (dev_iommu_restored_state(dev))
> +		return -EBUSY;
> +
>   	iopf_for_domain_remove(info->domain ? &info->domain->domain : NULL, dev);
>   	device_block_translation(dev);
>   	return 0;
> @@ -3187,6 +3190,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> +	if (dev_iommu_restored_state(dev))
> +		return intel_iommu_restore_device(domain, dev);
> +
>   	device_block_translation(dev);
>   
>   	ret = paging_domain_compatible(domain, dev);
> @@ -3317,7 +3323,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	info->iommu = iommu;
>   	RB_CLEAR_NODE(&info->node);
>   	if (dev_is_pci(dev)) {
> -		if (ecap_dev_iotlb_support(iommu->ecap) &&
> +		if (!dev_iommu_restored_state(dev) &&
> +		    ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
>   		    dmar_ats_supported(pdev, iommu)) {
>   			info->ats_supported = 1;
> @@ -3421,12 +3428,16 @@ static void intel_iommu_release_device(struct device *dev)
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
>   	struct intel_iommu *iommu = info->iommu;
>   
> -	iommu_disable_pci_pri(info);
> -	iommu_disable_pci_ats(info);
> +	if (!dev_iommu_restored_state(dev)) {
> +		iommu_disable_pci_pri(info);
> +		iommu_disable_pci_ats(info);
>   
> -	if (info->pasid_enabled) {
> -		pci_disable_pasid(to_pci_dev(dev));
> -		info->pasid_enabled = 0;
> +		if (info->pasid_enabled) {
> +			pci_disable_pasid(to_pci_dev(dev));
> +			info->pasid_enabled = 0;
> +		}
> +	} else {
> +		intel_iommu_detach_restored_device(dev);
>   	}
>   
>   	mutex_lock(&iommu->iopf_lock);
> @@ -3434,11 +3445,13 @@ static void intel_iommu_release_device(struct device *dev)
>   		device_rbtree_remove(info);
>   	mutex_unlock(&iommu->iopf_lock);
>   
> -	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev) &&
> +	if (!dev_iommu_restored_state(dev) && sm_supported(iommu) &&
> +	    !dev_is_real_dma_subdevice(dev) &&
>   	    !context_copied(iommu, info->bus, info->devfn))
>   		intel_pasid_teardown_sm_context(dev);
>   
> -	intel_pasid_free_table(dev);
> +	if (!dev_iommu_restored_state(dev))
> +		intel_pasid_free_table(dev);
>   	intel_iommu_debugfs_remove_dev(info);
>   	kfree(info);
>   }
> @@ -3900,6 +3913,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
>   	struct intel_iommu *iommu = info->iommu;
>   	int ret;
>   
> +	if (dev_iommu_restored_state(dev))
> +		return -EBUSY;
> +
>   	device_block_translation(dev);
>   
>   	if (dev_is_real_dma_subdevice(dev))
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 3a2cb08c0ac1..25104644317c 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1310,6 +1310,9 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
>   void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>   void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   					       struct iommu_hw_ser *iommu_ser);
> +int intel_iommu_restore_device(struct iommu_domain *domain,
> +			       struct device *dev);
> +int intel_iommu_detach_restored_device(struct device *dev);
>   #else
>   static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>   {
> @@ -1319,6 +1322,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>   							     struct iommu_hw_ser *iommu_ser)
>   {
>   }
> +
> +static inline int intel_iommu_restore_device(struct iommu_domain *domain,
> +					     struct device *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int intel_iommu_detach_restored_device(struct device *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index c9e553379683..6e6707eefc8c 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -351,6 +351,165 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
>   }
>   
> +static void domain_detach_reattached_iommu(struct dmar_domain *domain,
> +					   struct intel_iommu *iommu)

The naming is ambiguous. How about

	domain_detach_restored_iommu()
	domain_attach_restored_iommu()

?

> +{
> +	struct iommu_domain_info *info;
> +
> +	guard(mutex)(&iommu->did_lock);
> +	info = xa_load(&domain->iommu_array, iommu->seq_id);
> +	if (--info->refcnt == 0) {
> +		xa_erase(&domain->iommu_array, iommu->seq_id);
> +		kfree(info);
> +	}
> +}
> +
> +static int domain_reattach_iommu(struct dmar_domain *domain,
> +				 struct intel_iommu *iommu,
> +				 struct iommu_device_ser *device_ser)
> +{
> +	struct iommu_domain_info *info, *curr;
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int restored_did;
> +	int ret;
> +
> +	if (!iommu_domain_restored_state(&domain->domain))
> +		return -EINVAL;
> +
> +	if (!device_ser->domain_iommu_ser.domain_phys ||
> +	    !device_ser->domain_iommu_ser.iommu_phys)
> +		return -EINVAL;
> +
> +	domain_ser = phys_to_virt(device_ser->domain_iommu_ser.domain_phys);
> +	if (domain_ser->restored_domain != &domain->domain)
> +		return -EINVAL;
> +
> +	iommu_hw_ser = phys_to_virt(device_ser->domain_iommu_ser.iommu_phys);
> +	if (iommu_hw_ser->type != IOMMU_INTEL ||
> +	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
> +		return -EINVAL;
> +
> +	restored_did = device_ser->domain_iommu_ser.attachment_id;
> +	if (!ida_exists(&iommu->domain_ida, restored_did))
> +		return -EINVAL;
> +
> +	info = kzalloc_obj(*info);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	guard(mutex)(&iommu->did_lock);
> +	curr = xa_load(&domain->iommu_array, iommu->seq_id);
> +	if (curr) {
> +		curr->refcnt++;
> +		kfree(info);
> +		return 0;
> +	}
> +
> +	info->refcnt	= 1;
> +	info->did	= restored_did;
> +	info->iommu	= iommu;
> +	curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
> +			  NULL, info, GFP_KERNEL);
> +	if (curr) {
> +		ret = xa_err(curr) ? : -EBUSY;
> +		goto err_unlock;
> +	}
> +
> +	return 0;
> +
> +err_unlock:
> +	kfree(info);
> +	return ret;
> +}
> +
> +/**
> + * intel_iommu_restore_device() - Restore device domain attachment after live update
> + * @domain: Restored domain
> + * @dev: Restored device
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int intel_iommu_restore_device(struct iommu_domain *domain,
> +			       struct device *dev)

How about renaming it intel_iommu_attach_restored_device() to pair with
the detach helper?

> +{
> +	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
> +	struct intel_iommu *iommu = info->iommu;
> +	unsigned long flags;
> +	int ret;
> +
> +	if (!device_ser)
> +		return -EINVAL;
> +
> +	if (dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;

The vmd subdevices rely on the host endpoint to restore the domain
attachment, so instead of returning an error, it could return 0,
indicating nothing to do?

> +
> +	ret = domain_reattach_iommu(dmar_domain, iommu, device_ser);
> +	if (ret)
> +		return ret;
> +
> +	info->domain = dmar_domain;
> +	info->domain_attached = true;
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_add(&info->link, &dmar_domain->devices);
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +
> +	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
> +	if (ret)
> +		goto err;

The restored domain is an immutable domain. It could only be freed; no
map and unmap should happen on it. So why do you need to assign a cache
tag for it?

> +
> +	ret = iopf_for_domain_set(domain, dev);

ATS and PRI are not supported on the preserved devices, so the above is
dead code, right?

> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	/*
> +	 * Detach the restored domain from device and iommu on failure, but keep
> +	 * the hardware state intact.
> +	 */
> +	info->domain_attached = false;
> +	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
> +	spin_lock_irqsave(&info->domain->lock, flags);
> +	list_del(&info->link);
> +	spin_unlock_irqrestore(&info->domain->lock, flags);
> +
> +	domain_detach_reattached_iommu(info->domain, iommu);
> +	info->domain = NULL;
> +	return ret;
> +}
> +
> +int intel_iommu_detach_restored_device(struct device *dev)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct intel_iommu *iommu = info->iommu;
> +	struct iommu_domain *domain;
> +	unsigned long flags;
> +
> +	if (!info->domain_attached || !info->domain)
> +		return -EINVAL;
> +
> +	domain = &info->domain->domain;
> +	if (!iommu_domain_restored_state(domain))
> +		return -EINVAL;
> +
> +	iopf_for_domain_remove(domain, dev);
> +	cache_tag_unassign_domain(info->domain, dev, IOMMU_NO_PASID);
> +	info->domain_attached = false;
> +
> +	spin_lock_irqsave(&info->domain->lock, flags);
> +	list_del(&info->link);
> +	spin_unlock_irqrestore(&info->domain->lock, flags);
> +
> +	domain_detach_reattached_iommu(info->domain, iommu);
> +	info->domain = NULL;
> +
> +	return 0;
> +}
> +
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device

Thanks,
baolu
