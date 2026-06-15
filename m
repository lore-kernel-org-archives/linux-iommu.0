Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40523AB46F
	for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 13:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781529793; cv=pass; b=NMku4elB6UyNMUuluipkw+W0IA69RbUb4XVEVs0c4mU6fK02DM8KgaPjCiDPhdiHvDt0jnwSUFmMEVD4kyxhU6q4ITH0x6LdnpkswtWTANpRCvoXMolfGCRDJeqFmQ7jYHrp/9NiYcMD7yqj1DCtdXcbvM1lhIbTo1WxeBLGIDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781529793; c=relaxed/simple;
	bh=RracDr99YGEkyuEzsb2CCcrm9Kwzatx7RzWk7uryVJU=;
	h=From:In-Reply-To:Mime-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GmrIWSvRRWME3BJiUzGwiDbpFyMb8pDzSfETae9sUWpoLYMlrjNgatgG2GLZDf9gEmJ/E+pRYLBdRbi5DCmyxGaG8D61108m8gACXkw2HSJznIn+UWXSE2sLtWPbJ46GzAKYwDQ47DbewQRz/VEWBBCxgu1lNayh0kuKe195gpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SsONvAmK; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SsONvAmK"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ad0abf1f7bso2529736e87.3
        for <iommu@lists.linux.dev>; Mon, 15 Jun 2026 06:23:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781529790; cv=none;
        d=google.com; s=arc-20240605;
        b=coxMk+kBRTAeQmNejOntRj0NCfmTNtNrW5/CMpElejg0HI2pVDaP89ZdCkg23zvCO7
         +bEO8IOmNBxxd1H9TvYKdTZN9cCGZ4bHnDmKIRL0M2gXwk4vW/uE+9aOUJqZQTWHMdab
         Q8rx0zZCwIsO9Rpiyp5AKsZ2gEw/W4zI91FjI1dXZuixwW1KKDNNi3Re3G4vrIJMTvCj
         KL9+R+GiCbeUEepT8ifsUnQ/bEt4Dh0+aSOvHe8bVOBmK968ly8DMagOg5OfLeIqhOw/
         Duh1RQUMW1ky/NoQmNjo0IYMz6P9FVW0wW+eFVj9wW3K+9ldaIm301eYzb7JlAx2FjQS
         3p0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:dkim-signature;
        bh=RracDr99YGEkyuEzsb2CCcrm9Kwzatx7RzWk7uryVJU=;
        fh=mJv0ig/pVpvjTRLhCjnkwQoxiPiZnJmCeDy0J1vxR8E=;
        b=ag7caKamksBURNpVqYFGFtUdVUZhCk+rU1nSB7dKSRp5HlTDMsbfSb6pjLuoh6AkMm
         r7RZ09lBkmkUccDsODiD+t6YUsYH2udQeyPH3mxwA0654bRVGwlvLdjjZG/17OTMHZ38
         D21GdNxbs1bw+o9PDvTGJ3qsqa8CSrEii3Po8A+j05T6tQLht4THFgNv7d219oDlQLn2
         FYM8hKtBBsmSFfE5GrOrhlEp6WmNZE8O30nGVdXpCK7+AZjlfyShLoyGrOZwF67uzPTS
         ar+sWGNCLXjQ+oFkJvq1oHORTTv2G3QJ74DM4KZlWgrw6MiKd0kpeQoxS3o+lVg/peg+
         dp5w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781529790; x=1782134590; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RracDr99YGEkyuEzsb2CCcrm9Kwzatx7RzWk7uryVJU=;
        b=SsONvAmKL0Wy6/5zwQmU451eT3qynybovWXZVCNaheedyIG5Bia+pTxqvBaQD4hTUx
         WHKXdEJJBaCquMYFTAYhh/pUkrKDZwRB12DYQdAuGpVbMU70LRH5xXyZVVgxnvRTyd3F
         xr2M/4xB/VqlplRsuGS75zLs5in2vvp2+vyv4EBImjPPK5ZKN1pK25bfQO0YJPdMCset
         LvZoKDAsDEj51HCUh9jtvaXoxgj9D4rVQmNwHFZjBlp0EqICZbteshft3B0fQ9ZkqAQR
         WO5gKG0mPWLGQETxKg1kPX6MFG5y/vNdt4KMr8C+rlptOw23KGXrWvs+QagpKTN8R7Af
         R6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781529790; x=1782134590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RracDr99YGEkyuEzsb2CCcrm9Kwzatx7RzWk7uryVJU=;
        b=cWtWg+WkAgwPvUSDCFOiluuB1ngeXuPchLKi9OHTaq15s/xRWBJk4c5BdGlk3ypN57
         0lmT7LemQfZQwzN5jftrawSF4PLBZZd2a6oq38dVZBPJNe2ZQq1q0FTGTFIGQNTuLGWj
         xtZ4H7U0JbdFt5Kbt5jBwJnSx9xRk2TlUQio+h55ipK14ui5pdYkeZ4fACwbpsYYNQvB
         Z03419wDpzL43aIdtOLBYPJ/n0qFQKq4aY9ND8t9SMHRNK7QYAtJKJJZY06vb5UG4CRQ
         Au4IDFLMJ2h02u/3I+CB4ZXrlh03kWf0MfQeZoY8ad1rUIC/eZvNWQpF6AyGbKIFQhrU
         Ycig==
X-Forwarded-Encrypted: i=1; AFNElJ/zbYa2nvEPvjuMMUTbseKBOToAgOcLFNc+2yapnr6YtGpS3cvy+wl4SJT4yM1sufDUy12D/A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUIINwp8u5/DCnMBagI58rP/V91kmXHjq9AwL5v3vh7tNxJhz8
	Nv/f1fvXxODv9ki5CTPn2snBhaVEjQ+LX+kBehx9VDmTIC/FwB6NpolH2iqBIEZQ0T/vgjSvI41
	j0LtA67pK8orDAfS+dR93FJ8MZyDRlXLlyDMsqAUygQ==
