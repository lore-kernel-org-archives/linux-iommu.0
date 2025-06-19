Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7628C2B2
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352373; cv=none; b=XVA7jkB37148DVUBa9JbdhspIP3f2WUieF66775CiNzCe6fxPJEuuuNKoysoamdJZJ+MQ0325ccYo4uOVcNzQ+IxVqbTpVD+Gc0J31u70HaSRZl9tAzx5L0jmJzfrtit51JHaYXcyOM5fqsUZRqtyDYFgI6Ajp24P+4Yc6um984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352373; c=relaxed/simple;
	bh=uHeSXjDfXn7lYF+oBRLTKymZl/nezk6X31UcWI8RzH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvzF4AK6I21C9piPkU/ut2t1CVCWgJ3AeTwGawCrGc0Dq3sk+3BBOESaePWce7lC3pH8OAN/EB6hmNzZ4ZVsOg3xriC4fYdN9Q4exNx1bv0IXw5BB4iaK4gbWE2Y1rsb23fjAD8Ls921W1z+kPynk692YTZS4/eR2bsQkKl6FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ZTFYCnJ4; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ZTFYCnJ4"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-73884ccffcbso806054a34.1
        for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 09:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750352371; x=1750957171; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WU789LESDPx6spX9Gu45wOPXnZU17iFeIzBAgdevUwE=;
        b=ZTFYCnJ4KEZyEGJtghyYTXq6qJ8mzX2RuaJJYWpI20+BIYRbhZUPH0OPkSmckmkN/V
         23M1bMS625j4ls2GZtilQ0EMszYObMohrdv+4LlxbF2Qs1RUy8fXCM9WE23G+8biQ44A
         KzCOImOOw+bgYwO2UiGzWGFOH0qgvDl5rLrxE4iqnMDzfYDmAGSf9ry1mP1P0kyAbFjr
         etVcJbtGAqMZTJNVR8esAKKVmgpQHVAW3rrzYF9ymz5yslSuPN8fhO3kmLlq5E0rj+kS
         XyuzdqL4qmYg/wZisgKsqlT4Wl893sXcB5qF36RTwLG66q1YWJ/b7KhbsWLMw/pkVpYD
         gIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352371; x=1750957171;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WU789LESDPx6spX9Gu45wOPXnZU17iFeIzBAgdevUwE=;
        b=CLY9RPIBUAu1fwzi/+uHZ2Ad1N1CCt8hyFCxqbx1wsy28xnx04m85OQGniuSnRpNtY
         1jkjujOUj/8BfGBmRDTHSCF1FTi3X7wC1OVOL5JY5RzOPVHhveRv2ef/GlCPM64dl9aJ
         C6JLXiFir8diLKZTyK2T7Jcbolg8nN7+1oMGWKNdbtSeUlHNORLglagmjdmyh8RQnJcm
         vYz9M8jtfCH8CvnURvAUZ7s/p5PA6DkzOTIvTMzlsbx3s6vhFez4H/iLN5y/XJo85hWZ
         D2QRbe280mJ5zvQRznGsgSFXu+nBGUOt4cqmZh/f8k8s3GZJxXVd6fRITYoNqG/3wSW+
         nspg==
X-Forwarded-Encrypted: i=1; AJvYcCU2gCFNsqO/OhGWBuBDKRHUPfsrRqacrdbRQiITl+cgt570LXDLlSopQeBvClh7WWOVPQ9NJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwCucoQUGxCplPxAkIR7n4zQdHePzYtjVbXgOKUwdHzB4KwzQbW
	Tu1bPM9nUNsXzJmcQF+4CuNoXLSn31IzXZxQv0ovuSWJTNPl0i6m63fr6Wjo8V+PkUc=
