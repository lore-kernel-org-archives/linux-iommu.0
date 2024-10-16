Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B2118C347
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729061201; cv=none; b=SZK2bn0DuHkRBnKuTGzUnKC2jPCCLWjhrUZZWADq+wylytMWKN9WiYmYIkg22T3o0YUt9WGYNOQt0iON7ZIO4MET0lVhwUcH0JYDlEFisr9uT7BsI3/WzPQGelMmD1lLXp/472xks/r9VdRJTtvQmCkYUZoe9tqSTlAH6NnMkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729061201; c=relaxed/simple;
	bh=PXSEBqhU5Gd07/QuG/Zc6PGX+IDY/LoLery1Q1MNLMY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/anw5qiIC2WXdt5xSMJ1e1t6c31Aq+qbR+b1r+vQTKrBWVA77HK2jjA0rYxAC9cXtImTJQRLFt7QbAGFU5E3a5ywodTakBI7qo17SaKnnPhigepAASfsnCfWKhn8WbwrONlBlDR13T0f2A8vOZwTNYwWstKQwoPZRrCz8qBp3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=09+OTJl+; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="09+OTJl+"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a3bd42955bso16110305ab.1
        for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 23:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1729061199; x=1729665999; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+UWG+iQDx7/sDsMqknKCoFlNlO/iTQrpby5lYUUqTw=;
        b=09+OTJl+HISQGZ7fxyyzXIYqcaBz150x/hBEtZNLc4PaQgjDqgxGClKo9/6TYl9DlU
         tx07noxwJ0+J6hdFgTEAN1jl1PSYr0kiPqpBwDmrFfc9FnZJxbWmiP0ts4xbbIm0dBZk
         aiOBiGqfiei9RWjvMpyVNkIi/uWCqNey2u+0AVZ01OUZNP2y1aPEpETqKy2BfVJLiZRO
         2H4h7HivzHlI5M/lvSt6Et35OANhxh17waf+bEHXA0OQVPVZ061IE+fAbhpcIpShVFdW
         afh0EXV8amvpcfwK8UONwJPfskA2MBWM3670000KuBaHAzbzGdkyoo0t0ZYvhfUT3QX0
         /fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729061199; x=1729665999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F+UWG+iQDx7/sDsMqknKCoFlNlO/iTQrpby5lYUUqTw=;
        b=az1mk3mAiAraC6AHEXu+vk1B/OZ/rsJbcfdTSvZRaZmSdx6Q7qj35qKtx0Xlx/nZxb
         3/GVJSck2iCQAS61mi1HkJbevUAjcvSCzpZ0rXX1R71we4FEMoZehRiCUN+KX0R4BKUN
         Wi+/iHuTYmmOMV3hPzl4hpUmwZqktIYM9lDZ1HLY6aF7Gujxbsr3sqyFkYagFBVZV3o/
         y2aFc2gn7LJ3f3EIMuF+L5rjYKpyoT2yVU9HHXDDuG1yiP9r9OHy7F2hogkax9ODmyup
         FuiENjghdwM3JUTX/mdxqTSBLWXzemouOOsbdtUmnOd+xyKoU5tVs7MEGVc0mqzY9Zwp
         A1/g==
X-Forwarded-Encrypted: i=1; AJvYcCVmNqSK3QglkXO1sKn8lnnJYi2ICYi1CnL2MtyNsBvwTyqj4dGhaSXpeJTD4968x+aQQllR5g==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywo4tCBBmf+o4h2sli1Yzn8x9NyxoIfahwINkPguFw7upHDV0ei
	R5ilY/9J2DKZBYyGZXqjSDNQ4Kzb1esBxrFQ+BOMyhOCBwA0XejmQy9EEPHCS1wavfG+NaxMHoo
	nTYON8PpTBVTwgAlM5X4SHnkMv9/dhWXI0+JuhQ==
X-Google-Smtp-Source: AGHT+IG0i/JYD0IC1+8ATNDbsKwtcxr+LgejQV1B7YdOhS4ht6Ui8pkwiop1o21oFn6m9FR3zioopWhLOktOCqkpAjM=
X-Received: by 2002:a05:6e02:194d:b0:3a0:480c:6ac4 with SMTP id
 e9e14a558f8ab-3a3b5fc413cmr160135915ab.22.1729061198896; Tue, 15 Oct 2024
 23:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1728579958.git.tjeznach@rivosinc.com> <b8da2b00aec3f7b4b2e3a7cc194f7961bf656f24.1728579958.git.tjeznach@rivosinc.com>
 <20241015085044.GA19110@willie-the-truck>
