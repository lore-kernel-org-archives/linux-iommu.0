Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB51A9FB7
	for <iommu@lists.linux.dev>; Mon, 22 Jun 2026 01:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782093108; cv=none; b=IpQT38Tk0KqVm0fv5ddREr2hXrTX/OrxySuuvK8C05FSjgZliIl7d+250jr4zqXnRS8x4Fz+zYt4XSMrw0Xcex83Y0kXIQlvY5gc358PG5/vgkM0sBuLHGyy+OngxBuiavDwJrpmfJXxa19KpjU+26Tct2meiNAG2uAEsU07QTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782093108; c=relaxed/simple;
	bh=IhFd4pwYcMEK9RXDArmw//aLgtYRiH8UKMytxagLRQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nv4Yz9xdualIMPEvTLdWMWAwq37HV9YAa1H/1AczU3dzYG0ZE21PAQL2/0rN/izXBKqYayBJzu3+Jt80S3P/yPFjADCHDgXSbX1ZkSG0fOo8Z8GXT4nc8rypS+ygE/+fp2MzQYTaOuOOAsCp9mbxXZxaU1OQIEwV7YPCBJ4HXbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0pb9X8j; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0pb9X8j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782093107; x=1813629107;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IhFd4pwYcMEK9RXDArmw//aLgtYRiH8UKMytxagLRQ0=;
  b=k0pb9X8jcNldbdCRdUkf2XyIcRxitZcjhQLaqZqLT09uA3BmERjzOU9x
   9c9mPx0Y2u3rJivG5flL2bX+9vv2q3p2CHMG29AF4w5PToQlVkqANLGLJ
   hcIG6PiFpJUZYOyTTybpbSIh0J6RHE/1WndILuK4yO74aVy3uL4Z7XXXc
   4fvOIpFtkwofm6Fy6W0Vs4Qb5j2D7fos2qXn+aBF6z6F9CdR0zE/Jwv4F
   nXxB7jX1aNKGdQnYVwncPRCKr7yIJEtO+/Qw6QYcHTnmRgX519XwO4Rwt
   WVOObzcQTLgO7nMVP04eDcLo63elY+A3T/EHhClZl7BEv7mBQXDjAjwF7
   Q==;
X-CSE-ConnectionGUID: MFSNuiNLTlK22plnkpDdsA==
X-CSE-MsgGUID: 84lJAmluSwq7CjjNwlMTVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11824"; a="100250561"
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="100250561"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 18:51:46 -0700
X-CSE-ConnectionGUID: wGA5Cx4nT2ina0INAfRSJw==
X-CSE-MsgGUID: TO3yEEHXSM6u7V00c39TOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,217,1774335600"; 
   d="scan'208";a="254093299"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2026 18:51:42 -0700
Message-ID: <f3e2fef9-4f8c-4032-8d7b-007f47b3fb61@linux.intel.com>
Date: Mon, 22 Jun 2026 09:50:36 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
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
References: <20260614233728.2212104-1-skhawaja@google.com>
 <20260614233728.2212104-8-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260614233728.2212104-8-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/15/26 07:37, Samiullah Khawaja wrote:
