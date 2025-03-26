Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91793BBF0
	for <iommu@lists.linux.dev>; Wed, 26 Mar 2025 03:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742959581; cv=none; b=o4S7RTVbOIkqDnOH+TRcaanx7mfqZ4e0/fKDvSiqLc4EU8Mb+ubjtCLiy51k84NnT4nXgV6Ajw7rljBbkFOLNt/9KYrknSYf9gOnfx632lgtPeSDg+UsdxfCHhEdT57hsLS3sR8fhwTw4LHvqlDgWRvRPZmd0207Wz2kUboywEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742959581; c=relaxed/simple;
	bh=RfYEVpFV77vQUZcEiqLW/wGhxmNFc+8zk8y1nmVLwa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uyYREu7HB5peLEqQXm38yH1cGdoEoB5BSHPbKqlwvd27RpeXlS0EMC3uEvvLaPrOtCVn+OadORg3/cUeSKuvJwIm5NBUpIcpIur7RLT0tZmYKW4ZNDRNuhGhZvxOPwoe1xkLBOh02PGoWO2PrUigYIa83rTrqtjnsZdzqSgujG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SO8NVXT7; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SO8NVXT7"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301d6cbbd5bso10815426a91.3
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 20:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1742959579; x=1743564379; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfIZvsvXpyObm/MeDnvF7J2nbF4JP/x/sNoYgG6zOmE=;
        b=SO8NVXT7ncr3C5TuR2C7jzkxJP7vHmVJyhGY6f1/2IIhCeUd9AUUJpG0GMnmuclYAD
         DS0P25PxPEp/2S4RUgnxmLVB6jNNvANwsS4yjWr9eBPcjeurvYzM6I5geyIWYdtwiIJt
         knv0vCUKdzR9RQdDz8qWPs5PI/+N0SR3Nrej8XoyeylCfC/Fguht4jGulEvCwyNLgEh1
         dv7b+HUsKzgvawO8LSb0W8eKIKy/5XaAJXMnYf2bxpLKpLdV1YxvXzNRB/7YfWQwDe7f
         9GiADS848FBs9cTIbEB/E1dEdvfpV97G7ln5fKA3okOef4KGdmIvaSH/ViMiq1ZKb9nY
         L7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742959579; x=1743564379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfIZvsvXpyObm/MeDnvF7J2nbF4JP/x/sNoYgG6zOmE=;
        b=GdBbhrDmofvCvP58ux7vtPgO4EI5Gnj+DTRJ3BYM0VhdZCG7roXMJbtpOojfDoJxZV
         9J9sJJRTkHIKb0uuUbenazPnnACeGJDkppIMX/CNw6Zfd0wqlsbplpdmzVA3Bya6jFq2
         Wbm1D4uAnQvTheS9EJIYmc5RCe7kMrnjOgQdp1DTpWSB886USEBQ1x2WE0/aHXAldXhV
         mZKF0jphw1tEoT6wY0NKPJzZprrreMnhKC7uKrb6e9PAZ8qWk4oOqLdd6918TnL303KI
         mOlzhq3t4sziBASzbdMgLwyiryis0C0k4+UZ5J30jLd/jovAhGhyBTJMTsJxymErkv7P
         1ifg==
X-Forwarded-Encrypted: i=1; AJvYcCVddUfP5E97KFw+iLB/Hqsei6oMJ1zFgKZ96ACzFRJDuQ9tG9L4jVeVNsBzfmA4jwQtReIsbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxRQKOGud6CRd/TKh6+qbXuejQkBsM710mnm53DcexGfRuI4KZ/
	dX7ABT1CJajMJT6jPACqWM00wjv21PHmQtqcvFAynFQ9YJUud/rPo+8y9msOydMlmoyIgyqpUAe
	D6k7RaVDzSH7Amk4CllrRC3YwPROpVtATEK8aLQ==
X-Gm-Gg: ASbGncv7hObkJ2yQZ1TcUbNqKPUObWZ7eBRcML82oOOT3+f10p9PKWYmwOXXnTXW2gW
	BICee8nLMUVSE3sHjPGMMACt8SHhZA8qvclRl3logrYsGt2xmOvzEpOS+5/0KvZ2zEem7r9mXFS
	U6CEvMYxq3rJuynXNT3Y7cFSFVkG5HZVb89/hGLhY=
X-Google-Smtp-Source: AGHT+IESJp7bMb71tkEwSEqLlTExKVrqQjhhbFW5v0UB8BFvfnFaTdUzEAIGCTPbNRUOBYf4WDIquQovAJzJJAsBfdo=
X-Received: by 2002:a17:90b:540b:b0:2ff:52e1:c49f with SMTP id
 98e67ed59e1d1-3030fef7845mr25635283a91.26.1742959578594; Tue, 25 Mar 2025
 20:26:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250325144252.27403-1-luxu.kernel@bytedance.com> <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
