Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35907175A7B
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 22:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778020369; cv=none; b=UXQyxTDs6E3h+2zesXItuysbPEnMf7aDuB0aNzTpSne3jvtYdbD0oVWwDEO4UWZ6FfgtDBzw/VISa2Km4108bZscXxcj1NLXSmUzKcgedk+0fuht/dJdhr7U9s3DyQ/K0GZLBbwZeWX67TfxBIszi6PN1vAad3lZWEl/B/4kc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778020369; c=relaxed/simple;
	bh=+6/2POXX3cuXcrGkXV6UbQDmfujdVkAZ9+z0vzeesnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kT4kPfTNU/qm5KT0uYlUPuEbgrJjuPfYJ4yF5p6butoP0kLMwYETfQm8ZSIZYZywZg7bPEuDBVyRDgFezUsvtYNlrNeCfzbWYU9IdCMFbS1Y5GV8RmEF/zb9wrJ/sotjpiW4JZLNeTM3McXycUl0fIYvK/ak03RhSHcati4DZaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lN3cCP4v; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lN3cCP4v"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so17975ad.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 15:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778020367; x=1778625167; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1xG+Qbz5wQjyMj+Ch1eYKOvYVfZIJ1i2cAjNHip5xLE=;
        b=lN3cCP4vTccKJH67m2V8FZjLxiGhyLq5W/0fzYgV1QOFDIw02t0L9oxNjXZFa3NtQn
         3aXZCCOYZQaOrxkWm52iuoulj3mcX06ocuSEnV+VVOmdDh+bHInMQQwnbRo4x4QCFUnH
         pmIFFJoSglXdSGWgmhg4A/JimcvbdcxkQSGcXB034bkeDsPqv4EHpB5T+itqaBFJ992k
         YhUtISE3z1RUoNTqpZN+ulYZa25Pg5wEcPwI53f0Z/iYJkXF971lQsYltfmLRukkkb8i
         P4iYTgGodGw4F0DS9THCkKroFtMwXbj2v8W3G9yvUCF2xMumwX/jUrlSICYggeF6ZWB5
         gtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778020367; x=1778625167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xG+Qbz5wQjyMj+Ch1eYKOvYVfZIJ1i2cAjNHip5xLE=;
        b=g6tWTNRvRQPX4dMVLiyE7LOXuBMkySa+oMldbeOlYzO9wKPd1orLT6/V9QS2Z+QTZk
         cVy0mXsfpvJAVmzY8Q7TmTppiFbD4bPoMoN7af/GrCazmT7RuOoHFsPX9V4TY+4XVfg5
         sQmmmdewecZTxCw8jN18aCOSKCjguadxm00dLEunIp8a/I11PvmstRCV9hST7ZQHjYk3
         8pZUVkq5Y9pav3I/NRMsFPeGTtukvaPMq8wx1XvBLL1PHb/WCBBpfg1NUmLwFlraO/m0
         0V9Lqo6SJWaE2rrmdzD+yYzPmCis+iDtdYjigyubk+gt2csPxlg/iN7wUUUaC2V7EEWk
         WxDQ==
X-Forwarded-Encrypted: i=1; AFNElJ+E2Vfy1ByjPLxtqFe5SiUVeAN8b9/b9xtX2aG6ECBTSsHhW5IbSQ834jUfmizfEgeFXARkJg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA/cPiBki0nkXnBxGrQmGVDwDHQPBJDP0yzj7RPmM1s19yYnx+
	6eDWGOXHLoaj/h8FWWwMccJyNaAFViqIkL0M0SevFvz+qbVXVFUxVd5HOsuKbq84PQ==
X-Gm-Gg: AeBDiesPVfJZWcUncyq3T2C46h9mWPMrzb4/q1AIrG6r6OgJ91BrREleUGs2eTnVenb
	u8qSmSnMbdNc3fK+wG2XHAz52ctbIyKaGyvfUnegaWjQZQLENtcAb/75g/MVCJLGOVfGLBBFDdi
	usb/dmNu+TAS3geiJTkf1kO+KPKoZPYUfKi6aBRqGyFAwt1M5E7lWhFu+JqD3afAmNwJI3awGsQ
	Q18VjJFi9QuItfg7CAdMGchqKtivRV+DNqOdbtydJCjrSFWImUgOU3HE1WHmyHdDwgRipFuhWun
	WYtm0GaTr+h8H8+cxd7B53sO0p07fgRNeUHHtaa2m+ewoxEAsW/+rHJVE5yzEDEVDEoFjbTApZM
	McwDt8Yl1+MiEy89Q0VF949CU3IS1Fx7Y0HpKX60QdcGyqabpo9K3Hs5s41NaO7IlpUwdsQv9m9
	o+nJS6ngaAodLikP9yTePnrMxNSHeowzqUAAmQWMM68xDK+tOu64Gu/WnKxAFb5RJC1FlhqQ/le
	qWcYXo=
X-Received: by 2002:a17:902:d590:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2ba7cc552ffmr746195ad.1.1778020367018;
        Tue, 05 May 2026 15:32:47 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7bf2db67sm3042775ad.29.2026.05.05.15.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 15:32:46 -0700 (PDT)
Date: Tue, 5 May 2026 22:32:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
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
Message-ID: <afpwCIjQXwfImPXm@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpdm5lfIeWptxOh@google.com>

