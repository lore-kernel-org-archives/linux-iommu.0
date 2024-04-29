Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749EB7EF18
	for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402053; cv=none; b=R0v7krY4mp5K/0Ta0UtbglMoUmmCG8wEMHsVB753FPt110PHV4o79vvPHG+9ojeOpHhr4kKOSLERVI1lpsLJBJAE7iR7oYgV9NxHxnmD+ctLvpPF7vfhyvINdpqrTWoAONfsdpAuXucsAdlc891G0UlqwMWEdfBftMiFeLrnWtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402053; c=relaxed/simple;
	bh=COZvZVIo5pXIfwu8taNy8p11lpn+iafehtZeaKCUui4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUfOp6pKP59/HxSpUXT1/UmBwfEFY6BY0xVAmV+IAdCaOOKQI6zktXybdaofSlP0jS7tuM5ZBGczfTzuaRFToRLFbTezXTq0W+IpE/7W2nMCKnIfpX4NIP6ymlPLU1l3NaRaTw3Qko3daSN8j33Bty6yEaOib7TCI2ktUR92KR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhGa0VVT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhGa0VVT"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41a428374b9so92425e9.1
        for <iommu@lists.linux.dev>; Mon, 29 Apr 2024 07:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714402051; x=1715006851; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sXpF4pD7wukxSYdmZaDlYDHlfz3ekIJvwV28C1GdwUE=;
        b=LhGa0VVTMtSl5oFUDAl4sYcvTeQ9oM04ddo7SoGZ/BZoTheyR9QH7lIc/SpmcKeGig
         ym2qujWnTXFkp300KSX8zjtSFH33OZwnquJVMV27c16rTvZ4oq+Eo3FHA4PTreT0daJE
         0cM2QmObEfA5Uhonl7Ej2OZgJD+MK8/r/rjdMBR3tLPTINY2JPJF2WF1ZhvEuQqVIQMm
         AeMUg5SsoYPtq2/H8w86PdPn0qbUTyGQdvmfZjSroQ2lJ9lC7H5LOalDltcdKta6YE0/
         y6RXxDcMSboUU167NJ1v9qFG/DJuaJMvVxmDqPIiS5CG13b1XP1cMpO1H0AdPbV2cFnz
         dUdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714402051; x=1715006851;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXpF4pD7wukxSYdmZaDlYDHlfz3ekIJvwV28C1GdwUE=;
        b=f6P94h6PwltYJ9UbZ5gGgEsuAfTvfZcvq3rEDWtUQA+76e2VIHw8mdTyTsl5RdzFHf
         PrWIqUn3Y2KTS+GUedAOfmv69RypIic8luwnP8qXbFQbzV8gpwK8eco3QJJdlFv7uxVF
         Q6T+Fw2MHTUxUjARLA/TIM5KK+UTPiLbbEP4tyUNfJvM3JecqAlajQoe6rNr+nx67Ng8
         3Eir08Ug0leUbYoNfCOn8c9KFrs07rk8wOWbmRjWZKlSPQjSjgUNTfv4WNubsqM/vClc
         K6BkaAcH8pz0xzuznTmTN89FDNHNEKS8KGvDIA2TkvMXg3qjfbs5C6eDhssqHt6vhlgD
         DQ5Q==
X-Gm-Message-State: AOJu0Yx8/SCN+wSUclnFBeoxu1fN+RPPmhv+gUcavM3rQWT3XSWrx0xv
	xDS9reQFu3S0xb4E2uYnYgLKi2FSmN5Q83PcyvvtG0oYlzcDCmb/SwXEJhi/Yw==
X-Google-Smtp-Source: AGHT+IEumJiMM+6KQSyGqx27CMnk+MXJQtk3/BQ/0NixLY9cScd/LoNQiUjE0BVCSn8fHdv0F7Woeg==
X-Received: by 2002:a05:600c:470a:b0:41b:ff4e:c8a4 with SMTP id v10-20020a05600c470a00b0041bff4ec8a4mr260523wmo.0.1714402050620;
        Mon, 29 Apr 2024 07:47:30 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id j13-20020a05600c190d00b00418a386c17bsm45568804wmq.12.2024.04.29.07.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:47:30 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:47:26 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	Eric Auger <eric.auger@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Moritz Fischer <moritzf@google.com>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v7 5/9] iommu/arm-smmu-v3: Make arm_smmu_alloc_cd_ptr()
Message-ID: <Zi-y_kgb34l0rrRU@google.com>
References: <0-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>
 <5-v7-cb149db3a320+3b5-smmuv3_newapi_p2_jgg@nvidia.com>
 <ZiLerRK1pXvt-HML@google.com>
 <20240422142053.GD49823@nvidia.com>
 <Zi15-dcNj6E0k4jK@google.com>
 <20240429140137.GE941030@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429140137.GE941030@nvidia.com>

On Mon, Apr 29, 2024 at 11:01:37AM -0300, Jason Gunthorpe wrote:
> On Sat, Apr 27, 2024 at 10:19:37PM +0000, Mostafa Saleh wrote:
> 
> > > I'm not sure what you are asking? We have two versions. One is called
> > > alloc and one is called get. That have different locking requirements
> > > on the caller so they have different names. I would not call them both
> > > get?
> > > 
> > 
> > My point is that arm_smmu_alloc_cd_ptr() doesn’t only allocate the leaf,
> > but also the L1 through arm_smmu_alloc_cd_tables()
> 
> Sure, it is called alloc, it allocs everything to make the CD table
> entry usable.

Maybe if it’s called alloc_leaf, it only allocates leafs :)

> 
> > IMO, arm_smmu_alloc_cd_ptr() should only allocate leafs. And inside
> > arm_smmu_attach_dev() it calls arm_smmu_alloc_cd_tables().
> > This makes it clear which path is expected to allocate the L1 table.
> 
> The PASID path sometimes has to allocate the L1 table too, why
> duplicate the allocation code?
> 
> What is different about the L1 vs L2 that it should be open coded?
> 

I don’t think it is a big problem, but my main concern is robustness,
for example a small erroneous code change might trigger allocation for
L1 table from a path that shouldn’t, and that might go unnoticed as
this function will allow it, leading to memory leaks, or other issues
that might be harder to triage later, instead with limiting which path
allocates which level, would return a NULL in that case and fail
immediately.

Thanks,
Mostafa
> Jason
