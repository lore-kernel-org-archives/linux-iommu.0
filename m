Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F76644D688
	for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 18:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777573525; cv=none; b=m6dXa+VKFsUAiq1UDjMn9PVX2R+5aE3mG0dnDFzuI0yyM9Q8vp7ddIx8PqPeeBHjHE8lBuKOVIh17IrLc9eD/evKLmoQM80bOYRpxAzi9mYXM5BylKaongUbpEF20ck7ypKXhGAyxbXu55LdPH14+jxtTSYvB9wBw9+BFb2fgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777573525; c=relaxed/simple;
	bh=ZDryYlw3wmD6yJlXYdxSZE6y0ltm6/Y3efuvn9gp+xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQHbXsCxWZ0T/Vzf+l2yOOvtNc6hB7U3BUUyFMTWghieVV5FhmhC0GYT3XQOPuxJ9ctu5jCMsBFos0iFE4zrzAB2jA82RRpplrt6WWCv2Mx/W5+6Y5XnrWWJ39qmiqcXpOSn0EvoheCW0VFd7uLUQwXWdcEbroXHxR+dNeBTQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jjrme8Bj; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jjrme8Bj"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2b46da8c48eso18975ad.1
        for <iommu@lists.linux.dev>; Thu, 30 Apr 2026 11:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777573523; x=1778178323; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=jjrme8Bj7IDYEP00iOFn6kzVN/2/IXVAopQKAFHzt871mrE9nykpfcxWWcrvcrZ0yB
         ZP6vDl1mkKr6AGjeMr3g++EIigZ4Ysjfu3J64m0cUP5HfeZ1Lhw+m5p0bucBWYuNqkw+
         lJOReukPNqP54Ro2ftwqdYp6mm9+iPFqJAQuhVIh8X6WuBAfWcW/QNC2HddJcl6MNkVY
         hdttlZd+PdnvV1TbesoGfyiwomzqShsJiYZ2H/irbt//r2BGEbZ/MkQKYQVAcWwx5kA4
         xSmjPsQtj+lL4Rrxo2o7w+PVw3iSc2pdwmvXfgxpQNld0c3uTDCUJ86rpgnpGW5kFWHx
         xumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777573523; x=1778178323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eSG/yM4Jbprzjr8hlewRTOp1V59hFoclV98ulyGviIc=;
        b=a18s/sbjaitjoqtCZKrQvc8ZyNCKgsa/V7alTA+rFj38t9khAMLZYUwqaQKOJD71FZ
         By43rKVXol63TLSw0rpdMkZueyEZriMH9iHHBwu08sO00MyI58OA2yhhniPvKSM57E3D
         Ria8Xgl8U/jowNOTySedhUKOLHqEIFMFG6ubJB2G9XBMA2k50ku5ZwtrzUYEeCUEWIvu
         NNQ7N26md/MDOWkJpbDZJw/7a/rlV6lENiWbYQFzZ36v+/XG7rJPzgIJxUSSENEfzAws
         iPM3LcvSRJNTGaH+3h/D8qYHwy1MgXOtgEoIfw2FzJ2kJaPURd/kMR4C1OOcUlcLzAlR
         g69A==
X-Gm-Message-State: AOJu0Yy004ce5mlAvLII1OJtNasrGs5X4VXXLDMehxIfk9Q89iW5NRks
	WnrKn94pHC6hhuBGoq9GkZ8uvzwFqjCR+BIxpRv2aOUfFqtZsqj38tdO135oYuFvEw==
X-Gm-Gg: AeBDieuqBfhyHDALfIO3x+AJ+KzLOtbmqXa9GBh5oNrrWhUOhm942MIJqh9A3s50bEE
	/ymTHkc6j9KQHxOmIK8FFC2jF3YFYvSza9/3gvTSukrS5ZNzpFfY7gwe/ga6XWTkxL/x79wxjD2
	ozIin2Fmn4zEbmmJxwHpNSb+URE8IRwejKO3PdRWYmnuEd4V7Ay+Pldhh0AzZJYdC8Z0KYqbRCr
	9auCNFhOwPV6O/E4qga3LTwSpY0oeNzM/fuQdHkksRH+VWbIgYooL2r9Catr8QRIBaVszx0P+6T
	ZwpzGgicd4NulpI5Cq2pEUME7ieK87q1oeEizklS8253uSsTUfuFzIF7p4Yp5wM9wHCxdFpIIEh
	Nhldcbp0MDq9amK0FIRCMOcgABjsQJqJyjE+jk5mlo2BA5UmAVbOAniW0/9jiDvXtlWO5ulhBm4
	KyYSJLsOYPXwXRLZcodgqKh9vKI6NwOzioPMQV0zPonnpsalJ4lwfct4yAkA2CSMugVhQ7p0LxD
	99KIFY=
