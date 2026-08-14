Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2FD3C8C55
	for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716972; cv=none; b=lWTQEwGwBDDh4rwU2ZySL1U3x+X1NGeBo59wPr5PZyTRPAX/N1nwh8sAFMev2dfw0RF9liv8qVl5VR3NBoCXCPtGDuEqXl1JevXYziND27Ysm11MWAH4xOA9knZqf7z+HCQm6Y23DgwTJfVafs2OPIfWMhoTejUym6MLI8x8QJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716972; c=relaxed/simple;
	bh=wNpmRG0bvwI0zH3SDqeNYVrQrLdnvlPl+nuh3Ab+P20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tzw9Rr/JZq5JUbjbtxnjSzZJTO5QhU9oAYmLxelEv1UDWvQfUBweG7qkKopw8Q2Q4dkwSeSGXgFtU4kSv3hwSaRmfGlNIQjEmbIBYT57w3hNkAo5Z6wPosAHBFKzAnpwdqdtiIszy/ydjf90eq30UbrteBPimQz8qs4rUl4OLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCN65Q+d; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCN65Q+d"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso89725ad.1
        for <iommu@lists.linux.dev>; Fri, 14 Aug 2026 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786716953; x=1787321753; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rH19XpzJqW08+W7mG+VpaQ4KF0ayb7gJPWy2w+2WSfo=;
        b=SCN65Q+dac/yqwk2Np51M4MxFXHWIy6yaYnx6EoPk6/PY5f5WbJiZFDMhfkg/oEBi4
         TR0IHEOUBYf1EpdV3/iw2yOE0+WDJD6e4UwDjc21sl7oHBInln+SLGgL0xhvxOy477As
         xbiYgIvlLT26i+U1p4xUXRytKUvDvq2ZdmD04Ty2w1ucy6U/YFE/D+KdVfwaonNusW2x
         0zauoKXjRW0u5Rmaz85gF3Ghsub2cD5YUmAxnEpZgVqEGAeLnMp6yPvksU6Zq0dPiocc
         uwffo3BgDq+HAsg36QfkU1ttyVvVTF0u+1E2RjfGAHg870tjdA43jR6IBnubzDPUZTqy
         QYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716953; x=1787321753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rH19XpzJqW08+W7mG+VpaQ4KF0ayb7gJPWy2w+2WSfo=;
        b=IhiGywxsoZsef9T/OYooLoADJx7ne4mWKe3eo0UQ83AlBFSITickMnXRyQuwK1ogeg
         jCG/8ngq0NJtC0dhqZxl2RZY+ftdBcNj8YU+4cFVNAqOKl6vqVRSwOqWj38FYh04auz5
         Yxoi1LW2IshA/DaUqarFvOZfD+o8cOUp0wTSmXrPmH4DqI48MK8ZP3RHIvFeHUWe+X+Q
         EWjaKcDCEq3VPGqdqauMxqPIwl106qS1yCOPy3j018qTgFxnkBkJ0jc6FH6WaoCr5FMM
         aZ28xTtkVBk86KsfKisIq2WrkUfIpFOQWnQLLM936nL18mnbl0ok4izun7+Z0BcIVjRO
         GCSQ==
X-Forwarded-Encrypted: i=1; AHgh+RpQoViYZ3Pp5VYfElqeZZ7zdvnWD6n09EY8ZhfT7OTbZ76xOAg3tty1HzEWdG2kPdmvaWCHyA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywc65lSPSbtZ9QgSgS9isEkurLTdNJ0a8Nrj/JJWbSUjDFWO8nr
	8DPbPXS4W7hxMIIN3stGA2djkPP5stoPn8gGTo/cVovP8g4NlTxgEXiZCG8RBRelPw==
