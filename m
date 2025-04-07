Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451DC221DA4
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023096; cv=none; b=n4B+6KeU5bIL4tBZ26sNJm3JRfmBokAJfbpJqimfdXvHSt/6aJZNr1TvRBSCgnAqDdWlf6PzJATVAiuy6LfpFoOUc+NPgbyRfqdFTx83jFMimukplhgcte7biE0/M/a9PnvPhTSxfBIXIFvg8EO+CBU+MW7q66/lKaXNC58tDdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023096; c=relaxed/simple;
	bh=gJaoZvdoA/F31HW61JIj0XVLqHtXvDLdzqtnVyaLyt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BzkLPKmJEVcHXN3kdzDi9AluQYilONP5zv/ZsmY/kMpICwgC9jjS9W1l1YJnJyrDbyef6guk+tp0Is39WSzadOfOjq/Oc1srxnoNp3DjDvgA5JlOp0HmvkYYwnoGLNbJoGiSKK/5tKIG7hff72KfsDFhbpSnDLDdA5MmxaXUeWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qecFyJNa; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qecFyJNa"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2263428c8baso351815ad.1
        for <iommu@lists.linux.dev>; Mon, 07 Apr 2025 03:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744023093; x=1744627893; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbOTzGFNhz15uoPOrk0rjEt/+xH1zo2FYpc66vCfXZE=;
        b=qecFyJNaB5QK8/4p7YiOLp1tP+8kw6DnxJSOo9N9m1z1kIPRITCr9p9WI97cQlofEb
         sfyVydiDTnHJjGCwPHUE7otIvAZQlS9wpf6cfDjALw9nLAezil8LSjg6dSOx7Sr3zy7A
         4Vyl4udhaJ/X7/eIZVIBWVhy1BMBjEw9QenKaO/CFvuVLcr5kYMMvpaHmEtHpMjdfZyh
         nvunDPlXsrs8SLUUp/SYGaCAlZ9G1D6GVQDpbiei/FBu9NQYn7KKB6L4Q+c0zrSmk6TR
         KnZEjF9WiJQG768T3YNwYVUX5014lmGXHBMkZmYHM8wv4oj9fEC0KgJ+e0QS/0ykzqKR
         jrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744023093; x=1744627893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbOTzGFNhz15uoPOrk0rjEt/+xH1zo2FYpc66vCfXZE=;
        b=Vck6+EsmMKglJhxKb0P1M4vt4Di1WM0QdXJy65Nvzmf/uqtMCFLOdvcc/CkteHDKjh
         hU4Lz0WOTlTF1DZSvwkzVd1VTowLzFQmRzWgFp0cb7eOikckq4IMMhk4L3W/pdkeXZag
         w/jVOCRriL6/0jGCQvq3fT7BdlqXEaglNfP344XmV+nYmiqOKSwd6ue1DZL75VvdL+/V
         /1Ijjo1PcgAbscsYoVe6LnTpdwPXXvdLgtl71U5eYZTDuNXTWPqDjhjVWycfFffMf88D
         zjhAgv0muIPJOwfn7PDZsw6aw+lHBIK+Qt8LZ3OM4gmgrNmlZOOLdCJd20AoNw9zhTYa
         dDVg==
X-Forwarded-Encrypted: i=1; AJvYcCXbcaPiUZLl0GsxqXw8hye6EHrrK4L9HkOx17iWa0YYTlMQAlLrgbgZSfleHIUl6vNBbfsX2g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzGcQl0a37u/Mdz/r04/CckSrxSOEyAnZoh1VjErF+EVjJ4CneV
	O3wj2x/19GG7hEu/K+npAaJ1W6qCieGyv/9aR/SHRHc4uOR41Z8dvMEZQdlJzV4YHIblcvUqBaI
	pvA==
X-Gm-Gg: ASbGncvxXPko5reJeYLOeOXXtbUQeunAphslWUQwYdE676wBkNPeoaHUNsnpBAwhB8H
	Ph8drrMofqauxwMo1mDZw0sY2XxieVUGsWKqkmYkHV52Wn8uPsF3ICuPDzLemZ5FD6YMg+dFQs3
	RgdgGk4GlnAEDJyUHQP5YUfAPDLHA8Whq4H+ymakY0rzSxxTCyNiJ0f9A0knLxmM0etRnj+rnS6
	cXcYUtC0tgYDrErfDPkQGZ3Mz8wHcz9VOBLLazjnMo5WM0atq20GmonHcQ05UmMPEOTvOB3UN7w
	1eTqT6oOqvX/zAdI16ojiCWnrn6TNdQf+ZmGqfD+HXuE3gwcAkVsZqtY/OQHAWlffX0Z5oOOTJZ
	4bKg=
X-Google-Smtp-Source: AGHT+IHb0AXSOrm1IvS7cqtNNGlz0NiH+Mhkd5aWS0Yc7Ae/NCDEI4krlsFHBlUBOAJW0WycUAsCOA==
X-Received: by 2002:a17:902:c412:b0:223:fd7e:84ab with SMTP id d9443c01a7336-22a95eb8de7mr4775375ad.24.1744023093078;
        Mon, 07 Apr 2025 03:51:33 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e7f5sm77676465ad.206.2025.04.07.03.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:51:32 -0700 (PDT)
