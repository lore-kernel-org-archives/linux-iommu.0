Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB2A1D88D7
	for <iommu@lists.linux.dev>; Tue, 18 Nov 2025 00:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763424884; cv=none; b=jKd4FKV6NGjXrIwH8tYQi0tNnqLKS5MzB3RU/sIdr2cZm0PlPaLGYYclaceXBM5NpWM7rxe6APetgaBOJBdRi2wm0HEVT9Dd+PzN/iba6CULnAUFcA32syCyzvop51WfteGoyOeDZRxDrv6Yqjpi72geIu9EgcJk5A/0Aa3H8pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763424884; c=relaxed/simple;
	bh=59dkISQhDxxeSYGRIb1tvn0ByeIHMc6w53i4RK4ojzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5a19xu/CgRaEwdEtAGgfgdycgLIhU2e4MNN95cB921PzTyCGSEXV/mDGrfmLt62Uo9DULbnaP6K7fd3G0HX0AeplVFxjZ8Nv7vEvlJZQyJP5u/3iq1m7+UgPScKcPkmigtWXVQRtas4+3spIsK7DtT+r5nKf05x3jFmFYRi+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JU3TuuKk; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JU3TuuKk"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88054872394so64676406d6.1
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 16:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763424880; x=1764029680; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9h+bVRZ3VpRt/4U2FxH9wTdAZ8SKu8h6koAp4wAZ66E=;
        b=JU3TuuKkZL9RWafWxT8/wcBEKC9Fr5XXee/CsdM8L1Uc2l5ovWbqgs+LS8QcTyKh8p
         6oaPP8OvVuiwBIdLqHpJr2zh/pyMcbV3bMbcxAQnzWwNtDyvXqgJmRn66KnRwhR06Got
         +bF3xSzuB5mOdBchThZiyP0xcQtpidTtEPrCFRuGDfv/EjleHLoFZCGZsmzUJXgV0C0X
         cSikWqLE6CnnGOfJLidrnMffLc13wdNTkml0brDEDJeRYQCSLpAFtapiY5Yn+oCD3Wj+
         p1aqK5xW8443GWqXRHJOdkA9BIA3KZn0CYuXZ2yZ26ZIIt4MZTR9AyfDcHCvBGoP9P3J
         41Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763424880; x=1764029680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h+bVRZ3VpRt/4U2FxH9wTdAZ8SKu8h6koAp4wAZ66E=;
        b=NQxP+UN92tbqTq1MZt48XaDNkvJ5vyRTxXCd5600+Mn0Ui8Gd7U8sycTLUz4uteiNh
         0m5v7lcSCOIooSJkR6dMSxdXjXVTIhuSbArm0slSn9qbe7ERWjwwHuBlBD1Zatm9vqqm
         xM+aA05dT72/kQJtGt0g8T54XHxzetH9ZcgmwiqsNJ9DwrNYSs2maYPGnkrrJIuQt/zD
         jP4P1AH2jyPvgYeoKuQfK4BAJdguRj4ORMupqa9KU+FsKZXX9dkGGU4GBLsowxUQzb2E
         kiOIobzy+0LLm7CPJdMh32FlZvWaQBo+7Fr5cwIbb1yYYZKvx4GghoxuUkq2otNEjPmo
         KZbQ==
X-Gm-Message-State: AOJu0Yxvl2qAVveDygSa8IvAG5Msxn2F890EVkPr8T7WBE/X83ljMVMM
	qhg/XltC+oVY1O+S/kHIvwOhNXdN6Vww+YCfSeOqcY8hyj/B9RlfuThd8YGqJd1fahM=
X-Gm-Gg: ASbGnctxDxEB8uo7vICbW38BC+DudQYsp3Z3CTNe8DX6sgIOIZSJl+k0ccJv6SQiAdh
	AvZFFQDMfN7EFEnNecEhzl1pYanoWLZ6CHW5/GYrmdIi/8KiCHVfOZQ0+H8kC2DVu7KYtIEr2ZD
	DhxIc/BMvCtVnzvCMTyirguKicipwwDuIsANCg/1DdymJBHfpeueF2bl4ySzyAuXYyxzaIZzyx0
	GPbCwyQ7WBXaIUDDpk0PWb2ukmvddbjxb37yKtPzdqC9CpvNZaCwgYyVAsmZOu8kn+GNpylJs3m
	GAUNvXCgiyQqZWOrmRwDDXLYP+c053V+3bcbxr3ZdNtvU1wa0rrVIZ7hiMmvCLJiDMhIn3usYA+
	W2o8iJZOvD6pQyjdTKILxYrzUwSVMrbHVsEFgVHQ3Hd2S7MuD49djxC4GG3ab7sUnDqq2H+GAO4
	8zp4ZvjD6Sh/QZgPe7oUhGeOO1NlymzTiCHd3QayBI+kbQX72wSnT0Y7MF0wRfIeQ3UOM=
