Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111A11D5151
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770640302; cv=none; b=ICL9giRHnrW3V1isIILoZEloPoJQAns7gR2ay7g5UhTP/DFjkchAxYwwNYo4ARrZI5VcBSeFozSYgzTaam9aHsVXmfxmTZaizrOkoRpHtKF8A2Zj2HFAfjuaIMaZx0E/UhFhYBSeIqV0QKucISBN0mYUSJenMCiMNIkQDEyfaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770640302; c=relaxed/simple;
	bh=Q1uDJhMkSMLDbnPCEIALwsIuWxwqSIcuW/1uYWKzPmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hRBv0qvVMghA661lO9wSuqI84/Fw1dKJR6wreVFg2UNQ0wrlP/M9+3h3e0zl6yrgoshLqvJoHE19SJmirSDZHrvpmynG2Gyb6YP8O8b8WpI4aDdRwuhzng0GjztP50cSjpyL4jSt8Ll+7qyo/lgTRZ6EvOqIi+1cDfSkz32R1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C6F9339;
	Mon,  9 Feb 2026 04:31:35 -0800 (PST)
Received: from [10.57.52.189] (unknown [10.57.52.189])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CFAB33F63F;
	Mon,  9 Feb 2026 04:31:38 -0800 (PST)
Message-ID: <0af5b5f3-912a-4f16-a68b-032617576537@arm.com>
Date: Mon, 9 Feb 2026 12:31:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] iommu/io-pgtable: Add support for Arm Mali v10+ GPUs
 page table format
To: Liviu Dudau <liviu.dudau@arm.com>, Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Karunika Choo <karunika.choo@arm.com>, Liviu Dudau <liviu@dudau.co.uk>
References: <20260209112542.194140-1-liviu.dudau@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260209112542.194140-1-liviu.dudau@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/02/2026 11:25, Liviu Dudau wrote:
> From: Liviu Dudau <liviu@dudau.co.uk>
> 
> The Arm Mali v10+ GPU drivers have been (ab)using the ARM_64_LPAE_S1
> format as they are mostly compatible with it and some of the gaps
> left in the code to allow for ARM_MALI_LPAE format (pre-v10 GPUs)
> is helping to paper over differences. In preparation for adding support
> for changes introduced in v15 GPUs, add a format specific for modern
> Mali GPUs.
> 
> Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>
> ---
> 
> This patch is trying to gauge interest in adding proper support for Arm Mali
> CSF GPUs via the simple approach of extending the generic Arm page table code
> to add support for the PTE format of the GPUs. In order to test the changes
> I've decided to add the phba bits to the arm_lpae_s1_cfg struct to validate
> the allocation and setup of the page table entries, but in the end I'm
> targetting the specific arm_mali_csf_cfg structure that will support
> the GPUs PTEs.

Other than the addition of the PBHA bits (which are part of the VMSAv8
page table format anyway) what are we expecting to be different between
the Mali format and the CPU architectural format?

For Midgard GPUs the page table format was "inspired" by LPAE but was
explicitly different in some cases - so a new format was required. But I
can't actually spot any differences in the GPU format to what VMSAv8-64
describes (albeit the GPU format is less flexible than all the options
the CPU format describes).

I can see why we might want more functionality (e.g. PBHA): I'm just not
sure what the reason for having another special Mali format is - why
can't this be in the generic code?

