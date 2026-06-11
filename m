Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACFC93BF69C
	for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781178975; cv=none; b=mK6/+BVi/V0HysKxOFrSw4xvQOnvTOXr0brPjuRqpNhWFZwm+hvPE6Nma1gKDptjY+vW3Lsv/edEjaEKJ+2oxFDA5FvNMZLxqqOiJ/MNV1qY8f/sY6p8BSGyJ0IevdFNU7FXCEEx1/NQ/lu9qxh4jPSdO0GEgokXfQ8diaSyZt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781178975; c=relaxed/simple;
	bh=Iq4WLN3UdQuYTUuisLYn2W2X+Ndr+qrOMlfb30nqMdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGzBFpq9Gron0pbFMS20UceSL2rqUBFPtKEXj2jfGIlHFZ4pcUrIUarWrZOFNA3kdcq9PfHprrZKtB0Z6J3yNV7RmnKa9u7O25UJN9SPv5jLpxPZwaUXvEKMqS4/o60kZ47uXtRrywsBholPh3HsY+qQzGVyEK3ijWuGTgT8rpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hs3K5SpP; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hs3K5SpP"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ccdf8d4ac5so83468836d6.1
        for <iommu@lists.linux.dev>; Thu, 11 Jun 2026 04:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781178973; x=1781783773; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1yyl63jb1xDe2p0em50yKYVQR6uYI/TfEklW/8AWTuk=;
        b=Hs3K5SpPCQLOg42kMSOh/cH0Xm7gcumC28qvBN5SnC/idwJ1YHizK/AfKIgEtzsaKV
         FfnDAUDORthwXPXAeSNq/tsOORCc9p3jG64QZCGbWj2qguAG6j4PZG4uIIbGtZpp+P9v
         YbwXD38ZaqGmvuECgP1MLy2tNPHtdTzu7Bouyhlhw/WdN26meR9maR6lTCrYOiEfDYDG
         hweKElP5FJ99qwC8uxySpIqSMqFwZG4BezDl8SaGiaYKy7XaDKnUi2DnPzQiZR8MGM2M
         3ZFTR+PWsTVI22+/0Z8YwvPKxc1ImQhADWFt1udCMlpKFhSim9Ku0PI43PJryE7284d7
         dhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781178973; x=1781783773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yyl63jb1xDe2p0em50yKYVQR6uYI/TfEklW/8AWTuk=;
        b=rkrEnaSq31vk4XK6N/HZxWw0vC7JdbNtK+hIV/0dsofiZiu//8RdsX86kE+FVn/ddR
         0RqZbQsLQCRRh0wcKx+2y8LX6ZyQ1ggzBvaVDV138KSVPbpHeLTVeF8tCCYG8mdMvX05
         6cd1TADZjQF7WYt/sfWB/t+SxY4bdFNY3BE0baBfdBPzgpO5feKSWNBFtj6BWuB0iFtD
         +prULmyFSqyubwjKFZb/OoH9N9Jom29m1UBHVYOUSe5912p2nKRtWSATy6mTszSvctpn
         B6yYviB4qtooe+39+v2BKwpFuRgLCBGNKzAm/AHVuQAXIY9/Xtw53JKZe8bo7LOg7w+x
         dV4Q==
X-Gm-Message-State: AOJu0YyZkH4iO0bwmKTuHahH4I2n1tJB099v22KdD6TRsT/iAs1ZUOGb
	KAGwMbW+QlCye9CdeaAC7Qk5Hf7P1njdM/d5jbF7vZWA5WgraBIBM7YoHprHbC02TsM=
