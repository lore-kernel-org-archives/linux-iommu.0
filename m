Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D62C341661
	for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758033028; cv=none; b=DsVse0NgdnpOC/rQjFkGT2E2c+MPs6c6zMJ89xhNtghnsPAgeP69xbQUsfARwmjWOU3c8Erz+GLXWKTjOqNQmOtLgP7CnhVOa6yKs5zYLiPmkMD9IpRYTkQa8cPFK3Q/9a4P0Du29cCphfMHamIrnvFpumpiQm0we1OliR/rRKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758033028; c=relaxed/simple;
	bh=lXDcSFWQYp91MNC66yHZBJWni2JhoTUG5cLOCWW97Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bl5l9M/HkJlp6jMIr5GxyRoSNJG999dL4ezjjIw66sqB6PszhBzDfpJxeUTo0uTmDh2ArDokcO5CYHZxzRCcSQekxBV2oA3eJDwToymTToqrQFfwTBGH4yq/Rrerr+Z73xjCQDkC+IOsDUwj60VYxbBliLGGImWdDt9q4jFJyRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5IAwGEn; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5IAwGEn"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45f2f894632so57015e9.0
        for <iommu@lists.linux.dev>; Tue, 16 Sep 2025 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758033024; x=1758637824; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhmMdRL8qlR3Tvk3u8O3tOtlAqkQkVluaZ5zKHg+950=;
        b=g5IAwGEnUvNRYKCwJX6TPolrheK+nD88x5JxCcbE9cL/+fe0l9dI7R34NC6gLdxVKw
         U6j9n+k8otRPVXEKEuMCJoWe/nuwkRVf2+NPWKM3/OyZ1atg7wGd0GJfCFd3K8pt2Khv
         CzncIOpKaEPc+s4y8tJXuADtUuYtB9XTbRq5T3g2cPGAGYBirLfLKewFhcjh4nh77B6I
         VxtgZNNKvnQi0TKkElIXQQz6yV0f/nlaf855r/VrBlkZFWyniY7EcZyrJ4mWH86trAMU
         jh41TXdev6nLcRjatSBmUU/4RJCAmhE6tB0m3Ckd/7aTGPiojhh3ZPqDBBkR8iN+xTqc
         ST8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758033024; x=1758637824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fhmMdRL8qlR3Tvk3u8O3tOtlAqkQkVluaZ5zKHg+950=;
        b=kVcxvuciQn3UD4TANaviXZbSjd569ji81Mg/jJvxRFd7Ie4IVpCrljrI1df+GSLhpN
         SlZDAcPoSfTj+WAFEijTMUeVfPjZQokcOaVyxylLEijS5wPkeLMD27N5subQavz2iuvg
         5nqYlKAXKgXhOTXuY4VCFNWFhGccc8gI0X8bgnxwXQPgyM/Aef/Rd1zFmSptrU8gj5jJ
         v9oMB02+yaHTkXQirUfDew2p4L70Houkt89ia3odJ56RuEmoIyr3MlME9kGIShyEKpZ+
         tCZ9ynK2M+DkYuHGFcAHDgcy3ADMyO26NQCUpUmIafMQlaBQKPDf7bbDksJFQafoDqNa
         2tNw==
X-Forwarded-Encrypted: i=1; AJvYcCXtuaADmQr/gQQKzjvfrs6zqaEe8SQ/iELXp9QAjKN6gEXEvz+rh7ClZeFOYsbDmE6jq8GSzQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxYeadH2xtEw3FosXjkeyDPD2pj0rw0A5Qv87kC6hQD+P7C5CHz
	XzkoL2SorELdIC4D9yVzmPImr59Pzx65IvKG5MJ5t13UAX2/DOKYTc+K/psR67xJZQ==
