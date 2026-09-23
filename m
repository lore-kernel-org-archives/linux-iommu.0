Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4649D515965
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165928; cv=none; b=Xyn0qaN+jNCWAjCYgDYDjRObj1wOBIVTVF5W9sDr/T3AF4pr+3Mrd9unj3n/MIW+1BPT5RIyLD61bVp/hNNz9Efp3zLkEPCmIJQ0X1L0eOYa+PIuZk+7RHPTLF3LpDqCD7Dc+XeD24dho8Ujn92l95LkMx37znYcqWwSsQF7SA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165928; c=relaxed/simple;
	bh=6uyCzTA89gitKOhgv2KiUrKJJ9yVEy5QdsBqN5+DQCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2f0Vkoc2GQM932FTiHrs+iHNIfsE6jBzeivmsDuvnh9w4rQf93pIDxpOuGnmsO+ABtioDcn097K2kzYWFZ3lp6mlP5Pq1UtzkUKjCtP+6N72Vbyh9nmCnHfIPVjNwPhrnH6aCitermfgAYptQflxPuIdtrwxcW8BhQ/j2aDISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usMh8gbu; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usMh8gbu"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-498012a61f6so33935e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790165924; x=1790770724; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yKoljqZU8Nwxrz36bE/WLCNEgSRa/n5CLFAsiZ8BcVQ=;
        b=usMh8gbuVR98RU+b02d2VMfdOwM8HU5GgxFSdGLApIawD9zPryenxnGjKT/uqtqdP0
         /vNw9qt9NYuFWRpknkXLtZ+RVpwpnvGVzvxICmR63wpcbhiNx981qFBmjU0ut/uBTr+n
         +GaYGGls5bjrFftn1ZmtC+kl9lRUa1ml+rv+NGHmY7Q4Q5SpwmO8kzqdv8dOb1mrUrz0
         D5lNhYn4QjWNgnt4W+p6NZlMPDAsQyJp1RsjGPsnnoKvO9a8WZzLC4WwmFQ3+qeidkfL
         8kwgLyG3ND1QKKtRiuz8ny9XUKfRgaFC5KSwb7ucDFkcMM+4uDB9MFMAhqI2GhoumGon
         1fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165924; x=1790770724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKoljqZU8Nwxrz36bE/WLCNEgSRa/n5CLFAsiZ8BcVQ=;
        b=IiNcKr597Qzij025l7f8hH/prGiGzI1JfppYj12Oj0Lm6pIMfufuUKMuS0+fxAr68B
         uOUMsxOve4+BGMBuIaJ2FpR74YCpDmQqjJJDiRkFZShegiYHk4BDAb8YyWr4utewqZ+A
         9eBPxgii5KVOfY8qLZiDJh33mngsrC+FDRo3KDn/QCOB06mjzVddo5gBFrhOSPkD6Wyz
         eeNAUyOfxJMtHIGeOxMlffSqZQlrd0jDBghjnqRZlt8MP79zV6qEz9tXMIQJ6CFPlEyz
         +QE2hG1cB2JIYkHIvRlO8iZ7k3xDEQBdsasZZc6kyR1yst4XK+jwH+EfvGJhNElN//lt
         IxyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZ8GhAmKGWODbRxgNcn0Lf/fQI7AMWo2WWT6nhiLd4p6Fz8o8kHF0braUjvTsK4qFwt4cnWA==@lists.linux.dev
X-Gm-Message-State: AFuF++nnJ4o280JgFvdw1Ygsp2E1hbkhtPiB/xdCMkLEblAHCyAL8QLp
	0bbWp500+FKe5UShxMOUo9U0nfz5tWYjm+wqum3vKUVMIAnK26uHgZT1pJJIdG+Rog==
X-Gm-Gg: AYBFou08v4mw/EoU+Zk8P9Acc8XB8XS4fQ3l/CcGrZZAzhX0Rv/7jzwC6XiYGyFq86F
	7UX4PLMKuIYospsBCQ8G/CP6PZh7LanOZAIHjRDFoxXw4K7RshkMFuVfuEI5nfYAmIt1MBx+Lve
	J/ZbqlwmbVKtA93RJ5nHeT2RKOxBMtHBRgyxihouJKsoRohEWCToQHDuTilT0NAo1BTHXmlb5O8
	tcfJMyEvy/fNBGkRcSdG7iu0SscJ8ERHiBbYK5++gMfuXr2NoH8XgR1nbX3gSx73RDWDRDXffD6
	2i/5/oMWpVfTAHaF0ogw5HwhTi369HEHKoo4+8iN6RJ1/27hEN5rbv4Q6t08G7jPpfdgni1X7Iy
	REKN4dzRV1zSDr8A6jK6DF5KxCAb1/SfF9rDgU7BtrIQcCiyDZJvcqY9SiSDicCQOHhHgG/vr6U
	JOVHkbLNK4s69uIAAXjpuPoAi1lKe9mtgUInhyshATIhGzu0XHbC8RFY5MvnRkLLy4y2I9dOcxI
	YwPCqgH2zj9SWHQK+xe6vjc7NkV4TSqwo69DVNG
