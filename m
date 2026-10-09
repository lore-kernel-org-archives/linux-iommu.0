Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D63367282
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791517154; cv=none; b=C2kUiTba6Y3snGizQm/sW60jNRj5Ewj0rwj2KhA3q7i52N/hD6GxYCCBz1gMMVCkLSVpKugGKId+RuorzODOG/PbpNanJUgp8poDFpiV1rQua5vV8G/41qPOYjtMK6L6afefbrtyfacskO5w6m+WkD1eeqNgaSzzNS/mAkT9dq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791517154; c=relaxed/simple;
	bh=qxkP7enFTqdhW6Qu4+SieFT7bB/OzuNtiOV4WmyjgcU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cDspe2ek5kgKxy9PM/6V8nlprR5EPicppgO4UEO6IMJmmLmBd7hDOdpEgrbov3xATPu+qzuT9D5QK1GwR+WMF86y5hfZ0xgR77prVv56OUpjc/B/LOmeSjb/TZZVJL5Untfctka7OJS5jZkXOCVeWd0pjVtm2Xqf057ndJAxExM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CtIsRyCj; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CtIsRyCj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791517145; x=1823053145;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxkP7enFTqdhW6Qu4+SieFT7bB/OzuNtiOV4WmyjgcU=;
  b=CtIsRyCjZ8t44tXyodM7Z/H3SF6aHntx1vb3Udmo5a9lZHNjjrCk1imT
   CISBn4pBVhm+lQnJ5TcDmjkqCDvNRDsJdhq9vnYnfj5wLbJ0YiGrqvZSb
   9whfuBag/eaoVk19RN5w4RXh7lcmT0Pfa4yzqfrwcz+HLppq6WIDAiGUg
   P6UAasKFU2LV+0cSNFjbBDPjo5+hovvJLYpDpoHnq2m6A3GBfvvHrCsM8
   oAhQm6eu26WeCbtNZ/Z/ypfmYJXtzh6ih/7ZAEE2nmPdkXemsFPoW2EaV
   1dL3dZSW8StQNsPKXGvNHWxIVosUd7+tlRZR94Bljx+aPpE29v1vm3a5X
   g==;
X-CSE-ConnectionGUID: Yphz+EP9QTWwE/JWNmnheQ==
X-CSE-MsgGUID: uX3N81rvTH+ckp34qeEEIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="322155"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="322155"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 20:39:04 -0700
X-CSE-ConnectionGUID: +j5MTzF0RgSefwq5oHFpug==
X-CSE-MsgGUID: J/DFg3C/RTyOkalJxGI/sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="535772"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 20:39:01 -0700
Message-ID: <f48258bb-df50-43bb-9141-433601d885a2@linux.intel.com>
Date: Fri, 9 Oct 2026 11:38:57 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
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
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH v5 13/18] iommu/vt-d: Preserve PASID table of preserved
 device
To: Samiullah Khawaja <skhawaja@google.com>,
 David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20260921004834.2601285-1-skhawaja@google.com>
 <20260921004834.2601285-14-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260921004834.2601285-14-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/21/2026 8:48 AM, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/liveupdate.c | 141 +++++++++++++++++++++++++++++--
>   drivers/iommu/intel/pasid.c      |  10 ++-
>   drivers/iommu/intel/pasid.h      |   8 ++
>   include/linux/kho/abi/iommu.h    |  17 ++++
>   4 files changed, 169 insertions(+), 7 deletions(-)

Should this patch come before patch 12/18, which restores the device’s
domain attachment?