Date: Mon, 7 Apr 2025 10:51:24 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2
 nest_parent domain
Message-ID: <Z_OuLJ7RGnChDckY@google.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>

On Tue, Mar 04, 2025 at 09:04:02PM -0800, Nicolin Chen wrote:
> An S2 nest_parent domain can be shared across vSMMUs in the same VM, since
> the S2 domain is basically the IPA mappings for the entire RAM of the VM.
> 
> Meanwhile, each vSMMU can have its own VMID, so the VMID allocation should
> be done per vSMMU instance v.s. per S2 nest_parent domain.
> 
> However, an S2 domain can be also allocated when a physical SMMU instance
> doesn't support S1. So, the structure has to retain the s2_cfg and vmid.
> 
> Allocate a vmid for a vSMMU instance in arm_vsmmu_alloc() and add a proper
> arm_vsmmu_destroy() to clean it up.
> 
> Add a per-domain "vsmmus" list pairing with a spinlock, maintaining a list
> on the S2 parent domain, to iterate S2 invalidations over the vmids across
> the vSMMU instances created for the same VM.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 10 +++-
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 35 ++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 47 +++++++++++++++----
>  3 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 3336d196062c..1f6696bc4f6c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -849,8 +849,12 @@ struct arm_smmu_domain {
>  
>  	enum arm_smmu_domain_stage	stage;
>  	union {
> -		struct arm_smmu_ctx_desc	cd;
> -		struct arm_smmu_s2_cfg		s2_cfg;
> +		struct arm_smmu_ctx_desc cd;	/* S1 */
> +		struct arm_smmu_s2_cfg s2_cfg;	/* S2 && !nest_parent */
> +		struct {			/* S2 && nest_parent */
> +			struct list_head list;
> +			spinlock_t lock;
> +		} vsmmus;
>  	};
>  
>  	struct iommu_domain		domain;
> @@ -1049,6 +1053,8 @@ struct arm_vsmmu {
>  	struct arm_smmu_device *smmu;
>  	struct arm_smmu_domain *s2_parent;
>  	u16 vmid;
> +
> +	struct list_head vsmmus_elm; /* arm_smmu_domain::vsmmus::list */
>  };
>  
>  #if IS_ENABLED(CONFIG_ARM_SMMU_V3_IOMMUFD)
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index ff8b550159f2..2c5a9d0abed5 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -30,6 +30,23 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
>  	return info;
>  }
>  
> +static void arm_vsmmu_destroy(struct iommufd_viommu *viommu)
> +{
> +	struct arm_vsmmu *vsmmu = container_of(viommu, struct arm_vsmmu, core);
> +	struct arm_smmu_device *smmu = vsmmu->smmu;
> +	struct arm_smmu_cmdq_ent cmd = {
> +		.opcode = CMDQ_OP_TLBI_S12_VMALL,
> +		.tlbi.vmid = vsmmu->vmid,
> +	};
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&vsmmu->s2_parent->vsmmus.lock, flags);
> +	list_del(&vsmmu->vsmmus_elm);
> +	spin_unlock_irqrestore(&vsmmu->s2_parent->vsmmus.lock, flags);
> +	arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	ida_free(&smmu->vmid_map, vsmmu->vmid);
> +}
> +
>  static void arm_smmu_make_nested_cd_table_ste(
>  	struct arm_smmu_ste *target, struct arm_smmu_master *master,
>  	struct arm_smmu_nested_domain *nested_domain, bool ats_enabled)
> @@ -337,6 +354,7 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  }
>  
>  static const struct iommufd_viommu_ops arm_vsmmu_ops = {
> +	.destroy = arm_vsmmu_destroy,
>  	.alloc_domain_nested = arm_vsmmu_alloc_domain_nested,
>  	.cache_invalidate = arm_vsmmu_cache_invalidate,
>  };
> @@ -351,6 +369,8 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct arm_smmu_domain *s2_parent = to_smmu_domain(parent);
>  	struct arm_vsmmu *vsmmu;
> +	unsigned long flags;
> +	int vmid;
>  
>  	if (viommu_type != IOMMU_VIOMMU_TYPE_ARM_SMMUV3)
>  		return ERR_PTR(-EOPNOTSUPP);
> @@ -381,15 +401,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
>  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> +	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
> +			       GFP_KERNEL);
> +	if (vmid < 0)
> +		return ERR_PTR(vmid);
> +

Probably a basic question, I hope we'll have one vSMMU per VM? Even
if that's not the case then the VMM should take care of invalidating
contexts of all associated vSMMUs anyway? (Just thinking if we should
allocate a VMID per VM or per vSMMU)

Nit: Does it makes sense to create a helper like `arm_smmu_vmid_alloc`
and call it here and finalise_s2?

