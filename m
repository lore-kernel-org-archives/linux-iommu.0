Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F56E1E4A4
	for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 18:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719597850; cv=none; b=nfwTVYeT14RhRbhl9O6z4xRBkt6leeY/8t8wKtuco0829ydO5PSx6W+WVFPM83yeypW2nsrzZW4PSYZM6Yg51R8MjjtrjPnRrX+usT2XAWRTiEuzbn9uQtTPGntviU+I+MCdSHfX8e8b6fzqdgv6NqTfGndf8qhQ/JOt7yKVjDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719597850; c=relaxed/simple;
	bh=3lzft4q8n9i3j4J/6k5cURCCPEnZAFAVHd/ViPhElLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LGR/Vair2m5EnBavpZp8mEpdyRhUzHyH/SvY6SK+xWQ+x+rJMsrpXucPdkDVtKU7ojcm0vdn/V6yvczTX8n+fAlSdKwkLOaVSiXPEjj4aThb45QMEDeggGZF7BnQj+lxb+HytpVtmwU14b1RYhGebwECrTA+mNrM07WEA2n2c/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HuEp2XeO; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HuEp2XeO"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79c069554f8so38370285a.3
        for <iommu@lists.linux.dev>; Fri, 28 Jun 2024 11:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1719597847; x=1720202647; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ZYiPaRVqyxaDuQUHZ3Xl3k1AiXXgY2i+KeMsta5c+4=;
        b=HuEp2XeOXDAjMkaKDogIYEyJTUpzs/rMFhdsolEhnkKMoJltZVNUGZUQqSfT+tDA5W
         a1/FHij0K4RW6L6o/N62dPDv+kwRuLPeppO80PBYc5iqbGm59xYsvaMJRjf8rxaFtyVg
         IoNPzYzevqo9yirtaFjKxJpUF/o9BfC8dqJn5HBP20LGTAVj1lwjbgMvw5CCPYqeA6Ne
         AvTUTqF/IIDfFAZ/mT3AiBxvpBFgfqkB/0m3CeSlZe9i1fLWQ+UIHDBtocOr5KqYJtyy
         1BypsomC8leQGCE2bX6WtSZNXHBg8eHIN0zNXgE9TJMoQ0+mg1qWV66VadT0ICcSANIS
         n+pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719597847; x=1720202647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZYiPaRVqyxaDuQUHZ3Xl3k1AiXXgY2i+KeMsta5c+4=;
        b=DoGnsMw6f20H1WWWy4JatvlJHMMiryCNOCxf+uW4XrDb3BeM1bpqCcrmmEigd2fGUg
         aHuF7OA1/H1q85x5gyoius/+VzgFjuN7wGs0tm4qs1S877Qc0YeG6sgtsyOJBo+pxHnn
         w+fuEWO2Yd7xGharY2EJYHDwNeWN1f2f8BTO4d275EsgUFrKUMokz+cyb8GvFFKv+RWS
         NIcbSo2LFjghnu/5vm4vFwS26V7FzdPKUYidkxM6be5uzg4d8GUHqrruVfV4QhZ96hbu
         o1irxC1NnFDwSZB27fJEbJKxuyHqR3SvBo0PafenguJT0zioSHDFKSLLdYdt5fzvQUdp
         nvoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIPZa2ddNLJ2EngxfD1RuNka52DuXPn22WcgymGVWXrXVt2kprzBbNSGU3VdNoU1kfQA+oJr9xH8O9+Lbm+90snnfxaAk=
X-Gm-Message-State: AOJu0YxIKD8/N5/Fr5CRB1iIhR/qZ6ZJsq5vTY3Zo6mtXXYNOIBiwtjH
	/GgOySioPD9n2YDfwwqUR39ILDBisS83kcFx3hBb0sLjJPPZnAjCHlBizqeRy3k=
X-Google-Smtp-Source: AGHT+IG1LURmeP4Ia6oydAVhS6inSSN08Ekrbq1/mXsq15t4f9t14XKn/iN1NJZg0Zjmirqjch+epw==
X-Received: by 2002:a05:620a:211d:b0:79d:759d:4016 with SMTP id af79cd13be357-79d759d4191mr79281185a.11.1719597847232;
        Fri, 28 Jun 2024 11:04:07 -0700 (PDT)