X-Google-Smtp-Source: AGHT+IESqwymd4/cuNAvOZY228QguoQIqen7Rriulx/lQKAHD/t2H/UkToyIY9uR3jqYAlH6nfi1vg==
X-Received: by 2002:a05:622a:1647:b0:4e8:ae6c:2392 with SMTP id d75a77b69052e-4edf2129a39mr209641901cf.69.1763424880561;
        Mon, 17 Nov 2025 16:14:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede87e6fecsm97276601cf.18.2025.11.17.16.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:14:40 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL9Ml-000000007u8-1tBU;
	Mon, 17 Nov 2025 20:14:39 -0400
Date: Mon, 17 Nov 2025 20:14:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 8/8] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <20251118001439.GF17968@ziepe.ca>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-9-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117191433.3360130-9-praan@google.com>

On Mon, Nov 17, 2025 at 07:14:33PM +0000, Pranjal Shrivastava wrote:
> Invoke the pm_runtime helpers at all places before accessing the hw.
> The idea is to invoke runtime_pm helpers at common points which are
> used by exposed ops or interrupt handlers. Elide all TLB and CFG
> invalidations if the smmu is suspended but not  ATC invalidations.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 10 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 95 +++++++++++++++----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +
>  3 files changed, 91 insertions(+), 17 deletions(-)

I wonder if the cleanup.h macros would improve this?

> @@ -1122,6 +1124,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  		break;
>  	}
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>  	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
>  	/*
>  	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> @@ -1129,6 +1135,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  	 * terminated... at some point in the future. PRI_RESP is fire and
>  	 * forget.
>  	 */
> +	arm_smmu_rpm_put(smmu);
>  }

What are the rules for power managemnt? If the SMMU sleeps and GBPA is
set to abort all then how can we have an outstanding concurrent DMA that
needs page fault handling? 

ie if we resume the fault and the racily power down the SMMU isn't
there a good chance the transaction will blow up anyhow?

Isn't that a bug we should detect?

Basically, shouldn't some of these be more like 'if not powered up
then something is very wrong so log and fail' ?

> @@ -2152,13 +2171,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  {
>  	u32 gerror, gerrorn, active;
>  	struct arm_smmu_device *smmu = dev;
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_get_if_active(smmu->dev);
> +		if (ret == 0) {
> +			dev_err(smmu->dev, "Ignoring gerror interrupt because device isn't rpm active\n");
> +			return IRQ_NONE;
> +		}
> +	}

This looks troubled too, if powering down looses the gerror register,
then this scheme is racily going to loose gerror events?

Seems like it should be checking that gerror is indeed 0 before
powering down? Under the assumption there is no concurrent activity
this should be race free? If it is not zero then it should be handled
before it is lost.

>  /* IO_PGTABLE API */
> @@ -2377,6 +2422,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	} else {
>  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> +
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  	}
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> @@ -2471,6 +2517,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  	}
> +
>  	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>  
>  	if (smmu_domain->nest_parent) {
> @@ -3312,13 +3359,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
>  			sid_domain->ops->attach_dev(sid_domain, dev);
>  	}
> +
>  	return 0;

extra new lines??

> -static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> -				    struct device *dev,
> -				    struct arm_smmu_ste *ste,
> -				    unsigned int s1dss)
> +static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> +				   struct device *dev,
> +				   struct arm_smmu_ste *ste,
> +				   unsigned int s1dss)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  	struct arm_smmu_attach_state state = {
> @@ -3361,6 +3409,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  	 * descriptor from arm_smmu_share_asid().
>  	 */
>  	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
> +	return 0;
>  }

??

>  
>  static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> @@ -3371,8 +3420,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  
>  	arm_smmu_master_clear_vmaster(master);
>  	arm_smmu_make_bypass_ste(master->smmu, &ste);
> -	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
> -	return 0;
> +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> +				       STRTAB_STE_1_S1DSS_BYPASS);
>  }

These things are not allowed to fail, please be careful not to
propogate errors beyond where they should be. This is the biggest
thing I don't like about this series, we already have no error
recovery and now we are adding more cases where errors can't be
propogated. 

For instance this call really cannot fail and propogating an error is
nonsense.

If you really couldn't power it up then you are better to keep it
powered down and update the in memory structures knowing that a
powered down device cannot cache them.

Jason
