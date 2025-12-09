Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4D28FFE7
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765294875; cv=none; b=squVQqd+L22BJNkkNJtoh9SK9GVHqzdXNEOXVA+JYV+0c0NAyaVdlqWJDtIfYc7cab3RNM2vy7mBQiaWj+0adG84HuFX+y/1BRwsztWslsm0C3D7lmy6evE+Pv4ykfljIPzeL+H794D81npsveBpdc9PjGagq1HpcCm/qiOsDeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765294875; c=relaxed/simple;
	bh=JO97przZcar26CUjgMTNscdnloD6XvzmS1gbBANy9xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ld3K3oLA9tOdPCmxnyaU0W/2JIyczXncFtycTFEwMrdz29lDM1TTjTTrx9NZVXmZS5iPYjOig55Rzjw414TqNElT1akM0h5GeOOruBWTFHJ1l17e+3CbaNjWHE+WuvQanI9dekO7So30nA8hiaE6sjiLSYTecjafbiyKV/FIkx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVks9D0P; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVks9D0P"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477a1c8cc47so75135e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765294872; x=1765899672; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FRSJPoZVIWwIEh7D+HUP6mvJWdSsS3ngbeEkLMitoU0=;
        b=qVks9D0Pc+zNVF9og67x7GcH0M4FmS+3GtP8Q2lwExU8zsju12u9JnoGMTkV/4GkMc
         3KPTeUI4vw+RdfBrfzown+eO4pzRm3qnDUTVGyxwNln/P8cOqKLRAP2v+N2nYlCLcu3S
         OR1TtpOH8ujNbD3SznEIM+ACIoNRsVaaCJZjt3WIYfRp8CDEcp7yjHgYQiQ28lNExFk4
         xGqbpLXA03GVoZa/3F28vqI/pgSoCy0J0gNqxPnU7iSXoAlcmXFPUIRyf678ghOlNGM+
         36NZsU1eDvrWGUsNO4jwUZDJs/V89sPqXlc+9vOAcU6DT8tsPZf7iirm+wj8XZS8NgUg
         mCdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765294872; x=1765899672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRSJPoZVIWwIEh7D+HUP6mvJWdSsS3ngbeEkLMitoU0=;
        b=s4hF3bvGBJ2569XsVoRKDZH3R/dTkf4myGQEKTjnF6j2bE5+GrT/pKRGmQTo4VEtia
         1I/b0kCkxni14G3TKP47uVDt79PRrzfDpOrf9pFUOxv9h89owm6pN2BpW442WU8DeIIt
         cn0syr+7yXUZ2yyQzsTr2WgDzQFbyWhOZKmgbrVftnrPfnVxlCzxRPMJrik1q5HPeEOh
         PpaQ5G8/80ow2Dn17fu3Xannjhbe+gkhdc6/3N6MfvbU2B+QKg1alcNNapOFtZG+Hg9x
         FzvcxXULpOeBHB7fpIvKKBJ9Q8SX9/W5qWE03+SSxnjhlTkfXzkZah1Nmxdpa6niPU6L
         u+Ug==
X-Gm-Message-State: AOJu0Yz2mogRlSA5ih4x4/U2j9Gl7lP+4LJLqigZBPfxuQRmbqFVXj0f
	3JzM45MO2ne/c3SVz+6B3FAYTI5GBb04P9qemFgx48tIdowX41Wyk8VMj2iujVscdQ==