X-Gm-Gg: Acq92OGg+kV37u1dpvYlgYAdaMHksf+6C4kVUQnM4orDrspRQxs2+DE2qh0/XRvdDon
	Kpwc1DDl3mQWbx5/iUOdmsTsgMCiqZopGIRkAXeu8JaQooSrJhX9AJkXk0trVYwqgVD4IcNENqj
	h69SvZqcdbte4AARvDGEdMj6ng56ksLCV5p9BRctuu8s951N5Vedm1D/uLHANUj05bfhcsPE9hr
	iIveityUrGngnTsKJlcALtdIY+iRGJ8zKKMDq4rmjajmChYDi/xF8N9AeIyF1foCjVP0CrA8AtJ
	Iwb0rSBYQ2rgtzL6+wKAzObAH3fxkcB+zL/41ZYRJfNjDb9nhzENlI/1VNrIF/MhImjMkSxgnUr
	kpZnhp8NcyduqkHchvnI7N6z04ZerVAJzo7219d/XwlGmwYNPOdaKTU8XaCCr+rGkwcIe51pfpU
	SI5kwW7ggRPB3E5Jpr4u0JMuoaIAfrjrseeSlr09/KyW6/ceVw2u6N2HD3xW1mufFCYcy510W7q
	aVZSf10pditwIDv
X-Received: by 2002:a05:6214:2a86:b0:8cc:ea7f:d3c8 with SMTP id 6a1803df08f44-8d1da5623a5mr39488366d6.30.1781178972636;
        Thu, 11 Jun 2026 04:56:12 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d1e838f3a5sm16144646d6.18.2026.06.11.04.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 04:56:12 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wXe15-00000005gzM-2D5R;
	Thu, 11 Jun 2026 08:56:11 -0300
Date: Thu, 11 Jun 2026 08:56:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Srivastava, Dheeraj Kumar" <dhsrivas@amd.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, patches@lists.linux.dev
Subject: Re: [PATCH 0/5] Improve the invalidation path in AMD
Message-ID: <20260611115611.GE1066031@ziepe.ca>
References: <0-v1-a7b77c25974e+115bf-iommupt_inv_amd_jgg@nvidia.com>
 <83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83b8a0f3-2409-464d-a9e4-59b9eea926cd@amd.com>

On Tue, Jun 02, 2026 at 12:36:18PM +0530, Srivastava, Dheeraj Kumar wrote:
> Hi Jason,
> 
> On 3/27/2026 8:53 PM, Jason Gunthorpe wrote:
> > Auditing this path reveals some unnecessary complexity and some
> > confusion around end/size/last and types that may cause issues at the
> > ULONG_MAX limit.
> > 
> > First, fix up the call chains so that the gather start/last is
> > retained faithfully throughout. This avoids converting to a
> > start/size, and avoids various type conversions along this path. Fix
> > everything so the theoretical cases like start=0 last=U64_MAX work
> > correctly.
> > 
> > Simplify all the calculations for alignment/etc to use trivial bit
> > maths instead of the complicated versions. These are all intended to
> > be no functional change.
> > 
> > Finally, add support for PDE=0, deriving it from the gather. PDE=0
> > allows the HW to avoid scanning the page directory cache and
> > supporting it should improve performance.
> > 
> > Jason Gunthorpe (5):
> >    iommu/amd: Simplify build_inv_address()
> >    iommu/amd: Pass last in through to build_inv_address()
> >    iommu/amd: Have amd_iommu_domain_flush_pages() use last
> >    iommu/amd: Make CMD_INV_IOMMU_ALL_PAGES_ADDRESS match the spec
> >    iommu/amd: Control INVALIDATE_IOMMU_PAGES PDE from the gather
> > 
> >   drivers/iommu/amd/amd_iommu.h       |   4 +-
> >   drivers/iommu/amd/amd_iommu_types.h |   2 +-
> >   drivers/iommu/amd/iommu.c           | 175 +++++++++++++---------------
> >   drivers/iommu/amd/pasid.c           |   2 +-
> >   4 files changed, 87 insertions(+), 96 deletions(-)
> > 
> 
> Tested across multiple IOMMU modes; no regressions were detected for this
> series.
> 
> Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>

Joerg?

Jason
