Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CBE31717D
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927242; cv=none; b=JrC/Y4Ec5vkjIGOcGU2St8XVbOGqycv7KRc2xAPFslSbNRp5SWj516WrPp3qcgR/uh15ZXj6BTARoHMsoGDlHUBmZWusHTx2SzSIvrt4Cx+UjMHW+TD3TCK90Omy558sIsU9JZvLJUflU77kk1DbOU+UqlSTzSz4IseEvahmkrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927242; c=relaxed/simple;
	bh=F34Beg8R0RuDCQeBJnBldXOK1T/053KKVu/CQdtFiTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+dGHcSxjvqehQJbhNl5YJMfv10Xc2Owq58RnnTzvBpYM5m7vEtwSFEr4lmzffw20NqCoBYCw0ILMROhU4CpRKgjCPY5PricF04g9t7BjfjlSbR3Yp6jgAD3zU225KV4SJKtmrJi2zbGwEs8L/2Hf40H6EbZrYXtIieCqxrZ//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QbofmtLr; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbofmtLr"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso7425ad.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777927240; x=1778532040; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=44jYzK0YI4vgBmRBFomnrNtpmRA/B7MEUchibqvVlXY=;
        b=QbofmtLrhlU60c0bYSzRUrzABNbCXjSFlslR1d4IWvULAhf5UixIe3FSEFIXQlx+6O
         umWF6QFmP0pgUnYQ4KKG0LefDmxHrOcpLP33C3KzbcEH/Klm7p0ravfVBnYY4wW7ep9a
         0IOs3Eqmr+VvPAy08JSQJmbsCky/RZdn/qGkZyZGoutxiP0/0S+d1aqOFAdLirryE6NF
         HRpz63naNHxaxbYnuJZnxcsmwnz2r5vlzXXnfkPC+xZ1j8v8ft/iT2t+vL6IuAkUINXA
         sMMg1WAZ8kjOfHSEzAQr+INr/HX0WNz3f/Ff8vcgvVu25LKMY3CY29eqTVb+oiIbf5aM
         aApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777927240; x=1778532040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=44jYzK0YI4vgBmRBFomnrNtpmRA/B7MEUchibqvVlXY=;
        b=iRsvLQMW/f1QQN0tZQ1opXJnhSljURzkQYFwPGM+GWg6q+IzldQtp8/Rns1f+yaX4e
         iYYV7O2L14ouTvWJMOuNnxRLtKcutV+n9VbW5Ng+unYy8sKKexakyFqr6zWLbn/aY8ZW
         bf+zMN/pOPhRBVr/YAhC9U0aOW0rq+pLyida8eYZmqunJ39/Jk21QzBy6ENLp1ydohJi
         tacsTA9wbiWfWG0TbsIwcD4NFpQAS85mzuHRo17BFdX/63SicHaE5L1Tn8SBu/poqzVj
         /F+LaRXCuwVFWMONi+PGzdIMrPJs0upUQZW11R1YluaiNPcAaFzuZYCOfIAOJq1z9h/P
         XMOw==
X-Gm-Message-State: AOJu0Yw8HGTYsnKOVpJKkZweDgWT7cU5t+5mxr0bRhKlQ11yxFRK5IaL
	/g1RtDEgwsikpxiTi7MLY9pX2A5naZXUvnMKnZATmTWkpSvqvfoJ7z8VbjWgw46Nyw==
X-Gm-Gg: AeBDiesAL2yLW2aUwrkoAP42jqYLRmX9ZeHRqFsuNhp2faqMq6F29rWKfQXkMaX3Bw6
	0QJvInXo1EnnSBSZ1rOX4pTHy097ubNPIPDi+BLG0cCEBmeQQFzUU5zGLQ3TyW9ThtJmXSCc7Ai
	rUoyIVJocKTIG8g7pUGd7WraT8Pp8Ezpsw6x3fewucKgRHtYOmbfu3dxtOSZlTNpFEbqCRwDxtB
	m1S5GoLrSX1NXiL3AezH369BzD/LaxGse3/tQVF9ySaZR+A2UCyZzK1IfAUM4TBLuJK+facG8To
	xqaCghXEFHiKNOD3ZGE+t5MdAlsiIdzdPfZQWDBPBnw54SmDZPMBRtoniuoYlwb3JetSfGkxjP0
	P+wlG3lY9ca7U+YmTbvYhVFHQEflhBZHL/zboPtpKkRsAQMKTchCBedUbLd0x1CWFKgw3RdtigV
	HwpFduGrSkqpqJBtgg90rayHYdS7QO9dGCbYhLRrp2RNU5O6RRXtMMkzvaK5GeadvYO2WoIhALM
	9klyTeRLLaUw0jyFA==
X-Received: by 2002:a17:903:32d1:b0:2b0:5cc5:9405 with SMTP id d9443c01a7336-2ba531108e2mr297145ad.1.1777927239870;
        Mon, 04 May 2026 13:40:39 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7e80bsm114878825ad.8.2026.05.04.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 13:40:39 -0700 (PDT)
Date: Mon, 4 May 2026 20:40:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afkEQTSiP2WE_KdJ@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afkAKlu4nllduGCE@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afkAKlu4nllduGCE@nvidia.com>

On Mon, May 04, 2026 at 01:23:06PM -0700, Nicolin Chen wrote:
> On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> > On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> > > On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > > I am thinking, maybe the call sites of pci_enable/disable_ats() can
> > > check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?
> > > 
> > > Then, we keep master->ats_enabled as-is, so detach() can revert the
> > > nr_ats_masters and ATS invalidation entry in domain->invs.
> > 
> > My suggestion in that case would be to update arm_smmu_ats_supported to
> > check if the client is a VF and check if it's PF enables ATS:
> > 
> > static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> > {
> >     struct device *dev = master->dev;
> >     struct pci_dev *pdev;
> > 
> >     if (!dev_is_pci(dev))
> >         return false;
> > 
> >     pdev = to_pci_dev(dev);
> >     if (!pci_ats_supported(pdev))
> >         return false;
> > 
> >     /*
> >      * If this is a VF, ATS only works if the PF has already enabled it
> >      * with a valid STU.
> >      */
> >     if (pdev->is_virtfn && !pci_physfn(pdev)->ats_enabled)
> >         return false;
> > 
> >     return true;
> > }
> 
> I think that's okay to address the issue for now. But it assumes
> that pci_enable_ats() will never change so it won't fail for any
> other reason.
> 
> > and then in attach_prepare we can add the ats check for safety:
> > 
> >         if (!state->ats_enabled && master->ats_enabled) {
> >                 pci_disable_ats(to_pci_dev(master->dev));
> > 
> > +               if (pdev->ats_enabled)
> > +                       pci_disable_ats(to_pci_dev(master->dev));
> 
> master->ats_enabled is redundant if we check pdev->ats_enabled.
> 

BTW, is it really redundant? I assume it represents the driver's state 
machine? I believe the condition:

if (!state->ats_enabled && master->ats_enabled) 

translates to: The current state has ATS active, but the new target
state is to have them inactive. Isn't that the case?


> If we add a gate here, should add to pci_enable_ats() too?
> 

I see that pci_enable_ats already checks for it:

	if (WARN_ON(dev->ats_enabled))
		return -EBUSY;

Praan
