Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240B535A381
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000761; cv=none; b=Gk2G2KoYdDindjuzmEuXZF06tuxVPhHzKHVvSUQCsNG11DmkoNnx6mjim6LO3/ykjscQHwqBfW7o+yRL8bHzdEhxmuRo00C4/8/a1P66HzbGy8scmD04FurAet0MdzY51oiY/G0+OkVVO+KLZNnDb9aErnralrzzJGRONue/7PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000761; c=relaxed/simple;
	bh=KqExw4yVF8fFYi6V24rBae9JPYjDk4kcYZvI5BlVCOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTJkcDGhnoehsCRbDGVRnPw8Qsece0tKQ1QmVG0wizzRi36nbFm+9Y3YkPoDV/EQEbhvgdE4Iar2z5uaiF8H8GhtWqI9ZuM3gk3xD32+jHNfUVF1wDX9NwmSv+jPgas3ZxTyT79U02V4nr5rI7tSXpcYtwXsnnqvtEeUK7QyN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HcDksEXQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HcDksEXQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1055ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000759; x=1780605559; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=HcDksEXQJRIYp1h1SLrS9zsLZxq3moHitNY/XaSg1WOOMIwFkFmuZuy9pDNODlrcty
         I9fsQ+xibq0ykE3mCmUpnrxyrZ0tunnJf39EBurHWkZxmb2Q1cz28ksi7t3sPhVGEb7a
         +r7z7WetONCmuCjy1fjWPUaLG61UySPNngl9/cbjYrUJmWk+eCkYNXNtjMagA/b6IrZI
         ihZU0QXYQpX00gZN7QXn9Mg+rPXkghnnfvv7a/JVHKkjUgmeitXtWJ0bWrn+LGkRLOHf
         SK6la4WPPKEOvVh1/rI/LR3cuOtQYymSG50PZbT8qnAxlU1NXfNt6wiHZlYmUkbNX9qt
         IBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000759; x=1780605559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meonzuuyclWLVGJV9U6aQdhritntP0vgCuzICbgArsQ=;
        b=tVZNm4H+yuMPzI3MYYGY04bBsiR8sDnHA+rBjzQn8S4vtPFMK1/7tMhn/bUbWaZv9i
         VypTxpszVRE9j/GZRj/pj3Y9q0RJDauJgQ4HSpl+QxZOIiSIz88FvZV/pgCANINJ2G4m
         aJ93Hf5H0BuGK8U8ZmZKYc45ZEOw/3WyEEiqRG/buq8wIXXLppk5cLmEwzGR8QBAKeUK
         BIXVdi0VXqNJE0IOS47gmCSitr8b+b7+WxguzPtQBCiv/822b8TNaEl3G8YHGaqB4nQu
         Dpd6hJj5KAnjrmTK6NOCtEt1aEII9cu/p3QGlxmtOy0itE4hoaZ2BGmYpRJXphTen7AI
         Jwfg==
X-Forwarded-Encrypted: i=1; AFNElJ/7/lmAbzZ2f7/v1s38/U6J9TDWuXyUjn6jGTW3PPK/YfDRkdMM2T3F6zF5nXRIAX7T7KQeww==@lists.linux.dev
X-Gm-Message-State: AOJu0YzIrn2zkY8FdEtdJAsp6Hsaq/ScjZ04hG4n9NOXFHf73JkI71dw
	55hTspzFnkuP6dRiHopRosbJTyUgBHFNuONFQZBMX8EDb01Ig1Nz0wuUSUZldExgvw==
X-Gm-Gg: Acq92OEfpKNenW5r7B6MaHB1yTwJ/UDsRrvxDqim2OeT/BAApLSB/iCn0wgj06ZxIdD
	nWMGN/+ObmCwZqdQhtrimq1cBvLMzbrCSMO5Btt8nQCcqyMX7jX8JqpMUWcb0TBdSEycVfIGDZP
	8Ok6KrnUXxtaxLDgm/OOH2kARgcYAQ1F1LhWgNT8HoU1Z9lNGHdBwnKCw6r01UccIO1jFIyPp2m
	rKaFgafYVBDjTRdAxZMHWQIP0RJdOPPqFUG4EHnO8HdESsysHjlYV3NSTUeWNn4kn72EzSgAg/K
	8yZ6yVjo7hsedZSypLefC5TtExN8pmTaaGuCi8JSSy8S0u8uIi1xWCzJEOaYWGDZeFQPzMKSo0w
	GJ2nzZQmzwa5kIAhjuY8MRmxDQY0/k/Geon+oUXHOtL82werE117gl8hS0CWtS3rqpK8C39xIK5
	6G1sdgRVaalykdFNlgduW4mN6lJ7wK0esF6XMDGKWSF+rrfVTL0A+yQkzRQVIYOr2XxiG8
X-Received: by 2002:a17:903:1a67:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf2046519bmr79225ad.25.1780000759071;
        Thu, 28 May 2026 13:39:19 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf1e609a0asm1939385ad.26.2026.05.28.13.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:39:18 -0700 (PDT)
Date: Thu, 28 May 2026 20:39:11 +0000
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
Message-ID: <ahin734hJ0CSSepe@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
 <ahhuFw3ZJpy48xkH@google.com>
 <20260528180018.GB3195266@nvidia.com>
 <ahiGIUDG2uvA6usM@google.com>
 <ahiHc3y4wAxxtpLT@Asurada-Nvidia>
 <20260528200450.GC3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528200450.GC3195266@nvidia.com>

On Thu, May 28, 2026 at 05:04:50PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 11:20:35AM -0700, Nicolin Chen wrote:
> > On Thu, May 28, 2026 at 06:14:57PM +0000, Pranjal Shrivastava wrote:
> > > On Thu, May 28, 2026 at 03:00:18PM -0300, Jason Gunthorpe wrote:
> > > > On Thu, May 28, 2026 at 04:32:23PM +0000, Pranjal Shrivastava wrote:
> > > > > On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> > > > > > On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> > > > > > 
> > > > > > > > +	master->ats_always_on = true;
> > > > > > > > +
> > > > > > > > +	return arm_smmu_alloc_cd_tables(master);
> > > > > > > 
> > > > > > > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > > > > > > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > > > > > > requires Config=Translate with S1DSS in bypass?
> > > > > > 
> > > > > > Yeah, basically.
> > > > > > 
> > > > > > Effectively the ARM rules for enabling ATS and Bypass together require
> > > > > > a valid CD table pointer.
> > > > > 
> > > > > Ack. But do we expect transactions before attach_dev? What'd happen if
> > > > > we don't allocate CDs here?
> > > > 
> > > > It can be done at any point before a non-abort STE is formed.
> > > > 
> > > > The core code pretty much does this immediately after probe so there
> > > > isn't much point in moving it later.
> > > > 
> > > 
> > > Right.. that's what I'm not understanding clearly, if the STE is Abort
> > > anyway during probe, why are we breaking the alloc-at-attach convention? 
> > > Usually, we allocate CD tables in the first attach_dev call. Why does
> > > that not work here?
> > 
> > It would work in attach_dev(). I just felt cleaner to have it in
> > probe(), paired with arm_smmu_free_cd_tables() in the release().
> 
> I thought it was like this because we don't have an alloc on attach
> flow for the identity domain, so add it there or add it here..

Right, doing it in attach would've been cleaner, but I don't mind the
existing way too (since it's merged anyway)

I went down this hole since the reason for the convention change wasn't
immediately clear.

Thanks for the clarification!
Praan
