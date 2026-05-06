Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFCD33AD85
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 22:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778106021; cv=none; b=VrWCoaQ26wyPmaJXlleTUoIO1wTu1I5UhisFHtc6aiYottJpYJo6+suT4BY8ozCVM9ghpN56MEl5KoEPoGqVJLlk/5U9KfVIWIraZRK7B6H8KR6Z4LHl/LgArIA16Bjqhk0155Hqbz1i1WNfbIa4JKh9DZvgeqCHUQ5jHG5JLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778106021; c=relaxed/simple;
	bh=zRq/+I9xHsvThfUxt+wcHigq6zTh8tYsG/kpNFRaf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIalz0Kxv9o9CcXxp7k/BINcfYGutzRluGhURl0SekSBIUY5DxMvSvGUGcQ1JnrV9SSaKM//cWamuBVShM/sLSpLxMN1B/6+uacNoMDsmOC6rjf6iUkS9eMTUwkYWve9FRVLZP+yzwRA4fcVzjziTdbz1qDFRGFC44MMI7dyLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Who2fRXk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Who2fRXk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b46da8c48eso19545ad.1
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778106020; x=1778710820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=faK89Am0otTSmAcVRsm2dBTjpbS/djylu86NEYR5cEg=;
        b=Who2fRXk+rEle7tzN66jkcNv7e6Nkk8LDVzagEcFxebYKoZmmQ36n+0ckBKyAEjR+i
         j9LNUhVhn926XfQ8gnW/YZnzTUgOm9pEBm4KwuQMNYQgOp2xHAPXz1lGqW+cPJuKm0Xk
         ADgaKseO93SOj9L3A7kBNCyBO9JradakPpIbT4t4WrnzghEbPYGBEi6G9iyrSd7gFbHk
         kBRYYFy3yTYlvBmaIhBJe/ASniQPLjzgdTJ4JKvobAN7rfnZID/xLRaFytfASllgy0i0
         FH3F3ELHi33jsGFdjfsQTRLMUjEhHVlWnT7dGtMpVJIOrFs/xaQ8trNVOK9RtG9Lnz29
         Wmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778106020; x=1778710820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=faK89Am0otTSmAcVRsm2dBTjpbS/djylu86NEYR5cEg=;
        b=R97lkkmttw/WkV7gA7vSyTrehrkgwwOdKlHSqCGYS3yegDcfhW549UhUigJ3f25U/s
         w8IhHVhK6tRSuIhY6H/tjdCF/4osP3YDlnFZF0UhB/qIfYvzRGd6XqyNSn5voja1B/Yp
         W3Jf3BmIsLQaJ0G7xoCHVaxSYY/VGd0ElAGQbS6oKbzoDqy9umu8wfEUeQrQu3aenJ1h
         Fo2DFVDk4MjOILYERsYTUr+4RwBJn5S4pth85O+iESdTaKgLdjJhiB/nnSJPzBfJR+q4
         MFeXwcMw6vsJJxsCP8skjWNvmygTDzti0gXWs0GXtOwDDtF1h0gbcexL9/1Kv8Z91uf9
         jGbQ==
X-Forwarded-Encrypted: i=1; AFNElJ83brhmC5Fg3l8KV9HY13PYKjF7Q45iMUOx1uJO7MskhGbwJiFN/RxN9KoB0ycBaO9VZmWArw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzyYjzzJ9dArQTq+MNCQVfnQb1rrzR+cbv48t+FU+NOmS6BPOCD
	4Z/aXTzjtEK79VFskJRwU1JQuN/y2E+UkC7t0Q7AvWA1fugJJpZwQlODgNdEvaEXarXm9b6R16g
	ryRJJgQ==
