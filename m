Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDDB365A1B
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778018815; cv=none; b=D2r6tFuHJ+JJ09pW/R31E9b42iWX7NLk+myiWtI6nsIqNoBxzesCLp/JGoTMDWG6JtZ4w7FTKGnUD1CqTwS/RHRt4+Et9OIgjEfAlRqcYDz4A0EJ4lkzUO6jTzSL4nS77EcCm4SZX6vQU3n9e14D1Pjq/0rLTO3Nn5cX6lMD/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778018815; c=relaxed/simple;
	bh=IKiTrywZnB1XM2iHoD1HYzW2ebrvVWGtwENCaikniBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxrEO6jCzlfTsIlGcpmrWp3PcOhiIuyhwz2oabfWif9bP2XplRvILzxAHRgfFP2asr7TynVJj/eMVTndFajAX/R4yh3+jGd2H2ENU0T92I6g0xODLNeWl3EAQjy83rzpkG5ZzAUIKxjT05UiGEBqbfG4R1+kDf9w1xSGagijbpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IesEe/iN; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IesEe/iN"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba180a022dso16415ad.1
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 15:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778018814; x=1778623614; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sEhVzTAP+doS3lh9CNtFPnJAX1uTaUTJFAU+QFl8Mm0=;
        b=IesEe/iNWs5DVw+EUlZMm7YzNoMQstANEFcJJaNGduGlNqwPLs1j/McxjhzbyhHQOS
         VP66YydPy801UL8Pqqi+I2uBbyXWDTd7HhgTSzEb1tYloAV7XzJqxn1vIWwfXgNmRkbm
         iVTKO3ImWw5E2cUesi7dPvy+Y2S6oOBshWEQgD+49P/r7aXO6ueVReNe0LKYqBUcbkqW
         lj4Stx+4H7SU6AhPfi8/mBBx8aGnDzCrbhZWQrrEGYuY0id9maK3WlUkEskEwlkZcC8O
         h7pqTcgvfqt4wuHbLJ/lzc7hfAqAMdX4K1KEufskrUAhx1BmfcNuBVOZe4E+eo9YTwS3
         z8DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778018814; x=1778623614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEhVzTAP+doS3lh9CNtFPnJAX1uTaUTJFAU+QFl8Mm0=;
        b=gZQYxdx4lVJuMFKs+/y64tRUgAI91SzL3218jJrx6DZqIxee94sc70fDZ3MOYWP7U0
         l4DQOFiS9w3L2Z2xNiTMPZISot2hyBfLf64CiVGBsxAJnnBpxwpEHivZqjGexy9rtNzw
         7MtX89wCPqD2WJIRyR50JkO3V1GM+yi6bNFriKMPIFDz50wNui3jc8kks0eVgi+X6VwA
         eRDnt4udq7oazNVl1JcJVcZJhgrv7psKkFNAm5eO7wNnpZSRGDHMu7WNwkwQ/oRzqrxP
         Mn0hwFxGgM3dUcfVOzfvwLFOlGDL0SUa9n2qwIUMOoyZ0h5IFb7xxROcKJxeWV2tHUSE
         vu/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9kJmIedIw85TbA3kOGT9pw+6xXOdZ82qCvMdOEU6JyU9+PsuJiXVFa/5g8loXJNTV80gOC7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwK/hep2Ik6Buzm8BEaT2I/Q6FBMqZg4dOdLBvj5VDU2EHB1uLQ
	95nS2eQL4bc35NRMNux9t/C61f/FGa4jWCZUC/7aZi5Apc7DUyzDNETLNK56A/Mw9Q==
X-Gm-Gg: AeBDieu4PX/Toyo0r8ISVJ0Q5KnrP6aPZRCbua8ZlwPJNLf2AjdzETcFXzUzqDrfIvf
	363Ttp6cyuBCy+jS7cp2MQhwc6AD9k9IgNoPwmr6IJMP9LPSkaK7uYuYSxHybZYeXPDCFkjFVod
	MmiWEGu6sbyXK9rvKv/tueZei8k2ge7YYkdER4BK+RjlFwgvNMwJfC/eUgypsrKMAAqE40zUe2f
	Y+1+FalO2aQRPYhxUzRFJZl5mmKJ9+50yB0HBacSS6X3viSXte1yXm3wzCt6ppEStzcMWLmIE3l
	bUbgQRKXz9MnMHRsYBpAnblEuusYVnVcVRsw5QgNyLkC7FdLE63Qkuy+Pt3qezu62R/H6WW2Y2F
	jKVNWVDdtJJKGnKkHu2U7r4lhS9vkw6AJ/G0KjLs+0H0FsS2HUhrigwrsD9YdQi1UKtL7OrQA9F
	iXILVLD7mfDGjCK1Ydr7yj0p+52YR1GR6UiZ87KijP8uZBo6dQYIa1dsE2kEYi5Y0pCDH7FjKGi
	/pT//I=
X-Received: by 2002:a17:903:2984:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2ba7cee1c10mr556515ad.5.1778018813064;
        Tue, 05 May 2026 15:06:53 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8242b7f54dsm218905a12.19.2026.05.05.15.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:06:52 -0700 (PDT)
Date: Tue, 5 May 2026 22:06:47 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afpp9yZS7WapVuc3@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpRUaciIEGvD3Bi@nvidia.com>
 <afpfwwmUeNbs1juV@google.com>
 <afpkuz31tGtCZ2rT@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpkuz31tGtCZ2rT@nvidia.com>

On Tue, May 05, 2026 at 02:44:27PM -0700, Nicolin Chen wrote:
> On Tue, May 05, 2026 at 09:23:15PM +0000, Pranjal Shrivastava wrote:
> > On Tue, May 05, 2026 at 01:21:37PM -0700, Nicolin Chen wrote:
> > > /**
> > >  * pci_prepare_ats - Setup the PS for ATS
> > >  * @dev: the PCI device
> > >  * @ps: the IOMMU page shift
> > >  *
> > >  * This must be done by the IOMMU driver on the PF before any VFs are created to
> > >  * ensure that the VF can have ATS enabled.
> > > 
> > > But it returns 0 directly on dev->is_virtfn.
> > > 
> > > I wonder if this function itself should just fail if dev->is_virtfn
> > > and !pci_physfn(dev)->ats_stu?
> > > 
> > 
> > Just wondering if there's a use-case that might break?
> 
> Well, even a break would be what the kdoc statement demands :-/
> 

Yea

> > Otherwise, in
> > current context I agree that we should fail if ats_stu == 0 / mis-match
> 
> Yea, should check mis-match. "== 0" doesn't guarantee the enable
> success.
> 
> 
> > > Then, arm_smmu_probe_device() must fail if pci_prepare_ats() fails.
> > 
> > I don't think probe device should fail, we should just mark that ATS
> > isn't supported for the function? right?
> 
> PF must be probed() first with ats_stu set correctly. If VF gets
> probed before that or with a different ats_stu, something must be
> wrong.
> 
> Again, following the kdoc statement, VF should not be "created"
> in this case. Or should we read it differently? :-/
> 

Yea, VFs shouldn't be created without PFs.

Praan
