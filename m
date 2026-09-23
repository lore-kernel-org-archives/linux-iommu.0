Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01548822C
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 10:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159417; cv=none; b=BLSiyZcyjkSXcuPDa6PgFDn1Pa8iZR4dGsJNS5kvdS8j2U1rsOdwqU6OnV/svjDKYAVyVK4b4Kulv5mpmiytMw5OpaxFr56ft3z816Msbb9/xG2NW7ozl2cNEMjWTp2K4FwcVsICGrjlg8EF39Tb6JMpN7YL+Nn2SVdiSd2UsnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159417; c=relaxed/simple;
	bh=RH724JkT1TH0BVBbfq0vo+soCwQoN0cmU8izeXTd2vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MoJl3Sn41BuM9AHJOvYP6p7tj2TPBwLnY6shu1EH0NjYKAVrwmD3AR+YGBsBvAufPv7o/v3t6F27s2L0duC5OWh5y/B8NhdKktR74X+EsGFu6iaRhOqZb1+P6E0QHd1EYpLqhYNMxTPYvCT/Ncmpy3RnbdTSnPI1TneRyFVEBHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CqVVvPNF; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CqVVvPNF"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-498012a61f6so29785e9.0
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 03:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790159410; x=1790764210; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ovOwY8bLaV9a90WmLe0SJbMjYqolqHUHY1GzJaJp6yo=;
        b=CqVVvPNFKmkIkc1XPcBvsz/sNGZu/egCVHwZo7pz/mGo5xQGXT0SrIg+A0+FD075+H
         eCXxZ2XKN5zA3GHhj5LmM8hKKct/k3di4o9C+WYRoZI8J2mAIJtLMJte6ucqeltOf42B
         NhYB2O+i1anVt4P6sEikqNlovUgbsOVX9BHJjyyud+DLlf2WCFhmV7mnVQFcax3cNDVa
         +Dj+4H6YHqw3sentgmT145OSwkMa53/ozrJKnu4HSsMzIfXO4uQo3lqh1Y93oUpRk5bv
         QKSJH6T7fl+AUv+alKVkv9c2o/bZc9hqD+0SWXL6N2zu1K76wN3g/C5U0UXe8VRwatln
         WgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790159410; x=1790764210;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ovOwY8bLaV9a90WmLe0SJbMjYqolqHUHY1GzJaJp6yo=;
        b=d/+4h6xfYPov52yhKEoL+lVStP8jvnIgnpBb0I7qB/oczly0UsPwXPhivWhU0e2uKs
         6q+bb5ACg9BeOQzttTc7rLycMOb/lQPm+9l8Gz3qbcV3gW5DsAY52ZzRu04ym/e97Ymi
         UiMHA/EXG32r7csMie7oqpNmCTs2E9zFAoU9ZKdRP6XejJxIsuFdfFxojA95LgwT/I6t
         VEEf3iDkwFl38CtNxnWg/eJWY9wnS5mWEDor5ictQVtaWg//T7IEXrd1LLOyD6D36AzA
         Fb7SNufQolw+h3Xd2s3Dxtdos9+M7hqAqpohaUJkWOZzFxnd2uPBgZWEEf3aF11krV5d
         GQMA==
X-Forwarded-Encrypted: i=1; AKwUvByMLADzNHoIBKXXUd72bHsGL0cQe482nd6dj9hFy+hoxKjOxOAWY6Q4u/XpLVR9jPWVPZH2QQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kXAxPdkPj7qg0jlmY0GFGRtt+7esOesHHlHdL3kekzIg2FL9np
	4K7mEJyAUV6lzPaLJCWo7VvdoO3wG1HLmzf5RAbHNTA40pwonmyNBnKqLIAWDMgB5g==
X-Gm-Gg: AYBFou22cpVDo4boNAKNW7fxbXO56jT3NE/HihjVKyMHLQAbO7w6Hwd51nIkJKi+oDW
	+bB4JqPOAjZ+3JrvvNAB2PiUTPCEXCXhNv8MAYIqjrjNwWKdf8BuD2bKfePPWgKXwbY9PD6YSCr
	XrpwFljfUrCwMKjkl31EYSxI5xJmE76cRBCHunyXitB6unakrDzTTUiBdDptLDWL5/ViM/QO0ct
	tgS1EyH0uFs7ttWfa632igNix8P/JMOm+29zL1skK74VVuQHl1HCZEPeBMeiqw/T2Xo6B2MoDLH
	J0Dq9//xZxBZX8rD/SeDPYPNqIkTqAob8vXiW2bBFtJ/vOpkFDn5GXzz1JsSzJEqDL3NjpqVYil
	GkpSMEmy2Ao2RCnAwCNHsG6BsVqzh9THOro5h5TuUF6N1x8T2orpNd3TvKYHmcjjtd/o8Kl7pAC
	thrTYInt94CrRSh3FrYNBfZhFdVfFzG61mgvIjio67DuHEbApYB8Xk/4+6Ka5HPlataBX4Y0zLa
	wN37wmuL1gHn9GfTiFNrM6bCX6tAqQWIorFqQmq
