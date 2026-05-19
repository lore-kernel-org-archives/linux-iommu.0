Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93123242CA
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202563; cv=none; b=ixQExeCRJouulxn27/bVdUAVdar+QMSiYPV4mU8c6V0jR0d8uzw3E5S5l8Skmr5WpohmxHTBPdpLrDEHpAKAJa5Pn+YPnY5Lxdhx2QsmOT1ug7CLW3eBi4bCNTwk8Oy6qZEBFboqwq8BSxCB9mmulZCiAA7JAihzXP4aABjOjPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202563; c=relaxed/simple;
	bh=UTruZ0htNrfrig+4Zj/f+VTgHemhS2OQ5ihVLvJ2sCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0/KT8YqMFQwmv2O7t+d2TRplng52VbctB45hA4zngEFhSxj6p/WNiW1UEDD4Kt3D1bYUsZlvI2i9VFqw7rLwcbrKGpPJ6nvHRY/QxPoTWNXvGnRgb4RQntCsWMmEfMGtO4ltNKXymf1yoEvo7g0ieAl0lBpKA+2O/KWcpKEwRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aLJEOBGu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aLJEOBGu"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so1195ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779202562; x=1779807362; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UobWovSHeOsX5hqrU728+VOS+TFZATYzmVbruY5nx+A=;
        b=aLJEOBGuN3j/WknB0XgFGVTFxcMHJeYrOZmsOvxVPgy5E4L7Q2V49KK3r/6EZ/vwiE
         Ikn6ma573Yl1IQtn5H/108CnkxSa295atjqHs4xaUJ+z4hoLjfcQcAMwf1NZZqZYO1j8
         /WaR8kZBdSYzHsc0Hb23nkHmWFI6e/YZidBTT+nBdqVp+6Ae3qxT1baHAG8z86DvkHrb
         tyg+LSK6ffK1k4XJmgvbLa2KziNgYoFDw53chF40Obpa9lF9dJaIVS5jFOLYcpKeG4EY
         xS/rHAV3KS5hC+/J8KFgA4z4X/a7F4/bihvbxzJ4NJUBcRXgcr7gwgXlXbkWxVN2scFP
         w8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779202562; x=1779807362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UobWovSHeOsX5hqrU728+VOS+TFZATYzmVbruY5nx+A=;
        b=VuyXwfa6ljKfguo5VYMR5ux355ul78tixCirSOBsBkBL2hv7KlXX5s/AoG5MiQwGlm
         QJRitJoNGO90CzQXbDKax5h9QGpKBRyJZPalW+zG754yRY8C7QYJSPsBuhkBiOdMTdWT
         bmSOy5lUwTORcmlKmzIK6Vxjd7+O0vVB6CRoArWPF2pLLZqlpaoa/hLrlYSifUQLKJo5
         JWx/gR0Yge7OgzXERlGhet5DGGLMS0ggyScoQbSTcMn8gsyPqi4gvXvefpVLwmSReHH4
         /1+YyKXQ4ZZj6BYbZ1uApAnDswmuUrJYI/Ms3niWPk/EUZNHMfLfquwVmo1RG1KzekCU
         oCQw==
X-Gm-Message-State: AOJu0YwR60CVZCWq7qBQ5roekee9k/0PFrDrsbGD02GzGOBwcUU+YshY
	BKwC0LNLSShhhESGgwoyXz0ixZjOkJxngeQYDXI3rqGSs8oyjXCY3Rboa2cA75umCQ==
X-Gm-Gg: Acq92OHxG75CoUWj6ngdMTrioqLWr38AlY8ZGD5J6FcheQCGLGKCubrYo7t5ngEOonb
	CQIkstvG8MfhXVw22xKpn1lYWKcdSNxNL35bDOGX8tloSrK+Pc/D/FLJP8AHXIWpwV65eXufjZv
	c+j+SEaLQk2N3JjZMXJaxyToOgupR9oPq2U5HNLJPsrB6uuOgyXYlcAQNbVRbqRfSHuOsUVx79J
	S/xVE8dFOjMLd1T8zRO9QqlAC5a04T+4rnFWiSf+Zq+l3wCvJ+GnpNtOF/3w9bpXGGNjXrncMsX
	6ou77p/MRuMIyx9GJaf/FfJPQnSkK94NvGdmguajv51ETZpiOeblS8jP+5XJnbYVqE68W9JMJ/x
	xzb8EeXxqP4WHLULavWMyqfN5z1pVEQzPchVFqaFzSU+Klhi5SoJazm4cR0fVn2YALgoXtlT4kR
	kw5TpquAB9uWTxN8P06Qps5S35/xPX7qmwgZs7gdUFb6DN8mICtJByMzgPbqGmkbK0X8dsOUtxe
	uGMEVU=
X-Received: by 2002:a17:903:2a8b:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2bdb04114e3mr6771465ad.24.1779202561421;
        Tue, 19 May 2026 07:56:01 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe47c8sm190356995ad.51.2026.05.19.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:56:00 -0700 (PDT)
Date: Tue, 19 May 2026 14:55:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <agx5-jFkU2skyEos@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519144430.GI7702@ziepe.ca>

On Tue, May 19, 2026 at 11:44:30AM -0300, Jason Gunthorpe wrote:
> On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> > @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
> >  	if (dev_is_pci(dev)) {
> >  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
> >  
> > -		pci_prepare_ats(to_pci_dev(dev), stu);
> > +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> > +			master->ats_prepared = true;
> >  	}
> 
> This should fail not keep going, it is a kernel bug if
> pci_prepare_ats() fails.

Are you suggesting it's a kernel bug if the STU doesn't match?
IIUC, it can fail because of the following cases (including the PF STU):

	if (!pci_ats_supported(dev))
		return -EINVAL;

	if (WARN_ON(dev->ats_enabled))
		return -EBUSY;

	if (ps < PCI_ATS_MIN_STU)
		return -EINVAL;

	if (dev->is_virtfn) {
		struct pci_dev *pdev = pci_physfn(dev);

		if (pdev->ats_stu != ps)
			return -EINVAL;
		return 0;
	}

If ats isn't supported or if there's a STU mismatch, shuoldn't we just
ensure that we don't try enabling ATS for that device? 

Returning an error here would fail the device probe.. which seems like a
big hammer for devices that can't reliably use ATS.. I see Intel and AMD
IOMMU drivers don't check the retval for this pci_prepare_ats but check
it for pci_enable_ats.

We have a special case in SMMUv3 where we pre-allocate stuff in prepare
but actually enable ATS in attach_commit, which IMO neeeds to be gated 
based on client device's ATS capabilities?

Praan
