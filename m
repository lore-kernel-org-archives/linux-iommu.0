Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE4B22655E
	for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750340876; cv=none; b=hIEg+lHmbw3hrykHdquLSIKW4HC2iUCz5y34o907Z2mJAeGLVRoqZZdi8yoRu85JR29G4tm6l4XV1vQXUKAFlcXQ72DqnaxaLKrA2A2rGmvq7skxNa1MA3ZDc4SS3dvCEL/xNYk7GyTNtzBtMscvqATfQ7o+le+qztrOZnydQC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750340876; c=relaxed/simple;
	bh=UYYFdDcAErhN/qN1WuDJnBpFA4QrsUpy0gQqM/MaVA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUJjep4IL2SsKtUIPap/SByp8h7vhrXNRmDd1P7yOnnKJNGkHmUfZBlrJx+5I/v2t3+TMXwhqimC6c1hP15TVxlNheuRrwkflxPl74lqTjIaRVSDBrk8mBQdM8OUyAT6OMIGGtSn9UkvFlVKrzRg9J7iTHOKMn6+VuAEdvcP/pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W6JEBjM+; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W6JEBjM+"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7c5f720c717so84809885a.0
        for <iommu@lists.linux.dev>; Thu, 19 Jun 2025 06:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750340874; x=1750945674; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GYQ/bpAI/sDBdZirKSVzCU1z9UHeGrQNsjqHwc+cPlM=;
        b=W6JEBjM+QyqNRzFel2QzpVrUWcek08iHp6XlmGvoucnrkQ9SFtISuT5rEQhRK8pGQo
         kO47GC1r5NAt6rUMe5SN/1oZ2q1V61xmUkef+5C4XP1LHKLfR0yQ/Q39/Q2npeycJcGy
         uU4HqvaOD9JkN/PJnoeOD7h5T+fjT6VkGX0UxFlTioytLycVqurOI7YmwaaQnP3SUQYT
         nDA8cRECCUeroGfywobqfbtXQSxqdrnrtMnwiZqeeFFklWan0IBLWtOgBN+eGNYs0xcl
         vDoc7J4GwKrQak8yKa+Y4Q0Sq+cm5xvUoHNZxg1M5gdWr/BWsHuIuLo4Ly78B+vg2L5K
         7TzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750340874; x=1750945674;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYQ/bpAI/sDBdZirKSVzCU1z9UHeGrQNsjqHwc+cPlM=;
        b=SESJZxFWTvUo6f0fDZGg4EZXHczKWcZ5z7XJy1jiK55rdhdBJX1AK6B/JjIh9IevrR
         TCK2SAUMOq5VOuCj2mxALvkAuzOwmMHhwJzatsKv5Ou+KX17A7g/+Y477wkit7df1Jnn
         SHEVrN9eCbd5YNa2zo63vJ1UN2NWv4rYICGaRGUF4Gdvs8shWjI96BXYz7iz9a3RlbfL
         nVw9oLKfOloDiWMnI3+Adew4yjAFbbz8FsCD8a7qcATqf3BlqOD/xBY/tU0QV5ALjDdc
         LYzHuz7MA0KAvgE7XRjcdi4vHU8h/LHvUbNfFrV5Hyi3A78dmRuOMBjcbeK1Ic2rBJas
         yTHw==
X-Forwarded-Encrypted: i=1; AJvYcCW83lRP01ZBTGHaxzZK226/DNXoq9gxKUHSTFpY+cTTxKNoFxdsgRh6B7XAofUbSL3BErWwqw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLuA3ZDN8liz8FQ9ANxsAY38DaPnQxbtaoxnWkXbtpQwEFo5NX
	Wk4xdbFToBjcQcDbguqtgf/D0vrc81qwPsPl7LQd9uhf78VaevxVmVUEiSZ6KvHO2iU=
X-Gm-Gg: ASbGncvtWboYjqQSB0GVH/4MKzeqpT6m2re22kjK5NSdC7lgjL5igYRpxgH+msF/bXA
	u8qWaI+fUCpZNuuu7Fyw8aDhngTlFNMXrsrhWeI/8xiss2aqPa2fes24gLoygCFqnI0fXIdKOTQ
	86C6LYrTZFK1sVFx37buoP/TurXsH/G8J8vEQziYnuH+4TDNYln3W4fKYK7/ag0W3xXxbE+X1Xe
	3o1hX9ZE9ENgN9B93YEA0Dg5htptMHWgPSHE2zjzPV2TewnJFXa/SXPlRqvWLpJqylkjRqxJ2Q3
	rbgjJOqGOmihHbumhc42LV/txKiLHKjSlI9uiu5aMyC4E0owP916OE5V6cwMadrfBNYXBNTKAes
	0r8IJKE4O7wI2SzRFMMOdNRTW1IolysAChHNd5H7u/LmRtBuT
X-Google-Smtp-Source: AGHT+IGKKbkBGSks/IowBLfvye5xxNHuREVlgm3Gb8+mx970WjBDJXc/75SD+rQcFO1qF/3YmiJmhA==
X-Received: by 2002:a05:6214:5249:b0:6fa:ad2a:7998 with SMTP id 6a1803df08f44-6fcff77803fmr53005146d6.18.1750340873781;
        Thu, 19 Jun 2025 06:47:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd01508c18sm7586976d6.54.2025.06.19.06.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:47:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uSFcO-00000007AG4-3E8L;
	Thu, 19 Jun 2025 10:47:52 -0300
