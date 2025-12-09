Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB632BF44
	for <iommu@lists.linux.dev>; Tue,  9 Dec 2025 12:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765283838; cv=none; b=taWa4nZ69O8WdL71k6MqYrn1dor/cJiGYRPPJebKYf6n3y8wbnfo8bSqlz13ycUTcVtiIdKLo4c0+dVV9JZW2E6tkNn0LhYOhhiP/XZ9bjmsKppiyXCLrBn1CC8ZCuR643SKrG7RKUjwJ+xyV9mOBwgIC1JpWcoP19zrVYM/gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765283838; c=relaxed/simple;
	bh=Y73uYvlk1WLIgqwTbEE+iU7NSsrqKBOdoNukYczXr7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWaQqA6H2wYi7KfYCipMO1BjShN76o68e5t0o368IEEkB8klwAGv6gwumvPkhcY8iu2MNsbceu2PtqInHEQVK7zjG7s+ItnBzn2oMSRJd+T5caV/gLK7kwuGbwRoAryRUzjxNdQ+62/rcG6vE5bz6LFOU6tDRJYYykafwphniB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0vzxl90; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0vzxl90"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47a815c43baso12425e9.1
        for <iommu@lists.linux.dev>; Tue, 09 Dec 2025 04:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765283835; x=1765888635; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vlFI2bCRqxpqLkg/AiIg8IcS+TSdYsio6x9QrT+ERVQ=;
        b=H0vzxl90ySgIbyukIGqqhDpjDkPJX/cC6MSpi7pTMhos7G5BEVK/95RsGCqn9dYoX0
         q6LAusPsrNKY54pxHOuhLxLA4YKYG1n41CxCwIz1SpnDMG/BKfX2ZPOmoMnlXepdDL2E
         kXIeBjVJnKrWLXW4BJrfRQpxUT36YmPNR6VokPG1XSUr6EDLxuADBY2uviIEQ4+vFOqM
         r1iB9OTRDGVXpDRBiJPcw4OaDlaQuRW6WXjhvJjw0x0bzQ5o+RlU7GU8ag64Js29O9/4
         NJD3IMWSii3WdhzOTlHqyJEm/S1ziOp1H2dfc1X0GY65JwNqoc1UEx47XysNtpq7hQRh
         xteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765283835; x=1765888635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vlFI2bCRqxpqLkg/AiIg8IcS+TSdYsio6x9QrT+ERVQ=;
        b=nXpvUoiySECavqR6nlzas9Bo6zMfFQtKCVIjh3VAjQHQZYKvzWz/lSSBId8UCphrGA
         DBjUmPQnztQppi7hg5uMs0rzPdhKy0v9nfrzmr8g6kmuTWfaFmCevBjyPHh5/wm84KQT
         zMfUbieLRBqIOWSbxQayFhjJ4hRoAqDPo0bTjJQZkbrgHGJ8dctlS4B6hOxKYW4e6h6D
         +J6HNC4dG1VEW3tQDYKEiO7bFngXka5HxJ8rvaA/ekzkii1GiFRWDE0Qgpp8WgVoNwIM
         l3Zq8lnzEnjIUfnowQCDBvtVvjoOvHDNz6/l+Hq/DhIPr5WHNpuPv9qf+4qXu8ckzRQx
         VkfA==
X-Gm-Message-State: AOJu0Yyv0bfabKEaYyJeeyNkDUdjaX1DNynQbao2zZ7DCrnxl+FWSoek
	HjqSm3OVsVRRCQy4vMzj4q2IRl8ZEYO/+EpjWvUuRttpGgYOGXUXHNzQHPRBxWSRMw==
X-Gm-Gg: ASbGncsEVjbGs6v4sz1vs8Z7wNoBpPBLr2sDXiVhbgxeU+/iUUYHMBvYGKZuqIRzwQK
	EOWDQtthW1Nw5LahOGXUBsuD+zx1+TisGhCQvZjcYw3fqCp9/UCHQkNtIaJmnS3w6NAuiiHJcUa
	7w2acmBZq+cfEZg7/LxvzCKm9zPyEUls0/WVmYW82QWrOfolUJxWYn5XviYQ1jTARlKZIeaqGJm
	bUQja4k5jdRTcEE5EODzxa3akLUd+kUyoLNzzPXN4Y+RzqXdxMknrQQk8NgC9xPOTi1ePMFMmSe
	+ijSx3Vyiv0hrYNT2dW3waG1YK7rqRdamNDY/J2OK3hrBHEwUnoGzMohYwIziaGY4C0cZbUxrF+
	oQ8opitG7ZUtd06bpFnSViQmm8pQmteS5ElHtMrIHRZQ2ZQyrD/gmVOkwucYRpEZ8LjxotzLkA2
	lH6HayiMsl27ZV7csx56k1NSBa4BJ9eQyIXDds4hWd/58BgvM1WKawGsTcyUjz
X-Google-Smtp-Source: AGHT+IFBVi6Any6314XmuF0VtSnmCugjUmteW57ZeCuI2t3TMv2bo5E7PrvrZtUvcE0omaa0J1rj/w==
X-Received: by 2002:a05:600c:c092:b0:477:255c:bea8 with SMTP id 5b1f17b1804b1-47a7dafc8a8mr643695e9.7.1765283835141;
        Tue, 09 Dec 2025 04:37:15 -0800 (PST)
