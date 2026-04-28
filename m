Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D38381B1F
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777405556; cv=none; b=ugLfz1r7ST6JaWIbaK0ouutlk878cZCtN9ymdfSQV46gUjVEGbZWRXri6Azf6MLUcKaIDznA1ZUWSCedE0w7YWpeUUZ//9108UjXbKhQi72rw08KlIWVxSFV8IO5vrnGrmyiLuAgW5+Wbphznlsu6quC7Fy1Kv03suDJgiq6ytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777405556; c=relaxed/simple;
	bh=t8AW6SfVnUEhN9bd4oWyayBPAuaNupHqxJT75tRMt0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ORv5Z1inHScOyQrGLpEeMGCRu+Sll7KXmdGRwbixz97swNRKqTAr5AjnZHKWm57SHaPvmFqcWt8fLCaGlG3KEE/YWZB/FdP+yTuWxfY4q7rsA+FVR29cky+8cJut4Xz1cqz9hfnbptoc9mq5xNQFXpMRmmp/t96MP3rxWjscebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BFmS2aJw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BFmS2aJw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b243198058so9855ad.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777405555; x=1778010355; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=BFmS2aJw7pB7404wGN7zVgz68CLC/6KU1JmYnsd7goSonuKBKjCUeK2VDmgfYT200J
         fEWsyBk2J8eLmBoPXHjALxQLIdrrGxvMl16jrWev0gli54rQ/eayCEoSqwwwmLsvGsa6
         RDl5LZMOZBHR7lMGDna9w5QVISoR+SUJ5BagVVmJoHRMNjZfLwD9RgPL+kzQgsYhTFPN
         FAje6xrR2QFCFJU7ujhWwOg7nmxoLY39WoQc+66gSMLr2k2IpUkx0r4MXZW3X7pfxR7B
         6pw1zDzj3N7dwgyUQ9gnbHhkxPKM80PqyiQ2dikXopppi6RQOhSwlQZe8Rxs66mgk8HN
         NAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777405555; x=1778010355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DQ/Dt/O+th05aIC11KQd/tiOeex8kzc+/1s7j7TCtCI=;
        b=r2ZVeVp/k+ulsF9dTzkbCe2GwLHxR0rtYzaOzB2YblFC7Rm+iLSYCtsm3me37ubV1K
         RzTf1ae3HPrFQbsnViR41QbTuyFphQzXv/XtsFj41lrxKDUkhmzs6hP7Hr9OAGoLWZhp
         2eZSulPCtN6UXSqCVgR0eT/nXROQEm5xsqnf//eC9Kb5I4Of5tg2ZZFKhaohY61XIJC8
         TqEmnEcsZ7yMTsbQfoWXxYwHR4oyo7csHBBuMlfbV9jc02syNMDdqTf+cAC3nO+OfWHj
         e6EGnJcip9qIGDk/ERek1A+52JbdFWhZhRRK4q1zx3KteuYCsAcFhkJBb+gb/lqSgl2h
         2xCw==
X-Gm-Message-State: AOJu0YzGHaEKeKLQ0YAhb1j3QQzy4TEDobMy29RpNFehDt9k9dhvAbCf
	gdQaO+e+dXrpyftE84l+xsUtFXPwp9twcgV+rSb3/1/OWwJd6IEY+1e7aeoNIVTuqw==
X-Gm-Gg: AeBDieswWxDMGGXt3hu2ELawgCg/xk+N8XW9Fwrdl7L8Ap8I8ULsmqIp91Yadct8tTL
	PI/+LJvZEUBZryCJ7W8XicxWOupf6nvj7GPOiR05WtQ6rrw+Krf6mScu7V1vhGHqwidwW+sS7gq
	bOXGwrrEXtAPiJcUH+fO9zdkO3HO92jxPlckUaCkXh60Of7IDgN34Pgty+3jjCi6gPbOlf60xO2
	UgJy4YK7mx6015SlDXKlu0rNnpGKmdWO82Uu0pmUIKVg2MW4uQHcyZFOjRWlhGbxKA4o8/3dNrB
	BOkYTNzuv6Aw8gQETLtw38IfASqNNmH72VBZynrIDfT/5uyjliIvwzOqRSxrgkPKzAbJdIOofQH
	dXS1X4gAP5fs4vN4JhBO6xbJw4r+BN7wN1gMbnmmB9LMtLu7LLKDMaFMd38merYD30QR/uBav3J
	JkJ4jwrzqHZSqAkJmJZWeEHp7IeW8JNAyYqgT/HAacFhDRRMTWXKwqwiO+Zy9RcOqMD6Crq9KwD
	MyCtSIbFkmiB/MBMQ==
X-Received: by 2002:a17:902:d58a:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2b987eb5398mr770645ad.16.1777405553961;
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364a2732502sm41657a91.3.2026.04.28.12.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 12:45:53 -0700 (PDT)
Date: Tue, 28 Apr 2026 12:45:48 -0700
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
Message-ID: <20260428185242.GB3825533.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-2-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> +	pr_debug("Preserving struct pci_ser with room for %u devices\n",
> +		 max_nr_devices);
> +
> +	ser = kho_alloc_preserve(size);
> +	if (IS_ERR(ser))
> +		return PTR_ERR(ser);

Should there be a similar pr_debug() in case of failure to denote that above
"Preserving ..." message didn't finish, or, maybe just print one
pr_debug() after the error check above?

> +/**
> + * struct pci_dev_ser - Serialized state about a single PCI device.
> + *
> + * @domain: The device's PCI domain number (segment).
> + * @bdf: The device's PCI bus, device, and function number.
> + * @reserved: Reserved (to naturally align struct pci_dev_ser).
> + */
> +struct pci_dev_ser {
> +	u32 domain;
> +	u16 bdf;
> +	u16 reserved;

Should this be renamed to 'u8 __padding[2];' instead? This will allow to
just change the array length based on the need (0, 1, 2, 3).

> +} __packed;
> +
> +/**
> + * struct pci_ser - PCI Subsystem Live Update State
> + *
> + * This struct tracks state about all devices that are being preserved across
> + * a Live Update for the next kernel.
> + *
> + * @max_nr_devices: The length of the devices[] flexible array.
> + * @nr_devices: The number of devices that were preserved.
> + * @devices: Flexible array of pci_dev_ser structs for each device.
> + */
> +struct pci_ser {
> +	u32 max_nr_devices;
> +	u32 nr_devices;
> +	struct pci_dev_ser devices[];
> +} __packed;
> +
> +/* Ensure all elements of devices[] are naturally aligned. */
> +static_assert(offsetof(struct pci_ser, devices) % sizeof(unsigned long) == 0);
> +static_assert(sizeof(struct pci_dev_ser) % sizeof(unsigned long) == 0);

Nit: Maybe move this assert to be near to the definition of this struct,
easier to find it when editing the struct vs finding it later during
build.

