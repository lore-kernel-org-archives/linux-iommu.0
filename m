Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF8F1F1511
	for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 18:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738348497; cv=none; b=J6kOnMICbSwf6op3fFX16TzBEd8oSCdK1DRZSEMXyQFpqfGHZRjlWu8T/r9rtZkMPIomU2PrQEhSStnBuxmbt/2r9BHngycKPMbW8vOFlQOiHH6VIGCtSJCCeCEUtUBV9mY3l8rSOdxjwn1q0Iz1S0sTbShwcn+e46XcZoNy6ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738348497; c=relaxed/simple;
	bh=fNWXKiXO2P8ivV5RaHwtYShP97cRJPV2kvBURFYp/aA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I5wXcqGZoA5kp5cqZ5IeHAWK2NmydgbgjvDRg/Px5QIeCWdolXmD96jmvGfgRBkJCZZTQik50kqd5wZZNtiG2Pqh/HBXsh3PWHPv0oo2Fk6jfJuJCdfepTRhQ4ibd7D9VB9rcrtg2sSR0I1QZrS91ZHoZftVzOAx3ImeLjkp8yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqOaWg/g; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqOaWg/g"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so4448201a91.2
        for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 10:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738348495; x=1738953295; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OHvxpFXR5lAEIxk+o3Hek4ypvpPcHmc+gKmCjQ+uPaM=;
        b=QqOaWg/gJQmwHTA8JPopgh8S724qLSXorHdBcYJCMqLmoT+G2aYiC4xZGkYEhQw8gY
         XngagPNYnkH5adnMCjAYGFzKhu292YweEWNvbME6ooiyyZQX6tfrd1EuxXyl8h67LO8+
         vHFv4RnSAT7UzLqeRe5hTnAAyBep4F/+IU6KFq3u9Msk4DjCqvpIXIRPTd471G2bPGgG
         Q3bacsuUg94lPKeIntE/94mZfEabzf1xTuKn84qdZKOlAh9hgVSa+QNPde5kXgWDPZWt
         PITuAZ+W861B7AOOm3Li30mJCCt4XL/dwp/X+Z3+v9MR56vDnn8zvSoFa+4ty7G7LSQx
         FcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738348495; x=1738953295;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OHvxpFXR5lAEIxk+o3Hek4ypvpPcHmc+gKmCjQ+uPaM=;
        b=ira5DQybW1DPC1I3n0nI3RP981NRwywSJdxr2ZyHTu7Kc1CXXFLISIyvE2HtD8PgmP
         u1QNYFrQPGt5VCq+HVI0bNTwh+pdN7ZeV6ct1Rne92elAxF7zhNz9YZX9YJYlVsK8SS9
         cYK4QORKi8pl1etcoFIi6OobHYghNWSK31jjEO8bzcMt1qHnPYMZe0kN2he/mtm8g6Ta
         0iT0WMkvuyMqPleKfLfO1gBBFXjBvacwMaF7H1F2yGQZSuagUmceDa0fH8BG/3BS9/PE
         MH/FBc+aekcw3WFluby7mKAB+Y6jIQxaF6YANm4JiXIiVQwu+FU0mtDr2g8IQfSy7JBC
         iXLw==
X-Forwarded-Encrypted: i=1; AJvYcCVlr/ukmbeTBe6bFhFDYE1Z307dDWy1unfGsBDtkgxfs1tEQmH6mrDojavmBwwx/imYehbBeA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzFGKS8ZLtdL6o2vT+IHzRZsFuQSo2fof4en3jBe5FvNYfcv9CU
	er8wBaYMs//3K2tQJB9w6rqdgwzKx3mWHfpKPj7sh+AlzsSJQRNg6AyUvxX6U4Nh9A4EGKIfrVL
	qTg==
X-Google-Smtp-Source: AGHT+IE/oZCUZdCZRJTGm8rMH0vhTkQhVXUs+8QMDWccMmAQAm7pMQvcBwS4gYOfo5ygWQzF5ovfuAe5ry0=
X-Received: from pfaq15.prod.google.com ([2002:a05:6a00:a88f:b0:725:eeaa:65e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:6f54:b0:730:1db:80b2
 with SMTP id d2e1a72fcca58-73001db80e2mr418968b3a.17.1738348494797; Fri, 31
 Jan 2025 10:34:54 -0800 (PST)
Date: Fri, 31 Jan 2025 10:34:47 -0800
In-Reply-To: <93e8a84a-d4cc-4dbc-a593-99995b000947@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1738274758.git.ashish.kalra@amd.com> <8f73fc5a68f6713ba7ae1cbdbb7418145c4bd190.1738274758.git.ashish.kalra@amd.com>
 <Z5wqN5WSCpJ3OB0A@google.com> <93e8a84a-d4cc-4dbc-a593-99995b000947@amd.com>
Message-ID: <Z50IQyFzuMQRihhF@google.com>
Subject: Re: [PATCH v2 3/4] x86/sev: Fix broken SNP support with KVM module built-in
From: Sean Christopherson <seanjc@google.com>
To: Ashish Kalra <ashish.kalra@amd.com>
Cc: pbonzini@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	thomas.lendacky@amd.com, john.allen@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, joro@8bytes.org, suravee.suthikulpanit@amd.com, 
	will@kernel.org, robin.murphy@arm.com, michael.roth@amd.com, 
	dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org, 
	kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-coco@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Jan 30, 2025, Ashish Kalra wrote:
> On 1/30/2025 7:41 PM, Sean Christopherson wrote:
> > On Fri, Jan 31, 2025, Ashish Kalra wrote:
> >> -nosnp:
> >> -	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
> >> -	return -ENOSYS;
> >>  }
> >>  
> >> -/*
> >> - * This must be called after the IOMMU has been initialized.
> >> - */
> >> -device_initcall(snp_rmptable_init);
> > 
> > There's the wee little problem that snp_rmptable_init() is never called as of
> > this patch.  Dropping the device_initcall() needs to happen in the same patch
> > that wires up the IOMMU code to invoke snp_rmptable_init().
> 
> The issue with that is the IOMMU and x86 maintainers are different, so i
> believe that we will need to split the dropping of device_initcall() in
> platform code and the code to wire up the IOMMU driver to invoke
> snp_rmptable_init(), to get the patch merged in different trees ?

No, that's pure insanity and not how patches that touch multiple subsystems are
handled.  This all goes through one tree, with Acks from the necessary parties.
