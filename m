Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CED33A6B6B
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 21:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777583727; cv=none; b=SrmK5Srodj9mqpsDkCvHVl/EoHLg7cvmH0kbe11KjL5IhcWfwWvjsRw9sPQXK0pwMCa8DtDfQgucQvv+fn/IUa70Shs/Z5bkbFjxNnpwYasMJO8KBg/MJqUIT7pYMBQx/fB4xl/anibMAMqlj+4Hr/Q+n1WL/UKu1M3iiIZpcG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777583727; c=relaxed/simple;
	bh=inZO7ZV0wRh5CqvM/ucg9lY2CTAYKdanpisWvC3TQ9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2HkzUprmqQudaR2FBf20ovYhxuWRx2C8HVH68CF6//fSrjihwqCyFqjQjSvX27J/dF8nluVfrEk/SRtx8a/VjeKGTNLVRV0QRD8NmnMfSNxGluRKlMRVAoICteDkPi4alAhD4ZZadcG4QnB9UkX00Dokb8O0l13fInm3wQKnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kZDDq9e9; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZDDq9e9"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d90833cacso1161426a91.2
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 14:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777583725; x=1778188525; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=kZDDq9e9thPGtK+lWIDTBtCmzShadOgydm78Q/tjmzwUvCZiHw0Cm0InjOMDOjvuRK
         7b7yX13Nvjs6hs3KZz9G/frntvz85DkWKjDvFX+wZ1NID9iy7AL8XpE/VokPf8M5UyvJ
         51VsO9QV8ZXLsAoCe43/66DHNLqnFDb4P8o19M6n6ddQl9ZAC1J8Vtu3lrmvMvLnt6MN
         l6gGapWZIIleVFVHyySougOuBWDw7DYA5kWIG1STUX47mrNU/xf+LHniAyIQK724jsRG
         e91eEO/InjxIki7Maya2QNrgRIrecFxjqhw1EoHz+P0JwgkI9Xcie0FS09mtmth3Rb+s
         rT0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777583725; x=1778188525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuRbo58QsKRQvu4meQcJrzjCe/FSskWcv20z3c8VC1o=;
        b=FDxVl1H4fDL9Y6NToUfGwzSqfkbckirlqReW92aHLNFVV3TWGKePDof6G2JzOfW3Er
         6PU3FUeCYuj0jTi/rJPcBh+XG+a3S2qdt35PG/Iiikgy+t6ztMoECsU9x/luiabocc7f
         VnH/z+BflVCk+GEfSXpkm6sXptt6chiokV1HEiVKQae0WM5Y+29up0wLQ9NdehpYxfuH
         /0GHJtf/AfCFLHJfEXazkUjfafdm1Ku4OyOGLWbTF73Wpi7eLU+m97NrglBwpoMl7zIR
         4I/rubDdMsIVpzAcwivQhDWN+AdCcDTz0+c2ZvM8iMZbmL4i5q1IQJbsrFXi2EkYQkGa
         Vpzg==
X-Gm-Message-State: AOJu0YyztTO6UUeCQhLCi6ELkao6DtSSnh9xzlse3NwgnflsqX+4K3mW
	GVJ+YMpRPi5pD4u+ObtSAeaTxmDMoyjb55OP4FRWSKuxJc9Kk57qmp3oFkBA1SZ86w==
X-Gm-Gg: AeBDies1bFI8gTbS0OZqSyfmQEeC17rO040Dbw7NJEvmo7xOIC+UbqwHBhzVMiG9M1p
	5Z9TNEasrUj7NoxPri8y0+d5fmvnYTKuhdUFdTBp9isZTvYCW/cXDv9IwBP9mVALU6k/j6XrZL8
	tvkR5E1VJxAwkANN/nuClf6Ougo8uh0NwJXzDiZjfntLavMUeZeapIZTKgyUZW0mYx/L8G0rcC0
	QP0ozK+hxFzfdaZC9aY0Ub1kzYDeTeekP6vMWdp3oUXcTKlYDsbhMJLnW0WyhP99HA477fQeFdg
	0bwcJVhIfGcRuPZkc5rESIZFgshl17CJpKOe4A9pla+nWe7b79XL18eAN6Pn2JbYrMU4fBSQPS+
	FHzibTmmz0cQ1TGVyJ+i6w3iM5+zyW7mOjY2BHHz0uCsPT3OyVo62WIrXJNTDn2sfA5JH9wBja8
	KRPavwxEpkslGxlno7eufs6ICVxAEUXmHn9ovboVMjB85aEOQhxMcjjD7z0HiRz7sGY+QcWKKi9
	xLtvFQOPEoWcFdC
X-Received: by 2002:a17:90b:2790:b0:35b:e51a:ec77 with SMTP id 98e67ed59e1d1-364c309bc21mr4610958a91.16.1777583720228;
        Thu, 30 Apr 2026 14:15:20 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ebd46484sm474408a91.0.2026.04.30.14.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 14:15:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 21:15:14 +0000
From: David Matlack <dmatlack@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <afPGYp145FbrvURR@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <afDqs6oqWlhoVqMN@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afDqs6oqWlhoVqMN@google.com>

On 2026-04-28 05:24 PM, Samiullah Khawaja wrote:
> On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:

> > +	for (i = 0; i < ser->max_nr_devices; i++) {
> > +		/*
> > +		 * Start searching at index ser->nr_devices. This should result
> > +		 * in a constant time search under expected conditions (devices
> > +		 * are not getting unpreserved).
> > +		 */
> > +		int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > +		struct pci_dev_ser *dev_ser = &ser->devices[index];
> 
> nit: Maybe we can move this logic in a separate function as down the road
> when we expand this to add VFs and Hotpluggable devices, this might
> change significantly? It's good if it is self-contained.

Did you mean to leave this comment on pci_flb_preserve() where it
decides how many devices to allocate room for?

> > +static inline struct pci_dev_ser *pci_liveupdate_outgoing(struct pci_dev *dev)
> > +{
> > +	return dev->liveupdate_outgoing;
> > +}
> 
> Is this expected to be called under the outgoing lock?

For now this API is only used during shutdown, at which point userspace
should have already been stopped so drivers should not be changing the
preservation status of an outgoing device. So I don't think this needs
to be under the outgoing lock, but it would be nice to have some more
explicit synchronization.
