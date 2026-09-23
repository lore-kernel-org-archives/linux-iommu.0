Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154444E73C5
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 17:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790183285; cv=none; b=KZ9wzzUFtEQT0h2mcGdumwTK70+T8209XtCQSyLHMbkNkuUsUzwv8Q/RdHCkM1aPvzzfN0A2/qr8veweIP9ocm08gh0VDFRK0i+r/ORIXL0wm68ezffsMzhEiGcCvc3mFQegwznoaRfPYqo+LjIb7R5NkgbGezq1k2LIj8+T4xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790183285; c=relaxed/simple;
	bh=cNl6b6j0ZD9iEUUf0B0ghdkeaT66llrYIqOEGQey0qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elTIDraMjLN7yBUvgETfnQXzzj7KiRnksS1XabaG5r0Kx1NtcPmGa0xfUk9lGf4gSDUxOBq4m8PLgNyanazxBvSCFNVA3mBMAynf/p9yQcJ2yTDEYG0gJiQNcdMCh8L0FgZ+DMXjfrkFC/xHlSc8Zyx47W1HXoNQZjYcpyFoHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SVZi0vuM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SVZi0vuM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49e65a8f70eso1255e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790183282; x=1790788082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+sWyggwBV1D9IUYjZa6aLkPXJtAz+OTvh2XpzdjOSmY=;
        b=SVZi0vuMGx3BobVbLY8KLjNIzeFZzkiDkQQ+U1RzSVfJYUw6ERltw4dgxeKC48W98r
         Fjn+60ltX3rIrID+u3JOExY8oCIxQTPu8izWMyWmsHZaqi7q92DSVOeTbwm1V5E2ipU1
         O+PpPJUZHS24SkWOfEWfrETxL8BsfrE7jCtUiR/fhDOTXFXV+cEMUP3ju8pvA/A8PO14
         r+bU83eiycbgPQpqhZi/Pf50w04hfqGl7x1UNsevurqNJPJSmNIi7gl30jHACOFlIJtF
         gioo7BD1dyGwCyP/6MmcoXu85x4poEa24MUsGdK/R0FvYrKpzTovp1wHCMFQWqYOzb6e
         eaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790183282; x=1790788082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+sWyggwBV1D9IUYjZa6aLkPXJtAz+OTvh2XpzdjOSmY=;
        b=XCHhReiEhyaxq7stUlUF+HpOjEg0UdcHoYYSXLswd1az3/j/YrsvdqcAZnaYN1zi4s
         eobPLTCgzWTVmaOxoGLo8dFYs/QYyXTXN0Bd2mOtDx2yEesaqXOS0MHl6elahu0bDU9O
         b54kd89ge5pdCP7YGDb9ROdO+0YixJrdQcrxPr8v9qfLrz4c76vdOcIK88TM3mfG25EK
         W4SS0aPjg4086Quh75x3EXbFpH4U+yQPnu4Ib4awHzOdL8s1gdnvWT5sxE3vNuMMSAbW
         XpjSH/yhyJ11IQsyrdcr5Q1FbhezF5pf5GcI1pxUwabRTn9E1/upBB0f1QSnxY14QA5g
         EmbA==
X-Forwarded-Encrypted: i=1; AKwUvBy7AoEmNFQ71jJH7cnuHREcLgpDrlwXIId82sc5eqFE/Sh+toHwZqXZkJCZcNl2YYDceGkILw==@lists.linux.dev
X-Gm-Message-State: AFuF++lFas6savxp/TgscKTswoKi/mmqhp9eohWir1Sve/qpRfe6kNvH
	lkZa+d6oryUu7ayo7o9JPTgkxPYNCFYivY+pwf2rOrqVHHriPoDi3h1FWqiDmWjY+Q==
X-Gm-Gg: AYBFou0Q1oNHbTS+EM8tad8jRG6yz+QJnerLFRYFhrIFgrNqiDqCbKjNeDLYjcx9bmy
	kdz9huPi1YWYOpZA5fk86xqS4tYRlsCDCLwYysWAbEIGZ3kN2SzEyLGYGl7asAm9NcJddFNRpJd
	d2l3orkFjW+rPNztn8u1NNOGURVCut1ma+oX6ES50/3ab0Yz1BmGfDEn21P8r230//btOgsTlJH
	/qWw5cjd1B+4iTKatNZx8JxD3iELpBjhahSg8+TFdzkQdN+QmbRRfbiSd307tZaHnXy6bPa6svK
	22W/b5PbRh0BUt98X4+OFqxNGYY09V8ifyyETZ1x2ELaQ0oYhd67FUJEWX8XjW+ri7et4tkF5+K
	rdBbzEtoAjTml1nyljdlP/njyuZgX5t/Ezfi7cxHnpbY47xs3baHlj+gPAdXMYUs3ySq0QhHxq3
	nWiW5uuh2TETOXX71nSJVPmuiUl+esQiCBzbbtLKaQAogWwwB3IAua9y9gKbX44QmKGBjFY5cwX
	hP769P8LN4VFN0blNS+BCeOcpyPzvCh8qGTBoyR
