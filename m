Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793259750;
	b=Q6/jzVzoF3F3vDN7Yuwoe1d8IbQdhshZi0YSAaVMKP0+xTDnuzmMe5se73QR3DFnTlql
	 kNLqEcb/jlQ5M8ID+1hBxIH8maqGneOFlP4g5YluWE3gzYL2lq49bYMFAfelfOF7ZTx1R
	 vVm87CaUvXK4VXYSDUO1qTEy7j9EAtjwLaCAlI8bs0fRFUZ/hsPZAwLUUxLzKGTb4V8AI
	 D2NeqK46d34l+n+oA2aPeJ57Ji7MGfkKTP3z51ZSGvSTWySM9/2NLTF5D7i3lorMCyknW
	 dsDrCbJZpww+msVyd6xd8ahKxf3s4M5r50Re4aa9dv7WU9WgRZor85Rwh9g4ssm9q4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793259750;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uqtLDQD5xTS0V2akScr1AeCuZBi18jL8j7JRCM14Iek=;
	b=f0Tb+fAhERIz0mp6Z6WFNVnhgtjCxBwOnX9jAo2tyM2zM3ltV07Eu6TzxbloAKteLMJI
	 c3hu6IOaCl7GgzgE+t5d8HOdBjGOBdoEsSRLhDTdd3upyzRtJ6PRSFuMYJuSqXl+Bv7lP
	 eXd4HUfQM0oLraPjbNDfso7BGDBP6QegKTz0ZSTzbCX+Rk4jVG94/qlrczyRmb6RWzxgE
	 2jnRQ6LkulBoANPXd9VRYYZ6kXdWuUYxOF9WFmU2q9msCCusQYTGHBRxx+xAEOPT1wMgx
	 WkpNppARhL3N8Zoy5cATYcq3r664MD1pMkcx9DrJ3myT4r2ilDTNw+OL06jUjnYfSQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djNC1Rw9;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F1606A31A
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 07:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472F1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=djNC1Rw9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793259750; x=1824795750;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MVpVtdLQY4IkhjqzlWnwVcUPW52r2XOrV9LJwuyJ5k4=;
  b=djNC1Rw9WbnjxgyKxSPeoG/tA56mEJCCp2eIq8otp+wwnxh4cPTWghmT
   0IGHoQ2iObykXtCqFJZQEYK4nextG6C98Zwg7aMhKIYYhN28UT2xLdn+m
   +HcMHpzx16DTQSKkcPytTtAx+/njBGf9fwVA70v37qfNYlmnAGaoxU0sR
   rN7Q3ojYBXcELXwPL/smFFf5bUiYSJpippOPJjy2XH008TgMZXNa351OM
   o8kXq8wI9JQZriQQwEgr9vTB04m+JYmOoPoyiq9D+nV9y082Gc21jlN8f
   DpaoL7C+Pz++4Mfe+FqeqfsWNiExcKLKfyh3TacPexL20l0ONgJUDjp9D
   w==;
