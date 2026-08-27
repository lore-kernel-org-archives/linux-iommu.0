Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDAD3C3443
	for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 08:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787818333; cv=none; b=Z1+rWZKjm/R980ZmbUdk+3RgiPmqquYkM3GVRBtO1prz5ff2OdrD+Q1L6jn8/H78xrWR3WGAI51lZVH3Pk8TIErU5omdQgP3JNg2L/6hr+ltk4y87WokLi/yCJZ5E9vWitUPenlHjo5FBr9fvslhFQwdn/C8ClCRTRLTnTxTDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787818333; c=relaxed/simple;
	bh=xIw5or3RM6YwBPe1jR7j4fTvcYob61G6FjHWuUnrzDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HFnNokbPnTNOjbWT1L2O9e96Swx+//xAkHtX0Y9eGfehV4iQ0g+YZ7wcGj5X+pxrc0H+cW09uzHzwAPRwBnyrtNe4GY01XNmM8A+AtFMnSlcTX5JQknpRQHxX+Dxxw1nLmlJCjQrHWJuN7Jd6QDqubZMvlvgyDctvW1XkT0kENs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PHRTWH9s; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PHRTWH9s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787818330; x=1819354330;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIw5or3RM6YwBPe1jR7j4fTvcYob61G6FjHWuUnrzDs=;
  b=PHRTWH9sSlNUHfjk96WV6vkqrsyIMkti9W8cke/OyRDlMVr2fZsqBiWc
   GNhbLjZxmWj4V5n9EF5E5izc6pqVE8a7WNb6JnO4vl4uMimakJah3F5HE
   rFHvaaT02xwVlag0kGMBtHH1jjImU6a7gvlSLB04i38t4Q4R8TEUC3pUt
   cn0sbBVgiwi9dezwjfXYEkx0/xH8Am7pzJq83LV11ykNQEUGJ/xMcs0IF
   mXa8w9Jtmp6eFwDwQLym9xb0GbX0DuCKlpXJYPQ/fXEJne6SNoMPNjP6L
   Mqzoek/EmjyVOcpa6MAjUvw0vvYa++cbVdlL5xVvM5XNEHvq+8oE0QwE8
   Q==;
