Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBD93D301B
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 16:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515640; cv=none; b=iyQaOkL6JGhzQTOpFrNcy8ndYF59/wXvhvLgel3ATrDpJBtImRgnWpNamhhFezdoHbL+4/UXSr21vWSoIqnQnBv8t9EZ54j5W2ugO/XczaazRsvugkdk9Y3LQnC6wlVRfmNT0yxFUVepof+PgbusMVbRk5LpbmkZziwLWIJFKN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515640; c=relaxed/simple;
	bh=2SUghpFDdCu0lHDEMeEu7bxOXhHv2vXRxLxKKa+EJAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TXWDKNcO9su3AfDywBFc0ycz62JZQBtkikzlxXKY4nzhqa5ZDPQJCP+JyRfl6cU8aF6SDhP6Ps2MwlOB62ivcR3jLSBnLn0G7oW/+U4lwR69xfjqeNkcJcb5KmNTpC/4sBzwt0G93ezyRGxIbdEqJX9neUkOeToVly+jpr8XdDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PDdLDJqQ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PDdLDJqQ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ba180a022dso85ad.1
        for <iommu@lists.linux.dev>; Mon, 11 May 2026 09:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778515639; x=1779120439; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rueWGtmi0URcaWlYJW9AHk5rAqgIWokqrrvYb6vzEKs=;
        b=PDdLDJqQYRcirbO4MK/h0OBV4pnq7wItV3zJENHB0EBGP1CT9U92tQxdzn3fTv80c1
         uZgr2CAK0K3Lo3n4FGDtpkBP2SPkkM/htSki8/CDg1nQtFBAYGQHQiIYbXGh1VyMxWfv
         YMDLDT0d7hRzwYz9KZlUxCToDdwZATLQhxrH73OdbWhpt/GPk9I8zzIPEGIAcDJy6Lxa
         LS1TnWZ5G6ZYN6KyzdqgdkMKqRbSFVYzd3jtFY9IRYT2cF7zqOuCa8OPMatiS+OWUOOD
         P8a9DWSyDjyVQ81MA5QMGQ5ZLDJAH3YpbWd3mLrfpfEWUPwxDuCsMOOhRhM2JUg70kg3
         8cPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778515639; x=1779120439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rueWGtmi0URcaWlYJW9AHk5rAqgIWokqrrvYb6vzEKs=;
        b=YehECaS1eitnnCmcsHAjkW1FEXSuqsbOSFCyPd9jhrJu00MQOCB3qyCDE4z/JfWiMZ
         amDCVXr+WGE51VLsjTmiTugTPR5+amHXGbjMgWud36MHvCGwecNIHCm62LV4ecZJ5+tI
         p5pvXCKki2IkMrIsEYzNp29hcnDfsl3KW3zgWmDCNJi8hnpnfDIyLjFNCkV7OwQamj34
         LrZqsz64XW3KV2kf8QE2dZbGqOdH2IQmpJs5ktlPkgLuZIvzFZ4//pqb9M+UTaCP9Ua5
         YgSzI1jfEWlMNDe0SNVaCTjpnUAZ1kLdTR+hZrTuBTCalgyWIE1aXSDI9Sn8dHDR79QY
         WjLg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zh47Mmn35JrdSmBegRN/4Y96al5u06QB11Cbz2m/NqrRyzErXFdbgNepzTqTc86HBPSOTtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm/AXo6h4bl9478AavLRcJbdbYnT8FQmN1tBuAMFlrLGT/25+H
	QDFOIlgeGdddplA29iHQUV9zGy5Y+4Ni6PaCldB94iVtwmjN89zmL/h/RPv1sk7Hqw==
X-Gm-Gg: Acq92OG8jePefTz+9/VMIVSur293uoUysFEUI5Ekkc+mwHsLsuYULvnBeg8I/n/Tbv0
	i4hBxNFXhzCZj0ZzC+TkqwZFiQYttkJa1G72jMrH7PCO3yNJl/x6TCA8e/SuG9hAPCuguDZBLic
	st3WOkJ4t5zgum61/dnoEgGggroGkQzL9HCTSzstF3Z0/OQ8+mg6039D7Rg1wZC3cWkG8CWHWpH
	UenA11G8zdaLTANKS5mUeXQtZJnSCKlIBZQoa2ZGuMlUsuZ6GEifJPS+t09CYDwZUkFDVZKFOJ4
	OC/7t3Krw2olRLcChYjA49kzcT0IWFVOTBZ4fnRbB+gsbIagJfOAxijuqncAVjU6zt50q+byaD7
	9HdhGFUsmz93DDw1shWtASL0zMmSvBxJRdk3+wImqUf/SFN5RCDK+zENG+3U2UZsRt10RwXQrkH
	h9IVFcQx7V2bhsxA6cxiCwsmaz8FYxNllMH7Bu6lzqcmAhmnuCcizPWkC25JpVyCiH7ykJ
