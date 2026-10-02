Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FF1C2324
	for <iommu@lists.linux.dev>; Fri,  2 Oct 2026 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790975515; cv=none; b=uLCuLsy+o1QK6sBDpvqgDJS8wS7DJ9A6eAQDdLUymElkjR/s2Vyw2yv/8KvoT7uRL7ozf/Jf1yk9Z1u+NvYWg6NQ02bFfdFGsmXWTuahjeNzOrUdC/t4oB0UP9n1ad8tC/eFGN+8L2sJ8ymlHxt7rLFIUByXIIy4l8a/3iEX3eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790975515; c=relaxed/simple;
	bh=iOrHGz64z0wKTg4YNpqTI/tUIfNY75DEXU5oPmbSSps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJ1p4QDsEzo4VJlMZBTGQdxNiZQ6RaOfNax0cW/C8EZMOoIHzz8qhXSM4aXSE7Tg3ePy+IqQQFjmUN+a5/urHah+inSc4YlPNF1U94HZRAUDTWN3A/JX4qqF0eK5scBLLcVc5JV90B4ACjZ37JSm42qJP6beoKQeJ/tVnnpYZY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nuDcH4Wh; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nuDcH4Wh"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d3b445a84fso20545ad.1
        for <iommu@lists.linux.dev>; Fri, 02 Oct 2026 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790975507; x=1791580307; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aTAI7MYZpbnU/agtQxfkMDXpGe2YnzBKn6e+VLjrcQs=;
        b=nuDcH4WhOYh6+5b80rm+NwPkm6jz+tV0Ti7Q7U5P9xyREJJNGhs8ysG3fPJ2oFd7wD
         V9LuMByJDpE4dv8+zPR1RUXJTR9i14b4ACUYzLErC6vSSXPPsktNiTJbQu23lxsf7jJ0
         vu+gO7zyIuUy2cTSBIB1Tv/pLQv4SsIT2B1OZ5KHSi7BSVPkGsE/nDQEOCT3+UuZwj3Z
         d09Z3ermq0HHJnlZ59ReApp49KYNeglieeSyfYNdxgfEUjgNb35sCTsf6KRHxH74983T
         dum58uBZ72xIgB8Aqw+JWmyVDbq4ddeEt4aWtRGXUJ78uLIJFcSm1vJaCou+MFSU+28t
         wv+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790975507; x=1791580307;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aTAI7MYZpbnU/agtQxfkMDXpGe2YnzBKn6e+VLjrcQs=;
        b=L/5hPavsZiGJ0JUcgfMhYFBMHKu348vOHtBQtOd/lNLX5+kIVmlAHtRhyIzd56GaB+
         Hjojw9hbQtSqWp3LGmXbtFjwiLDpAMc8Snp2zW3X0YoxivxSm4iKOknpLsxH5PLZY4UT
         6kOOLX2UsSDBPptHb3ctHqsPHrePhHlsn33lCf56scOA3eSbvOpz6+iidOgEi/2cZX3L
         OW04bywAy85Yg/UpExe80YtI8qsRkgWKzt5dHUSK3RY0hiY3rFHzSSplmqGk9PBDKpfE
         JXTFgwdqlOkjjeANqrB5dkaRqUvbHeEePjIOWW4FLqbJ7zxOiBuIiBcZuCLwCEAMh3ev
         2gWg==
X-Forwarded-Encrypted: i=1; AKwUvByosmElpAHn0PA1RPxSU+MwfnAYH0Ym4VLATWYESOiSK9Pwm6ZOBPV4jPTJZc7E0NvyyTqZPQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYK0IdzWCuegUfhxDUvWGKTpbj1/Yvns0XQRY5fbBgLoDIYFtVvy
	Ng9DliyaeN8YsO0Yjovr8DbFoFqqt8deu7BjJptNgd3zsjkaOQU+1LKh1YXNElCkIw==
X-Gm-Gg: AYBFou19k26w6PbFsEs5ctHW0ePrAAFALcFKRNBU9nQ1mmpMXunN3dyS4Vy7i1uWIdG
	jZsXZJ/hyBfjYJ9ehhZLBf6A+JQjrFIUPDOoswrZURONA6ZwrqCnULb5xhlYYbzQC/8qhrqDT4Z
	j485jfAeQvVy0Jj3MGSrQnQFgTKXnfVSPRw3W+9rejAlT0yEdBzTzM1LDD5wMSzC44+ePiklJ8h
	SAcV3OYcArZCNj3wLv5jrg7fjCqCCLX8kJ+jNUHk/XSASYObJ8pXnvIXtxK7pawE1ZkTjJVoMsI
	qANW6Geesjj3jrnIDqty7jT60mQa/Aul1Mv4BEOFXMWbz4qQV7fo0wDqbh5x7tBM2v2Q8h58Eb/
	W2yhfNsUrlomFwUetq9F7gOsQPgPwuabbcmFF5bC+DUmDK0Skh8tV1KhPkaPafA0NZe9hk3w0zd
	K1k/MeNnl9NEHxX7377Q2lIKj+sXJG1OAnrdTaCQdpH8tjjOV6aW/VPEhmfZi+X7PTY65cWeOWF
	qZTZtODLHiZoEgkyd/qGjIO+XKy13IAyBb8