X-Gm-Gg: Acq92OF4FyaJcXM3kJBmgFxbVfv+AtY3GY3okcwmPF/s2UoL4tlVzst0zx5hGNp8MYG
	DTrLlW5+qZ8fnQyG9jOKfahBbhhYAJ2DhgiAaAJPVm1fwBqkbo8TRVfX87hEs/xpTvy06Kd2+tl
	p4casZwPKRSYZwE8NVmpBXvH+CvAZCwshBoBSG5pYXabs01JOl3spOM0e/0ZqFEv1ly+r07hoyu
	V7gVrWUBlJA04snt7txpxSK8oFXuOMF/sYm758DXFZcnZxo3DZkpqGipFI7hkHcYXaUdu+sfuPB
	zAwo78s=
X-Received: by 2002:a05:6512:230e:b0:5ad:3035:b350 with SMTP id
 2adb3069b0e04-5ad3035b3eamr3410309e87.50.1781529789846; Mon, 15 Jun 2026
 06:23:09 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 06:23:08 -0700
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 15 Jun 2026 06:23:07 -0700
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20260615123821.373248-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com> <20260615123821.373248-1-guoren@kernel.org>
Date: Mon, 15 Jun 2026 06:23:07 -0700
X-Gm-Features: AVVi8CcvQzFdtR3DKRmDScb4fYB6iqDRAptHcEOI7gqPhYIkL0fqhV5X8bnObgw
Message-ID: <CACnXVnd-DsP2XGrnDFjuZmm4NOpZ0Hd+5BLpoCsDTTtmuFZHMg@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, 
	iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com, 
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guo Ren,

Thanks for the pointer, and sorry that I missed the earlier discussion.

I agree with your concerns. The lock in my v1 is not the right approach, an=
d
David also pointed out the same issue. More importantly, after reading your
comments, I agree that this should not be handled as a separate Kconfig-sel=
ected
path.

If the RISC-V IOMMU specification allows 64-bit registers to be accessed wi=
th
32-bit MMIO operations, then a generic kernel should be able to support tha=
t
without requiring a platform-specific build-time option. So I will drop my =
v1
and will not continue this separate patch.

I will take a closer look at your earlier proposal and the previous discuss=
ion.
If the preferred direction is to make 32-bit register accesses part of the
driver's common register access model, I am happy to help test, review, or
rework patches in that direction.

Best Regards,
Zhanpeng

> From: "Guo Ren"<guoren@kernel.org>
> Date:=C2=A0 Mon, Jun 15, 2026, 20:38
> Subject:=C2=A0 [External] Re: [PATCH v1] iommu/riscv: Support 32-bit regi=
ster accesses
> To: <zhangzhanpeng.jasper@bytedance.com>
> Cc: <alex@ghiti.fr>, <aou@eecs.berkeley.edu>, <cuiyunhui@bytedance.com>, =
<iommu@lists.linux.dev>, <joro@8bytes.org>, <linux-kernel@vger.kernel.org>,=
 <linux-riscv@lists.infradead.org>, <luxu.kernel@bytedance.com>, <palmer@da=
bbelt.com>, <pjw@kernel.org>, <robin.murphy@arm.com>, <tjeznach@rivosinc.co=
m>, <will@kernel.org>, <yuanzhu@bytedance.com>
> Hi Zhanpeng Zhang,
>
> I noticed you posted a similar fix recently. However, I had already
> submitted a similar solution back in September 2025 [1]. It would be
> great if you could review it. A few concerns with the current patch:
>
> 1. Using spin_lock_irqsave in such a small semantic structure is
> unnecessary. IRQ protection should be provided by the higher-level
> IOMMU driver interfaces. Many existing call sites already handle IRQ
> disabling, so adding it here feels redundant and adds avoidable
> overhead.
>
> 2. More critically, the RISCV_IOMMU_32BIT_ACCESS Kconfig option is
> problematic. According to the RISC-V IOMMU specification (Software
> Guidelines, =E2=80=9CReading and writing IOMMU registers=E2=80=9D):
>
> > Registers that are 64-bit wide may be accessed using either a 32-bit
> > or a 64-bit access.
>
> This clearly requires that any hardware supporting 64-bit MMIO access
> must also support 32-bit MMIO access. Therefore, the IOMMU driver should
> be built on a 32-bit access base for maximum hardware compatibility.
>
> 3. Only performance-monitoring counters require 64-bit IO access or the
> high-low-high do-while retry strategy. For ordinary status and control
> MMIO registers, a single read is sufficient.
>
> 4. Introducing a compile-time Kconfig that forces 32-bit splitting (or
> 64-bit access) across the entire driver is unnecessary for the vast
> majority of registers and would prevent a single kernel Image (or .ko)
> from working across all compliant platforms.
>
> I believe the correct approach is to keep the driver on a 32-bit access
> foundation (as required by the spec) and apply special 64-bit or
> high-low-high handling only to performance-monitoring counters when
> justified by data. This preserves broad hardware support without
> unnecessary complexity.
>
> What do you think? I=E2=80=99m happy to discuss or collaborate on a clean=
er
> solution based on the earlier patch [1].
>
> [1]: https://lore.kernel.org/linux-riscv/20250903144217.837448-1-guoren@k=
ernel.org/
>
> Best Regards
> =C2=A0 GUO Ren
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
> > --
> > 2.50.1 (Apple Git-155)
>
