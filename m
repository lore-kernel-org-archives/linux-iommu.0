Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793152304;
	b=zz3TMNXI+DFK9GDiIDeR/PUDy3pVNi3AjN2JDfqW1p3zhEQCvt8ZSXFA6/XGq7Lj3w3L
	 1xle4ycLxQ+j2u1CBGearYezYEERH2cZUTgkNRYLmqLrCkH4DRwvkm0K6MU83dk5OwSqb
	 X24j0xkMVgvHw4l9zzEcvDocCSZnV9GvZ2tLGvuxI+4VspdOtl2E/HgLWvw5ElBR2BUOu
	 ENXnq6HRMW2W+6HijuaLN4K8FiwR1aW1LKYnhB9Mq08Wf6Jl7rc4m/x+/elbBsuNWz+T7
	 Uj+unReesqEB6l5Br0CTxhtv4g7Vam/0l75GyQK4h33T5M75P/ydVV34nmbAjXGFJ9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793152304;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=G18YpjquSjO6D532GrD6rLkvIfON+n7DZwNyuYr0uic=;
	b=e6TNhD/4xgYPs/cqpvhRA/TYdLxb0chCIIh9jKkopn6Gnw/a+zjwrYC2rdzAFs+O9WRs
	 l4kBL8Zx0R/OtZh8oQnL6YTF25D8N2dP+trAVEzE6bpjbkNbs+3e8pX3EpK0r+mWAzUlT
	 L1PrZYGrp3y5qXs22pO5S8R4ccPKUduaJPFUPQpd44PAFGM4lyN9Wf+tsJu7AHVzyFWBQ
	 3XnaPb5ICRIECDh7bQOZAm4NFn3neXUgjCFULxHszL5jfyMy4TWfQGTY8/J2dQuSaG68p
	 GRmy+5Lze6GsLC/RD0QT0Vb00qh3Khz0s6H83GAPDu23Z+aX/mK+sg69dDgoF+hXK1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YXoOe7Y8;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D6C606A31A
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 01:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D6C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YXoOe7Y8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793152303; x=1824688303;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zzd3TmgZ5MZHTciE28cEVWUNl7miIFyDQPHHPlpHXlk=;
  b=YXoOe7Y86B0AUPUF/rtlMmst1xRmqFoEOZVAl0o0Xu7rhU4c/Os/g2Yt
   +FqyXFJLzg3PMBXvrJA6CupZbTZDrSb5f+dppboOTq/o8VQlNPbIUWdIF
   Sp3GBnnHN5XwgwwJ5Wp5Q+nMiygUZwjqecE4AFtaJRI4wxfOWnxitdt8o
   tfAIOkFzL74IksD6rMVko78IprkoatHKvoXEX7zb27yuoQ7bDRFvLdIy5
   YJNwnawEeEyC4CJMlSCtaB1PKcWbMVR7O0Bs7pyHU+c2GB3maZd6zMK0F
   XuBik5VuC0NJqDeUzyN0Yz4PUgx0FTeDpyr8kZioFiB6muG2JTuinQvyu
   w==;
X-CSE-ConnectionGUID: cE83Mn1LRju83r8FT/p6CA==
X-CSE-MsgGUID: Tf1hYJdgRmGAMNwpc1ECuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1891849"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1891849"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:51:42 -0700
X-CSE-ConnectionGUID: HdRX+of/TbSxvEJrPBy/1g==
X-CSE-MsgGUID: lKJx0SVBQSOcrz+Lw88BzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="6533872"
Received: from blu2-desk.sh.intel.com (HELO [10.239.156.26]) ([10.239.156.26])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 18:51:38 -0700
Message-ID: <b35a10e9-e48a-4da5-84d6-caaad693bb3d@linux.intel.com>
Date: Wed, 28 Oct 2026 09:51:18 +0800
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
Subject: Re: [PATCH v6 06/18] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
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
 <20261025021930.674647-7-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-7-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/26 10:19, Samiullah Khawaja wrote:
