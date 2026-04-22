Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E1A346AF8
	for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 15:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776872682; cv=none; b=ZvXx7bv2X2QKMMN9c6/jDAR5iZfXEarmoihw4WJH1qAPyiQJ86UW8C4nnAjFvGTvw/BKipMp8drQCCK+uqSn9qE25x1g2SZ82QfM1o+aFLFb+1FZE/tcp4Ia9tUVGRMmFDDBh5TSciRiF82t3gA35tzKKe5c6JwoG6jvEfsimxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776872682; c=relaxed/simple;
	bh=avnk4GU77eJdWBqpzi1y776H5v2VdhpFnM8ByuUntY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eiQ7705QnRkjxbtHjYdzi4NM7lwSiMaLfQxHyHiHibLJdm1H5xCABkYb4IS7AvTYe8XRemgaPkl4srVfCz+i2KTy91Zl2YHA+hTqtGSOUqfK8rJM/JX+JgQ/cOUjXqJm8lExsNas1SbtMHD21i4/14iu6mCz7o/4/8hwGh64Dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KiMpyOuq; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KiMpyOuq"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2591757fbso9995ad.0
        for <iommu@lists.linux.dev>; Wed, 22 Apr 2026 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776872681; x=1777477481; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3/bQL7TanDi+LGxlRj56HG2qI4sxsGUbPbeeZiNiay8=;
        b=KiMpyOuq5JjbEuzdgw0+lrKcIAI8IyNxpkE+NSWQKYGu2AK4oF5ri4/0eIjBeCIXp3
         Q7kWEFKu6Wb+GqzJvXQe98dR1koWH2ApyYi6yS2BAApw3wkCI0w5WDcG0JukdZpaIGQk
         4NU28q0+3I0RFjBrCg2DPasDSI2gaqcAasgpT4ouPhKbcrhv7kOg3Ynmqls33jUalBhl
         eclTAkoSMbisKYbnqj4YxR+xP4222FbY+z1bucWDt58i2eGNbBrOISbYJwPyBiKN5aeW
         2zithZuZTBHBgoKwp8ekVG0VA9xQGZzBPbmWyR2B74BjvZv5Nghyz/kVVxlbQczKI68P
         2KOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776872681; x=1777477481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3/bQL7TanDi+LGxlRj56HG2qI4sxsGUbPbeeZiNiay8=;
        b=KaNk6n5H4nH2pFMCMo2uffxggIfmS/9SSoGbCLPzRXWiWD1Bzsh4+448n1d0V6J5tX
         mButQbEDeuwhG7aE1jT9uMSA2I63VGKrcTpyAPk4BAe/RqdN4b+c0h6Bd6y+xWIHDwFO
         vranURYbe75DlpWNtWll608CYUEoIaxU6kPMC/BQw6rU6CH6fbDFcofCaWYFjEbiG97E
         y0G1M1AT8Tb4oEspOAMYHmlQcRYaO9oeOs9Vr2pmuJF8ZnuwusE2q+ZpI8fYN0XvwWHi
         Z5x2o5oqYjvLaZ+vF6qPyb8Lgupik6MvSFM/hLFWPQxr+6/+/2wF16/lQfUmBJXAr08r
         kj3w==
X-Forwarded-Encrypted: i=1; AFNElJ8m5VqGzyJTJC4OlhvXm4M2e48Bu7G5KFAPmRPB5PTaeabCw3w3KdYwjRJd41eZtTETf/LOnQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdXvG0zN+7o5YrvirWqsbcrBxVbCbkA6wVz36VK/+dERsTexgg
	JDoWcPl00+WsqcLzfrvsdYZaNtgydVcU79ENTfWuoDYBXhtU64kVbJBLsxr28cnWOA==
X-Gm-Gg: AeBDiesk1BQcsUHV68Lu0T3PzFAeUpuCz+420ayR/bxkaevJYMpSBkvaWdQosQyumXp
	qn1o7LTIr2w2F9V5PiS+gaNoSQ/cjY8MJRImp8hZDe+FWT0zslz4PMGbyngOXKy95cJLI4UwKkb
	3O9RkjEQ5pKYmMMb+faqWT1WEKSCZ8CJb++Z28/V7jRlXX5e/JA+icuF+QVlPI07hCigbLnCHdh
	TOu/Niq3JWqDBUJeOZFVGDYS2IRAKoVX2Q5oNDHtyEKwVWt/m7NDJHUNUQ7ZDCzBaswpo4/DxFZ
	8kfxncHFVFVAT2LG+zQ/OXoGkRJZTP5xSFbvR4UxXHrx519bDgKGJ79/NBoK2Vov6DYbZ+7rKWB
	mD1q2s+K/RxSAFKm1cp1QnD3eYPucnPf7vRodaKajiH7+cE3h0XI/F1Czyf/4mFI+8TiVLjfZtd
	CDfpnogUP8rlU+XTV6cTY2HV3Nm1LOieGZVXLRN0/j/IyFFT3iHJ3jIsSOV8lZQsgRXGUQ9x1q6
	0+wDZU=
