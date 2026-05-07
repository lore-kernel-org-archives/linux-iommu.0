Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761036AB77
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778184743; cv=none; b=R10BCM6wvuMObRCiXBs9WTwHj/xbt5lUISzqsUz+YY7FL5Bi/7N6G/Rba51d/HAV76papls6XH8ud/mqTrqiHikoGw532tdXaF5kx2t2L3/JJSxpqoonQETnHjO46OtcS7575eQ/ZLNJUIiKiq3hHHR3Lup2A7wvpTXS85ROxbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778184743; c=relaxed/simple;
	bh=saBpaD3FYQphogaD7lBZThMVv45E7M3i+4Uxu1LH21M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0WU1Dq4NTLnbTMcpPYYEBj8uV/OTfgJDCGX85L2opqJbPe4EOI2XJXewKLe4HT1+4es0kxnm7Q6fxCIGC2BmDS+cc6j/o2ZZe1iYCFJ+xXqbFSj++zkCX4JpTquCoKD0cKFFaETIAQxmflUEjQyvo5y5KGgHXzO6Loa3tY5hv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gf6/iB7M; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gf6/iB7M"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso6765ad.0
        for <iommu@lists.linux.dev>; Thu, 07 May 2026 13:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778184741; x=1778789541; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iTBwEf5cFW2J6vKw2a1TMt4cf9FpxkIw7xjtJSL/6NA=;
        b=gf6/iB7MN7nvaLanzlI0UxXQJS4zYMU4rHHdcYtRLbHfc0D6fFcB3pvM+RS/Lz3sKh
         Z4koCI4kGb7JKpVbY6u8/lKmGwpFyPWuURwopW6eJuKoSf+irK2EcYJF33dBGDWWXUjB
         aN4ochPU88zpwK9jbpqMojLimqZuGmmhGXtkvgUYHUvLPrV+ejxgrFNkFMA3uei0xuML
         9hNgYcQfCZBlbk6fI29nSE64VJ0ZYsBTlXkAxkqD17e1LrqxuQSawy/kp14hkNOoWMxo
         5u9waB3QY1X4jXDQdBs4g0Fy2NJpE1I2/uDvdb42P+nlYKxmrfhfiBtfPAaM9glUzNxA
         unDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778184741; x=1778789541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTBwEf5cFW2J6vKw2a1TMt4cf9FpxkIw7xjtJSL/6NA=;
        b=hPVyhudOsIhhoCtlCMTn6epocVrUW7oVyl1IpOpH+nQ8DK351EhU35zdgKYw7eQkpy
         +bIhhGS/24sxNWHEepOgALv7rH4fR1AEkJR9FSzUjlgC8HTv9C8C/raz+Q3ECZmulLKA
         Q23g/Aglj54Ha8QitY8RGW0IaNqAKLah0590U2mDjxAGU5tln8EdGnxWYrEA6xMNsnqB
         Gp1+V/BIMwOCTdfdPdJ4tmqd8jBMUVgVk6vApDpcv9R166PtbKpgFvBmwmbEyRrmf2mg
         99SoIZvXQIjgMZiPSIu9JjK7B8I1v2fe7t9H/SRB2p4HoIgsordUIkI+MeQtASQidPFH
         vsGg==
X-Forwarded-Encrypted: i=1; AFNElJ+WsdOV0MYNPbZSESJLHJY66Wz6PJRkUHuHxNWU88NZodKHJxoKz20u/dUUN6SVX7zRiV/4Xw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyue29pUeKT2tk7fcQ70q3bDdOxpjj6ZPvT/a+uwKVClirwWkdu
	q+V++lqenkSeInA91j1g8kwI3jEDZzmATeEY7EQGTay+W+lc7kVzRiED1bdzCpch/Q==
