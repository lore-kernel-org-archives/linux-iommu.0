Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4837E314
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529719; cv=pass; b=Y1o1V6MqLzvXi4+AwWEIFsxyOKf3pba8AT8w2ijnEZ4zk2BVr+Nkxm65AmAp/u3G5qtEZRILzK0TL/VqwRRDos+Ekw6HdFX3vZzoHAsmwR+pBYQ4Dwv2u5e9FJwY+13mrbxLNVzsUT+HmlGKRiPPq1xuvpTGCsbQ3yWP+mOSLQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529719; c=relaxed/simple;
	bh=xSFePTrYn0i0duWqY4Rac1mt5Z8jJM6Bfpkdt8ojZBs=;
	h=References:In-Reply-To:From:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGnAyix9Bl/cX0U45WnJgpy40bttHQBzzATYet134Nig3bGbN0eAIMMM4NOdJIlPo+1FMjxcClT4dDPCCwfhig0NNyC9X0rG6kw4r2Oz0in4hHvLorzyBptOUXoUJ/JtrbKUtxvq0u+qqMm0uyrPt7Zyts6SchNvf+ScCXzvBp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D5WgXR7U; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D5WgXR7U"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so4236225e87.2
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:21:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529714; cv=none;
        d=google.com; s=arc-20240605;
        b=Ty6GqPUyV4YOTfoxkqgRMqbbphHsZ8d5Gd8WSp2DXjreRXDJth48BxUunApu3ArxDf
         Y40TrnYoTTPatnJrUXOpfWtnC8E7T+wb7oAt8Sv7pBmajDxBPNOaKMffsgccTpTXSXjl
         4kartYrbUo6xIy2AlNNMDYrL3DyDDvhOoN7lACMnC/5vVf8HuDeoGVdyPANMuNa8ulBU
         j4FjeG0fIF77CGkvefvqWn2cmdqqpeUL9+qZtObu7cvPZTdY2lFYd7I6IwVp3aMt7rhb
         m+buzf1033nSu6S1HHxqqm8zl3IjFiBFHEbmHeL8RG6Se/Cws6OtUoaVwULFFfZ/xPzg
         tJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:in-reply-to:references:dkim-signature;
        bh=xSFePTrYn0i0duWqY4Rac1mt5Z8jJM6Bfpkdt8ojZBs=;
        fh=hlnPFMWSDVHCQcocgiIgj2Uwz23LXwUHPddny8/bz78=;
        b=hXQJ+9DcrIggf5fUxiYqNqYzHvJLCLMF04DCmGkt7zF5/G8Wi9tTS2CYayqBjBnf+3
         BUn5bAIp/3YvTGpPdADLHSpKlEx6ZHKpH4fLiy4dU67mnJ2WZoA19djlmmjh5ibmefLp
         NCsq2gHyCcS2qv6lXlvvt2rSYOH2ooBcQmgOl0hy9MlBxAl6imuPHCox/iTjrS1pvZQL
         J5ITF4Vbjgp0E8pRmQcyLuGWNSt9eAbq9IUVra04pk0Cv4beqcRXz31FpkgremsQDEKc
         f1nxaURth6zN8vAWzZ0xlWvOZPztTpTnY0+13UNIRX5yanPDVZ8H80+HQFLQUjgMQCDC
         9WmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781529714; x=1782134514; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:in-reply-to:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSFePTrYn0i0duWqY4Rac1mt5Z8jJM6Bfpkdt8ojZBs=;
        b=D5WgXR7Uj7KTrih5ooXNLkNn9AAI1hWLJyUs0gV/Ikwf+3f+Wa4RTMJn6NMWg02qRW
         ajmJ1HGXTZbb1IomSDN+fYH644Ddhtopvomy60HxbJJviUwISk+cPeS508t3YrL3lST6
         2yyxWgFji8WxItg7eh5gCWtSRDfGP0QV8zn/MtFeRy+7iSdBb1tobMTR7JQi3csSf07D
         9WCZsZjVZSOnvzv8b25sU0L0rR6jQK0UKnx1aVNdMcZpmDr+igJ9i0FaNJwKrkYsrRC1
         TpU09/91ccDIs1ruJgXzusdfRu4wtvNEGbf8LCPzfDiOf0xKzZ+3yrwNDDi3Hv6lNWl4
         uKew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529714; x=1782134514;
        h=content-transfer-encoding:cc:to:subject:message-id:date
         :mime-version:from:in-reply-to:references:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSFePTrYn0i0duWqY4Rac1mt5Z8jJM6Bfpkdt8ojZBs=;
        b=liyot7VnNvptrNJOB8owUUmr66m4DMGAeLOZmDyxc1W6OhbOYZa4xZh/tsDGhFTZgh
         GvoP1ZqXwwWhN4NHJ+n2yZZs8S3Nv/T68NaL+ZXQfEs6YERFNW497t59+R3lEOiaxHNn
         00oVmBjvD9BPBPEJkeDc5M6g4JABklSMoqXViZJEXME+PS08dCHCbquDZfBrO3AUz0j4
         fztr6Xe6FXzl22WcaSilKfZnR/REiWxNu2t2P5EA4rY2pYZXIAWeJeG3Rabdsn7JvO1o
         qNOuQZnNYlDhcmcdDSvlYIEOQF5cp6nfSTidrTe6ERRacPEd3/qINSfI+K4+lWQanyBl
         FZ2A==
