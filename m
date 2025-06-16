Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5A73B1AB
	for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750108672; cv=none; b=JURXxskQJG56W00MwhQruUzibFevvwNtTIIU5Oi13oHHSGt2yImSNOccNjbp5mx94c0KYswu/akW84fEHOcdmoUbBcniG1kNjAv+m1FkwqjHzkGL+RyZGGXDn8uajqPJrkrLhFuNKX31A4iO4M2zCjwelsDA3l5Wco4SDyngAuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750108672; c=relaxed/simple;
	bh=SQ4FnpsNh6VpTd7gKdL4dppDBM28FgxPAn0I0bxAUa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rcRS4sqohUFg5IOkk/SodBBrTPM9nynJ2EKjKywwMbrnL8I71/beT6JoPiVPOGlT9J+D4JS7OERZcQVz5h5mb1B17hb8Qtf/XH2HFuYfnwWYmH4HJPOsGEGdkTvAKhKE0ARaLql1DBwKiNo++EYKO4yxwc9xrBy9UoV6BWnSYEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OOTY7ZBB; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OOTY7ZBB"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2348ac8e0b4so21285ad.1
        for <iommu@lists.linux.dev>; Mon, 16 Jun 2025 14:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750108670; x=1750713470; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Dte9S5IWAzLh8eHyVjwryVoXkQBlEWABWLNFJpRbeA=;
        b=OOTY7ZBBuFusHeov/nOg57aNyfWUy1tchBeBwG7FchY4modzVo+RVWUS7DeZRkc3qW
         YfVm0eGlvDcOLtH06ZMTgs8/WuMKOINF6VO2P16WLsIgTOf18rQEeaS9944eEWPwCrjF
         m1Ajk8xH8pnf8l8AcO1OR/hC8nFBYZSnwUu8dkOKCu+q2QT9QD3cpIlxiSIJr6t1yp5o
         YAF92BStappKHEwYnjLXoZD5mf6Cw9CtNRbHKDp35BGcGXeQ5fDtyk+tfl6wrKvyEMgD
         G7EWtaguWXnOqrc8DXYK/tHgOCxIHa54/O8VXPHSHcf7cHv3gnGd1XCIAPAwmnaQY2r4
         175Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750108670; x=1750713470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Dte9S5IWAzLh8eHyVjwryVoXkQBlEWABWLNFJpRbeA=;
        b=V+eyqdxX9kAyi4TFhQ8EdYKN7HGGbsWMVB+SIZXUEmJ2u7kq0pl2LI7X4p5g0EFuxJ
         OxhKjE2iZKqSEKO4CEg0F7Rsfoo7sBslurOMaAx+O+DPGm3h3R1Tt06Wp5S3tJxxejmD
         zmYEVAC6+klSphedTfjscQJKbUCmBaEEIIIh3y61r1Xm7S3hAHytwFWazGWKKzg0zBX8
         u9QtVFZnbdIjX/aEUyl6wygJ+pABpwP3nlHVoMiCbtnKqN0Wq9TV8DIZyTl/xGyyBKnj
         dtTq5PbX70rkyWYykFX8g0HyoHCcCYkmlQTA1w/koVp/0OAX6RYuhjZlJ+rXPRiRzGH2
         irbw==
X-Forwarded-Encrypted: i=1; AJvYcCXybkD43Xmx577RHEPx83FZPFaFdzyf27CrIf/L7SQVPqzXqcqukGKyFenfT1co3jEizEyozw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa6U4AyvGqx8JuKclEk7/dXQA3jhwIhcGp+g2wPrElVij5TgxJ
	2Cqq4GLaEAHV4GjkzVAaTG8yoAkPpmRBQE6/TQ80PKYGgBOTouhQzlN6QaLPU6tm2w==
X-Gm-Gg: ASbGnct17OZh/vdpPJFEUv/9wKT4eArF8eBAkPKU+rOBUClwWRQJO4yGiY/+mW3xBBr
	Ti96rxe++JKQ/dhv+aKlOFEkHXREQcj82U1vrYktm+5gLcx9830gfFCcoLGnO4Jw+JI1t0dYejj
	p2GHAXn+EuNWF0Bg3gtknl851+LrvJEUssxfGuYrq9giStzfPuSGEK2aUDU4rjMRwjd7nUY1v85
	TJl3x1koWJLHOz500P3JDbmj7AARw2DYesVtdi/VJIeZ+DE/CtnkWJELCY5GmN7KrNzRKyndXQa
	ldblY1slTzRsOMb1WQspRFLV5CMTAo701VYga/p4sGcpS/oESAKG+nsLsOuXgm+HE/E7e5b3xlh
	YF+LZat7Lut2O+Hdm5Rgt
X-Google-Smtp-Source: AGHT+IGAzwl1QJPvA++EDqwFMKyBsCjjEWjJhBE98c+aEAA11TrriZ5qleZr0s+YLMW9x0aRwxpKcQ==
X-Received: by 2002:a17:902:f54c:b0:234:48b2:fd63 with SMTP id d9443c01a7336-2366f0099e0mr5348025ad.21.1750108670083;
        Mon, 16 Jun 2025 14:17:50 -0700 (PDT)
