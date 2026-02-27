Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D23B27381E
	for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772200951; cv=none; b=a7HMxf3i5EA2ymeLY5DUr9G4Bn9jincNIHZWXHbfPbM9/cqUdRIPl3pueGOgbdXmUaVsCiWMU2kIzoD6ubbLQpNwG46aUDCRsmgsoZz9mApn/lHU2YcumQNh9cPtTQC5OKEOv5SNyULwVYXzOsyGWwvFzMd8ybQk14Nv6Y+4l5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772200951; c=relaxed/simple;
	bh=aSRqMKxcrbPd9RuiBTJW4IA9zU5KmfnxEfx5aGDc9B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N7e6OuPGllsyUXrpdnn+1MeEU9v//sH2EBQer8H2EGw9E/XeZJP5+3YAw9ypJ9Z+pDDTFxRXBld/40yWlHBiKXCY6MoZfm6SoRAPq7mfPspBdFAAXpfDCznBnBfMm3vZfy0j61mP2Ico+3t+F0d6/nOT+d2HClGv00SYdy7g6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=IsFPOPMc; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IsFPOPMc"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5ff19e74779so1422546137.0
        for <iommu@lists.linux.dev>; Fri, 27 Feb 2026 06:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1772200949; x=1772805749; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hQdUXbHz/SW2fZ5RpnaB8oeuhylG3PJBhh+z4+fhm0o=;
        b=IsFPOPMcEneiE+zP2wSUGJ76B8F6bNA/1gT+VOgY6QUsSrcePuAPl2Nf0bHEYW+cAF
         bxA/YA1Bf15vf2aRe7AJ+rejVXW4ewDx54amRvBSK/x74g1Iboy9swBm9+vJdNJNKBy8
         nr6tlCH3HRzi7cOclyHoN1cwsP4X9/BUUN4hZR1Httvu/l5z8E7mwMklMAtWHszTkV8a
         6hBHQEjpoYTASweOkBxuFHEboFL2p9qzNNx71x3fnL7HyfmEqrWwWPVf1j0EkTPCAPR7
         H5aOxZkdcJpakZgmfXGr6k9KNV+ZdsD8Aw0Fjvjx3YPG1J1CR6X8hEVtCsHNZED502Aj
         O/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772200949; x=1772805749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQdUXbHz/SW2fZ5RpnaB8oeuhylG3PJBhh+z4+fhm0o=;
        b=XtBl9z8JlbdNEXIJxrTdQwMRWEbRpj+OVVro/RVqbRfjS4HiaZoTWzCA6iH5AeZrbg
         WN5pCpox8dOPLetni66jqnWeilNl2K49cXW8z3z18Hb+8RGIdvapenLvNwxMHf2cZxZI
         rV5qDNWmHjOB8xKdQJxZNwTEH78Xz9mGJNtfdZ4lI8cMO1RlOWMTcJMz+fFhOu/UpLLg
         VQaLpmJJdLbQCeNecov83nSkzxVY3X3CDFmSZKWGKxdaiG7wJdyyj4otMdTw+EhcXPF/
         S2+2k9anrTcuRO+3ud7m0Js8YDNi+o0FT/Pcrgj0de0RXtWhDFolGonEDGY541p2qiXU
         wOBA==
X-Forwarded-Encrypted: i=1; AJvYcCX/pdAPkL+CPsj1VQ/ZmbsAd4jCYJJYDVniRiA2waBbYTgLIsYBRLXOn84O+q3c62ILbFs10Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwXN4r6B6nhIVK40RlKfSa9ZGdviRIUBJHOfMPIPITFiBZlhju/
	7KbXu18//mxjzoemynzf1YAc3wxM4ZQBmgPXkY+6ldibEMgYBeSGpRa9TQpf8WYKZP0=
