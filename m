Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF58340A6F
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 06:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294870; cv=none; b=Xaz7hy/GJz5J6NSSfe2+WMF5pdxrITg2dZVVIHsbp+D6lQ1ZGsGRYXU4G5UKY9yI3w1d6XTgxF2vTAZ5XcMA989E4ZPjRbbYmYcQNfxEay5guYVFC8fYfOy9HAkrq9ATEICS5xE07wdtH2GDkeRdKQYjbZvgDcOfK/qVVonlgnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294870; c=relaxed/simple;
	bh=0jGCNAEl0yRsxt/VCx8AwwynyUP+qZakeyTXndkIksY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRlztFVQTWLLV6+nP0egwFo0tAKsXHI0epUsR2zJQsjHCf7Fz5xorHxGw/MHV21LeDW+sltngKMEtiuT3zMAS9XReVF06PiyGClH+VQnlQ1MVW4QflWMyyFbfe/Rp2nFCTZkN9KgJuG6tJ4sdTho9PXgX9E7wo5SZyuPFbwmy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtEMb5pD; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtEMb5pD"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2c0b1a48855so2075ad.0
        for <iommu@lists.linux.dev>; Sun, 31 May 2026 23:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294867; x=1780899667; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=soP7J9BuT/6lT7vP2K/RAxhntDj41HAi5S9Movt3ds4=;
        b=JtEMb5pDYIEBPjC3GDCVc66+h4eF/qb3vAKRHtwpOWwZpJdGRauUjKqnh8nyYS4mEu
         N/xepL0bvqG/nEX/y344TLYwLr519EsR3fOiO3t2NLlaiTlaKSDd2AMuMpVeczCwrhD8
         zQqxp20znfctI4Pnt69KyB+pjcBirkcIydqqbNHE0DHgpFaqhueLLSh4aSroVdhLAbkk
         ha+p+6dk5/56JhWU8rD+b9Wagqu4J32fR3lDV22JHEa+bNV3FmQD/2Rykaf6G84KEgkP
         wMiMnE3rGO66dbHeyRpoYVyCqpThD82euvQoCFRD/0n9zFaSLTmqmb4w7PFPelyvXFCU
         C2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294867; x=1780899667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soP7J9BuT/6lT7vP2K/RAxhntDj41HAi5S9Movt3ds4=;
        b=pDFXJM+CkktC2n20lry8Zn8ig5SuAZUnIvpsYeWo7sgkSYbZepOOSXhw2Qz//0iR0e
         Jnbtlaoo60OC7dIRg2N8On+ff2W+T/Ajp5jrpPzjwc4AeAg/T4NjfLzqks33EHRF6RXc
         0VN6SE/K3X/F2F3bsXBZOj2dozsK1B9I64BOHQ4JP2EjDd6OJNimc8j1WO7xA5nRdKq7
         Jfj2iuOt4Mtzdibib607tl1VrQPRnajatN5zx2g1V/hxDAd07wnK939wRCz3shJboK+g
         kiSJadztv3MBasSi1PpUeCrDwB+yNJLHZC6wFf6GtWQMk1nhOefqrnTdEkmHHC6IR4NF
         xm9g==
X-Gm-Message-State: AOJu0Yz9pUAfRsELoJglTnGBCUz5bIpHTOEw5jt1EQzCpc5qiJq3r5uk
	J5U5yC0dgshG4tlDR6A+VmuG4XQ9H0i6C8E+sUrtyCybpwrcSIsee38oWh4R3eiZ5Q==
X-Gm-Gg: Acq92OEfqrRHWgcn9NLPTgSPBxcSm4t+hJ20ZZQbNyobW/TlkiW0xrg1JpbPTNvpm4V
	bB7z1pCG/E0woQv+hgYCchnDF4U1Ymh4yVUfNThzGPwYUCPDkV63XwfWqd9siDgmxzGoJ1wzUZ7
	3NXbqv+FGPEijxoD0tm+0wT2p5MbNBGmW6STi0zViCY5LHgxoPeyOdpqDXs9ORuhq6n9x2UqJmD
	dzIZlNA8dC2Tc7LODFQ1JB1ZK3ha6WQGiI5mk9PCKNmyt78hP4u29TcjVrGG03Hdmo9vHc7P1yZ
	qVzwrh/4vgXlj2eUBLIdw//3Tbl2cReAD35Xv74CmezeQ101ejQvs+pP/BOq9VZtn/eiMxEIJ9v
	Z6/2eAt5XUEF5lLgk2jmNHNs5fQzf0DyXprHEGxCGxQb68pmAuE8OUi4ituFjRhyU1LXEsgLG/Y
	ewNTvglDgxFBsXFFEwT1ynB0UpZJKiS4YjDgQUdut2SQb6ptYALImD3n/8vcePdulrtcPjBTw=
