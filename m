Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BA83E5ED3
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937601; cv=none; b=D+7KJB7crdLMbPNk7ePsNulFXdRBp52AuXwPlI3IK8PGDK4C3Q951n770kFQGCDnTAN9KgWq7df2uOhMOHiFWcPeqA09yMfsEDHPyn18wXiPzMpUod1K/qRjZBa4aAUD+C+tEWbx5GRHA8QjmndgoRhlH+7uLN7HGVn7j4L0KrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937601; c=relaxed/simple;
	bh=u9moo65x03qWiVj+FNv6pjb8T63fO0FWXRaF/TZaVNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKvtj89gFPXPNtwKQuej/T1Z86bwRmQJp4f24wbPnhGTwbxd9a1rHd5Cz/VmE5klOjkzA1DR3gCTrRNT4l0aXYxVdLw1Rm/5+eNMnXN2oHcnvIgG3oo1uJRPMm7w6uRLsYQWIF7g1LJWrDAQ7Ysme+dAalu8tN0VglXNPYBPIA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GakUp5Oc; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GakUp5Oc"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so88375e9.0
        for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783937598; x=1784542398; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4FOjodbDLawuqaxqRGW5J71xttNR9yOzfD0eE/pV9Fc=;
        b=GakUp5Oc1ARRNMKMdwYCDLZ7Q7inNRoK061V53GcuQAdBdyoL3JACUaBiUpQnLzLuo
         uC7KU0VgYiHTlrJqYgy66UD7seo7h0urE2TRYGEVNtGtMbPw2iCFw0ZnSN7rWLvlMRm8
         QqxGjWKmBI6NkA1Zn8btQMQsvsTPckI2Ku2tSbYbRTzmCD8Mq5VWyoUcI4R8hgSB5f5o
         /BZsT8LlwlpY76OoYDwg5yRRHUhTzUFLnDneuNGFIruSgpQw7YJ7GJJRorEP4buRt2bu
         PmttwuuXKhsxFGUqPseUfTN+HvTIlNAu39VQss0fvg8PpQM1SI0iwHLkdLAR86OfP2tj
         4v8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783937598; x=1784542398;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4FOjodbDLawuqaxqRGW5J71xttNR9yOzfD0eE/pV9Fc=;
        b=qdQnOM6wtyNJNurLld2Wresegq0KlxtSC0zD+BTHGlMxA73wyukBDdO08GIdJBP2pL
         rBgTF7ZkvnzX6sXGKx6iBNIx3V9zIyqXta4+H3i+2rJ29i9dCRWYeahC5mu2A7FpmwrK
         G97450vecouJ7oKqI9phi86x+a90XYNvcIBni26okCddf/GKCmN0DPOXWO66knojcFUV
         SHak17yeBj4bQgSfXBASez/r9xJ24D/C9n1Ji84CYKV6fotZnwGX4aQ0Iv1DzrahqLwI
         68IjjI0N0qBi9EdY+f6IxWRxY2dJIvCo0cnzrt4NeGSro01gvy0EcvdBcFaCA5ekKQwG
         K3Aw==
X-Forwarded-Encrypted: i=1; AHgh+RoIxwzZVIbQtyxUPF0AGO5pM0XP3E8asvjGgJj8KUjECQQtXZKeoHgGA59iMYFJltT3S3kpxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCF2B0sO89kScrSDc9S+3aDx3THXlvhwOJv8eogJA2bluC8GZQ
	vwiIYQ7hSAz2ZJuHSIav6KGTnuFfWVuCG6UflQf0JweJA3sNMdurk8kPuZ9KHDt8qn75Uiy4vA6
	vZlGjrg==
X-Gm-Gg: AfdE7clJARxSsbBmWwAZXV3XjoTzzc55b6UVE5FPaX3SQoANVUclxGtKjuG7eVavo3+
	30vx8IC/4rND4Y5KWdRghSvgCFxPcGWHV6Mg2z6ROCZ9eIdI88HNona7npKCnC5wJl1iNBb1Cj1
	AySqJght8j6mpByo0//YoXvwUFVmAXNJH9Myd9L9JsI+uz2tTPEJIKdLJgqWirFbwwsiclAeCH+
	PiRzrS/W3hSHVmS2Q49QrMhZmN7whnM76bbHJ+h9+zUO1MWvx4gXRgPIXzqCp9Ery2BUD0SEUzS
	JEqfHgWHHNpwdJxil4AERJ52h0fb2bUoLtm8U7R4u8DiF/cB8vf0cVSOlaq96zWQrS4Xq/1fF3C
	N3Jsg+y9WZHNd5s7qVaFcvnYQOzsTyK7/M4snG22W7oNeVn94+sVs98GLzSAyrox2WLPT1aXWK4
	lRwaHBhFxn1PrD5becI355tcm4jcZwqWX/1Z3MPCBDdymiAmUQ