X-Gm-Gg: ASbGncsYe3y2W+ChIIIXgsgaxIisgRhXtZ77Dbj0PofYbnYLoRpIxINnN44PIsF6ga0
	pGKdyGX8BQdbP5cOq48CAQZXtY5Wzh8kyiMkMZUINd4kNzr52LocA3nN0Y8C6DoYrMKPKfAdsgS
	fRoP3zCyDez5ONBopEU5vIwxP736vSPkHvm+AkI43AoKqmNEjXRWN2+Bu92IYv5uPuVWPH4Kv/T
	Xu5PvAqEPb6W+sIuy5vDu3LMoUSCxiDKJZiGemR8E8jJHkscSMpAvuEGhoEjgHHwCGQpuz0OGLB
	S1uPBrfJSYUu5SwE4Sm9jbRg0VrxQ/hFUejK
X-Google-Smtp-Source: AGHT+IFIVSAeEPqWaR7ouc36Dp5BIP5quliMTNtM08oDDkQu9GEu/sRTek8upP25DBEtFCz1lvvpVw==
X-Received: by 2002:a05:6830:6c8a:b0:73a:8a8a:5151 with SMTP id 46e09a7af769-73a8a8a5334mr1331051a34.17.1750352370711;
        Thu, 19 Jun 2025 09:59:30 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a284ff5f4sm2339324a34.43.2025.06.19.09.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 09:59:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uSIbo-000000003GJ-3nRB;
	Thu, 19 Jun 2025 13:59:28 -0300
Date: Thu, 19 Jun 2025 13:59:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250619165928.GA10257@ziepe.ca>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <20250619134752.GB1643390@ziepe.ca>
 <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>

On Thu, Jun 19, 2025 at 06:27:52PM +0200, Benjamin Gaignard wrote:
> 
> Le 19/06/2025 à 15:47, Jason Gunthorpe a écrit :

> > Ugh. This ignores the gfp flags that are passed into map because you
> > have to force atomic due to the spinlock that shouldn't be there :(
> > This means it does not set GFP_KERNEL_ACCOUNT when required. It would
> > be better to continue to use the passed in GFP flags but override them
> > to atomic mode.
> 
> I will add a gfp_t parameter and use it like that:
> page_table = iommu_alloc_pages_sz(gfp | GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);

This will or together GFP_ATOMIC and GFP_KERNEL, I don't think that
works..

> > > +static int vsi_iommu_attach_device(struct iommu_domain *domain,
> > > +				   struct device *dev)
> > > +{
> > > +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> > > +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> > > +	unsigned long flags;
> > > +	int ret;
> > > +
> > > +	if (WARN_ON(!iommu))
> > > +		return -ENODEV;
> > > +
> > > +	/* iommu already attached */
> > > +	if (iommu->domain == domain)
> > > +		return 0;
> > > +
> > > +	ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
> > > +	if (ret)
> > > +		return ret;
> > Hurm, this is actually quite bad, now that it is clear the HW is in an
> > identity mode it is actually a security problem for VFIO to switch the
> > translation to identity during attach_device. I'd really prefer new
> > drivers don't make this mistake.
> > 
> > It seems the main thing motivating this is the fact a linked list has
> > only a single iommu->node so you can't attach the iommu to both the
> > new/old domain and atomically update the page table base.
> > 
> > Is it possible for the HW to do a blocking behavior? That would be an
> > easy fix.. You should always be able to force this by allocating a
> > shared top page table level during probe time and making it entirely
> > empty while staying always in the paging mode. Maybe there is a less
> > expensive way.
> > 
> > Otherwise you probably have work more like the other drivers and
> > allocate a struct for each attachment so you can have the iommu
> > attached two domains during the switch over and never drop to an
> > identity mode.
> 
> I will remove the switch to identity domain and it will works fine.

You'll loose invalidations..

Maybe the easiest thing is to squish vsi_iommu_enable() and reorganize
it so that the spinlock is held across the register programming and
then you can atomically under the lock change the registers and change
the linked list. The register write cannot fail so this is fine.

This should probably also flush the iotlb inside the lock.

> > Which will cause the core code to automatically run through to
> > vsi_iommu_disable() prior to calling vsi_iommu_release_device(), which
> > will avoid UAF problems.
> > 
> > Also, should the probe functions be doing some kind of validation that
> > there is only one struct device attached?
> 
> which kind of validation ?

That only one device probed to the iommu?

Jason
