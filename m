Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0501A314D06
	for <iommu@lists.linux.dev>; Fri,  3 Jul 2026 19:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783106703; cv=none; b=hviBLbvUHEjH92BwJAjk5lSerAxyGWr+nXcvUx+9l0csUVtFt4xS5C6FWnWdsfCMREhKc5NJvleqNnEt4l11PRMDZz7gv3AmucZ/rvzgQ14li+qBvNxD40kUkwyDIC34y8oh7KGf1BGH/4HzXDuJgRssdv3wtSAyiK9Ki6OaTQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783106703; c=relaxed/simple;
	bh=yayEeyU4e7p8xCn+5eQp5ki7+IbDFzlKh1940AmQVPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7pdxP504797BaJ8GiADsZ5opdc4O7lGXYO+MbSAKxq8+CJvJKLikE+zBvGOYFlKtN2M6o0yY56O9XIeWkxUFyMYRL6Sdk0nNnaklP7bOmrXQu//pDx6HtxGgtQBwWQD07O2rk5RBEyjg/wAB/m6XQzt6Mb0mrnu6afdpTxhgO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iJaiwhAj; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iJaiwhAj"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e5d6f35c1so72222385a.0
        for <iommu@lists.linux.dev>; Fri, 03 Jul 2026 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783106701; x=1783711501; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NXmfnDT9ccdJDht6GSlGH0hP5z1VNfXLI97+RVOH2w=;
        b=iJaiwhAj4fpw3R6g9U1DbMFo1dtL/Q1wbqNSScmt4Qp0EKs/mtUlpP178BEnYCZ1Kr
         W6TL6DAyeb88S7atM44Ms8RodbX3Wu9S4MnY8/BddhRHXhrLtLDwTwg9ZYCEn0z9CDvc
         FPQwplauQ5c1YL1RLKyit10g/2jT4GCc/Hb9H9BeMvu6JOOKUmas/mOUr0ja+175+IMQ
         Q+27T6zi1VD9NgbKnPLNmd5w4VtKiAlRaoTlyxL5aygLqxnOiNEi80z7RB/Wluyioy/x
         bp4mcjyu9ZnFEa4DsApNF5D7oJF3MP59IjSA9HkJLlcWMrQgD//h5Fj5ypN2409aLpWC
         QMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783106701; x=1783711501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NXmfnDT9ccdJDht6GSlGH0hP5z1VNfXLI97+RVOH2w=;
        b=ZDKSK/J/KUZyAIhykzVkA8iPoB/KrY9Od6wUyjXiplyVu6LPz8fPyiw++kJmATYpX/
         g1dL+Rxm3WBtZR5ypDx11GoiE6r21/Hys3iYhfilbePtgtj4PDK5sKBTSlkK9uySMKgI
         8WWy5dur9e2fzrElZSFkXC4oOkVlgBhi3dJ6BjyPTw8PHSt/REzBL2cNUBdyXRb+UlLa
         X5me91lXAfXFtT2kldyOxZKhBXaB1z+ux4OL5UatqOnM/YHFWdm/xpzZs7trxNw6hcc+
         NT4OxMvsPx8rKKVOicQY1RFYm6EO7NMO52JNeFNJ/zG9Ai6/vWpu9BTiYiXB0ImRwzp7
         iAzg==
X-Forwarded-Encrypted: i=1; AFNElJ+DukWdpcUs9YK8jjFL+jxFxoQWf81P6x3gnW/YeARQOAaoP7FEBOP5WOK2rFHDnMFCtXeYoA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGEKz/7m8JJyj6E5Jw62v5VOp1MhfIZ5z5Kp4zL9S/KPHZkClz
	Nx8Z0wnFxjpckmxsq0mDKAxakDtBQ7UmqLzvvnmKRhZnD0UaWf8fCWNFOGvPeee20lA=
