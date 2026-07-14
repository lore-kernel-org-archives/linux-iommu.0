Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8052444717
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784039015; cv=none; b=fzhBJ5dRPC7lioT8ONytmB01YKdkQT7AuJafA7MqaSChV0zDJzmNfNe6mrYKUFsTCWnv6ejSsBkE6fwzVTEDhlgGFI0UpAvji9b9BUvQd83JMD8jiUmoOhx9AwgUT61H03pBjH0M8Nw2rBP2fd1ShFxdOpi7B9dNqMdaSSi31S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784039015; c=relaxed/simple;
	bh=eX92KqheksDKBQ6r9bH0KvEMVEg9f8Ux4Qm+X6nv1ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0xy+Ld+ckpE5qPWtnTW/Hgz4i2aHgXn8g+d+d3BYKj7CBfh3IvWoC3CxASJ/jb45a3pQOAFgOJ2MjtHu2YGIRL1/TjIEyuuRYFAsOgGLoSth74e+BOWz87LCNFlw7oVzKks02LKXmywjqlSueG/+XLge4rzQ50RPRpyGoylIxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mC29nCxD; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mC29nCxD"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ccdf36f63dso139925ad.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784039013; x=1784643813; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lCzoPTpV/z5B2tKPQZt3PsPAo+HT8Vi32iw6SgMRUdg=;
        b=mC29nCxDDZA9piutgeH4a1UFZqlgr+A2za270wVKhYhQ2O2iTzmh7iJUfIz+uHK/0n
         E4o/SSAEXiaxBwhWe3ZY+a33whhBFv4MKdtP1KmPB7aocY3M6xGGGb7hEeQ44WQ3iAVm
         gcVnwZv2Ut/p2z5Ua55jF/6DNm5P/SXhCV4jVn2iPbselzVauEwurmh4kU0skhy2Qerb
         jqPLZwd1l3a0PJ+SDcme0UejnBV0U3tNNVYwg6hjzIvTk2jpAAmN7siqMMuu9PUIeQ3e
         2YzrKk8ceSA6gGoUKB7MGw+XjKJYXGkpZqNfLaXpPoSLNVFG3pjJTYQFPMQ5iJCcUit4
         RXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784039013; x=1784643813;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lCzoPTpV/z5B2tKPQZt3PsPAo+HT8Vi32iw6SgMRUdg=;
        b=K63t0GJprANIMsX2kffWXiX/bmNDkK6WBCdUmtqMpg1Lm/Hnw9pGFRP2WudC2gJ0fU
         TwcTPzEt8czgMTjotepSyekBu/SjDUrzAgtFOmnV6OL7wWOAve+2nsc6xwAt6DGPQ6de
         hRL0DOBSX8D2HOhN55Xe2aEjfMDvoxzf4K6OsTdzUK2bzpeDVswixM/guIH2hIWVtR9u
         vLadveBSAFgLYNzDtKMW28AxyFdUZqUcC8iooib3JPXqawiOcBWq6eWWEHfNH9gX8Zlg
         gSY3UHL58H8UJUNA2LGceVR9HPXtO98y9poym7L3OO5TUYIXKIEIgUeITS8VoTknoCdE
         RMzg==
X-Forwarded-Encrypted: i=1; AHgh+RrQ4QKohH+tyZMxWE2e/pesXcsVD08R/bV87La0lVzXb2VKGe3hF05bhvUYZP34nZgmNzcJjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwfyMxw90f3LEvyeX+CaytO6G1GM3sovJOquRhrqj5K57c/Do8R
	pcMQlUdbCf7fZiiEpzGERQnZAIjIitmCCTjk3Dr2KCetgXwta6IyMqXc5PgjcYdbMA==
