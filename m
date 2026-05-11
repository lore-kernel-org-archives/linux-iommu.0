Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DBE2DA75B
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778519017; cv=none; b=VCUv1oCa+DHaEs1mhzzv6U3esSboYcDuSv+vebny6MXRpBUL3VbvyDvZc9ryvKHX47cpqAZ3ul08J+uZs/jTsiyZqEKok7Lpp5kQ8lvKRBD1bQqfiiih1qM6NH2cXrj7nJ5qA/YyaI5siLHPCoj0YvLXA1YfrdnjaCjLbkMYU90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778519017; c=relaxed/simple;
	bh=gYYhWwA0hdhxCMyJA4OZinhLuWcBFzg9MbAHRNDn3xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNHNPSavqQgyDJfwqCO7dR1UgYCrpEqktMNRGSa3sbyTYokN4WEuNFMsgY2aa6NyPWFvlblKZ0K/I9QRVh84HA+Hbq9bVtk+l8WajoD/FnehVILbkYLCEOZ3hgmGd3DMEnIK2KDPJ6QL+ShGReQn1mjHUO9eD9eJuGF9tf2nwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=W69ANqop; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="W69ANqop"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8f15e900586so227488185a.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 10:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778519015; x=1779123815; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVELsMkQoZvUDxtoVm9jjibtI9kHfGwIRJ+z3Spm4xY=;
        b=W69ANqopIZTExx9CQSitlzr9ar82Frt67g7D5o6DTg6h6Un0MCaN8lvlP4T9JGepxN
         ggFsU7vHjL17iiQsmSRLIXbliWLvjLT1p/Spd09JUOBexBktHP5R9kiyTMrXo5NttOm1
         WC+xWTFws6wsqmjFcTJHbZEcvoB1thPL4xc/bn80ExZA79w50fdGQOAzIBVxBPpIvkI7
         TFPPge2LX3gd9iEs50KwV+nkrgpQw7p69KY1VoYQErXBCvgKWtQakaRvhxEuaXwXPRSX
         gQl5xC/oR31JOHpKOkxb11SuJJ+SoWv+h4ZXvyuLz5H/VN1DZGgBmwY/iKFxwNuSj/+v
         v3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778519015; x=1779123815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zVELsMkQoZvUDxtoVm9jjibtI9kHfGwIRJ+z3Spm4xY=;
        b=YNPj5K6nwIQ6Ezc0d+5qU4pXJLIFCGsq+Rzmy8F9/3nal5cdJtzbTBHpxAxVDniiEA
         ubR2UaG4uxfiG/XG2KoNKP1LQbH5ipykG/Avx7O3n6HSN8mCeB7G07Y+G+V+B06CBZnX
         jtq1dicQOcQbb7qGhqBhDkaNjEbVZg8HPApza7Gb8yXYRwu0D9XBww8yUPZ5lh/Q4W6H
         /Oh80e8MX2I3b2KA9Eimw2f+qEPYzwxC4ypyR8wETTlBvW9+L1ybwOwmoEvHfiFqtqH/
         T8bFh0ailM9iXppUsifWOcd5J5AniG05RVmVJfxE7uKFfqscoPqOn1072yHB5ccNMR5C
         hSXA==
X-Forwarded-Encrypted: i=1; AFNElJ9CMBS9nb7dXbgful51w2C958CgVNoxFtg2KByNwTOrUAIs6maNiH4bFVihPmJSyvtNEY1qWg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzjd/U4AIoqREdbVQljy/RJQaB+/r/b2CLXg99fxiTIVI3Kqwm9
	t+sKluptpRSQCe5DAXkWfvyeHTNF6NkieuH/PjVY2mPc2KJvpraWq14GnPrGyL+vVJJdyVy7oNJ
	NQDVYFjM=