In-Reply-To: <9F043708-3BB6-46CF-BEC3-2636E9A388B7@jrtc27.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Wed, 26 Mar 2025 11:26:07 +0800
X-Gm-Features: AQ5f1Jo0368Hu_uIx_F-VQxmteASeA53lS4ajgOXrFsQ3icn84Q0MxG88EP36ck
Message-ID: <CAPYmKFtAWNz7nCDDD7rjGeV2fRBgy5Kt6KR60pEyXAM=bb7r4g@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] iommu: riscv: Split 8-byte accesses on 32
 bit I/O bus platform
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: tjeznach@rivosinc.com, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, alex@ghiti.fr, lihangjing@bytedance.com, 
	xieyongji@bytedance.com, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

> Is such a platform conformant to the specification?

We have talked about this before [1]. I think the IOMMU spec does not
mandate the implementation of 8-byte access functionality. The related
sentences are listed below:

"The 8-byte IOMMU registers are defined in such a way that software
can perform two individual 4-byte accesses, or hardware can perform
two independent 4-byte transactions resulting from an 8-byte access,
to the high and low halves of the register, in that order, as long as
the register semantics, with regard to side-effects, are respected
between the two software accesses, or two hardware transactions,
respectively."

"Registers that are 64-bit wide may be accessed using either a 32-bit
or a 64-bit access."

> Either way, why is this a static build-time configuration choice rather t=
han a dynamic run-time choice based on the FDT / ACPI tables / some other p=
latform probing method?

I did not find available field in RIMT table to describe it. So maybe
adding a new config is faster.

[1] https://www.uwsg.indiana.edu/hypermail/linux/kernel/2408.3/03968.html

Best Regards,

Xu Lu

On Wed, Mar 26, 2025 at 2:51=E2=80=AFAM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
>
> On 25 Mar 2025, at 14:42, Xu Lu <luxu.kernel@bytedance.com> wrote:
> >
> > Introduce a new configuration CONFIG_RISCV_IOMMU_32BIT to enable
> > splitting 8-byte access into 4-byte transactions for hardware platform
> > whose I/O bus limits access to 4-byte transfers.
> >
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
>
> Is such a platform conformant to the specification? Either way, why is
> this a static build-time configuration choice rather than a dynamic
> run-time choice based on the FDT / ACPI tables / some other platform
> probing method?
>
> Jess
>
> > ---
> > drivers/iommu/riscv/Kconfig |  9 +++++++++
> > drivers/iommu/riscv/iommu.h | 28 +++++++++++++++++++++++-----
> > 2 files changed, 32 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> > index c071816f59a6..b7c9ea22d969 100644
> > --- a/drivers/iommu/riscv/Kconfig
> > +++ b/drivers/iommu/riscv/Kconfig
> > @@ -18,3 +18,12 @@ config RISCV_IOMMU_PCI
> > def_bool y if RISCV_IOMMU && PCI_MSI
> > help
> >  Support for the PCIe implementation of RISC-V IOMMU architecture.
> > +
> > +config RISCV_IOMMU_32BIT
> > + bool "Support 4-Byte Accesses on RISC-V IOMMU Registers"
> > + depends on RISCV_IOMMU
> > + default n
> > + help
> > +  Support hardware platform whose I/O bus limits access to 4-byte
> > +  transfers. When enabled, all accesses to IOMMU registers will be
> > +  split into 4-byte accesses.
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 46df79dd5495..0e3552a8142d 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -14,6 +14,10 @@
> > #include <linux/iommu.h>
> > #include <linux/types.h>
> > #include <linux/iopoll.h>
> > +#ifdef CONFIG_RISCV_IOMMU_32BIT
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#endif
> >
> > #include "iommu-bits.h"
> >
> > @@ -69,21 +73,35 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> > #define riscv_iommu_readl(iommu, addr) \
> > readl_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readq(iommu, addr) \
> > - readq_relaxed((iommu)->reg + (addr))
> > -
> > #define riscv_iommu_writel(iommu, addr, val) \
> > writel_relaxed((val), (iommu)->reg + (addr))
> >
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> > +   delay_us, timeout_us)
> > +
> > +#ifndef CONFIG_RISCV_IOMMU_32BIT
> > +#define riscv_iommu_readq(iommu, addr) \
> > + readq_relaxed((iommu)->reg + (addr))
> > +
> > #define riscv_iommu_writeq(iommu, addr, val) \
> > writeq_relaxed((val), (iommu)->reg + (addr))
> >
> > #define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, tim=
eout_us) \
> > readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, cond, \
> >   delay_us, timeout_us)
> > +#else /* CONFIG_RISCV_IOMMU_32BIT */
> > +#define riscv_iommu_readq(iommu, addr) \
> > + hi_lo_readq_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > - readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, cond, \
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > + ((addr =3D=3D RISCV_IOMMU_REG_IOHPMCYCLES) ? \
> > + lo_hi_writeq_relaxed((val), (iommu)->reg + (addr)) : \
> > + hi_lo_writeq_relaxed((val), (iommu)->reg + (addr)))
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + readx_poll_timeout(hi_lo_readq_relaxed, (iommu)->reg + (addr), val, c=
ond, \
> >   delay_us, timeout_us)
> > +#endif /* CONFIG_RISCV_IOMMU_32BIT */
> >
> > #endif
> > --
> > 2.20.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
