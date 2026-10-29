Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793262524;
	b=rAFGvV5RRB50mIx3rkKZhrVTHA+WB2S04poU17q5bHtSkxY6LPBdP+IshEMYkvKt3/s+
	 DGm9v44NaWuE9x7tCr5Ss1OrF8Iv7yau0myT6w9Mrf97wViMeJ7zS35yIPD9idviT0TGi
	 iByS7UpyV/FDF/YVKQvUINqdZGDvlOIaVRnVoJ3fOAuq7nDfgIlYBilbSVD2zYuNogoVe
	 WpRkiZNNS2BWb3ZinpSWVEggfHV6y2uY5itUhLuCi74Bk/mbY3Nwvdt5BaZ68fc2boZBp
	 dpWlGQiGQIU7tc+F4PyBmdDknqdOuKVPC8SXsKyClVApFOmAgNEQM4DtMziU39sY1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793262524;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=+O06dij/E4AszSh3h8D/A3AN8Cmq/N471sJmbDo5SdM=;
	b=v6eWFY+qhwbMPQMFkXjcdiZs75SY/i2K1U0evCpBIl75X84kgCk/WLc9ASYUYBGTRraZ
	 gGnLrFZF/sJBtAAzySoF4AR90k+iY2MrwuFYVOQRhzHjgsSo53wa0pRFY2ogft1bqQ7KV
	 bZ51XTG6mCvcF/L4349m96WNVKlRox/X4RKp6MtVv+5gmM1AwDf9RZYyZRAaTJ+qSgic3
	 KwNtxYbHDc1IYUnsZfPMuwtDP3WHSq5RCPWtDnHKsNhJN6wvra33Gx6Y+r6CMAien3mlu
	 k6NQU+um3GP8SQBdqx/OTLTpaIuOzomewW2yoR0WEhw9oQP/E9citKX4rJc1uKZXHNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWpRZVuv;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A2A606A31C
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 08:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42A2A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bWpRZVuv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793262524; x=1824798524;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mLZ17SLVuKJOfZG+q8nNSv4+tuB7DXBX7DQa1UdgEHc=;
  b=bWpRZVuvblQ/WevSIn6OUYmzRxgMjk8sX29BKrjtLb0Nn6k8VWUnfeHs
   Qf197JRwVfGB2IepaoVnxnDdA89jC82TwpBw73busQ/BxogT4tic7AGuN
   pUzeyXw0dhnkSs/A5vGzQ4RwPzG+NYCXDWph7hL0zh+OYG1Nq0A5ZxAST
   E5vf05WSPA41hO+k83xzrDWtcLBOAcPd8jSocDGXc09jGlKIhgtBal6BZ
   /60XRNGHw4a7nNIQYNr4D1oMR+GAmeEYspeB6rvHAA6/qs466FC4WIibZ
   sgxoF9AVtbLfKVCd+LgYPQyUIjOup6GtNDu3NBfFl9i0zNXFLiMoeeAL1
   w==;
