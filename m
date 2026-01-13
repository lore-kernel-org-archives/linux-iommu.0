Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF8935EDC8
	for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768332477; cv=none; b=ReeQQEAmX9myVsvJBXq4TJ/MIn5qQWeE+71b/BDeJnvjlXoVEV9YeK9CvCpqc7/ZiWMTAYAurbKw0ffMQMQTd7THnaRSSlPzY/YtkI5dXBsJouGVbJFe33csVJCPwzmSOUiGBdZb/hibiyFbrV1yAHIKEvQ7rz0o7k/ZQR1JPTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768332477; c=relaxed/simple;
	bh=j3MTvudFYp/Z3BA8v0Nf5anA/VDSXeRdzFYQIHWSPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBbntptN0QaSBRGLoyZP7wZ0udTwSgS6Cjsj3OZrTBtWfwGsiK/xdGwraHr8Ttr6icg48QNvjbaryniPOa9XdvHe2wPd4sxmxazMz/XBQ4uLOe463z//YhoAsRzzmLNPGD8GjjVELVcIWQIDs07HdauDA6YTY5EH1nbaqi483rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fOsPCrJj; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOsPCrJj"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so11373801a12.2
        for <iommu@lists.linux.dev>; Tue, 13 Jan 2026 11:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1768332474; x=1768937274; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LZBaZL2bW3E22EnT/tukcFNcW6Np3cq6LKK5NCta40E=;
        b=fOsPCrJj6S+nzpZaJ1ZUWko/B+7rfL8jRdZQ8HcZMwrBrvFjnznQEIywOCBt3KIxiw
         BtFOhLP5Z+dZ4nzswY0Rp90TiGTddncdVPgh8ASmZ7ekji/vQ44HYbuFGBzUocMynRe3
         XQbo6pwIDjivJw3SIVKONujM8LnR6JdNcTD5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768332474; x=1768937274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZBaZL2bW3E22EnT/tukcFNcW6Np3cq6LKK5NCta40E=;
        b=ffhZ6V6h+u0QY5L9/tiUr/uAUbdyTeC/GpuhMRdQy66SvnvlSusUoymb/4vJrqNiPO
         BGmu6ydklItMGILQRynrjxXEKWAkaVLaVK/3TgdR9d3cyBaQktXmLE32Gp1dpHCvVtfQ
         RCeDCOxWIDkVSKQwGDj12NjtzwbkMFAz30NaiNGg7KS0fYHpjJNuJXnCpAEiwrpQTsor
         22VD+orKQ5beoe30/BKOC7IvaEW3UR8r+7A94smWO4fH/JZLW6wMg+wCQA/m/hdzp+4W
         MopwbRBY38jm+I8rN28P9J2KfPGz0fiTzrKKPEmgiYd6ZXAnbjQt9tmn8xuN5snINFgk
         HwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvvGG2q5V5B0W9iYMbB45Mw2jCF2mYm+YhWiEHv940ZLeNAdr5jSqnFLL801FJWzuYzd1BEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoehSzw7+W+VVo/+P5uET1IQo3SPh/k3iTJ/9QcebKQ7KLgfWw
	actIz9E5kJyBwYVt7innxGbb20MRJ6ZB+kKPNN/xFsH/gbr2NPmFqqzJ6kuVlxSJkQ==
X-Gm-Gg: AY/fxX4Ofg/TKc+ynUMIP9W7pzy2YhkJOw+8ssbhlYB9PWTet4AhBfvByFykPpEA+Ed
	jNSJGvosidKDYCNcyHYsB390CUcBS0T5FopnqqLshohyR2fVVIR529ii7fjXEF2O91f414HyUrf
	1i25rG1Ja/fZuOnW32S/scpqDyyi+pnmT9pAxrgNTdlwvVIbK1BS2F9ust6tWaXflqthqcqH0JE
	AB6xgeX2V6FqZjZLS9hfBgtJBQBR8dN/Nv0a3D316W14+ekMJ/B9Er9b5zlTsnwG9+p2PuWFJg+
	3t//zp829JGdjMKG10NyTe3hgsE5w6oc0DLejp5ew3R8kmD4ETsq4dyizYIWkjQyxpDeEKrbURY
	G++MWkklKWJyaCzwghWxKgK1D5lXnjk3qVDYhzL0beTMCO+N7hs8dCUXbzG1rvBdGs45QgLw+f2
	Bb+zM7
X-Received: by 2002:a17:906:c141:b0:b87:4f80:f4ca with SMTP id a640c23a62f3a-b87612c3b87mr19870766b.56.1768332474242;
        Tue, 13 Jan 2026 11:27:54 -0800 (PST)
