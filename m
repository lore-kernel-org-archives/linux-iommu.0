Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB3C37A4AF
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787728240; cv=none; b=iSkvqVaRvwk7PKcaJpSimZKNQzSozS9V/ZOT79d8x5789IMGxR1S2NkTifsgg7UY9M1mDMkOeQKhKPeeaV7Mhnfw1Di61PEDCCxej02UkmBq8doDOELdIH/HutZeGKCMy6rbbvGvREaT2KqApa2c5YEQvH27Mp0qoFWFLtheEwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787728240; c=relaxed/simple;
	bh=igsS+i1+R6ldFfaZzDh1PXkfxvgl7Kuv+Wpuh0oPVcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DFkH3gZoiXmTUce7sCwwM2uqu1Pu0Vt9Bjuu+ypRcvtX6ZGMxzj0BYTZmt2WZZGErWWzC6HtGFdvtU6px4NluMN8Ppes8SOwegLoiubAfG7v/9nv+Otu0Pw2HvA5kn1oPr6Or3Ovo2mkw/6JQar4wOoQc6gDp7+rT9SpuRcbhvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d9YrNhRt; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d9YrNhRt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787728238; x=1819264238;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=igsS+i1+R6ldFfaZzDh1PXkfxvgl7Kuv+Wpuh0oPVcs=;
  b=d9YrNhRtmWiDVhP7oqUDoBgX1mrI9Pb0wymYwtndPU2C8OPlpZueSGWx
   ByZ2/ngBbXmZz0Vssz0QZz0iDta1rQeR6GfP7LuCIFEXEMIlwjevoH5Ew
   thI0uCJ3psifSJ+IQ+HAX7eaLJq0ukilhPtxLwBUzDkcG9VythUc14WeK
   DTAbhu1Yo5yVsQ3peEIrwycxTQYP0HcbSfKGW6Q5beIIivrtoABDt/qiQ
   WIOO3AxQ24LQ7sbzAdGojaepPcVbvi5AKZZ+EcMphseoEucfP4aH/HEfS
   TSWVr090LPiYyG/enUYl2hltYDn1nYkxmxObnBv7xaKn8TZnv0nPvZqIr
   Q==;
X-CSE-ConnectionGUID: XXdBhF+NRsmh1Ri0pgiFHQ==
X-CSE-MsgGUID: EnxcIfvbT6yssTGhHAvHPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="75742259"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="75742259"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:10:37 -0700
X-CSE-ConnectionGUID: fKUrZBt0TF6paIgE+YoEpw==
X-CSE-MsgGUID: llkuth/WR5G1O+g9mD4R5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="266207409"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:10:33 -0700
Message-ID: <065b2be2-2ff1-42a0-99b1-ed81e783dca1@linux.intel.com>
Date: Wed, 26 Aug 2026 15:10:31 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] iommu/vt-d: Implement device and iommu
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
References: <20260808022723.3893618-1-skhawaja@google.com>
 <20260808022723.3893618-8-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260808022723.3893618-8-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/8/26 10:27, Samiullah Khawaja wrote:
> Add implementation of the device and iommu presevation in a separate
> file. Also set the device and iommu preserve/unpreserve ops in the
> struct iommu_ops.

This patch, on its own, does not fully implement the preserve operation.
At this point, the callback preserves all root/context entries used for
live update, but it does not yet clear non-preserved entries and
invalidate the related caches; that cleanup is supposed to be done in
the next patch.

So I think we should either:

- add a brief note here to make this dependency explicit, or
- merge these two patches into a single patch for completeness.

?

> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   MAINTAINERS                      |   8 ++
>   drivers/iommu/intel/Makefile     |   1 +
>   drivers/iommu/intel/iommu.c      |   9 +-
>   drivers/iommu/intel/iommu.h      |  35 +++++
>   drivers/iommu/intel/liveupdate.c | 220 +++++++++++++++++++++++++++++++
>   include/linux/kho/abi/iommu.h    |  25 ++++
>   6 files changed, 296 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/intel/liveupdate.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 25707398426a..2ed856ab0501 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13132,6 +13132,14 @@ S:	Supported
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
> index 849d06dfe1ae..aeae0563dfd0 100644
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
> @@ -3931,6 +3930,12 @@ const struct iommu_ops intel_iommu_ops = {
>   	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>   	.def_domain_type	= device_def_domain_type,
>   	.page_response		= intel_iommu_page_response,
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	.preserve_device	= intel_iommu_preserve_device,
> +	.unpreserve_device	= intel_iommu_unpreserve_device,
> +	.preserve		= intel_iommu_preserve,
> +	.unpreserve		= intel_iommu_unpreserve,
> +#endif
>   };
>   
>   static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 775f1c4ae346..4906cce1e66e 100644
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
> @@ -1295,6 +1297,39 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
>   	return 0;
>   }
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int intel_iommu_preserve_device(struct device *dev,
> +				struct iommu_device_ser *device_ser);
> +void intel_iommu_unpreserve_device(struct device *dev,
> +				   struct iommu_device_ser *device_ser);
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
> +static inline void intel_iommu_unpreserve_device(struct device *dev,
> +						 struct iommu_device_ser *device_ser)
> +{
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

I believe the #else ... #endif stubs are unnecessary and can be removed.

Specially iommu core checks driver support via callback pointer
presence:

         if (!iommu->iommu_dev->ops->preserve_device ||
             !iommu->iommu_dev->ops->unpreserve_device ||
             !iommu->iommu_dev->ops->preserve ||
             !iommu->iommu_dev->ops->unpreserve)
                 return -EOPNOTSUPP

So when CONFIG_IOMMU_LIVEUPDATE is disabled, simply not wiring these
callbacks is sufficient.

> +
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
>   struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> new file mode 100644
> index 000000000000..ffdcebf2b773
> --- /dev/null
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,220 @@
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
> +	/*
> +	 * In the Intel IOMMU driver, context tables are never freed once they
> +	 * are allocated during runtime, as they can be shared across multiple
> +	 * devices. So taking the iommu lock here to protect against concurrent
> +	 * allocations inside iommu_context_addr() should be enough. Once the
> +	 * address is read, it is safe to use it without holding the lock.
> +	 */
> +	spin_lock(&iommu->lock);
> +	context = iommu_context_addr(iommu, bus, devfn, 0);
> +	spin_unlock(&iommu->lock);
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
> +
> +	/*
> +	 * Intel IOMMU context tables are never freed by the driver once
> +	 * allocated. It is safe to access the context pointer outside of the
> +	 * iommu->lock.
> +	 */
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
> +/**
> + * intel_iommu_preserve_device() - Intel IOMMU callback to preserve device state
> + * @dev: Target device
> + * @device_ser: Struct to populate with serialized device state
> + *
> + * Return: 0 on success, or negative error code.
> + */
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
> +	if (dev_is_real_dma_subdevice(dev))
> +		return -EOPNOTSUPP;
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
> +/**
> + * intel_iommu_unpreserve_device() - Intel IOMMU callback to unpreserve device state
> + * @dev: Target device
> + * @device_ser: Struct containing serialized device state
> + */
> +void intel_iommu_unpreserve_device(struct device *dev,
> +				   struct iommu_device_ser *device_ser)
> +{
> +}

Please add a comment explaining why this callback is intentionally
empty.

> +
> +/**
> + * intel_iommu_preserve() - Intel IOMMU callback to preserve hardware state
> + * @iommu_dev: Generic IOMMU device handle
> + * @ser: Struct to populate with serialized hardware state
> + *
> + * Return: 0 on success, or negative error code.
> + */
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
> +/**
> + * intel_iommu_unpreserve() - Intel IOMMU callback to unpreserve hardware state
> + * @iommu_dev: Generic IOMMU device handle
> + * @ser: Struct containing serialized hardware state
> + */
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
> index 7641a86684e2..430c42bf9561 100644
> --- a/include/linux/kho/abi/iommu.h
> +++ b/include/linux/kho/abi/iommu.h
> @@ -81,6 +81,7 @@
>    */
>   enum iommu_type_ser {
>   	IOMMU_INVALID,
> +	IOMMU_INTEL,
>   };
>   
>   #define IOMMU_SER_FLAG_DELETED	(1 << 0)
> @@ -142,16 +143,40 @@ struct iommu_device_ser {
>   	struct iommu_dev_map_ser domain_iommu_ser;
>   } __packed;
>   
> +
> +/* There are maximum 256 buses, so maximum 512 context tables */
> +#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
> +
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
> +	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
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
