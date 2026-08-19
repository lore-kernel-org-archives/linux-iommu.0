Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F55C385D70
	for <iommu@lists.linux.dev>; Wed, 19 Aug 2026 13:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787145520; cv=none; b=MF0J+mEDWGFmVzyrPZM3eIpx6QOJSPdeZUrc2QMg2vvTzLMOA0KyBQgIJE5OjPiZI/Yqe5aiKKXZ/+4BDjJxCh3Gfm9avVVcPZs8JqD77Wn5NrkqzPHaMMEeJl3xg2PGlWGvRMGibJ6WHGdRQUq3wzmgyAo5gGLu43bvmzaiXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787145520; c=relaxed/simple;
	bh=vn/SkGjfNrKD8wvWcu+XDj6+BCww9V0YVlnZajvUnvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiNPzW6pts7UmBOhLPP9lKB5oWAIp+X6zWEdvg9UJ/YqPhkBkSJa2DR/V0V4nKJcR1d54cpKW/lx0yF9+zviMmPhrfRZc46L+gCr7PiYIgKcwM03Hwk6VT8n4VoEcrtV+tryPwz8fCTeAozw+Sz+NUmdTjNnDL2nlcG9EZMHbi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EUwWkm28; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EUwWkm28"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787145510; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ehot8+ud1Cx8OFo0VWldk2182LeLIkSkmbUUWPzs2Xc=;
	b=EUwWkm28AC0TodbByZdcxrRAD3GKx+Pg214t3mebU4YLS/IsGN5zH4qsk/MskJVNQ1KSusCzz41GRR+2KKbvTzjXxdm2JQMeZIiSZL6TdcYx+bGJzJa/rV0RjaeRBrJUmM8HwZ+HO85abLBZig9BuNQtxFeYidSnDrTAaEAr27w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X9Geup4_1787145509;