X-Gm-Gg: AR+sD12FDzlS0GMagD/nT/deoTVQ7AIEuGDQr2SgB2kMjW/qc2mFkKPg9eAr0LNZz3B
	R2mrnuJcG38fn60XTx3pE81GyVMoN2V8iuhk31+XcH45+7jhpPpyAvD3B020GCJQw134ZjA29WH
	6BOCalzdSk4Zr/kDTJfVEeMju82MnH8yjBq5saoUtPIhJ8GANGamaF5FB1uZ52Zw5fJ/9l8jOMS
	R/tmQlmtBYXR3QikoIQ8a6EQGMDdy1BvxGMcN+WIu+jmDHSDvcyDbNXe0b1M9+kSZZOKJD+VP95
	YfmAOrMUxrx9XHtIKQ6H2E++Xbm1RcWe4gEYwkd4SoxT1vyHhNbbfEJoWmlZK3QnYWlHGdyezka
	r4NOGBQQjser/fXKdto+/4z/HOrrQKNKahTzoPnhrmTjRqLHh2z1ki7NRN1LRS0mcLAGrwVPlFV
	7q7WG+Ot6rbEtuovhPpTWsJG9wCoRfjynOx5ri3uc/BgUfT9NO7dPLjwWGmKgAh3llpYOCjdMHv
	2zg9n/Vg745atJWNN7xFzPVsuKiK940WQ==
X-Received: by 2002:a17:903:15c8:b0:2ca:6bf:5bac with SMTP id d9443c01a7336-2d3af24fa75mr9130205ad.8.1786716952002;
        Fri, 14 Aug 2026 07:15:52 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8517d223f8csm551513b3a.35.2026.08.14.07.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:15:50 -0700 (PDT)
Date: Fri, 14 Aug 2026 14:15:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Dmitry Malkin <dma@nebius.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFC PATCH] iommu/arm-smmu-v3: Allow nested attach for PCI
 bridges without vDEVICE
Message-ID: <an8jEbT9pAUYfsvR@google.com>
References: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA1P190MB25578C482C8A3B06A4DCC6FDDBDA2@PA1P190MB2557.EURP190.PROD.OUTLOOK.COM>

On Fri, Aug 14, 2026 at 10:07:09AM +0000, Dmitry Malkin wrote:

Hi Dmitry,

[...]

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -5,6 +5,8 @@
>  
>  #include <uapi/linux/iommufd.h>
>  
> +#include <linux/pci.h>
> +
>  #include "arm-smmu-v3.h"
>  
>  void *arm_smmu_hw_info(struct device *dev, u32 *length,
> @@ -118,6 +120,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  		if (cfg == STRTAB_STE_0_CFG_ABORT ||
>  		    cfg == STRTAB_STE_0_CFG_BYPASS)
>  			return 0;
> +		/*
> +		 * Group-wide domain attachment also visits host PCI bridges. Such a
> +		 * bridge is not exposed to the VM and therefore has no virtual SID.
> +		 */
> +		if (dev_is_pci(state->master->dev) &&
> +		    pci_is_bridge(to_pci_dev(state->master->dev))) {
> +			dev_info_ratelimited(state->master->dev,
> +					     "skipping vDEVICE requirement for translated nested domain: cfg=%u ret=%d\n",
> +					     cfg, ret);
> +			return 0;
> +		}
>  		return ret;
>  	}


I agree that this is needed for old bridges. However, should this check
actually live higher up in IOMMUFD? Instead of the SMMU driver deciding
to bypass the error, what if iommufd itself intercepts the vDEVICE 
mapping failure during the group iteration? If IOMMUFD sees that the 
device lacking a vDEVICE is an IOMMU group alias/bridge, it could 
explicitly tell the underlying driver to proceed with a NULL vmaster?

Also, regarding RID aliasing: while it's true the host bridge doesn't 
need a vDEVICE for its own host-consumed DMAs (like AER/PME), are we
confident this won't break guest-injected events if the bridge aliases
the downstream endpoint's traffic? For e.g. if the "real" endpoint's
traffic is aliased to the bridge's RID and the bridge has no vmaster,
won't we lose the ability to inject IO Page faults into the guest?

Thanks,
Praan