In-Reply-To: <20241015085044.GA19110@willie-the-truck>
From: Tomasz Jeznach <tjeznach@rivosinc.com>
Date: Tue, 15 Oct 2024 23:46:28 -0700
Message-ID: <CAH2o1u75x3YQ7amKU4WEQVMZ5h9-PTAXnyoWLw6rQsVG2C=Qcw@mail.gmail.com>
Subject: Re: [PATCH v9 2/7] iommu/riscv: Add RISC-V IOMMU platform device driver
To: Will Deacon <will@kernel.org>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Anup Patel <apatel@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Nick Kossifidis <mick@ics.forth.gr>, 
	Sebastien Boeuf <seb@rivosinc.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux@rivosinc.com, 
	Lu Baolu <baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 1:50=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> On Thu, Oct 10, 2024 at 12:48:05PM -0700, Tomasz Jeznach wrote:
> > Introduce platform device driver for implementation of RISC-V IOMMU
> > architected hardware.
> >
> > Hardware interface definition located in file iommu-bits.h is based on
> > ratified RISC-V IOMMU Architecture Specification version 1.0.0.
> >
> > This patch implements platform device initialization, early check and
> > configuration of the IOMMU interfaces and enables global pass-through
> > address translation mode (iommu_mode =3D=3D BARE), without registering
> > hardware instance in the IOMMU subsystem.
> >
> > Link: https://github.com/riscv-non-isa/riscv-iommu
> > Co-developed-by: Nick Kossifidis <mick@ics.forth.gr>
> > Signed-off-by: Nick Kossifidis <mick@ics.forth.gr>
> > Co-developed-by: Sebastien Boeuf <seb@rivosinc.com>
> > Signed-off-by: Sebastien Boeuf <seb@rivosinc.com>
> > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> > ---
>
> [...]
>
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > new file mode 100644
> > index 000000000000..700e33dc2446
> > --- /dev/null
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright =C2=A9 2022-2024 Rivos Inc.
> > + * Copyright =C2=A9 2023 FORTH-ICS/CARV
> > + *
> > + * Authors
> > + *   Tomasz Jeznach <tjeznach@rivosinc.com>
> > + *   Nick Kossifidis <mick@ics.forth.gr>
> > + */
> > +
> > +#ifndef _RISCV_IOMMU_H_
> > +#define _RISCV_IOMMU_H_
> > +
> > +#include <linux/iommu.h>
> > +#include <linux/types.h>
> > +#include <linux/iopoll.h>
> > +
> > +#include "iommu-bits.h"
> > +
> > +struct riscv_iommu_device {
> > +     /* iommu core interface */
> > +     struct iommu_device iommu;
> > +
> > +     /* iommu hardware */
> > +     struct device *dev;
> > +
> > +     /* hardware control register space */
> > +     void __iomem *reg;
> > +
> > +     /* supported and enabled hardware capabilities */
> > +     u64 caps;
> > +     u32 fctl;
> > +
> > +     /* available interrupt numbers, MSI or WSI */
> > +     unsigned int irqs[RISCV_IOMMU_INTR_COUNT];
> > +     unsigned int irqs_count;
> > +};
> > +
> > +int riscv_iommu_init(struct riscv_iommu_device *iommu);
> > +void riscv_iommu_remove(struct riscv_iommu_device *iommu);
> > +
> > +#define riscv_iommu_readl(iommu, addr) \
> > +     readl_relaxed((iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_readq(iommu, addr) \
> > +     readq_relaxed((iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_writel(iommu, addr, val) \
> > +     writel_relaxed((val), (iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_writeq(iommu, addr, val) \
> > +     writeq_relaxed((val), (iommu)->reg + (addr))
> > +
> > +#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +                        delay_us, timeout_us)
> > +
> > +#define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > +     readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > +                        delay_us, timeout_us)
> > +
> > +#endif
>
> Curious: why do you need these MMIO wrappers if the driver depends on
> 64BIT?
>

Hello Will,

These wrappers were initially created to support 32-bit CPU
architectures but were later discontinued to concentrate on practical
driver use cases. It has been observed that some RISC-V IOMMU hardware
implementations might only allow 32-bit MMIO access, even on 64-bit
systems. The wrappers are left in place to accommodate these potential
designs if they arise. I'd leave them for now and reevaluate their
necessity in a few months.

Thanks,
- Tomasz

> Will
