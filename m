Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213B5306B0A
	for <iommu@lists.linux.dev>; Wed,  6 May 2026 20:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098793; cv=none; b=prpmkXRVLoykm3+1drj4hN9kPhKEWcUHGckxSuCNEPIXwcmS/4v9gB5racdfeBoTNLljQkDOOs511jbf8O7JfPfT0EZsj53Nt2aVG8/TKnRrbzBOxsmLm1DTay7NUOmq6GtOsCHgpKgx0YPLCx6Gx14iiK7nbAqfMGRsJzU13RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098793; c=relaxed/simple;
	bh=Edlevcg1nBaM3w99qkrpTrNZtvvaop69tskHgT2jrTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFAmVSFoXsiWlY7mE1YUHv0kKqUOECTto9I8cFgwIjdAO6DbH4AwbBJr3x6EQ+p1wKSVDIAt3i+Ofi+wHh6LCQDvDeq0ixYPSh9hMF7rQiVt0YLGX0jX8JNnKDpyZrPMv2vRkplsDwpddCgYzIDsLg5m5PtJBOXN6gRe+mt0xGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=InmzTGbV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="InmzTGbV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so7835ad.0
        for <iommu@lists.linux.dev>; Wed, 06 May 2026 13:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778098791; x=1778703591; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OCAPxB7QGconoA/zCYitEvGIQfm+2eC59LxLUGxnH2M=;
        b=InmzTGbVDP27SGAcD0nhTGKEEx0ed8o4LuNMcTCq7Ok7ytlihuMekZLzmgIsrq9qsG
         ZPXrHUy0Wkpa99KezqlIcrEMbXjRf6trQWbe/bVwzbyx3JZ0yyaDMDp4KnmmyLH0K1Ee
         cYKbDZx8y2Fgr5Fwkwu3XU2PDeYGB3A+YgTASfS4kNYudry+2p3K89Pvl4JyOTbhBwCR
         AWCNwlI4QHkfPRjHFNWSyjARolhWuyms4B3JOCPjlAct2SExY7b9Fkx9cZluERCAdE9E
         LLBsDe/EvRenOLlWf0PCe1ERCLrdhS+G1WBSfxS/zwSjxahcUrbz9vCpUtvyQI5mtXH9
         dIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778098791; x=1778703591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCAPxB7QGconoA/zCYitEvGIQfm+2eC59LxLUGxnH2M=;
        b=OwnN3uBBtr+ZfHToafz+QNvaHBZ6a1wPe5WqJxghYOifiBze+eWMisTTvoffIS7ONK
         zh6AAwbcUjvqEACaqgnN/aae/VBI/fRXXKbbqW1efzXLGkrPXKoWUh4CnO8Xw8P3OzF4
         x+ERLVG8YjoiMz7AoQevlTicc/n1zZYZoIm2biqB461I3bVtGNYdVnNp2QyMAKw1tdUT
         rH/zP5XgKLS6IliHhEyz0bLR+UgUaYvXaGyvIaIHmFtnwblt584RFNUE42nhOaJtQsXB
         z78YM3GmOIP0wKy/v+7MHPI9k+O1Shbw7LxkwKHmlEfpXzWpMxGhnc6TCSza0p1IoUKm
         bq1Q==
X-Forwarded-Encrypted: i=1; AFNElJ99QKHezKVnOhXEhZDAndYAouVauy48T5fIv6H6AvA0lnBTWNzv4beoBeBV99cbDswVu11dow==@lists.linux.dev
X-Gm-Message-State: AOJu0YwussUO24BBdaaSleadWvoORqxYKmFPmoqbdQ5JfZkxi733nJG6
	S9W637NnXfy1+dTqqWhKTTl0wSMSDLTsecDyxsjDAmsfKD4iE3OaRwpSvIzZ6nwEiQ==