X-Received: by 2002:a05:600c:3b86:b0:49f:e1d3:fe03 with SMTP id 5b1f17b1804b1-49fe1d4031emr732825e9.3.1790165924117;
        Wed, 23 Sep 2026 05:18:44 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1c0f6csm90764065e9.3.2026.09.23.05.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:18:43 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:18:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, mark.rutland@arm.com,
	qperret@google.com, tabba@google.com, vdonnefort@google.com,
	sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 04/25] iommu/arm-smmu-v3: Move IDR parsing to common
 functions
Message-ID: <arPDn5c815X72PSF@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-5-smostafa@google.com>
 <arLa0E3xq5dGuPpd@nvidia.com>
 <arOlQtPYzF5yT8fP@google.com>
 <20260923115257.GC2545495@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923115257.GC2545495@nvidia.com>

On Wed, Sep 23, 2026 at 08:52:57AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 10:09:06AM +0000, Mostafa Saleh wrote:
> > > > +	if (coherent && !disable_msipolling &&
> > > > +	    smmu->features & ARM_SMMU_FEAT_MSI)
> > > > +		smmu->options |= ARM_SMMU_OPT_MSIPOLL;
> > > 
> > > Will pKVM ever use MSIPOLL?
> > 
> > No, this version does not support MSI and hides it.
> > And this check can not be moved because disable_msipolling is a
> > module_param.
> 
> Could you move the above if into the shared area and have the callers
> mask off options if they don't want it?

Sure, I can move it and pass disable_polling as an arg which the
hypervisor will set to true.

> 
> > > > +	if (smmu->features & ARM_SMMU_FEAT_HYP &&
> > > > +	    cpus_have_cap(ARM64_HAS_VIRT_HOST_EXTN))
> > > > +		smmu->features |= ARM_SMMU_FEAT_E2H;
> > > 
> > > Why is ARM64_HAS_VIRT_HOST_EXTN left behind?
> > > 
> > 
> > cpus_have_cap() can not be used in the hypervisor.
> > Also, ARM_SMMU_FEAT_E2H is not exactly FEAT_HYP. As it defines the
> > world the translation lives in based on the kernel EL.
> 
> But don't you need this FEAT to issue invalidations correctly?
> pkvm never issues a S1 invalidation?

No, STRW is enforced to zero (NS-EL1) with pKVM as the kernel must be
running in EL1.

pKVM will issue S1 CMDQ_OP_TLBI_NH_ALL to invalidate all of S1
after S2 changes and invalidations.

> 
> > With pKVM at EL2 ARM64_HAS_VIRT_HOST_EXTN is always true anyway.
> 
> > And the hypervisor never owns a page table itself, so it never
> > checks this feature.
> 
> ? I thought the whole point of this was for pkvm to own a S2?

By own I mean "it's own translation regime" as if the hypervisor wants
to do DMA itself (synonym to EL2-S1 translation) in that case the
hypervisor will have a different STRW and use the E2H stuff. But that
never happens, the hypervsior populates S2 to enforce isolation of the
host but it never uses it itself.

> 
> Maybe same as I suggested for MSIPOLL, set the FEAT and mask it later
> if it can't be used. If KVM implicitly knows it has
> ARM64_HAS_VIRT_HOST_EXTN then it should operate with ARM_SMMU_FEAT_E2H
> set.
> 

As I replied to Nicolin, the problem here is not the FEAT being used or
not, it is that cpus_have_cap() can not be used in the hypervisor.

I think this can be replaced with cpus_have_final_cap() which should be
the same and then move this code also.

> > Otherwise, I think we can move this check and use cpus_have_final_cap()
> > instead as it can be used in the hypervisor.
> 
> Or that, I don't know the difference

I will try that for the next version.

Thanks,
Mostafa

> 
> Jason