X-Received: by 2002:a17:903:2a8f:b0:2b4:6153:e541 with SMTP id d9443c01a7336-2b9ce26a5dcmr69445ad.3.1777573521791;
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbcaa477sm278266a12.31.2026.04.30.11.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 11:25:21 -0700 (PDT)
Date: Thu, 30 Apr 2026 11:25:16 -0700
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
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260430175916.GA13902.vipinsh@google.com>
References: <20260423212316.3431746-1-dmatlack@google.com>
 <20260423212316.3431746-3-dmatlack@google.com>
 <20260428201231.GA3885809.vipinsh@google.com>
 <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzav=dfLtdrPhkBkGwHpDAWUBMHnbGPccwhy1__doziNVZQJQ@mail.gmail.com>

On Tue, Apr 28, 2026 at 02:12:13PM -0700, David Matlack wrote:
> On Tue, Apr 28, 2026 at 1:20 PM Vipin Sharma <vipinsh@google.com> wrote:
> >
> > On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> > > +int pci_liveupdate_preserve(struct pci_dev *dev)
> > > +{
> > > +     struct pci_ser *ser;
> > > +     int i, ret;
> > > +
> > > +     guard(mutex)(&pci_flb_outgoing_lock);
> > > +
> > > +     ret = liveupdate_flb_get_outgoing(&pci_liveupdate_flb, (void **)&ser);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     if (!ser)
> > > +             return -ENOENT;
> > > +
> > > +     if (dev->is_virtfn)
> > > +             return -EINVAL;
> > > +
> > > +     if (dev->liveupdate_outgoing)
> > > +             return -EBUSY;
> > > +
> > > +     if (ser->nr_devices == ser->max_nr_devices)
> > > +             return -ENOSPC;
> > > +
> > > +     for (i = 0; i < ser->max_nr_devices; i++) {
> > > +             /*
> > > +              * Start searching at index ser->nr_devices. This should result
> > > +              * in a constant time search under expected conditions (devices
> > > +              * are not getting unpreserved).
> > > +              */
> > > +             int index = (ser->nr_devices + i) % ser->max_nr_devices;
> > > +             struct pci_dev_ser *dev_ser = &ser->devices[index];
> > > +
> > > +             if (dev_ser->refcount)
> > > +                     continue;
> > > +
> > > +             pci_info(dev, "Device will be preserved across next Live Update\n");
> > > +             ser->nr_devices++;
> > > +
> > > +             dev_ser->domain = pci_domain_nr(dev->bus);
> > > +             dev_ser->bdf = pci_dev_id(dev);
> > > +             dev_ser->refcount = 1;
> > > +
> > > +             dev->liveupdate_outgoing = dev_ser;
> > > +             return 0;
> > > +     }
> > > +
> > > +     return -ENOSPC;
> >
> > Since it is executing under a mutex, and we already failed
> > 'if (ser->nr_devices == ser->max_nr_devices) check above, will we ever reach
> > here and return -ENOSPC?
> 
> Yeah I wouldn't expect to ever reach here.

Will you be removing it or want to keep it just in case scenario?

> 
> > > diff --git a/include/linux/kho/abi/pci.h b/include/linux/kho/abi/pci.h
> > > index 5c0e92588c00..5b4c8d9e462c 100644
> > > --- a/include/linux/kho/abi/pci.h
> > > +++ b/include/linux/kho/abi/pci.h
> > > @@ -23,19 +23,20 @@
> > >   * incrementing the version number in the PCI_LUO_FLB_COMPATIBLE string.
> > >   */
> > >
> > > -#define PCI_LUO_FLB_COMPATIBLE "pci-v1"
> > > +#define PCI_LUO_FLB_COMPATIBLE "pci-v2"
> >
> > Just curious, why did we change the version here?
> 
> Because a field in struct pci_dev_ser changed.
> 
> > It's not like just
> > previous patch is working enough to perform a live update. As the config
> > is experimental, can't we just keep it PCI-v1 for the whole series?
> 
> What is the benefit of keeping "pci-v1"?
>

I don't see any benefit in keeping v1 or changing to v2 as well.

My reasoning is that before this series is merged, there is no real need
for versioning here. This is first series which is introducing PCI
liveupdate. It is not gonna be that someone has merged patch 1 only, run
its kernel and then kexec to next kernel which has patch 2.

> I think it makes sense to follow the rule we set which is to update
> the compatibility string in any commit that changes the ABI.

Okay, this is also fine.