> 
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index 6e6707eefc8c..b9467fb7195f 100644
> --- a/drivers/iommu/intel/liveupdate.c
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -14,6 +14,7 @@
>   #include <linux/pci.h>
>   
>   #include "iommu.h"
> +#include "pasid.h"
>   #include "../iommu-pages.h"
>   
>   /* 2 tables per bus in scalable mode with upper table at odd bit */
> @@ -510,6 +511,69 @@ int intel_iommu_detach_restored_device(struct device *dev)
>   	return 0;
>   }
>   
> +enum pasid_lu_op {
> +	PASID_LU_OP_PRESERVE = 1,
> +	PASID_LU_OP_UNPRESERVE,
> +	PASID_LU_OP_RESTORE,
> +};
> +
> +static int pasid_lu_do_op(void *table, enum pasid_lu_op op)
> +{
> +	int ret = 0;
> +
> +	switch (op) {
> +	case PASID_LU_OP_PRESERVE:
> +		ret = iommu_preserve_pages(table);
> +		break;
> +	case PASID_LU_OP_UNPRESERVE:
> +		iommu_unpreserve_pages(table);
> +		break;
> +	case PASID_LU_OP_RESTORE:
> +		iommu_restore_pages(virt_to_phys(table));
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int pasid_lu_handle_pd(struct pasid_dir_entry *dir,
> +			      u32 max_pasid, enum pasid_lu_op op)
> +{
> +	int max_pde = max_pasid >> PASID_PDE_SHIFT;
> +	struct pasid_entry *table;
> +	int i, ret;
> +
> +	for (i = 0; i < max_pde; i++) {
> +		table = get_pasid_table_from_pde(&dir[i]);
> +		if (!table)
> +			continue;
> +
> +		ret = pasid_lu_do_op(table, op);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = pasid_lu_do_op(dir, op);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	if (op != PASID_LU_OP_PRESERVE)
> +		return ret;
> +
> +	while (i > 0) {
> +		table = get_pasid_table_from_pde(&dir[--i]);
> +		if (!table)
> +			continue;
> +
> +		pasid_lu_do_op(table, PASID_LU_OP_UNPRESERVE);
> +	}
> +
> +	return ret;
> +}
> +
>   /**
>    * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
>    * @dev: Target device
> @@ -521,6 +585,7 @@ int intel_iommu_preserve_device(struct device *dev,
>   				struct iommu_device_ser *device_ser)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct pasid_table *pasid_table;
>   	int ret;
>   
>   	if (!dev_is_pci(dev)) {
> @@ -543,6 +608,22 @@ int intel_iommu_preserve_device(struct device *dev,
>   
>   	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
>   								     info->iommu);
> +
> +	if (!sm_supported(info->iommu))
> +		return 0;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return -EINVAL;
> +
> +	ret = pasid_lu_handle_pd(pasid_table->table,
> +				 pasid_table->max_pasid,
> +				 PASID_LU_OP_PRESERVE);
> +	if (ret)
> +		return ret;
> +
> +	device_ser->intel.pasid_table = virt_to_phys(pasid_table->table);
> +	device_ser->intel.max_pasid = pasid_table->max_pasid;
>   	return 0;
>   }
>   
> @@ -554,15 +635,33 @@ int intel_iommu_preserve_device(struct device *dev,
>   void intel_iommu_unpreserve_device(struct device *dev,
>   				   struct iommu_device_ser *device_ser)
>   {
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct pasid_table *pasid_table;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	if (!info)
> +		return;
> +
> +	if (!sm_supported(info->iommu))
> +		return;
> +
>   	/*
>   	 * The context tables preserved during device preservation, in the
>   	 * preserve_device() callback, might be shared with other devices, so
> -	 * those are unpreserved in the iommu unpreserve() callback. So this
> -	 * callback is kept empty.
> -	 *
> -	 * Once device PASID tables are preserved, the unpreservation of PASID
> -	 * tables will be added here.
> +	 * those are unpreserved in the iommu unpreserve() callback.
>   	 */
> +	if (!device_ser->intel.pasid_table)
> +		return;
> +
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!pasid_table)
> +		return;
> +
> +	pasid_lu_handle_pd(pasid_table->table,
> +			   pasid_table->max_pasid,
> +			   PASID_LU_OP_UNPRESERVE);
>   }
>   
>   /**
> @@ -607,3 +706,35 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
>   	unpreserve_iommu_context_tables(iommu, ser);
>   	iommu_unpreserve_pages(iommu->root_entry);
>   }
> +
> +/**
> + * intel_pasid_restore_table() - Restore preserved PASID table for a device
> + * @dev: Restored device
> + * @max_pasid: Maximum supported PASID
> + *
> + * Return: Pointer to restored PASID table directory, or NULL if not preserved.
> + */
> +void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
> +{
> +	struct iommu_device_ser *ser = dev_iommu_restored_state(dev);
> +
> +	if (!ser || !ser->intel.pasid_table)
> +		return NULL;
> +
> +	/*
> +	 * MAX PASID of a device should not change as it is read from
> +	 * capabilities.
> +	 */
> +	BUG_ON(ser->intel.max_pasid != max_pasid);
> +
> +	if (ser->intel.restored)
> +		goto out;
> +
> +	BUG_ON(pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +				  ser->intel.max_pasid,
> +				  PASID_LU_OP_RESTORE));
> +	ser->intel.restored = 1;
> +
> +out:
> +	return phys_to_virt(ser->intel.pasid_table);
> +}
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index e4f24d3f19a6..59cc69383799 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -13,6 +13,7 @@
>   #include <linux/cpufeature.h>
>   #include <linux/dmar.h>
>   #include <linux/iommu.h>
> +#include <linux/iommu-liveupdate.h>
>   #include <linux/memory.h>
>   #include <linux/pci.h>
>   #include <linux/pci-ats.h>
> @@ -60,8 +61,13 @@ int intel_pasid_alloc_table(struct device *dev)
>   
>   	size = max_pasid >> (PASID_PDE_SHIFT - 3);
>   	order = size ? get_order(size) : 0;
> -	dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> -					1 << (order + PAGE_SHIFT));
> +
> +	max_pasid = 1 << (order + PAGE_SHIFT + 3);
> +	if (dev_iommu_restored_state(dev))
> +		dir = intel_pasid_restore_table(dev, max_pasid);
> +	else
> +		dir = iommu_alloc_pages_node_sz(info->iommu->node, GFP_KERNEL,
> +						1 << (order + PAGE_SHIFT));

