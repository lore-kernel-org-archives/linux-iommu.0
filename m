Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9724478F29
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122062; cv=none; b=ZvALoLD3Rc0Mitw47vteQHVX0WKx7Q74QWN+fHIjkf7e52OnZjMDOB8upakJGlm2r32x7BO9kKL57TGQbG3+7fl4gC56vgpikz0fN0/ftBfpTudDiUJMeeOvAFuFeLTKC7hZRGwX+CrZpvmeaJUoE1Ats4d3Tu2aSSKfvnRPSLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122062; c=relaxed/simple;
	bh=2Za3cLRtM7U0gO0EIvM/IkgVzkWdWwiibIb4Fc41G4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ON2TljJs4ADaE3T4QoOYspS0ru9ZTxST3HmPzwGoaFZU4+PwK9ULa3ztZcp0QbSmDqLerqj3sgbVyzX9LNeC+NJ5DgWgXdn8jXUhQU5he1NeO5GNfyVi0e3CwKuPONTP2etwM/fIDlN5UlYsbg+lkI8FMhfnwgtqh6Ft6EdWyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zGv0Tj7d; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zGv0Tj7d"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2242ac37caeso158825ad.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744122060; x=1744726860; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=50rhH0P4C6X37y8/XrUykTYL68bxlRnwKFJu2ki7lY4=;
        b=zGv0Tj7dO1sRDj+QYBU+lE9TK3ii5SPG+Tup7Ioa1I3sjljodSKnkp+xi7M96GNVEc
         PkMoiNEisuT6/IWKVQM+mZvkTHVwDkQGaZERsFhbkkdqvyf06W9ngEh8ges1FYqEWEMo
         glyT71JZTGplxcSbEsb5ar/fdfWr9KVRZrDKYkManBXZslsjOhZfWPIJD/8fuFwWL6/U
         HICHvvT97QT9iSp4yNOKbJQDV4GGMfHqSsLtj2e4uXq+dVdbJvHgtkrlVUg/vZiCAqME
         p2y3kw5N5LNdGpQZ9zth7KdmLMivYPq0h7+0Y6Q52vzWNKirCf08jQjfp9Z+NvC6+cWQ
         Sz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122060; x=1744726860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50rhH0P4C6X37y8/XrUykTYL68bxlRnwKFJu2ki7lY4=;
        b=VvS3TeN2YpAPC687eGO1GVogVfFdTpzfhPM+D8RTUg6fIE4Xr+lj5G3eEatOoeBZ1n
         H9pDQhPMBVnYV73jG7nMc3Tl+XwWhuwKFgp+D5dctPwZdfcF/SY5HDrLfdGQnp96RYmY
         eDTn3qJO9YtBykOyMhKwrXjsx3J/z/d7b1d+jwy0mrxvfd7tf6x1NIptqQOheE6rC+nV
         pqWpoMaulUIQWN0TjG9R2a/Tn9UoJPKiXVmmAAbrvp8hNyINNvWYEklrkNVf2vC9pQ1q
         pT+wVSLrnYtUgE4vnhzmbezWdSBr080i8wNHizv+P+kRORG1YpcpNND0GUFlFepyN3Sr
         QhYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOxgE8/XkNvhwKbSNNCr2VcqJ5/CUbWlxGIVkXyl2nk33TcXzN3QQMQUaEBsjzJcJjFeOJag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyMJGJ0DPWN6pKr69PCiGk+rqWgsAf3VPL2bnlGmZ74CQWtp6ET
	qbFfaUTIJJfV0hCmZCURzIb06rYYG3AIY1EOL0jBBdj9Lx2rtLk2PQbu98yy5g==
X-Gm-Gg: ASbGnctdQfUiTmCrfmifJmyECzuHQQ2tnJ+Nu3EAqTVsucUYPdc9rfAUgR6W/cXogf/
	Fp8SfBbC7Lc5biUjei0TzkwWfqwMUKGQ8TuEwRuRJwQh2ZLFRxaiLNtehJn/3W7o+jm+IZS+BEK
	ko9gUQYHQwFAxyX4ntrbOk7vC71j6LHPbV63QrSVzxCeLLNV2K1IgN1D8UxlmdVgoO9X8ykrC+7
	E+m1Ehndmh3g1xUlRbIE0QFWT84/WinPPbuBskHes/HX312AA57h/q0jBbZuc/VL1M4sjLGaMKa
	IDW1AcMdY7IuoSko9qKCdrvxnkdrvhoKqIWWjH1c0ZpV/lnIm6CaOXORUfQyUDCdHxRm35RFsb1
	3gCc=
X-Google-Smtp-Source: AGHT+IE4iRRh4X4YLUZunHgPf+vwd/X5Yt1E655M4r0NMhwn9qwL0MFydS3s1KuHykiWXHRTrO7ZHQ==
X-Received: by 2002:a17:902:db03:b0:20c:f40e:6ec3 with SMTP id d9443c01a7336-22ab7136fa8mr2614455ad.22.1744122059590;
        Tue, 08 Apr 2025 07:20:59 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af9bc32382dsm9155045a12.28.2025.04.08.07.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 07:20:59 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:20:51 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 3/4] iommu/arm-smmu-v3: Decouple vmid from S2
 nest_parent domain
Message-ID: <Z_Uww4PdJesOoA8N@google.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <0429d554fb0f54f6d79bdacacb3fb3e7877ca8f7.1741150594.git.nicolinc@nvidia.com>
 <Z_OuLJ7RGnChDckY@google.com>
 <20250407165220.GH1557073@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407165220.GH1557073@nvidia.com>

On Mon, Apr 07, 2025 at 01:52:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 07, 2025 at 10:51:24AM +0000, Pranjal Shrivastava wrote:
> > > @@ -381,15 +401,24 @@ struct iommufd_viommu *arm_vsmmu_alloc(struct device *dev,
> > >  	    !(smmu->features & ARM_SMMU_FEAT_S2FWB))
> > >  		return ERR_PTR(-EOPNOTSUPP);
> > >  
> > > +	vmid = ida_alloc_range(&smmu->vmid_map, 1, (1 << smmu->vmid_bits) - 1,
> > > +			       GFP_KERNEL);
> > > +	if (vmid < 0)
> > > +		return ERR_PTR(vmid);
> > > +
> > 
> > Probably a basic question, I hope we'll have one vSMMU per VM? 
> 
> A VIOMMU is tied to the physical SMMU, it cannot be shared across
> physical SMMU, so this is the right sort of way to get the ID
> 
> > Even if that's not the case then the VMM should take care of
> > invalidating contexts of all associated vSMMUs anyway? (Just
> > thinking if we should allocate a VMID per VM or per vSMMU)
> 
> If the VMM wants to present a single vSMMU to the VM then the VMM
> needs to replicate invalidations as required to all the physical
> VIOMMU objects. This will prevent using the HW accelerated
> invalidation paths, so I expect that the VMM will have one vSMM per
> physical.
> 

Makes sense. Thanks!

> > Nit: Does it makes sense to create a helper like `arm_smmu_vmid_alloc`
> > and call it here and finalise_s2?
> 
> Maybe so
> 

I recently saw Shameer's patch [1] using a different vmid allocation
scheme, so I guess it's okay if we don't share this function..


Thanks,
Praan

[1] https://lore.kernel.org/linux-arm-kernel/20250319173202.78988-5-shameerali.kolothum.thodi@huawei.com/