Received: from 30.221.133.143(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0X9Geup4_1787145509 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 21:18:29 +0800
Message-ID: <59ce731f-8514-43fb-b9f1-96b4599478c2@linux.alibaba.com>
Date: Wed, 19 Aug 2026 21:18:28 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
From: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
In-Reply-To: <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2026/7/27 21:28, Suravee Suthikulpanit 写道:
> Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
> capability (VSC), reading the VF and VF Control BAR addresses, and
> mapping them for host access (256MB VF, 4MB VF Control).
>
> VF Control covers the first 4K of guest IOMMU MMIO (control registers,
> trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
> IOMMU). Per-guest bases use the Guest ID from the previous patch.
>
> Initialize the per-amd_iommu gid_ida here so amd_iommu_gid_alloc() can
> run when IOMMUFD creates a vIOMMU instance. Export MMIO map helpers and
> call amd_viommu_uninit() from IOMMU teardown.
>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu.h       |   2 +
>   drivers/iommu/amd/amd_iommu_types.h |  34 ++++++++
>   drivers/iommu/amd/amd_viommu.h      |   6 ++
>   drivers/iommu/amd/init.c            |   5 +-
>   drivers/iommu/amd/viommu.c          | 124 ++++++++++++++++++++++++++++
>   5 files changed, 169 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9f2a1a8a6d3c..044bc9a634a1 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -28,6 +28,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>   void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
>   void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
>   				  gfp_t gfp, size_t size);
> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
> +void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
>   
>   #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>   void amd_iommu_debugfs_setup(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 00f964d5b149..e88e0bacd1a9 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -40,6 +40,12 @@
>   #define MMIO_RANGE_OFFSET	0x0c
>   #define MMIO_MISC_OFFSET	0x10
>   
> +/* vIOMMU Capability offsets (from IOMMU Capability Header) */
> +#define MMIO_VSC_VF_BAR_LO_OFFSET	0x08
> +#define MMIO_VSC_VF_BAR_HI_OFFSET	0x0c
> +#define MMIO_VSC_VF_CNTL_BAR_LO_OFFSET	0x10
> +#define MMIO_VSC_VF_CNTL_BAR_HI_OFFSET	0x14
> +
>   /* Masks, shifts and macros to parse the device range capability */
>   #define MMIO_RANGE_LD_MASK	0xff000000
>   #define MMIO_RANGE_FD_MASK	0x00ff0000
> @@ -473,6 +479,20 @@ extern bool amdr_ivrs_remap_support;
>   #define for_each_ivhd_dte_flags(entry) \
>   	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
>   
> +/* VIOMMU stuff */
> +#define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
> +#define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
> +
> +/* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
> +#define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
> +#define VIOMMU_VF_CNTL_MMIO_MAP_SIZE	0x400000UL
> +
> +#define VIOMMU_VF_MMIO_BASE(iommu, guestId) \
> +	(iommu->vf_base + (guestId * VIOMMU_VF_MMIO_ENTRY_SIZE))
> +
> +#define VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId) \
> +	(iommu->vfctrl_base + (guestId * VIOMMU_VFCTRL_MMIO_ENTRY_SIZE))
> +
>   struct amd_iommu;
>   struct iommu_domain;
>   struct irq_domain;
> @@ -686,6 +706,20 @@ struct amd_iommu {
>   	 */
>   	u16 cap_ptr;
>   
> +	/* Vendor-Specific Capability (VSC) pointer. */
> +	u16 vsc_offset;
> +
> +	/*
> +	 * VF MMIO base physical address. This is needed to calculate/pass
> +	 * per guest VF MMIO address (3rd 4K of IOMMU MMIO space)
> +	 */
> +	u64 vf_base_phys;
> +	u64 vf_cntl_phys;
> +
> +	/* virtual addresses of vIOMMU VF/VF_CNTL BAR */
> +	u8 __iomem *vf_base;
> +	u8 __iomem *vfctrl_base;
> +
>   	/* pci domain of this IOMMU */
>   	struct amd_iommu_pci_seg *pci_seg;
>   
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index f08ab9ef23a9..d0c4fdd00809 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -10,6 +10,8 @@
>   
>   int amd_viommu_init(struct amd_iommu *iommu);
>   
> +void __init amd_viommu_uninit(struct amd_iommu *iommu);
> +
>   #else
>   
>   static inline int amd_viommu_init(struct amd_iommu *iommu)
> @@ -17,6 +19,10 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
>   	return -EOPNOTSUPP;
>   }
>   
> +static inline void amd_viommu_uninit(struct amd_iommu *iommu)
> +{
> +}
> +
>   #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>   
>   #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 5ac883429ced..6e69b3dd8b1e 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -459,7 +459,7 @@ static void iommu_disable(struct amd_iommu *iommu)
>    * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
>    * the system has one.
>    */
> -static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>   {
>   	if (!request_mem_region(address, end, "amd_iommu")) {
>   		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
> @@ -471,7 +471,7 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>   	return (u8 __iomem *)ioremap(address, end);
>   }
>   

iommu_map_mmio_space() calls request_mem_region() before ioremap(),
but if ioremap() fails it returns NULL without releasing the region
it just reserved. Please make iommu_map_mmio_space() release the
region on ioremap() failure


> -static void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
> +void __init iommu_unmap_mmio_space(struct amd_iommu *iommu)
>   {
>   	if (iommu->mmio_base)
>   		iounmap(iommu->mmio_base);
> @@ -1790,6 +1790,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
>   	free_iommu_buffers(iommu);
>   	amd_iommu_free_ppr_log(iommu);
>   	free_ga_log(iommu);
> +	amd_viommu_uninit(iommu);
>   	iommu_unmap_mmio_space(iommu);
>   	amd_iommu_iopf_uninit(iommu);
>   }
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index f4b5f96d4785..014ae16bf58b 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -7,9 +7,15 @@
>   #define dev_fmt(fmt)    pr_fmt(fmt)
>   
>   #include <linux/iommu.h>
> +#include <linux/amd-iommu.h>
> +
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/ioctl.h>
>   #include <linux/iommufd.h>
>   #include <linux/amd-iommu.h>
>   #include <uapi/linux/iommufd.h>
> +#include <linux/mem_encrypt.h>
>   
>   #include <asm/iommu.h>
>   #include <asm/set_memory.h>
> @@ -18,12 +24,130 @@
>   #include "amd_iommu.h"
>   #include "amd_iommu_types.h"
>   #include "amd_viommu.h"
> +#include "../iommu-pages.h"
> +
> +LIST_HEAD(viommu_devid_map);
> +
> +static int viommu_init_pci_vsc(struct amd_iommu *iommu)
> +{
> +	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
> +	if (!iommu->vsc_offset)
> +		return -ENODEV;
> +
> +	DUMP_printk("device:%s, vsc offset:%04x\n",
> +		    pci_name(iommu->dev), iommu->vsc_offset);
> +	return 0;
> +}
> +
> +static void amd_viommu_gid_ida_init(struct amd_iommu *iommu)
> +{
> +	ida_init(&iommu->gid_ida);
> +	iommu->gid_ida_inited = true;
> +}
> +
> +static void amd_viommu_gid_ida_fini(struct amd_iommu *iommu)
> +{
> +	if (!iommu->gid_ida_inited)
> +		return;
> +
> +	ida_destroy(&iommu->gid_ida);
> +	iommu->gid_ida_inited = false;
> +}
> +
> +static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
> +{
> +	if (iommu->vfctrl_base) {
> +		iounmap(iommu->vfctrl_base);
> +		iommu->vfctrl_base = NULL;
> +	}
> +	if (iommu->vf_cntl_phys)
> +		release_mem_region(iommu->vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
> +
> +	if (iommu->vf_base) {
> +		iounmap(iommu->vf_base);
> +		iommu->vf_base = NULL;
> +	}
> +	if (iommu->vf_base_phys)
> +		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
> +}
> +
> +void __init amd_viommu_uninit(struct amd_iommu *iommu)
> +{
> +	amd_viommu_gid_ida_fini(iommu);
> +	amd_viommu_vf_vfcntl_unmap(iommu);
> +}
> +
> +static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
> +{
> +	u32 lo, hi;
> +	u64 vf_phys, vf_cntl_phys;
> +
> +	/* Setting up VF and VF_CNTL MMIOs */
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
> +	vf_phys = hi;
> +	vf_phys = (vf_phys << 32) | lo;
> +	if (!(vf_phys & 1)) {
> +		pr_err(FW_BUG "vf_phys disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
> +	vf_cntl_phys = hi;
> +	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
> +	if (!(vf_cntl_phys & 1)) {
> +		pr_err(FW_BUG "vf_cntl_phys disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!vf_phys || !vf_cntl_phys) {
> +		pr_err(FW_BUG "AMD-Vi: Unassigned VF resources.\n");
> +		return -ENOMEM;
> +	}
> +
> +	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
> +	vf_phys &= ~1ULL;
> +	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
> +	if (!iommu->vf_base) {
> +		pr_err("Can't reserve vf_base\n");
> +		return -ENOMEM;
> +	}
> +	iommu->vf_base_phys = vf_phys;
> +
> +	vf_cntl_phys &= ~1ULL;
> +	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
> +	if (!iommu->vfctrl_base) {
> +		pr_err("Can't reserve vfctrl_base\n");
> +		goto err_out;
> +	}
> +	iommu->vf_cntl_phys = vf_cntl_phys;
> +
> +	pr_debug("%s: IOMMU device:%s, vf_base:%#llx, vfctrl_base:%#llx\n",
> +		 __func__, pci_name(iommu->dev), vf_phys, vf_cntl_phys);
> +	return 0;
> +err_out:
> +	amd_viommu_uninit(iommu);
> +	return -ENOMEM;
> +}
>   
>   int __init amd_viommu_init(struct amd_iommu *iommu)
>   {
> +	int ret;
> +
>   	if (!amd_iommu_viommu ||
>   	    !check_feature(FEATURE_VIOMMU))
>   		return 0;
>   
> +	ret = viommu_init_pci_vsc(iommu);
> +	if (ret)
> +		return ret;
> +
> +	ret = viommu_vf_vfcntl_init(iommu);
> +	if (ret)
> +		return ret;
> +
> +	amd_viommu_gid_ida_init(iommu);
> +
>   	return 0;
>   }
