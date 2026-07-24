Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086935F170
	for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 19:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921176; cv=none; b=m9Hdkgo5EvUbRlRRn4q1BTDamSj/W2dHyeW24pimbWP1Iq2Iv7nw2GNHAQWRrS9XDPe4r/Hw7+52UgVqvMz2ITKzh+qghXe3/Z1+49SxyptIV4/mPvuJ0ni67n4Tjejrpg8IsFWLao7zOcDgk/oTs2HJg2D1vvxX3VXJ3kxM+Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921176; c=relaxed/simple;
	bh=0HQlirkEYCWCz8l1vNkcmjQBrUCbF0fQBQEtNkiVrDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2quXLLI2ETlLqO9IErEK6DKjPZ91c9Ao2ivazZHLOvo1vkTX7nulNFqTChpKeg9Gt4Q9rc/ZgPDOJbgakAx2UK2JiKcKy2/BTH7XYsLqpAemAlRb2xZv/EVAf7WHwcmi9vnXNDF7mY9dAmmYM8JVvds3ScKP4A1WaxmA6amdq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mShK68X5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mShK68X5"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so9725e9.0
        for <iommu@lists.linux.dev>; Fri, 24 Jul 2026 12:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784921173; x=1785525973; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MzVdoK4UkN4wvU8WsKv82P8uCjeb8Sfe3uyjAreWqHc=;
        b=mShK68X5I9a7f0YcD/e3lReBNz0N63A2is5ltCK8doDdQk0evlUxZxAxEBe/1mnDxv
         u/Ftfp/65p4uA9gK9/iLyZUCKy8qV1gBwdMnGTilzsGb+HZSA2Eg0RWAD6+XXPjJ5ZvT
         jygG0tRyOpLgTf0L3vseVV5jZ2URg5LugNn9J4OVgElzvnPetP+3s6XX6z2YaL0tgzxO
         NlNZSmr2WdTeBTD+SLOI0hmDETuQTBwosZ4ElAtHWzk15g0KBMaeb2atHTeQ8u8sWP+Y
         C9Ao4TVVVZlVe+A4Lfvq6vp71WkHeWO3DghBqXHNAjhm92/5IRuQBt9vS4LmYj1jihqd
         0PZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921173; x=1785525973;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MzVdoK4UkN4wvU8WsKv82P8uCjeb8Sfe3uyjAreWqHc=;
        b=UZr/md1sawB0dupLp4d6rftgy/oVGBm6t0UkfzxX/UnjxSpmLRACv+8HNJc3hHDIZv
         flHpLR3DXhl/rPRhDY/E1n6eT+Kd/E4S76DBeMyvPM1R8frLvJW0ImKNTiksESVvpPu6
         yC/K2mC/nmPDr5rrWd6b05T+KEkVV5zifrtRZ1EhDn9Ggl5T0HtgSkfc1NBPRpJ6vks9
         i2X0KmMeP5baSjphne1+VWYpbFJoZIpMQXxECtGQfkAl0yc3gI+vwr3ML8BiM0noUpWb
         GdWKizl8DfE6WjJEOKARuC07GpNDJeguCckHwasjsMDdTn5XtJpk+2+lgTDOMwbhJlLJ
         M6bg==
X-Gm-Message-State: AOJu0YwCE+2QWbFA3xxmHrR/4wmUoHh2ok9mc6RWULiALwCcuLT4r910
	rLcn6dL39bW0EVYYKF8A57B3XXczTCx5ltG/yVOipZGzhL/jYRZ7Sss4yO4k9Txiag==
X-Gm-Gg: AR+sD10AbQyy+mmX4Cc6sDWWMs63/DSlTPVPpjV2x5T5d1RXpovocajNZUAfL7+JWr0
	Gc5XgSuzBa+91Slb42UWpoLaccEbvlYCdll+vqf6V4+lX6D9NjtRpF4VNmRsUOQbc4C+BfDmWnm
	vD3HDc8r370qU+W3jyoRrbMtZoDxmch6pl2gDlWfVdVvA5bbQT9/puGbbRBUtoy18mp6JmBfGjt
	zNvqnx8P+lmd/JprgLZ9++2IFPlTge6LHi0YCIQnUFRtC1F8GkZV3N7eocL3DTeLaZ/x+UlAc69
	JaBMgZW9CO6nlT06sl/IYcQZm1RVqb3i44aKNkQQDK8HkFycVjmEyLtaFsql90SGa0IvPy+U+gt
	Ic8hqlO25yXz1QtnWytE0NLygydoT2f5ldNKAplYzA1YEqrCKWMJYIAzyPUCLgzsnrTbEIPy37G
	qEDnvuWJdyMyLPPEXsBX0EOEG8dsCMp5BvNkibTg==
