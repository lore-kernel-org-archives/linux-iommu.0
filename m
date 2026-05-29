Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AD1349AEA
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038232; cv=none; b=jRpAZNR9MSUVOcV4GrDT/LETRYKAZZ1yl7DvujNa+QNMwEjNpqctKS/Rb+/lVoHLIicz9oiBB54eBDTiTZ6XIl9meHwVBwyedB/GRrCZtx5IByS9klsqYq+zkV2KQdia0Ihnn1bHJyOg42/Id0yZln9QGvPr75FPIMK2E2f4vlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038232; c=relaxed/simple;
	bh=K37FJrlJLgQ48xNBlfd/0e/D+IfYMnIA6C3+yZ6AfF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dDcTCB4lW4BPoT4dwz8GCfWpoOEPDwUMJniIKm89tzLK0LqLOv4dOcfpLs/eY6YVsFzkc+mGPhrpeTuBrnKI03kOoRbihFbY2RINgsefp7WRUs4dDodaGoE5JVmM6zOgu5LfqdeFqGR4M/RvdbeQwglar20cq2eBqst1GW2ad6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z/wgWQgo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z/wgWQgo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf2911f93cso715ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 00:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038231; x=1780643031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wayzXiIvXZ+65LI5CwNwB4BPx1PsmW3NvKiQ0xrMIcM=;
        b=Z/wgWQgouVKaabVcMCXbzw1e/vDezguudesN8W2ePB8MyEFrSbwTExszipdNMJAZwT
         y+BCnq+iWYXkvChIiw5DvSvntia/M2tHRfkkCruqVJm7CaeXklsookpxEAPgAECbIid0
         ZG4aW2ha0WgimZAupl+LUt0voxRZaoE2c5cx0GzvlBHs8KNQhxhycJCLmGIuRrRCzx7L
         zqCXJ1UAsE8O2RFu0f4/92Yphu03N01Zmn0cyqhatmc+Dm8L8qeLcSLIeHR0sJM1p2VE
         m1L9SqHLQ1c/aMOaoHCHqq2rwM6MzX5wNbB1yqEyJ9Fnq0CJxdvOh5nRMZN1EfyqMzCg
         VbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038231; x=1780643031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wayzXiIvXZ+65LI5CwNwB4BPx1PsmW3NvKiQ0xrMIcM=;
        b=JvIGZbrDK3GeTwLN4kmXEbSjIGugPAnr6ToYZrZ5ZSXhTwnZTHcBk+IekYKSTPVX5f
         5FhKakkL5dStiXue4Uz6inXZEIPtjkbnv710eJuV5x+To90C3V0cORDwxbrUB6aw9cfT
         J9CSlxM8Fxu/wDEDfiERsQZWhKnIsSx08PNJmaC38KLT7UnDfO9lw3w3DNwAEp0BL1zg
         /P9HHDXVp8QkM8aQ55mxjXLjMRf3AHXwJnHa5TVtnnrCmwBvl5CuTdq3HxX0sJ6fdvTf
         DnvkklFVFP4JW+tX7YATU39H+zCNgRaX7M3dKS4NTseiIJFDwlH3q6/O945pzca06Ou+
         oLiw==
X-Gm-Message-State: AOJu0YzVjO1O4sfGuY6EQ7cXglhU0zFHFsamHr+8CVVEmDSghgen0BCO
	9F1M4YutNJl2WLTXHaRYbutuGHmDaHI8t5xFi06dISVli+oDg0H+SrEtADFoAbsC7g==
X-Gm-Gg: Acq92OHvz22lIRZann7TlmGOdk97LJMXDMn46Yj0GQCUc1+hFxP2U0LfBLeXwyuozaZ
	cVLNzfwwkC7Gzcx7Mv9XySRqavlbXKyDncLABanFXdOYvSA1aYeZ8cS71o1mxr1tVFfHr2yn8fg
	jxhwW9otvahQZiyXEmGk2U6fvEm/b3lXG2sK+gIrHZyvkyv/Npvb2FYNFpXBGNSI4+I27zuDYTv
	dZyc+Lb5LBv7LY/PZnqjmagC2EbyGvp431ELgPH9tpxNd07mkR7M/NNjJ6E3c5HJ9H/DEteoYQ4
	9XsDs6r7Lhz3KGfGU0XSExdJoEjjTyMmokJEqI0osgKA/gCNa+YY6OC+8Odp8W7OrHhJygWavA4
	3w7N88mYiJY0KLgmXEg1kfx7sTUMZnGbzYJ4sY2KwV6y6ZSe+yRL1eGz0eG1wLXhIIjcyZzISZd
	sAmToKyNMrGDEh97b+y9x0KZNl+N63l99uxL2/i7I5iOu/bt6LS2/Zz3V2ZLmOly2y71Ywihy7h
	FMMLiA=