Date: Thu, 19 Jun 2025 10:47:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250619134752.GB1643390@ziepe.ca>
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619131232.69208-4-benjamin.gaignard@collabora.com>

On Thu, Jun 19, 2025 at 03:12:24PM +0200, Benjamin Gaignard wrote:

> +static struct iommu_domain *vsi_iommu_domain_alloc_paging(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = vsi_iommu_get_from_dev(dev);
> +	struct vsi_iommu_domain *vsi_domain;
> +
> +	vsi_domain = kzalloc(sizeof(*vsi_domain), GFP_KERNEL);
> +	if (!vsi_domain)
> +		return NULL;
> +
> +	vsi_domain->dma_dev = iommu->dev;
> +	iommu->domain = &vsi_identity_domain;

?? alloc paging should not change the iommu.

Probably this belongs in vsi_iommu_probe_device if the device starts
up in an identity translation mode.

> +static u32 *vsi_dte_get_page_table(struct vsi_iommu_domain *vsi_domain, dma_addr_t iova)
> +{
> +	u32 *page_table, *dte_addr;
> +	u32 dte_index, dte;
> +	phys_addr_t pt_phys;
> +	dma_addr_t pt_dma;
> +
> +	assert_spin_locked(&vsi_domain->dt_lock);
> +
> +	dte_index = vsi_iova_dte_index(iova);
> +	dte_addr = &vsi_domain->dt[dte_index];
> +	dte = *dte_addr;
> +	if (vsi_dte_is_pt_valid(dte))
> +		goto done;
> +
> +	page_table = (u32 *)iommu_alloc_pages_sz(GFP_ATOMIC | GFP_DMA32, SPAGE_SIZE);

Unnecessary casts are not the kernel style, I saw a couple others too

Ugh. This ignores the gfp flags that are passed into map because you
have to force atomic due to the spinlock that shouldn't be there :(
This means it does not set GFP_KERNEL_ACCOUNT when required. It would
be better to continue to use the passed in GFP flags but override them
to atomic mode.

> +static int vsi_iommu_identity_attach(struct iommu_domain *domain,
> +				     struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int ret;
> +
> +	if (WARN_ON(!iommu))
> +		return -ENODEV;

These WARN_ON's should be removed. ops are never called by the core
without a probed device.

> +static int vsi_iommu_attach_device(struct iommu_domain *domain,
> +				   struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +	struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +	unsigned long flags;
> +	int ret;
> +
> +	if (WARN_ON(!iommu))
> +		return -ENODEV;
> +
> +	/* iommu already attached */
> +	if (iommu->domain == domain)
> +		return 0;
> +
> +	ret = vsi_iommu_identity_attach(&vsi_identity_domain, dev);
> +	if (ret)
> +		return ret;

Hurm, this is actually quite bad, now that it is clear the HW is in an
identity mode it is actually a security problem for VFIO to switch the
translation to identity during attach_device. I'd really prefer new
drivers don't make this mistake.

It seems the main thing motivating this is the fact a linked list has
only a single iommu->node so you can't attach the iommu to both the
new/old domain and atomically update the page table base.

Is it possible for the HW to do a blocking behavior? That would be an
easy fix.. You should always be able to force this by allocating a
shared top page table level during probe time and making it entirely
empty while staying always in the paging mode. Maybe there is a less
expensive way.

Otherwise you probably have work more like the other drivers and
allocate a struct for each attachment so you can have the iommu
attached two domains during the switch over and never drop to an
identity mode.

> +	iommu->domain = domain;
> +
> +	spin_lock_irqsave(&vsi_domain->iommus_lock, flags);
> +	list_add_tail(&iommu->node, &vsi_domain->iommus);
> +	spin_unlock_irqrestore(&vsi_domain->iommus_lock, flags);
> +
> +	ret = pm_runtime_get_if_in_use(iommu->dev);
> +	if (!ret || WARN_ON_ONCE(ret < 0))
> +		return 0;

This probably should have a comment, is the idea the resume will setup
the domain? How does locking of iommu->domain work in that case?

Maybe the suspend resume paths should be holding the group mutex..

> +	ret = vsi_iommu_enable(iommu);
> +	if (ret)
> +		WARN_ON(vsi_iommu_identity_attach(&vsi_identity_domain, dev));

Is this necessary though? vsi_iommu_enable failure cases don't change
the HW, and a few lines above was an identity_attach. Just delay
setting iommu->domain until it succeeds, and this is a simple error.

> +static struct iommu_ops vsi_iommu_ops = {
> +	.identity_domain = &vsi_identity_domain,

Add:

  .release_domain = &vsi_identity_domain,

Which will cause the core code to automatically run through to
vsi_iommu_disable() prior to calling vsi_iommu_release_device(), which
will avoid UAF problems.

Also, should the probe functions be doing some kind of validation that
there is only one struct device attached?

Jason