X-Gm-Gg: ASbGncs93pw7momACkdE4OyDMfEzV8kd0HpjqqGhndVcli+MjQW7K9p+VObndmDmQbD
	JvJh8TcSvj4atNRaWfJxv/2mtIttrTTeVRxzODc9IvQRsoaxy6MWATEgwLawONPq8Rw/Jsmn+sC
	w7oBnk00JQw0YUISDxjgTny9ijoaUhUjK1//trD/FNPSWVI7sWA9IXtafTDkScjrGpxXkpWxgHt
	n9M7nBCnT3RD0CXcO1f8qxCee+bvNOZ0AkkLkLJ1gaWbpcMZ8cGPhv8Xc1WfLCwQjTJtTpbciAU
	PFWgyCV7IFHFD5Zv604tHPgkpK6fbBfcFHfb/d4apOh8JBrh27jzgh/GatWyD4A7nLr7QkEPYsE
	yXbunIEQNQTODdmu3D63bcfyPLes/IgQ1eHYFrRcSYv7awmLzGjArdpRik4nhKMo+dSJRw0u9Uz
	yachsCS8IhK5Mx0yoQiZPzaYIOrmSZ2I64L6WkYKlxA+LVLRDZyg==
X-Google-Smtp-Source: AGHT+IHQEZ8FLIilFiXNCi+g2Qu7gthEz4ALV/uyU+U+XaaH+GfBRniWK3APXG/SjEYT89Xm7QNmpg==
X-Received: by 2002:a05:600c:2054:b0:45f:2940:d194 with SMTP id 5b1f17b1804b1-47a7d390f34mr549265e9.2.1765294871501;
        Tue, 09 Dec 2025 07:41:11 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a816938d4sm15340565e9.1.2025.12.09.07.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 07:41:10 -0800 (PST)
Date: Tue, 9 Dec 2025 15:41:06 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
	Tomasz Nowicki <tnowicki@google.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
Message-ID: <aThDEnbbop8ZYAuG@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
 <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com>
 <aTgX9qhaLyrQ5iye@google.com>
 <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <498bbad4-ea64-4a24-a63f-e131d271990a@arm.com>

On Tue, Dec 09, 2025 at 01:33:36PM +0000, Robin Murphy wrote:
> On 2025-12-09 12:37 pm, Mostafa Saleh wrote:
> > On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
> > > On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
> > > > arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
> > > > correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
> > > > as IAS would be 40 bits.
> > > 
> > > But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
> > > SMMU architecture is talking about the maximum IAS that an SMMU
> > > implementation needs to be able to accommodate based on its configuration,
> > > but it does then attempt to clarify that the actual IPA size in use by any
> > > given context should depend on the VMSA format in use:
> > > 
> > > "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
> > > and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
> > > 
> > > Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
> > > AArch32/AArch64 detail.
> > 
> > I see, thanks a lot for the explanation, I got confused by the this
> > statement:
> > Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.
> 
> Indeed, that appears confusingly contradictory; I've filed a bug.
> 
> > However, I think this is still a bug but somewere else, as at the moment
> > the SMMUv3 dirver will use the SMMU IAS (40-bits) as input for AArch64
> > stage-2 page tables, so we need either to limit the IAS as:
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index d16d35c78c06..d21153156daa 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -2561,7 +2561,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> >          case ARM_SMMU_DOMAIN_S2:
> >                  if (enable_dirty)
> >                          return -EOPNOTSUPP;
> > -               pgtbl_cfg.ias = smmu->ias;
> > +               pgtbl_cfg.ias = min(smmu->ias, smmu->oas);
> >                  pgtbl_cfg.oas = smmu->oas;
> >                  fmt = ARM_64_LPAE_S2;
> >                  finalise_stage_fn = arm_smmu_domain_finalise_s2;
> > 
> > Or, don't populate IAS depending on AArch32 support as the driver
> > doesn't support it, effectively reverting:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0c453dbcce7767cd868deb809ba68083c93954e
> 
> It does appear we've missed the detail here. TBH I'm not really sure why
> we're bothering to consider the theoretical maximum IAS at all when it only
> makes any difference to a format we've never cared about supporting anyway.
> Frankly I'd be inclined to just remove smmu->ias altogether - even if we did
> ever want to support LPAE format, it would be just as trivial for that to
> hard-code pgtbl_cfg.ias = 40 based on the architecture rules.
> 

Makes sense, I will prepare a patch.

Thanks,
Mostafa

> Thanks,
> Robin.