X-Received: by 2002:a05:600c:8588:b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-49fe1a55d46mr425265e9.7.1790159409353;
        Wed, 23 Sep 2026 03:30:09 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde185329sm68031695e9.1.2026.09.23.03.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 03:30:08 -0700 (PDT)
Date: Wed, 23 Sep 2026 10:30:05 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v8 10/25] iommu/arm-smmu-v3-kvm: Add SMMUv3 driver
Message-ID: <arOqLQTOsofAzCmg@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-11-smostafa@google.com>
 <arMDiPHiMvHVHsBr@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arMDiPHiMvHVHsBr@nvidia.com>

On Tue, Sep 22, 2026 at 03:39:04PM -0700, Nicolin Chen wrote:
> On Tue, Sep 22, 2026 at 01:12:43PM +0000, Mostafa Saleh wrote:
> > From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > 
> > Add the skeleton for an Arm SMMUv3 driver at EL2.
> > 
> > The driver rely on an array of SMMUv3s on the system, where at
> 
> s/rely/relies

Will do.

> 
> > +++ b/drivers/iommu/arm/Kconfig
> > @@ -141,3 +141,15 @@ config QCOM_IOMMU
> >  	select ARM_DMA_USE_IOMMU
> >  	help
> >  	  Support for IOMMU on certain Qualcomm SoCs.
> > +
> > +config ARM_SMMU_V3_PKVM
> > +	bool "ARM SMMUv3 support for protected Virtual Machines"
> > +	depends on KVM && ARM_SMMU_V3=y
> 
> Should it depend on OF?

Makes sense, I will add it.

> 
> > +	help
> > +	  Enable a SMMUv3 driver in the KVM hypervisor, to protect VMs against
> 
> s/a SMMUv3/an SMMUv3

Will do.

> 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
> > @@ -0,0 +1,31 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __KVM_ARM_SMMU_V3_HYP_H
> > +#define __KVM_ARM_SMMU_V3_HYP_H
> > +
> > +#include <asm/kvm_asm.h>
> > +
> > +/*
> > + * Parameters from the trusted host:
> > + * @mmio_addr		base address of the SMMU registers
> > + * @mmio_size		size of the registers resource
> 
> Are these still in the host's physical address space or guest's?
> 
> If it's still "host" (though trusted), what's different from the
> ioaddr in the main driver?

This is the physical address of the SMMUv3 as read from the device
tree.

The "base" pointer is for the hypervisor virtual address which is
created in the private mapping range (similar to ioremap())

The hypervisor doesn't keep the host VA anywhere. Also note that
there is no guest support at the moment, only the host.

> 
> > +size_t __ro_after_init kvm_hyp_arm_smmu_v3_count;
> > +struct hyp_arm_smmu_v3_device *kvm_hyp_arm_smmu_v3_smmus;
> 
> Should kvm_hyp_arm_smmu_v3_smmus be __ro_after_init as well?

That won't work at the moment as the hypervisor writes this pointer
after __ro_after_init to convert the kernel VA to hypervisor VA
unlike the count which is set once at boot.
It might be possible to make the kernel do this conversion early, I
will need to double check.

It's worth noting that __ro_after_init is just for the hypervisor
hardening and not for protection as those are protected by stage-2
MMU.

> 
> > +
> > +#define for_each_smmu(smmu) \
> > +	for ((smmu) = kvm_hyp_arm_smmu_v3_smmus; \
> > +	     (smmu) != &kvm_hyp_arm_smmu_v3_smmus[kvm_hyp_arm_smmu_v3_count]; \
> > +	     (smmu)++)
> 
> "smmu" sounds too generic. Maybe for_each_pkvm_smmu?

This macro is private to this driver, so I guess that's enough, also
smmu is used everywhere else, but no strong opinion.

> 
> > +/* Called while is the host is still trusted. */
> > +static int smmu_init(void)
> 
> s/while is/while

Will do.

> 
> > +/* Shared with the kernel driver in EL1 */
> > +struct pkvm_iommu_ops smmu_ops = {
> > +	.init				= smmu_init,
> > +	.host_stage2_idmap		= smmu_host_stage2_idmap,
> 
> Can we add a "pvkm_arm_smmu_" prefix for the ops and functions here?

Similar to above, these symbols are private to this file and the
hypervisor symbols gets prefixed with "__kvm_nvhe_" anyway, so they
never clash with the kernel. But no strong opinon.

Thanks,
Mostafa

> 
> Nicolin