X-Received: by 2002:a17:903:b8c:b0:2bd:3bfd:74f1 with SMTP id d9443c01a7336-2e53091f83bmr1274215ad.2.1790975506423;
        Fri, 02 Oct 2026 14:11:46 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78e497230sm39218a91.11.2026.10.02.14.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 14:11:45 -0700 (PDT)
Date: Fri, 2 Oct 2026 21:11:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>, iommu@lists.linux.dev,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <asAeCz_rmpe5hbsh@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <ar1yNtr7Kp2OTcDd@nvidia.com>
 <ar3yWUmi8E0k37Ml@google.com>
 <ar6gY9grmdMZcN/M@nvidia.com>
 <20261002164748.GD3481470@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002164748.GD3481470@ziepe.ca>

On Fri, Oct 02, 2026 at 01:47:48PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 01, 2026 at 11:03:15AM -0700, Nicolin Chen wrote:
> 
> > > So we can't issue ATC_INVs during suspend (the EP is already down), nor
> > > during resume (the SMMU resumes *before* the EP is made active). The EP
> > > can't use its ATC while suspended, and if it loses power/resets on the
> > > way back to D0 (from D3cold, or D3hot with No_Soft_Reset=0), it comes 
> > > back with an empty ATC.. same assumption the PCI reset path makes today
> > > (pci_dev_reset_iommu_prepare()).
> > 
> > In that case, would the STOP flag be too late? It's only set in
> > the middle of the SMMU suspend. So, an ATC command (via doamin
> > invalidation) might be issued prior to the Point of Commitment,
> > which will be timed out due to the unresponding EP?
> 
> How can you ever fix that?

The unfortunate reality is that this gap exists in the kernel even
today.. upstream SMMUv3 has no RPM, so it's always on, while the EPs can
runtime suspend independently. So an ATC_INV can already be issued to
an EP that has suspended. I'd argue RPM improves this slightly, since
once the STOP flag is set everything is elided, so the window closes at
SMMU suspend instead of never.

> 
> How does power management really work, is it expected that the end
> device is already quieted by its driver?
> 

Yes, power management would topo-sort all dependencies and invoke
suspend callbacks accordingly, i.e. in our case the suspend callbacks of
all SMMU clients would be called before the SMMU's suspend callback.

> Could the first step in power management install a blocked STE? Then
> we don't have to worry about ATC desync and that automatically stops
> generating new ATC invalidations if we go and detact the domains too
> 

Partially.. at SMMU suspend we set GBPA to abort and clear SMMUEN, so
nothing gets through while the SMMU is off. But that's global and only
happens after all EPs are down, it doesn't stop ATC_INVs in the window
Nicolin pointed out.

One way to ensure the ATC state is relying on the PCIe spec to lose ATC
content during D0 entry from D3cold, or D3hot with No_Soft_Reset=0). 

Another way to enforce this, is to *somehow* ask the endpoint drivers
disable ATS during *their* suspend, i.e. in the EP's driver's suspend
they could call pci_disable_ats or a better suited helper from pci core
and the in the pm_resume / rpm_resume they could call it's equivalent 
pci_enable_ats, counterpart ensuring a clean ATS state. Or maybe the 
pci_dev_reset_iommu_prepare/done() pair (with slight refactoring) in EP's
suspend/resume?

I could mention this explicitly in some comments or dev_warn if any of
the masters have ATS state as ON during suspend?

LMK what you guys think of that?

> Maybe I'm wondering if power management should involve the core code
> so it detaches all the domains from the device, setups up blocking and
> then the iommu itself could power ofF?

I'm slightly against the blocking domain attach because it's a
reasonable ask for the client drivers to be able to dma_map / unmap when
they're suspended, given that most of the modern IOMMU state is
in-memory and the only HW state is some sort of TLB/ATC maintenance. We
can map/unmap when the IOMMU is off and just ensure a clean cache state.

Drivers often want to pre-map everything, power ON just to run their
workload, power off and then unmap. 

That said, I agree it would be nice to have the core code handle power
management, which can be one of the next steps. (it would be complicated
to see how or what each IOMMU might have to handle for power mangement
in a generic way). 

> Jason

Thanks,
Praan
