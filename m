Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B264386567
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779741029; cv=none; b=pxrJWe/JkbazQOYjCR4+xAe5hyqS7n6NM6CdFkDHPz7SLFq1HIWFI21x1JkxtTjX+qCwcoktcQnEZlVBIgc9KT3KBFzlL98PCQXdIEhHTXmKWB+y2Y6TmB4w2dqTn3Qrxjqm5veUZCNb/8lxVnL6TxPYng3jEbqbrNPDW3PrwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779741029; c=relaxed/simple;
	bh=fb1sV8f7GTFbilAJDWZVAHBiDupn0F6kRbrmdEB9hdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6scNpc0au5g9WczojpXgeB8yEiMkBg0JoKaEvOSjTOOODOfD9gGrGSK2hFIk9CeB/m/ZxVuZ9soQmWHMz5pXThMXUnNEDScBcdN18Hxr5ICTijRdYQvvDmkU2IHvEvFhco8pbxMPoU88+WG7IGlVVLYfGrO1x6kERMG+U56SRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b58IQ8lk; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b58IQ8lk"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso45ad.1
        for <iommu@lists.linux.dev>; Mon, 25 May 2026 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779741027; x=1780345827; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zWhZgy3CvZVYPvW9umuB7DRocYTW3QJrl2ACJkt8tw8=;
        b=b58IQ8lkkHYcqtTdi0dgG3tpoGHEo1qc1Y+t6uwYxKdbpoeEiXp+H9sPpvHtW+jHxo
         PklPTrknZXw2B1h2mlJSC7hzx8+3bF/oskuFNYBtkk9KxD97Dboi+vy6VwkaeSex2414
         nMPGkqVt8zVoCS4Q327Don6l1ACfcAKuDKqE0Sq2HBm9feVMEyLI9oCZEAeWjAHjOvnp
         U6GQdPHZI7ocKnsOl/A71raFB7XWqNpds+OLgx/5fK1vVhmYFAhYO/60ps3ao4SgxEix
         rpUllMaPKd9jqVxTSaMIXk3bVQva9bT6WCHQ7wsSi+b4VPVCVuTawm+9pEPyoYNhzhPc
         SKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779741027; x=1780345827;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWhZgy3CvZVYPvW9umuB7DRocYTW3QJrl2ACJkt8tw8=;
        b=f/G2zPA8NnMNjtejWh/lKDD+bm7fO3RZ/sABGsKkV6jUMRZDGRtjDCsoMaTms5iVhi
         rxmqNnFGf6r2sfd9WVgnO5d+uIxLHNlwrt8CU6zvasP64THe9wRXrote+DkDS6xgJGns
         /2i02+YN1mT3Y3IbMydvbo6YBz8vmiEUmrAflv7mcRU6M4k1UNjIOQhlzM9cMSV8dKdq
         0Lh3U2c5yLZEHOaSYJECGUfZasc+6P4j16uMktnCJORlYyGGZy9EndAbUs92ty6MHG2E
         RW0hL9yrBPr388fwJNB0IVsiU/95EDiKY7wsAC0xEzmXoDLmaeBgsIZ7vlae9m3kAwRJ
         vdwA==
X-Gm-Message-State: AOJu0YzrjYhWtlQKTRMZNZJ0F+e3J96gYmpbHLeDHPbPkJKssYsuqkbh
	8YqHjSlTTj8Lpa3+AUhWaVa+67V2+TQGXgDE1ZsVIMLCRedTQkNE4h4s+DQa0k58BQ==
X-Gm-Gg: Acq92OGzSrspjslTC+0VgPhVwEvchVz+sR2sQQPyYgh6KbUZMQWLBf2RUfqzFLT1r1j
	AIFwjNa85/JOSA1t551vW3FAD19Z/Cw+zkaFssu1kgU0k+YoYHLLxOAVKhfXETpyE9/GWVJorx1
	8PAGVRXxSA2Jx8T8FfHMkQ6JWvQ6IBkdV+Qav4VeSfrR+QUIiDcYWo/XLUMnq7E/nMQa4QBJYUr
	m611/mLpN3Xnc/0lF5CeaonEz1DkWEWuEtVjKEsDFXe9D37APDiR+ci1hgdrF6/AqwXe1zOI7BM
	lP88qFL2uULqzEwj/3+Qsmvby1upv9bb8gGTrseYcMWb8Eny8FXcMCw7LGFIRx4qitJjKg2IZvo
	zXx8c85qF7a8dNvHYjDxk+y2X1FcKMDvCoS0bv0at24oUz2hrv0K+BDLRRiQT4OyDcG+OTjR8AG
	An6Y1q/bS2+lvsUSTzIIl8y5S1sNJVOO3f5S+07IEMhp3ENCwt1shVyHDMSqfDMa3pYjEj
