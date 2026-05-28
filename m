Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F3407598
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992107; cv=none; b=U0V9cMGyZfESZJb5nNJ8ZLtt/hZ81RWI/bih02CpAAl8ju2wZTAfjBzd4EOKV03Ztd/ThhDpdGARb1R5dt0mT0TJ7jcC9xuU0iNs3twxh/8AmD966E8l+aS7KksVgtUKnltMRBn0EOLZp0Y+3j0cnfw5dOJ6ZlFDcgH36CU8DvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992107; c=relaxed/simple;
	bh=oVw3Nd5J5iK2SatiaW52qk8wnvZOzD4L0X/96I7vm/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T0zGjByxqeJ8CVOYpmYOIyLFGIz4eR+3idVzwPw+MI8nvulgUf62XqPoeJQEjSnM+C9/ePQ4hOG3mpPEOOiho3VeeLlH2RFBIPpq3BbIfBORfcySzdA//K6syX9ImVnMLge6o+9z6js3CoGDgxX5orKoPY8Wzad27eJOGKdDIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M9eU5qBr; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M9eU5qBr"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so135ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 11:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992105; x=1780596905; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=M9eU5qBrwzj4QkxQXpLqkuHSa6IPvr9zAEpFI6HEt7GrYHKHq1mW+eT6Zh7AZg2lh4
         cj23uPASdpxk6/QicbIrYGvEQi3yjvj6icQfRb3U17orGsC3sbmnyHM6KPup0NVBUbkU
         PkFpHpLfodO6BOKm/bCSACqv7ZoxP+ISn7luaa5G9T37GqAZqVyuY32BaONkhu4BvWlJ
         I3MM7Tc/Bx78klaNPfoBxDWVSVyv0/l/HB8IWREKeZayRaW3Xl0e6sAKYV5dnqCkuksm
         +L968vMz75Y6ulJgbx1nz7BwGe0IBrpiQHqONhfUp9yTT479BLV0PBfAubkbBRMDxJPg
         4D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992105; x=1780596905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J/+HWoid0BEbW+tXsuIRks6EMfRCMcY0XqrXIbQ7CY=;
        b=UFpgmRFRsAyyjPNFhbI4wzUK8lfVL3Kqgru0fdQKIj9F+csQdEB6jHGThw35uPcrsY
         rVefjcjZ5tgDsq5mwxvlbNdmhpwWUditmmQO9TTyNlhO81BaEJuONWIpwrcAQzoGISaN
         mBWiuskqzY1BnXSFiUyGZIJrE7k/Oy8ShtlfXwread7JPjw6PxQfMoQZoyu3VuIAQlel
         XGx0NmyjhAxcG9wXlT5jWjp+F4+D/uV/qVEUg5bfw2LvxWWzK4v47/2lmNTgL5mg+hbP
         nV1T+G8684XQ5qeaNUJixr+J6rZjn2EBBj7p1Vgh/ZB6ZNtx5COiFEhYLqf+MRhJ82PJ
         zUxA==
X-Forwarded-Encrypted: i=1; AFNElJ+sMsg7gLAlE/+8Acwt1kNAowlB0xWjtr+NVnRQC0cW8Z4ChhCXE09GaB6LbBFiIzMirMXkbw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1JzDRQdEhcV6Ne3w6g1eNRBysVQMsl5KU4DgoGo/nlqpzWuFc
	zWH4Ve6g8UuA4yA88el36YTp7MaAfo/oXdvA13Hr/zo7uLRt6vq+T75sigMTBxwNDA==
X-Gm-Gg: Acq92OE8CIcgWRQ3GzwwYlNx5G5UOy0Z355EI3mJz6IorPodEjGVWwe6Rnt0pUdiUoE
	f4wZ8zr+UnHuS13Q2AT9xr3WdZmTf6743tI2DI8v3bqakYOmB8qtvgN6RT9aWG0bukaxpBqF4TZ
	kmHWfszK4bJhQ8/+5PsPaFcoErXZ3MtbjQ/MOocGY1LkMS66mhqUqT1KM/6GoC9Bskz0lKmR4mI
	9zKdNXQf/6ZL/HDk1UiRvck32xePMhhbexonNHA0NbcSWGhr3u0IiSc2+fKClzAr8YN63kExhz9
	wISywLIzPME5XbgqrW6w6qtPTShHkckA4kIHpP5+zfqO+qqRKejElLJHrC6bmciXMoHNXRelV7P
	mEDmoVWIbcmfmduaSnr0i7jJCs7r9Csin6U2mEvXWVGUMlIZw3gFua8xYZYYjnZBhfVXmh0Lx19
	E8456cBEts5vrexGhFzB0eXiXZzdB6/kRbSbDychFqdSpjNepdSVhQk6HSO+k3U6fDe59Q
X-Received: by 2002:a17:902:da8d:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2bf1e2f6227mr112265ad.2.1779992104891;
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b908f8f80sm2156136a91.5.2026.05.28.11.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:15:04 -0700 (PDT)
Date: Thu, 28 May 2026 18:14:57 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahiGIUDG2uvA6usM@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528180018.GB3195266@nvidia.com>

On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > 
> > > > > +	master->ats_always_on = true;
> > > > > +
> > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > 
> > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > requires Config=Translate with S1DSS in bypass?
> > > 
> > > Yeah, basically.
> > > 
> > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > a valid CD table pointer.
> > 
> > Ack. But do we expect transactions before attach_dev? What'd happen if
> > we don't allocate CDs here?
> 
> It can be done at any point before a non-abort STE is formed.
> 
> The core code pretty much does this immediately after probe so there
> isn't much point in moving it later.
> 

Right.. that's what I'm not understanding clearly, if the STE is Abort
anyway during probe, why are we breaking the alloc-at-attach convention? 
Usually, we allocate CD tables in the first attach_dev call. Why does
that not work here?

[Disclaimer: Not a pushback, just trying to understand the requirement]

Praan