On Tue, May 05, 2026 at 09:14:03PM +0000, Pranjal Shrivastava wrote:
> On Tue, May 05, 2026 at 01:11:26PM -0300, Jason Gunthorpe wrote:
> > On Mon, May 04, 2026 at 07:33:07PM +0000, Pranjal Shrivastava wrote:
> > 
> > > > > The issue was exposed under heavy load when running a VFIO-based DMA map
> > > > > stress test: iova_stress [1]
> > > > 
> > > > I wonder what's the real reason for pci_enable_ats() to fail:
> > > > 
> > > 
> > > Yes, It's the dev->is_virtfn case (the one you suspect below)
> > 
> > Oh.... This is a much larger problem then
> > 
> > The VF should not fail to enable ATS, that is a meaningful bug, I'm
> > not sure why are are just discovering this?
> > 
> > It looks like the PF unconditionally calls pci_prepare_ats() during
> > arm_smmu_probe_device(), so how does this happen:
> > 
> > > >         if (dev->is_virtfn) {
> > > >                 pdev = pci_physfn(dev);
> > > >                 if (pdev->ats_stu != ps)
> > > >                         return -EINVAL;		// maybe this one?
> > 
> > ??
> > 
> > So, I think the right error handling for a case that shouldn't happen is
> > to fail the attachment not to try to continue it broken?
> > 
> 
> Hmm.. you mean we should fail the VF attach if it's PF's ATS isn't
> enabled?
> 
> I agree prepare_ats is called regardless on every device and we return
> early without setting the STU if (dev->is_virtfn) but the catch is we
> never check for pci_prepare_ats's return value in probe_device :/
> (The PF might be untrusted or non ATS capable).
> 
> Here's the EXACT failing case:
> 
> 1. arm_smmu_probe_device(PF) -> we call pci_prepare_ats & ignore retval
> 2. The PF attaches to Identity domain (pci_enable_ats skipped, no logs)
> 3. We create VFs and try to assign them (new group -> unmanaged domain)
> 4. We try to enable ATS in attach_commit, fail and see the failure log
> 5. arm-smmu-v3 driver tracks the state as "ATS enabled" for VF
> 6. We try to disable ATS which was never enabled and hit the WARN
> 
> The catch is in step 1, pci_prepare_ats(PF) returned -EINVAL as either
> the ATS capability didn't exist OR the device was untrusted but the
> driver let it slide (ignored the retval in probe_device).
> I'll debug further to see which one is it (because in that case
> arm_smmu_ats_supported should've failed too).
> 

I added some logs to check the reason of failure.
To make the matter worse, I believe I spotted this due to a broken HW.
(Although, we can face something similar with untrusted etc. in the mix)

The PF shows no ATS Cap:

[    0.575749] PCI host bridge to bus 000X:00
[    0.575773] pci 000X:00:00.0: set_pcie_untrusted: no parent bridge, removable=0, external_facing=0
[    0.575774] pci 000X:00:00.0: [abab:cdcd] type 00 class 0x060000 conventional PCI endpoint
[    0.575786] pci 000X:00:00.0: pci_ats_supported: NO ATS CAPABILITY FOUND (ats_cap=0)
[    0.575787] pci 000X:00:00.0: pci_ats_supported: NO ATS CAPABILITY FOUND (ats_cap=0)
[    0.575819] pci 000X:00:01.0: set_pcie_untrusted: no parent bridge, removable=0, external_facing=0
[    0.575821] pci 000X:00:01.0: [abab:cdcd] type 01 class 0x060400 PCIe Root Port
[    2.591975] pci 000X:00:00.0: pci_ats_supported: NO ATS CAPABILITY FOUND (ats_cap=0)
[    2.591979] pci 000X:00:00.0: pci_prepare_ats: ps=12, is_virtfn=0, ats_cap=0x0
[    2.591980] pci 000X:00:00.0: pci_ats_supported: NO ATS CAPABILITY FOUND (ats_cap=0)
[    2.591981] pci 000X:00:00.0: pci_prepare_ats failed: not supported
[    2.592001] pci 000X:00:00.0: Adding to iommu group 19
[    2.592007] pci 000X:00:01.0: pci_ats_supported: NO ATS CAPABILITY FOUND (ats_cap=0)
[    2.592009] pci 000X:00:01.0: pci_prepare_ats: ps=12, is_virtfn=0, ats_cap=0x0

Whereas the VF presents ATS cap:

[   16.803702] pci 000X:02:00.0: [abab:cdcd] type 00 class 0x020000 PCIe Endpoint
[   16.803869] pci 000X:02:00.0: pci_prepare_ats: ps=12, is_virtfn=1, ats_cap=0x1e4
[   16.803871] pci 000X:02:00.0: pci_prepare_ats: device is VF, returning success
[   16.803927] pci 000X:02:00.0: Adding to iommu group <redacted>
[   16.803941] pci 000X:02:00.0: arm_smmu_ats_supported: dev is PCI, ats_cap=0x1e4, untrusted=0, pci_ats_supported=1
[   16.803949] pci 000X:02:00.0: Calling pci_enable_ats(STU 12)
[   16.803950] pci 000X:02:00.0: pci_enable_ats: ps=12, is_virtfn=1, ats_cap=0x1e4
[   16.803951] pci 000X:02:00.0: pci_enable_ats: checking PF (000X:01:00.0) -> ats_cap=0x0, ats_enabled=0, ats_stu=0
[   16.803952] pci 000X:02:00.0: pci_enable_ats failed: STU mismatch (PF STU = 0 vs VF STU = 12)
[   16.803954] pci 000X:02:00.0: Failed to enable ATS (STU 12) error -22
[   16.804168] pci 000X:02:00.0: disabling ATS

which means pci_ats_supported returns true for such broken HW. Ideally,
it should return false for VF if the PF doesn't support ATS!

Currently, we don't *really* enable ATS but I believe pci_ats_supported
should fail in such cases.

Thanks,
Praan