X-Received: by 2002:a17:903:1aeb:b0:2b4:6529:7bae with SMTP id d9443c01a7336-2bec11c2cc4mr3609585ad.17.1779741026873;
        Mon, 25 May 2026 13:30:26 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36adc0a6e94sm4597808a91.4.2026.05.25.13.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 13:30:26 -0700 (PDT)
Date: Mon, 25 May 2026 20:30:18 +0000
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
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v4 3/5] iommu/arm-smmu-v3: Fix ATS state tracking
Message-ID: <ahSxWoWd5hFvKE_R@google.com>
References: <20260525184347.4059549-1-praan@google.com>
 <20260525184347.4059549-4-praan@google.com>
 <ahSrkOv+4QZWrcJq@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahSrkOv+4QZWrcJq@Asurada-Nvidia>

On Mon, May 25, 2026 at 01:05:36PM -0700, Nicolin Chen wrote:
> On Mon, May 25, 2026 at 06:43:45PM +0000, Pranjal Shrivastava wrote:
> > @@ -3065,8 +3065,14 @@ static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> >  	 * ATC invalidation of PASID 0 causes the entire ATC to be flushed.
> >  	 */
> >  	arm_smmu_atc_inv_master(master, IOMMU_NO_PASID);
> > -	if (pci_enable_ats(pdev, stu))
> > -		dev_err(master->dev, "Failed to enable ATS (STU %zu)\n", stu);
> > +
> > +	/*
> > +	 * Any failure at this point is a kernel bug. pci_ats_supported()
> > +	 * and pci_prepare_ats() have already verified the hardware capability
> > +	 * and programmed the STU. Thus, pci_enable_ats() should not fail here.
> 
> Nits:
>  - WARN usually indicates a kernel bug already.
>  - pci_prepare_ats() covers pci_ats_supported().

Ack. For the pci_ats_supported.. since we're failing probe if
pci_prepare_ats() fails, the idea was to call prepare only if ATS was
supported [1] i.e. not penalise non-ATS callers of pci_prepare_ats. But
I agree.. maybe a better way would be to factor our pci_ats_supported().

> 
> 	/*
> 	 * As pci_prepare_ats() have already verified the hardware capability
> 	 * and programmed the STE, pci_enable_ats() should not fail here.
> 	 */
> 
> > @@ -4264,9 +4270,16 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >  		master->stall_enabled = true;
> >  
> >  	if (dev_is_pci(dev)) {
> > -		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> >  
> > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > +		if (pci_ats_supported(pdev)) {
> > +			unsigned int stu = __ffs(smmu->pgsize_bitmap);
> > +			int ret;
> > +
> > +			ret = pci_prepare_ats(pdev, stu);
> > +			if (ret)
> > +				return ERR_PTR(ret);
> > +		}
> 
> Again, pci_prepare_ats() covers pci_ats_supported(). So, the check
> is redundant. Instead, it should check arm_smmu_ats_supported().
> 

Ack, I'll add a check with arm_smmu_ats_supported

> By the way, this would conflict into my series:
> https://lore.kernel.org/linux-iommu/18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com/
> 
> It would be nicer to have an arm_smmu_master_prepare_ats() so that
> both series would have a common ground; mine would be just adding
> some additional lines if your series goes in first.

Ahh yes, I was thinking about the conflict to (I'm yet to review the
series though). That makes sense, we could add 
arm_smmu_master_prepare_ats() for clarity

Thanks,
Praan

[1] https://lore.kernel.org/all/20260519145947.GK7702@ziepe.ca/
