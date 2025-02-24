Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0205D1DF242
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 21:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740434052; cv=none; b=WFzA35sPCc8Nc5BS5/UpZTj3/BKecciJcMAB996rqGxI14uq+WFz9825DboOO90MajeCGN8CuRE9oMLGg6E8AcMCzBl988MGHTHTA8h0bOvcmec5T+vibKVjk8u9MaQwiGx8Q5k64Lc5FzDA3IDFJ+L68E9euZo4ISEUxRkub28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740434052; c=relaxed/simple;
	bh=lOfd6dlmeiqEPHy61wcCsI34PRZuT2J/fiEGMBXUCZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ccOsQTx3lVroBy3dUCJm4s9CZBvVKJYGTR6eJz2CGy4Sg/1xVfD2CLqyUrs/TcFBdFUfo5ds/jh0KRBWr+BinU6s/tdD/Pd0BYZ0dTZSjaaLuvGH+I4l+hHBuM5Ps3b/GpcDSjARgwb+VBaycWv5xvKimDNqb9qr//7MY/T+Rv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W5v2HARo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W5v2HARo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-220e0575f5bso53445ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 13:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740434049; x=1741038849; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qcg5x+HnDt6i287wHJ6fnl/QzabNNejalgvIUO3dans=;
        b=W5v2HARom9cPki3f1hm/OOMKahYs6ZrrrFIFmnHV+knFGkHjuJLB14nw84JVUQdUc6
         0+R7B/6Z0c0WR8cj3X/+4JFthM7MDPUH8r8q1SfDm6b143SQKeKe4PWrBem8LtITCoGd
         z5bhqwlHj6i17MBZr6wfONfRcnIUOLx6squP7PKpbxCfpYDMkHDKewKQHZUBPsOpPJkV
         sDiJ4jvrbRwXU32PV+Ic1I2b1q2LGlE41uwWa8LCXHjXu31+DdlHZhiDi8AqSvNzcsS4
         kynNxhApF5vdTYQPtX9AlzoS5msAXjJ5Uac55ednTApvuE4fpOKBScwirJ0doNUA5Isa
         9T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740434049; x=1741038849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qcg5x+HnDt6i287wHJ6fnl/QzabNNejalgvIUO3dans=;
        b=WYMeKu2egd69ZQuBsmirhn92mOeH97+nSe/ni8CfNtRxD3xT+PspgxsiHjQcD0b+De
         5Ltcp3CbOWKzBwvBbCCmqq7aKjgi3NCZK4mdTrfWKjom63fBVyoyers6/se/PL8uRj3C
         zozzq+9H8Fpq9BH60JfJaIh2rTyC97GIqcXCblAYwmCGGdjUh2x/OBuz3j/MvhNV+3gy
         jrEKtD23+B8Z93ARPkU/do90xxA/morCQstRXdMM3faQz5eccHDM6++y/+mq+5E1KjhJ
         cnuVCMFedUzppbX9S8XQHb1HXGHhfysSEqYh91gs5zE+l4EbK1vv0E5fbcH1nZN5uxoY
         LGGw==
X-Forwarded-Encrypted: i=1; AJvYcCWy9Or6t1vdbZrCWWF+vX7y1TSrN4uUco+30KTkG3FQz47PlthsL2LqEJOC5PqLsNOxEndnbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqruDPpsa3Z6UyOGDUwmyCLh9iZB26kjqE6yamVpN73I1ET6MG
	u3lVJ8aQT1tF4+zPyXSNsUPe9Sw9koI3eUsyDekzwSBB4tjt4ckxQoNvgQ9jmA==
X-Gm-Gg: ASbGncu6LDFwrkO9zutMI9WUigHAk8O4aAfsLXhtF6x9967fTPOOgxX7OyAXBA6+fie
	OZqMRowxILNPkS6CpfFBWPwggucXuxYxXOWZ5t1bd7mcaTFO4sXuny8SR05HE5fc87L8Ovvz9hB
	slX1HMLi+VsVEIGVkREKHSrJu/4w6B15vYlub5vScvNvUUklx8RtPMu/MiKpye+ML4rkgLJ/zoR
	gxRL0Sr/YJa7UXp3xJ81z0Fdb3UPsPDnDRBiDAp4e9F1HkVwWAlUReByCGvEq9tr2IMubYxULvr
	Xnr3MBlbMxkYeIhVE/gz4InMTbvpbZyuv1GLAaf0JjkRry/noUPldCUS+CI5yXY=
