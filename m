Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE247AF5D
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037337; cv=none; b=bxnLvJI3hUGuPZLWkjjbw4OIkasPyNEuDgSUItBMHys3L83P33U7YmQ6ar4fM87QxcWulAzlrP5iVeQGm3TP6RgS42nEInD9X0PH/bM++hS+VfO+lPWj9sBtM8z43NII1t3u8hHOSFC5D7CXAf3YkQd2BpYaKwXGksHsWDdne5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037337; c=relaxed/simple;
	bh=XDABGg54JY9c5uqgS9D6pfXfs2755GdNh/jkgiPt/KE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ur3xPeTrqb/Pvtr+rDuRR/1RJgti7AW29jIrqTSZ947+uBumKKfAwZMSvANVoE3K9D/km99O0RL0GsUM216e8DicnO0ZrHhiIVNK4ivMkEDKp345WKLfuVZQY+R0GJxmMPmaRoSjP43nFtJAbX4vtBdsZvGSXTNBOAjUWLvD2xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Av5CS1Mm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Av5CS1Mm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865531F01559
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784037334;
	bh=GrtPi17fWb7l6qnwhn70BMM+c4yaLt5ZNiQNuUJJ6XY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Av5CS1MmS21TxmA6tkYmv+ESHj6KPV/GLWUGYYNk9PyXIwm6GOI31l2M+HScRG8JY
	 MiV4c48tAKrudB3tWTenRlZKC349/GMejecaqadoqyo3MeNVhyCfRnfCdb4Jtddk3u
	 tYWS6bX0Bz/zD8Mu+S+ztTSA11xhP55jjR7Xfczozmog4aSv/AsVkx+Gl2k0anEGUv
	 hc01DcbyR8I0fHgO8fSiS2UBjpElPmCDxOLtB9f+qRO7myq5P7aDNdyt/YH0nMPEdO
	 HUlw8/1qTrzuaW6+jFXVgmGh0i+QwiiO66Vl9ge2xcfqVqA6M9NQ5QawcCUEK7H6Xs
	 bpIEt39ZgbF4A==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f3e6cc44aso2013996f8f.3
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:55:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqRCBSpRF1WHECmxDE5tisxOQ6LxG5PozSPdaekgCvnGVqg6QFncvXGgSDfdW5Ufc+hDIKLFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzR3OmOwzAHsPzPTa9uGvIQVq0Zg8S6x7PzoHR4bUJGCVWFq0do
	DpIwUQoQivbCERPGXCSeRDS1KVOvg30KQcChZXhvn0f4WF9NLAeZWNgZ1VlxjGPYYy+fi6aCE0Y
	aWFlCHKDQYq1bSQMHCOKtvdndSBELQec=
X-Received: by 2002:a5d:5f87:0:b0:47d:f445:9490 with SMTP id
 ffacd0b85a97d-47f488c6b08mr2844267f8f.60.1784037333037; Tue, 14 Jul 2026
 06:55:33 -0700 (PDT)
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
Date: Tue, 14 Jul 2026 21:55:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
X-Gm-Features: AUfX_mxaEJedzwJhtabOBLnboi2nGcv0Lw_TrI6r1-U99azbqLRyWD0GnM_9bhU
Message-ID: <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
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

You cannot exclude RV32 from the discussion. The spec statement in question=
 is:
"Registers that are 64-bit wide may be accessed using either a 32-bit
or a 64-bit access."

This sentence applies to all implementations, including RV32 systems.
On a pure RV32 system (or when running RV32 software), 64-bit accesses
are impossible by definition. Therefore, if the spec were interpreted
as making 64-bit access mandatory, the statement itself would become
self-contradictory on RV32 =E2=80=94 which is clearly not the intent.

The specification is deliberately precise. It uses "may", not "shall"
or "must". We should not introduce speculative implications that break
the spec's consistency on RV32. The safe and portable interpretation
is that software is explicitly allowed to use 32-bit accesses for
these registers on any system, which is exactly what this patch does.

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
>
> Thanks,
> Robin.
>
> >
> >   #define riscv_iommu_writel(iommu, addr, val) \
> >       writel_relaxed((val), (iommu)->reg + (addr))
> >
> >   #define riscv_iommu_writeq(iommu, addr, val) \
> > -     writeq_relaxed((val), (iommu)->reg + (addr))
> > -
> > -#define riscv_iommu_readq_timeout(iommu, addr, val, cond, delay_us, ti=
meout_us) \
> > -     readx_poll_timeout(readq_relaxed, (iommu)->reg + (addr), val, con=
d, \
> > -                        delay_us, timeout_us)
> > +     hi_lo_writeq_relaxed((val), (iommu)->reg + (addr))
> >
> >   #define riscv_iommu_readl_timeout(iommu, addr, val, cond, delay_us, t=
imeout_us) \
> >       readx_poll_timeout(readl_relaxed, (iommu)->reg + (addr), val, con=
d, \
>


--=20
Best Regards
 Guo Ren