X-Received: by 2002:a05:600c:4ec6:b0:493:aed4:8d03 with SMTP id 5b1f17b1804b1-49468883469mr153335e9.9.1783937597212;
        Mon, 13 Jul 2026 03:13:17 -0700 (PDT)
Received: from google.com (220.60.76.34.bc.googleusercontent.com. [34.76.60.220])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm80270824f8f.23.2026.07.13.03.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 03:13:15 -0700 (PDT)
Date: Mon, 13 Jul 2026 10:13:09 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jean-philippe@linaro.org,
	jgg@ziepe.ca, mark.rutland@arm.com, qperret@google.com,
	tabba@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v6 07/25] KVM: arm64: iommu: Introduce IOMMU driver
 infrastructure
Message-ID: <alS6NVzDahb2sCQP@google.com>
References: <20260501111928.259252-1-smostafa@google.com>
 <20260501111928.259252-8-smostafa@google.com>
 <alEbHFbmr_PvY6ZB@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alEbHFbmr_PvY6ZB@google.com>

On Fri, Jul 10, 2026 at 05:17:32PM +0100, Vincent Donnefort wrote:
> On Fri, May 01, 2026 at 11:19:09AM +0000, Mostafa Saleh wrote:
> > To establish DMA isolation, KVM needs an IOMMU driver which provides
> > ops implemented at EL2.
> > 
> > Only one driver can be used and is registered with
> > kvm_iommu_register_driver() by passing pointer to the ops.
> > 
> > This must be called before module_init() which is the point KVM
> > initializes.
> 
> Everywhere s/KVM/pKVM/ as this can be registered only if pKVM is enabled.

Will do.

> 
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_host.h       |  5 +++++
> >  arch/arm64/kvm/Makefile                 |  2 +-
> >  arch/arm64/kvm/hyp/include/nvhe/iommu.h | 13 +++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/Makefile        |  3 ++-
> >  arch/arm64/kvm/hyp/nvhe/iommu/iommu.c   | 20 +++++++++++++++++++
> >  arch/arm64/kvm/hyp/nvhe/setup.c         |  5 +++++
> >  arch/arm64/kvm/iommu.c                  | 26 +++++++++++++++++++++++++
> >  7 files changed, 72 insertions(+), 2 deletions(-)
> >  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/iommu.h
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> >  create mode 100644 arch/arm64/kvm/iommu.c
> > 
> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 851f6171751c..52898d2a3ec6 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -1733,4 +1733,9 @@ static __always_inline enum fgt_group_id __fgt_reg_to_group_id(enum vcpu_sysreg
> >  
> >  long kvm_get_cap_for_kvm_ioctl(unsigned int ioctl, long *ext);
> >  
> > +#ifndef __KVM_NVHE_HYPERVISOR__
> 
> I think it's not necessary, a lot of things aren't guarded for
> __KVM_NVHE_HYPERVISOR__.

That makes it clear that it is hypervisor code, but no strong opinion.

> 
> > +struct kvm_iommu_ops;
> 
> Perhaps we can keep this private to hyp code by just using (void *) here?

That does not leak the struct, it is just a forward declaration, I
beleive it is more clear and readable this way.

> 
> > +int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops);
> > +#endif
> > +
> >  #endif /* __ARM64_KVM_HOST_H__ */
> > diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
> > index 59612d2f277c..0ddef54f7434 100644
> > --- a/arch/arm64/kvm/Makefile
> > +++ b/arch/arm64/kvm/Makefile
> > @@ -24,7 +24,7 @@ kvm-y += arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
> >  	 vgic/vgic-mmio.o vgic/vgic-mmio-v2.o \
> >  	 vgic/vgic-mmio-v3.o vgic/vgic-kvm-device.o \
> >  	 vgic/vgic-its.o vgic/vgic-debug.o vgic/vgic-v3-nested.o \
> > -	 vgic/vgic-v5.o
> > +	 vgic/vgic-v5.o iommu.o
> 
> alphabetical order.

That does not seem to be already sorted.

