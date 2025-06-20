Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C6727FD56
	for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421113; cv=none; b=ZB3IeNp1RBFScG2jHGdEHqccZ+lnSk38obqIP+OvDbHXPmew8glJMpFXbyzDyp7Z3AYW3m/zhUU5yBSeyAjTuFXjKVqKtQH14W5e4HuWhc17eQtwnC7cjU2NeFZuYmAj8P7Txyr0ipV6O8mptjIuKio1HQ2wzMDpn6ZG6RCWzXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421113; c=relaxed/simple;
	bh=jsmOaERJJJU+XCJVI4JWcgqpWpirMEBecRWGeNiANCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWeGsAd8OdAlySsvdHenGD5sd4auMkzXJHip1YQ9MrU3Cj5VKJqBKYMqIpW8TJtYClMkpZXd+BuLC01PF5q9HgCOF1Inz0NfBhRqqCFDOk+GzJ4jiQj3nbtLJR4OhPGHJs4DPtcdAbrEbzeSwXF35Avo0TcrtB7+aqf/WeAhgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Z3luOjKs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Z3luOjKs"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso16263266d6.0
        for <iommu@lists.linux.dev>; Fri, 20 Jun 2025 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750421111; x=1751025911; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iKSU6GlAD0b+reZYhRj4iOMFyn23zu+YAR94aAzdOEg=;
        b=Z3luOjKs5xNpoS3ur5G2jDlangry3tAYbkjVU90bnH2LbNoaauF8vQSVo+ScL1AjPz
         6FZSydBOK8lrIRMVYBAmok26E9uNaDiw1vWpNM9WDup/OTsH7N6AQ9uJPDivOkmJwVDw
         v8OQS4FKCDwI10pG4beKt63JjG47yOLrXcnkxBNliCmUKzBwZrFdW1LC09Txko5kz/jU
         AneQmVpr0YsymHFcuqRQ1nVK7bgnWl+BjepcxjG5Iz6NSlNlU+BTND/THJ46I2YzTB9V
         +uiNnSPMN5xFGGB0cbNl280JFrVrHM4gDH/JklSfclymV0y/WaolbUFY6R9Cl1h7pAnO
         C8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750421111; x=1751025911;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKSU6GlAD0b+reZYhRj4iOMFyn23zu+YAR94aAzdOEg=;
        b=BxKjGR17NcJnzV22gQdPpCKVmJbJuyhb6ThO9LVlVwS730ydM7fN6blACrMndN5IcV
         Et6UTCHMZrN3mmwyWLLnUVsxe3NNB0o+UrfV28N0yRGs9z2JAM8CYenzhSNDM62spKXs
         DPQ3jrlWls9eAiE+I1OYQYYk5ntQw54yLzJiORct4BoTCLrlyQ0AZN/pf8Y/brtK7+In
         7iKBmAcZfh6GWNmkWLKzsMkBbHHkZSGhP6dU+t4Tjy+cigKhXG+7w1xvMllNYf21i14l
         Hhpy4NxOV4yr5ZEpu16RSm1pZd2aOCHPa6MEjoZq7jYqDepZc0pQSLBxqw5WMqBzQfOM
         +qjA==
X-Forwarded-Encrypted: i=1; AJvYcCXC417MXW6f8k8ln4y1SCxWSrBR5X4H5uHY5iXS+IV/wiBy+m1gMH3l5fAlddf1cjp2+LEdnw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw77iJ+BuKiyY0swttHCRR4RUTU/v4bFA77D/ZbnQwlfyShYOgg
	3wMbAkP/9H571u3nS0Fu1jpXNDZJZeZW6Wgcceh4h8rgt7fF/iMY+ZIaRkVSUOPK1Dw=
X-Gm-Gg: ASbGncsCdworNZiYgxNrkD7e9vGqqRUM04hAlAM3EyMQd0R8yYIqz1HkL67slzJLEPJ
	xvvb6c98O4idRl3U5mOFLh+CqoD/UT2s9dWHKoDkikdjiOIBmJwTqtsB0KEJqaHS/RGYje31N0c
	U6NAOicERu5F4DBGoM1Z873pNmff7efdvjTfeVccxND2hr5YqqQC6eDZSmwGFyWCObFXi8UAv3r
	iMw1wpunWIcgplC2AD0HihPcWvnSZAWdb/LPrRvtPG1hcP1Tz8WPHdi2xMh3ntWWqsEqoXQ7vF/
	e9kMvZb3weqTUbaH3e1xXi2Pso3c0jaqU+ASf4WsFEZDP0w3apwhFV71T08coOmKC+pJ4MkIC9X
	O36gHRyw4VoFSGLvjyLe1rrrylxnAY6JQo8Ln7Q==
X-Google-Smtp-Source: AGHT+IHfu4I3beDwgjtHUIfD6yuQvdS/JqKOrGvhTdy+iUwvWk3om69mhib1iCashING8Al0Lp0xvw==
X-Received: by 2002:a05:6214:1d24:b0:6fa:c81a:6202 with SMTP id 6a1803df08f44-6fd0a58f236mr37698336d6.29.1750421110649;
        Fri, 20 Jun 2025 05:05:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd09576766sm11104646d6.81.2025.06.20.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 05:05:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uSaUX-00000000Dmo-1ZEQ;
	Fri, 20 Jun 2025 09:05:09 -0300
