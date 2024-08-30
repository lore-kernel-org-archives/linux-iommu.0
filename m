Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722A61B4C51
	for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725030784; cv=none; b=KrAgjpDcnaSV7uAFhvGHHRj/dUm2/okm7cBfV9MR7ZScnmldgvGdkqKl9R4rYWr3olf2nXDWP/oPeFViXL3CSEhjbZnD3U5RQW0yPoAeb4omvMZZYFaB+EFIe6ZHAB4hkHHge14AW29eHkzVqO+LnwaIxyYegG9srJ1GsRs352Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725030784; c=relaxed/simple;
	bh=I3bXtBmIy7/eeL/DbG2/D8ucFXFFUY9KAXD5JCu9l4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcjWayVzLpkZmd4S0NMOvCwuVFKUplnz6eVnNJFte2U/Y9VDv75zbXiJyiqQDmloPUHJQ2LcpwK97jNvx/lygVPqb1BV0p1SjXV70epwUh5a7EGbVFKQQZ9/Scms+SfgRWUFnSC86xb15a5Jd8k6qahmYDjCGE6snRLcj2S/lcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fs8sgHHQ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fs8sgHHQ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-427fc9834deso66395e9.0
        for <iommu@lists.linux.dev>; Fri, 30 Aug 2024 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725030781; x=1725635581; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1lcEa/62Kw1i52AmJldPMDz8bUHwIexwRpxBM5juH+M=;
        b=Fs8sgHHQAYv5xrjtDPjT/zoxbDc0F1S4GYUDt1ZfmtNOUu/U/zHxRYSH0nLAUpFGK+
         zoJ3UMEielqa761Ay+7SoXGJhjJIBxYFAQhuGx9dYs5TgHOOT+/Hey5yYJE3MrgH+Rk3
         qYt3P3U/UU/3maodtfEbx0L/vrR+sTN6/hTM9P4ysVTqu7MYTPzqU+2UNtIs3gk6yyJx
         mJqfDw+0FZ3g5cByYEXD8PlhuhQAKpP+SUQJhbahSg+C+HlaZecVu4yjABZ6E1s3pA2T
         S2WPpqCeVMRHgT/lWGUWSgEsxlH8aIkkd1qtE24NFFPcDd3JpJpNXTw/ce4i+ohmDC6G
         DRhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725030781; x=1725635581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1lcEa/62Kw1i52AmJldPMDz8bUHwIexwRpxBM5juH+M=;
        b=K4Vw215aljb9BunLjZFe2x6O+xO94FX5VV2gN582XxX0wX5Fb9AoB6bRb1E6gy5u/w
         hbAiTKHpy7EagZPCK0Vd/Oz57gXro7xvkp5531l9ZTN3YRxz09bqveItXjF3f2QCGwNe
         0vX3QD1F42vmOLupxncaLUJZX/FE162h0MJj6oYWIICR27Rf7jfA0ili5eUE9vUnLFKi
         F00IPw3STGItB+U9vIV0R/eStismOV6Lul+MFN93NNAy5MjKff893h3ZGySlhy9Ovi8s
         O9ZWZ0IhgUQg0afv3f4trp2UQNyWUp567FD9auhmde4GZw5iBvlcu2PlVUPAGn56JjxY
         uWGA==
X-Forwarded-Encrypted: i=1; AJvYcCUwu8VDgINObmjdy079VjDKaLsevue5FhpFvxYCqcW8fRa3Tby4JeZmTDgyjHtqoMTOleQ4Yg==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywvvtkp4QBWZXBsE0iNyaDQuUuLT84JWlBCGw4AqdTHq0iB77F8
	SFzx02zx93dSqqy+Hk+lKqiD5Xqwu+nT4AGnWXS1mChDx8Z/frtBIw3RoElnxA==
X-Google-Smtp-Source: AGHT+IHJbpPb4O4ffx3y2dEx6iavJsP2XZWrsa1LBOsEBLDV+AOfU73CkPAUYNiw0y7TKMOOnSZsvw==
X-Received: by 2002:a05:600c:b91:b0:42b:a961:e51 with SMTP id 5b1f17b1804b1-42bba7e3e4emr1459045e9.0.1725030779120;
        Fri, 30 Aug 2024 08:12:59 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b67ff88dsm1224828f8f.26.2024.08.30.08.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 08:12:58 -0700 (PDT)
Date: Fri, 30 Aug 2024 15:12:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v2 2/8] iommu/arm-smmu-v3: Use S2FWB when available
Message-ID: <ZtHhdj6RAKACBCUG@google.com>
References: <0-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
 <2-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2-v2-621370057090+91fec-smmuv3_nesting_jgg@nvidia.com>

