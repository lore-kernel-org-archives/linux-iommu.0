Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657382F39B4
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000083; cv=none; b=Bz2+mUkF8PXHynbNnWNdToBV/ra55oUrcp3pEYWPPPV/bOYtJdn/b2EzEsm2VtBZSBx6/4MwbDMXNVjsCHrCosxYs0lV8vij0rMiLZ+OXOirkBuaWZ2u4uPVoLe+ikC4qBOJPxx9qyF+heTY30d/wtm3/Kq24EGeFuojhKQ07mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000083; c=relaxed/simple;
	bh=zcMMUMnHH7CIUa+4+Lg1jZfdooYB9e7ATSCdzCpDQM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoEKQy498tGWA+tI2oZPiC9sdCwFDkhBAfNIo/bXPC8RiuY4WAf4CU6nPKoYSlqBLRMfWS9DY5yLw+1GjH4AaDcJfCRLz6LLDswGKwckeh1rq39MzsZJZGEQjE3iWfdnfdQ9sVt3FF+a4HqUjRt7LELpgbJHEz1eJWa66d0l64w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tTZKHYSw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tTZKHYSw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so295ad.0
        for <iommu@lists.linux.dev>; Thu, 28 May 2026 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780000082; x=1780604882; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c5q3gOIhDAVqYSRxkfcmclYVTj3UlMX250M/GhPgP2Y=;
        b=tTZKHYSweYBmBQLlk7Ac0I2RutvtLaFXd88ry5jfFRM3Xft2BQ8DpF57+KFI1x20TH
         EGv0W/gFhZaPSrMO6Kr56adeXYEpYEHD0Radi2JAys6D7ldSOnB4KFYCpHMKD4ob1WIe
         EwOnKGz1AuNOKr+ZW9aaf3NOUokhiTJBpsVYC8zQhUILqWnI7xBkjQPiVnZ7CZQH/TSu
         HD7J2EvZb+wEJXuhMTFL+kLZt2Jk3+wFtSaB8CNL7MOvZOZT0dmbwLJHkWzk8bvr/vpX
         wWztrEP2mafSt1bPRhqYzXdBSkci4/TMme9q8gwEfbW1rGg0+iNNUXvbGExQqfL4izOG
         jrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780000082; x=1780604882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c5q3gOIhDAVqYSRxkfcmclYVTj3UlMX250M/GhPgP2Y=;
        b=RhfCH+Oe1LP6jXZs/KOAmuZ+As5mEZKY4k32fDYu9vCxrW+LZppkSWq4wb7L3O/b3+
         nntN7Gs95qIUt+KvL1fkQ3eidXskzmejQ/dO8N36R9YWC7BenF+yiNEShKbSfJVlPQJG
         4EmPC2dlACE5nPiymYdOQZRl1yHd+7t5R3rAWocpejM+uIMc+m07LmtaY6LdruRGvYoO
         F9Zlz8HlBTLsjNmN8NQ+h8IiVfhlgAVz+WkUMFAcsNtrcmGR65iu2EqOnM9Qk4iEX+M8
         Xejglmbv49Lhe06Hqnf+xEDBkgfPm+Xf3ss76BcXk1L2ZcdXn+/Uie2YDuWfhEgW6Htr
         2Hqg==
X-Gm-Message-State: AOJu0YzUoZJq20SWvmekCkqL4xe4Rw4FlgPmB++fcrCbaf47uhh92hME
	mC+bIjQRjWCN5+5XILTq1j+yXqMEwSPMzLnDOGNSDMzLMUD9SmdeQ7Df900TRANf8w==
X-Gm-Gg: Acq92OHl+vz1Nhe2JhuoZwTxoOnhvkE4TCajwtYeL/kZMHVcDxnkcDjk7+aBXoanY9s
	wiKWABk07MdcGfRqr72zIhWl9zoxTcw6qaypvKJsSYMg67DzasoHugHwcA51gl0iG0swKG/mryQ
	gqw7KCMgJmlUM29r1AzZpkty193LvZym6UEglASuLsoWZH4pj93D89OS0j4OZYTUg6ITCvHPp81
	7UAqBKsz+dLDqtLh/aR4cuk7m+pIOgRpK+2AJYIMPhftitHrKzZlrC0VHYn5jNpZj5e0l+/G7Gu
	QnCqnemVgcXl24pbwV0n9OFiCkH6bozJeAcqOvIFF50/Cs7F1T9rj7kcsMhtICQWg9428TpHTm3
	QKB3ws+rSzow/sIUVvtOuvA2IChuOlTO9MhG4QQBgZr5aIa66IKd7e2D7YkIP3A3DMEvUjgLGbP
	wSVes9JKYmXa/tEA0TZtOnRTIt60DXLV1eIVJ1aw8tlcRWJTFsuioG9RJhCZUBinPaUw8xRgKLb
	lsKaTE=
X-Received: by 2002:a17:903:1a67:b0:2bd:6dad:3dfb with SMTP id d9443c01a7336-2bf2046519bmr36625ad.25.1780000081220;
        Thu, 28 May 2026 13:28:01 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8572cdd391sm167499a12.0.2026.05.28.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 13:28:00 -0700 (PDT)
Date: Thu, 28 May 2026 20:27:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 2/5] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <ahilSL7sGb1pnq5I@google.com>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-3-praan@google.com>
 <ahSnLeKchpPbz1m9@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahSnLeKchpPbz1m9@Asurada-Nvidia>

On Mon, May 25, 2026 at 12:46:53PM -0700, Nicolin Chen wrote:
> On Mon, May 25, 2026 at 06:43:44PM +0000, Pranjal Shrivastava wrote:
> > While every PCI Function that implements ATS has an independent ATS
> > Extended Capability structure with a Read/Write Smallest Translation
> > Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
> > driver to configure the STU on the Physical Function (PF) before any
> > any Virtual Functions (VFs) are created.
> > 
> > Currently, pci_prepare_ats() bails out early for VFs, assuming that the
> > PF has already been correctly prepared. However, this creates a potential
> > mismatch if a VF is subsequently prepared with a different page shift.
> > 
> > Update pci_prepare_ats() to validate that the requested page shift (ps)
> > matches the STU already configured in the associated PF. This ensures
> > early detection of incompatible configurations and maintains the kernel's
> > policy of consistent STU sizing across all functions associated with a
> > given SMMU.
> > 
> > Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> > Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> 
> Nit:
> 
> > @@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> >  	if (ps < PCI_ATS_MIN_STU)
> >  		return -EINVAL;
> >  
> > -	if (dev->is_virtfn)
> > +	if (dev->is_virtfn) {
> > +		struct pci_dev *pdev = pci_physfn(dev);
> > +
> > +		if (pdev->ats_stu != ps)
> > +			return -EINVAL;
> >  		return 0;
> > +	}
> 
> pdev doesn't seem useful. Dropping it reads better to me:
> 		if (pci_physfn(dev)->ats_stu != ps)
> 			return -EINVAL;

Ahh, I missed this nit in the v5 I just posted. I'll surely address this
in the next revision.

Thanks,
Praan
