Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7254352031
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 07:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038535; cv=none; b=bB8FaL9k+lxs2/mKeF6NlzZ7GsumULm/kMEPPnukn9SF8Oyh17QeMNqpRZw9asEgJqqRsHAOMRNXzJ19VaH7i4NnDCeumQZ5eThyGPSiIo4taRm2yHbSLT7nP0uckg/wLMST9Wl7/T4DRclHSygUr9xPU7xo5wEG3tRMBuX+Kvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038535; c=relaxed/simple;
	bh=3YRPDdkBYwuR8SskEPhXZydnjWk8w+KTKFKsHSALymk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1A2pJM2jMdeQM30PZW87eXwAAJnzUQutSBfqNjywdbSY5s747ksbBC2XIwfn8eRfuCWKkcAKn/C5wtswzsHetIDY9HU4uW7d9P+yiO0IasbBXA6S/Gn/kFKcrmQQne7VOXGaaI7Tymfoqt39hqh0bZugJHqjJl6aBdPHn2t0BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RcRznTxE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcRznTxE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2911f93cso1705ad.1
        for <iommu@lists.linux.dev>; Fri, 29 May 2026 00:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780038533; x=1780643333; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+6kkGTm8aDOuEQx+9gLd0hWMQBKtucSi5H8ZVEqct2s=;
        b=RcRznTxE/naQhrjU1AP41UU+t4N0Jq6P51bxx9dhRGKLAx3V2897Ld/ji6WIegq1VJ
         jm+FGqIUywC5Mg3hswfxxg9VbYlso8HnvCgalGwgTxMSny+S3E0/4rJ3xqtDeoI+sNUU
         MHpVuZhjCvf7271WKa2snJiz6+NlkS5aFeSBzhnDVhfKruuCfLy88cYN0E08LlklUTQO
         r7G4VF4+XkOFASeW0rxQ7HEhn2lSeQWqCnbCqjsyyei/pC5SC5IE8wtaa/bTD9yjhmhS
         A4w2nbFjGBpngUKVPysVtKD7aqg0PikMZXzuLjkbXo+Mijm+YwYrQXpuLYKaTHofiij3
         5cKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038533; x=1780643333;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6kkGTm8aDOuEQx+9gLd0hWMQBKtucSi5H8ZVEqct2s=;
        b=YIGXN9/nliQYM2c6a1t2rMVNb+7LB74AqVDXgfTJlMK5EQRSZxP+tkyZo6IHpFt14D
         ozLAMs4dkvmaXTcszJw66BbSHViuzWMQtnnmtsZ0IQlIdiC6zKHP+jsqKHoVMVeXp5EH
         oHK96LR+TmTayyrtupaZRPl5N4OGLl1wl0pNJJrrFHSGl8rPcG1mUI1+HCxYYb1eh2h+
         S2FbtTKlRKbDtSsH1qbQuafpSvfiJBShKPsNRtsfMPehLoA3P2i7bURWPLSA0zB7its7
         Lc2KxPRepuEUj2Sqy13hGIyyWb1yXhGHnYdqEmUCNs3yjOv4JsToMznGNLogKrkVGFLL
         UFyQ==
X-Gm-Message-State: AOJu0YzrM4KC/YVjry9jgmissP7Bv8GeT+xZGRhZhltSFY2eywbUJOm0
	pveDqWA/QKj+IYSZjbY1s9URVBvV5E8DQKrrdhs1+8tIUA334Vx/WTcJ8sVAzR6MlQ==
X-Gm-Gg: Acq92OFg3dKi2lVXM/NmOdIh9R3GLNjuVyQb/cUYdfbrCf2UDigGR1mb3jZ4xs16hf3
	DNjDOEB8vKciYzAP5HUYsM3x5qyJCouWeAMkbrxA75Fnz0qjBUcZyRJLN5e9WkB/GP2A0gpS0uL
	srQtWiYYzmxX7mSsmGk//BtrIXBOVDsMeao4Vs4Au8cGWMVi5NonUfcG12dn7WQ76ccJnTrA7+g
	GYw85sKCYqqKdvrSAxpP/mIN5qMRqOop0dBdwZRRHcRnCYXTYPY7Aa80dPsRkahAFaVuJ/NMtAr
	W0feBb5YF3RU+160Sa/DPHcNI+mp5SfVu+ZvaeD+FF+CmUgDXClUMzkrzC+oxMumQI01TjqtUd0
	8IW704fU675CAai/yxkJAmIo3BbElJrQKn1kxOlYBt0+51bp+LzI8AIBQRC53hEfJiXweJJybzp
	ZR69bHT2gMvMNqYzd5joiqanT+KYuN3ta1GEWfiF2kD5LVC3WG/Xi/4o60wAeJDy8IC9tl
