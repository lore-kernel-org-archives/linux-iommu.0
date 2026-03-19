Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127173EDAC1
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936279; cv=none; b=akbDE6xyUTKiXMX2+9yEUlp5q710UdzDWOew0DTKBhbfAZfBnI7e95LqPuJ8NUjLBjntLwYSBfcflC516iZDp02CJ0KrUlp5fTvAIBa5U+CidqH2ZuQNgn4slHxUoK1ZTtiioEJQ7gDzhWfnDLvgFW63dUQ9fhOTdIHkCMfQAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936279; c=relaxed/simple;
	bh=dfS2Q8fq6arO/G/n+oqxc0mTgErVibxYeHUwv2jGQuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmYJz875YbQ8igSvzO8GpzGdJ3fn7rjaJ4GiXixbxCmdz5TGnAe/Wx1NhQXv1h4iEyLGsH5qeJTohRr4qhIZFHTD3wI2ZLTEndrwc/OLQ1ZHeLXV6ncXaJN3p8Yvm9b759LW+G77Ud/3syhZ9dqcqb8SoKksNr0Q4vqiyWfJamQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIyzTa/G; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIyzTa/G"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aeab6ff148so86285ad.1
        for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 09:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773936277; x=1774541077; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NSymXHBx0EVLNRB8aixQ7qsvbdQ8KkgdXax/b9Pc2mw=;
        b=TIyzTa/GOQLyyKhnI9NzP5LvhutIACQkrhbP26Hz+LHAPG+DzMT2sB6XW2OJe7XYIw
         IzKsS4+V+TRAYyRtG7wOyje28aOJc63tyIRvv/2cd5rJ7FI3x8Q4k69/M+3ycO+t8gkA
         C9Ys5u6bbaej3Ndhj1henTCYgFfPZuPlSNNYUg4+RJi9V3W9qkmy38dvhIpn/PCe02ZU
         mLcr8/tTF8d684zRSq8S6CeiHKyEZAF6lb2ovisalWgaBynjpvEEf10ILKZHSBp6eKso
         jVS2pqrf4tIWNU3inmje8iK1Wk5fr03qBgRsZvfVVm8C1qcuSwdmGvmKJfG6mT7afIOn
         /dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773936277; x=1774541077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSymXHBx0EVLNRB8aixQ7qsvbdQ8KkgdXax/b9Pc2mw=;
        b=msBcJSkPnNuuPZbNu9j49ZvhDeKynlmd0MjCsMyfxQYE35/VResLpePbc/NFP+clYC
         r/+I1WEqpTyEeYm0D5AimW7A8tGzqNP/RnO3aAk5KcWleScpJHkxavym634Y6FPpPiEt
         02B4CxamaOO0gwp13nmI3c7L3tqQ6zx0Gyk5VfWfEP5KsYZLItsvyx7yLzOA3zfu9L7b
         Rn3J7wmb/dVHGpPsjLMf4hwlUI4v2p1w8Gm7VPHjuc1K+rVlEhZKW9RIfd+H03ZwA7jt
         EJ4GeGrrqajpvGcHsoe3Hz6Oy3fEt/f+QRca83kQWNN7mKYjAnZ/wWNTAIj1C7LNewIr
         v3/A==
X-Forwarded-Encrypted: i=1; AJvYcCUJ0AaEevgNFVSYdueWT+r/E59592+Ve14orwufnVwKsm+DWyU8A2i3VIGPenR66Gc6qedbww==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcsME+hem/r1DNTh7VL0f03kN+sJ7pbIDTTEakX+L5JC4K1TX9
	A3wn26yZL5PZMz/vx69mhX1c3A9jcKVDRzVRh8TagR6fnLxFUbhDRQzY2QRLeYabSw==
X-Gm-Gg: ATEYQzwC3YjIR393eUvw6ntwd79hkOGnq0PYNiWJRmE6wsI0TrlL/ABPtr9LYeT82+o
	ECQO5y0O2E32Y5oJUQbsOMkqG0nhxAcxUmZA5f9XUhwvW5aYQTfN6T00vxSSoYNftgfSoo9dyVp
	6q6bP6RSRTMTMUuHPh065GYaGjSKLhkI9a2pGA1gv9SMS4ZkG6EuYH5v0SUkc4QLqBdaSzYygrr
	hjS5vfqxSealbCjtl5dFf1SK7M48srGxe6SDy753hx6gA/0gIR91sdko1zxbomwPGBYXBAR7+B8
	s1AJOGOa8VEBX4Mb0WvdF7qoPtnf0nIeWL2lzEkKHxHuC9nm14uikkrYCXk/dkrsAJE8loEWttt
	WpOK7c+6Q+ncwGJbzTXdf1aThsrOFSyABEOpW7IFQSbq3G8j/usSd84YiEpUeOhzoMZB6nfx4Zx
	v0hFQwqvQFpgOkK7rFnhDkxaSHz9vvOUktjFTcXOus+cTvP/u0R/+r72bcA7bWO3d8jgCR4m0=