> Add implementation of the device and iommu presevation in a separate
> file. Also set the device and iommu preserve/unpreserve ops in the
> struct iommu_ops.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   MAINTAINERS                      |   8 ++
>   drivers/iommu/intel/Makefile     |   1 +
>   drivers/iommu/intel/iommu.c      |   8 +-
>   drivers/iommu/intel/iommu.h      |  28 +++++
>   drivers/iommu/intel/liveupdate.c | 175 +++++++++++++++++++++++++++++++
>   include/linux/kho/abi/iommu.h    |  21 ++++
>   6 files changed, 239 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/intel/liveupdate.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cef90bb50781..4dfb56962426 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13002,6 +13002,14 @@ S:	Supported
>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
>   F:	drivers/iommu/intel/
>   
> +INTEL IOMMU LIVEUPDATE (VT-d)
> +M:	Samiullah Khawaja <skhawaja@google.com>
> +M:	Lu Baolu <baolu.lu@linux.intel.com>
> +L:	iommu@lists.linux.dev
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
> +F:	drivers/iommu/intel/liveupdate.c
> +
>   INTEL IPU3 CSI-2 CIO2 DRIVER
>   M:	Yong Zhi <yong.zhi@intel.com>
>   M:	Sakari Ailus <sakari.ailus@linux.intel.com>
> diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
> index ada651c4a01b..d38fc101bc35 100644
> --- a/drivers/iommu/intel/Makefile
> +++ b/drivers/iommu/intel/Makefile
> @@ -6,3 +6,4 @@ obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
>   obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
>   obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
>   obj-$(CONFIG_INTEL_IOMMU_PERF_EVENTS) += perfmon.o
> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index c3d18cd77d2f..715b538e7efe 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -16,6 +16,7 @@
>   #include <linux/crash_dump.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dmi.h>
> +#include <linux/iommu-liveupdate.h>
>   #include <linux/memory.h>
>   #include <linux/pci.h>
>   #include <linux/pci-ats.h>
> @@ -60,8 +61,6 @@ static int force_on = 0;
>   static int intel_iommu_tboot_noforce;
>   static int no_platform_optin;
>   
> -#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> -
>   /*
>    * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>    * if marked present.
> @@ -3926,6 +3925,11 @@ const struct iommu_ops intel_iommu_ops = {
>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>   	.def_domain_type	= device_def_domain_type,
>   	.page_response		= intel_iommu_page_response,
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	.preserve_device	= intel_iommu_preserve_device,
> +	.preserve		= intel_iommu_preserve,
> +	.unpreserve		= intel_iommu_unpreserve,
> +#endif

Any reason why an unpreserve_device callback is missing here?

>   };
>   
>   static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index ef145560aa98..5e0bc17e76bf 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -552,6 +552,8 @@ struct root_entry {
>   	u64     hi;
>   };
>   
> +#define ROOT_ENTRY_NR (VTD_PAGE_SIZE / sizeof(struct root_entry))
> +
>   /*
>    * low 64 bits:
>    * 0: present
> @@ -1284,6 +1286,32 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int intel_iommu_preserve_device(struct device *dev,
> +				struct iommu_device_ser *device_ser);
> +int intel_iommu_preserve(struct iommu_device *iommu,
> +			 struct iommu_hw_ser *iommu_ser);
> +void intel_iommu_unpreserve(struct iommu_device *iommu,
> +			    struct iommu_hw_ser *iommu_ser);
> +#else
> +static inline int intel_iommu_preserve_device(struct device *dev,
> +					      struct iommu_device_ser *device_ser)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline int intel_iommu_preserve(struct iommu_device *iommu,
> +				       struct iommu_hw_ser *iommu_ser)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void intel_iommu_unpreserve(struct iommu_device *iommu,
> +					  struct iommu_hw_ser *iommu_ser)
> +{
> +}
> +#endif
> +
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
>   struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> new file mode 100644
> index 000000000000..b5613e4ad43a
> --- /dev/null
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2026, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt)    "DMAR: liveupdate: " fmt
> +
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/iommu-liveupdate.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +/* 2 tables per bus in scalable mode with upper table at odd bit */
> +#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) ((bus << 1) + (devfn >> 7))
> +static bool is_context_table_preserved(struct intel_iommu *iommu,
> +				       struct iommu_hw_ser *ser,
> +				       u8 bus, u8 devfn)
> +{
> +	return test_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
> +			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
> +}
> +
> +static void unpreserve_context_table(struct intel_iommu *iommu,
> +				     struct iommu_hw_ser *ser,
> +				     u8 bus, u8 devfn)
> +{
> +	struct context_entry *context;
> +
> +	spin_lock(&iommu->lock);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	spin_unlock(&iommu->lock);

The spinlock is dropped immediately after reading the address pointer.
If this is guaranteed to be safe, please add a comment to explain why a
UAF or race is avoided here. Otherwise, the locking scope needs to be
extened to protect both the pointer lookup and use.

> +	if (context && is_context_table_preserved(iommu, ser, bus, devfn)) {
> +		iommu_unpreserve_pages(context);
> +		clear_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
> +			  (unsigned long *)&ser->intel.context_tables_bitmap[0]);
> +	}
> +}
> +
> +static int preserve_context_table(struct intel_iommu *iommu,
> +				  struct iommu_hw_ser *ser,
> +				  u8 bus, u8 devfn)
> +{
> +	struct context_entry *context;
> +	int ret;
> +
> +	spin_lock(&iommu->lock);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	spin_unlock(&iommu->lock);

Ditto.

> +	if (context && !is_context_table_preserved(iommu, ser, bus, devfn)) {
> +		ret = iommu_preserve_pages(context);
> +		if (ret)
> +			return ret;
> +
> +		set_bit(CONTEXT_TABLE_PRESERVED_BIT(bus, devfn),
> +			(unsigned long *)&ser->intel.context_tables_bitmap[0]);
> +	}
> +
> +	return 0;
> +}
> +
> +static void unpreserve_iommu_context_tables(struct intel_iommu *iommu,
> +					    struct iommu_hw_ser *ser)
> +{
> +	int i;
> +
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		unpreserve_context_table(iommu, ser, i, 0);
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		unpreserve_context_table(iommu, ser, i, 0x80);
> +	}
> +}
> +
> +static int preserve_iommu_context_tables(struct device_domain_info *info)
> +{
> +	struct iommu_hw_ser *iommu_ser;
> +	struct intel_iommu *iommu;
> +	int ret;
> +	int i;
> +
> +	/* IOMMU for this device should already preserved.*/
> +	iommu = info->iommu;
> +	iommu_ser = iommu_preserved_state(&iommu->iommu);
> +	if (!iommu_ser)
> +		return -EINVAL;
> +
> +	/*
> +	 * We could do preservation of context tables only for the bus of this
> +	 * device, but these devices can have PCI aliases, so context tables for
> +	 * those will also require preservation. Also unpreserve would require
> +	 * some kind of refcounting where the context table will only be
> +	 * unpreserved when the last device associated with it is unpreserved.
> +	 *
> +	 * This introduces unnecessary complication with minimum benefits as the
> +	 * unpreserved context tables will probably be recreated by the next
> +	 * kernel as these are all active devices. We follow simpler approach by
> +	 * just preserving the currently active context tables.
> +	 */
> +	for (i = 0; i < ROOT_ENTRY_NR; i++) {
> +		ret = preserve_context_table(iommu, iommu_ser, i, 0);
> +		if (ret)
> +			return ret;
> +
> +		if (!sm_supported(iommu))
> +			continue;
> +
> +		ret = preserve_context_table(iommu, iommu_ser, i, 0x80);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int intel_iommu_preserve_device(struct device *dev,
> +				struct iommu_device_ser *device_ser)
> +{
> +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	int ret;
> +
> +	if (!dev_is_pci(dev)) {
> +		dev_err(dev, "Cannot preserve non-PCI device\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!info || !info->domain)
> +		return -EINVAL;
> +
> +	ret = preserve_iommu_context_tables(info);
> +	if (ret)
> +		return ret;
> +
> +	device_ser->domain_iommu_ser.attachment_id = domain_id_iommu(info->domain,
> +								     info->iommu);
> +	return 0;
> +}
> +
> +int intel_iommu_preserve(struct iommu_device *iommu_dev,
> +			 struct iommu_hw_ser *ser)
> +{
> +	struct intel_iommu *iommu;
> +	int ret;
> +
> +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> +
> +	ret = iommu_preserve_pages(iommu->root_entry);
> +	if (ret)
> +		return ret;
> +
> +	ser->intel.phys_addr = iommu->reg_phys;
> +	ser->intel.root_table = __pa(iommu->root_entry);
> +	ser->type = IOMMU_INTEL;
> +	ser->token = ser->intel.phys_addr;
> +
> +	return 0;
> +}
> +
> +void intel_iommu_unpreserve(struct iommu_device *iommu_dev,
> +			    struct iommu_hw_ser *ser)
> +{
> +	struct intel_iommu *iommu;
> +
> +	iommu = container_of(iommu_dev, struct intel_iommu, iommu);
> +
> +	unpreserve_iommu_context_tables(iommu, ser);
> +	iommu_unpreserve_pages(iommu->root_entry);
> +}
> diff --git a/include/linux/kho/abi/iommu.h b/include/linux/kho/abi/iommu.h
> index d06f251a2df4..ad760c497e13 100644
> --- a/include/linux/kho/abi/iommu.h
> +++ b/include/linux/kho/abi/iommu.h
> @@ -80,6 +80,7 @@
>    */
>   enum iommu_type_ser {
>   	IOMMU_INVALID,
> +	IOMMU_INTEL,
>   };
>   
>   #define IOMMU_SER_FLAG_DELETED	(1 << 0)
> @@ -140,16 +141,36 @@ struct iommu_device_ser {
>   	struct iommu_dev_map_ser domain_iommu_ser;
>   } __packed;
>   
> +/**
> + * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
> + * @restored: Whether IOMMU state is restored
> + * @phys_addr: Physical address of the IOMMU register base
> + * @root_table: Physical address of the root entry table
> + * @context_tables_bitmap: Bitmap representing the context tables that are
> + * preserved.
> + */
> +struct iommu_intel_ser {
> +	u8 restored;
> +	u8 padding[7];
> +	u64 phys_addr;
> +	u64 root_table;
> +	u64 context_tables_bitmap[8]; /* Tracks upto 512 context tables */

To avoid open-coded magic numbers, how about something like,

#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];

?

> +};
> +
>   /**
>    * struct iommu_hw_ser - Serialized state of an IOMMU instance
>    * @hdr: Common object header
>    * @token: Unique token for the IOMMU
>    * @type: IOMMU type serialized state belongs to
> + * @intel: Intel specific serialization data
>    */
>   struct iommu_hw_ser {
>   	struct iommu_hdr_ser hdr;
>   	u64 token;
>   	u64 type;
> +	union {
> +		struct iommu_intel_ser intel;
> +	};
>   } __packed;
>   
>   /**

Thanks,
baolu
