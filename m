Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FE03112C1
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784035474; cv=none; b=gaeD7MucdxByoolwYWqKlWvi1mdifsPQu0NmgKEwThOQ8cUUJIcH1WJECUT+66cd7oQqs/NNEMoAlqcVMc3T3bDvI42wa3ar0sXiUU0WxLprCcM/EOqTO8MtGd7JnrxU1gVhpViBQG5PY9UdMCEXj3tKcuk7Lr11FbnHcvcgMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784035474; c=relaxed/simple;
	bh=MfxLyEQCwq8uoeiYyt+lHKfDFl6e5IXIYDVkpqPie6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bj3NnrPk0RaAaH2zrLpKtxtNuhNdNHd+mA/DGoGDjHPPIdMRVWAbqpmg/7o8jfixCrjltgoaOMq13LEuSdLZ/LH1KQfnJSbeqMWI4o+m3JR8DyIovusgnR/x7nN8hyyiSF00OBrP987Z5P97FJMfUKO4ZD/N5ObWcyhAXec/+fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYKmYGM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYKmYGM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3340E1F00ACF
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784035473;
	bh=2AIC5RMcPvMx+e9S377T3+e/eCB/7vrbMH1BkQIbGRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CYKmYGM6r5S8kRLS7xE3by99Cig6iyn932mr7c2hpSH9cIRGmK4pIXSOFmwVvuH8Z
	 305ccNwkSX7ZXGLK+K1fTxDln7oX+0Fr6oyIcgQ2deqJB4iD5ZC4neLBas6mP3Y210
	 LpgNZZgYQn357QkGLl8pHgGH77chcLuBsMHY01qun0MrIvaVoOokqvyHhYVLuar5Qe
	 e+POkY18jSH/nJLYjkGRPfEGXmWZlIxpmVN2fQp/P3Q6sqi1UnN07euBjTcCisk3Nl
	 9ns/X9MQf/k2KXhVJ8fDDiL7B9+A0yAqOShu0q++OXo10HlxHQcO9866LUarMSeAcV
	 z6YUsWg7b9yPA==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c733f15aso39387045e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:24:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr7weeWQcjkh6daBBN4bbCP74yxSmIViKig8dvv1v379HrpwcJqK9Ng8RlWsatVV9X94s6FtQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqysAMaj72fxhfw7yjHC1lbNwF58CGDMTh/+R/+SWDaJJBa38L
	DqpbjaK68F0RMpYc1tLciBqZsb5GZKHiX1IWIdt3CdXKOkPJVGfgLwscTG+v4mZtTCbfjOQIoxt
	EY3HMiQ3qtWSFvC2aT5UGQLT9xmWUG7s=
X-Received: by 2002:a05:600d:9:b0:493:e97d:97e3 with SMTP id
 5b1f17b1804b1-49538a246cfmr22655705e9.39.1784035471605; Tue, 14 Jul 2026
 06:24:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com> <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com>
