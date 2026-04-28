Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE8F37E2E2
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 23:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777420305; cv=none; b=iJF7sZ1RzMo+POzyyIUTomy1jyVldKPEwibC18FJbimtGkMQ7KTTA00CRwFT0hV5yeO+ZtBOdGMlehY2S8RQZ1nayzj73fHkRKia3a3zbE7dT0MNKDMt/CRzDb2yQoaSb6WPaWJMXPxYVYEBPe6qm8TfYWjshBd6e+M1DHSIQ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777420305; c=relaxed/simple;
	bh=PzrGjnYnqw4935qMxbE++jGJcpzbiv9Qu385mNo68Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PPrFQAisyB/QqJVt89o+6bhspZb/nLGV9WB5vj2/guM9TeZn+JUWAihL/t7N4GrKw9eoNiX1WA+1L6nF7FjqiWKBfsht2z7xxOaDEJ4TDq5ITcR0OwjN49MTUEL6tNOYb/8lEsQS8RKQgMPkYc8i10Cla085a2Zs4qykOcX3AM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jg04sL3y; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jg04sL3y"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ab077e3f32so52325435ad.3
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 16:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777420303; x=1778025103; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=jg04sL3yRdVXm25n4h6Yv1hcS1O/IvnIMyjkdmU0EpASrFXmqoic/eH8yLGarP074d
         rPRHEViUZ7l0cvPHpmfYlCFkrsbcjlBXh4iEaBCDCXzLWz1nEH+o4OLEzJXj6F/lJN5I
         yIEMIzhLJLNO3FMB3GOHQhNlvM95/rkuXCXFK+MGfGMTi/aZ0T59XxB0xFWeUM+eHien
         KRB86nMc9JaAgaQCesrJdZq8pIVrmFyoPHTb1noZfM8hrO6qZsRv9sTRsYpXpq7ure8g
         7nVhSYHBL/d5kWhfyOsFxhx2/IqGXw6O/46rRLfux/HPPh9LmpUSypVmrJyw2J6hD0ih
         CJGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777420303; x=1778025103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=in+mysCXNp4IJcp8wpKV/ePcsC7P4CQwStR4ajhF2Xo=;
        b=BhQsVMaqy+3K5mwDD7ewpChq+1UxaL3j/tV3T4in8tCVL8le0TLyp1DARWnWIL5WQ8
         ix9U9DcIE5hOkILvCpPCRMMhta1gjAARCHkAMuHZDgqm1D8K9wlnbLVAHxmgftnh5xxK
         QDu2byrJY1nNfAnH0tD0woiWsdTjphuT+bXAg8bBg5tjHLG6UJL45y2H2/PSQDLxmLU9
         x8/KLlUWf/rZ6aZvrD8gve0RFvhqrwvr0uHY86maCXeNB35G/MG+MQ9wwP/Vfb5MuQzG
         QbZ8cKqm3Y1z4FUiPypH5khs7MjM69zfznsWka6priW5GPpgfUPenmbFN/mvkCEZSv1a
         Ib+A==
X-Gm-Message-State: AOJu0Yyr41GnB7OACZ3SaT4tKSx7CgNOTleL03rMqmuqNndnNZ3+5EVA
	XN2IH4vUnmPwvO4Guo2vKWecs1+UgBpR7CRQjvhvAz85YPsPC8Jpc7MNyne8IIhCJw==
X-Gm-Gg: AeBDievWmAO5P8fry4zOoWnaw1zM4YSVJ/knAwa9nn8tf1rrsneSB1d7tRsCkMu0QT8
	4dFFEq3VqqSlmF9syG6jb4V2hyOL8OCPi6gmilw40EGCCriU1EwM8sTfSbNaMpHRPATwm9N91TO
	JzrRF1fLpWGzgzeO9TViTet7hiVxk3OUQeI4IsawVOOu7ff/wJ5iPI32Vj4Xo3KP2yCeqtOOvQa
	FshWm+kTweb+6UoUlBemPddqT0vG6BHyYMfoVSknnuPlD012iz1CKfDZON0bDlBLmrmvuxP2z9S
	0d3t0M3m4XGr73sB+urO/fMx+Fx4XFz074fS+CG0Sz76QhqI1Ag5uZxLKBJoL7JmQBlcDNEhPMi
	BCtY0nBdgJM5niv47dXYS9FAUqgnqU20Wx07QEJwUhnTHNLsEM5G2b3jgeKKDuyhGZ+3xoEOSMK
	qZ3GMMbSQUlyaM2xKLsjkQsaSHBhsWyfzUO0ctEBdvFAMKlHi/0CSi36DyyWLyBFjHTQQxQiiI2
	MkeDw==
X-Received: by 2002:a17:903:a90:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b97c4c8995mr46570035ad.27.1777420302688;
        Tue, 28 Apr 2026 16:51:42 -0700 (PDT)
Received: from google.com (76.9.127.34.bc.googleusercontent.com. [34.127.9.76])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98859f629sm3480345ad.0.2026.04.28.16.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:51:41 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:51:37 +0000
From: David Matlack <dmatlack@google.com>
To: Vipin Sharma <vipinsh@google.com>
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
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <afFICT9mSL1XG0v_@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
 <20260428185242.GB3825533.vipinsh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428185242.GB3825533.vipinsh@google.com>

On 2026-04-28 12:45 PM, Vipin Sharma wrote:
> On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> > +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> > +		 max_nr_devices);
> > +
> > +	ser = kho_alloc_preserve(size);
> > +	if (IS_ERR(ser))
> > +		return PTR_ERR(ser);
> 
> Should there be a similar pr_debug() in case of failure to denote that above
> "Preserving ..." message didn't finish, or, maybe just print one
> pr_debug() after the error check above?

Hm... I guess there could always be more pr_debug()s but I don't want to
instrument every error path. I could move it to the success path but I
don't see how that makes it any better.

> 
> > +/**
> > + * struct pci_dev_ser - Serialized state about a single PCI device.
> > + *
> > + * @domain: The device's PCI domain number (segment).
> > + * @bdf: The device's PCI bus, device, and function number.
> > + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> > + */
> > +struct pci_dev_ser {
> > +	u32 domain;
> > +	u16 bdf;
> > +	u16 reserved;
> 
> Should this be renamed to 'u8 __padding[2];' instead? This will allow to
> just change the array length based on the need (0, 1, 2, 3).

Sorry I'm not following what you mean here. What is the reason to rename
this field and change it to an array?

> > +} __packed;
> > +
> > +/**
> > + * struct pci_ser - PCI Subsystem Live Update State
> > + *
> > + * This struct tracks state about all devices that are being preserved across
> > + * a Live Update for the next kernel.
> > + *
> > + * @max_nr_devices: The length of the devices[] flexible array.
> > + * @nr_devices: The number of devices that were preserved.
> > + * @devices: Flexible array of pci_dev_ser structs for each device.
> > + */
> > +struct pci_ser {
> > +	u32 max_nr_devices;
> > +	u32 nr_devices;
> > +	struct pci_dev_ser devices[];
> > +} __packed;
> > +
> > +/* Ensure all elements of devices[] are naturally aligned. */
> > +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> > +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);
> 
> Nit: Maybe move this assert to be near to the definition of this struct,
> easier to find it when editing the struct vs finding it later during
> build.

The combination of these 2 asserts is what guarantees that every element
of the devices[] array are naturally aligned, that's why I put them
together here.

I can move it up though if you think it's better.