X-CSE-ConnectionGUID: 85n1IuptQ8aYAYZOI1ETHg==
X-CSE-MsgGUID: TEmEXpeeTWe/mldozNqD0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="87254981"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="87254981"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 01:12:07 -0700
X-CSE-ConnectionGUID: K34+mq1JRQGKND7PRdXgig==
X-CSE-MsgGUID: qy5v8s5WR5mzCXNHocKrGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="264558865"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 01:12:03 -0700
Message-ID: <5b920299-260b-4025-ac4f-e8f83beebf95@linux.intel.com>
Date: Thu, 27 Aug 2026 16:12:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/18] iommu/vt-d: Handle reattach of the restored
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
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-13-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260808022723.3893618-13-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 10:27, Samiullah Khawaja wrote:
> Reattach the restored domain to the preserved device using restored
> domain ID. While reattaching do not setup the context and PASID entries
> as those are preserved during liveupdate.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |   9 ++-
>   drivers/iommu/intel/iommu.h      |  10 +++
>   drivers/iommu/intel/liveupdate.c | 120 +++++++++++++++++++++++++++++++
>   3 files changed, 136 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 42d3ff6db281..5370214629f4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -864,7 +864,7 @@ static bool dev_needs_extra_dtlb_flush(struct pci_dev *pdev)
>   	return true;
>   }
>   
> -static void iommu_enable_pci_ats(struct device_domain_info *info)
> +void intel_iommu_enable_pci_ats(struct device_domain_info *info)
>   {
>   	struct pci_dev *pdev;
>   
> @@ -1225,7 +1225,7 @@ domain_context_mapping(struct dmar_domain *domain, struct device *dev)
>   	if (ret)
>   		return ret;
>   
> -	iommu_enable_pci_ats(info);
> +	intel_iommu_enable_pci_ats(info);
>   
>   	return 0;
>   }
> @@ -3164,6 +3164,9 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
>   {
>   	int ret;
>   
> +	if (dev_iommu_restored_state(dev))
> +		return intel_iommu_restore_device(domain, dev);
> +
>   	device_block_translation(dev);
>   
>   	ret = paging_domain_compatible(domain, dev);
> @@ -3376,7 +3379,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
>   		info->pasid_enabled = 1;
>   
>   	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
> -		iommu_enable_pci_ats(info);
> +		intel_iommu_enable_pci_ats(info);
>   		/* Assign a DEVTLB cache tag to the default domain. */
>   		if (info->ats_enabled && info->domain) {
>   			u16 did = domain_id_iommu(info->domain, iommu);
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index b33a12528066..1ef3b9309d44 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -1187,6 +1187,8 @@ void domain_detach_iommu(struct dmar_domain *domain, struct intel_iommu *iommu);
>   void device_block_translation(struct device *dev);
>   int paging_domain_compatible(struct iommu_domain *domain, struct device *dev);
>   
> +void intel_iommu_enable_pci_ats(struct device_domain_info *info);
> +
>   struct dev_pasid_info *
>   domain_add_dev_pasid(struct iommu_domain *domain,
>   		     struct device *dev, ioasid_t pasid);
> @@ -1309,6 +1311,8 @@ void intel_iommu_unpreserve(struct iommu_device *iommu,
>   void clear_unpreserved_context_entries(struct intel_iommu *iommu);
>   void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   					       struct iommu_hw_ser *iommu_ser);
> +int intel_iommu_restore_device(struct iommu_domain *domain,
> +			       struct device *dev);
>   #else
>   static inline int intel_iommu_preserve_device(struct device *dev,
>   					      struct iommu_device_ser *device_ser)
> @@ -1340,6 +1344,12 @@ static inline void intel_iommu_liveupdate_restore_root_table(struct intel_iommu
>   							     struct iommu_hw_ser *iommu_ser)
>   {
>   }
> +
> +static inline int intel_iommu_restore_device(struct iommu_domain *domain,
> +					     struct device *dev)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif
>   
>   #ifdef CONFIG_INTEL_IOMMU_SVM
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 480eab2d966b..05dea3893399 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -12,6 +12,7 @@
>   #include <linux/iommu-liveupdate.h>
>   #include <linux/module.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>   
>   #include "iommu.h"
>   #include "../iommu-pages.h"
> @@ -342,6 +343,125 @@ void intel_iommu_liveupdate_restore_root_table(struct intel_iommu *iommu,
>   	BUG_ON(iommu_for_each_preserved_device(_restore_used_domain_ids, iommu));
>   }
>   
> +static void domain_detach_reattached_iommu(struct dmar_domain *domain,
> +					   struct intel_iommu *iommu)
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
> +	int restored_did;
> +	int ret;
> +
> +	if (!iommu_domain_restored_state(&domain->domain))
> +		return -EINVAL;
> +
> +	restored_did = device_ser->domain_iommu_ser.attachment_id;
> +	if (!ida_exists(&iommu->domain_ida, restored_did))
> +		return -EINVAL;

It seems that checking only whether the domain ID is reserved on this
IOMMU may not be sufficient. It would be safer to also verify that:

- device_ser->domain_iommu_ser.iommu_phys matches iommu->reg_phys, and
- device_ser->domain_iommu_ser.domain_phys matches @domain.

?

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

... or, move above check here to ensure the attachment relationship
between the @device and @domain?

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
> +	if (!sm_supported(iommu))
> +		intel_iommu_enable_pci_ats(info);

Could you please clarify the PCI ATS behavior across live update?

My understanding is that PCI devices may bypass reset during kexec and
are then re-initialized by the new kernel (is that correct?). If so, ATS
state in hardware would depend on its state before kexec in the old
kernel.

In a normal reboot, ATS is expected to be disabled and the device ATC is
empty. But that assumption may not hold for live update. If that is
true, can we still use the same approach to keep hardware ATS state and
info->ats_enabled in sync?

> +
> +	ret = cache_tag_assign_domain(dmar_domain, dev, IOMMU_NO_PASID);
> +	if (ret)
> +		goto err;
> +
> +	ret = iopf_for_domain_set(domain, dev);
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
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device

Thanks,
baolu