> Add implementation of the device and iommu preservation in a separate
> file. Also set the device and iommu preserve/unpreserve ops in the
> struct iommu_ops.
> 
> Preservation is refused for devices where ATS is supported. Carrying an
> active ATS configuration across kexec would require adopting the ATS
> state in the PCI core and in the context entries, and handling the
> disable-to-enable, enable-to-disable and STU mismatch cases for a live
> device.
> 
> Note that the preserved iommu root table, context table and device pasid
> table will need cleanup as devices do not go through the release flow
> during kexec. So the stale entries need to be removed during shutdown.
> This is done in the next commit.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   MAINTAINERS                      |   8 +
>   drivers/iommu/intel/Makefile     |   1 +
>   drivers/iommu/intel/iommu.c      |   9 +-
>   drivers/iommu/intel/iommu.h      |  13 ++
>   drivers/iommu/intel/liveupdate.c | 246 +++++++++++++++++++++++++++++++
>   include/linux/kho/abi/iommu.h    |  27 ++++
>   6 files changed, 302 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/iommu/intel/liveupdate.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 08800ff55cae..15e1da41b0cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13231,6 +13231,14 @@ S:	Supported
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
> index 5a2e705a2f2e..14bd1ca4fbd5 100644
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
> @@ -56,8 +57,6 @@ static int rwbf_quirk;
>    */
>   int intel_iommu_tboot_noforce;
>   
> -#define ROOT_ENTRY_NR (VTD_PAGE_SIZE/sizeof(struct root_entry))
> -
>   /*
>    * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>    * if marked present.
> @@ -4070,6 +4069,12 @@ const struct iommu_ops intel_iommu_ops = {
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
> index 5b3d234ae265..a6c0ed55db30 100644
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
> @@ -1305,6 +1307,17 @@ static inline int iopf_for_domain_replace(struct iommu_domain *new,
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
> +#endif
> +
>   #ifdef CONFIG_INTEL_IOMMU_SVM
>   void intel_svm_check(struct intel_iommu *iommu);
>   struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
> diff --git a/drivers/iommu/intel/liveupdate.c b/drivers/iommu/intel/liveupdate.c
> new file mode 100644
> index 000000000000..0047f9d92cbc
> --- /dev/null
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,246 @@
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
> +#define CONTEXT_TABLE_PRESERVED_BIT(bus, devfn) (((bus) << 1) + ((devfn) >> 7))
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
> +	 *
> +	 * The check and set of the context_tables_bitmap below is not atomic.
> +	 * This is fine as the IOMMU core serializes the preserve_device() and
> +	 * unpreserve() callbacks using the lock of its liveupdate FLB object.
> +	 * That lock is private to the IOMMU core, so it cannot be asserted here.
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

... should already be preserved ...

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
> +	if (info->ats_supported)
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * intel_iommu_preserve() is only called once per IOMMU, when the first
> +	 * device behind it is preserved. The context tables are allocated on
> +	 * demand as devices are probed, so new context tables might have been
> +	 * allocated since then. Preserve all the currently allocated context
> +	 * tables every time a device is preserved, so the context tables of the
> +	 * device being preserved are always covered.
> +	 */
> +	ret = preserve_iommu_context_tables(info);
> +	if (ret)
> +		return ret;
> +
> +	device_ser->attachment.attachment_id = domain_id_iommu(info->domain,
> +							       info->iommu);
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
> +	/*
> +	 * The context tables preserved during device preservation, in the
> +	 * preserve_device() callback, might be shared with other devices, so
> +	 * those are unpreserved in the iommu unpreserve() callback. So this
> +	 * callback is kept empty.
> +	 *
> +	 * Once device PASID tables are preserved, the unpreservation of PASID
> +	 * tables will be added here.
> +	 */
> +}
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
> +	ser->intel.sm_enabled = sm_supported(iommu);
> +	ser->intel.phys_addr = iommu->reg_phys;
> +	ser->intel.root_table = __pa(iommu->root_entry);
> +	ser->type = IOMMU_SER_TYPE_INTEL;
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
> index 20e6c764aa2e..95354a12ba1d 100644
> --- a/include/linux/kho/abi/iommu.h
> +++ b/include/linux/kho/abi/iommu.h
> @@ -77,12 +77,14 @@
>   /**
>    * enum iommu_type_ser - Type of the IOMMU being preserved
>    * @IOMMU_SER_TYPE_INVALID: Invalid type of IOMMU
> + * @IOMMU_SER_TYPE_INTEL: Intel VT-d IOMMU
>    *
>    * IOMMU type is stored in the IOMMU HW state to differentiate between various
>    * IOMMU HWs.
>    */
>   enum iommu_type_ser {
>   	IOMMU_SER_TYPE_INVALID,
> +	IOMMU_SER_TYPE_INTEL,
>   };
>   
>   #define IOMMU_SER_FLAG_DELETED	BIT(0)
> @@ -155,18 +157,43 @@ struct iommu_device_ser {
>   	u64 reserved[2];
>   } __packed;
>   
> +/* There are maximum 256 buses, so maximum 512 context tables */
> +#define VTD_PRESERVED_BITMAP_LONGS  DIV_ROUND_UP(512, BITS_PER_LONG_LONG)
> +
> +/**
> + * struct iommu_intel_ser - Serialized state of an Intel IOMMU instance
> + * @features: Bitmask of Intel IOMMU specific features
> + * @sm_enabled: Whether the IOMMU was used in scalable mode
> + * @phys_addr: Physical address of the IOMMU register base
> + * @root_table: Physical address of the root entry table
> + * @context_tables_bitmap: Bitmap representing the context tables that are
> + * preserved.
> + */
> +struct iommu_intel_ser {
> +	u32 features;
> +	u8 sm_enabled;
> +	u8 padding[3];
> +	u64 phys_addr;
> +	u64 root_table;
> +	u64 context_tables_bitmap[VTD_PRESERVED_BITMAP_LONGS];
> +} __packed;
> +
>   /**
>    * struct iommu_hw_ser - Serialized state of an IOMMU instance
>    * @hdr: Common object header
>    * @token: Unique token to identify the IOMMU instance
>    * @type: IOMMU type serialized state belongs to
>    * @reserved: Reserved for future common fields.
> + * @intel: Intel specific serialization data
>    */
>   struct iommu_hw_ser {
>   	struct iommu_hdr_ser hdr;
>   	u64 token;
>   	u64 type;
>   	u64 reserved[2];
> +	union {
> +		struct iommu_intel_ser intel;
> +	};
>   } __packed;
>   
>   /**

This patch looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