X-Received: by 2002:a17:903:41c7:b0:2bf:1ae5:2c51 with SMTP id d9443c01a7336-2bf22e488b9mr1020105ad.1.1780038230320;
        Fri, 29 May 2026 00:03:50 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbe12456esm592183a91.4.2026.05.29.00.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:03:49 -0700 (PDT)
Date: Fri, 29 May 2026 07:03:41 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v5 6/7] iommu/vt-d: Fail probe on ATS configuration
 failure
Message-ID: <ahk6TchfnjsGUzs9@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-7-praan@google.com>
 <3fa3d4c9-c083-4167-93fe-814f0ecfcb7f@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fa3d4c9-c083-4167-93fe-814f0ecfcb7f@linux.intel.com>

On Fri, May 29, 2026 at 02:39:26PM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > Update the Intel VT-d driver to handle ATS configuration and enablement
> > more strictly. Specifically, update the device probe to fail if
> > pci_prepare_ats() returns an error. This ensures that any ATS-capable
> > master reaching the attach phase is guaranteed to have a valid config.
> > 
> > Additionally, update iommu_enable_pci_ats() to WARN() if pci_enable_ats
> > fails. Since earlier checks in the probe phase preclude config-related
> > failures, any failure during hardware enablement is considered a kernel
> > bug.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 15 ++++++++++++---
> >   1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index ed6d3a0203f5..f13da16717fe 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -876,8 +876,14 @@ static void iommu_enable_pci_ats(struct device_domain_info *info)
> >   	if (!pci_ats_page_aligned(pdev))
> >   		return;
> > -	if (!pci_enable_ats(pdev, VTD_PAGE_SHIFT))
> > -		info->ats_enabled = 1;
> > +	/*
> > +	 * pci_enable_ats() should not fail here because earlier checks
> > +	 * have already verified support and configuration.
> > +	 */
> > +	if (WARN_ON(pci_enable_ats(pdev, VTD_PAGE_SHIFT)))
> > +		return;
> > +
> > +	info->ats_enabled = 1;
> >   }
> >   static void iommu_disable_pci_ats(struct device_domain_info *info)
> > @@ -3292,7 +3298,10 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
> >   	dev_iommu_priv_set(dev, info);
> >   	if (pdev && pci_ats_supported(pdev)) {
> > -		pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		ret = pci_prepare_ats(pdev, VTD_PAGE_SHIFT);
> > +		if (ret)
> > +			goto free;
> > +
> >   		ret = device_rbtree_insert(iommu, info);
> >   		if (ret)
> >   			goto free;
> 
> Sashiko made a valuable review comment, and I believe it applies here as
> well:
> 
> [Severity: High]
> Since ATS is an optional performance optimization, does failing the
> IOMMU probe when pci_prepare_ats() fails break backward compatibility?
> 
> This completely prevents devices with buggy ATS capabilities (or VF/PF
> STU mismatches) from attaching to the IOMMU.
> 
> Could this disable DMA translation entirely for hardware that would
> otherwise work correctly without ATS?

Ack. We explored the "not failing probe" strategy in v3, but following
discussion with Jason, we moved toward this "Fail Hard" policy [1]

The rationale is that we ONLY enable ATS IFF ats_is_supported().
If a function claims ATS support via pci_ats_supported() but then fails
in pci_prepare_ats() (e.g., due to an STU mismatch between PF and VF),
it indicates a bug or hardware inconsistency.

Thanks,
Praan

[1] https://lore.kernel.org/all/20260519145947.GK7702@ziepe.ca/