X-Gm-Gg: ATEYQzxsqsTGJLHwcOcwpp1jCkm+0jgSUW7Cl0Gd8ey9vkFBcDvKqwj26FeBIuRyiwB
	n2Y4lbTkfMc9pFF6DpkiAoyfP13HTKqQf0vqphts0r1YcF0jpRCVPRRPOIHTPQxFwRccSYysLjm
	R0YkvvV8+bDbRS/io1OQsFzPkwk5f2mGStMzbNRDj23EfV6B7TlT7dlN1M2xKEHG2nUq9U2tCPs
	6Y8MNeE+OBtNNGPBXVSezZLOtBRt9Y0uDjRGBu5vvw7i4V623zAQ3XdNKcBkBPcHur6RuGltyW1
	E73ucp4X4y5byTnPN1MdSCVJdrLOkTJ+J1jKe9hwOQrQyCG4uZMEH67DZVfpy29/4ERO7YnXFXy
	jYEmtXiQKPOrky9YGvMn35jgAKFOWPdFcA0PaOl/gQp4FeL6eGNmr+w+2x1c1kNcHkwP3jk6pkk
	FpuC+1DvnyIEnZuAuVcHTy/CyHLt4YPDc0e9CsGKJCbVeo5ox0yXtJnzv6hE96wP+WpEmpAVzNZ
	aWVNFGP
X-Received: by 2002:a05:6102:32d1:b0:5ef:ac78:3c77 with SMTP id ada2fe7eead31-5ff323b778amr1669504137.18.1772200920113;
        Fri, 27 Feb 2026 06:02:00 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf677448sm464268985a.19.2026.02.27.06.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 06:01:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vvyPl-00000000vPr-2NW2;
	Fri, 27 Feb 2026 10:01:57 -0400
Date: Fri, 27 Feb 2026 10:01:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	dnaim@cachyos.org, Mario.Limonciello@amd.com
Subject: Re: [PATCH v1] iommu: Skip mapping at address 0x0 if it already
 exists
Message-ID: <20260227140157.GH44359@ziepe.ca>
References: <aZ36tRwNP8cRRX1l@ziepe.ca>
 <CAGwozwFPLLFfKP90fFrt-QC1rKPRCVo_iHuLm4roHX7erQ=Y5Q@mail.gmail.com>
 <aZ3/W8sw+gW5aTA5@ziepe.ca>
 <CAGwozwFKTeXW7_tPcUw8pYvNSoS9860mNJ=OUKCt2vEawYVOJA@mail.gmail.com>
 <6bac3817-9652-4146-ab44-2a9518c3b339@arm.com>
 <CAGwozwGXpVZ1ctUyZ79itwcX7RPjeLebFPWDVpNMq6-f_UtF3A@mail.gmail.com>
 <7e3a1d3c-64cb-43a8-bd2f-05b24a8d1611@arm.com>
 <CAGwozwGsh3_M+e35M2Ld7827W=w26-71xGXwgeEBu-ZcZGLACQ@mail.gmail.com>
 <20260227010317.GD44359@ziepe.ca>
 <CAGwozwExiRo9RhXOHj4wLpn6Tq0N_pKwAywcr7=SwAyaaZvNZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGwozwExiRo9RhXOHj4wLpn6Tq0N_pKwAywcr7=SwAyaaZvNZQ@mail.gmail.com>

On Fri, Feb 27, 2026 at 09:06:27AM +0100, Antheas Kapenekakis wrote:
> On Fri, 27 Feb 2026 at 02:03, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Thu, Feb 26, 2026 at 09:40:10PM +0100, Antheas Kapenekakis wrote:
> > > I am still concerned about unaligned checks. It is a functional change
> > > that can cause regressions in all devices. The approach of this patch
> > > does not affect behavior in other devices. I would like for Jason to
> > > weigh in.
> >
> > I think Robin's solution is very clever, but I share the concern
> > regarding what all the implementations do.
> 
> I will send a V3 with a ternary instead. This way, only 0 is affected.
> I will compile test now and test later today. I am impartial with either fix.
> 
> ```
> phys_addr = iommu_iova_to_phys(domain, addr ? addr : 1);
> ```

Yeah, that's a good idea

Jason
