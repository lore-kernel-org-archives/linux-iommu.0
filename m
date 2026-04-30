Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8224014BF
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 18:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777574909; cv=none; b=HRsQyfjERhcu2pw+3tATpGW5jyoN0CNEL9Veoa5hooQ1d5o/Yw23Nk1n2f5nLe2F7SEamq91oCwyx1P12tJXevX0AZ/TX+nWMVFrYNSVoREXYjhVeSfd8epJOSYw3sux8mbNwIbMgEO7RYPtB3QDmL/v/acc/e0fgeKqcft6/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777574909; c=relaxed/simple;
	bh=oOCA6r5C2BmuUW8Nh03N3Y23igUJA/x154m57C9Gmrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLReqW2IdqoE4gw1ypp/TrHbQ7CRknLa/MeFsCJCP+8k602h/2IahojX2rO6wvdyU/ejGgPWpFd/KJC90w7M2QZslgWFFqO1hvD+AKks9hyB0ItSr9BmPt3c+Ft1Nq+I2Qct8KugXzlYVB2HWlYLA/ERt+/6PrZ2g9M5XbKlBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekMpj/XR; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekMpj/XR"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso26925ad.0
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 11:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777574907; x=1778179707; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=ekMpj/XRGbOx8tMn7dgK4jS37u8YVls+uH+fVNzou54HpXNz9mdektZ7xkcL+PYnVB
         3dDIpB1vwMtbqRVvEYmhjHgLFpeEO9W22c6qZtZLf/Y1QOaaetSz5fBTTbblYrOSt28e
         hP0GGsD4UuB9PM/IZQqlZLFaxa90099GxORc+KKkI2SY45DC7skeQh+ycGky8VENFm4n
         YwCdy6SK8jI8QIgADr9mDG4G/+f98rx70aOd/BfwhNfP5vcwsiA/pjxmVn+mQ8VjcQ1e
         2TMSwGaKwjyohde0/qZuMtkyuutpSK/1SVb5LgT2xiokxpiopIysVB9vKN7LKrCCRyBY
         dK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777574907; x=1778179707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xAzQZcfn4hf28SgvSsobLbrv7DrZRSNcDWvXS0OfYE=;
        b=qgYBcYsIB6cnPmi5fgcn1Iw9ByK5hM0YOOrbiwCqEi/B0iQvpRgbSRn78kyQ4P/qKL
         bGTHUONFT7pqtG+pAU1FBAzVzEjQ7DDvO01wRRRbmS3ICYvGj3KlcYueymvAjyWWFKIA
         2fAeR3M3ff+OpFfXL3jFpIrVwP/Xa+uzoD5H/HKqwjYIRPB2IxZfUwr9GUaT0X6AavGp
         /Gfuohydr4GMuXRIJwpdFUPiqA1X96FKdx8z/1QwkDsqzqCOkPoAnBFYNJuCsX71gakH
         fWdCuXi4AKAYOacJgYy2IwED5bj6vLXJtStnQB2eLnYcagaayPP20Enh73enu7Q2AgWz
         DhtQ==
X-Gm-Message-State: AOJu0Ywih51ryNv1CP+DL8jGhQtK+yQH5VM1XFykk7IuW1mDlXZJBCgD
	tSd3J7NtYZVaH2wvFPhSDU5PGoYGo0WzLF53rVoXLFMsbvRwnoFTR8NPG/CnbbfnUA==
X-Gm-Gg: AeBDietcDatJJqlmyRS/29y8rpvtxch2RboIaY6Y5rKwHIu/uJum3FyoWi5t40HXqoO
	woF1t0Wwa6pfg11T2Q4uIvdY+Rn1A+hSW6hdH5yxQb5/d6Ozb4/62sr4CIDxz7P0AwxRdjjXH1X
	mC51n54F/XomVVfij21U9vxFRt1ypzuIZdQpsy2Ymw713pzZQNqz/TPXoy8kOVCEf1u095pyyf7
	L+jgwXrl3LkqJERZC/Tew9uDJCkqd43DtiF9kcqe+SFbGoBkmqONvPO8+AC7OBSe9Mtz5iQ4SOR
	SzLNym+GYShDVOpLQJMH208EpCF6oP/8GFFQzQhIWOX7HccDDktOe9ahm8qGN0DpE38plTD3pm9
	AeGLIghU+TS/gmKxLQxBaCLpMCL0/jE6jd2KWOTDtIBcpn9g7ZiIeb1W23JoZ2uydtXOWBRKnNZ
	mg2Bt3edgpIOKuvC7P8mWTlOG9wxlNCsFG2f0jIgM2cC0Y9khP5Al4dVmxnCC+8FIkA0z5au8OL
	V3U3fBejw==
