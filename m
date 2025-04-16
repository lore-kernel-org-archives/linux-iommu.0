Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC925184E
	for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744808836; cv=none; b=ioaekV5zqBrjawEMPTFSIE7yp0B526ApDYnS/+aOSeoZnXSkh6oWSf+2G/rJr5hp/oa9BmCQEmkf4i+uLijz1y9XGegWQTd4QiigBrrqCyrqbzEKcQddzRRTtP9bsNOxyF2HlUtytU7yEHSV5yAonmVKRL9aGewPaDsnRjePJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744808836; c=relaxed/simple;
	bh=ivhzV4ufct/sd/cBeYeNsxDSl3U1cXtFl/7LsCnkJ5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7tKM78RTfe3BvZQ7Vp4CwO6fN7qHRlwI5pZvE5A1fColRopObgzykfIK8+wd+hvD2ep0keDUhHpkhCGlX/LrWcuq9C1bkgvWmKlo6/P6SisR+b+85FXWTlQNSSP/pByAx8DTDXJvLWF7IZchoJcR/pBff0/yaTQJjqjsL9vvDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CrVcdyBO; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CrVcdyBO"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54b651310so895235085a.0
        for <iommu@lists.linux.dev>; Wed, 16 Apr 2025 06:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1744808833; x=1745413633; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8fYPpM9pupai6TAnp1FGBmMsxI/8khJCJ10gVtL3G5o=;
        b=CrVcdyBOViqZWZeA3bTulEYAidsz4R2bPsGeAQ7qzaXu0H67xFgycp8JZPbvVChIA/
         EZnW1XpjnNWUiucDjYZZeBxG+qjzxH/1ZH8PklaQDOf8wSyeBuxWyDATRqUstg6EuU+g
         d+n8XdwdXaCKQYDJwZle6lsmMJWtKqFhq5z8aDD6fLcgwXOJAuG0J0HTp3g7WOBFd7/n
         9reJIUmBfs8j5qS1kpsVvQayRu0JEoIgqr8OzQS68hLGLcDHrFMjBXY4mm2HCLSyxQqS
         ligXr4VNKLeRiSzTJ8JarF+N1ZJcQ6SssJtgl74tdmz2a3jsl/b3RZXi+kcf6HJfH8Az
         E+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744808833; x=1745413633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fYPpM9pupai6TAnp1FGBmMsxI/8khJCJ10gVtL3G5o=;
        b=IOR9LVWzijtHsAKsLqZdpzofWgsP4TFPKU7lLDc5NJb3QjKcxsDIg/lJodJ4VOOHXb
         1dJ6wHnqY85FD/UsgMMFUDq7tB73MwbC4kclKwHEG5RRlTD+FCNsz8n5mL8aWpNnfp5i
         1Qqj9I5wEAs3fWZzalIKnP9imQzp3UwxmP7LfQxSxUT9uP5Q4s++IYr4KPnwoP/qc1iZ
         CrEhzAUY18Wq4COh4qdDZCyMWA7ptseNWYdCYvXRQ0bu7pJfMdYOTD5rbAdE2eDvid2c
         PSjF7LAVOxoFkUfmyh9k8ZdrMkPM48VbOOJ8Rfe/ngxfLIXypSWu8+fwAs3GKy2wxinL
         f7oA==
X-Forwarded-Encrypted: i=1; AJvYcCXmFa3X422bsZEXvQ9yuUxwJxX15chhiScD0T8yZrKLAYPQ2xi71eYUju3RouwcJv7AsCJT1Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrukvYDYSedePKBdhfizgzGD28AAPQOPW3Dyk6OnOhKfE07EJ3
	BEaHTYHudZrAYo+DRS+PRCl4Tq7/X+C1fih52OtiQAui/wpNVR+cOVSHxqomGcA=
X-Gm-Gg: ASbGnctTYsPH3Q5GEZh5ehxmGR+zMdcY8MWSnNF9zNBxZaaN6bjkl8w8VbqgCXazIsE
	fxRQ2GQ/c+Rkglexods3vuzBkggZ0/LBvdEY9/SgIJh5XjAFXQx6nIVoUJPTmC/OgE7D3owjy7c
	xPZ3g0sPkdkoOy+DjPD1Xh1b6NAYzV7+gU/+7tYqoL4DefgO/RhDR73Vxs+EucR/0o5s0B1Gpua
	fwriGsnHNvGGKbj4YlHk55azQRdqfxQZavnu4p2J2/q1DmMb7VZHmnQstkcNr65akU4n9+/a2ZL
	nSapNurutsVdDOX1qJnKxLRdicSVpQIpcjgAHyhc4XXh/1xYhthGU1zXn9X48zV4iZZdh+2qP55
	x2EEak+quGr+wN7X7740=
