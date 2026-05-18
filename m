Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0A48A2AB
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112899; cv=none; b=LbD9DFSAzjsqW9z/2VfwIJCCgdgSlwjUkOGygZ1TZcFxPOD0gPSwSDYXhwuPWSCh7IPjJFsTfPWnx1yH8WUQvSVCtMR/MB7t6H53ihozsj+oJsnGg0C3bTCqXzXB3QbA6KNMBAUc4FA+V0T2wMlxY9Gr7bkDNoElsQ4g+sUGSCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112899; c=relaxed/simple;
	bh=pDXXz1TH87s1IivcdxWzN8kqNDaLaW3x0g7egMGT/II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxIGkncuf4erY2pPMreCyKrZYM2OlAB/5rYMKnKzCT5Vgx2lUgGCQjElfe9rccjTgNOqa2khmxB3qn1+0aqVNF7jIOOtURhM/KdhnTyQfgOFxy+Xts23fL+WmE5SDT+PXtkYeIua6xrQ3vUP2HG5JBB1iZnVSsbBXPcn6M1aL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W8LUVKvH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W8LUVKvH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso1225ad.1
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 07:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779112898; x=1779717698; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/DDwNmydnZ95awbzSL1/xD68dz5V6Sw49Abl3+3NpU=;
        b=W8LUVKvHJlc/kDYSHfpOZlt6/2BYJQEw+uBbJbxUVuqSFDuaLS96ErLatBCXFUNyc6
         nQ2v/0tWKAzaR3Bsx9B7icXcxL/vHtXmVwXiA6Xw0EWUSaJZVhnf24CUl3yOfNVugQQD
         EwmBKuLLVnyCx6uC/b2pJmOsH6x2ht04PqV7N4NA4s1c1askLNJcb48/7/jQV8WVGrLV
         KeyuukOXVmLIBCFCacy3sAhC1uOv1uXhum9AD+GEwjRDpBB18jTGu3/ZIECG+EzR+Y/i
         kFIiguXqttRqHCoHJQP4d6NMgc2uCwGvp56asag/tajASuzGcYc8Kz5FeeKElGXSxxLg
         bO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112898; x=1779717698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/DDwNmydnZ95awbzSL1/xD68dz5V6Sw49Abl3+3NpU=;
        b=UvV3Gsbkieh9gvTe4ra3+O9BPAezRWZ2iwYOJ+EWr1+WKQ9gu67SPx7b/YFYPkFest
         omtoCZg/toUktBN2io47YurNMNm9CD6QYnsGEKgiiTvUt741vUWb3JafTn5jc/AhlA+o
         lJleqJFQaQdAVDv7zTrfMTCMk9qWhBLSOmFTxPSlGry9LAKsoSUMhj0u874AUqmDi49D
         aTCox4nP2KCNw0Tm24y1zdDU/pl6l9W3l3jIpjMxNIi4A3YgwCYWoZylSLC+kI/aiPm3
         0Qc1lWqwrOfOaqMhwP+1Ysk/z4O4ifOfaCgWeoYBco1YLkbMhDXEOPdTS+G+dLVqNIlf
         GHDw==
X-Forwarded-Encrypted: i=1; AFNElJ8HK5/qGNsP77Id1uoLOposAerGT/xaLAuIPtNo/WkMgmVKN4gRRWAAzIRkQHWasV4PtcpVpg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyxUX8ASXoQ04hfyLassGNliroM3bPUWUpDHeaeMieHmVxEJf6G
	YVgrHhDNARMnCCdtZo4BmSxUqQuHim5o0STSAN53UNG026z+esUEF3i8IjIH9YMInQ==
X-Gm-Gg: Acq92OHLGlJ+WzvaMvo9AoLFK0d1zsgoOu30tnAeEHNcSbHZIwCBmMRPPbTPhbuA3ZX
	hDa9jYfx8GwRXB9EGDqHSZTVvrKcRRohNbrovJnnfetw2fNrr3p0KfgWhhvt2KaOhrwgC9iKAgm
	/s/KF5hcLBFlnsUpu/W9MNSaIguKgeHCs8j/yND0/dZFStSUSQOxy4vdTP0zwk6vIGK+1Otg/+q
	2jnVoeNBORKiBMa3f91KTtelDA8Gzm+kBmgc4ewJpyEe4Ffj1x/830neuzUE0O1vc0zN8/45J2m
	yWiA4bCKBBtAKxudcVVAGI571dA1gfc9cNrD3QfcawtZFHQz1NcboZdUNbvCEItb7HzNT9utHVt
	BnO0uroTntdPCR0NMwvttx6mOO2qL4Ti7x1d8tATgOveBqCbw2BdRLMJmNuRLsQjOPX0fgiYjHJ
	/vQ0g21Bm07VPSux2sbBPqGPScpJhdhvP6Fpd7mVER10nAb3cPsX2YXEQ3QAyCdMMC6GWc
