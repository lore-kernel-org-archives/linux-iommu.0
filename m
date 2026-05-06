Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D2C309EE7
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 22:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778105087; cv=none; b=Ehax4yjHOUl65GpSnqahU8mNNW+1nvnSwzxZbuAme0my+w6MuVjSZ/RKkP8Tw/BhlV0Sr2/IYTbOc98hHVrT0OPmpIGr1n7xD4q2NDuihYQWg5u1FMvdkgkCL7QdphKkl+5P7rnWnlVjbaGRZnMkrHMbJZRWKGPwlQGLzUZp5dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778105087; c=relaxed/simple;
	bh=a/aXubIMMBKa2KVxHWnRXK7TRbb0idqgGQGBvR6+ju4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WY5KCpMeEScOcx49uY54FXYeevM0/uQIRn2VMARnPT1BySvsqSKIcbyKVHGnEtpStD/AjfqrCKcXCxFUZH+Shue1BI0Vd5D/KMu3jwnft1BQL6rXXx9GTaIqKYDjzlrv7b0MyUV4h+9plvlbLH/3tZ1ZO1v50UhJWeDo0WenVvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Af/OGKB4; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Af/OGKB4"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso17815ad.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778105085; x=1778709885; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YPcRdORi8EGyWobJ2WIEUsuCtHpHvRrii0Vhu6jLzdA=;
        b=Af/OGKB4ayqvU4vYjutuffmRmdJmlhoBLaNBDnP3m8MqCH7uDbL7EhY5ku+iLicGLu
         Pw0ekf2fqNj4xA8xQyw5FDB2GmYcAewAD4prH7L8kc9YK7Qe9nUiLcYTg+qxcNfRhhCL
         G56cgKW/A/NB7z07HuvSZrpmeuQDsIZJ8Yon+Y4+g6EhKeybMkT6VUHgCgQ1NdgmaTxV
         rfLvZRa+f6v0s5mop7yZPZuLF74muMAS9TjgUFp2A2bExRaK0z/hiumRHrbdFq90oWLB
         Kn29AVGbJuOIMst3B6cMKCIWSpi4ycY4pOfGZq8Zm8bVL4jhZBbIJcQtjjzZZIqqmes3
         YegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778105085; x=1778709885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YPcRdORi8EGyWobJ2WIEUsuCtHpHvRrii0Vhu6jLzdA=;
        b=M1TJe3c4YETrN7cStuklNFdfrEw55wMDJCTtpy4Kuxx5G4owQF1RLgaPbUs0985cBb
         83K82BKiXjSF2rnNzKijrUvoG8ig6Yqi/NvL0YZiKinYksp8sURtNI/Tc7Psafwh4OtG
         B4elYIgtWj63sAe9qwLAuuPtSiuDmI8XeTgWUEBRyLE7SJIFa7kNnLN+B4m5e80Z5UmP
         vaIlPQrjzwoVEKE6ehSzlBA9zokIYslyWPWhNExJlWOOsO9NgGcOFYR1O2Rd4kP3jBZK
         AiWaDLwm/IEKDmkstuyNashj7+gQzlMw45gGmL+0rv+9MCL/kSaiev/DJlGZIANewYOd
         gcPg==
X-Forwarded-Encrypted: i=1; AFNElJ9cNlDZoVgERYoysAmoHIF86VZt/OipbihzBP0I8X4ZF8M+YFSC/gIHLv2Keg1nogZr34WmUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzuvMkOeTW9dRScKBqOBSCzXAGMEb8Ifna+NzfI9y5JYCj6E5BO
	xmPX2gXVFhYtBXqgCBwHR9RQZNlJ3NVFKNQqFvAkUJZV9DtFtC/0LGy1LMimYlxo6w==
X-Gm-Gg: AeBDiesFjGNkzJjPCHTxFD6HanNS7WCzwE6jD3gY0+FtMX5l+rOqFT2aiA7WCkmTnco
	p42BagKzNDRRS1kjnAoITKbvHTSR0N2xrZVd+EL3QGcLpFVbt7jgNHepkDqjEyVrNWleCeGZwz5
	KGWdbX3aEKPOJqCeeE2Fh7Y4gwCfUgETIDajRUqig4egKUcPQtjfXhPBjTaKF4e0wJL3tSVtwnA
	zdR3fBGl8pE7weKywMrUK29zeQycmXK/YwOQKZNq+4pGpIkX7+iVd3oGPZYFauIJP3qCGYLj2iC
	sbxBXQKmcm9/3gLtTibqPUXMDMIkPDZdk0MaP/gPV2VfVc6ANgQ7cH+aZ8f7MVXNpuSWfCwej4z
	iYzu3EMWywiuSpEL6gCp+vt9vYmhW2BmytS9jScdUO4fCRRsCGjtGq6N3jpGES+R2GLt8NCAuEw
	0NCSkCEN322P2th1/iv/RxVOdy4+p3VWtM74FyS7aaSn1SIKvAXSS8bnbDUpD8XEZu1Vda8OUEn
	RaKDqI=
X-Received: by 2002:a17:903:4b28:b0:2b0:5e19:1862 with SMTP id d9443c01a7336-2bab63fdb34mr1436705ad.5.1778105084460;
        Wed, 06 May 2026 15:04:44 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365df6f88cesm1564860a91.3.2026.05.06.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:04:43 -0700 (PDT)