X-Gm-Gg: AfdE7ckDIDOtrtfapOTv6JKwQgn41x7HDnBcq19O+FeQK+HCdZwUvSEjd3P6vfFeNPl
	U3p6sChCMXcpW3ux/FZ4asb5bCEll5y8evetDTLcQA4+o+Z7RAPki5+pr1d32eTi9K9PS2/p/kB
	hTfLhbirDSMHnZ61sQVZCOifHoElD6ag86f+FQ1LJlcI32fJ4sgmh+PBlagv45H8SmJk1/jDXL+
	TIWUwOHZOfKQkggGNCRRuUltZ8HODqeVYfd02RGNqtcHN4Wvgidp442Plx5PXmVfvMzGC2oWAYr
	zRpfDMvqa7lgqh3fafy13r4nmQRITnbN22Iew8uPx80oXP0R6rYHW2PtM8myRwOrpJfVNgr96Bn
	w3xoRZn0OJLlB2r/AYnkTTqkIaPrY2XSdsnD378/jy/yqmtKAO4xa6DxJqUf5heZNfMQ0EjHRrN
	dJC5e2fI3MgD4AC9SP7l6FajRyhamENzsvg3m/ml9IfBwKK7MKlRVPcpjHQWm9AVqQmpM=
X-Received: by 2002:a05:620a:414e:b0:92e:57ec:a4d7 with SMTP id af79cd13be357-92e9a4ed968mr109865685a.73.1783106700898;
        Fri, 03 Jul 2026 12:25:00 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90ccdf8dsm225956185a.37.2026.07.03.12.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 12:25:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wfjVT-00000008UHZ-0qcN;
	Fri, 03 Jul 2026 16:24:59 -0300
Date: Fri, 3 Jul 2026 16:24:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
	catalin.marinas@arm.com, yangyicong@hisilicon.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
Message-ID: <20260703192459.GB1978949@ziepe.ca>
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>

On Fri, Jul 03, 2026 at 07:57:04PM +0100, Robin Murphy wrote:
> On 03/07/2026 5:49 pm, Jason Gunthorpe wrote:
> > On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
> > 
> > > @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
> > >   	if (system_supports_bbml2_noabort())
> > >   		feat_mask |= ARM_SMMU_FEAT_BBML2;
> > > +	if (system_supports_haft())
> > > +		feat_mask |= ARM_SMMU_FEAT_HAFT;
> > 
> > I fear this is going to make SVA stop working on systems it currently
> > does work on, so it might be a major regression.
> > 
> > SMMU HTTU is not a commonly implemented feature.. I think of all the
> > NVIDIA ARM chips only one supports it. Given that a quick internal
> > check is raising concerns this will be breaking for us. We need to
> > check in more detail which cores have HAFT.
> > 
> > Breaking already deployed SVA would be a major functional regression.
> > 
> > I think this should start by just enabling SMMU HAFT when CPU HAFT is
> > on, when possible. Maybe print a warning on the mismatch instead of
> > failing.
> > 
> > Since we can't break already deployed SVA a full solution would either
> > have to somehow turn off CPU HAFT or we ignore the gap in the AF
> > updates..
> 
> TBH I do not know how bad the implications of
> pmd_young()/pmdp_test_and_clear_young() returning a false-negative are, but
> if we aren't considering mismatched CPUs harmless then surely the same must
> apply for SVA. In the POE/GCS cases all that can really be broken is users'
> expectations, if they've opted in to additional security features, but also
> opted in to SVA wherein those features can't protect against DMA. Here,
> though, it's the kernel mm layer itself that's impacted, and I'm not
> confident to say that that isn't more serious.

This has come up a few times now where the SMMU and CPU
incompatibilities in ARM's IP are causing real headaches.

Let's give it some time and I can say for certain if we have impacted
chips or not. I was able to confirm the server chips are OK, but there
is still some concern about the embedded chips..

I also don't know how harmless it is to ignore the aging. I thought
the PTE was designed to be backwards compatible, but I never looked at
how AF works..

> Making HAFT depend on !SVA could only easily be done at the config
> level, which seems arguably even more over-reaching

Yeah, but if you could build a custom embedded kernel with HAFT
disabled in kconfig maybe that is enough for some people.

Jason