X-Received: by 2002:a05:600c:4583:b0:493:aca0:32e2 with SMTP id 5b1f17b1804b1-496b4cf6c36mr246435e9.4.1784921172928;
        Fri, 24 Jul 2026 12:26:12 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-496b4ed5f93sm11566705e9.1.2026.07.24.12.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:26:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 19:26:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	David Matlack <dmatlack@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Pranjal Shrivastava <praan@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH 4/7] iommu/arm-smmu-v3: Remove io-pgtable-arm from sva.c
Message-ID: <amO8UPHuxrvoiXq7@google.com>
References: <0-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
 <4-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4-v1-807e2d1a5efb+e1-iommupt_armv8_jgg@nvidia.com>

On Mon, Jul 06, 2026 at 01:29:10PM -0300, Jason Gunthorpe wrote:
> This is only being used to get some STE constants. Put local
> constants along side the register definitions instead.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 13 ++++++-------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h     |  7 +++++++
>  2 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 0e670c92469b2f..f82a513ede09c9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -11,7 +11,6 @@
>  #include <kunit/visibility.h>
>  
>  #include "arm-smmu-v3.h"
> -#include "../../io-pgtable-arm.h"
>  
>  static void __maybe_unused
>  arm_smmu_update_s1_domain_cd_entry(struct arm_smmu_domain *smmu_domain)
> @@ -41,10 +40,10 @@ static u64 page_size_to_cd(void)
>  	static_assert(PAGE_SIZE == SZ_4K || PAGE_SIZE == SZ_16K ||
>  		      PAGE_SIZE == SZ_64K);
>  	if (PAGE_SIZE == SZ_64K)
> -		return ARM_LPAE_TCR_TG0_64K;
> +		return ARM_SMMU_TCR_TG0_64K;
>  	if (PAGE_SIZE == SZ_16K)
> -		return ARM_LPAE_TCR_TG0_16K;
> -	return ARM_LPAE_TCR_TG0_4K;
> +		return ARM_SMMU_TCR_TG0_16K;
> +	return ARM_SMMU_TCR_TG0_4K;
>  }
>  
>  VISIBLE_IF_KUNIT
> @@ -85,10 +84,10 @@ void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  				   64ULL - vabits_actual) |
>  			FIELD_PREP(CTXDESC_CD_0_TCR_TG0, page_size_to_cd()) |
>  			FIELD_PREP(CTXDESC_CD_0_TCR_IRGN0,
> -				   ARM_LPAE_TCR_RGN_WBWA) |
> +				   ARM_SMMU_TCR_RGN_WBWA) |
>  			FIELD_PREP(CTXDESC_CD_0_TCR_ORGN0,
> -				   ARM_LPAE_TCR_RGN_WBWA) |
> -			FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_LPAE_TCR_SH_IS));
> +				   ARM_SMMU_TCR_RGN_WBWA) |
> +			FIELD_PREP(CTXDESC_CD_0_TCR_SH0, ARM_SMMU_TCR_SH_IS));
>  
>  		target->data[1] = cpu_to_le64(virt_to_phys(mm->pgd) &
>  					      CTXDESC_CD_1_TTB0_MASK);
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 95186cf84e9abb..99ca96db0d0401 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -203,6 +203,13 @@ struct arm_vsmmu;
>  #define Q_MAX_SZ_SHIFT			(PAGE_SHIFT + MAX_PAGE_ORDER)
>  #endif
>  
> +/* Constants used for CD TCR and STE VTCR fields */
> +#define ARM_SMMU_TCR_TG0_4K	0
> +#define ARM_SMMU_TCR_TG0_64K	1
> +#define ARM_SMMU_TCR_TG0_16K	2
> +#define ARM_SMMU_TCR_RGN_WBWA	1
> +#define ARM_SMMU_TCR_SH_IS	3

Can the driver use the ones in generic_pt/armv.h instead of
re-defining them?

Thanks,
Mostafa

> +
>  /*
>   * Stream table.
>   *
> -- 
> 2.43.0
> 