Received: from google.com ([2a00:79e0:a:200:e42d:53cb:2a0f:636a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8724197145sm564109066b.11.2026.01.13.11.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 11:27:53 -0800 (PST)
Date: Tue, 13 Jan 2026 20:27:46 +0100
From: Dmytro Maluka <dmaluka@chromium.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Aashish Sharma <aashish@aashishsharma.net>
Subject: Re: [PATCH 1/3] iommu/vt-d: Use 128-bit atomic updates for context
 entries
Message-ID: <aWacsq9gDrAgPxli@google.com>
References: <20260113030052.977366-1-baolu.lu@linux.intel.com>
 <20260113030052.977366-2-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113030052.977366-2-baolu.lu@linux.intel.com>

On Tue, Jan 13, 2026 at 11:00:46AM +0800, Lu Baolu wrote:
> On Intel IOMMU, device context entries are accessed by hardware in
> 128-bit chunks. Currently, the driver updates these entries by
> programming the 'lo' and 'hi' 64-bit fields individually.
> 
> This creates a potential race condition where the IOMMU hardware may fetch
> a context entry while the CPU has only completed one of the two 64-bit
> writes. This "torn" entry — consisting of half-old and half-new data —
> could lead to unpredictable hardware behavior, especially when
> transitioning the 'Present' bit or changing translation types.
> 
> To ensure the IOMMU hardware always observes a consistent state, use
> 128-bit atomic updates for context entries. This is achieved by building
> context entries on the stack and write them to the table in a single
> operation.
> 
> As this relies on arch_cmpxchg128_local(), restrict INTEL_IOMMU
> dependencies to X86_64.
> 
> Fixes: ba39592764ed2 ("Intel IOMMU: Intel IOMMU driver")
> Reported-by: Dmytro Maluka <dmaluka@chromium.org>

FWIW, Jason and Kevin contributed to this discovery more than I did. :)

> Closes: https://lore.kernel.org/all/aTG7gc7I5wExai3S@google.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/Kconfig |  2 +-
>  drivers/iommu/intel/iommu.h | 22 ++++++++++++++++++----
>  drivers/iommu/intel/iommu.c | 30 +++++++++++++++---------------
>  drivers/iommu/intel/pasid.c | 18 +++++++++---------
>  4 files changed, 43 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
> index 5471f814e073..efda19820f95 100644
> --- a/drivers/iommu/intel/Kconfig
> +++ b/drivers/iommu/intel/Kconfig
> @@ -11,7 +11,7 @@ config DMAR_DEBUG
>  
>  config INTEL_IOMMU
>  	bool "Support for Intel IOMMU using DMA Remapping Devices"
> -	depends on PCI_MSI && ACPI && X86
> +	depends on PCI_MSI && ACPI && X86_64
>  	select IOMMU_API
>  	select GENERIC_PT
>  	select IOMMU_PT
> diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
> index 25c5e22096d4..b8999802f401 100644
> --- a/drivers/iommu/intel/iommu.h
> +++ b/drivers/iommu/intel/iommu.h
> @@ -546,6 +546,16 @@ struct pasid_entry;
>  struct pasid_state_entry;
>  struct page_req_dsc;
>  
> +static __always_inline void intel_iommu_atomic128_set(u128 *ptr, u128 val)
> +{
> +	/*
> +	 * Use the cmpxchg16b instruction for 128-bit atomicity. As updates
> +	 * are serialized by a spinlock, we use the local (unlocked) variant
> +	 * to avoid unnecessary bus locking overhead.
> +	 */
> +	arch_cmpxchg128_local(ptr, *ptr, val);

Any reason why not cmpxchg128_local()? (except following the AMD driver)

Otherwise,

Reviewed-by: Dmytro Maluka <dmaluka@chromium.org>

> +}
> +
>  /*
>   * 0: Present
>   * 1-11: Reserved
> @@ -569,8 +579,13 @@ struct root_entry {
>   * 8-23: domain id
>   */
>  struct context_entry {
> -	u64 lo;
> -	u64 hi;
> +	union {
> +		struct {
> +			u64 lo;
> +			u64 hi;
> +		};
> +		u128 val128;
> +	};
>  };
>  
>  struct iommu_domain_info {
> @@ -946,8 +961,7 @@ static inline int context_domain_id(struct context_entry *c)
>  
>  static inline void context_clear_entry(struct context_entry *context)
>  {
> -	context->lo = 0;
> -	context->hi = 0;
> +	intel_iommu_atomic128_set(&context->val128, 0);
>  }
>  
>  #ifdef CONFIG_INTEL_IOMMU
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 134302fbcd92..d721061ebda2 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1147,8 +1147,8 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>  			domain_lookup_dev_info(domain, iommu, bus, devfn);
>  	u16 did = domain_id_iommu(domain, iommu);
>  	int translation = CONTEXT_TT_MULTI_LEVEL;
> +	struct context_entry *context, new = {0};
>  	struct pt_iommu_vtdss_hw_info pt_info;
> -	struct context_entry *context;
>  	int ret;
>  
>  	if (WARN_ON(!intel_domain_is_ss_paging(domain)))
> @@ -1170,19 +1170,19 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
>  		goto out_unlock;
>  
>  	copied_context_tear_down(iommu, context, bus, devfn);
> -	context_clear_entry(context);
> -	context_set_domain_id(context, did);
> +	context_set_domain_id(&new, did);
>  
>  	if (info && info->ats_supported)
>  		translation = CONTEXT_TT_DEV_IOTLB;
>  	else
>  		translation = CONTEXT_TT_MULTI_LEVEL;
>  
> -	context_set_address_root(context, pt_info.ssptptr);
> -	context_set_address_width(context, pt_info.aw);
> -	context_set_translation_type(context, translation);
> -	context_set_fault_enable(context);
> -	context_set_present(context);
> +	context_set_address_root(&new, pt_info.ssptptr);
> +	context_set_address_width(&new, pt_info.aw);
> +	context_set_translation_type(&new, translation);
> +	context_set_fault_enable(&new);
> +	context_set_present(&new);
> +	intel_iommu_atomic128_set(&context->val128, new.val128);
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(context, sizeof(*context));
>  	context_present_cache_flush(iommu, did, bus, devfn);
> @@ -3771,8 +3771,8 @@ static int intel_iommu_set_dirty_tracking(struct iommu_domain *domain,
>  static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
>  {
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
> +	struct context_entry *context, new = {0};
>  	struct intel_iommu *iommu = info->iommu;
> -	struct context_entry *context;
>  
>  	spin_lock(&iommu->lock);
>  	context = iommu_context_addr(iommu, bus, devfn, 1);
> @@ -3787,17 +3787,17 @@ static int context_setup_pass_through(struct device *dev, u8 bus, u8 devfn)
>  	}
>  
>  	copied_context_tear_down(iommu, context, bus, devfn);
> -	context_clear_entry(context);
> -	context_set_domain_id(context, FLPT_DEFAULT_DID);
> +	context_set_domain_id(&new, FLPT_DEFAULT_DID);
>  
>  	/*
>  	 * In pass through mode, AW must be programmed to indicate the largest
>  	 * AGAW value supported by hardware. And ASR is ignored by hardware.
>  	 */
> -	context_set_address_width(context, iommu->msagaw);
> -	context_set_translation_type(context, CONTEXT_TT_PASS_THROUGH);
> -	context_set_fault_enable(context);
> -	context_set_present(context);
> +	context_set_address_width(&new, iommu->msagaw);
> +	context_set_translation_type(&new, CONTEXT_TT_PASS_THROUGH);
> +	context_set_fault_enable(&new);
> +	context_set_present(&new);
> +	intel_iommu_atomic128_set(&context->val128, new.val128);
>  	if (!ecap_coherent(iommu->ecap))
>  		clflush_cache_range(context, sizeof(*context));
>  	context_present_cache_flush(iommu, FLPT_DEFAULT_DID, bus, devfn);
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 3e2255057079..298a39183996 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -978,23 +978,23 @@ static int context_entry_set_pasid_table(struct context_entry *context,
>  	struct device_domain_info *info = dev_iommu_priv_get(dev);
>  	struct pasid_table *table = info->pasid_table;
>  	struct intel_iommu *iommu = info->iommu;
> +	struct context_entry new = {0};
>  	unsigned long pds;
>  
> -	context_clear_entry(context);
> -
>  	pds = context_get_sm_pds(table);
> -	context->lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
> -	context_set_sm_rid2pasid(context, IOMMU_NO_PASID);
> +	new.lo = (u64)virt_to_phys(table->table) | context_pdts(pds);
> +	context_set_sm_rid2pasid(&new, IOMMU_NO_PASID);
>  
>  	if (info->ats_supported)
> -		context_set_sm_dte(context);
> +		context_set_sm_dte(&new);
>  	if (info->pasid_supported)
> -		context_set_pasid(context);
> +		context_set_pasid(&new);
>  	if (info->pri_supported)
> -		context_set_sm_pre(context);
> +		context_set_sm_pre(&new);
>  
> -	context_set_fault_enable(context);
> -	context_set_present(context);
> +	context_set_fault_enable(&new);
> +	context_set_present(&new);
> +	intel_iommu_atomic128_set(&context->val128, new.val128);
>  	__iommu_flush_cache(iommu, context, sizeof(*context));
>  
>  	return 0;
> -- 
> 2.43.0
> 
