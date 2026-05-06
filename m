Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8209837106D
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104684; cv=none; b=CBphhAqYXAlsRmBov2+57IV6m94+/4zWmTFJsnKm0NO4tkbr07N+OXoPNp/iZjLS3mkd47HdAD0K4NkThG0gh3eatlD8f0e4JE2MB4erNAhaMwnds6u0IZXu6qgzTxcrlmv5wbD7KsEBZW8UtkH+AFqSgdnnnvswJUHvDX8Ms3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104684; c=relaxed/simple;
	bh=A3Eyx0juCKPivb1WOr+KGxgbVBT3Er4gXQ6ywTpBPhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nlfskf/gidx4x0crafsnYy0drEHumWCiVORTow9J5J6ew0MYHOhwZMWYIQ6jmX75QuP/XAn0/Kgha9DhHMIYOG+V83DMEIc/XlLBCQnAeyq7nmyaq3/XM5IWagsjScMUsLqG+d10Ap3PWAktRBk7Otnqpnc/T3b7sEhfcPWT/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AVOJas8l; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AVOJas8l"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso17285ad.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 14:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778104683; x=1778709483; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOB1W/ORSDa7JUnJPQjyolVaPhXWnjrIaLVGMxAf84A=;
        b=AVOJas8lUcniTm6B22Pml5oY7c9bRbMnA4tBEv0o4eQv/ALfr5KxnBasotDQi7ge9a
         nA4nNg+Qp9V6Ac7KNWnRdtrR0WS9yaEBY8mBctR5OSXmnUdBSyazTOXMlRXIJ4dphU6B
         TnKnMpkPTwYA0HGhANphgJXckG/DY0sFB0QU1qw8FEfnn1Aktp/0UK88nuzhbrgIzRUY
         WQZXM1aUIuXWA2RVW9pr57IzAissAn3CcatWITAfBLNHsPM+G7z/CdI3VUbnsq3OY63S
         d7Y/GSZ7XJa27yJkcpQZzUqVdWlNDSsnm9wQbSrniLq1J/Gk9ACxMm2D85+WyNoG2KYV
         SNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778104683; x=1778709483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOB1W/ORSDa7JUnJPQjyolVaPhXWnjrIaLVGMxAf84A=;
        b=M3i4ND0pJn/CedTGw6ZcigkE1w/8X1/Jfxb96zYlgxPjDBVOxKboQHJ3JRNZs+B1PI
         SnMBqX9uPo1WH6vKtyQ59EWn0hv4xo2rIvF6Q0qZQBXL5HEvoSFHnXaUUB09Ir8YI1KV
         MNzshg+9Zl2A4VWA9nzVeOtaoOq+w5TOL6RLfiCYW5ipqbXS3nbDdQ9pKl6iMP0XABPO
         mMWMKU7e30YlgOMcUx0/G4j/vghIWSxelq4Ur0UQBj2Wfu77vEY67PK8st7N/CcBxogr
         cEgVrMnhDY1DXI3y6iSCSAyWwFVEFXDhjcmF0+8BtNMvShETBs7Ok6kCthbTkb2yfFRG
         xrCw==
X-Forwarded-Encrypted: i=1; AFNElJ//UOnnA9zgV8u5CrKk/P4fR3CuRBemQDBkZyJXlvkcGvuUl4yqN38aDMtHOMnT88oUZqTJxg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx3c5LOdEOr8PRCQ/MaMCM8jVDH1aTKIwtqGzG0ZUvU+Yj/I2Bc
	Ial1b4kPKWb9xhEViNCr0dXM9wt8dr/+M8uWtEOQB+iTbSXGjwCFJd5VDpKJzMHL/g==
X-Gm-Gg: AeBDieszMz0C3nxcd1lNUJdGXlSp6Ctb2dmxWFp1dEtV1kUbe/h5lNGbQEaObYER2NB
	r4E9NWYzp3ro2m/djtkyXrsPWUfYcol+ngO62mYp++lgEZ5MDZFJ9KWh9zRa7vJKb0x3OOa8Gsg
	60NMeuehi1e9BhVieA0v0pT5wQNCh5Md6cYNrJkQijkJ2U7YypRDKKK704JP8dsRDlcswHiHNvX
	lfH2ZbszCcBeJrhM8pPXVikd30coghm6PneEUcrBwuv4TquOs4aWwThuU8keK7VgiXILI+Em4Nk
	sicyrBuwJc+yI2Jy7MvFgoeBOHSwUNoqBlPfx1mSEZkcVfoyW2F2AC4/JwIp/Deh14FS1uBFZ5j
	JK1irFZAIGBQf/h8h6tUGCZ8roCv8Vx1gV7vQLDIkm+jzNni33Z2rYOTagnM835T3xwvO2Pk28+
	YqJcGjM9Fwi8Y1U6Fjgd2Xm+putovyWF7jOsoFf3u0TBUfMJHLJf9LKL2tJwEPPuwKIR18TiA4D
	oZ6zM8=
