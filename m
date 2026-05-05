Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE084A2E18
	for <iommu@lists.linux.dev>; Tue,  5 May 2026 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778002884; cv=none; b=SiO9WKIviulI2m7cRguNG48XY0cKo5T9FKcWzADPS5pkovvhlNGtIjlTMaQd4p5T1VWbNT5wb0xhzd1fu+6B0AF4M7Kz6QmBaxQHyxUTzoLXT8dUjLUelgTFKAdJJ8+c4BCrZAmszRViLojhp6A2K/JYCdrCwsb2Szk4qnCX20I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778002884; c=relaxed/simple;
	bh=525LeDklozoETAtrKYkudlzP2wOk5vQkSNeexHPHqnM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kDswamtLxfHDLTOeDkWfzV6vCZQyqJ8/avzACbaUNJdySTKhmQVd5xU4QMHFZA3RnZnpr2FmRs1VXHvMRwlb+m3+YJQwlm5TytAJsSzKWPzjgUJbdDhuCSQOHmXNpr8AdcB+XsC49vq3nsdXk/0jk+3eVo5RlnhYRL3jmGiaBZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nzKiAo1u; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nzKiAo1u"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8397b14a689so405787b3a.2
        for <iommu@lists.linux.dev>; Tue, 05 May 2026 10:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778002883; x=1778607683; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=4UXfAs80XROESuyegKpQZQVSyo3dUpTtapWPfSPBH3c=;
        b=nzKiAo1uZin7XnyfWTUPnG3S7x2ycbv1NhJQeOjEXOZ4tO3P8eIOh85MHqNwSNZEC2
         t2VJHmfFqgRkIAdD43dOf7judP9Ga4KP5xK7Z17Ut/i7LNh4NsChTe4KP9DMk//GgdYM
         o59J2Tsp8KTUZAl8yTE0ANp3tC5hipA/0Ppykk6LUf/HQP5VRz/OI4sO4QXKaFvRGpby
         HGy3fiBltppysnxKCYnOJ3jx7n4BIkjUov+TI2U3nLHBFK2KEl6MVENvaobzGqMtiKgL
         k9Kma+v+k9uTLKyAyby3J454GRZknTfC2Ni0i4Ppf5x8eH7Sf1dhZlxOFRXWjj4NvPeU
         V5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778002883; x=1778607683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4UXfAs80XROESuyegKpQZQVSyo3dUpTtapWPfSPBH3c=;
        b=eojg1FNnTcZBzUxT5fe7RYbhELeuM132SDTIwXSUXMGox6/lbFesDj1c+Yfts1fRrh
         NPdY5+w/vyfF9PcmkbdnigP8AlFNfjFRclqmglW+aUh7Ad28QwnIw2aKhhysKLjsprlL
         VYfpwUo8SiizJ84D/4gkcNO1TVDXpVBjuat1H2VaOd9m8R2/kJGfzMvOQ5WvGo5EuXKZ
         YjPMpAj4EuPHG5CUeOSulcnXLhXo3i/x82Sr+mifhwowV9ydHoWt7c4w2q024SXH8TGP
         Ukf9jr2yqmPMvvPlRyGmO9kid8IQlq501Y0ve1jcyT/t9lkskf2Gnj0dT4z6FkAncUNw
         mTGg==
X-Forwarded-Encrypted: i=1; AFNElJ/iTBgiDyUyHdYjDPRKJ8uMkdZvlqdNYlRAcgWwZMlmEkcBFONI6hZsn8IHHSURHPxaaOyYRQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnI2yUR7HGl7gkHbxLLOHir0gsmGwrr9SFIxU4NcglJTDpiDNw
	MhXCUkvN7nfL4mWayfg1nntxu+Dw9y4pMUSHFvStlyCcCD6WhYy1kp13cP/FR0HpJJW1Glm3owT
	avC7bhg==
X-Received: from pfnj5.prod.google.com ([2002:aa7:83c5:0:b0:82f:8a3b:87f0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3003:b0:82f:24e:6a48
 with SMTP id d2e1a72fcca58-83921ef6e0fmr3897849b3a.5.1778002882564; Tue, 05
 May 2026 10:41:22 -0700 (PDT)
Date: Tue, 5 May 2026 10:41:21 -0700
In-Reply-To: <655fd173-5dab-40c2-8f77-8b3e891a1c40@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250315030928.2373250-1-seanjc@google.com> <655fd173-5dab-40c2-8f77-8b3e891a1c40@amd.com>
Message-ID: <aforwTPix7Q_ClTO@google.com>
Subject: Re: [PATCH] iommu/amd: Explicitly bail from enable_iommus_vapic()
 when in legacy mode
From: Sean Christopherson <seanjc@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 05, 2026, Vasant Hegde wrote:
> Sean,
> 
> On 3/15/2025 8:39 AM, Sean Christopherson wrote:
> > Bail early from enable_iommus_vapic() if IOMMUs are configured for either
> > of the legacy modes, as it's absurdly difficult to see that
> > iommu_ga_log_enable() is guaranteed to fail because iommu_init_ga_log()
> > skips allocating the ga_log.
> > 
> > Opportunistically have iommu_ga_log_enable() WARN if it's called without
> > IOMMUs being configured to support AVIC/vAPIC.
> 
> 
> > 
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >  drivers/iommu/amd/init.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index cb536d372b12..05c568da589a 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -931,8 +931,8 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
> >  
> >  static int iommu_init_ga_log(struct amd_iommu *iommu)
> >  {
> > -	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> > -		return 0;
> > +	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
>  +		return -EINVAL;
> >  
> >  	iommu->ga_log = iommu_alloc_pages(GFP_KERNEL, get_order(GA_LOG_SIZE));
> >  	if (!iommu->ga_log)
> > @@ -2863,8 +2863,10 @@ static void enable_iommus_vapic(void)
> >  			return;
> >  	}
> >  
> > -	if (AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir) &&
> > -	    !check_feature(FEATURE_GAM_VAPIC)) {
> > +	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
> > +		return;
> > +
> 
> We should move this down after SNP check. Otherwise we may hit WARN_ON_ONCE in
> iommu_init_ga_log().

No?  enable_iommus_vapic() ends up with:

1.	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
		return;

2.	if (!check_feature(FEATURE_GAM_VAPIC)) {
		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}

3.	if (amd_iommu_snp_en &&
	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
		pr_warn("Force to disable Virtual APIC due to SNP\n");
		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
		return;
	}

	/* Enabling GAM and SNPAVIC support */
	for_each_iommu(iommu) {
		if (iommu_init_ga_log(iommu) ||
		    iommu_ga_log_enable(iommu))
			return;

		iommu_feature_enable(iommu, CONTROL_GAM_EN);
		if (amd_iommu_snp_en)
			iommu_feature_enable(iommu, CONTROL_SNPAVIC_EN);
	}

And that's the only call site for iommu_init_ga_log().  Getting past #1 guarantees
"amd_iommu_guest_ir == AMD_IOMMU_GUEST_IR_VAPIC", and if #2 and #3 return early
if they modify amd_iommu_guest_ir, so it should be impossible for iommu_init_ga_log()
to be called with amd_iommu_guest_ir anything other than AMD_IOMMU_GUEST_IR_VAPIC.

Shifting the initial check down isn't functionally correct, as it wouldn't do the
right thing if amd_iommu_guest_ir==AMD_IOMMU_GUEST_IR_LEGACY.  AFAICT, nothing
prevents calling into enable_iommus_vapic() in that case.