X-Gm-Gg: Acq92OGTF7hF+CheicL0K3O2ZNdiZxey9icJtYHhvf9xGuSk0V/rQAvNc9KXZRT8dxc
	FLfLTloMQp5CYx3qpPjCOzRaJtUsfXhkWcUyNxJ+IbCWH0iSAeM73HptCC42YHXrp+BSgCMfUVI
	MXT1X8jPbA8aPqDTujptMh6XovNcoy73rNAGHMec/IUCy61kEWUhqj14DgSYUcHwlWCzb+iNPNV
	jhg6+be1DCyTRiS57yvexVK37O5toVk+jqiHdpS2M8UE5Q1PbTKs8/6U6bo+ctNj/W87oPKvPj3
	Hqa4z6M9Te6EjfoAyjpbO2S9T2p5T7Uf7dywW7sCJtbq2Yhyn918cQGmOM+OSslP9my4SKLgHhs
	6eo8VdOVlJw/ezHtZw4a1S9zpx4PaPv/p8hrcuDiO7m9pRLeqDwoNGDoO+Um4jJGWdrKpUl0sMn
	FBy6dFdDdA4KbluKTSFv82IIoFq2Ygb42strAOHX2xWawClW2/pM4NYndTEp5TCTPsdS1a7F5xB
	j+m7A==
X-Received: by 2002:a05:620a:4452:b0:8f6:4a8b:f75c with SMTP id af79cd13be357-904d70cd025mr3604961285a.55.1778519014966;
        Mon, 11 May 2026 10:03:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9eed0sm1117527185a.19.2026.05.11.10.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wMU2X-00000004xaq-3WhD;
	Mon, 11 May 2026 14:03:33 -0300
Date: Mon, 11 May 2026 14:03:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <20260511170333.GS9285@ziepe.ca>
References: <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca>
 <agHGaJfwPr7-F1z2@google.com>
 <20260511141607.GN9285@ziepe.ca>
 <agH-rkumGS1vX4dv@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agH-rkumGS1vX4dv@google.com>

On Mon, May 11, 2026 at 04:07:10PM +0000, Pranjal Shrivastava wrote:
> This is actually a little weird/funny...
> 
> For PF: pci_prepare_ats fails as it sees a null ats_cap (quirk applied)
>         and fails at pci_ats_supported().
> 
> For VF: pci_prepare_ats bails out early if (dev->is_virtfn):
> 
> /**
>  * pci_prepare_ats - Setup the PS for ATS
>  * @dev: the PCI device
>  * @ps: the IOMMU page shift
>  *
>  * This must be done by the IOMMU driver on the PF before any VFs are created to
>  * ensure that the VF can have ATS enabled.
>  *
>  * Returns 0 on success, or negative on failure.
>  */
> int pci_prepare_ats(struct pci_dev *dev, int ps)
> {
> 	u16 ctrl;
> 
> 	if (!pci_ats_supported(dev))
> 		return -EINVAL;
> 
> 	if (WARN_ON(dev->ats_enabled))
> 		return -EBUSY;
> 
> 	if (ps < PCI_ATS_MIN_STU)
> 		return -EINVAL;
> 
> 	if (dev->is_virtfn) <---- THIS
> 		return 0;

I would check the PF STU here and fail if wrong, like pci_enable_ats()
does. The purpose of prepare is to make the STU right, so it is
completely logical.

> Ideally, in such cases I'd want VFs to fail at pci_ats_supported itself

The quirk should cause pci_ats_supported to fail.

My observation is that pci_prepare_ats() shuld also always fail if it
cannot setup the STU, meaning the VF should do more than just return 0
since enable_ats is doing more.

> if (dev->is_virtfn && !pci_ats_supported(pci_physfn(dev)))
>          return false;
> 
> OR 2. we could have pci_ats_supported call into some ats quirk helper.

Both of these seem like good options to fix the quirk. The first is
probably OK

> We need pci_ats_supported to fail here because if we contain the failure
> in pci_prepare_ats, we'll see pci_ats_supported return success in attach
> which will make arm_smmu_v3 believe that ATS is supported..

Yes, that's right for the quirk issue.

Jason