X-Received: by 2002:a17:903:fa6:b0:2bd:a61:8536 with SMTP id d9443c01a7336-2bdb03a448amr2847385ad.6.1779112895495;
        Mon, 18 May 2026 07:01:35 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d11b495sm159037515ad.69.2026.05.18.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 07:01:34 -0700 (PDT)
Date: Mon, 18 May 2026 14:01:25 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 04/16] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <agsbtV4oargwX45d@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-5-skhawaja@google.com>
 <3874a086-98ae-4b94-8c1b-20e13f5a92fb@linux.intel.com>
 <afzcqWa8iVqrhJLs@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afzcqWa8iVqrhJLs@google.com>

On Thu, May 07, 2026 at 06:47:07PM +0000, Samiullah Khawaja wrote:
> On Thu, May 07, 2026 at 10:07:43AM +0800, Baolu Lu wrote:
> > On 4/28/26 01:56, Samiullah Khawaja wrote:
> > > Add IOMMU ops to preserve/unpreserve a device. These can be implemented
> > > by the IOMMU drivers that support preservation of devices that have
> > > their IOMMU domains preserved. During device preservation the state of
> > > the associated IOMMU is also preserved as dependency.
> > > 
> > > Signed-off-by: Samiullah Khawaja<skhawaja@google.com>
> > > ---
> > >  drivers/iommu/liveupdate.c       | 162 +++++++++++++++++++++++++++++++
> > >  include/linux/iommu-liveupdate.h |  33 +++++++
> > >  include/linux/iommu.h            |  20 ++++
> > >  3 files changed, 215 insertions(+)
> > > 
> 
> [snip]
> > > +
> > > +int iommu_preserve_device(struct iommu_domain *domain,
> > > +			  struct device *dev, u64 *preserved_state)
> > > +{
> > > +	struct iommu_flb_obj *flb_obj;
> > > +	struct iommu_device_ser *device_ser;
> > > +	struct dev_iommu *iommu;
> > > +	struct pci_dev *pdev;
> > > +	int ret;
> > > +
> > > +	if (!dev_is_pci(dev))
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (!domain->preserved_state)
> > > +		return -EINVAL;
> > > +
> > > +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> > > +		return -EINVAL;
> > > +
> > > +	pdev = to_pci_dev(dev);
> > > +	iommu = dev->iommu;
> > > +	if (!iommu->iommu_dev->ops->preserve_device ||
> > > +	    !iommu->iommu_dev->ops->preserve)
> > > +		return -EOPNOTSUPP;
> 
> I will check for unpreserve ops here also.

[snip]

> > > +	pdev = to_pci_dev(dev);
> > > +	iommu = dev->iommu;
> > > +	if (!iommu->iommu_dev->ops->unpreserve_device ||
> > > +	    !iommu->iommu_dev->ops->unpreserve)
> > > +		return;
> > 
> > Is it considered a driver bug if it implements the preserve hooks but
> > not unpreserve ones? This would at least cause a silent memory leak. How
> > about adding a WARN like this?
> 
> I think the preservation should not be done if the unpreserve ops are
> not implemented by the driver. I will add these checks in the _preserve
> functions and return EOPNOTSUPP if it is not implemented by the driver.
> > 
> >    if (WARN_ON_ONCE(!iommu->iommu_dev->ops->unpreserve_device ||
> >                     !iommu->iommu_dev->ops->unpreserve))
> >        return;
> 
> We can add this warning here also.

I'd rather have the iommu device registration fail instead of solely
relying on these WARN_ONs here. We can simply add a snippet inside
iommu_device_register():

#ifdef CONFIG_IOMMU_LIVEUPDATE
if ((iommu->ops->preserve && !iommu->ops->unpreserve) ||
    (!iommu->ops->preserve && iommu->ops->unpreserve)) {
        pr_err("IOMMU: %s: Asymmetric live-update operations detected\n",
               dev_name(iommu->dev));
        return -EINVAL;
}
#endif

This prevents a half-baked iommu driver from ever spinning up, completely
eliminating the need to check for it inside the live-update session paths.
We anyway don't support hot-pluggable liveupdate ops atm.

Thanks,
Praan