X-Forwarded-Encrypted: i=1; AFNElJ+d4NqhdvBM4kJk/Zx6rIfcvxvBMSlFisK+tAk/NLYF4+Mi2/Co0eVtPgpo5yRXiE8S6jaR0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS3j5vGOiEGKPVsFZOGPYvBswSj/zrARKA8rD3oL5KO9ypfG+X
	zFA07LkxIhCafoJjnCOVSHX/xI7vZLEJCvYQcysS3OZdICrzMBKy2EvJ6oJqvWsJ3kJWB6RVklG
	fIJzTyvL+1exqP+KbJv68nXDwM4pUUPO1vgcrT+vN2g==
X-Gm-Gg: Acq92OEqoJhDB2kGrS3WYVeIPrig8NVmCO+RVOJHNrQsJu6SLn6hhk0UP/JM77EShR1
	bA692uVmBRSES5uIGdzLd4KFUsv0b5l9b5CNBgmZ51zCQ0q/wIm3j72QkCmbty64pkhtnh+qL0L
	/QghEuWk3+YGBYd1ZnuQq1ROBgai5AeyQZMoHUpeCiKA0KHZ0+JvLlfCA9muyk5jBoqPB/cLczH
	Y8btCsjjQX79KTWktL3LDonf+/acCi49hNF9o0ohZAxFLRpqclh6Zw6D/W6QHWYQXPHe/LqudMz
	Y0lJ+EZg
X-Received: by 2002:ac2:4564:0:b0:5ad:a04:e62a with SMTP id
 2adb3069b0e04-5ad2db7b41bmr2549151e87.33.1781529714093; Mon, 15 Jun 2026
 06:21:54 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 06:21:52 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 06:21:52 -0700
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <20260615105959.136698e8@pumpkin>
In-Reply-To: <20260615105959.136698e8@pumpkin>
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Date: Mon, 15 Jun 2026 06:21:52 -0700
X-Gm-Features: AVVi8CemA-VQ3ru42sjMqAtJHBnInWyFz3gCO42JMupJXaZSETmNLhovgshvRdY
Message-ID: <CACnXVndGA+A1Uu1qZ0=AaEuJGrNQZx6iiuRWgLYAZpirE=UfNQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: David Laight <david.laight.linux@gmail.com>
Cc: tjeznach <tjeznach@rivosinc.com>, joro <joro@8bytes.org>, will <will@kernel.org>, 
	"robin.murphy" <robin.murphy@arm.com>, pjw <pjw@kernel.org>, palmer <palmer@dabbelt.com>, 
	aou <aou@eecs.berkeley.edu>, alex <alex@ghiti.fr>, iommu <iommu@lists.linux.dev>, 
	linux-riscv <linux-riscv@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Xu Lu <luxu.kernel@bytedance.com>, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com, 
	"guoren@kernel.org" <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

Thanks, I agree with your point about the lock and the relaxed accessors.