Received: from google.com (54.140.140.34.bc.googleusercontent.com. [34.140.140.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7cbfee71sm31524754f8f.15.2025.12.09.04.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 04:37:14 -0800 (PST)
Date: Tue, 9 Dec 2025 12:37:10 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, will@kernel.org, joro@8bytes.org,
	Tomasz Nowicki <tnowicki@google.com>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Add misisng concatenated PGD cases
Message-ID: <aTgX9qhaLyrQ5iye@google.com>
References: <20251130194506.593700-1-smostafa@google.com>
 <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a39079-2285-47fb-b306-040f2bc1bbaa@arm.com>

On Tue, Dec 09, 2025 at 11:34:34AM +0000, Robin Murphy wrote:
> On 2025-11-30 7:45 pm, Mostafa Saleh wrote:
> > arm_lpae_concat_mandatory() assumes that OAS >= IAS which is not
> > correct for SMMUs supporting AArch32, and have OAS = 32/36 bits,
> > as IAS would be 40 bits.
> 
> But that is only when *using* AArch32 format. The bit in chapter 3.4 of the
> SMMU architecture is talking about the maximum IAS that an SMMU
> implementation needs to be able to accommodate based on its configuration,
> but it does then attempt to clarify that the actual IPA size in use by any
> given context should depend on the VMSA format in use:
> 
> "VMSAv8-32 LPAE always supports an IPA size of 40 bits, whereas VMSAv8-64
> and VMSAv9-128 limits the maximum IPA size to the maximum PA size."
> 
> Rule R_SRKBC in the Arm ARM lays out the exact T0SZ constraints with this
> AArch32/AArch64 detail.

I see, thanks a lot for the explanation, I got confused by the this
statement:
Note: If AArch32 is implemented, IAS == MAX(40, OAS), otherwise IAS == OAS.

However, I think this is still a bug but somewere else, as at the moment
the SMMUv3 dirver will use the SMMU IAS (40-bits) as input for AArch64
stage-2 page tables, so we need either to limit the IAS as:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index d16d35c78c06..d21153156daa 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2561,7 +2561,7 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
        case ARM_SMMU_DOMAIN_S2:
                if (enable_dirty)
                        return -EOPNOTSUPP;
-               pgtbl_cfg.ias = smmu->ias;
+               pgtbl_cfg.ias = min(smmu->ias, smmu->oas);
                pgtbl_cfg.oas = smmu->oas;
                fmt = ARM_64_LPAE_S2;
                finalise_stage_fn = arm_smmu_domain_finalise_s2;

Or, don't populate IAS depending on AArch32 support as the driver
doesn't support it, effectively reverting:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0c453dbcce7767cd868deb809ba68083c93954e

> 
> > In that case, concatenation is mandatory in some cases.
> > Document those and add the checks, this can be simplified; instead
> > of adding extra checks we can say that concatenation is mandatory for:
> > - 4K, start level = 0 and OAS <= 42 bits.
> > - 16K, start level = 1 and OAS <= 40 bits.
> > Which cover all the missing cases.
> 
> AArch32 uses a fixed 4K granule, so this cannot impact 16K. Note that we
> don't support AArch32 for SMMUv3 anyway, and while this does technically
> apply to SMMUv1/2, Arm's MMU-400/401/500 implementations all have OAS fixed
> at 40/40/48 bits respectively, so I'd imagine it's quite a rare case to
> encounter in practice.

Yes, I don't have access to such HW.

Thanks,
Mostafa
> 
> Thanks,
> Robin.
> 
> > Reported-by: Tomasz Nowicki <tnowicki@google.com>
> > Fixes: 4dcac8407fe1 ("iommu/io-pgtable-arm: Fix stage-2 concatenation with 16K")
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >   drivers/iommu/io-pgtable-arm.c | 10 ++++++----
> >   1 file changed, 6 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> > index e6626004b323..ecf27e86b429 100644
> > --- a/drivers/iommu/io-pgtable-arm.c
> > +++ b/drivers/iommu/io-pgtable-arm.c
> > @@ -223,6 +223,8 @@ static inline int arm_lpae_max_entries(int i, struct arm_lpae_io_pgtable *data)
> >    *   b) 40 bits PA size with 16K: use level 2 instead of level 1 (16 tables for ias = oas)
> >    *   c) 42 bits PA size with 4K: use level 1 instead of level 0 (8 tables for ias = oas)
> >    *   d) 48 bits PA size with 16K: use level 1 instead of level 0 (2 tables for ias = oas)
> > + *   f) 32/36 bits PA size with 4K and 40 bits IAS: use level 1 instead of level 0
> > + *   g) 32/36 bits PA size with 16K and 40 bits IAS: use level 2 instead of level 1
> >    */
> >   static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
> >   					     struct arm_lpae_io_pgtable *data)
> > @@ -234,13 +236,13 @@ static inline bool arm_lpae_concat_mandatory(struct io_pgtable_cfg *cfg,
> >   	if ((ARM_LPAE_GRANULE(data) == SZ_16K) && (data->start_level == 0))
> >   		return (oas == 48) || (ias == 48);
> > -	/* Covers 2.a and 2.c */
> > +	/* Covers 2.a, 2.c and 2.f */
> >   	if ((ARM_LPAE_GRANULE(data) == SZ_4K) && (data->start_level == 0))
> > -		return (oas == 40) || (oas == 42);
> > +		return (oas <= 42);
> > -	/* Case 2.b */
> > +	/* Case 2.b and 2.g */
> >   	return (ARM_LPAE_GRANULE(data) == SZ_16K) &&
> > -	       (data->start_level == 1) && (oas == 40);
> > +	       (data->start_level == 1) && (oas <= 40);
> >   }
> >   static dma_addr_t __arm_lpae_dma_addr(void *pages)
> 
