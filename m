Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDFC3B7747
	for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787737468; cv=none; b=C9O1cqDnxGEE6LIIyFVuRAy3+clEGHdRQ1WWjj+xboprRVOS8xMUKhNRRQmh1YfeH/Vob4cS9/+S6F/u684Cdt+b06HkV5pOXzw3WWOWvO+CJx2uiH0Ou2iF5kEqsQUn0W0lwF2Nxl0DfoHfNsd7uvMsJpiqU5gQlHAhWzEWlb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787737468; c=relaxed/simple;
	bh=9GuDmecgyVvxCQJOyCXGHOjgfhqUN7ivkB/e7B/dl2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sIoHftEXumsccOPAuONlbrRqKG6/1kpA14JFmmoFtevCtgJiq2YmhqtMdS6gbHwOnnuaLsjkZv0w6EuZQGxmXhDuuEJReK/9jJGvK9OWpU10Y234erpL70oThb/gcU3AbM/G9gsJr4YNL0l5Y/XmoCJwdfLWFbh/HNpSDf/OJhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f59f9pDy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f59f9pDy"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-499b1409a75so35885e9.1
        for <iommu@lists.linux.dev>; Wed, 26 Aug 2026 02:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787737465; x=1788342265; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DCpGxFqreLjSVtJ1Gq5kxQUJHIsXo7AfwLCjemfnd9c=;
        b=f59f9pDyq0XxLi/KXxBA5PNCzAd6tUTRlUJ2NP0NEmdnHA2zXjiXJS4qanoVyv9Uoi
         v3+jWcLs+YUTCk93yISkvey6DRpb4pt0cePSy27Q7SiMs2ySIBRmy5xoUt/g1aOb103q
         pMhqTKURuexb7yLiZMgEGYWZomzqWNwFa49iWWc5V7skseQ+hZn//DlU8fVggm1rnW0p
         wAdKqHa9nlTg6PTcS+1JoD4HFIC4hwoLg4GztYT653Y3Sx7W+tc1eUQyU29l7XsIhYeM
         RIeConBlN7olZ0KCL6eBAPMQtjJUUHMF0NR+1sDUTvD+Pnk/x99Z0WXJkEM1zwJyvnCK
         bLdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787737465; x=1788342265;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DCpGxFqreLjSVtJ1Gq5kxQUJHIsXo7AfwLCjemfnd9c=;
        b=exCbgfrT1SkCQ5NpLjY18lxV9cqfzqOMLZAv3ZvUfsTJJc6Fim253t0PaXxeYmw9s3
         Ji00riYrFzMWy3QRBdjbmO+4ro81grph226Fm5ssKzX5hIfu8CBHtt8ETBbB3OleY9KJ
         OEM6SvPdzQiK1Fn4pooicY2O0A139Co9UDavXMTnr/0d/HHcLAu3nUnAPcBNVNOJuFY8
         pn3CRAjf216xtyE2ovs+SK4kAsj+eVzwTXZHuB10EHBax4nO3gYvLRFeeaER7kW4cSOO
         b2mOVZL9vinLgKCE8pGX6/y7Q/Cpj6Q46w73C/2GC36ftWRTqj1RleNK4R52llB4GagD
         B7rA==
X-Forwarded-Encrypted: i=1; AHgh+RrdclkSDypN6LWii6tvqNgeW+LVzjcZ8+k6kQ8AQp50K1MlqA2teZK3dZIGywgZGJg5nMaiAw==@lists.linux.dev
X-Gm-Message-State: AFuF++nAWOS/Z5zYaCb/F1Foa//fbqnQNC/tMYDjhe0LK4xLi4j2d2D3
	KmS3ZggAnBfQJL4gWprwRkfRM23jcj27yq5zomIFaeGY+QPH/JjgZtgLzCCFwVkXjQ==
