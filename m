Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616926ED53
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 20:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763670388; cv=none; b=f+0n6R6TAyVtqpox8IJmagzpBGmDosNWI5Nm4FfYkacdAcxh0IuCnbNdKVVNXrENEsxNvJnrOgzayhSw2A63SMk/jfV4QbEN5Pz0jJMvxCnSCIuGbWpBlaFzCqO5EdUbkdO8EVXJucLpSLF6FLUyC8o16LdzxPLFutYlzC4//pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763670388; c=relaxed/simple;
	bh=SOhWuiZaDYS9utBno1RyPxrQi1nmDaUm1EumeRWQcd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnCuYS4l4+kB8RWMz9OqL0cscXe6yYmUOIuT7Uu6kQwyD8HPPESWCsFCQQuaIUUxfzkMJ5nyOluNesMKFBYHcOVBz4WMx5Y5Q49ffhyQobTjZLDmEnGKJh4JrCoSdag0ZcaTltJU5oqI6MTo0errvkZy3hN8X+Oo+guuBSRNVm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FqzyujJK; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FqzyujJK"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-295c64cb951so42385ad.0
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 12:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763670386; x=1764275186; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ei+IMWTJdIi7sfHmeYbW5wAKDLr0zA2TA75JePGt5G8=;
        b=FqzyujJKxIcwmmW7eTexzdzJmeRK8vGbxq9M0C365kyMrRxvdIgjAVZca4DZiYGWQf
         6yqwoHo5xoW9CcbiE6aEULfKSQYFbkOHp7SWdPkjWmy5stzWW5Jv/og8MjbYi8MRL2nY
         pL36uGiBWVztIZGyeXJk2BqJjDf/66zxnMtfoYKBSEcLrDTeUgJjSbrjbLjhuAwhzIuz
         2edbS7a2Dkh+XW+J5LETs8oUG1h3GCgkIg0HKVEB+vp0kIvxDsR49nYI5on7ux8xphCP
         4hX2sD0jmEHrpZ51ZZTnOZe2x3iS5Iad9MF/hyOKVUuf/WCEEhhKZKeNZoSx9UlTAPJP
         ZCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763670386; x=1764275186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ei+IMWTJdIi7sfHmeYbW5wAKDLr0zA2TA75JePGt5G8=;
        b=VVX86MdSq0ZQ/NbGazZ6OjmHmDMui4PxAPH0HXOlNNl8oaJRsXPDheERw4dWarTGGK
         GLmq/Pvd+Fxc0RexaBQuNk7YFs4E6bRW83XBguHr8Hq2qIkgkZ8/tkgYIlYmiBaReYes
         LL7diCUTeq70f4PNswHrt9cHzH/whOYNuUeX11DUUhLLWLl3y/4hOFYQWU3Y6ibFOmW+
         f3xD2WJrCLwx3dQUEt7/wyVMqmNTWl+mOj3udEUyq5wkCLBT5nvADf/42C+WH59DsFL0
         fpKmvRGPrlT6nkzHo9e2+jL/kt2Jqvit2W0uLnJdzY24qVc6Hgp/oxQpf6qagLE75fzK
         PY+g==
X-Gm-Message-State: AOJu0YwNbYLVaoZw0tFIu0ltRbctkvIi96JjNKyv4tN9l6Jl5bz1wQtS
	fncWRwzlR2ijXPVFGB0UiYG1ln3hQfKR/URhKtW0+6SesHrAQoraULWVFXGHs2mKDg==
X-Gm-Gg: ASbGncsfgzLhjuFPG4Jh4RAw5NCFtyrKLxvgT//pxU7l0VHcKjFVDOrSGDNyI/IogRB
	rJtqm87myr4QSsP2OsMt95ZAHk/scnnkKOFMLjbb3la2icuj0g6gfnYIEPGkjoi5OimDejx0Ygl
	9tWKdoguX3qnb3Kq/Geg2mPO8AXRedYKDHHzqFX+0YmGpvIqJ0Del8uEpb4i29tkithovdN/8ZH
	kzfIyvvnXdwQ0XaUitk7ig0lpzg1bgSgcBxppEBf+o7Eew21szjuZ85KzdThwTLaB9ttAZevZts
	kRAAJWIHSPuC33rZb9Oi/klMsICyTv35di5TwJ+E8mjb8Jv/B3my2JOd5wrLuZAZDMImqI0GsaR
	r2ghg08Mj+eF6FzPDe/k1G1kommEYr4GM9AbC7Hyu4FWHKv0o6vVmkCzwbZSkOVifpGnRi3Oyi2
	5Rew+kbQVGVFint2L3N1ccNjFnNWac9mqeI6MhUoMzpVd/DUkR
X-Google-Smtp-Source: AGHT+IE7x4xZ5mGBfgyUfKt39HYzlwSIKyIPjw+CM5sXb3/1Ra4vMIYBbEqEgeNtS2CdDZtpld1I7Q==
X-Received: by 2002:a17:902:f691:b0:295:5138:10f2 with SMTP id d9443c01a7336-29b6a437f68mr490105ad.11.1763670385639;
        Thu, 20 Nov 2025 12:26:25 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0a67a4csm3713827b3a.48.2025.11.20.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 12:26:24 -0800 (PST)