Hi Jason,

Sorry, I haven’t followed up on that, I was out for a while.

On Tue, Aug 27, 2024 at 12:51:32PM -0300, Jason Gunthorpe wrote:
> Force Write Back (FWB) changes how the S2 IOPTE's MemAttr field
> works. When S2FWB is supported and enabled the IOPTE will force cachable
> access to IOMMU_CACHE memory when nesting with a S1 and deny cachable
> access otherwise.
> 
> When using a single stage of translation, a simple S2 domain, it doesn't
> change anything as it is just a different encoding for the exsting mapping
> of the IOMMU protection flags to cachability attributes.
> 
> However, when used with a nested S1, FWB has the effect of preventing the
> guest from choosing a MemAttr in it's S1 that would cause ordinary DMA to
> bypass the cache. Consistent with KVM we wish to deny the guest the
> ability to become incoherent with cached memory the hypervisor believes is
> cachable so we don't have to flush it.
> 
> Turn on S2FWB whenever the SMMU supports it and use it for all S2
> mappings.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 11 +++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  3 +++
>  drivers/iommu/io-pgtable-arm.c              | 27 +++++++++++++++++----
>  include/linux/io-pgtable.h                  |  2 ++
>  4 files changed, 38 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 531125f231b662..e2b97ad6d74b03 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1612,6 +1612,8 @@ void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  		FIELD_PREP(STRTAB_STE_1_EATS,
>  			   ats_enabled ? STRTAB_STE_1_EATS_TRANS : 0));
>  
> +	if (smmu->features & ARM_SMMU_FEAT_S2FWB)
> +		target->data[1] |= cpu_to_le64(STRTAB_STE_1_S2FWB);
>  	if (smmu->features & ARM_SMMU_FEAT_ATTR_TYPES_OVR)
>  		target->data[1] |= cpu_to_le64(FIELD_PREP(STRTAB_STE_1_SHCFG,
>  							  STRTAB_STE_1_SHCFG_INCOMING));
> @@ -2400,6 +2402,8 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  		pgtbl_cfg.oas = smmu->oas;
>  		fmt = ARM_64_LPAE_S2;
>  		finalise_stage_fn = arm_smmu_domain_finalise_s2;
> +		if (smmu->features & ARM_SMMU_FEAT_S2FWB)
> +			pgtbl_cfg.quirks |= IO_PGTABLE_QUIRK_ARM_S2FWB;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -4189,6 +4193,13 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
>  
>  	/* IDR3 */
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR3);
> +	/*
> +	 * If for some reason the HW does not support DMA coherency then using
> +	 * S2FWB won't work. This will also disable nesting support.
> +	 */
> +	if (FIELD_GET(IDR3_FWB, reg) &&
> +	    (smmu->features & ARM_SMMU_FEAT_COHERENCY))
> +		smmu->features |= ARM_SMMU_FEAT_S2FWB;
I think that’s for the SMMU coherency which in theory is not related to the
master which FWB overrides, so this check is not correct.

