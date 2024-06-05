Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ADD195FE5
	for <iommu@lists.linux.dev>; Wed,  5 Jun 2024 12:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588948; cv=none; b=nvxVJ2GBcAmcUBtpIfN4CXmBoly0hZAOmDi/8Ia2r65S2/9GSHizef/WjOx5lh75OhUM9YB+t0/7nXgbtuePo4n0e8ysEC+9715mVyxHivm1yZwxepMwrn4KP7zrDhlCqQRHfdumQOxPLl7oJMPQJOnp8ETvmZv1hh6+iHP0Kik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588948; c=relaxed/simple;
	bh=nw27Ww+rQ2umB0SaLCjNt4fTaXvBnAkTAq1QSdPry8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hcEJnM8v+jO7Uji+sF9zYHw7DlKiZcewfvSywh026sTltL4RMzwg34HaKhmAFPkRtShLwLurQnafIuJOyYj7rnddDjndR93WIsqUgR9dZCytJGJMCIGMQgHgTo2D4qZ75SRLAD58csjoluHh9gw3Gvo02X9pGSwD3iiyG7PL27M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NASqDXGP; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NASqDXGP"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70260814b2dso743580b3a.1
        for <iommu@lists.linux.dev>; Wed, 05 Jun 2024 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1717588946; x=1718193746; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EBzQyRtg9eqUOlOjbmDo1iz6ws2MaRBxmM5VGftOF3Y=;
        b=NASqDXGPYrlnxrS6beR0Sg9C3HSPxtW1YyudN78DxBcYXbM9edjHPQjUMzPOMXURJf
         i6D9ghElm9eITMpwx0d2HzLef3pQWaoOiSjpFyCrSoP96iFKA0a5mvArse5Ak/6kszIJ
         X5eHo9J1EdIWbO/WbdgP9f+bU8sj673oIvKi728zAzt2j7e9atHTrfd7vwW33zX3m4xS
         2sWEuGGWLJRP5XZAYxl7XQ1jQVU+w5qJaadWnOX+3CxjMRlr59QGvHHakMxNmmsDWgOK
         THwvOH3PD9hP2ppkmpCS6dKFlTPbkun4th/oyHzf5WYsGJHVZIIYfl5iaGhSl7K+ZYUu
         BAnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717588946; x=1718193746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBzQyRtg9eqUOlOjbmDo1iz6ws2MaRBxmM5VGftOF3Y=;
        b=n5EkWmXyPnuVPIM7IkHOejSpDNDNX4PPRkI2els9Fzh/vVAsH7c0ziBVNab77ELmwI
         3d338Sz8w83QOSZPyo78tf6IERpqlbenF2mRgAXQbGzL1APUmB8/Brhj6mel8mElTwLZ
         shNOxiH8W9lYSjo0zHMlh+gKrc42OpLl/o/lLeEjE6LO0D+dHScecnL61lnZy2tzp9T5
         0deVWTLfiTAM7+Gm3qsvTBN9/liFYknGm3fzfvYl9DNugSEGGTCXR4qlATFLl87v5KuE
         N1g6dTKlPAbxxt+1Vbuttdnbjeuc/H9WW94y3OpHpGUtTi69cvYxZ8R3YBevQuKjge3D
         oFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvy1AJYHyipbTEqJhw7buZO6o7xDd+tF2rVuiiEYrTDtsKVxZoRLSuINaVMVhQq8xov8B3FW9pv7UJz8yVt1JRRDLiBmI=
X-Gm-Message-State: AOJu0Yz7D0VgsnfjkIH/sOnIPuaZEgSA0NQbWK+zDis+L4reb9rcsPo6
	P1m9yMR6JOXegCCIMgXgcCLxQxxi/Q71a4TkvjsbiFAMQKYsJ7vlKG6ZtMBwPXg=
