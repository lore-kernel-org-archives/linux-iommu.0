Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F913BACE
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055392; cv=none; b=Wv9icUtITTNvypp6g4/5U7e+nqHPkw8lEZrSDBI3msN0V65jDcpGEQREwfrfWXkFOt/F2Gf7r4CMiQQUBOj2MkgPrbg3oI/zA4IwDzqbaryoc1gBmorku9WH05TPPH9zBw7Ha7QoBHoVsxXe553jpPXXMoUHP1GqmOlBcUzDSSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055392; c=relaxed/simple;
	bh=Rt5mlVvrG5X18GXNdqMBX+k6wbq6RbsS0qvrJIui/wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD5mdj3/nDNajkV/KdYjPUMF4gBc31Nj3XbQe0V81ypBDVWPVIM8sjjoAojGWoW9bFMUuUKNxqQ8YgPhcRbWZMwkinL5SAVHiWonUdNLu/lAT8kSBmJ0B1gtNCjKkIhv+C6TOCXUrKswkaFQ5jQvMoOOaDrE1ROj1xAdsFJRLa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bf0wV5r4; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bf0wV5r4"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-49297fca3c2so51145137.1
        for <iommu@lists.linux.dev>; Wed, 07 Aug 2024 11:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1723055389; x=1723660189; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=odt3o15pjSSXDDe/dv4lXVLEFU6RnmQKpOxVO9YCrQE=;
        b=bf0wV5r4JA7/3Cu56S0zg00bdUylj33jFTPw61iAsVf15UHKXURBVzpFTFbjDWvCuR
         Qdf/OtvRy5/9gUppjvA7MIPZ2UVwN0OWNpurx6XuwgKg9PLxtDatuFpTv/0hah/pUFaV
         nXHWvDJ+1ODQL8WQXPFGMa2CWCQySBWfb8NepDBE/UTKxScP+xK7ZuJCynmhMbUMjC59
         KsrTavrTBhX+wnSOC1ndLwEw6yn/G0yoHVu181OcNSA4Gn2+L6RW+YN3z6RXEmlAc90U
         4GGfKEz9rrfhaXrQeNfQ5nPujpzVFCZ6vdd58vaT9y6nruifbbYYnqfO4XN2fFsGkc4B
         gnMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723055389; x=1723660189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odt3o15pjSSXDDe/dv4lXVLEFU6RnmQKpOxVO9YCrQE=;
        b=KMxF7p07nqvJikCrmGLU0VEcembadA/1j8zgPG/La+73J6XZuQ+vQt70fY7rK54HFF
         mEfxv2n73jFZcwCFiELP0X7IzDzli37Tc/CJelZ9FhPbPzCOAatktleLsJueod14lWSM
         kz+8ApoIsnVXii0QxGK/nU8TNgYLYauN2LuCUdw2F8s/pHQmlBaSK7s4HNKReba9Mjgn
         HdOIuWLPuO8ks4Vk7rQDb1iLtBfNR105dDFURK+jntRhafFM6rS/FCrv/mHaG60NudQ2
         hc7BcHu7YCFHJwZnK1U2yl8io1OGNNGHP4PrGWO3hoeWSjYKv/JxQHS9CXoyBp5FwzMX
         KEXg==
X-Forwarded-Encrypted: i=1; AJvYcCWL9g0PEWj3bclxrb1mHFuErY5IAyxHhf43XoHet9t0rm/MYACzyDnXLHha8TamPoDcxm8l8B2wAcpnhF8Lf74HkRJ7amc=
X-Gm-Message-State: AOJu0YxS09rSnMw6aw4A0AzCmdePUMyaIUL02Q3MTdCjUMCvipBTFCwX
	lmXDRrkgJbzh3DtCB8x+oQEsjI8EPoyzNUaD2ytCcq8qtCTf1u24WzEsdaJyJ2s=
X-Google-Smtp-Source: AGHT+IFEiYcBmHAQFmzO3KqZ0GqP9RwrVyw7YqKn5M7LQWcQ2LFGwqnk+x3WJQmix2QFqFcEx1zE2w==
X-Received: by 2002:a05:6102:38d1:b0:48f:cb62:231a with SMTP id ada2fe7eead31-4945bf0479emr25206185137.23.1723055389422;
        Wed, 07 Aug 2024 11:29:49 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c8631d0sm58087956d6.106.2024.08.07.11.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 11:29:48 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sblPv-003TVW-N0;
	Wed, 07 Aug 2024 15:29:47 -0300
Date: Wed, 7 Aug 2024 15:29:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Message-ID: <20240807182947.GI8473@ziepe.ca>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>

On Wed, Aug 07, 2024 at 10:22:00PM +0530, Vasant Hegde wrote:
> > Needs more words, maybe even two flags?
> > 
> >  @IOMMU_HWPT_ALLOC_DEV_PASID: When the domain is used on a device,
> >  with no PASID, the device will support later attaching a PASID as
> >  well. Some HW requires a specific domain format on the device to
> >  allow PASID to work.
> 
> I will add this.
>
> >  @IOMMU_HWPT_ALLOC_PASID: The domain can be used as a PASID. The
> >  domain attached to the device must have also been allocated with
> >  IOMMU_HWPT_ALLOC_DEV_PASID.
> 
> Why do we need this flag? Previous one is already allocated PASID capable
> domain. Is this similar to SVA domain?

IOMMU_HWPT_ALLOC_DEV_PASID is the flag you specify to allocate the
domain you will attach to the RID

IOMMU_HWPT_ALLOC_PASID is the flag you specify if you intend to attach
this domain to a PASID

They are actually different operations from a user perspective. Today
every iommu driver implements them with the same logic..

So I thought perhaps they should be seperate, at least if we get some
really crazy HW down the road the uAPI will still work. uAPI is a bit
more tricky because you can't change it.

> @Baolu, Do we need to make any changes to intel driver?

I think Intel ignores this issue, they have nice HW and their RID can
use both of their supported domain formats in all cases.

Jason