Received: from google.com (232.98.126.34.bc.googleusercontent.com. [34.126.98.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900cc047sm7614113b3a.147.2025.06.16.14.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 14:17:49 -0700 (PDT)
Date: Mon, 16 Jun 2025 21:17:40 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Xueqi Zhang <xueqi.zhang@mediatek.com>
Cc: Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	Ning li <ning.li@mediatek.com>, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 2/8] iommu/arm-smmu-v3: Add SMMU implementation
Message-ID: <aFCJ9IuzC1Rx2atk@google.com>
References: <20250616025628.25454-1-xueqi.zhang@mediatek.com>
 <20250616025628.25454-3-xueqi.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616025628.25454-3-xueqi.zhang@mediatek.com>

On Mon, Jun 16, 2025 at 10:56:08AM +0800, Xueqi Zhang wrote:
> Mediatek has its own implementation for wrapper interrupts and
> power management.So add SMMU implementation when smmu device probe.
> 
> Signed-off-by: Xueqi Zhang <xueqi.zhang@mediatek.com>
> ---
>  drivers/iommu/arm/Kconfig                        |  7 +++++++
>  drivers/iommu/arm/arm-smmu-v3/Makefile           |  3 ++-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c | 16 ++++++++++++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c | 13 +++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c      |  3 +++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h      |  4 ++++
>  6 files changed, 45 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
>  create mode 100644 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
> 
> diff --git a/drivers/iommu/arm/Kconfig b/drivers/iommu/arm/Kconfig
> index ef42bbe07dbe..a7f98fd0f2bf 100644
> --- a/drivers/iommu/arm/Kconfig
> +++ b/drivers/iommu/arm/Kconfig
> @@ -88,6 +88,13 @@ config ARM_SMMU_V3
>  	  the ARM SMMUv3 architecture.
>  
>  if ARM_SMMU_V3
> +config ARM_SMMU_V3_MEDIATEK
> +	bool "ARM Ltd. System MMU Version 3 (SMMUv3) MediaTek Support"
> +	depends on ARM_SMMU_V3 && ARCH_MEDIATEK
> +	help
> +	  When running on a MediaTek platform that has the custom variant
> +	  of the ARM SMMUv3, this needs to be built into the SMMU driver.
> +
>  config ARM_SMMU_V3_SVA
>  	bool "Shared Virtual Addressing support for the ARM SMMUv3"
>  	select IOMMU_SVA
> diff --git a/drivers/iommu/arm/arm-smmu-v3/Makefile b/drivers/iommu/arm/arm-smmu-v3/Makefile
> index 493a659cc66b..0670065d6e9a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/Makefile
> +++ b/drivers/iommu/arm/arm-smmu-v3/Makefile
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_ARM_SMMU_V3) += arm_smmu_v3.o
> -arm_smmu_v3-y := arm-smmu-v3.o
> +arm_smmu_v3-y := arm-smmu-v3.o arm-smmu-v3-impl.o
>  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_IOMMUFD) += arm-smmu-v3-iommufd.o
> +arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_MEDIATEK) += arm-smmu-v3-mediatek.o
>  arm_smmu_v3-$(CONFIG_ARM_SMMU_V3_SVA) += arm-smmu-v3-sva.o
>  arm_smmu_v3-$(CONFIG_TEGRA241_CMDQV) += tegra241-cmdqv.o
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
> new file mode 100644
> index 000000000000..d39587b965ef
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-impl.c
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Ning li <ning.li@mediatek.com>
> + * Author: Xueqi Zhang <xueqi.zhang@mediatek.com>
> + */
> +
> +#include "arm-smmu-v3.h"
> +
> +struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu)
> +{
> +#if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
> +	smmu = arm_smmu_v3_impl_mtk_init(smmu);
> +#endif
> +	return smmu;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
> new file mode 100644
> index 000000000000..381268968185
> --- /dev/null
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-mediatek.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2025 MediaTek Inc.
> + * Author: Ning li <ning.li@mediatek.com>
> + * Author: Xueqi Zhang <xueqi.zhang@mediatek.com>
> + */
> +
> +#include "arm-smmu-v3.h"
> +
> +struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu)
> +{
> +	return NULL;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 10cc6dc26b7b..d36124a6bb54 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4754,6 +4754,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	}
>  	ioaddr = res->start;
>  
> +	smmu = arm_smmu_v3_impl_init(smmu);
> +	if (IS_ERR(smmu))
> +		return PTR_ERR(smmu);

I'd suggest adding ops to struct arm_smmu_impl_ops and use them. Please
see how Nvidia's implementation makes use of `arm_smmu_impl_probe`,
maybe we could improve that function to handle mtk smmu as well.

>  	/*
>  	 * Don't map the IMPLEMENTATION DEFINED regions, since they may contain
>  	 * the PMCG registers which are reserved by the PMU driver.
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index ea41d790463e..99eeb6143c49 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -998,6 +998,10 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
>  				bool sync);
>  
> +struct arm_smmu_device *arm_smmu_v3_impl_init(struct arm_smmu_device *smmu);
> +#if IS_ENABLED(CONFIG_ARM_SMMU_V3_MEDIATEK)
> +struct arm_smmu_device *arm_smmu_v3_impl_mtk_init(struct arm_smmu_device *smmu);
> +#endif

We'd prefer to avoid implementation-specific #if CONFIG_* across the
driver as much as possible.

>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  void arm_smmu_sva_notifier_synchronize(void);
> -- 
> 2.46.0

Thanks,
Praan