X-Gm-Gg: AeBDieucO2Cg5F9/WSIvZYghbD9fwTmCvf3kL10NeLqJ/Ig89VgQyWqWf4r+izpkX5U
	XVFnXdDPARJXDuZ/t6JF5pcBxzfwb64yPvQOV2FthEJYQmLVjBjfRZdMadqBd/t9zuFGPGW234J
	bgZfnCF3U+GYeNbDabNmEaWI3o9YY2OwUR2zlqVTceY9kJiqQKrNpDXXrUvtzSTaTXNdn1Gnzj3
	Yoms9YJeU7m545EkRGXsOK5HKqfyK8Ul3LBroFqziMhSOc9c2cm2E4N9GcKKINO4mOgn0mH2ypI
	L+7bo/2LocXv5k7aJElo9E9QLnoQUvrVL/K/xGgaEU7zoQo1yRD/Q8RLdMmd3zcSMh5YiiEZ8Wa
	aYj7cd2iyNvavdkS3HbllWYvDio6z+TFqMYu3ZD2t5oqbTc8EIBnSBGWgNBHsKvXvu4bXUvZK9I
	MHKwv1h9poTOXFdYeqz44pxoDRArWxevCSvr7uBXIfc03X3wV08cIcMhdNWjNElGjbs2d6u+Foy
	mgDbpPUvVVTXqN78e4=
X-Received: by 2002:a17:903:987:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2ba7cf04e0dmr4884965ad.17.1778106019309;
        Wed, 06 May 2026 15:20:19 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82537949c1sm176498a12.12.2026.05.06.15.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 15:20:18 -0700 (PDT)
Date: Wed, 6 May 2026 22:20:15 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>, 
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Mostafa Saleh <smostafa@google.com>, 
	Daniel Mentz <danielmentz@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afu5s1vnmZ2aEev_@google.com>
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
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afu5Y55W5oj70b5v@google.com>

