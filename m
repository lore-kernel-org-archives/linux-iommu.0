Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2765822A4EE
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777923196; cv=none; b=R5+GB+p40z3564jUSyTm/qYUbjsWnvsFc4ujyPsdPZYXzrJDD/WE3DZGgN8yC5y3Szu0gAujkJz3wy1cEnMHY7U+4t86UurnK6v0NtAuVBjQgCV/GVN/Khnt4PRlOea9psYDCiRRPGaKNAsXARlyrIv9SReq23MWxKPnvlYUhh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777923196; c=relaxed/simple;
	bh=mU4IPVkfTcGuiDTvA/XnalQI16QfsCyS4EkwRGGZgJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnzKnkY48IVZ4oCOtXP5xZRPzVAi7qnFBBlklX3N57Sd9lKmfscXw79E+aLFokZPkxlKlT4sAhiEnS+qpu99P7jM0UezhdGwH087Gwty7RnXiS/eC8YIGl8EEqBOylBf6goiKL6puqM4UYkBYypyYK5APiX52/Zi+RWJj7M6M5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZqetakEI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZqetakEI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba180a022dso1245ad.1
        for <iommu@lists.linux.dev>; Mon, 04 May 2026 12:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777923194; x=1778527994; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8341Zd4ezCwu9ZlJzqGINTBHGZzhQ8U7k1LE549Gnig=;
        b=ZqetakEIicBQ8wBJaAaZdR44GZjcHaz2Vge9itWr2nevguYlf2Cd87+GpTve3RYPjj
         rwt14qMVAwZ/9E/lEn0TdxnCOAAFKA6GXvzVP5lLAFyx301xbBRMdKAlY+r+M3EthE2K
         LJMZB3wpuC1KYjnsijAGRtl2IIGx1ih96gBoaXU5dFIJGcCHQPP7uD5rhhq12nQ4LZwo
         1zx+V9t8Ct0rPHCkgKtpUXD86rixO1Z3oEL1rYcR23bfKCaM7Hn62dtvZAHW5mpkrpEi
         AVEwZ84tFthSnixyWRRRbT4mRd2a8EljWINmRX1/rBl1m3R2ko8YpSm2RmioWqgQDvGA
         HcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777923194; x=1778527994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8341Zd4ezCwu9ZlJzqGINTBHGZzhQ8U7k1LE549Gnig=;
        b=TaqTbEd4kNokOkJ4QWo25YHQUcpK+2EvUhFAlrzGP7bpL1cfRZSNpWu4KlZc47xnlR
         /pwAR5gnwZ9uhwbc5hg40R7mbi8GAwHJlk4L6BsVv25hPMwQF29xYuAkZAxAYP6ckEmq
         OxTuCyU/irJlvu9FBn0wQ5KvezWZADPyyA5wMdxNI+D6iw+YTfe3PJZRW+l6pknDqekJ
         fl5juR8RZ11e0SNdWZETiQPKbnw7XMAEpZs7CDdzT66N7PDrvWyTmGTbgbHvBTIJCBNe
         sD2DjFu2pVstrzf9aY0BM4MmI3KR/gdVvzCA9O4DClwyRvtL9S0Q5pVQm6nHK+FOi1zU
         sOvg==
X-Gm-Message-State: AOJu0Yz2xmq869LjGiz+hbPqv3ZK87jswjHOTQgO2tkE/9fZf+bya8Ol
	S8tIxdXXRAMoacu+6Y/1kwvIGnElMJDOOsWyW8VNKbzWnJ1Lfpj0KltQnnUPbEOzWw==
X-Gm-Gg: AeBDietNzzecR22aOK330JzmdfHK3IQM0NEDUab3cBaKXwvWy4ygWVtvQmzAyrYcior
	/+GfG/8XCIywmf2O4Lj1tPE1E+BAHsJWhriWY8WSItxyA5wj/dB9ZpuNZgK2hiezP8A3dUgymDc
	i3lz4eKzxcpmKW9nLlBK+4/6HhPThMhrW6XzByNBnQtshxb3AHnrgER7milgD5bQ76hjGGxpMuB
	ElbWEREhRKpWaSToe6ZFSc/XSxl2U6iaLACW9kClbvuEtDGxdPrOuWuUCJOUNsbmaAZMc/mCFPk
	aKsxBlcmUVRr1JZXWWmARj3/nOQhzu5HdYmQYSWSTQ9HmeRr81n/He8nU7mfjoNLI0G71zGlGwi
	Wm9+YZmhTUDjO0DnpSV34i+jsv5pabP0QLy0myjJv9usDbvsno9Ib0szUqi2QGIhAWyTHFCGu1R
	VqAQAxpfYXGpm9ZMHtQ+mcYqaaH0ZOJH/GYeRAty9rbxbB/cIKgBRX91aCSB2n6tgEQ+maEoAcB
	mwkNlY=
X-Received: by 2002:a17:902:d2c1:b0:2b2:5931:5950 with SMTP id d9443c01a7336-2ba4f7ae96cmr811095ad.16.1777923193833;
        Mon, 04 May 2026 12:33:13 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caaadb1esm117532125ad.20.2026.05.04.12.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 12:33:13 -0700 (PDT)