X-Received: by 2002:a05:600c:4e8a:b0:49f:e185:f3ae with SMTP id 5b1f17b1804b1-49fe55e13a1mr140635e9.2.1790183281720;
        Wed, 23 Sep 2026 10:08:01 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bae53dsm575695e9.4.2026.09.23.10.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:08:00 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:07:54 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com, vdonnefort@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 11/25] iommu/arm-smmu-v3-kvm: Add the kernel driver
Message-ID: <arQHamIHuaUqlJyy@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-12-smostafa@google.com>
 <arMbxX+sqTS3gByB@nvidia.com>
 <arO9hGmEx7c9mZAj@google.com>
 <20260923155507.GJ1540250@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923155507.GJ1540250@ziepe.ca>

On Wed, Sep 23, 2026 at 12:55:07PM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 11:52:36AM +0000, Mostafa Saleh wrote:
> > I can add more info in the cover letter about the code split. Mainly:
> > - arm-smmu-v3-kvm.c: Is the kernel driver for KVM SMMUv3 (this runs in
> >   EL1 and can use all the kernel functions).
> >   The main job of this driver is for discovery, it doesn't do anything
> >   else in the runtime.
> 
> Maybe call this el1 stub or something like that?
> 
> guest_pkvm_stub.c
> pkvm/hyp.c
> 

It is not really a stub and I was following the convention of
arm-smmu-v3-(iommufd/test/sva) I think for the pkvm/ one it can be:
- pkvm/arm-smmu-v3-pkvm.c
- pkvm/arm-smmu-v3-nested.c
- pkvm/arm-smmu-v3-el2.c
- pkvm/arm-smmu-v3-hyp.c

All of those are fine and for the other one:
- arm-smmu-v3-{pkvm, nested, el2, hyp}-init.c
- arm-smmu-v3-pkvm-el1.c

Anything along this lines, otherwise it's too vague IMHO.

> ?
> 
> > > > +extern struct pkvm_iommu_ops kvm_nvhe_sym(smmu_ops);
> > > > +
> > > > +static size_t				kvm_arm_smmu_count;
> > > > +static struct hyp_arm_smmu_v3_device	*kvm_arm_smmu_array;
> > > > +static size_t				kvm_arm_smmu_cur;
> > > 
> > > That spaces/tabs in those two lines look a bit odd..
> > > 
> > 
> > These are tabs to indent the variables, similar cases exist in the
> > SMMUv3 driver, check arm_smmu_cmdq and friends for example.
> 
> Personally I hate this style, it is a huge PITA for maintenance and
> makes diffs bigger than they need to do. I remove it whenever I have
> the chance :)

No strong opinion I can change it.

> 
> > TBH, this is a bit of a hack. The hypervisor can not allocate memory
> > at the runtime. All of the hypervisor memory comes from a carveout
> > allocated at boot (see kvm_hyp_reserve())
> > 
> > So we allocate the worst case for memory mapping with leaf granule. But
> > the hypervisor also need to allocate L2 pointers and the SID space can
> > be massive making the upper limit for this too large.
> > 
> > However, smmu_hyp_pgt_pages() defines the minimum pages required,
> > actual allocation comes from the command line, so it is possible to
> > tune the system without re-compiling the kernel.
> > 
> > Thinking about it now, we can just drop the 500 as this is the lower
> > bound, earlier versions of this series would allocate the carveout
> > based on this size, but it is not needed anymore.
> 
> I see, and you can't scan the ACPI to figure out all the SIDs used at
> this point to get an exact estimation?

I thought about it, but it is complicated to scan the DT/ACPI/platform
bus and I don't think a driver should be doing that; going through each
device with IOMMUs, duplicating existing logic...

And even with that, things as PCI won't be there as they are dynamic.

I think the best way is to remove the 500 as it is hacky, and rely
on the command line option.

> 
> Not being able to manage memory after boot is rather an extreme
> limitation.. But a huge amount of RMM's API complexity comes from its
> granular memory management so I can't really fault that..
> 

Yes, that was one of the main sources of complexity with the
para-virtual approach also.

Thanks,
Mostafa

> Jason
