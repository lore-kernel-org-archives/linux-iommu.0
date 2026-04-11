Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5A1A6808
	for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775911670; cv=none; b=DFYiyt+STbYRquHUcFJhw1fqu1qiZC0ruNXKbVeiC2TURkgdFwaH9xJkQGTEXVx96R+XVoNdXwE/mzB6qbYXflZu2gyjAKiUrzLjwauB+QZldN/DcUnrnzbnYQZeIm1/JbGcZXURqh2/3E1tplQuNcjRooLcDlWPKGeQgqcFppI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775911670; c=relaxed/simple;
	bh=vE6uduna5kbLefu3g/QI7NWKo/mMqJB28trOSCaWors=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SHs0ns70bgzehHuY4V5CrFktAsR8myG9FrgNFuQhn8Y2rZ5ly46cN3wr9lUbcsmIBROTgCsQNYbsiIvSr0QjqBWVZnmdany+/8+HHf9Z1nzgl7dvvR0vVufIesaVXdAJlTpmFy3P61tPfz5rUoberp2Um3tmhYGIChdtt97pg+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UW7g2AL3; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UW7g2AL3"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50da9a7928cso23577841cf.3
        for <iommu@lists.linux.dev>; Sat, 11 Apr 2026 05:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1775911668; x=1776516468; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2V2rJGuz1N7Jn8jex+6xRO5eeCVkWdXEYVceyBVA2GA=;
        b=UW7g2AL3zwihgTNuh3TuLIC6tnG83HJjnN93rBi7wy/UCr16PtVoIIu5hoT/RmXWeA
         Gw58BjCHJ2nqiyirrK6l51AqnSA7bzjO3TF4gQvdGOjHNrpKyLCUAI2jEzvPRt8+Ti9P
         rCOWH37iuIKTUyXBqlxM4zXTuKSy00NbSynFgAb/KSrSwEbgfkl72qcYWlx1tIylXSFP
         WEI0rlHBKo//l/0ZCqEt32GtPcWj+7m8vRGXFCkVArlTs5qwIXX+6bqCLY97p3rGnCP7
         FTiMqdXgwOWRnV+6tPFZLoz4nd2KRTKK8DcoEO1HSBzmCVYrbpOvY9Mp5kWUsJrNz/L6
         RtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775911668; x=1776516468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2V2rJGuz1N7Jn8jex+6xRO5eeCVkWdXEYVceyBVA2GA=;
        b=CpdXfA2tuhMgqKqGsbBz2E2mFVvFvnIQ3xq7FEEpFg59KaDXTPSnDleaQf38WbEfMk
         ITWu6QfAtICR3FSObfakvNJy0sCGxg4n/SkLka60udj0jnPI5LYwI7fU1X29d9tEm+B8
         10TTJlCzBEFQxg6niEbI/rhxzHosBJ/0cZxCBI3Dgmrq5qV/DdljDwSbnXuONi2iBWoA
         d2NVEc7jP4dov2Vm2JtO++wQFgnmTbwXiT3f3UaNw+e2t9Puit4MwFe80uXEO0Xsx763
         sJWXmU/VgaZmTxPUKjgiRBteXVeXXgiz8DpOCRR2L/jSxOEzrafwJ2S/9QXlUsF9AwEo
         ndvw==
X-Forwarded-Encrypted: i=1; AJvYcCUU/5dATTFTdiItzSK7wBh5Sn5uFTEBjqDMeN0nw7bdVyilqbEDK8KkoqSYluCZ08GrFXFFUg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzjelrAhBa1qKindayuf2JTXpG2WkDnWmYNrUxMhEYjRBF8LGpE
	pIVGxOEAKE8JaguymnV891tmZN/PRhhTvNE5JadH78ofUg/KvgzwSUVxqVuSiSQ11IY=
X-Gm-Gg: AeBDiesn5dZAI+gIFsBwrChDLDglJ2x6B/1k1Dd9uzqmRdhcmNBRyVvDdVAGcn/xAcn
	i/LyuqZn3c8QIS5BaR5ZfJV4eRxGWqSt7/3sWnFnsnZF8B1trKDM/R0p8lfwqH6WZy/SY4vdfVd
	hehJHqetGZFvRHslpE5Q26O2OIvo8xxqiJhE6bzsNdDw8QgJ1V0RV34rd5BE2EgWvLvg3efGvXb
	1FvWw70OpSH2FGBKBFyhrNKa0unrd9JjaZMWf0XjWtrIuSjCi6FxRtU3yS0fTY3pnS9C16BHdrr
	HZsu9DN1PieZaLnWm/+lYLVP5sxsbpZmBfO/KY4LYqS2Ep5fQoxPPh+QcgcsfRoww5xaaGSyK+h
	v2hdWNMJ/qi2OsFnQ5keIERZG98A6Jix87Eal+rCQs9ysuL49e6MUG36OEd/uqKypu1uI7XcuPa
	LUeNbxa1cgstHKAhJIf5j4FnhrmkaKFLm/UERr/wZx+L1FpekZL4KW23b9mPU0pZbEGxL8CSXIU
	PkGGQ==
X-Received: by 2002:ac8:590a:0:b0:509:3cd:b22f with SMTP id d75a77b69052e-50dd5af20e4mr102128571cf.23.1775911668183;
        Sat, 11 Apr 2026 05:47:48 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd5651482sm43650061cf.31.2026.04.11.05.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 05:47:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wBXkY-00000002Xgq-4AP9;
	Sat, 11 Apr 2026 09:47:47 -0300
Date: Sat, 11 Apr 2026 09:47:46 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, guoren@kernel.org,
	iommu@lists.linux.dev, kvm-riscv@lists.infradead.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
Message-ID: <20260411124746.GF3694781@ziepe.ca>
References: <20260411022223.91029-1-fangyu.yu@linux.alibaba.com>
 <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260411022223.91029-3-fangyu.yu@linux.alibaba.com>

On Sat, Apr 11, 2026 at 10:22:23AM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
> a way to tag mappings with page-based memory types. Encode memory type
> via PBMT in RISC-V IOMMU PTEs:
> 
>   - IOMMU_MMIO   -> PBMT=IO
>   - !IOMMU_CACHE -> PBMT=NC
>   - otherwise    -> PBMT=Normal (PBMT=0)
> 
> Clear the PBMT field before applying the selected encoding, and only
> touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

This is similar to ARM now with the 3 kinds..

Jason