X-Received: by 2002:a17:903:4b4f:b0:2b0:5c88:51e1 with SMTP id d9443c01a7336-2b9cd98bb43mr418175ad.14.1777574906266;
        Thu, 30 Apr 2026 11:48:26 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e47asm3289405ad.15.2026.04.30.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:48:25 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:48:21 -0700
From: Vipin Sharma <vipinsh@google.com>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-pci@vger.kernel.org, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Alexander Graf <graf@amazon.com>, Alex Williamson <alex@shazbot.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>, 
	David Rientjes <rientjes@google.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Hilke <jrhilke@google.com>, Leon Romanovsky <leonro@nvidia.com>, 
	Lukas Wunner <lukas@wunner.de>, Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pranjal Shrivastava <praan@google.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Samiullah Khawaja <skhawaja@google.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>, 
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260430182532.GB13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
 <afFICT9mSL1XG0v_@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afFICT9mSL1XG0v_@google.com>

On Tue, Apr 28, 2026 at 11:51:37PM +0000, David Matlack wrote:
> On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> > On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > > +		 max_nr_devices);
> > > +
> > > +	ser = kho_alloc_preserve(size);
> > > +	if (IS_ERR(ser))
> > > +		return PTR_ERR(ser);
> > 
> > Should there be a similar pr_debug() in case of failure to denote that above
> > "Preserving ..." message didn't finish, or, maybe just print one
> > pr_debug() after the error check above?
> 
> Hm... I guess there could always be more pr_debug()s but I don't want to
> instrument every error path. I could move it to the success path but I
> don't see how that makes it any better.
> 

In current way, it is printing that it is preserving pci_ser, but there
is no indication did it succeed or not in logs. If we are printing the
logs then may be complete picture will be to know what is the action and its
result.

I think moving to success path or printing again based on the failure
provides assurance of what happened. If this gets printed in happy
path, then we will know it succeeded in preserving that struct on
kho.  Absence means it didn't. 

We can also remove pr_debug(), if this is of no value.

> > 
> > > +/**
> > > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > > + *
> > > + * @domain: The device's PCI domain number (segment).
> > > + * @bdf: The device's PCI bus, device, and function number.
> > > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > > + */
> > > +struct pci_dev_ser {
> > > +	u32 domain;
> > > +	u16 bdf;
> > > +	u16 reserved;
> > 
> > Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> > just change the array length based on the need (0, 1, 2, 3).
> 
> Sorry I'm not following what you mean here. What is the reason to rename
> this field and change it to an array?
> 

Having a padding explicitly tells there is a requirement of being
aligned. Reserved sounds more like don't use this u16.

If someone add more field down the line say u8, then to make struct size
aligned they will need to add another u8, u16, u32, and name those
fields padding or reserved. IMO, having a u8 array named padding makes
it easier to just change array length as per the need.

> > > +} __packed;
> > > +
> > > +/**
> > > + * struct pci_ser - PCI Subsystem Live Update State
> > > + *
> > > + * This struct tracks state about all devices that are being preserved across
> > > + * a Live Update for the next kernel.
> > > + *
> > > + * @max_nr_devices: The length of the devices[] flexible array.
> > > + * @nr_devices: The number of devices that were preserved.
> > > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > > + */
> > > +struct pci_ser {
> > > +	u32 max_nr_devices;
> > > +	u32 nr_devices;
> > > +	struct pci_dev_ser devices[];
> > > +} __packed;
> > > +
> > > +/* Ensure all elements of devices[] are naturally aligned. */
> > > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> > 
> > Nit: Maybe move this assert to be near to the definition of this struct,
> > easier to find it when editing the struct vs finding it later during
> > build.
> 
> The combination of these 2 asserts is what guarantees that every element
> of the devices[] array are naturally aligned, that's why I put them
> together here.
> 
> I can move it up though if you think it's better.

Okay, SGTM.