Received: from ziepe.ca ([142.177.133.130])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79d691a2182sm94912785a.0.2024.06.28.11.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 11:04:06 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sNFx7-0002NT-Tg;
	Fri, 28 Jun 2024 15:04:05 -0300
Date: Fri, 28 Jun 2024 15:04:05 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support
 AMD IOMMU driver
Message-ID: <Zn77FbsQWmByf16t@ziepe.ca>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26524622-971f-47f5-936e-d0173d342288@amd.com>

On Fri, Jun 28, 2024 at 11:19:23PM +0530, Vasant Hegde wrote:
> Hi Jason,
> 
> On 6/28/2024 6:33 PM, Jason Gunthorpe wrote:
> > On Fri, Jun 28, 2024 at 12:13:43PM +0530, Vasant Hegde wrote:
> >> Hi All,
> >>
> >> We are working on adding domain_alloc_paging() support in AMD driver and came
> >> across below issue.
> >>
> >> BACKGROUND:
> >> ============
> >> - AMD IOMMU HW has two different page tables : V1 (host page table) and V2
> >> (guest page table). Only V2 page table supports PASID and PRI features.
> >>
> >> - With V2 page table we have an aliasing issue. Hence we added
> >> per-device-domain-id when domain is configured with v2 page table. See upstream
> >> commit 87a6f1f22c97 ("iommu/amd: Introduce per-device domain ID to fix potential
> >> TLB aliasing issue")
> > 
> > Yes, but IIRC this is a shortcut to developing a proper packing
> > algorithm to optimize the IOTLB. HW like this that has aliasing issues
> > needs some more complex SW support to get optimal usage.
> > 
> > ie you can share DIDs if devices have a logically equivilant GCR3
> > table. Optimizing this is a SW problem inside the driver and should
> > not leak out to API.
> 
> Its not just SW issue. With V1 page table HW supports variable page size. (not
> just fixed 4k, 2M and 1G). So in terms of HW cache management, V1 page table is
> better.

Okay, that does make alot of sense.

> Another issue is with VFIO device passthrough and mixed device passthrough (few
> w/ PASID and few w/o PASID), type of domain we endup allocating is depends on
> the order in which VFIO requested for domain allocation. So its not deterministic.

Yes, VFIO is not good about optimizing disjoint domain types to
minimize domain requirements. This probably does need some more
work. You have the other problem too where if you attach the non-pasid
device first then pasid will be blocked and this is not expected
either.

> By the way, can you point me to your series please?

https://lore.kernel.org/linux-iommu/0-v9-5cd718286059+79186-smmuv3_newapi_p2b_jgg@nvidia.com/
 
> > 
> >> Please let us know which one is preferred -OR- is there any other better way to
> >> handle this.
> > 
> > Neither is really going to work. VFIO will have to assume the user
> > will want to use the PASID API and will always request a PASID capable
> > domain anyhow.
> 
> Even to make PASID support with VFIO, some way it should communicate the driver
> saying like "I need PASID capable domain". So that driver can allocate with
> right page table type.

Well, that is already implicit in the fact it asked for the domain from a
PASID capable device.

What we perhaps need is for VFIO to have some way to evaluate a lot of
devices together and decide on the best domain configuration for the
full set. It prpbably makes little sense to have a v1 page table and
then a copy with a v2 page table, for the PASID device.

> > We already have a path where the VFIO userspace can request a v1
> > domain by using the NESTING_PARENT flags during user domain
> > allocation.
> 
> That's with domain_alloc_user() API right? As I understand that should work fine
> for AMD driver.

Yes I expect so.
 
> > But I don't see any option here that doesn't involve userspace itself
> > making a request and indicating it wants a degrated VFIO
> > functionality.
> 
> That's along an option. We can explore it later.

But there is no later.

Your said your desire is to get a v1 domain even if the device
supports PASID, and VFIO will get PASID support likely before you post
your patches for this. Yi's work looks almost done to me.

Then VFIO will just request the V2 domain anyhow and you are right
back to the starting problem again.

Given your remarks it may make sense that VIFO disable PASID support
by default so that by default AMD does not have a performance
regression. You should start discussing this with Alex in Yi's series
to come to a decision. It makes sense to me at least.

If that is the choice then the idea of adding some flags/etc would
work well.

Jason