On Wed, May 06, 2026 at 09:57:55PM +0000, Pranjal Shrivastava wrote:
>On Wed, May 06, 2026 at 06:46:30AM -0300, Jason Gunthorpe wrote:
>> On Tue, May 05, 2026 at 10:32:40PM +0000, Pranjal Shrivastava wrote:
>> > The PF shows no ATS Cap:
>>
>> Yeah, that's complete broken and unusable. We should be failing things
>> not trying to patch around it. quirks should be used to deal with
>> this non-compliant HW.
>>
>
>IMPORTANT correction, the HW is NOT broken, I mis-read the logs & pasted
>the wrong ones. The BDF logs were supposed to be:
>
>WRONG BDF logs: 000X:00:01.0
>RIGHT BDF logs: 000X:01:00.0
>
>Infact we're seeing an in-tree quirk[1] in action:
>
>PF logs:
>
>[    0.575983] pci 000X:01:00.0: [8086:1452] type 00 class 0x020000 PCIe Endpoint
>[    0.576003] pci 000X:01:00.0: BAR 0 [mem 0x640900000000-0x64090fffffff 64bit pref]
>[    0.576005] pci 000X:01:00.0: BAR 2 [mem 0x640a6cc00000-0x640a6cc3ffff 64bit pref]
>[    0.576089] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640994bfffff 64bit pref]
>[    0.576091] pci 000X:01:00.0: VF BAR 0 [mem 0x640994800000-0x640a547fffff 64bit pref]: contains BAR 0 for 768 VFs
>[    0.576093] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6cc8ffff 64bit pref]
>[    0.576094] pci 000X:01:00.0: VF BAR 2 [mem 0x640a6cc80000-0x640a6fc7ffff 64bit pref]: contains BAR 2 for 768 VFs
>
>[    0.832175] pci 000X:01:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS
>[    0.832177] pci 000X:01:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x2dc) <--- pdev->ats_cap = 0
>
>[    2.365656] pci 000X:01:00.0: pci_prepare_ats: ps=12, is_virtfn=0, ats_cap=0x0
>[    2.365663] pci 000X:01:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x2dc (header 0x1000f, ctrl 0x0)
>[    2.365666] pci 000X:01:00.0: pci_prepare_ats failed: not supported
>
>The PCI ID : Vendor ID => [8086:1452] is for Intel e2000 NICs which has
>a quirk for ATS: quirk_intel_e2000_no_ats[1]
>
>VF logs:
>[   16.634000] pci 000X:02:00.0: [8086:145c] type 00 class 0x020000 PCIe Endpoint
>[   16.634060] pci 000X:02:00.0: pci_ats_init: pci_find_ext_capability(ATS) returned 0x1e4
>
>[   16.634196] pci 000X:02:00.0: pci_prepare_ats: ps=12, is_virtfn=1, ats_cap=0x1e4
>[   16.634201] pci 000X:02:00.0: pci_prepare_ats: MANUAL SCAN FOUND ATS at 0x1e4
>[   16.634202] pci 000X:02:00.0: pci_prepare_ats: device is VF, returning success
>
>[   16.634272] pci 000X:02:00.0: arm_smmu_ats_supported: dev is PCI, ats_cap=0x1e4, pci_ats_supported=1
>
>[   16.634282] pci 000X:02:00.0: pci_enable_ats entry: ps=12, is_virtfn=1, ats_cap=0x1e4
>[   16.634283] pci 000X:02:00.0: pci_enable_ats (VF): checking PF (0005:01:00.0) -> ats_cap=0x0, ats_enabled=0, ats_stu=0
>[   16.634285] pci 000X:02:00.0: pci_enable_ats EXIT: STU mismatch (PF 0 vs VF 12)
>[   16.634286] pci 000X:02:00.0: Failed to enable ATS (STU 12) error -22
>
>[   16.634513] pci 000X:02:00.0: quirk_intel_e2000_no_ats: revision 0x11 < 0x20, disabling ATS
>[   16.634515] pci 000X:02:00.0: quirk_no_ats: SETTING ats_cap TO 0 (was 0x1e4)
>
>The PCI ID : Vendor ID => [8086:145c] also has the same: quirk_intel_e2000_no_ats[1]
>
>Thus, this sequence occurs:
>
>1. The Intel quirk sets pdev->ats_cap = 0 for the PF at boot.
>2. pci_prepare_ats(PF) fails during arm_smmu_probe_device() as the
>   quirk causes pci_ats_supported to return false & PF->ats_stu
>   remains 0. (arm-smmu-v3 ignores the failure)

Ok that explains how PF stu is zero.
>
>3. PF attaches to identity domain: pci_enable_ats is skipped
>4. VF's arm_smmu_probe_device returns early from pci_prepare_ats() due
>   to the if (dev->is_virtfn) return 0; check
>
>5. SMMU calls pci_ats_supported() for the VF in attach_prepare() which
>   returns true as the quirk hasn't been called for the VF yet.
>   The SMMU driver sets state->ats_enabled = true
>
>6. We call pci_enable_ats which hits the STU mismatch (PF never sets it)
>7. Later while disabling ATS for VF via pci_disable_ats, we hit the WARN
>
>I guess we must think about the following:
>
>1. Check return values of pci_enable_ats / pci_prepare_ats in SMMUv3
>2. PCIe core to provide a proper ATS flag that iommu driver can rely on
>   and maybe define a policy around pci_ats_supported() to make sure it
>   also handles such quirks in pci_ats_supported().

It seems like that ats_supported() checking only ats_cap of the VF is
not enough, since ATS can be enabled for a VF only when the stu matches
with the PF? So even if ats_supported() for the VF returns true, its not
really supported if the stu doesn't match. And the stu would be set
properly if the PF had ats_cap. Should the ats_supported() check for
the ats_cap for the PF also?

We can check the PF ats_cap in the ats_supported() or handle the
enable_ats() error in arm smmuv3. Intel and AMD drivers seems to be
handling the error.
>
>LMK, your thoughts?
>
>Thanks!
>Praan