Date: Wed, 6 May 2026 22:04:38 +0000
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
Message-ID: <afu69hAtkRlI1GJd@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afu5Y55W5oj70b5v@google.com>

On Wed, May 06, 2026 at 09:57:55PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 06, 2026 at 06:46:30AM -0300, Jason Gunthorpe wrote:
> > On Tue, May 05, 2026 at 10:32:40PM +0000, Pranjal Shrivastava wrote:
> > > The PF shows no ATS Cap:
> > 
> > Yeah, that's complete broken and unusable. We should be failing things
> > not trying to patch around it. quirks should be used to deal with
> > this non-compliant HW.
> > 
> 
> IMPORTANT correction, the HW is NOT broken, I mis-read the logs & pasted
> the wrong ones. The BDF logs were supposed to be:
> 
> WRONG BDF logs: 000X:00:01.0 
> RIGHT BDF logs: 000X:01:00.0
> 
> Infact we're seeing an in-tree quirk[1] in action:
> 
> PF logs:
> 
> [    0.575983] pci 000X:01:00.0: [8086:1452] type 00 class 0x020000 PCIe Endpoint
> [    0.576003] pci 000X:01:00.0: BAR 0 [mem 0x640900000000-0x64090fffffff 64bit pref]
> [    0.576005] pci 000X:01:00.0: BAR 2 [mem 0x640a6cc00000-0x640a6cc3ffff 64bit pref]
> [    0.576089] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640994bfffff 64bit pref]
> [    0.576091] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640a547fffff 64bit pref]: contains BAR 0 for 768 VFs
> [    0.576093] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6cc8ffff 64bit pref]
> [    0.576094] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6fc7ffff 64bit pref]: contains BAR 2 for 768 VFs
> 
> [    0.832175] pci 000X:01:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS 
> [    0.832177] pci 000X:01:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x2dc) <--- pdev->ats_cap = 0
> 
> [    2.365656] pci 000X:01:00.0: pci_prepare_ats: ps=12, is_virtfn=0, ats_cap=0x0
> [    2.365663] pci 000X:01:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x2dc (header 0x1000f, ctrl 0x0)
> [    2.365666] pci 000X:01:00.0: pci_prepare_ats failed: not supported
> 
> The PCI ID : Vendor ID => [8086:1452] is for Intel e2000 NICs which has
> a quirk for ATS: quirk_intel_e2000_no_ats[1]
> 
> VF logs:
> [   16.634000] pci 000X:02:00.0: [8086:145c] type 00 class 0x020000 PCIe Endpoint
> [   16.634060] pci 000X:02:00.0: pci_ats_init: pci_find_ext_capability(ATS) returned 0x1e4
> 
> [   16.634196] pci 000X:02:00.0: pci_prepare_ats: ps=12, is_virtfn=1, ats_cap=0x1e4
> [   16.634201] pci 000X:02:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x1e4
> [   16.634202] pci 000X:02:00.0: pci_prepare_ats: device is VF, returning success
> 
> [   16.634272] pci 000X:02:00.0: arm_smmu_ats_supported: dev is PCI, ats_cap=0x1e4, pci_ats_supported=1
> 
> [   16.634282] pci 000X:02:00.0: pci_enable_ats entry: ps=12, is_virtfn=1, ats_cap=0x1e4
> [   16.634283] pci 000X:02:00.0: pci_enable_ats (VF): checking PF (0005:01:00.0) -> ats_cap=0x0, ats_enabled=0, ats_stu=0
> [   16.634285] pci 000X:02:00.0: pci_enable_ats EXIT: STU mismatch (PF 0 vs VF 12)
> [   16.634286] pci 000X:02:00.0: Failed to enable ATS (STU 12) error -22
> 
> [   16.634513] pci 000X:02:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS
> [   16.634515] pci 000X:02:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x1e4)
> 
> The PCI ID : Vendor ID => [8086:145c] also has the same: quirk_intel_e2000_no_ats[1]
> 
> Thus, this sequence occurs:
> 
> 1. The Intel quirk sets pdev->ats_cap = 0 for the PF at boot.
> 2. pci_prepare_ats(PF) fails during arm_smmu_probe_device() as the
>    quirk causes pci_ats_supported to return false & PF->ats_stu
>    remains 0. (arm-smmu-v3 ignores the failure)
> 
> 3. PF attaches to identity domain: pci_enable_ats is skipped
> 4. VF's arm_smmu_probe_device returns early from pci_prepare_ats() due 
>    to the if (dev->is_virtfn) return 0; check
> 
> 5. SMMU calls pci_ats_supported() for the VF in attach_prepare() which
>    returns true as the quirk hasn't been called for the VF yet. 
>    The SMMU driver sets state->ats_enabled = true
> 
> 6. We call pci_enable_ats which hits the STU mismatch (PF never sets it)
> 7. Later while disabling ATS for VF via pci_disable_ats, we hit the WARN
> 
> I guess we must think about the following:
> 
> 1. Check return values of pci_enable_ats / pci_prepare_ats in SMMUv3
> 2. PCIe core to provide a proper ATS flag that iommu driver can rely on
>    and maybe define a policy around pci_ats_supported() to make sure it 
>    also handles such quirks in pci_ats_supported().
> 
> LMK, your thoughts?
> 
> Thanks!
> Praan

[1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/pci/quirks.c#L5703