Date: Fri, 20 Jun 2025 09:05:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250620120509.GA39770@ziepe.ca>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <20250619134752.GB1643390@ziepe.ca>
 <073ffe14-d631-4a4f-8668-ddeb7d611448@collabora.com>
 <20250619165928.GA10257@ziepe.ca>
 <e034a111-93eb-42e8-a533-46553b4f5588@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e034a111-93eb-42e8-a533-46553b4f5588@collabora.com>

On Fri, Jun 20, 2025 at 10:57:49AM +0200, Benjamin Gaignard wrote:
> 
> Le 19/06/2025 à 18:59, Jason Gunthorpe a écrit :
> > On Thu, Jun 19, 2025 at 06:27:52PM +0200, Benjamin Gaignard wrote:
> > > Le 19/06/2025 à 15:47, Jason Gunthorpe a écrit :
> > > > Ugh. This ignores the gfp flags that are passed into map because you
> > > > have to force atomic due to the spinlock that shouldn't be there :(
> > > > This means it does not set GFP_KERNEL_ACCOUNT when required. It would
> > > > be better to continue to use the passed in GFP flags but override them
> > > > to atomic mode.
> > > I will add a gfp_t parameter and use it like that:
> > > page_table = iommu_alloc_pages_sz(gfp | GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);
> > This will or together GFP_ATOMIC and GFP_KERNEL, I don't think that
> > works..
> 
> I have test it, I don't see conflicts or errors. What worries you ?

Just looking at the bitmaps I'm not sure? Did you run with lockdep?

> > > > > +static int vsi_iommu_attach_device(struct iommu_domain *domain,
> > > > > +				   struct device *dev)
> > > > > +{
> > > > > +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> > > > > +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> > > > > +	unsigned long flags;
> > > > > +	int ret;
> > > > > +
> > > > > +	if (WARN_ON(!iommu))
> > > > > +		return -ENODEV;
> > > > > +
> > > > > +	/* iommu already attached */
> > > > > +	if (iommu->domain == domain)
> > > > > +		return 0;
> > > > > +
> > > > > +	ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
> > > > > +	if (ret)
> > > > > +		return ret;
> > > > Hurm, this is actually quite bad, now that it is clear the HW is in an
> > > > identity mode it is actually a security problem for VFIO to switch the
> > > > translation to identity during attach_device. I'd really prefer new
> > > > drivers don't make this mistake.
> > > > 
> > > > It seems the main thing motivating this is the fact a linked list has
> > > > only a single iommu->node so you can't attach the iommu to both the
> > > > new/old domain and atomically update the page table base.
> > > > 
> > > > Is it possible for the HW to do a blocking behavior? That would be an
> > > > easy fix.. You should always be able to force this by allocating a
> > > > shared top page table level during probe time and making it entirely
> > > > empty while staying always in the paging mode. Maybe there is a less
> > > > expensive way.
> > > > 
> > > > Otherwise you probably have work more like the other drivers and
> > > > allocate a struct for each attachment so you can have the iommu
> > > > attached two domains during the switch over and never drop to an
> > > > identity mode.
> > > I will remove the switch to identity domain and it will works fine.
> > You'll loose invalidations..
> > 
> > Maybe the easiest thing is to squish vsi_iommu_enable() and reorganize
> > it so that the spinlock is held across the register programming and
> > then you can atomically under the lock change the registers and change
> > the linked list. The register write cannot fail so this is fine.
> > 
> > This should probably also flush the iotlb inside the lock.
> 
> I will try to summarize:
> in vsi_iommu_attach_device() I should:
> - take the lock
> - do nothing if the domain is the same.
> - if iommu is used (ie powered up):
>   - update the registers to enable the iommu
>   - flush
>   - update the link list
> - update iommu->domain
> - release the lock

That sounds believable, yes.. Though can you do the "powered up" checks
inside the spinlock - are they sleeping? Can they be done before the
spinlock?

> in vsi_iommu_identity_attach() I should:
> - take the lock
> - do nothing if the domain is the same.
> - if iommu is used (ie powered up):
>   - disable the iommu
>   - remove the node from the list
> - update iommu->domain
> - release the lock

And maybe flush too? How does the caching hw work at this point? You
can't have stale entries in the cache when you switch back to an
enabled/translating configuration. So either the HW flushes implicitly
or you need to add a flush somewhere..
 
> vsi_iommu_suspend() and vsi_iommu_resume() will also have to take the lock
> before calling vsi_iommu_disable() and vsi_iommu_enable().

Yes, if they use iommu->domain that seems good

If the above locking is a problem then I'd use the group mutex instead
during resume/suspend. The attach functions are already called with
the group mutex held.

> Do I have to switch to identity domain in vsi_iommu_attach_device()
> before applying the requested domain ?

No, that is what creates the security problem. What you want is to
update the HW registers in a way that the HW just changes hitlessly
from one translation to another, then flush the cache.

Jason