X-Received: by 2002:a17:903:90c:b0:2a8:ffed:4663 with SMTP id d9443c01a7336-2bc747c2186mr6018285ad.12.1778515638084;
        Mon, 11 May 2026 09:07:18 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ac4d713csm2377a91.0.2026.05.11.09.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 09:07:17 -0700 (PDT)
Date: Mon, 11 May 2026 16:07:10 +0000
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
Message-ID: <agH-rkumGS1vX4dv@google.com>
References: <afj0cyBZwkVLyIwK@google.com>
 <afoWrn/RXxDmcHsS@ziepe.ca>
 <afpdm5lfIeWptxOh@google.com>
 <afpwCIjQXwfImPXm@google.com>
 <afsN9jrsfuigV+DM@ziepe.ca>
 <afu5Y55W5oj70b5v@google.com>
 <afu69hAtkRlI1GJd@google.com>
 <20260509171451.GG9285@ziepe.ca>
 <agHGaJfwPr7-F1z2@google.com>
 <20260511141607.GN9285@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511141607.GN9285@ziepe.ca>

On Mon, May 11, 2026 at 11:16:07AM -0300, Jason Gunthorpe wrote:
> On Mon, May 11, 2026 at 12:07:04PM +0000, Pranjal Shrivastava wrote:
> > 
> > > Thus the quirk should cover the VFs too and also disable ATS there.
> > 
> > I observe the quirk does apply VFs but after the VF's iommu attach
> > because of how the pci_iov_add_virtfn() is written:
> 
> Ah, that seems to be the issue then :\
> 

Yea :/ we need something to ensure that quirk orders don't impact sanity

> > While, we can move this quirk to be in fixup_early / fixup_header.
> > I still think we should add checking the PF->ats_cap within 
> > pci_ats_supported before bailing out happily (return 0) for VFs.
> 
> I feel like this should stay in prepare... supported is a differerent
> thing. Maybe the quirk should be more directly tied to ats_supported
> instead of whatever it is doing now? The ACS code calls directly into
> quirks for example?
>  
> > > So I still think my original suggestion is appropriate, fail to probe
> > > the iommu device if ats prepare fails (serious PCI layer bug, like
> > > broken quirks) and fail to attach the domain of ats enable fails
> > > (serious internal kernel malfunction since enable must succeed if
> > > prepare succeeded)
> > 
> > I’m concerned that refusing to attach a device because it isn't ATS 
> > capable is bit too aggressive.
> 
> Sorry, I was thinking prepare fails because it *fails*, prepare
> succeeds if ATS is just not supported and won't ever be enabled.
> 
> But these odd cases where prepare sees ATS as available but can't
> prepare it should fail and that should fail to probe the device.
> That's exposing some kind of kernel or device bug that someone should
> be fixing - exactly like you discovered here.

This is actually a little weird/funny...

For PF: pci_prepare_ats fails as it sees a null ats_cap (quirk applied)
        and fails at pci_ats_supported().

For VF: pci_prepare_ats bails out early if (dev->is_virtfn):

/**
 * pci_prepare_ats - Setup the PS for ATS
 * @dev: the PCI device
 * @ps: the IOMMU page shift
 *
 * This must be done by the IOMMU driver on the PF before any VFs are created to
 * ensure that the VF can have ATS enabled.
 *
 * Returns 0 on success, or negative on failure.
 */
int pci_prepare_ats(struct pci_dev *dev, int ps)
{
	u16 ctrl;

	if (!pci_ats_supported(dev))
		return -EINVAL;

	if (WARN_ON(dev->ats_enabled))
		return -EBUSY;

	if (ps < PCI_ATS_MIN_STU)
		return -EINVAL;

	if (dev->is_virtfn) <---- THIS
		return 0;

	dev->ats_stu = ps;
	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
	pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
	return 0;
}
EXPORT_SYMBOL_GPL(pci_prepare_ats);

Ideally, in such cases I'd want VFs to fail at pci_ats_supported itself

We could either:

1. Add this directly in pci_ats_supported:

if (dev->is_virtfn && !pci_ats_supported(pci_physfn(dev)))
         return false;

OR 2. we could have pci_ats_supported call into some ats quirk helper.

We need pci_ats_supported to fail here because if we contain the failure
in pci_prepare_ats, we'll see pci_ats_supported return success in attach
which will make arm_smmu_v3 believe that ATS is supported..

Thanks,
Praan