X-Google-Smtp-Source: AGHT+IEMPrmqDk88b8NreJuNAf9MrYy1MTjVtrSah+RVEU8VfZRRdGP4phzSkayvMv5JeULVhJd5cg==
X-Received: by 2002:a05:620a:319e:b0:7c3:cde7:a685 with SMTP id af79cd13be357-7c918fed37fmr242384885a.13.1744808832479;
        Wed, 16 Apr 2025 06:07:12 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a88b6b0asm1064079685a.0.2025.04.16.06.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 06:07:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u52Tv-00000004Lxp-1Eju;
	Wed, 16 Apr 2025 10:07:11 -0300
Date: Wed, 16 Apr 2025 10:07:11 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 3/5] iommu/arm-smmu-v3: Implement pm_runtime & system
 sleep ops
Message-ID: <20250416130711.GE493866@ziepe.ca>
References: <20250319004254.2547950-4-praan@google.com>
 <Z/1MjDaAM4Em53gE@Asurada-Nvidia>
 <Z/19e4eyj1k/pqsh@Asurada-Nvidia>
 <Z_7Fx-Q8baoyzJe2@google.com>
 <Z/7dqjiVdjnoZ+2w@Asurada-Nvidia>
 <Z_-FdLizyrz2_ovi@google.com>
 <20250416120251.GC493866@ziepe.ca>
 <Z_-ikT2whG6ekqrN@google.com>
 <20250416124252.GD493866@ziepe.ca>
 <Z_-oDPaAgLaXcrfC@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_-oDPaAgLaXcrfC@google.com>

On Wed, Apr 16, 2025 at 12:52:28PM +0000, Pranjal Shrivastava wrote:
> On Wed, Apr 16, 2025 at 09:42:52AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 16, 2025 at 12:29:05PM +0000, Pranjal Shrivastava wrote:
> > > On Wed, Apr 16, 2025 at 09:02:51AM -0300, Jason Gunthorpe wrote:
> > > > On Wed, Apr 16, 2025 at 10:24:52AM +0000, Pranjal Shrivastava wrote:
> > > > 
> > > > > Also, this would mean that we'll have to take care if the Guest Kernel
> > > > > ends up touching the mmio region while the SMMU is suspended?
> > > > 
> > > > I think this is approaching it backwards.
> > > > 
> > > > If power management is supported then the power should be on unless
> > > > the VM has activated its own virtual power management. VM virtual
> > > > power mangement would flush the cmdq from the VM side then signal the
> > > > host that it is OK to power down the SMMU, which the host may or may
> > > > not do
> > > > 
> > > > It doesn't make alot of sense to power down the SMMU while a VM is
> > > > running...
> > > > 
> > > 
> > > Exactly, that's what I meant to convey..
> > > So.. can't we simply take a ref as soon as a VM is created (IOMMU is
> > > assigned to it), maybe from somewhere like vfio_change_dma_owner and
> > > keep things powered on? That way we keep the IOMMU powered ON if it's
> > > controlled by the userspace.
> > > 
> > > This would also allow us to only care about the host-managed queues
> > > while suspening because we'll be sure that if we are suspending the
> > > IOMMU, no VM is active.
> > 
> > I thought we agreed VFIO already would need to do something to keep
> > the power on as it can do DMA at any time?
> > 
> 
> Yes.. but if that's the case why are the Guest-assigned vCMDQs coming
> into the picture?

Don't know.

But the vcmdq's are used by the host too..

> I assumed that there's a situation where the VMM doesn't use
> VFIO and only uses iommufd to assign/configure the IOMMU, maybe we'd
> need to get a pm ref there as well? Is that the case?

Right now you can't reach the iommu HW without a VFIO, so that path is
closed off.

> Please tell me if I'm missing something? 

I think the issue here is the host operation of the vcmdq's
itself. They need to be quieted just like the normal command queue

cmdqs that are assigned to userspace can be ignored, but the upstream
kernel does not support this yet.

Jason