What I meant in the previous thread that we should set FWB only for coherent
masters as (in attach s2):
	if (smmu->features & ARM_SMMU_FEAT_S2FWB && dev_is_dma_coherent(master->dev)
		// set S2FWB in STE

Thanks,
Mostafa
>  	if (FIELD_GET(IDR3_RIL, reg))
>  		smmu->features |= ARM_SMMU_FEAT_RANGE_INV;
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 8851a7abb5f0f3..7e8d2f36faebf3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -55,6 +55,7 @@
>  #define IDR1_SIDSIZE			GENMASK(5, 0)
>  
>  #define ARM_SMMU_IDR3			0xc
> +#define IDR3_FWB			(1 << 8)
>  #define IDR3_RIL			(1 << 10)
>  
>  #define ARM_SMMU_IDR5			0x14
> @@ -258,6 +259,7 @@ static inline u32 arm_smmu_strtab_l2_idx(u32 sid)
>  #define STRTAB_STE_1_S1CSH		GENMASK_ULL(7, 6)
>  
>  #define STRTAB_STE_1_S1STALLD		(1UL << 27)
> +#define STRTAB_STE_1_S2FWB		(1UL << 25)
>  
>  #define STRTAB_STE_1_EATS		GENMASK_ULL(29, 28)
>  #define STRTAB_STE_1_EATS_ABT		0UL
> @@ -700,6 +702,7 @@ struct arm_smmu_device {
>  #define ARM_SMMU_FEAT_ATTR_TYPES_OVR	(1 << 20)
>  #define ARM_SMMU_FEAT_HA		(1 << 21)
>  #define ARM_SMMU_FEAT_HD		(1 << 22)
> +#define ARM_SMMU_FEAT_S2FWB		(1 << 23)
>  	u32				features;
>  
>  #define ARM_SMMU_OPT_SKIP_PREFETCH	(1 << 0)
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index f5d9fd1f45bf49..9b3658aae21005 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -106,6 +106,18 @@
>  #define ARM_LPAE_PTE_HAP_FAULT		(((arm_lpae_iopte)0) << 6)
>  #define ARM_LPAE_PTE_HAP_READ		(((arm_lpae_iopte)1) << 6)
>  #define ARM_LPAE_PTE_HAP_WRITE		(((arm_lpae_iopte)2) << 6)
> +/*
> + * For !FWB these code to:
> + *  1111 = Normal outer write back cachable / Inner Write Back Cachable
> + *         Permit S1 to override
> + *  0101 = Normal Non-cachable / Inner Non-cachable
> + *  0001 = Device / Device-nGnRE
> + * For S2FWB these code:
> + *  0110 Force Normal Write Back
> + *  0101 Normal* is forced Normal-NC, Device unchanged
> + *  0001 Force Device-nGnRE
> + */
> +#define ARM_LPAE_PTE_MEMATTR_FWB_WB	(((arm_lpae_iopte)0x6) << 2)
>  #define ARM_LPAE_PTE_MEMATTR_OIWB	(((arm_lpae_iopte)0xf) << 2)
>  #define ARM_LPAE_PTE_MEMATTR_NC		(((arm_lpae_iopte)0x5) << 2)
>  #define ARM_LPAE_PTE_MEMATTR_DEV	(((arm_lpae_iopte)0x1) << 2)
> @@ -458,12 +470,16 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  	 */
>  	if (data->iop.fmt == ARM_64_LPAE_S2 ||
>  	    data->iop.fmt == ARM_32_LPAE_S2) {
> -		if (prot & IOMMU_MMIO)
> +		if (prot & IOMMU_MMIO) {
>  			pte |= ARM_LPAE_PTE_MEMATTR_DEV;
> -		else if (prot & IOMMU_CACHE)
> -			pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
> -		else
> +		} else if (prot & IOMMU_CACHE) {
> +			if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_S2FWB)
> +				pte |= ARM_LPAE_PTE_MEMATTR_FWB_WB;
> +			else
> +				pte |= ARM_LPAE_PTE_MEMATTR_OIWB;
> +		} else {
>  			pte |= ARM_LPAE_PTE_MEMATTR_NC;
> +		}
>  	} else {
>  		if (prot & IOMMU_MMIO)
>  			pte |= (ARM_LPAE_MAIR_ATTR_IDX_DEV
> @@ -932,7 +948,8 @@ arm_64_lpae_alloc_pgtable_s1(struct io_pgtable_cfg *cfg, void *cookie)
>  	if (cfg->quirks & ~(IO_PGTABLE_QUIRK_ARM_NS |
>  			    IO_PGTABLE_QUIRK_ARM_TTBR1 |
>  			    IO_PGTABLE_QUIRK_ARM_OUTER_WBWA |
> -			    IO_PGTABLE_QUIRK_ARM_HD))
> +			    IO_PGTABLE_QUIRK_ARM_HD |
> +			    IO_PGTABLE_QUIRK_ARM_S2FWB))
>  		return NULL;
>  
>  	data = arm_lpae_alloc_pgtable(cfg);
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index f9a81761bfceda..aff9b020b6dcc7 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -87,6 +87,7 @@ struct io_pgtable_cfg {
>  	 *	attributes set in the TCR for a non-coherent page-table walker.
>  	 *
>  	 * IO_PGTABLE_QUIRK_ARM_HD: Enables dirty tracking in stage 1 pagetable.
> +	 * IO_PGTABLE_QUIRK_ARM_S2FWB: Use the FWB format for the MemAttrs bits
>  	 */
>  	#define IO_PGTABLE_QUIRK_ARM_NS			BIT(0)
>  	#define IO_PGTABLE_QUIRK_NO_PERMS		BIT(1)
> @@ -95,6 +96,7 @@ struct io_pgtable_cfg {
>  	#define IO_PGTABLE_QUIRK_ARM_TTBR1		BIT(5)
>  	#define IO_PGTABLE_QUIRK_ARM_OUTER_WBWA		BIT(6)
>  	#define IO_PGTABLE_QUIRK_ARM_HD			BIT(7)
> +	#define IO_PGTABLE_QUIRK_ARM_S2FWB		BIT(8)
>  	unsigned long			quirks;
>  	unsigned long			pgsize_bitmap;
>  	unsigned int			ias;
> -- 
> 2.46.0
> 