>  	vsmmu = iommufd_viommu_alloc(ictx, struct arm_vsmmu, core,
>  				     &arm_vsmmu_ops);
> -	if (IS_ERR(vsmmu))
> +	if (IS_ERR(vsmmu)) {
> +		ida_free(&smmu->vmid_map, vmid);
>  		return ERR_CAST(vsmmu);
> +	}
>  
>  	vsmmu->smmu = smmu;
> +	vsmmu->vmid = (u16)vmid;
>  	vsmmu->s2_parent = s2_parent;
> -	/* FIXME Move VMID allocation from the S2 domain allocation to here */
> -	vsmmu->vmid = s2_parent->s2_cfg.vmid;
> +	spin_lock_irqsave(&s2_parent->vsmmus.lock, flags);
> +	list_add_tail(&vsmmu->vsmmus_elm, &s2_parent->vsmmus.list);
> +	spin_unlock_irqrestore(&s2_parent->vsmmus.lock, flags);
>  
>  	return &vsmmu->core;
>  }
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 0462eb1b2912..addc6308742b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2249,10 +2249,22 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	 */
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		arm_smmu_tlb_inv_asid(smmu, smmu_domain->cd.asid);
> -	} else {
> +	} else if (!smmu_domain->nest_parent) {
>  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
> +	} else {
> +		struct arm_vsmmu *vsmmu, *next;
> +		unsigned long flags;
> +
> +		cmd.opcode = CMDQ_OP_TLBI_S12_VMALL;
> +		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
> +		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
> +					 vsmmus_elm) {
> +			cmd.tlbi.vmid = vsmmu->vmid;
> +			arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);

Shouldn't this be vsmmu->smmu?

> +		}
> +		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
>  	}
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
>  }
> @@ -2342,19 +2354,33 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  		cmd.opcode	= smmu_domain->smmu->features & ARM_SMMU_FEAT_E2H ?
>  				  CMDQ_OP_TLBI_EL2_VA : CMDQ_OP_TLBI_NH_VA;
>  		cmd.tlbi.asid	= smmu_domain->cd.asid;
> -	} else {
> +		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
> +					 smmu_domain);
> +	} else if (!smmu_domain->nest_parent) {
>  		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> -	}
> -	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> +		__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
> +					 smmu_domain);
> +	} else {
> +		struct arm_vsmmu *vsmmu, *next;
> +		unsigned long flags;
>  
> -	if (smmu_domain->nest_parent) {

Minor Nit: IMO, an explicit like this clarifies it better. I think we 
can keep this add gotos for the __arm_smmu_tlb_inv_range calls above?
(Like the arm_smmu_domain_finalise_s2 changes below).

>  		/*
>  		 * When the S2 domain changes all the nested S1 ASIDs have to be
>  		 * flushed too.
>  		 */
>  		cmd.opcode = CMDQ_OP_TLBI_NH_ALL;
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu_domain->smmu, &cmd);
> +
> +		cmd.opcode = CMDQ_OP_TLBI_S2_IPA;
> +		spin_lock_irqsave(&smmu_domain->vsmmus.lock, flags);
> +		list_for_each_entry_safe(vsmmu, next, &smmu_domain->vsmmus.list,
> +					 vsmmus_elm) {
> +			cmd.tlbi.vmid = vsmmu->vmid;
> +			__arm_smmu_tlb_inv_range(&cmd, iova, size, granule,
> +						 smmu_domain);
> +		}
> +		spin_unlock_irqrestore(&smmu_domain->vsmmus.lock, flags);
>  	}
>  
>  	/*
> @@ -2477,7 +2503,7 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  		mutex_lock(&arm_smmu_asid_lock);
>  		xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
>  		mutex_unlock(&arm_smmu_asid_lock);
> -	} else {
> +	} else if (!smmu_domain->nest_parent) {
>  		struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;
>  		if (cfg->vmid)
>  			ida_free(&smmu->vmid_map, cfg->vmid);
> @@ -2506,7 +2532,10 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
>  				       struct arm_smmu_domain *smmu_domain)
>  {
>  	int vmid;
> -	struct arm_smmu_s2_cfg *cfg = &smmu_domain->s2_cfg;

Is this really required? I see we're still doing the same thing for
the nest_parent == false case.. we'll anyway return without doing much
if (smmu_domain->nest_parent)

> +
> +	/* nest_parent stores vmid in vSMMU instead of a shared S2 domain */
> +	if (smmu_domain->nest_parent)
> +		return 0;
>  
>  	/* Reserve VMID 0 for stage-2 bypass STEs */
>  	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
> @@ -2514,7 +2543,7 @@ static int arm_smmu_domain_finalise_s2(struct arm_smmu_device *smmu,
>  	if (vmid < 0)
>  		return vmid;
>  
> -	cfg->vmid	= (u16)vmid;
> +	smmu_domain->s2_cfg.vmid = (u16)vmid;
>  	return 0;
>  }
>  
> @@ -3233,6 +3262,8 @@ arm_smmu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  		}
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S2;
>  		smmu_domain->nest_parent = true;
> +		INIT_LIST_HEAD(&smmu_domain->vsmmus.list);
> +		spin_lock_init(&smmu_domain->vsmmus.lock);
>  		break;
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_PASID:
> -- 

Thanks,
Praan

> 2.43.0
> 
> 