Date: Mon, 4 May 2026 19:33:07 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH rc v2] iommu/arm-smmu-v3: Fix inconsistent ATS state
 tracking
Message-ID: <afj0cyBZwkVLyIwK@google.com>
References: <20260504163842.2692314-1-praan@google.com>
 <afjfBi+vw/Ywkzid@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afjfBi+vw/Ywkzid@nvidia.com>

On Mon, May 04, 2026 at 11:01:42AM -0700, Nicolin Chen wrote:
> On Mon, May 04, 2026 at 04:38:42PM +0000, Pranjal Shrivastava wrote:
> > arm_smmu_enable_ats() ignores the return value of pci_enable_ats(). If
> > pci_enable_ats() fails, the driver still updates its internal state
> > master->ats_enabled to true in arm_smmu_attach_commit().
> > 
> > This leads to a state mismatch between the SMMU driver and the PCI core,
> > the SMMU driver operates assuming ATS is enabled. Later, when detaching
> > the device the driver callspci_disable_ats() because it believes ATS is
> 
> Missing space: "calls pci_disable_ats()"

Ack. I'll fix the typo.

> 
> > The issue was exposed under heavy load when running a VFIO-based DMA map
> > stress test: iova_stress [1]
> 
> I wonder what's the real reason for pci_enable_ats() to fail:
> 

Yes, It's the dev->is_virtfn case (the one you suspect below)

> int pci_enable_ats(struct pci_dev *dev, int ps)
> {
>         u16 ctrl;
>         struct pci_dev *pdev;
> 
>         if (!pci_ats_supported(dev))
>                 return -EINVAL;		// unlikely
> 
>         if (WARN_ON(dev->ats_enabled))
>                 return -EBUSY;		// unlikely
> 
>         if (ps < PCI_ATS_MIN_STU)
>                 return -EINVAL;		// unlikely
> 
>         /*
>          * Note that enabling ATS on a VF fails unless it's already enabled
>          * with the same STU on the PF.
>          */
>         ctrl = PCI_ATS_CTRL_ENABLE;
>         if (dev->is_virtfn) {
>                 pdev = pci_physfn(dev);
>                 if (pdev->ats_stu != ps)
>                         return -EINVAL;		// maybe this one?
>         } else {
>                 dev->ats_stu = ps;
>                 ctrl |= PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>         }
>         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> 
>         dev->ats_enabled = 1;
>         return 0;
> }
> EXPORT_SYMBOL_GPL(pci_enable_ats);
> 
> > @@ -3051,8 +3051,9 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
> >  	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
> >  }
> >  
> > -static void arm_smmu_enable_ats(struct arm_smmu_master *master)
> > +static int arm_smmu_enable_ats(struct arm_smmu_master *master)
> >  {
> > +	int ret = 0;
> 
> Seems no need to set to 0.
> 

Ack.

> > @@ -3635,7 +3639,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
> >  	arm_smmu_attach_commit_vmaster(state);
> >  
> >  	if (state->ats_enabled && !master->ats_enabled) {
> > -		arm_smmu_enable_ats(master);
> > +		if (arm_smmu_enable_ats(master))
> > +			state->ats_enabled = false;
> 
> This alone isn't sufficient.
> 
> First, prepare() does:
> 	if (state->ats_enabled)
> 		atomic_inc(&smmu_domain->nr_ats_masters);
> So, unsetting state->ats_enabled would need to balance that:
> 	atomic_dec(&smmu_domain->nr_ats_masters);
> 
> Then, arm_smmu_master_build_invs() adds ATS invalidation entry to
> domain->invs during prepare(), so a per-domain invalidation would
> still send ATC_INV, which is probably ok for the PCI device, IIRC.
> 

Ahh yes, I forgot about invs array here! Nice catch!

> But the device's ATS entry would not be removed from domain->invs
> during detachment since master->ats_enabled is reverted here, which
> would be a memory leak. And reverting that in domain->invs could be
> a bit painful to do in commit().
> 

Hmm.. because we set the ats state in prepare() but turn on ats in
commit.. (no state-change races here due to the asid lock though)

> I am thinking, maybe the call sites of pci_enable/disable_ats() can
> check to_pci_dev(dev)->ats_enabled instead of master->ats_enabled?
> 
> Then, we keep master->ats_enabled as-is, so detach() can revert the
> nr_ats_masters and ATS invalidation entry in domain->invs.

My suggestion in that case would be to update arm_smmu_ats_supported to
check if the client is a VF and check if it's PF enables ATS:

static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
{
    struct device *dev = master->dev;
    struct pci_dev *pdev;

    if (!dev_is_pci(dev))
        return false;

    pdev = to_pci_dev(dev);
    if (!pci_ats_supported(pdev))
        return false;

    /*
     * If this is a VF, ATS only works if the PF has already enabled it
     * with a valid STU.
     */
    if (pdev->is_virtfn && !pci_physfn(pdev)->ats_enabled)
        return false;

    return true;
}

and then in attach_prepare we can add the ats check for safety:

        if (!state->ats_enabled && master->ats_enabled) {
                pci_disable_ats(to_pci_dev(master->dev));

+               if (pdev->ats_enabled)
+                       pci_disable_ats(to_pci_dev(master->dev));

	/* Rest of the condition */

	}

WDYT?

Thanks,
Praan