X-CSE-ConnectionGUID: VU6WCbtNQzaKUvr5Msjw3A==
X-CSE-MsgGUID: k3npXhKeTsue4HJlyysOuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1881222"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1881222"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:28:38 -0700
X-CSE-ConnectionGUID: YEZk7yxMTfyll+nI6HZ4hQ==
X-CSE-MsgGUID: O5OSDsujS+qaCtgj7dGapg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5170576"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 01:28:33 -0700
Message-ID: <faeedd16-a271-4ced-be1a-7bd70860bcdc@linux.intel.com>
Date: Thu, 29 Oct 2026 16:28:30 +0800
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
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 13/18] iommu/vt-d: Handle reattach of the restored
 domain
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-14-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-14-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> Reattach the restored domain to the preserved device using restored
> domain ID. While reattaching do not setup the context and PASID entries
> as those are preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |  34 ++++++--
>   drivers/iommu/intel/iommu.h      |  14 ++++
>   drivers/iommu/intel/liveupdate.c | 131 +++++++++++++++++++++++++++++++
>   3 files changed, 171 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index ecec057f78dd..4f01aa34ccb5 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -2926,6 +2926,9 @@ static int blocking_domain_attach_dev(struct iommu_domain *domain,
>   				      struct device *dev,
>   				      struct iommu_domain *old)
>   {
> +	if (dev_iommu_restored_state(dev))
> +		return -EBUSY;
> +

There is a contract between the iommu core and iommu drivers that
attaching a blocking domain must always succeed. Otherwise, some
existing code paths will break.

My understanding is that "block DMA" is always a legitimate request, but
we don't expect it while the device is in the restored state. So perhaps
we could trigger a WARN here and continue tearing down the preserved
entry?

>   	iopf_for_domain_remove(old, dev);
>   	device_block_translation(dev);
>   	return 0;
> @@ -3294,6 +3297,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> +	if (dev_iommu_restored_state(dev))
> +		return intel_iommu_attach_restored_device(domain, dev);
> +
>   	device_block_translation(dev);
>   
>   	ret = paging_domain_compatible(domain, dev);
> @@ -3424,7 +3430,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   	info->iommu = iommu;
>   	RB_CLEAR_NODE(&info->node);
>   	if (dev_is_pci(dev)) {
> -		if (ecap_dev_iotlb_support(iommu->ecap) &&
> +		if (!dev_iommu_restored_state(dev) &&
> +		    ecap_dev_iotlb_support(iommu->ecap) &&
>   		    pci_ats_supported(pdev) &&
>   		    dmar_ats_supported(pdev, iommu)) {
>   			info->ats_supported = 1;
> @@ -3529,12 +3536,16 @@ static void intel_iommu_release_device(struct device *dev)
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
> @@ -3542,11 +3553,15 @@ static void intel_iommu_release_device(struct device *dev)
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
> +	else
> +		kfree(info->pasid_table);
>   	intel_iommu_debugfs_remove_dev(info);
>   	kfree(info);
>   }
> @@ -4003,6 +4018,9 @@ static int identity_domain_attach_dev(struct iommu_domain *domain,
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
> index 260c7a5b1240..f910e5383e12 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1322,6 +1322,9 @@ void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>   void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   					       struct iommu_hw_ser *iommu_ser);
>   void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu);
> +int intel_iommu_attach_restored_device(struct iommu_domain *domain,
> +				       struct device *dev);
> +int intel_iommu_detach_restored_device(struct device *dev);
>   #else
>   static inline void clear_unpreserved_context_entries(struct intel_iommu *iommu)
>   {
> @@ -1335,6 +1338,17 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>   static inline void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>   {
>   }
> +
> +static inline int intel_iommu_attach_restored_device(struct iommu_domain *domain,
> +						     struct device *dev)
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

It appears that there is no way to replace the restored domain, because
nothing ever clears IOMMU_SER_FLAG_INCOMING or dev->iommu->device_ser.
As a result, if iommufd later tries to move the device to a new hwpt,
the attempt will always fail.

I assume this is intended for this phase, and that the actual
replacement will be handled in a later phase. If so, please mention this
in the commit message.

> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 36816d3651e6..665ebb81bd61 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -394,6 +394,137 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>   		      iommu->name);
>   }
>   
> +static void domain_detach_restored_iommu(struct dmar_domain *domain,
> +					 struct intel_iommu *iommu)
> +{
> +	struct iommu_domain_info *info;
> +
> +	guard(mutex)(&iommu->did_lock);
> +	info = xa_load(&domain->iommu_array, iommu->seq_id);
> +	if (--info->refcnt == 0) {
> +		xa_erase(&domain->iommu_array, iommu->seq_id);
> +		kfree(info);
> +	}

This seems to be different from normal domain_detach_iommu(), which
looks like this,

         if (--info->refcnt == 0) {
                 ida_free(&iommu->domain_ida, info->did);
                 xa_erase(&domain->iommu_array, iommu->seq_id);
                 kfree(info);
         }

why ida_free() is skipped in the restored path?

> +}
> +
> +static int domain_attach_restored_iommu(struct dmar_domain *domain,
> +					struct intel_iommu *iommu,
> +					struct iommu_device_ser *device_ser)
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
> +	if (!device_ser->attachment.domain_phys ||
> +	    !device_ser->iommu_phys)
> +		return -EINVAL;
> +
> +	domain_ser = phys_to_virt(device_ser->attachment.domain_phys);
> +	if (domain_ser->restored_domain != &domain->domain)
> +		return -EINVAL;
> +
> +	iommu_hw_ser = phys_to_virt(device_ser->iommu_phys);
> +	if (iommu_hw_ser->type != IOMMU_SER_TYPE_INTEL ||
> +	    iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
> +		return -EINVAL;
> +
> +	restored_did = device_ser->attachment.attachment_id;
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

		if (WARN_ON(curr->did != restored_did))
			return -EINVAL;

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
> + * intel_iommu_attach_restored_device() - Restore device domain attachment after live update
> + * @domain: Restored domain
> + * @dev: Restored device
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int intel_iommu_attach_restored_device(struct iommu_domain *domain,
> +				       struct device *dev)
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

The context and PASID table entries are not touched in the restore path.
That's fine, but it would be better to check that the hardware
configuration matches the restored domain before trusting it, at least
the physical address of the page table and the domain ID. With that
check in place, it would be reasonable to skip
paging_domain_compatible().

> +	ret = domain_attach_restored_iommu(dmar_domain, iommu, device_ser);
> +	if (ret)
> +		return ret;
> +
> +	info->domain = dmar_domain;
> +	info->domain_attached = true;
> +	spin_lock_irqsave(&dmar_domain->lock, flags);
> +	list_add(&info->link, &dmar_domain->devices);
> +	spin_unlock_irqrestore(&dmar_domain->lock, flags);
> +
> +	return 0;
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
> +	info->domain_attached = false;
> +
> +	spin_lock_irqsave(&info->domain->lock, flags);
> +	list_del(&info->link);
> +	spin_unlock_irqrestore(&info->domain->lock, flags);
> +
> +	domain_detach_restored_iommu(info->domain, iommu);
> +	info->domain = NULL;
> +
> +	return 0;
> +}
> +
>   enum pasid_lu_op {
>   	PASID_LU_OP_PRESERVE = 1,
>   	PASID_LU_OP_UNPRESERVE,

Thanks,
baolu