X-Gm-Gg: AR+sD11gvDzuBZ6HJ6O0ok5LrxjKOQPpE63ojBQGWnY9zkJKIR1h5qBGFEYzdLTiJax
	ygP4dvUF1+6Mqav9CmIouGEEnfdwK9S6K8bsTzHB0WRQW58x0os8dbRIzEvWBV7/k6mqznQCkas
	1mX2BLhoI7T6ZCq4bWM7xAcqDZB8KSNfAZ79+i31DiIWn2GdUt23fYQWHO6CUXa4kcIFHQm32DO
	OYvp1rMdQLP7eIarbDlJmur7hTWSCK/EAkTgwu23Ci58qs2lLs5ffgMJuHy0pKqFk2j3aIG1w0H
	Uva9T9LJQSSSuGDhnfFdtrRdD/VE6WFducISCHi596DRfSqg96JXhoZDuWh81gv+V402pgv/ZFf
	zKs4CM+iQI3WAXxolfToxTKAx1l17Dg01NgqFrGLIPqR0/gDpsolhIWcHAMf7JIGxeiYH6AH85R
	oIz65QLiDZ+oWUSsG4qepPk1l+kiyvSChoGeQyD7qsnFVqkE39Y2V+mAmdXSCHsmRZyPC6kj4AN
	RxvkKTtGbKDZby2Q7ArLwql5c6KoQ==
X-Received: by 2002:a05:600c:6085:b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-499dda23078mr651695e9.7.1787737464409;
        Wed, 26 Aug 2026 02:44:24 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dca8c75csm20805035e9.2.2026.08.26.02.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 02:44:23 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:44:20 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v7 05/24] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <ao61dMZqUEgC7huD@google.com>
References: <20260715115906.2664882-1-smostafa@google.com>
 <20260715115906.2664882-6-smostafa@google.com>
 <178769159057.3356902.8176677714818911833.b4-review@b4>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178769159057.3356902.8176677714818911833.b4-review@b4>

On Tue, Aug 25, 2026 at 05:59:50PM -0300, Jason Gunthorpe wrote:
> > [ ... 21 lines skipped ... ]
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-common-lib.c
> > @@ -0,0 +1,184 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2015 ARM Limited
> > + *
> > + * Author: Will Deacon <will.deacon@arm.com>
> > + * Arm SMMUv3 driver functions shared with hypervisor.
> > + */
> > +
> > +#include "arm-smmu-v3.h"
> > +#include <asm-generic/errno-base.h>
> > +
> > +#include <linux/string.h>
> > +
> > +u32 smmu_idr0_features(u32 reg)
> > +{
> 
> I think you should do more to make this shared C file usable by both
> compiles with more of the infrastructure available.
> 
> For instance, something like this at the top:
> 
>  #ifdef __KVM_NVHE_HYPERVISOR__
>  #include "pkvm/arm_smmu_v3.h"
>  #define arm_smmu_device  hyp_arm_smmu_v3_device
>  #else
>  #include "arm-smmu-v3.h"
>  #endif
> 
> (heh you used _ and the driver uses - in file names)

Yes, that's a bit ugly, I can rename it to arm-smmu-v3-hyp.h

> 
> Then the existing code using 'arm_smmu_device' just works fine since
> the hyp version has the same structure members. Now just move the code
> as-is.
> 
> Otherwise we still have alot of cut and paste duplication:
> 
> 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> 
> 	smmu->features |= smmu_idr0_features(reg);
> 	if (!(smmu->features & (ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE))) {
> 		dev_err(smmu->dev, "unknown/unsupported TT endianness!\n");
> 		return -ENXIO;
> 	}
> 
> vs
> 
> 	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR0);
> 
> 	smmu->features |= smmu_idr0_features(reg);
> 	if (!(smmu->features & (ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE)))
> 		return -ENXIO;

I am not sure I get this, the only difference is the printk?

We can do more with that, but as discussed last time, I am worried that
re-defining structs using macros just makes things harder for
maintenance and more fragile to changes, causing build failures,
and mismatch in types between the 2 structs.
I can experiment with that when working on the next version and see
if the there is significant benefits.

Thanks,
Mostafa

> 
> Then you can put the prior patches tlbi stuff here instead of the
> header file, which is important because after I get the CONT and
> errata stuff worked in it becomes really quite big.
> 
> -- 
> Jason