This restores only the PASID table pages. The PASID table is eventually
installed in the context entry during probe_device:

         if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
                 ret = intel_pasid_alloc_table(dev);
                 if (ret) {
                         dev_err(dev, "PASID table allocation failed\n");
                         goto clear_rbtree;
                 }

                 if (!context_copied(iommu, info->bus, info->devfn)) {
                         ret = intel_pasid_setup_sm_context(dev);
                         if (ret)
                                 goto free_table;
                 }
         }

For a restored PASID table, the call to intel_pasid_setup_sm_context()
should be skipped. Instead, it should check whether the preserved pasid
table is compatible with the new kernel environment.

>   	if (!dir) {
>   		kfree(pasid_table);
>   		return -ENOMEM;
> diff --git a/drivers/iommu/intel/pasid.h b/drivers/iommu/intel/pasid.h
> index 48d3bb6b68de..801768cdea16 100644
> --- a/drivers/iommu/intel/pasid.h
> +++ b/drivers/iommu/intel/pasid.h
> @@ -301,6 +301,14 @@ static inline void pasid_set_eafe(struct pasid_entry *pe)
>   
>   extern unsigned int intel_pasid_max_id;
>   int intel_pasid_alloc_table(struct device *dev);
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +void *intel_pasid_restore_table(struct device *dev, u64 max_pasid);
> +#else
> +static inline void *intel_pasid_restore_table(struct device *dev, u64 max_pasid)
> +{
> +	return NULL;
> +}
> +#endif
>   void intel_pasid_free_table(struct device *dev);
>   struct pasid_table *intel_pasid_get_table(struct device *dev);
>   int intel_pasid_setup_first_level(struct intel_iommu *iommu, struct device *dev,
> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
> index 5aaa29da6832..308cd83fd3e3 100644
> --- a/include/linux/kho/abi/iommu.h
> +++ b/include/linux/kho/abi/iommu.h
> @@ -129,6 +129,19 @@ struct iommu_dev_map_ser {
>   	u64 iommu_phys;
>   } __packed;
>   
> +/**
> + * struct iommu_device_intel_ser - Intel specific state of serialized device
> + * @restored: Whether the device state is restored
> + * @pasid_table: Physical address of pasid table
> + * @max_pasid: Maximum supported pasid
> + */
> +struct iommu_device_intel_ser {
> +	u8 restored;
> +	u8 padding[7];
> +	u64 pasid_table;
> +	u64 max_pasid;
> +} __packed;
> +
>   /**
>    * struct iommu_device_ser - Serialized state of a device
>    * @hdr: Common object header
> @@ -136,6 +149,7 @@ struct iommu_dev_map_ser {
>    * @pci_domain_nr: PCI domain number
>    * @dma_owner_token: Token to identify the DMA owner of this device
>    * @domain_iommu_ser: Domain and IOMMU mapping
> + * @intel: Intel specific serialization data
>    */
>   struct iommu_device_ser {
>   	struct iommu_hdr_ser hdr;
> @@ -143,6 +157,9 @@ struct iommu_device_ser {
>   	u32 pci_domain_nr;
>   	u64 dma_owner_token;
>   	struct iommu_dev_map_ser domain_iommu_ser;
> +	union {
> +		struct iommu_device_intel_ser intel;
> +	};
>   } __packed;
>   
>   /* There are maximum 256 buses, so maximum 512 context tables */

Thanks,
baolu