X-Received: by 2002:a17:903:1a2f:b0:2b4:58ad:e987 with SMTP id d9443c01a7336-2bf22ee7642mr1033685ad.17.1780038532683;
        Fri, 29 May 2026 00:08:52 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b67b8asm814623b3a.25.2026.05.29.00.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 00:08:52 -0700 (PDT)
Date: Fri, 29 May 2026 07:08:42 +0000
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
Subject: Re: [PATCH v5 3/7] PCI/ATS: Decouple pci_ats_supported() from
 pci_prepare_ats()
Message-ID: <ahk7eomIcbZTkEAu@google.com>
References: <20260528202353.3422206-1-praan@google.com>
 <20260528202353.3422206-4-praan@google.com>
 <2693467a-eb86-4cb9-9161-db6042b0335d@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2693467a-eb86-4cb9-9161-db6042b0335d@linux.intel.com>

On Fri, May 29, 2026 at 02:29:16PM +0800, Baolu Lu wrote:
> On 5/29/26 04:23, Pranjal Shrivastava wrote:
> > Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> > returns -EINVAL if the device does not support ATS. While this provides
> > a safety check, it conflates support detection with configuration.
> > 
> > Update pci_prepare_ats() to remove the internal support check. This
> > decouples support verification from the configuration phase, ensuring
> > that drivers can distinguish between a device that does not support ATS
> > and one that has a true configuration error (e.g. STU mismatch).
> > 
> > Update the function documentation to mandate that callers must verify
> > ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >   drivers/pci/ats.c | 7 +++----
> >   1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> > index 8057c24b0469..92c2a6bc2dcc 100644
> > --- a/drivers/pci/ats.c
> > +++ b/drivers/pci/ats.c
> > @@ -56,7 +56,9 @@ EXPORT_SYMBOL_GPL(pci_ats_supported);
> >    * @ps: the IOMMU page shift
> >    *
> >    * This must be done by the IOMMU driver on the PF before any VFs are created to
> > - * ensure that the VF can have ATS enabled.
> > + * ensure that the VF can have ATS enabled. Callers must verify that ATS is
> > + * supported by the device (e.g. via pci_ats_supported()) before calling this
> > + * function.
> >    *
> >    * Returns 0 on success, or negative on failure.
> >    */
> > @@ -64,9 +66,6 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> >   {
> >   	u16 ctrl;
> > -	if (!pci_ats_supported(dev))
> > -		return -EINVAL;
> > -
> >   	if (WARN_ON(dev->ats_enabled))
> >   		return -EBUSY;
> 
> I am not sure that the removal above ensures that 'drivers can
> distinguish between a device that does not support ATS and one that has
> a true configuration error (e.g., STU mismatch)', especially considering
> that this helper already has a return value that explicitly conveys the
> failure reason.
> 
> Furthermore, if a caller misuses this API by calling it against a non-
> ATS device,

Ack. The idea was that all callers will check pci_ats_supported() before
calling pci_prepare_ats() but I guess I didn't consider callers abusing 
this for non-ATS cases.

> 
>         ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>         pci_write_config_word(dev, dev->ats_cap + PCI_ATS_CTRL, ctrl);
> 
> This causes the driver to attempt a write to an invalid or non-existent
> PCI configuration space address. Instead of removing the check from the
> function entirely, how about adding a WARN_ON() around it?
> 
> 	if (WARN_ON(!pci_ats_supported(dev)))
> 		return -EINVAL;

Ack. That makes sense. I'll post another version!

Thanks,
Praan