X-Gm-Gg: AfdE7cn5XuJjbekZAwYfhg3BSIXy9383qN2IWvCeRNrc49jj5t2zav9KrmYx2eLuc5w
	tUEDFN7UP7WnsNBVcwaRfN8h1VIjL3GXBrvkwqurk5uP9h9bZw4bWRCU4CHtZpq1SetPZtVWDOC
	kXQFhREbZ0C++mHv9WaelO2/xkb3Z6Xo4NrjSPLrMqZyFEugd8BqexPmxUb4YAORsMR7XKMgxw9
	YFOSk6gBESAck8CcNBuojkczmU50wQ4M8NwY8Nnf3QOgcbX2FaUOKU5d3g+D+5bA6mMeKec2SsT
	x3zFo/zdvwEtdFoD85kY3vHd7kown4R60dJIfR4vz4B6Y5BYMBKYfJ0lKCcUFpBiaTN/sr/3s3a
	SE9Xbi1iwGs+8S7m5nbSPi7qeiCBEpnYhK9mOM8XlJt+KZ5KJE2E+tvrAcvnaIn2HZFQ8ZFgHgN
	ctI1F4MmtWeyWc+S+BvtB7sNZdpxiKXFNbwcEJvs9LHIDtV9Q=
X-Received: by 2002:a17:903:2311:b0:2c7:7c7d:fb8f with SMTP id d9443c01a7336-2cee1c08769mr5822805ad.17.1784039012483;
        Tue, 14 Jul 2026 07:23:32 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e172cf903sm1577377a91.8.2026.07.14.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:23:31 -0700 (PDT)
Date: Tue, 14 Jul 2026 14:23:26 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	Kevin Tian <kevin.tian@intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] iommufd: Fix vDEVICE allocation lifecycle bugs
Message-ID: <alZGXrCMZffUvMdM@google.com>
References: <cover.1783311134.git.nicolinc@nvidia.com>
 <20260714140607.GB3695849@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714140607.GB3695849@nvidia.com>

On Tue, Jul 14, 2026 at 11:06:07AM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 05, 2026 at 10:36:08PM -0700, Nicolin Chen wrote:
> > Sashiko flagged a few bugs in how IOMMU_VDEVICE_ALLOC creates and validates
> > a vDEVICE on a vIOMMU:
> > 
> >  - the core publishes a vDEVICE into the vIOMMU xarray before the driver's
> >    vdevice_init() runs, so a concurrent invalidation can reach one it has
> >    not yet accepted;
> >  - the undersized-vdevice_size guard returns holding the igroup mutex,
> >    deadlocking later vDEVICE operations on that group;
> >  - the Arm SMMUv3 vIOMMU accepts a device without exactly one Stream ID:
> >    an out-of-bounds streams[] read for none, stale ATC/IOTLB for several.
> > 
> > Fix each of them properly.
> > 
> > This is on Github:
> > https://github.com/nicolinc/iommufd/commits/fix_vdevice_sashiko-v2
> > 
> > Changelog
> > v2
> >  * Add "Reviewed-by" from Kevin
> >  * Patch-2: Add "Cc stable"; drop the out_release label by inlining the
> >    xa_release() call
> >  * Patch-2: Note that the reserved slot is hidden only via xa_* helpers
> >  * Patch-3: Return -EOPNOTSUPP instead of -EINVAL
> > v1
> >  https://lore.kernel.org/all/cover.1782767110.git.nicolinc@nvidia.com/
> > 
> > Nicolin Chen (3):
> >   iommufd/viommu: Release the igroup lock on the vdevice_size error path
> >   iommufd/viommu: Publish a vDEVICE only after vdevice_init() succeeds
> >   iommu/arm-smmu-v3-iommufd: Require exactly one Stream ID for a vDEVICE
> > 
> >  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     | 15 +++++++++++++
> >  drivers/iommu/iommufd/viommu.c                | 22 ++++++++++++++-----
> >  2 files changed, 31 insertions(+), 6 deletions(-)
> 
> Applied to for-rc
> 

Oops, sorry. I missed this while looking at patches in mutt. Feel free
to ignore my R-b if I'm too late.

Thanks,
Praan