X-Received: by 2002:a17:902:da8a:b0:2a1:3cda:8e99 with SMTP id d9443c01a7336-2b079fd1340mr2824065ad.21.1773936276089;
        Thu, 19 Mar 2026 09:04:36 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0b2015sm5917787a12.6.2026.03.19.09.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 09:04:35 -0700 (PDT)
Date: Thu, 19 Mar 2026 09:04:31 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 06/14] iommu/vt-d: Implement device and iommu
 preserve/unpreserve ops
Message-ID: <20260317221907.GD2582517.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-7-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-7-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:40PM +0000, Samiullah Khawaja wrote:
>  /*
>   * Take a root_entry and return the Lower Context Table Pointer (LCTP)
>   * if marked present.
> @@ -2378,8 +2379,10 @@ void intel_iommu_shutdown(void)
>  		/* Disable PMRs explicitly here. */
>  		iommu_disable_protect_mem_regions(iommu);
>  
> -		/* Make sure the IOMMUs are switched off */
> -		iommu_disable_translation(iommu);
> +		if (!__maybe_clean_unpreserved_context_entries(iommu)) {
> +			/* Make sure the IOMMUs are switched off */
> +			iommu_disable_translation(iommu);
> +		}

I think instead of having a "maybe" function where it might or might not
clear the context entry, it will be simpler to just make if-else
explicit here.

@@ -2375,8 +2375,11 @@ void intel_iommu_shutdown(void)
                /* Disable PMRs explicitly here. */
                iommu_disable_protect_mem_regions(iommu);

-               /* Make sure the IOMMUs are switched off */
-               iommu_disable_translation(iommu);
+               if (iommu->iommu.outgoing_preserved_state)
+                       clear_unpreserved_context_entries();
+               else
+                       /* Make sure the IOMMUs are switched off */
+                       iommu_disable_translation(iommu);
        }
 }

clear_unpreserved_context_entries() will explicitly do what
__maybe_clean_unpreserved_context_entries() is doing.

>  	}
>  }
>  
> @@ -2902,6 +2905,38 @@ static const struct iommu_dirty_ops intel_second_stage_dirty_ops = {
>  	.set_dirty_tracking = intel_iommu_set_dirty_tracking,
>  };
>  
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool __maybe_clean_unpreserved_context_entries(struct intel_iommu *iommu)

Nit: s/clean/clear, this matches domain_context_clear().

> +{
> +	struct device_domain_info *info;
> +	struct pci_dev *pdev = NULL;
> +
> +	if (!iommu->iommu.outgoing_preserved_state)
> +		return false;
> +
> +	for_each_pci_dev(pdev) {
> +		info = dev_iommu_priv_get(&pdev->dev);
> +		if (!info)
> +			continue;
> +
> +		if (info->iommu != iommu)
> +			continue;
> +
> +		if (dev_iommu_preserved_state(&pdev->dev))
> +			continue;
> +
> +		domain_context_clear(info);
> +	}
> +
> +	return true;
> +}
> +++ b/drivers/iommu/intel/liveupdate.c
> @@ -0,0 +1,134 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +/*
> + * Copyright (C) 2025, Google LLC
> + * Author: Samiullah Khawaja <skhawaja@google.com>
> + */
> +
> +#define pr_fmt(fmt)    "iommu: liveupdate: " fmt

Should this be 'DMAR: liveupdate' to be consistent with other files in
intel iommu?

> +
> +#include <linux/kexec_handover.h>
> +#include <linux/liveupdate.h>
> +#include <linux/iommu-lu.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +
> +#include "iommu.h"
> +#include "../iommu-pages.h"
> +
> +static void unpreserve_iommu_context(struct intel_iommu *iommu, int end)

Nit: Can this be unpreserve_iommu_context_table(), similar to existing
free_context_table()? Same for corresponding preserve function

> +{
> +	struct context_entry *context;
> +	int i;
> +
> +	if (end < 0)
> +		end = ROOT_ENTRY_NR;

Can't we just pass ROOT_ENTRY_NR as end value instead of -1?