X-Google-Smtp-Source: AGHT+IEpKhaMyBCkt6aQomwMTBim64fWChp3DGISBq2p87Hyiqlav2xt82oY5FJwGrR4tW3dc9pk3Q==
X-Received: by 2002:a17:903:22ce:b0:216:21cb:2e14 with SMTP id d9443c01a7336-22307a989ecmr1049425ad.21.1740434049047;
        Mon, 24 Feb 2025 13:54:09 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a6fa230sm131119b3a.70.2025.02.24.13.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 13:54:08 -0800 (PST)
Date: Mon, 24 Feb 2025 21:53:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z7zqdrQn7Q8yXfcn@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
 <Z7zYLBLZGKim-5UL@google.com>
 <Z7zlH74/orq9HF7Q@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zlH74/orq9HF7Q@Asurada-Nvidia>

On Mon, Feb 24, 2025 at 01:31:11PM -0800, Nicolin Chen wrote:
> On Mon, Feb 24, 2025 at 08:35:56PM +0000, Pranjal Shrivastava wrote:
> > oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > index 5aa2e7af58b4..364d8469a480 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> > > @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
> > >  	}
> > >  }
> > >  
> > > +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> > > +				    struct iommu_domain *domain)
> > > +{
> > > +	struct arm_smmu_nested_domain *nested_domain;
> > > +	struct arm_smmu_vmaster *vmaster;
> > > +	unsigned long vsid;
> > > +	int ret;
> > > +
> > > +	iommu_group_mutex_assert(state->master->dev);
> > > +
> > > +	if (domain->type != IOMMU_DOMAIN_NESTED)
> > > +		return 0;
> > > +	nested_domain = to_smmu_nested_domain(domain);
> > > +
> > > +	/* Skip invalid vSTE */
> > > +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> > > +		return 0;
> > > +
> > > +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> > > +					 state->master->dev, &vsid);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> > > +	if (!vmaster)
> > > +		return -ENOMEM;
> > > +	vmaster->vsmmu = nested_domain->vsmmu;
> > > +	vmaster->vsid = vsid;
> > > +	state->vmaster = vmaster;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> > > +{
> > > +	struct arm_smmu_master *master = state->master;
> > > +
> > > +	mutex_lock(&master->smmu->streams_mutex);
> > > +	if (state->vmaster != master->vmaster) {
> > > +		kfree(master->vmaster);
> > > +		master->vmaster = state->vmaster;
> > > +	}
> > 
> > Does this condition suggest that we might end up calling
> > `arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
> > commiting to a vmaster?
> 
> No. prepare() and commit() are 1:1. How is it interpreted to have
> "multiple times"?

Ohh alright. I was just confused about why do we need to check:
`if (state->vmaster != master->vmaster)` ?

> 
> > > +	mutex_unlock(&master->smmu->streams_mutex);
> > > +}
> > > +
> > > +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> > > +{
> > > +	mutex_lock(&master->smmu->streams_mutex);
> > > +	kfree(master->vmaster);
> > > +	master->vmaster = NULL;
> > > +	mutex_unlock(&master->smmu->streams_mutex);
> > > +}
> > > +
> > >  static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
> > >  				      struct device *dev)
> > >  {
> > > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > index 358072b4e293..9e50bcee69d1 100644
> > > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > > @@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> > >  	struct arm_smmu_domain *smmu_domain =
> > >  		to_smmu_domain_devices(new_domain);
> > >  	unsigned long flags;
> > > +	int ret;
> > >  
> > >  	/*
> > >  	 * arm_smmu_share_asid() must not see two domains pointing to the same
> > > @@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> > >  	}
> > >  
> > >  	if (smmu_domain) {
> > > +		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);
> > 
> > IMO, this adds a little confusion for folks not using iommufd.
> > 
> > I guess it'd be cleaner if we invoke this below within the:
> > `if (new_domain->type == IOMMU_DOMAIN_NESTED)` condition instead of
> > simply returning from the function if the new_domain->type isn't NESTED.
> 
> But the arm_smmu_attach_commit_vmaster() still has to be
> unconditional as !NESTED domain should clean the vamster away..
> 

Ack. Right.

Thanks,
Praan