> 
> >  
> >  kvm-$(CONFIG_HW_PERF_EVENTS)  += pmu-emul.o pmu.o
> >  kvm-$(CONFIG_ARM64_PTR_AUTH)  += pauth.o
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/iommu.h b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> > new file mode 100644
> > index 000000000000..1ac70cc28a9e
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/iommu.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef __ARM64_KVM_NVHE_IOMMU_H__
> > +#define __ARM64_KVM_NVHE_IOMMU_H__
> > +
> > +#include <asm/kvm_host.h>
> > +
> > +struct kvm_iommu_ops {
> > +	int (*init)(void);
> > +};
> > +
> > +int kvm_iommu_init(void);
> > +
> > +#endif /* __ARM64_KVM_NVHE_IOMMU_H__ */
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index 89d0533921f9..606c0e1b7bd0 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -24,7 +24,8 @@ CFLAGS_switch.nvhe.o += -Wno-override-init
> >  
> >  hyp-obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> >  	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o page_alloc.o \
> > -	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o
> > +	 cache.o setup.o mm.o mem_protect.o sys_regs.o pkvm.o stacktrace.o ffa.o \
> > +	 iommu/iommu.o
> >  hyp-obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
> >  	 ../fpsimd.o ../hyp-entry.o ../exception.o ../pgtable.o ../vgic-v5-sr.o clock.o
> >  hyp-obj-y += ../../../kernel/smccc-call.o
> > diff --git a/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > new file mode 100644
> > index 000000000000..406c8fb9b3b9
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/nvhe/iommu/iommu.c
> > @@ -0,0 +1,20 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * IOMMU operations for pKVM
> > + *
> > + * Copyright (C) 2022 Linaro Ltd.
> > + */
> > +#include <nvhe/iommu.h>
> > +
> > +/* Only one set of ops supported */
> > +struct kvm_iommu_ops *kvm_iommu_ops;
> > +
> > +
> 
> Empty line.
> 

Will remove it.

> > +int kvm_iommu_init(void)
> > +{
> > +	/* Keep DMA isolation optional. */
> > +	if (!kvm_iommu_ops || !kvm_iommu_ops->init)
> > +		return 0;
> 
> The absence of the SME workaround on affected systems breaks pKVM init. So
> perhaps the IOMMU should do the same? (see pkvm_check_sme_dvmsync_fw_call())
> 

I initially done something similar, but I was not sure if that is too
limiting as now pKVM will not run on many hardware, I think the
best option is to make this cmdline configurable wether DMA isolation
is required or not.
But for this series we can keep it optional.

> > +
> > +	return kvm_iommu_ops->init();
> > +}
> > diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> > index 8041f6e80cd1..1f6b221db9a0 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> > @@ -14,6 +14,7 @@
> >  #include <nvhe/early_alloc.h>
> >  #include <nvhe/ffa.h>
> >  #include <nvhe/gfp.h>
> > +#include <nvhe/iommu.h>
> >  #include <nvhe/memory.h>
> >  #include <nvhe/mem_protect.h>
> >  #include <nvhe/mm.h>
> > @@ -329,6 +330,10 @@ void __noreturn __pkvm_init_finalise(void)
> >  	if (ret)
> >  		goto out;
> >  
> > +	ret = kvm_iommu_init();
> > +	if (ret)
> > +		goto out;
> > +
> >  	ret = hyp_ffa_init(ffa_proxy_pages);
> >  	if (ret)
> >  		goto out;
> > diff --git a/arch/arm64/kvm/iommu.c b/arch/arm64/kvm/iommu.c
> > new file mode 100644
> > index 000000000000..f247384fa193
> > --- /dev/null
> > +++ b/arch/arm64/kvm/iommu.c
> > @@ -0,0 +1,26 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Google LLC
> > + * Author: Mostafa Saleh <smostafa@google.com>
> > + */
> > +
> > +#include <linux/kvm_host.h>
> > +
> > +extern struct kvm_iommu_ops *kvm_nvhe_sym(kvm_iommu_ops);
> > +
> > +static DEFINE_MUTEX(kvm_iommu_reg_lock);
> 
> could be moved directly into the only user: kvm_iommu_register_driver

No strong opinion, it seemed it can be easily re-used this way.

> 
> > +
> > +int kvm_iommu_register_driver(struct kvm_iommu_ops *hyp_ops)
> 
> __init ?

Will do.

> 
> > +{
> > +	guard(mutex)(&kvm_iommu_reg_lock);
> > +
> > +	/* Only protected KVM before de-privilege. */
> 
> Don't think that comment brings much information, looking at the line below.

I will remove it.

> 
> > +	if (!is_protected_kvm_enabled() || is_kvm_arm_initialised())
> > +		return -EINVAL;
> 
> -EPERM?

I can see it both ways, my thought that it is invalid to register a
driver after a certain point, but -EPERM makes sense also.

Thanks,
Mostafa