X-Google-Smtp-Source: AGHT+IEFWklTwr0BdToe8q8Dyd2LsVYpzcq9B49hIrgHsM+qLI6lea7XfCdpTPFEyRoPcTJhgDV8SQ==
X-Received: by 2002:a05:6a00:2393:b0:702:683c:4aea with SMTP id d2e1a72fcca58-7027fbe118emr8967854b3a.5.1717588945595;
        Wed, 05 Jun 2024 05:02:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70264ec3d8csm5443733b3a.176.2024.06.05.05.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 05:02:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sEpLT-006aZU-Qp;
	Wed, 05 Jun 2024 09:02:23 -0300
Date: Wed, 5 Jun 2024 09:02:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kalle Valo <kvalo@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Alex Williamson <alex.williamson@redhat.com>, mst@redhat.com,
	Jason Wang <jasowang@redhat.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>, iommu@lists.linux.dev,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/22] iommufd: Use iommu_user_domain_alloc()
Message-ID: <20240605120223.GD791043@ziepe.ca>
References: <20240604015134.164206-1-baolu.lu@linux.intel.com>
 <20240604015134.164206-3-baolu.lu@linux.intel.com>
 <20240604165145.GD21513@ziepe.ca>
 <02e88f89-a277-433d-9ccc-af4318a8e80f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02e88f89-a277-433d-9ccc-af4318a8e80f@linux.intel.com>

On Wed, Jun 05, 2024 at 10:17:07AM +0800, Baolu Lu wrote:
> On 6/5/24 12:51 AM, Jason Gunthorpe wrote:
> > On Tue, Jun 04, 2024 at 09:51:14AM +0800, Lu Baolu wrote:
> > > Replace iommu_domain_alloc() with iommu_user_domain_alloc().
> > > 
> > > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > ---
> > >   drivers/iommu/iommufd/hw_pagetable.c | 20 +++++---------------
> > >   1 file changed, 5 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> > > index 33d142f8057d..ada05fccb36a 100644
> > > --- a/drivers/iommu/iommufd/hw_pagetable.c
> > > +++ b/drivers/iommu/iommufd/hw_pagetable.c
> > > @@ -127,21 +127,11 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
> > >   	hwpt_paging->ioas = ioas;
> > >   	hwpt_paging->nest_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
> > > -	if (ops->domain_alloc_user) {
> > > -		hwpt->domain = ops->domain_alloc_user(idev->dev, flags, NULL,
> > > -						      user_data);
> >                                                       ^^^^^^^^^^^^
> > 
> > > -		if (IS_ERR(hwpt->domain)) {
> > > -			rc = PTR_ERR(hwpt->domain);
> > > -			hwpt->domain = NULL;
> > > -			goto out_abort;
> > > -		}
> > > -		hwpt->domain->owner = ops;
> > > -	} else {
> > > -		hwpt->domain = iommu_domain_alloc(idev->dev->bus);
> > > -		if (!hwpt->domain) {
> > > -			rc = -ENOMEM;
> > > -			goto out_abort;
> > > -		}
> > > +	hwpt->domain = iommu_user_domain_alloc(idev->dev, flags);
> > > +	if (IS_ERR(hwpt->domain)) {
> > 
> > Where did the user_data go???
> 
> The user_data is not used in allocating a paging user domain, so I
> skipped it.

That's not true.. We have no driver using it right now, but it is
definately part of the uAPI and a driver could start using it. That is
why it was hooked up in the first place.

> In my first try, I simply replaced iommu_domain_alloc() with a new
> paging domain allocation interface. On second thought, it occurred to me
> why not use separate interfaces for different purposes? Even though from
> an iommu perspective, they both use paging domains.

If we want to do that then it needs to forward all the args

> The @flags and @user_data are defined in uapi/linux/iommufd.h, which is
> specific to iommufd. Wrapping them in a common interface for broader use
> seems awkward.

Right, you'd have to forward declare the struct and just let it
be. Really nothing but iommufd could call this API.
 
> So, perhaps we could return to my original idea? Let's just expose one
> interface, iommu_paging_domain_alloc(), and replace iommu_domain_alloc()
> with it everywhere?

That's OK too, this above doesn't really need to be changed, some of
the concept here was that iommufd-only ops would just be directly
called by iommufd itself, to discourage future abuse.

Jason