X-Received: by 2002:a17:902:ecc4:b0:2bf:139c:dcf3 with SMTP id d9443c01a7336-2c07cb51c58mr2879505ad.19.1780294866691;
        Sun, 31 May 2026 23:21:06 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8424defc024sm2572466b3a.47.2026.05.31.23.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 23:21:06 -0700 (PDT)
Date: Mon, 1 Jun 2026 06:20:58 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Nicolin Chen <nicolinc@nvidia.com>,
	David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 6/6] iommu/amd: Fail probe on ATS configuration failure
Message-ID: <ah0kyi5asHpnrpgC@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-7-praan@google.com>
 <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <unqzyef2n26wdf6tmc6vvwvpsgv244uvz7cxji4scymqmoofyb@trkzr7ix5bog>

On Mon, Jun 01, 2026 at 06:00:15AM +0000, Ankit Soni wrote:
> > @@ -2502,10 +2508,22 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
> >  	else
> >  		dev_data->max_irqs = MAX_IRQS_PER_TABLE_512;
> >  
> > -	if (dev_is_pci(dev))
> > -		pci_prepare_ats(to_pci_dev(dev), PAGE_SHIFT);
> > +	if (dev_is_pci(dev)) {
> > +		struct pci_dev *pdev = to_pci_dev(dev);
> > +
> > +		if (pci_ats_supported(pdev)) {
> > +			ret = pci_prepare_ats(pdev, PAGE_SHIFT);
> > +			if (ret) {
> > +				iommu_dev = ERR_PTR(ret);
> > +				goto out_err;
> > +			}
> > +		}
> > +	}
> >  
> >  out_err:
> > +	if (IS_ERR(iommu_dev))
> > +		iommu_ignore_device(iommu, dev);
> > +
> >  	return iommu_dev;
> >  }
> >  
> 
> Hi,
> This regresses IRQ remapping in the PD_MODE_NONE branch. By design
> rlookup_table[devid] must stay valid for IR - init.c:2257 documents
> this: "Do not return an error to enable IRQ remapping ...". Pre-patch
> the PD_MODE_NONE branch returned ERR_PTR(-ENODEV) without nulling
> rlookup, precisely so irq_remapping_alloc() / __rlookup_amd_iommu()
> keep working; this unconditional cleanup violates that.
> The new pci_prepare_ats() failure path has the same shape:
> amd_iommu_set_pci_msi_domain() ran earlier and parented dev->msi_domain
> on iommu->ir_domain, but on this new out_err that's not unwound. So
> nulling rlookup_table[devid] makes irq_remapping_alloc() return -EINVAL
> on the first MSI alloc for the device. Sashiko also flagged this in [1];
> 
> Also if iommu_init_device() branch fails, iommu_ignore_device() will be
> called twice.
> 

Hi Ankit,

Ack. Sashiko made me realize that this regresses IRQ mapping for AMD,
and I agree that the call to iommu_ignore_device() is a bit too 
aggressive as it  wipes the rlookup_table entry required for IRQ 
remapping, particularly in PD_MODE_NONE.

I was thinkig to address this in the next version as follows:

1. Split the probe error paths:
   - Proper init failures (like iommu_init_device) will continue to call
     iommu_ignore_device(). I will fix the double invocation here.

   - Config failures (like ATS mismatch or PD_MODE_NONE) will return an
     an error but skip caling  iommu_ignore_device(), preserving the
     rlookup_table entry for IRQ remapping.

2. Resolve the Use-After-Free (UAF):
   To prevent the UAF on the "DMA-only" failure path, I will ensure that
   the hardware Device Table Entry (DTE) is set to a safe state (like
   blocked or bypass) and the dev_data->dev pointer is cleared, as the
   IOMMU core does not invoke release_device() after a probe failure.

3. Fix iommu_ignore_device() infrastructure:
   I will address the pre-existing bugs identified by Sashiko:
   - Fix clearing order (calling setup_aliases before clearing the
     rlookup_table).
   - Replace the non-atomic memset() on the hardware dev_table with an
     atomic DTE update.

That said, I'm investigating the safest way to revert the MSI domain
assignment on probe failure to avoid the dangling domain issue pointed
out by Sashiko. Maybe we can add an amd_iommu_restore_msi_domain() helper
to revert the assignment made in amd_iommu_set_pci_msi_domain() on probe
failure?

Please, let me know if that sounds okay?

Also, I'm wondering if I should send this as a separate series specific 
to AMD which is unrelated to this one? Or maybe handle AMD IOMMU in a
separate series altogether. Let me know if you (and Vasanth / Suravee) 
would prefer that?

Thanks,
Pranjal