X-CSE-ConnectionGUID: ecEb/cTBQASH/2WiBqOBFA==
X-CSE-MsgGUID: AfhmUlGbTqiYBGbXCpDo1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="2022963"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="2022963"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:42:29 -0700
X-CSE-ConnectionGUID: kxMxIR/0T1ONe6fL/FYo9Q==
X-CSE-MsgGUID: 3ztfeBnzRVClbEO5iW7CNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5456510"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 00:42:24 -0700
Message-ID: <0945bca7-fb1c-4bbe-b14d-1e9939738daf@linux.intel.com>
Date: Thu, 29 Oct 2026 15:42:21 +0800
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
Subject: Re: [PATCH v6 11/18] iommu/vt-d: Preserve PASID table of preserved
 device
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-12-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-12-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> In scalable mode the PASID table is used to fetch the io page tables.
> Preserve and restore the PASID table of the preserved devices.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/intel/iommu.c      |   3 +-
>   drivers/iommu/intel/liveupdate.c | 144 +++++++++++++++++++++++++++++--
>   drivers/iommu/intel/pasid.c      |  10 ++-
>   drivers/iommu/intel/pasid.h      |   8 ++
>   include/linux/kho/abi/iommu.h    |  19 ++++
>   5 files changed, 176 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 991ad9b2456e..ecec057f78dd 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -3473,7 +3473,8 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>   			goto clear_rbtree;
>   		}
>   
> -		if (!context_copied(iommu, info->bus, info->devfn)) {
> +		if (!context_copied(iommu, info->bus, info->devfn) &&
> +		    !dev_iommu_restored_state(dev)) {
>   			ret = intel_pasid_setup_sm_context(dev);
>   			if (ret)
>   				goto free_table;
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> index cf98b95bf8d2..36816d3651e6 100644
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
> @@ -393,6 +394,69 @@ void intel_iommu_handle_drhd_restore_failure(struct intel_iommu *iommu)
>   		      iommu->name);
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
> @@ -404,6 +468,7 @@ int intel_iommu_preserve_device(struct device *dev,
>   				struct iommu_device_ser *device_ser)
>   {
>   	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct pasid_table *pasid_table;
>   	int ret;
>   
>   	if (!dev_is_pci(dev)) {
> @@ -434,6 +499,22 @@ int intel_iommu_preserve_device(struct device *dev,
>   
>   	device_ser->attachment.attachment_id = domain_id_iommu(info->domain,
>   							       info->iommu);
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
> @@ -445,15 +526,33 @@ int intel_iommu_preserve_device(struct device *dev,
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
> @@ -499,3 +598,38 @@ void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
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
> +	if (ser->intel.max_pasid != max_pasid)
> +		panic("%s: preserved max PASID %llu does not match %llu\n",
> +		      dev_name(dev), ser->intel.max_pasid, max_pasid);
> +
> +	if (ser->intel.restored)
> +		goto out;
> +
> +	if (pasid_lu_handle_pd(phys_to_virt(ser->intel.pasid_table),
> +			       ser->intel.max_pasid, PASID_LU_OP_RESTORE))
> +		panic("%s: failed to restore preserved PASID table\n",
> +		      dev_name(dev));
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
> index 95354a12ba1d..08443f6cee6f 100644
> --- a/include/linux/kho/abi/iommu.h
> +++ b/include/linux/kho/abi/iommu.h
> @@ -137,6 +137,21 @@ struct iommu_attachment_ser {
>   	u32 padding;
>   } __packed;
>   
> +/**
> + * struct iommu_device_intel_ser - Intel specific state of serialized device
> + * @features: Bitmask of Intel device specific features
> + * @restored: Whether the device state is restored
> + * @pasid_table: Physical address of pasid table
> + * @max_pasid: Maximum supported pasid
> + */
> +struct iommu_device_intel_ser {
> +	u32 features;
> +	u8 restored;
> +	u8 padding[3];
> +	u64 pasid_table;
> +	u64 max_pasid;
> +} __packed;
> +
>   /**
>    * struct iommu_device_ser - Serialized state of a device
>    * @hdr: Common object header
> @@ -146,6 +161,7 @@ struct iommu_attachment_ser {
>    * @iommu_phys: Physical address of the serialized IOMMU the device is behind
>    * @attachment: Attachment of the device to its domain
>    * @reserved: Reserved for future common fields.
> + * @intel: Intel specific serialization data
>    */
>   struct iommu_device_ser {
>   	struct iommu_hdr_ser hdr;
> @@ -155,6 +171,9 @@ struct iommu_device_ser {
>   	u64 iommu_phys;
>   	struct iommu_attachment_ser attachment;
>   	u64 reserved[2];
> +	union {
> +		struct iommu_device_intel_ser intel;
> +	};
>   } __packed;
>   
>   /* There are maximum 256 buses, so maximum 512 context tables */

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