Date: Thu, 20 Nov 2025 20:26:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH v4 8/8] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <aR95bHwPMyW3U5hd@google.com>
References: <20251117191433.3360130-1-praan@google.com>
 <20251117191433.3360130-9-praan@google.com>
 <20251118001439.GF17968@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118001439.GF17968@ziepe.ca>

On Mon, Nov 17, 2025 at 08:14:39PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 17, 2025 at 07:14:33PM +0000, Pranjal Shrivastava wrote:
> > Invoke the pm_runtime helpers at all places before accessing the hw.
> > The idea is to invoke runtime_pm helpers at common points which are
> > used by exposed ops or interrupt handlers. Elide all TLB and CFG
> > invalidations if the smmu is suspended but not  ATC invalidations.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 10 +-
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 95 +++++++++++++++----
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  3 +
> >  3 files changed, 91 insertions(+), 17 deletions(-)
> 
> I wonder if the cleanup.h macros would improve this?
> 
> > @@ -1122,6 +1124,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
> >  		break;
> >  	}
> >  
> > +	ret = arm_smmu_rpm_get(smmu);
> > +	if (ret < 0)
> > +		return;
> > +
> >  	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
> >  	/*
> >  	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> > @@ -1129,6 +1135,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
> >  	 * terminated... at some point in the future. PRI_RESP is fire and
> >  	 * forget.
> >  	 */
> > +	arm_smmu_rpm_put(smmu);
> >  }
> 
> What are the rules for power managemnt? If the SMMU sleeps and GBPA is
> set to abort all then how can we have an outstanding concurrent DMA that
> needs page fault handling? 
> 
> ie if we resume the fault and the racily power down the SMMU isn't
> there a good chance the transaction will blow up anyhow?
> 
> Isn't that a bug we should detect?
> 
> Basically, shouldn't some of these be more like 'if not powered up
> then something is very wrong so log and fail' ?
> 

Yes, I think I assumed that this thread won't run while we're powered
off which was wrong. I'll add a check to confirm we're powered up. The
RPM calls are just to ensure that we don't suspend while issuing the
resume.

> > @@ -2152,13 +2171,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
> >  {
> >  	u32 gerror, gerrorn, active;
> >  	struct arm_smmu_device *smmu = dev;
> > +	int ret;
> > +
> > +	if (pm_runtime_enabled(smmu->dev)) {
> > +		ret = pm_runtime_get_if_active(smmu->dev);
> > +		if (ret == 0) {
> > +			dev_err(smmu->dev, "Ignoring gerror interrupt because device isn't rpm active\n");
> > +			return IRQ_NONE;
> > +		}
> > +	}
> 
> This looks troubled too, if powering down looses the gerror register,
> then this scheme is racily going to loose gerror events?
> 
> Seems like it should be checking that gerror is indeed 0 before
> powering down? Under the assumption there is no concurrent activity
> this should be race free? If it is not zero then it should be handled
> before it is lost.

Yes, I believe we can check it after disabling the CMDQ and log the
events.
> 
> >  /* IO_PGTABLE API */
> > @@ -2377,6 +2422,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
> >  	} else {
> >  		cmd.opcode	= CMDQ_OP_TLBI_S12_VMALL;
> >  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> > +
> >  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);> >  	}
> >  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> > @@ -2471,6 +2517,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
> >  		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
> >  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
> >  	}
> > +
> >  	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
> >  
> >  	if (smmu_domain->nest_parent) {
> > @@ -3312,13 +3359,14 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
> >  		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
> >  			sid_domain->ops->attach_dev(sid_domain, dev);
> >  	}
> > +
> >  	return 0;
> 
> extra new lines??
> 

Ughh, my bad, I'll fix this, all of these are just some rebase-remnants

> > -static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> > -				    struct device *dev,
> > -				    struct arm_smmu_ste *ste,
> > -				    unsigned int s1dss)
> > +static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> > +				   struct device *dev,
> > +				   struct arm_smmu_ste *ste,
> > +				   unsigned int s1dss)
> >  {
> >  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> >  	struct arm_smmu_attach_state state = {
> > @@ -3361,6 +3409,7 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> >  	 * descriptor from arm_smmu_share_asid().
> >  	 */
> >  	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
> > +	return 0;
> >  }
> 
> ??
> 
> >  
> >  static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> > @@ -3371,8 +3420,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> >  
> >  	arm_smmu_master_clear_vmaster(master);
> >  	arm_smmu_make_bypass_ste(master->smmu, &ste);
> > -	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
> > -	return 0;
> > +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> > +				       STRTAB_STE_1_S1DSS_BYPASS);
> >  }
> 
> These things are not allowed to fail, please be careful not to
> propogate errors beyond where they should be. This is the biggest
> thing I don't like about this series, we already have no error
> recovery and now we are adding more cases where errors can't be
> propogated. 
> 
> For instance this call really cannot fail and propogating an error is
> nonsense.
> 
> If you really couldn't power it up then you are better to keep it
> powered down and update the in memory structures knowing that a
> powered down device cannot cache them.
> 

Ughh, sorry, these are just some rebase-remnants. I'll fix them.

> Jason
> 

Thanks!
Praan