X-Received: by 2002:a17:902:f709:b0:2b0:b0c9:96e2 with SMTP id d9443c01a7336-2bab644d0f1mr1545885ad.21.1778104682252;
        Wed, 06 May 2026 14:58:02 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c9293sm6514543b3a.33.2026.05.06.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 14:58:01 -0700 (PDT)
Date: Wed, 6 May 2026 21:57:55 +0000
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
Message-ID: <afu5Y55W5oj70b5v@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afsN9jrsfuigV+DM@ziepe.ca>

On Wed, May 06, 2026 at 06:46:30AM -0300, Jason Gunthorpe wrote:
> On Tue, May 05, 2026 at 10:32:40PM +0000, Pranjal Shrivastava wrote:
> > The PF shows no ATS Cap:
> 
> Yeah, that's complete broken and unusable. We should be failing things
> not trying to patch around it. quirks should be used to deal with
> this non-compliant HW.
> 

IMPORTANT correction, the HW is NOT broken, I mis-read the logs & pasted
the wrong ones. The BDF logs were supposed to be:

WRONG BDF logs: 000X:00:01.0 
RIGHT BDF logs: 000X:01:00.0

Infact we're seeing an in-tree quirk[1] in action:

PF logs:

[    0.575983] pci 000X:01:00.0: [8086:1452] type 00 class 0x020000 PCIe Endpoint
[    0.576003] pci 000X:01:00.0: BAR 0 [mem 0x640900000000-0x64090fffffff 64bit pref]
[    0.576005] pci 000X:01:00.0: BAR 2 [mem 0x640a6cc00000-0x640a6cc3ffff 64bit pref]
[    0.576089] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640994bfffff 64bit pref]
[    0.576091] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640a547fffff 64bit pref]: contains BAR 0 for 768 VFs
[    0.576093] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6cc8ffff 64bit pref]
[    0.576094] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6fc7ffff 64bit pref]: contains BAR 2 for 768 VFs

[    0.832175] pci 000X:01:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS 
[    0.832177] pci 000X:01:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x2dc) <--- pdev->ats_cap = 0

[    2.365656] pci 000X:01:00.0: pci_prepare_ats: ps=12, is_virtfn=0, ats_cap=0x0
[    2.365663] pci 000X:01:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x2dc (header 0x1000f, ctrl 0x0)
[    2.365666] pci 000X:01:00.0: pci_prepare_ats failed: not supported

The PCI ID : Vendor ID => [8086:1452] is for Intel e2000 NICs which has
a quirk for ATS: quirk_intel_e2000_no_ats[1]

VF logs:
[   16.634000] pci 000X:02:00.0: [8086:145c] type 00 class 0x020000 PCIe Endpoint
[   16.634060] pci 000X:02:00.0: pci_ats_init: pci_find_ext_capability(ATS) returned 0x1e4

[   16.634196] pci 000X:02:00.0: pci_prepare_ats: ps=12, is_virtfn=1, ats_cap=0x1e4
[   16.634201] pci 000X:02:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x1e4
[   16.634202] pci 000X:02:00.0: pci_prepare_ats: device is VF, returning success

[   16.634272] pci 000X:02:00.0: arm_smmu_ats_supported: dev is PCI, ats_cap=0x1e4, pci_ats_supported=1

[   16.634282] pci 000X:02:00.0: pci_enable_ats entry: ps=12, is_virtfn=1, ats_cap=0x1e4
[   16.634283] pci 000X:02:00.0: pci_enable_ats (VF): checking PF (0005:01:00.0) -> ats_cap=0x0, ats_enabled=0, ats_stu=0
[   16.634285] pci 000X:02:00.0: pci_enable_ats EXIT: STU mismatch (PF 0 vs VF 12)
[   16.634286] pci 000X:02:00.0: Failed to enable ATS (STU 12) error -22

[   16.634513] pci 000X:02:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS
[   16.634515] pci 000X:02:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x1e4)

The PCI ID : Vendor ID => [8086:145c] also has the same: quirk_intel_e2000_no_ats[1]

Thus, this sequence occurs:

1. The Intel quirk sets pdev->ats_cap = 0 for the PF at boot.
2. pci_prepare_ats(PF) fails during arm_smmu_probe_device() as the
   quirk causes pci_ats_supported to return false & PF->ats_stu
   remains 0. (arm-smmu-v3 ignores the failure)

3. PF attaches to identity domain: pci_enable_ats is skipped
4. VF's arm_smmu_probe_device returns early from pci_prepare_ats() due 
   to the if (dev->is_virtfn) return 0; check

5. SMMU calls pci_ats_supported() for the VF in attach_prepare() which
   returns true as the quirk hasn't been called for the VF yet. 
   The SMMU driver sets state->ats_enabled = true

6. We call pci_enable_ats which hits the STU mismatch (PF never sets it)
7. Later while disabling ATS for VF via pci_disable_ats, we hit the WARN

I guess we must think about the following:

1. Check return values of pci_enable_ats / pci_prepare_ats in SMMUv3
2. PCIe core to provide a proper ATS flag that iommu driver can rely on
   and maybe define a policy around pci_ats_supported() to make sure it 
   also handles such quirks in pci_ats_supported().

LMK, your thoughts?

Thanks!
Praan
