Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556E3B5E08
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 18:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787684248; cv=none; b=UoDRWdYuE5nNwDxnxZGtEUVyeFQs6B1AFdAcruq4C5Pg2XVSiAnCMe72QO6rcnzSjvcNs7yoRSHUDTR+XLnfhJCl+KcgfmfTENPpJTHy8oeqkzxidLPssTdxFBkvRQ74E9vv6HH1WajE06Vln2VQ9U+UL79pPCStEXxaH3w/yt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787684248; c=relaxed/simple;
	bh=A/h26eXl0xarpMHAe7RIPRoWG8dNIaPwriDmWaO9FBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpW2h9lePGvDjZaMAD/br+huLd4uvYyAq1vi2SyLHqIM3pUx43xvsVMTNlHR/xO8EkU/pwLF8m5RbFxhZsrl/5t13KjN6vQoNkLv3ZJo2240CAP6YNv2WxE4T3kJeB7YSNRkh+s5T/rxiLm0FeaxEYNaO8lIcUZfYSqKK25Ars8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=di6Zv27t; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="di6Zv27t"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ccdf36f63dso24025ad.0
        for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 11:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787684245; x=1788289045; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=re8o97vXXRWN9hwLj+SXRGcLra8gbzi+bvyeubfh7Lg=;
        b=di6Zv27tb+J/JaATrU3WZVd4gafO7+1Pj2nrBRt1Gab20mFeWnkEJ3Zx3DhCkr1vxr
         8adkTHYq9oYF37kSpKTW2b4r2lkyDZwgCfb1SObxLNSDtcrlP1JopKBDCox0NIqqFgcw
         hK7R1bhZXiWiBeykUYMkCQZRr2B+LuyKXnqGnpOENYV4EWxYHG6wWOY4EypjNMYoEhTQ
         kL/DOk5RoCNkMCEyx4jHcXE0jIrdMC6/EKaDv3pvuDRCePq+7Uq+Jzh2+1wst1v3AMz2
         CjGJV+u/soNwILfMBDPxm4vDua69ONNdRVP+PkGbNPUVh3Moi3VqDTbdcSF2cGcAQbR5
         d20A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787684245; x=1788289045;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=re8o97vXXRWN9hwLj+SXRGcLra8gbzi+bvyeubfh7Lg=;
        b=GrQ9Db0RNFXicy4lDmoe9RttYHL632ISwk84DtWA1g+mqckuwN1pWRnMMXlskZq5xi
         /sCvowPmNm6AzO2u3cz5AuPZrgDYYGGxSNjs8c4WECsb9x/LmovABwbH0UL/8InhjQtP
         JJ74PjNdF5LbRwOOEIM3J87vikmethOuO1HtDwHBEYw1y1kz/HEVQ156bSOeB2i+Dc8j
         Io6FSI8X+/a2xhGmqe4m/QMsHUZjhe5KlNsJ5wWGY8W3oyp/wEfGxdtvTtplrNNtrRL7
         emwo0kmlaZrJSXndEnCSjuAZEfcLOQ2qlwxSdB0WN3i7Kyf6JZmisaA+CCx3kPrEqO6U
         +SWA==
X-Forwarded-Encrypted: i=1; AHgh+RqBIrgX0UNqoBiy6+gWvn60gADMNZnch0lVSpjm+nI4bvqII9aRLBRAxE85fjsIeP6bOk4+yQ==@lists.linux.dev
X-Gm-Message-State: AFuF++ny/04WMuVjJIvRosZz3voqvVP0mei9g00uTtr1ZIFhsz+JpsHF
	u8qSGLcwDl1dpULInnstQv3fzKr9vKLTJZgn8IrYNdCHZgYQgnk98vwDt3ztAPqGzg==