X-Gm-Gg: Acq92OGeOa67WHiZ13W2uzzNDc1VJI96+Pjrzl14coYQKLnVR2HW0RVH3hwZhg/fT02
	8P3FCXjHo3/THLGXrTbkTW0oJk0jA4aOMmFDmpmeHtugUk0XvsyzJr9+1BWJY7Pdt4+icg/Ues0
	nzD/POX5DPoS22rtQHB3vB9Gk71BTtn0x6Y3b5zoYa7QU7aua2hEEr395+SkExLC77s+o7UJD9b
	be2ymo02vHzV4+nNW6EcU36iKsC89RCFro2Bn7zdRMi0TLYN7LrUSypS5peHnI5OmwDn8RjQMpH
	WKCWpWsTOpVBVEh6pn39rtKj10jo8b0P01vz/O2J3tHzVLRE4E4ejCvQK4mXVStERLYQo/L7/MP
	tydLRi3WiM2N83Ih5TI4jdSFuQ61Nj2n2ZKXENTsO7Z7NhVlE4jRupUlH6AXT5DQJCx4hXlfgG0
	txnKv+pewIbkk/Vo/7J0mGUMpLQXg90UIczNDDOeJiztIj9+DbH+FqBmt+SqHqlVkGkVKf
X-Received: by 2002:a17:902:da87:b0:2ba:f71:57a8 with SMTP id d9443c01a7336-2bae9e663eamr899145ad.10.1778184740717;
        Thu, 07 May 2026 13:12:20 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82640e84casm411522a12.29.2026.05.07.13.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 13:12:20 -0700 (PDT)
Date: Thu, 7 May 2026 20:12:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afzyHk6aQeOiMm88@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu5s1vnmZ2aEev_@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afu5s1vnmZ2aEev_@google.com>

On Wed, May 06, 2026 at 10:20:15PM +0000, Samiullah Khawaja wrote:
> > 
> > Thus, this sequence occurs:
> > 
> > 1. The Intel quirk sets pdev->ats_cap = 0 for the PF at boot.
> > 2. pci_prepare_ats(PF) fails during arm_smmu_probe_device() as the
> >   quirk causes pci_ats_supported to return false & PF->ats_stu
> >   remains 0. (arm-smmu-v3 ignores the failure)
> 
> Ok that explains how PF stu is zero.
> > 
> > 3. PF attaches to identity domain: pci_enable_ats is skipped
> > 4. VF's arm_smmu_probe_device returns early from pci_prepare_ats() due
> >   to the if (dev->is_virtfn) return 0; check
> > 
> > 5. SMMU calls pci_ats_supported() for the VF in attach_prepare() which
> >   returns true as the quirk hasn't been called for the VF yet.
> >   The SMMU driver sets state->ats_enabled = true
> > 
> > 6. We call pci_enable_ats which hits the STU mismatch (PF never sets it)
> > 7. Later while disabling ATS for VF via pci_disable_ats, we hit the WARN
> > 
> > I guess we must think about the following:
> > 
> > 1. Check return values of pci_enable_ats / pci_prepare_ats in SMMUv3
> > 2. PCIe core to provide a proper ATS flag that iommu driver can rely on
> >   and maybe define a policy around pci_ats_supported() to make sure it
> >   also handles such quirks in pci_ats_supported().
> 
> It seems like that ats_supported() checking only ats_cap of the VF is
> not enough, since ATS can be enabled for a VF only when the stu matches
> with the PF? So even if ats_supported() for the VF returns true, its not
> really supported if the stu doesn't match. And the stu would be set
> properly if the PF had ats_cap. Should the ats_supported() check for
> the ats_cap for the PF also?
> 

I think yes. We should add that OR we should be checking for PF's ATS
cap while probing VFs to handle such quirks. The main problem is that
the quirk isn't applied to the VF *before* the IOMMU attach. 

> We can check the PF ats_cap in the ats_supported() or handle the
> enable_ats() error in arm smmuv3. Intel and AMD drivers seems to be
> handling the error.

I guess if pci_ats_supported() is fixed arm smmuv3 would stop hitting
that warning. Although, I agree that we should be checking the retval of
prepare_ats & enable_ats in arm-smmu-v3.

Thanks,
Praan
