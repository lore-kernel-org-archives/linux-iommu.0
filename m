Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E8A3F9264
	for <iommu@lists.linux.dev>; Tue, 22 Sep 2026 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059430; cv=none; b=sWkWmnVlb9+Ida/WKHH5gEI973SwSiSGgtjBvfPl08Q4OqxOWYv/+LhX2TUerO2sWIC68dNCheVcDcebVBnwJANmHm/xqiFBUATTNlXn983ICmOIXMa3kWxBqQd63G8IocVGcVDyV40rJC7P7QPby2ovnKSy4nRKtEcCQAZziZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059430; c=relaxed/simple;
	bh=q1TgAWjibTqSBeYwEYXsp/b3BYg5hbApnEz+oNjfx28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlV7JvY1fogCK8J+NTGFvBlthgsewa1paQQivo/veGcgWcwM273g4/Wb/l5NuBcOpOKl0CUSuUp2L+FoER3Ih8Yaim6NYWhyDekYWmMd26PgwUmeLyB0J0Ntn5oS2k0IhBWeXCDNz9oxOiOQc9884jm7VVmfAbf/PBLSiQJ5aD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ZGRIKMMi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ZGRIKMMi"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1790059424; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=VOuZemme5OU25g/hHlJFZJ/purnJcIscVGxnPZZMHno=;
	b=ZGRIKMMiknPSwrCOjHRlGO6rf8Y1xMmq1MVCXjl1kJqhaK1vYHCWliIHXmf1wKH520JztxK5LpD+2ocheXs48skpM8l9n2QQto+IQGIGT6qLhf1E6JiWvyjFpWefFaLu/0DVlhgrpTnPIPD3X4Sk3LRSlfKhEQR9yIaapROUDJ4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=23;SR=0;TI=SMTPD_---0XBSzHsK_1790059421;
Received: from 30.178.81.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XBSzHsK_1790059421 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Sep 2026 14:43:43 +0800
Message-ID: <e0ceffa9-4c75-459d-9298-dd1663d88fbe@linux.alibaba.com>
Date: Tue, 22 Sep 2026 14:43:40 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO
 BARs
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-7-suravee.suthikulpanit@amd.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <20260914184750.222939-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



在 2026/9/15 02:47, Suravee Suthikulpanit 写道:
> Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
> capability (VSC), reading the VF and VF Control BAR addresses, and
> mapping them for host access (256MB VF, 4MB VF Control).
>
> VF Control covers the first 4K of guest IOMMU MMIO (control registers,
> trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
> IOMMU). Per-guest bases use the Guest ID from the previous patch.
>
> Reject a VSC VF or VF Control BAR that is disabled or decodes to
> physical address zero before mapping MMIO.
>
> Set AMD_IOMMU_FLAG_VIOMMU_EN after the VF BARs are mapped. Export
> MMIO map helpers. Call amd_viommu_uninit() from IOMMU teardown
> before free_iommu_buffers() so MMIO and the command buffer remain.
>
> Release the reserved MMIO region if ioremap() fails so VF/VFCTRL map
> errors do not leak request_mem_region() for the life of the machine.
>
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |  2 +
>  drivers/iommu/amd/amd_iommu_types.h | 31 +++++++++
>  drivers/iommu/amd/amd_viommu.h      |  6 ++
>  drivers/iommu/amd/init.c            | 14 ++++-
>  drivers/iommu/amd/viommu.c          | 98 +++++++++++++++++++++++++++++
>  5 files changed, 148 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index f6cf412a9820..51e4364e8564 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -28,6 +28,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
>  void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
>  				  gfp_t gfp, size_t size);
> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
> +void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  void amd_iommu_debugfs_setup(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 8c38775ff5c1..c2257d48e222 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -40,6 +40,12 @@
>  #define MMIO_RANGE_OFFSET	0x0c
>  #define MMIO_MISC_OFFSET	0x10
>  
> +/* vIOMMU Capability offsets (from IOMMU Capability Header) */
> +#define MMIO_VSC_VF_BAR_LO_OFFSET	0x08
> +#define MMIO_VSC_VF_BAR_HI_OFFSET	0x0c
> +#define MMIO_VSC_VF_CNTL_BAR_LO_OFFSET	0x10
> +#define MMIO_VSC_VF_CNTL_BAR_HI_OFFSET	0x14
> +
>  /* Used offsets into the MMIO space */
>  #define MMIO_DEV_TABLE_OFFSET   0x0000
>  #define MMIO_CMD_BUF_OFFSET     0x0008
> @@ -464,6 +470,20 @@ extern bool amdr_ivrs_remap_support;
>  #define for_each_ivhd_dte_flags(entry) \
>  	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
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
>  struct amd_iommu;
>  struct iommu_domain;
>  struct irq_domain;
> @@ -678,6 +698,17 @@ struct amd_iommu {
>  	 */
>  	u16 cap_ptr;
>  
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
>  	/* pci domain of this IOMMU */
>  	struct amd_iommu_pci_seg *pci_seg;
>  
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index 864e7b283cff..e5fbea666e01 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -12,6 +12,8 @@ struct amd_iommu;
>  
>  int amd_viommu_init(struct amd_iommu *iommu);
>  
> +void __init amd_viommu_uninit(struct amd_iommu *iommu);
> +
>  #else
>  
>  /*
> @@ -24,6 +26,10 @@ static inline int amd_viommu_init(struct amd_iommu *iommu)
>  	return 0;
>  }
>  
> +static inline void amd_viommu_uninit(struct amd_iommu *iommu)
> +{
> +}
> +
>  #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
>  
>  #endif /* AMD_VIOMMU_H */
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 7b4cb473019d..79386816807a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -459,8 +459,10 @@ static void iommu_disable(struct amd_iommu *iommu)
>   * mapping and unmapping functions for the IOMMU MMIO space. Each AMD IOMMU in
>   * the system has one.
>   */
> -static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>  {
> +	u8 __iomem *base;
> +
>  	if (!request_mem_region(address, end, "amd_iommu")) {
>  		pr_err("Can not reserve memory region %llx-%llx for mmio\n",
>  			address, end);
> @@ -468,10 +470,14 @@ static u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end)
>  		return NULL;
>  	}
>  
> -	return (u8 __iomem *)ioremap(address, end);
> +	base = ioremap(address, end);
> +	if (!base)
> +		release_mem_region(address, end);
This release is duplicated with following free_iommu_resources() -> free_iommu_all() 
-> free_iommu_one() -> iommu_unmap_mmio_space().

Best Regards,
Guixin Liu

...
