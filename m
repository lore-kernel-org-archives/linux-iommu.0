Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30D054654
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016204; cv=none; b=BcBYDHLuFryKElZOKMLlOPzzRKWL4iQZXlHo0J3QgfJ9CoEBZJjKtvr8vgTphL4uL3hE0QwQk/lJIymf6GI/s8pisgSCjaYYDckSZ0xyc5JAe7Ip+K2GBnfSUg5DrVL8rJK3clW1fBctO75OeNGztu5HbzJhvFfqdsX99x/vMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016204; c=relaxed/simple;
	bh=BGb0iWxdCYeL8J+arIzaJxrMe2aHZ/tsRHAT4guOCPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/izgPEQ8U2I2LaB2sCE31A6gTNHIxIGr2FHoN7+EEKGGaKNFwgZ4LQUGXU99mg6hJer95SyOw8ilD+0TydaQLtpGyYcaijBdlfZthD8F9pt8oDTwZM62wq8h61IqFBsGpfbxrMi0G37IjPJVWTWNGv0fokCLzTQrgBKjZsgxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+iJzb7d; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+iJzb7d"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so13265ad.0
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778016202; x=1778621002; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EF7N2saeKWRt9QNInISs7LlrVhXl8UH86sm657r0EbQ=;
        b=U+iJzb7dqq9DdKfwoCINKG2W/Oj5+7umlceTnH+wQNl6Xfu4POMWkiWWCqFCq0GWQs
         /1lw8gteMPv+Immhy23qDUpG/Snr533ODs1rkw8G6qjsg3VkeTE+AFe3h55sOM6nrwLd
         HcXHLYQB/39uHfAjaxL1UyLzx6mNMwIBVXP+qn3CGNozb5txpDgJn/O4YVl5IgNpmOtA
         QEqvrZbgaqr3O2PQvMmeBToO+RwSRRbg1Unj7obBXOP5vtfyKJeNpAtH7BTu9x51wiRA
         Zx08REF/sBB0Zt+xfkYeklHaF1cTm5gbjZ4kRU8pIRIx1mve7a4gmhZDt9zQNDbZzpUW
         MY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778016202; x=1778621002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EF7N2saeKWRt9QNInISs7LlrVhXl8UH86sm657r0EbQ=;
        b=QbLoQBfk+CtGWgMxa7yybgP1VGXMbf6jTJlZZ79Ii9rCuDlvu7XzUMyFc+BsSeirxg
         5J0U2dMlunKZvkmWS2wSDeRXyr+D6Ov8P/2r44hdqN/CDmvVXwapr+x7mjf8eQbsTQRc
         8lyEV3VhF28ccp4s48oTqVx4xHVtUUxirUk/FQm+46TerlIF16u+PWwAarPckPQxziv9
         ph/Hxt5zVN32SOu00XoJutvMWDWu77rbhE1QcNSpa4VWdiSG/FMvOzZkpH35lilsavda
         hllQRNVbcp6zpfoltSF+TMSpKqmA0nrJOXkGVJ8FicPa5qn0ThftIpNAt4skBRPWKlsX
         A0Qw==
X-Forwarded-Encrypted: i=1; AFNElJ9Is4yQaxmxGPT1p5G3Z1UjOyfQo1QzueEAEo+wbescBHZCOA+NnJMSnxE0JDrNOII9Wlvijw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwmxT4Out3JNgI5TAEbY2k3+XAIbdkm05/ObIj4PcRhPlcIkAQL
	BCcC8koKERnb72g/6qzblClmJv9DduCQtgcX45PCsBMsOrRNuBGcMtOppPuyQVntlw==
X-Gm-Gg: AeBDietnjhltr+yfVXc7mXUJOc7EwNCl8fkjfe+GtnPL9+hLTZv8HRJigJIRm1/5Wce
	gX3dCPvvhIHUjIJeEYqszZvAbzDaNXeYrRs/s3XScmPbKJhLnjeD/gfyE0/QYiPTlsrROumR5u7
	i5spS3537KptxM/B6jIaA2BvFJbSg3gsC/thZemHjIMEQ5RvFIfq3hJ4mPtHlF+l4pAasVx6mCR
	+2d+ru9JsAHm3e5VYbLiPFqK2wtEvZAFby7reguvYLjKdpnHzfgHYOoHsUeN1fnqqQoVlmozfuV
	mlK9yx1t0tdiLkk2Z8VGDw3wDybY6C4QSIOQP7687Tl7IfKmyF051xqOX9lRy9wwpgSF5apqCvw
	JlSmpm5holK/Jij1TQA2AwX67DPBaDWtLE0vF2rjxYKAMV7JEuZBPLRCapPNuvvsKA93zmiILx/
	9BS4NBEJLqvPdKFjrjP8iq54sx4Jco5km7Q2KM0feomf8x9EGJ4s0uONgPUABwHQ+Mhx6yr7ixY
	xntcuw=
X-Received: by 2002:a17:902:d590:b0:2ba:dfa:328d with SMTP id d9443c01a7336-2ba7cc552ffmr456805ad.1.1778016201521;
        Tue, 05 May 2026 14:23:21 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-365b10d3e04sm31214a91.9.2026.05.05.14.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 14:23:20 -0700 (PDT)
Date: Tue, 5 May 2026 21:23:15 +0000
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
Message-ID: <afpfwwmUeNbs1juV@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
 <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpRUaciIEGvD3Bi@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afpRUaciIEGvD3Bi@nvidia.com>

On Tue, May 05, 2026 at 01:21:37PM -0700, Nicolin Chen wrote:
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
> 
> Inspired by your inputs, I found that pci_prepare_ats() demands in
> kdocs:
> 
> /**
>  * pci_prepare_ats - Setup the PS for ATS
>  * @dev: the PCI device
>  * @ps: the IOMMU page shift
>  *
>  * This must be done by the IOMMU driver on the PF before any VFs are created to
>  * ensure that the VF can have ATS enabled.
> 
> But it returns 0 directly on dev->is_virtfn.
> 
> I wonder if this function itself should just fail if dev->is_virtfn
> and !pci_physfn(dev)->ats_stu?
> 

Just wondering if there's a use-case that might break? Otherwise, in
current context I agree that we should fail if ats_stu == 0 / mis-match

> Then, arm_smmu_probe_device() must fail if pci_prepare_ats() fails.

I don't think probe device should fail, we should just mark that ATS
isn't supported for the function? right?

Thanks,
Praan