X-Gm-Gg: AR+sD12yJ6f3Iug4Ecadgn2IlAZHyijDKhPasDh7UuQnFVZut3vY4mE7X2g22uek8rq
	bi7POsIGpk8l5cTtAj1zxt18FoRllc1t7fRnbVGTPWWAk81PGpSBlKjxHUZfgEj1J41Y/ZxDpEL
	XCxNB+1tricf5OZJKyHqz7xITH2BKwMJqIEywVKZlTIBoYPMxlxmbIdQU3nKi71uX5rNdV29+aG
	hkoxLTwt548oyxSMjjJjoS3yiSK9k4CImsMBSuIV7KuCwqAP3RCvlF6Z69wsly5pPjSvP8V0W62
	Bmfl2+jXlVlutlDkR73N8G1C+E/SOX1LRUSX0iCl1BQwKpEQDMIiB34ctdxyHvdYvUPUYhsYlw6
	UxWjmm+NfYPLEN8KV0pTCbxu/VjbMOzi6cmlbUNTvx/alILjmDGPYA9j6/OaUKUwdrqv6PabHzp
	iXIeKRbKfUBOVNPt9ZWfFqX0nI27NTbotywc9aezalt5JEaDAe/MBnMPqvuuWQgwHFoet9DgCZf
	SiXpDxY5gJlydXOeskcXNma3w==
X-Received: by 2002:a17:903:174e:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2d6e0729be5mr10497505ad.12.1787684244127;
        Tue, 25 Aug 2026 11:57:24 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b3ab63sm4732888a91.7.2026.08.25.11.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:57:23 -0700 (PDT)
Date: Tue, 25 Aug 2026 18:57:18 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 02/12] iommu/arm-smmu-v3: Add a helper to drain cmd
 queues
Message-ID: <ao3ljjiXhnSJte5A@google.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-3-praan@google.com>
 <178767577112.3356902.15184998673790345568.b4-review@b4>
 <ao3S5ickm47p1QWa@google.com>
 <ao3dBm1CtH2V06r1@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao3dBm1CtH2V06r1@nvidia.com>

On Tue, Aug 25, 2026 at 11:20:54AM -0700, Nicolin Chen wrote:
> On Tue, Aug 25, 2026 at 05:37:42PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Aug 25, 2026 at 01:36:11PM -0300, Jason Gunthorpe wrote:
> > > > [ ... 36 lines skipped ... ]
> > > > +		if (queue_empty(llq))
> > > 
> > >  [Severity: High]
> > >  Does polling for an empty CMDQ actually guarantee that commands have completed?
> > > 
> > >  queue_empty() relies on the SMMU consumer register equaling the producer
> > >  pointer. However, for CMD_SYNC, the SMMU advances the consumer register
> > >  immediately upon consumption, not upon completion. Suspending the SMMU while
> > >  commands like ATC_INV are still in-flight could abort them, leaving stale
> > >  translations in the device ATC and causing submitters to time out.
> > > 
> > > This seems broadly wrong, but it doesn't seem explained very well,
> > > maybe put a comment above the function something like
> > > 
> > >  The caller must have ensured that no concurrent command submission
> > >  can happen. Thus the entry at the PROD must be a CMD_SYNC due to how
> > >  all submitters generate commands. Waiting for PROD==CONS guarentees
> > >  completion of the sync and all prior work and thus idle HW.
> > > 
> > > I don't think the other substantive remarks are valid.
> > > 
> > > The Werror thing is right, every patch should compile alone without
> > > warnings. Sometimes people add __maybe_unused to accomplish this..
> > >
> > 
> > Ack. I plan to add __maybe_unused here.
> 
> Maybe it's time to use the shared helper in both of our series?
> 
> I plan to send PRI-v3 on rc1 (likely next week) with this:
> https://github.com/nicolinc/iommufd/commit/d10325ff40fd45c476bc98d484d8dd2cdc7fdf95
> 
> I think this series can take it (and its parent Q_POS as well),
> as we discussed in the other mail.
> 

Ack. I agree, I can pick up Q_POS & the common drain helper here.

> Nicolin

Thanks,
Praan