In-Reply-To: <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 14 Jul 2026 21:24:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
X-Gm-Features: AUfX_mxAo2PlClbs1-u3Okii0GfqYOVbvnvZ9lLcnkpYniOOh_7yWQ9GGVgTzoA
Message-ID: <CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Robin Murphy <robin.murphy@arm.com>
Cc: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Zong Li <zong.li@sifive.com>, cuiyunhui@bytedance.com, yuanzhu@bytedance.com, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote:
> > The RISC-V IOMMU specification [1] permits 64-bit registers to be acces=
sed
> > using two 32-bit transactions, high half first, and leaves the single-c=
opy
> > atomicity of 8-byte IOMMU register accesses unspecified.
> >
> > Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() helper=
s
> > for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low hal=
f,
> > then read the high half and compose the register value from the polled =
low
> > half. HPM counter reads require a rollover-aware sequence and remain
> > outside these accessors.
> >
> > This follows the 32-bit access direction proposed by Guo Ren [2] and us=
es
> > the generic non-atomic MMIO helpers suggested by David Laight.
> >
> > [1] https://docs.riscv.org/reference/iommu/
> > [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.org
> >
> > Suggested-by: Guo Ren <guoren@kernel.org>
> > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > ---
> > Changes in v3:
> > - Use the DDTP access sequence from [1]: retain the low half returned b=
y
> >    BUSY polling, read only the high half, and compose the DDTP value fr=
om
> >    those two 32-bit reads.
> >
> > Changes in v2:
> > - Rework the patch based on Guo Ren's earlier proposal [1].
> > - Drop the build-time option and use 32-bit accesses unconditionally.
> > - Drop the global lock and use the generic high-low MMIO helpers, as
> >    suggested by David Laight.
> > - Poll DDTP.BUSY through its low half.
> >
> > Link to v1: [2]
> > Specification discussion: [3]
> >
> > [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.or=
g
> > [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.jas=
per@bytedance.com
> > [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> >
> >   drivers/iommu/riscv/iommu.c | 9 ++++++---
> >   drivers/iommu/riscv/iommu.h | 9 +++------
> >   2 files changed, 9 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > index cec3ddd7ab1..d647b71ebec 100644
> > --- a/drivers/iommu/riscv/iommu.c
> > +++ b/drivers/iommu/riscv/iommu.c
> > @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_device=
 *iommu)
> >
> >   #define riscv_iommu_read_ddtp(iommu) ({ \
> >       u64 ddtp; \
> > -     riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> > -                               !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> > +     u32 ddtp_lo, ddtp_hi; \
> > +     riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_lo,=
 \
> > +                               !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 10,=
 \
> >                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> > +     ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4);=
 \
>
> It looks like whenever you read DDTP you're only really looking at the
> BUSY/MODE fields anyway, so does this actually need to read the upper
> bits of PPN at all? (The spec says they don't even need to be written on
> RV32 either)

The motivation is not RV32 compatibility. It addresses RV64 platforms
where the IOMMU control plane can only be accessed via 32-bit MMIO.

>
> > +     ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
> >       ddtp; })
> >
> >   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
> > @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_io=
mmu_device *iommu)
> >        * regular boot flow and disable translation when we boot into a =
kexec
> >        * kernel and the previous kernel left them enabled.
> >        */
> > -     ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > +     ddtp =3D riscv_iommu_read_ddtp(iommu);
> >       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> >               return -EBUSY;
> >
> > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > index 46df79dd549..1b03790fbe1 100644
> > --- a/drivers/iommu/riscv/iommu.h
> > +++ b/drivers/iommu/riscv/iommu.h
> > @@ -11,6 +11,7 @@
> >   #ifndef _RISCV_IOMMU_H_
> >   #define _RISCV_IOMMU_H_
> >
> > +#include <linux/io-64-nonatomic-hi-lo.h>
> >   #include <linux/iommu.h>
> >   #include <linux/types.h>
> >   #include <linux/iopoll.h>
> > @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_device =
*iommu);
> >       readl_relaxed((iommu)->reg + (addr))
> >
> >   #define riscv_iommu_readq(iommu, addr) \
> > -     readq_relaxed((iommu)->reg + (addr))
> > +     hi_lo_readq_relaxed((iommu)->reg + (addr))
>
> This seems unnecessary (similarly for writeq() below) - once you've
> included the header, then it automatically provides readq{_relaxed}()
> for RV32 via the non-atomic implementation, and wherever atomicity
> doesn't matter, then as written there seems to be no reason for RV64 to
> stop using the regular arch readq().
>
> Not that it makes any difference to me either way, but I don't see any
> real issue with the spec - if software *may* make a 64-bit access to any
> 64-bit register unconditionally, then that can only imply that hardware
> *must* be able to accommodate RV64 software choosing to do so, and
> therefore must support *both* 32b and 64b accesses in general, except
> perhaps on RV32-only systems if software could never make 64b accesses
> in the first place. If 64b single-copy atomicity is not
> required/specified then it should be valid to achieve that by just
> sticking a downsizer in the upstream interconnect to split 64b accesses
> into 32bx2 incremental bursts.
>
> If do actually you need this as an erratum workaround to support
> specific hardware which has misinterpreted the spec then I think you
> should be clear about that. Otherwise, adding speculative "workarounds"
> which (slightly) penalise hardware that got it right, while inviting
> future hardware to get it wrong, doesn't seem like the right way to go
> at all...

The only three 64-bit registers the driver ever touches are DDTP,
CAPABILITIES, and MSI_CFG_TBL_ADDR. None of them is on any
performance-critical or hot path. Even if native 64-bit MMIO accesses
were used, there would be no observable performance benefit.
Therefore, this change does not penalize any hardware.

Regarding the specification, there remains substantial disagreement
over whether 64-bit accesses are mandatory. The relevant sentence uses
the word =E2=80=9Cmay=E2=80=9D (=E2=80=9Cmay be accessed using either a 32-=
bit or a 64-bit
access=E2=80=9D). Per RFC 2119, =E2=80=9Cmay=E2=80=9D does not express a re=
quirement. Because
every existing implementation already provides working 32-bit MMIO
access, we believe the safer and less controversial choice is to use
the portable 32-bit path via the generic hi-lo helpers.

--=20
Best Regards
 Guo Ren
