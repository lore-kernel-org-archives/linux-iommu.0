Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93C718A924
	for <iommu@lists.linux.dev>; Wed,  5 Feb 2025 15:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768515; cv=none; b=kA1aG+8To9h3pFVhQLamG9YXuYwh7+PS7QI2l9UZNEds/S/buw52jNDMIbjSOzZzaTQXJbmiMo7SsR500lYK9CjapvDcsw4K/ET4KMK5hl2K/TpfIljBlZMX+Cwbu4kpg0wKS6ZdbqruJnbxiu2pAqz28ZwpNM2VoY28nJ9q2qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768515; c=relaxed/simple;
	bh=4szL1eJgPRArjYOVHDwKE/JvLZRZfgR79x/numwtyM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hVBhJ0G9Sl9X5CM6SHqtFvXlkDcSpb2+bg7O4JrYXvBsiLiQUpsczGN1Msqt5liVSRJn7mx6JnK3dBdAg3rqnKl9ZV/Pfkpfq0b/8C+/WpHAkPlmB/ZxuS5Z6Krvf48+ZrbPro5icqz2bwsFg8NG08MnXQ6KbravcKv6M016ZUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lamghtwW; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lamghtwW"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-216311faa51so20406285ad.0
        for <iommu@lists.linux.dev>; Wed, 05 Feb 2025 07:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738768513; x=1739373313; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RjqsFlgPguDEnBdcgetC9zWFV3PjaxpPC075lKRZgFw=;
        b=lamghtwWPW0gClLg77X7LP4gJ/Bbzcmity1fvyWIJA9PtJKObuXco6mOWGEl7gQjOI
         c1SFBMQH2+rZXBwTbSZEcS2X4Hzgcog021XhulXHavVwjr8/7lRLV93lg089yVBzNGrj
         Hh4P6uXqRAmr7V7YnbLXU/Aw3GL/EMYtm+HIOTSrRSxAO0i5ZLN7hR+wYAx8FF8nFZyW
         cSHfqh4SE1j2qrfBs0wXfeZANzmxBWKgysCfuC4EOszkoBPnHAnkm8jub+/doFXnvwa1
         h2iJ3zcczwsm9IOmf5EN7JePOUkutg5uRRISQZd05OdUl15J030agj2xK1I0VihrJVaW
         Sy3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738768513; x=1739373313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RjqsFlgPguDEnBdcgetC9zWFV3PjaxpPC075lKRZgFw=;
        b=Ds7iOwnDpxK4algoHB34z/DtjEo0Mx8k5f++19N99dW7CT4po2fvWPKtGLVsxA7PoX
         GGyio0QFvHUhV76PpZvOGF/YAa4Q/6p5lMwopFpKz6GHpkztB+IdWPa1B5bHZDqLLzVD
         Sq9ycOx/tymAvQ/TFrEdyRKKDoyH4EEvfVGQfLsqDu58opz0v7ToIKgobvs/L1cIabak
         T+bKXRQ7fwINR5jqlZPo0rvZAxbKY7+aHYMkk70flBND0zN9a62cD5eyYRhgHMiusLnV
         ntpUvYZFFcjq0kDFs2xuaU7/joIO74ArS025UcCvSDSD1+wyM0m9We4sAfKNqw8XN0KI
         HkKA==
X-Forwarded-Encrypted: i=1; AJvYcCUVzjD7hYjVo62kYGQ15pxoAAHCQv7gBvsiItcKwdswvgqvVilCQHkqO2USWuR+y68pwJGLXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyFz4VXU6YAbSPAxEjVbwIcRntd+xBtsKZ3JkqpJZe6RWIhP9qN
	rKbK3xJDHU4kEt3M4oKANAu4zsTHtqyfKzMpW8Y0dsa6iwGoWCvnHOQMDPs6/qGO8riKvSIjE5x
	Xuw==
X-Google-Smtp-Source: AGHT+IFHs7tj+Q54d64NDKOfhfMfAS91bOZEx/8/ugogv1Ut4aJidKZIV/qdikwiSwu5m+q7+e5T4vD0P74=
X-Received: from plgi6.prod.google.com ([2002:a17:902:cf06:b0:21c:144d:411b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:daca:b0:215:758c:52e8
 with SMTP id d9443c01a7336-21f17a774a7mr66004375ad.12.1738768512794; Wed, 05
 Feb 2025 07:15:12 -0800 (PST)
Date: Wed, 5 Feb 2025 07:15:11 -0800
In-Reply-To: <1969aa1a-e092-4a48-b4a0-9a50ec2ef3b6@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <cover.1738274758.git.ashish.kalra@amd.com> <afc1fb55dfcb1bccd8ee6730282b78a7e2f77a46.1738274758.git.ashish.kalra@amd.com>
 <Z5wr5h03oLEA5WBn@google.com> <1969aa1a-e092-4a48-b4a0-9a50ec2ef3b6@amd.com>
Message-ID: <Z6OAf02sRJTZkl5K@google.com>
Subject: Re: [PATCH v2 4/4] iommu/amd: Enable Host SNP support after enabling
 IOMMU SNP support
From: Sean Christopherson <seanjc@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, joro@8bytes.org, 
	suravee.suthikulpanit@amd.com, will@kernel.org, robin.murphy@arm.com, 
	michael.roth@amd.com, dionnaglaze@google.com, nikunj@amd.com, ardb@kernel.org, 
	kevinloughlin@google.com, Neeraj.Upadhyay@amd.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-coco@lists.linux.dev, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Feb 05, 2025, Vasant Hegde wrote:
> On 1/31/2025 7:18 AM, Sean Christopherson wrote:
> > On Fri, Jan 31, 2025, Ashish Kalra wrote:
> >> @@ -3426,18 +3431,23 @@ void __init amd_iommu_detect(void)
> >>  	int ret;
> >>  
> >>  	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
> >> -		return;
> >> +		goto disable_snp;
> >>  
> >>  	if (!amd_iommu_sme_check())
> >> -		return;
> >> +		goto disable_snp;
> >>  
> >>  	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
> >>  	if (ret)
> >> -		return;
> >> +		goto disable_snp;
> > 
> > This handles initial failure, but it won't handle the case where amd_iommu_prepare()
> > fails, as the iommu_go_to_state() call from amd_iommu_enable() will get
> > short-circuited.  I don't see any pleasant options.  Maybe this?
> > 
> > diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> > index c5cd92edada0..436e47f13f8f 100644
> > --- a/drivers/iommu/amd/init.c
> > +++ b/drivers/iommu/amd/init.c
> > @@ -3318,6 +3318,8 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
> >                 ret = state_next();
> >         }
> >  
> > +       if (ret && !amd_iommu_snp_en && cc_platform_has(CC_ATTR_HOST_SEV_SNP))
> 
> I think we should clear when `amd_iommu_snp_en` is true.

That doesn't address the case where amd_iommu_prepare() fails, because amd_iommu_snp_en
will be %false (it's init value) and the RMP will be uninitialized, i.e.
CC_ATTR_HOST_SEV_SNP will be incorrectly left set.

And conversely, IMO clearing CC_ATTR_HOST_SEV_SNP after initializing the IOMMU
and RMP is wrong as well.  Such a host is probably hosted regardless, but from
the CPU's perspective, SNP is supported and enabled.

> May be below check is enough?
> 
> 	if (ret && amd_iommu_snp_en)