X-Gm-Gg: ASbGncveHM/xyBp5Rs8LOK5I4IM0gCTML5CFdbfqlOfYOmhOf7npBqXMcjuHc5neE61
	Z5+d/nQSUp96tiGadpLZ7bc4EyIQAc5uqT6rdbylErnZp9oLHSE1aUjk+VbSsleojk7ggIQARnd
	OiowfYt7I9uvaxAm2dS7gmRUTTmNzf/Gb21X+QmxaCWm8kg20xHZtNZn4216HcB+ALv0p5FYGVs
	yJ6a9H2K21avWtMfNbMWslvcS5bFwoXjxeL2m4Y/ciYrX1VUtNFtKtuagQqAFFGoyLkMj2UGgye
	BIEB3RMsD5oBDV4+6Fvq8uVtGOG86YhfWVHy3AUeOEnymqfK4ghLW35sirnw2BszVk2osDO3ePW
	x7Ss+rkZjPcLH+FeXeRVGPZmBX/EoypDa27/RgtyPyPmDOujWBL8AfXMaOCvjthwSU2k58rAZxz
	lt68GFe0QUoBBI6iM=
X-Google-Smtp-Source: AGHT+IGo1adSqugDdIZRQSzWcjgsYTglPxgYm/2Pf1a15n6l2x2VoKYdVxQeE+Hpg647GI1uAq/aog==
X-Received: by 2002:a05:600c:8b35:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-45f320ea2dfmr1944965e9.4.1758033024087;
        Tue, 16 Sep 2025 07:30:24 -0700 (PDT)
Received: from google.com (157.24.148.146.bc.googleusercontent.com. [146.148.24.157])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdc967411sm340062f8f.46.2025.09.16.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:30:23 -0700 (PDT)
Date: Tue, 16 Sep 2025 14:30:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, robin.murphy@arm.com,
	jean-philippe@linaro.org, qperret@google.com, tabba@google.com,
	jgg@ziepe.ca, mark.rutland@arm.com, praan@google.com
Subject: Re: [PATCH v4 14/28] iommu/arm-smmu-v3: Add KVM mode in the driver
Message-ID: <aMl0fJJyV5sJKIKS@google.com>
References: <20250819215156.2494305-1-smostafa@google.com>
 <20250819215156.2494305-15-smostafa@google.com>
 <aMQlm9ucDtd5-15r@willie-the-truck>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQlm9ucDtd5-15r@willie-the-truck>

On Fri, Sep 12, 2025 at 02:52:27PM +0100, Will Deacon wrote:
> On Tue, Aug 19, 2025 at 09:51:42PM +0000, Mostafa Saleh wrote:
> > Add a file only compiled for KVM mode.
> > 
> > At the moment it registers the driver with KVM, and add the hook
> > needed for memory allocation.
> > 
> > Next, it will create the array with available SMMUs and their
> > description.
> > 
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h             |  4 +++
> >  arch/arm64/kvm/iommu.c                        | 10 ++++--
> >  drivers/iommu/arm/arm-smmu-v3/Makefile        |  1 +
> >  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c   | 36 +++++++++++++++++++
> >  4 files changed, 49 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-kvm.c
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index fcb4b26072f7..52212c0f2e9c 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -1678,4 +1678,8 @@ struct kvm_iommu_ops;
> >  int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
> >  size_t kvm_iommu_pages(void);
> >  
> > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > +size_t smmu_hyp_pgt_pages(void);
> > +#endif
> > +
> >  #endif /* __ARM64_KVM_HOST_H__ */
> > diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
> > index 5460b1bd44a6..0475f7c95c6c 100644
> > --- a/arch/arm64/kvm/iommu.c
> > +++ b/arch/arm64/kvm/iommu.c
> > @@ -17,10 +17,16 @@ int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> >  
> >  size_t kvm_iommu_pages(void)
> >  {
> > +	size_t nr_pages = 0;
> > +
> >  	/*
> >  	 * This is called very early during setup_arch() where no initcalls,
> >  	 * so this has to call specific functions per each KVM driver.
> >  	 */
> > -	kvm_nvhe_sym(hyp_kvm_iommu_pages) = 0;
> > -	return 0;
> > +#ifdef CONFIG_ARM_SMMU_V3_PKVM
> > +	nr_pages = smmu_hyp_pgt_pages();
> > +#endif
> 
> Rather than hard-code this here, I wonder whether it would be better to
> have a default size for the IOMMU carveout and have the driver tells us
> how much it needs later on when it probes. Then we could either free
> any unused portion back to the host or return an error to the driver if
> it wants more than we have.

I can do that, we can set the default from a config or cmdline (or
both).

Thanks,
Mostafa

> 
> Will
> 
