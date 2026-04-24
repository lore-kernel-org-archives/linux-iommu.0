Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A193A2BE05A
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 15:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043609; cv=none; b=C4594W+kd/HhKj4KleexR8y8F1rmUfEo2BVBptmgCjl1ZkIJhkghh1riCHTaTCb8/CYdhbsX6lHXuP4N5fKdtOn43IUAbQiKbkPQWjSVIcG07p3CdrIEd5EaNr0clCTSJaTK/mjtFOnmuwXYR7z4US8gkBgOeqx9AufGRxuMisw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043609; c=relaxed/simple;
	bh=gZCnWmIfClQEBGVGW2eVbRPn92cEvPIVSLpxAFhKDLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zjcz2iHdxw2WuQGBW74k7tjSsuSRW50//SiLkG3tpoWDLa2LltjdtQFtbmSYsuVcgxpVCvIpVwWYxdVCPKs3IzO5wcEiyLbtdUmsxxgUQ3xC+Dcclid7Sv/E6O8npxz19kply/T6CmxAdyIjB02W9Sf6p7Emd0qFObnHx6l0oMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IrZBT45n; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IrZBT45n"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8a3b0242631so96967026d6.3
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 08:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777043606; x=1777648406; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8X5RNAKnOby8/9bt6AmeFSEjKUmJSSjNF4/BzQz7WA=;
        b=IrZBT45nCqSbNFj9oqY6lsg1nQHmS9U9LD0lNNn+sRs8hRnddFJLcYdof2ApjPXA8e
         xb7CGo8uAZ1TaO9VqfnMK1gs4tVLgMh+j1VsgMbnrb//nsjnRoNQ1qnAE0BlM9aKsUnE
         i46izE7rbGDrApy5HgTcE2+RmmJBdN5gvRyMY+qDTQI4F9vYCDKTpGA+PPu0Qwj/Ry2/
         3vzcpaRlG3zt4owy4YZF2rsHxMKdBAsKMYjqXzaQHdnKWCeMrevi0E4cNBWVpLURYeEP
         MF9v0fx8VgF95HaFyEfheigmeHN7UqueGx/rzdB+K+GUygJy/KyXy1gwrNK8ohPwPz3J
         +c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777043606; x=1777648406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G8X5RNAKnOby8/9bt6AmeFSEjKUmJSSjNF4/BzQz7WA=;
        b=D0NC5gGt/vgkJLNpV8u2avwqdI3VWjrIxokV6v2GlE3qdOYNBVwx6OHSu5dSSO83UK
         Frb3fu/e+jjQwg4QRlyEv0ifUxF7YboJUg4d3wPRAuQjqKVMnuBtEuYrMQuFD/CzXFZV
         6C9F4ThVGQMbtDvQK/2412exB4A47PndMg6LWew9lZnrNopYhF6wIbQQNGTDJhNxERY9
         feJyuvZ1wU4dC3bgw4cDZAOeli5b6qo2owO9yLKbWv4YYmGiULEmW7SeP2gaB/fEQ7fO
         oK2LCe2cuafq9pV/nfrGFp4FmjwM10Lgg1O1T+9V8mAWP4/78QyM8n8YpSbqQi5aRLvU
         vN5g==
X-Forwarded-Encrypted: i=1; AFNElJ9gf2NvSqLIyLU+u8/oYuP73TCtC+/N6r5eHHbEO51Sj1IGjD3DqvrkYGcd8iCXyn/ltxxGgA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6AXvcDlEqOQNgELPf45JPgLC+akuay+lwN1Iw9M3ppuVD5+kB
	dDYeloIOTriiRAE6Iy6XTDB0BkcB9DejJ00huQhzuU5F05rZUYLiHGSG3yg7aDUWuRk=
X-Gm-Gg: AeBDieuSV1VKpezjI2vE1Dit+pxfDV3t5IpMFCW+NE8L209gcI5J2ngbwfj0lHJyH+4
	uKTSvP+9DW07phKHEFn61Efa3MhiT5elkQ1ZMAzqT6Qj4dm1XCaAp8s6ApJJUUUWyevgQWDz7tq
	uLpfRUOVLuB6ZQLob/R77fMFpoGjDu9jD/2GCW8n9wC6so/9DZTQvOgGM4r0kYUgdCoAEIYYp2j
	zg8HupSqPKK6vLIEN2ZCoLkbQDuLvS2d2nlkBCdsl3dxXVpSo+kxM/HUTKB5nzilgcNgJ2WR5ed
	D+ssA7QUWJ+rSAZNuc/qQNDy5ATfG6PUPCR6JO663KBzXjMTcfwcDgbZul/cnhQtws04w2HoZfF
	ZVehlvPi78rDNZaPHC/Kr0s3jA70jThJSECWqN2Oa3B94x9yAopTWSkYOuE6Tk+v0HPx3uOyeST
	gEP3cugR0f4q/qxsM2gmNIjVJ8sZeNbAzPd1NrfBfm7qjlUX1yhaHEP0nVA76JbZ0/uOskFHtUB
	o4KCeAsOYVVndnQE0OIQABBQK0=
X-Received: by 2002:a05:6214:5c82:b0:8ae:6347:8c91 with SMTP id 6a1803df08f44-8b027fd8fb0mr444061676d6.3.1777043606591;
        Fri, 24 Apr 2026 08:13:26 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5c4b9sm255365256d6.28.2026.04.24.08.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 08:13:26 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGIDd-00000002yAV-2IfF;
	Fri, 24 Apr 2026 12:13:25 -0300
Date: Fri, 24 Apr 2026 12:13:25 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Ashish Mhetre <amhetre@nvidia.com>
Subject: Re: [PATCH v6 07/10] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <20260424151325.GD3611611@ziepe.ca>
References: <20260414194702.1229094-1-praan@google.com>
 <20260414194702.1229094-8-praan@google.com>
 <CAE2F3rCaBWtRruBbZcedrsLnkkETSniTWoxxYn+Lkac9ttsshQ@mail.gmail.com>
 <aejP5Yk72_FtZnIo@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aejP5Yk72_FtZnIo@google.com>

On Wed, Apr 22, 2026 at 01:40:53PM +0000, Pranjal Shrivastava wrote:

> > > +/*
> > > + * This should always return true if devlinks are setup correctly
> > > + * and the client using the SMMU is active.
> > > + */
> > > +__maybe_unused bool arm_smmu_rpm_get_if_active(struct arm_smmu_device *smmu)
> > > +{
> > > +       if (!arm_smmu_is_active(smmu))
> > > +               return false;
> > 
> > I'm wondering if this check is redundant. What would happen if we removed it?
> > 
> 
> You're right that pm_runtime_get_if_active() shall suffice. However, I
> added the arm_smmu_is_active() check as a lockless fast path for unmaps
> 
> Consider a scneario where there're high-frequency unmaps (unmap-storm)
> while the SMMU is suspended. Without this check, every thread would 
> contend for the dev->power.lock spinlock inside the RPM core 
> (pm_runtime_get_if_active) just to discover the device is not active.
> 
> This check allows CPUs to elide the command immediately without
> contending for the dev->power.lock spinlock inside the RPM core
> (get_if_active call) and avoids unnecessary cacheline bouncing when the
> SMMU is suspended.

But these sorts of pre checks are almost always racy, I think you need a
comment or lockdep statement explaining how the locking works.

Jason