Guo Ren also pointed me to the earlier discussion on this topic, and I thin=
k the
right next step is to align with that thread rather than continue this sepa=
rate
Kconfig-based patch.

So I will drop this patch.

Thanks,
Zhanpeng

> From: "David Laight"<david.laight.linux@gmail.com>
> Date:=C2=A0 Mon, Jun 15, 2026, 18:00
> Subject:=C2=A0 [External] Re: [PATCH v1] iommu/riscv: Support 32-bit regi=
ster accesses
> To: "Zhanpeng Zhang"<zhangzhanpeng.jasper@bytedance.com>
> Cc: "Tomasz Jeznach"<tjeznach@rivosinc.com>, "Joerg Roedel"<joro@8bytes.o=
rg>, "Will Deacon"<will@kernel.org>, "Robin Murphy"<robin.murphy@arm.com>, =
"Paul Walmsley"<pjw@kernel.org>, "Palmer Dabbelt"<palmer@dabbelt.com>, "Alb=
ert Ou"<aou@eecs.berkeley.edu>, "Alexandre Ghiti"<alex@ghiti.fr>, <iommu@li=
sts.linux.dev>, <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kerne=
l.org>, "Xu Lu"<luxu.kernel@bytedance.com>, <cuiyunhui@bytedance.com>, <yua=
nzhu@bytedance.com>
> On Mon, 15 Jun 2026 14:48:55 +0800
> Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com> wrote:
>
> > Some RISC-V IOMMU implementations cannot perform 64-bit MMIO accesses
> > to the IOMMU register file. The RISC-V IOMMU architecture allows 64-bit
> > registers to be accessed using 32-bit accesses, provided the accesses a=
re
> > properly aligned and do not span multiple registers.
> >
> > Add a config option for such implementations and access 64-bit IOMMU
> > registers as paired 32-bit MMIO operations when it is enabled. Serializ=
e
> > the paired accesses so the high and low halves cannot interleave with
> > another CPU. Full 64-bit register programming writes the high half befo=
re
> > the low half.
> >
> > This option describes the register access width. It is not an RV32 kern=
el
> > mode and does not describe a 32-bit IOMMU architecture.
> >
> > Co-developed-by: Xu Lu <luxu.kernel@bytedance.com>
> > Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > ---
> > This is needed for platforms whose RISC-V IOMMU register window does no=
t
> > support naturally aligned 64-bit MMIO accesses.
> >
> > =C2=A0drivers/iommu/riscv/Kconfig | 11 ++++++++
> > =C2=A0drivers/iommu/riscv/iommu.c | =C2=A04 +++
> > =C2=A0drivers/iommu/riscv/iommu.h | 55 ++++++++++++++++++++++++++++++++=
+----
> > =C2=A03 files changed, 64 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/Kconfig b/drivers/iommu/riscv/Kconfig
> > index b86e5ab94183..54d624b9b2ef 100644
> > --- a/drivers/iommu/riscv/Kconfig
> > +++ b/drivers/iommu/riscv/Kconfig
> > @@ -22,3 +22,14 @@ config RISCV_IOMMU_PCI
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def_bool y if RISCV_IOMMU && PCI_MSI
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Support for the PCIe implement=
ation of RISC-V IOMMU architecture.
> > +
> > +config RISCV_IOMMU_32BIT_ACCESS
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0bool "Use 32-bit accesses for RISC-V IOMMU=
 registers"
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0depends on RISCV_IOMMU
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0help
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Say Y when the RISC-V IOMMU MMIO wi=
ndow cannot be accessed
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0using naturally aligned 64-bit load=
s and stores.
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0When enabled, 64-bit IOMMU register=
s are accessed as paired
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A032-bit MMIO operations. This option=
 does not describe an RV32
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0kernel or a 32-bit IOMMU architectu=
re.
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index a31f50bbad35..7fa1721b5728 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -53,6 +53,10 @@ struct riscv_iommu_devres {
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0void *addr;
> > =C2=A0};
> >
> > +#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> > +DEFINE_RAW_SPINLOCK(riscv_iommu_32bit_access_lock);
> > +#endif
> > +
> > =C2=A0static void riscv_iommu_devres_pages_release(struct device *dev, =
void *res)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct riscv_iommu_devres *devres =3D=
 res;
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 46df79dd5495..ba78ef1858c5 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -14,6 +14,9 @@
> > =C2=A0#include <linux/iommu.h>
> > =C2=A0#include <linux/types.h>
> > =C2=A0#include <linux/iopoll.h>
> > +#ifdef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> > +#include <linux/spinlock.h>
> > +#endif
> >
> > =C2=A0#include "iommu-bits.h"
> >
> > @@ -69,21 +72,61 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> > =C2=A0#define riscv_iommu_readl(iommu, addr) \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readl_relaxed((iommu)->reg + (addr))
> >
> > -#define riscv_iommu_readq(iommu, addr) \
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0readq_relaxed((iommu)->reg + (addr))
> > -
> > =C2=A0#define riscv_iommu_writel(iommu, addr, val) \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writel_relaxed((val), (iommu)->reg + =
(addr))
> >
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0readx_poll_timeout(readl_relaxed, (iommu)-=
>reg + (addr), val, cond, \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 delay_us, timeout_us)
> > +
> > +#ifndef CONFIG_RISCV_IOMMU_32BIT_ACCESS
> > +#define riscv_iommu_readq(iommu, addr) \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0readq_relaxed((iommu)->reg + (addr))
> > +
> > =C2=A0#define riscv_iommu_writeq(iommu, addr, val) \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0writeq_relaxed((val), (iommu)->reg + =
(addr))
> >
> > =C2=A0#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_u=
s, timeout_us) \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0readx_poll_timeout(readq_relaxed, (io=
mmu)->reg + (addr), val, cond, \
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 delay_us, timeout_us)
> > +#else /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
> >
> > -#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0readx_poll_timeout(readl_relaxed, (iommu)-=
>reg + (addr), val, cond, \
> > - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 delay_us, timeout_us)
> > +extern raw_spinlock_t riscv_iommu_32bit_access_lock;
> > +
> > +static inline u64 __riscv_iommu_readq_relaxed(void __iomem *addr)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 lo, hi;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock_irqsave(&riscv_iommu_32bit_a=
ccess_lock, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0do {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0hi =3D readl_r=
elaxed(addr + sizeof(u32));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0lo =3D readl_r=
elaxed(addr);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0} while (hi !=3D readl_relaxed(addr + size=
of(u32)));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock_irqrestore(&riscv_iommu_32=
bit_access_lock, flags);
>
> Why the lock and the loop?
> If you need the loop (for places where the hardware might be changing
> both words?) then there is no need to read 'hi' twice when you loop.
>
> But does it make any sense to be reading the value either while the hardw=
are
> is updating it (does that happen?) or concurrently with a write.
>
>
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0return ((u64)hi << 32) | (u64)lo;
> > +}
> > +
> > +static inline void __riscv_iommu_writeq_relaxed(u64 value, void __iome=
m *addr)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long flags;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_lock_irqsave(&riscv_iommu_32bit_a=
ccess_lock, flags);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0writel_relaxed((u32)(value >> 32), addr + =
sizeof(u32));
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0writel_relaxed((u32)value, addr);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0raw_spin_unlock_irqrestore(&riscv_iommu_32=
bit_access_lock, flags);
>
> What are you actually locking against?
> I'm pretty sure it doesn't make any sense for two cpu to be writing to th=
e
> same entry at the same time.
>
> Can't the writel_relaxed() be re-ordered, so you aren't guaranteeing they=
'll
> be done high-low.
> Same with the reads.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 David
>
> > +}
> > +
> > +#define riscv_iommu_readq(iommu, addr) \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_iommu_readq_relaxed((iommu)->reg +=
 (addr))
> > +
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_iommu_writeq_relaxed((val), (iommu=
)->reg + (addr))
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0readx_poll_timeout(__riscv_iommu_readq_rel=
axed, (iommu)->reg + (addr), \
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 val, cond, delay_us, timeout_us)
> > +#endif /* CONFIG_RISCV_IOMMU_32BIT_ACCESS */
> >
> > =C2=A0#endif
>