X-Received: by 2002:a17:903:2f10:b0:2ae:4e8e:954e with SMTP id d9443c01a7336-2b603f3d6demr6173345ad.5.1776872680351;
        Wed, 22 Apr 2026 08:44:40 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b60003ffd7sm152803975ad.80.2026.04.22.08.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 08:44:39 -0700 (PDT)
Date: Wed, 22 Apr 2026 15:44:33 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <aejs4So33q0PoghS@google.com>
References: <20260420123221.20801-1-epetron@amazon.de>
 <20260420124032.GO2577880@ziepe.ca>
 <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260422064431.GA49867@dev-dsk-epetron-1c-1d4d9719.eu-west-1.amazon.com>

On Wed, Apr 22, 2026 at 06:44:31AM +0000, Evangelos Petrongonas wrote:
> On Mon, Apr 20, 2026 at 09:40:32AM -0300 Jason Gunthorpe wrote:
> > On Mon, Apr 20, 2026 at 12:32:01PM +0000, Evangelos Petrongonas wrote:
> > > When the hardware advertises both Stage 1 and Stage 2 translation, the
> > > driver prefers Stage 1 for DMA domain allocation and only falls back to
> > > Stage 2 if Stage 1 is not supported.
> > > 
> > > Some configurations may want to force Stage 2 translation even when the
> > > hardware supports Stage 1. 
> > 
> > Why? You really need to explain why for a patch like this.
> > 
> > If there really is some HW issue I think it is more appropriate to get
> > an IORT flag or IDR detection that the HW has a problem.
> 
> It's not a hardware bug there's no IORT or IDR bit that would make sense
> here.
> 
> The motivation is live update of the hypervisor: we want to kexec into a
> new kernel while keeping DMA from passthrough devices flowing, which
> means the SMMU's translation state has to survive the handover. The Live
> Update Orchestrator work [1] and the in-progress  "iommu: Add live
> update state preservation" series [2] are building exactly this plumbing
> on top of KHO; [2]'s cover letter calls out Arm SMMUv3 support as future
> work, and an earlier RFC from Amazon [3] sketched the same idea for
> iommufd.
> 
> For this use case, Stage 2 is materially easier to persist than Stage 1,
> for structural rather than performance reasons: An S2 STE carries the
> whole translation configuration inline. To hand over an S2 domain, the
> pre-kexec kernel only needs to preserve the stream table pages and the
> S2 pgtable pages. An S1 STE points at a Context Descriptor table and as
> a result Persisting S1 therefore requires preserving the CD table pages
> too, and because the CD is keyed by ASID coordinating ASID identity
> across the handover.
> 
> In the long term the plan should be to persist both stages.
> However, until a patch series that properly introduces SMMU support for
> is developed/posted we would like to experiment with S1+S2-capable
> hardware with an easier to implement handover machinery, that relies on
> S2 translations.
> 

Hi Evangelos,

We (Google) currently have a series in the works specifically for
arm-smmu-v3 state preservation. Our plan is to post it in phases (S2
preservation first then the S1 + CD series) once the iommu: liveupdate
persistence series has stabilized.

Since the iommu core liveupdate framework itself is still in flux,
it’s a bit premature to accept/merge this patch before both the series.

Furthermore, it must be noted that even if the iommu liveupdate series
is merged, until the framework is fully integrated with the SMMU driver,
liveupdate shall remain essentially non-functional or 'broken' for
drivers that haven't yet implemented the necessary support hooks.

We’d prefer to wait until the core infrastructure is solid so we can
ensure the SMMUv3 implementation aligns perfectly with the final
requirements of the iommu liveupdate persistence series.

That said, we don't mind posting our arm-smmu-v3 series with S2-only
preservation early as an early RFC if that helps align on the design
and implementation details.

Thanks,
Praan

> [1] https://lwn.net/Articles/1021442/ — Live Update Orchestrator
> [2] https://lore.kernel.org/all/20260203220948.2176157-1-skhawaja@google.com/ —
> [PATCH 00/14] iommu: Add live update state preservation
> [3] https://lore.kernel.org/all/20240916113102.710522-1-jgowans@amazon.com/ — [RFC
> PATCH 00/13] Support iommu(fd) persistence for live update
> 
> > Jason
> 
> Kind Regards,
> Evangelos
> 
> 
> 
> Amazon Web Services Development Center Germany GmbH
> Tamara-Danz-Str. 13
> 10243 Berlin
> Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
> Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
> Sitz: Berlin
> Ust-ID: DE 365 538 597