X-Gm-Gg: AeBDietnrCETJjBNB9XiVs3C1CCspBvX/bd0nxm0khU5R+p8WRyiF60IfO/IdsIw6Ue
	V9MR5cY85OCBnppR++w8W2pdfKZa1wCOwWniA/TiuV8xSNJm683hBcteqlDb8QrqYFzOEGXxvo1
	f2eyNQUtDldm45sCW+D+ejQobk/RseaNR3xxyjB76GpgNMIQwdVNnYodlqqoAxrt4HiE6NJYtZe
	qzcHCV7XZxiUAUX/h18/oBmGeCDXj0U2Yn+Q3qMqaMNc4g1vcpT7ntG1usTza0v/394XMxWskhn
	AqeAXS/eAcBu0BHkEJ1qFjyKGCBWyA7r2P6A+vDaVVrmRLRmJe8VcV1tVQZypeIAe6PTZwj/m0H
	kGZtpUQnpgvOq8cwJwA+kh3+4PL4qLNwtrn82GRnZ5j3P7HMz1IIwMWy03YTEM4WYVoO89qsCR3
	yS5PSDm1KBfy06l/xplCT13xOl9EHk7BNg5hsDtZiOiBX6V6ldt482/X5nPKCm71uNCpPE1jFRg
	gUrBI0=
X-Received: by 2002:a17:903:1c8:b0:2b0:be7d:a25e with SMTP id d9443c01a7336-2bab6437c02mr910925ad.18.1778098790682;
        Wed, 06 May 2026 13:19:50 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2babb0e4a37sm545985ad.74.2026.05.06.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:19:50 -0700 (PDT)
Date: Wed, 6 May 2026 20:19:43 +0000
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
Message-ID: <afuiX-lXJOSURB4H@google.com>
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
> I like the idea of prepare ats failing on the VF if the PF isn't setup
> right and then either failing probe or just disabling ATS on that
> device.
> 
> I also like the idea of failing attach when ats enable fails so we
> keep a consistency, but it should be a WARN_ON path that shouldn't
> happen do the prepare_ats dealing with it.
> 

I think failing attach would not be the right thing to do, we should let
it attach without enabling ATS (if that's what the ATS spec mandates).

Even if the HW is sane and PF has disabled ATS, the STU is set to 0.
Since, pci_ats_supported returns true for VFs & prepare_ats passes.
Anyway pci_enable_ats currently doesn't allow enabling ATS if PF's STU=0

The whole problem is that the iommu driver's ATS state tracking goes for
a toss as it depends on pci_ats_supported which returns true for a VF 
even if the PF's ATS is disabled.

> > which means pci_ats_supported returns true for such broken HW. Ideally,
> > it should return false for VF if the PF doesn't support ATS!
> 
> That's also a possible option, but I also wonder if ats_supported and
> prepare_ats should maybe be merged together? Why does the iommu driver
> have to call both? If prepare succeeds then allow ATS otherwise HW
> does not support ATS, turn it off ?
> 

They are combined:

int pci_prepare_ats(struct pci_dev *dev, int ps)
{
	u16 ctrl;

	if (!pci_ats_supported(dev))
		return -EINVAL;

	if (WARN_ON(dev->ats_enabled))
		return -EBUSY;

	if (ps < PCI_ATS_MIN_STU)
		return -EINVAL;

	if (dev->is_virtfn)
		return 0;

	dev->ats_stu = ps;
	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
	return 0;
}
EXPORT_SYMBOL_GPL(pci_prepare_ats);


I think it really comes down to one of these three possibilities:

 1. If pci_ats_supported() is strictly intended to signal whether the ATS
    capability is present, then the arm-smmu-v3 driver is at fault & it
    shouldn't rely on that check to track its internal ATS state.

 2. Otherwise, if pci_ats_supported() is meant to indicate if a function
    is actually *allowed* to use ATS, then it's currently incoherent IFF
    the ATS spec mandates ATS to be disabled for a capable VF if it's PF
    disables it. 

    The kdoc for pci_ats_supported() mentions "Returns true if the device
    supports ATS and is allowed to use it, false otherwise." [1]

 3. Finally, if the PCIe spec actually allows VFs to enable ATS even
    when the PF's ATS is disabled (but is ATS capable), then we might
    need to ensure the PF is initialized with a valid STU even when its
    ATS Enable bit is disabled, to allow enable_pci_ats() to pass for VFs

I'll dig into the PCIe ATS spec to confirm regarding PF/VF dependencies.

But from an initial understanding, I believe 3 is the correct way to go.
If a device is ATS capable (i.e. PF & VF both present ATS capability),
We shall allow PFs to attach to Identity domain and disable ATS while
while allowing VFs to enable and use ATS.

LMK your thoughts?

Thanks,
Praan