> 
> I'm interested to learn if this approach is considered sane and what I need to
> pay attention to when adding a new struct to the io_pgtable_cfg union. The patch
> is intentionally not complete with all the changes that switching to the new
> struct will entail as I didn't wanted to be dragged into a full code review, but
> I can add them if wanted.
> 
> 
> Best regards,
> Liviu
> 
> ---
>  drivers/iommu/io-pgtable-arm.c | 161 ++++++++++++++++++++++++++++++++-
>  drivers/iommu/io-pgtable.c     |   1 +
>  include/linux/io-pgtable.h     |  18 ++++
>  3 files changed, 179 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 05d63fe92e436..48aea598ab0c9 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -482,6 +482,7 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  	arm_lpae_iopte pte;
>  
>  	if (data->iop.fmt == ARM_64_LPAE_S1 ||
> +	    data->iop.fmt == ARM_MALI_CSF ||
>  	    data->iop.fmt == ARM_32_LPAE_S1) {
>  		pte = ARM_LPAE_PTE_nG;
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
> @@ -569,6 +570,8 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  		return -EINVAL;
>  
>  	prot = arm_lpae_prot_to_pte(data, iommu_prot);
> +	if (data->iop.fmt == ARM_MALI_CSF)
> +		prot |= cfg->arm_lpae_s1_cfg.pbha;
>  	ret = __arm_lpae_map(data, iova, paddr, pgsize, pgcount, prot, lvl,
>  			     ptep, gfp, mapped);
>  	/*
> @@ -864,7 +867,8 @@ static int arm_lpae_read_and_clear_dirty(struct io_pgtable_ops *ops,
>  		return -EINVAL;
>  	if (WARN_ON((iova + size - 1) & ~(BIT(cfg->ias) - 1)))
>  		return -EINVAL;
> -	if (data->iop.fmt != ARM_64_LPAE_S1)
> +	if (data->iop.fmt != ARM_64_LPAE_S1 ||
> +	    data->iop.fmt != ARM_MALI_CSF)
>  		return -EINVAL;
>  
>  	return __arm_lpae_iopte_walk(data, &walk_data, ptep, lvl);
> @@ -1236,6 +1240,155 @@ arm_mali_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
>  	return NULL;
>  }
>  
> +static struct io_pgtable *
> +arm_mali_csf_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> +{
> +	unsigned int max_addr_bits = 48;
> +	unsigned long granule, page_sizes;
> +	struct arm_lpae_io_pgtable *data;
> +	typeof(&cfg->arm_lpae_s1_cfg.tcr) tcr = &cfg->arm_lpae_s1_cfg.tcr;
> +	int levels, va_bits, pg_shift;
> +	u64 reg;
> +
> +	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_TTBR1 |
> +			    IO_PGTABLE_QUIRK_NO_WARN))
> +		return NULL;
> +
> +	if (!(cfg->pgsize_bitmap & (SZ_4K | SZ_16K)))
> +		return NULL;

This check should be moved down...

> +
> +	if (cfg->pgsize_bitmap & PAGE_SIZE)
> +		granule = PAGE_SIZE;
> +	else if (cfg->pgsize_bitmap & ~PAGE_MASK)
> +		granule = 1UL << __fls(cfg->pgsize_bitmap & ~PAGE_MASK);
> +	else if (cfg->pgsize_bitmap & PAGE_MASK)
> +		granule = 1UL << __ffs(cfg->pgsize_bitmap & PAGE_MASK);
> +	else
> +		granule = 0;
> +
> +	switch (granule) {
> +	case SZ_4K:
> +		page_sizes = (SZ_4K | SZ_2M | SZ_1G);
> +		break;
> +	case SZ_16K:
> +		page_sizes = (SZ_16K | SZ_32M | SZ_64G);
> +		break;
> +	default:
> +		page_sizes = 0;
> +	}
> +
> +	cfg->pgsize_bitmap &= page_sizes;

... to after this line. Otherwise we can end up with cfg->pgsize_bitmap
being zero and the function succeeding.

Generally this is mostly just a copy of arm_lpae_alloc_pgtable() (with
arm_lpae_restrict_pgsizes() inlined) - but with added bugs. Which is why
I'm wary of adding another Mali-special unless there's good reason. It
still refers to a whole bunch of _LPAE_ defines/functions - which means
any refactor to LPAE would have to fix up this code too.

Thanks,
Steve

> +	cfg->ias = min(cfg->ias, max_addr_bits);
> +	cfg->oas = min(cfg->oas, max_addr_bits);
> +
> +	data = kmalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return NULL;
> +
> +	pg_shift = __ffs(cfg->pgsize_bitmap);
> +	data->bits_per_level = pg_shift - ilog2(sizeof(arm_lpae_iopte));
> +
> +	va_bits = cfg->ias - pg_shift;
> +	levels = DIV_ROUND_UP(va_bits, data->bits_per_level);
> +	data->start_level = ARM_LPAE_MAX_LEVELS - levels;
> +
> +	/* Calculate the actual size of our pgd (without concatenation) */
> +	data->pgd_bits = va_bits - (data->bits_per_level * (levels - 1));
> +
> +	data->iop.ops = (struct io_pgtable_ops) {
> +		.map_pages	= arm_lpae_map_pages,
> +		.unmap_pages	= arm_lpae_unmap_pages,
> +		.iova_to_phys	= arm_lpae_iova_to_phys,
> +		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
> +		.pgtable_walk	= arm_lpae_pgtable_walk,
> +	};
> +
> +	/* TCR */
> +	if (cfg->coherent_walk) {
> +		tcr->sh = ARM_LPAE_TCR_SH_IS;
> +		tcr->irgn = ARM_LPAE_TCR_RGN_WBWA;
> +		tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
> +		if (cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA)
> +			goto out_free_data;
> +	} else {
> +		tcr->sh = ARM_LPAE_TCR_SH_OS;
> +		tcr->irgn = ARM_LPAE_TCR_RGN_NC;
> +		if (!(cfg->quirks & IO_PGTABLE_QUIRK_ARM_OUTER_WBWA))
> +			tcr->orgn = ARM_LPAE_TCR_RGN_NC;
> +		else
> +			tcr->orgn = ARM_LPAE_TCR_RGN_WBWA;
> +	}
> +
> +	switch (ARM_LPAE_GRANULE(data)) {
> +	case SZ_4K:
> +		tcr->tg = ARM_LPAE_TCR_TG0_4K;
> +		break;
> +	case SZ_16K:
> +		tcr->tg = ARM_LPAE_TCR_TG0_16K;
> +		break;
> +	case SZ_64K:
> +		tcr->tg = ARM_LPAE_TCR_TG0_64K;
> +		break;
> +	}
> +
> +	switch (cfg->oas) {
> +	case 32:
> +		tcr->ips = ARM_LPAE_TCR_PS_32_BIT;
> +		break;
> +	case 36:
> +		tcr->ips = ARM_LPAE_TCR_PS_36_BIT;
> +		break;
> +	case 40:
> +		tcr->ips = ARM_LPAE_TCR_PS_40_BIT;
> +		break;
> +	case 42:
> +		tcr->ips = ARM_LPAE_TCR_PS_42_BIT;
> +		break;
> +	case 44:
> +		tcr->ips = ARM_LPAE_TCR_PS_44_BIT;
> +		break;
> +	case 48:
> +		tcr->ips = ARM_LPAE_TCR_PS_48_BIT;
> +		break;
> +	case 52:
> +		tcr->ips = ARM_LPAE_TCR_PS_52_BIT;
> +		break;
> +	default:
> +		goto out_free_data;
> +	}
> +
> +	tcr->tsz = 64ULL - cfg->ias;
> +
> +	/* MAIRs */
> +	reg = (ARM_LPAE_MAIR_ATTR_NC
> +	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_NC)) |
> +	      (ARM_LPAE_MAIR_ATTR_WBRWA
> +	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_CACHE)) |
> +	      (ARM_LPAE_MAIR_ATTR_DEVICE
> +	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_DEV)) |
> +	      (ARM_LPAE_MAIR_ATTR_INC_OWBRWA
> +	       << ARM_LPAE_MAIR_ATTR_SHIFT(ARM_LPAE_MAIR_ATTR_IDX_INC_OCACHE));
> +
> +	cfg->arm_lpae_s1_cfg.mair = reg;
> +
> +	/* Looking good; allocate a pgd */
> +	data->pgd = __arm_lpae_alloc_pages(ARM_LPAE_PGD_SIZE(data),
> +					   GFP_KERNEL, cfg, cookie);
> +	if (!data->pgd)
> +		goto out_free_data;
> +
> +	/* Ensure the empty pgd is visible before any actual TTBR write */
> +	wmb();
> +
> +	/* TTBR */
> +	cfg->arm_lpae_s1_cfg.ttbr = virt_to_phys(data->pgd);
> +	return &data->iop;
> +
> +out_free_data:
> +	kfree(data);
> +	return NULL;
> +}
> +
>  struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns = {
>  	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
>  	.alloc	= arm_64_lpae_alloc_pgtable_s1,
> @@ -1265,3 +1418,9 @@ struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns = {
>  	.alloc	= arm_mali_lpae_alloc_pgtable,
>  	.free	= arm_lpae_free_pgtable,
>  };
> +
> +struct io_pgtable_init_fns io_pgtable_arm_mali_csf_init_fns = {
> +	.caps	= IO_PGTABLE_CAP_CUSTOM_ALLOCATOR,
> +	.alloc	= arm_mali_csf_alloc_pgtable,
> +	.free	= arm_lpae_free_pgtable,
> +};
> diff --git a/drivers/iommu/io-pgtable.c b/drivers/iommu/io-pgtable.c
> index 843fec8e8a511..1f43f898a8121 100644
> --- a/drivers/iommu/io-pgtable.c
> +++ b/drivers/iommu/io-pgtable.c
> @@ -20,6 +20,7 @@ io_pgtable_init_table[IO_PGTABLE_NUM_FMTS] = {
>  	[ARM_64_LPAE_S1] = &io_pgtable_arm_64_lpae_s1_init_fns,
>  	[ARM_64_LPAE_S2] = &io_pgtable_arm_64_lpae_s2_init_fns,
>  	[ARM_MALI_LPAE] = &io_pgtable_arm_mali_lpae_init_fns,
> +	[ARM_MALI_CSF] = &io_pgtable_arm_mali_csf_init_fns,
>  #endif
>  #ifdef CONFIG_IOMMU_IO_PGTABLE_DART
>  	[APPLE_DART] = &io_pgtable_apple_dart_init_fns,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 7a1516011ccf7..fc9776f71a963 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -17,6 +17,7 @@ enum io_pgtable_fmt {
>  	ARM_MALI_LPAE,
>  	APPLE_DART,
>  	APPLE_DART2,
> +	ARM_MALI_CSF,
>  	IO_PGTABLE_NUM_FMTS,
>  };
>  
> @@ -148,6 +149,8 @@ struct io_pgtable_cfg {
>  				u32	tsz:6;
>  			}	tcr;
>  			u64	mair;
> +			/* ToDo: remove this when switching to arm_mali_csf_cfg struct */
> +			u64	pbha;
>  		} arm_lpae_s1_cfg;
>  
>  		struct {
> @@ -175,6 +178,20 @@ struct io_pgtable_cfg {
>  			u64	memattr;
>  		} arm_mali_lpae_cfg;
>  
> +		/* ToDo: switch to this structure for Mali CSF GPUs
> +		  struct {
> +			u64	transtab;
> +			struct {
> +				u32	pbha:4;
> +				u32	ra:1;
> +				u32	sh:2;
> +				u32	memattr:2;
> +				u32	mode:4;
> +			} transcfg;
> +			u64 memattr;
> +		} arm_mali_csf_cfg;
> +		*/
> +
>  		struct {
>  			u64 ttbr[4];
>  			u32 n_ttbrs;
> @@ -320,6 +337,7 @@ extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s1_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_64_lpae_s2_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_arm_mali_lpae_init_fns;
> +extern struct io_pgtable_init_fns io_pgtable_arm_mali_csf_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v1_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_amd_iommu_v2_init_fns;
>  extern struct io_pgtable_init_fns io_pgtable_apple_dart_init_fns;

