Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35A74DB546
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 16:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784048003; cv=none; b=qtQEAFDnAd5b6LCCa5S7M8qs5JMudoxKMHfKyKOG91oN9d3zKLD+3EkTNRUmKCk1REGEoQ2xjXE3CVLzEtLcyXWygWv4KgYYA5ra6FWdTm3/rKqILrxtUjXsRVs3WOOwuJfqr4+zxw/ILnXVWPuV5LLS6Xzm8rdE9crzFbycX1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784048003; c=relaxed/simple;
	bh=Li0kszrpNQX4EtdpsU/K4+asOP+3UJIkPXwD9+u1XX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oft2TK+Yway+zuTigDTs6xRGgNgfWZFxF/cw9C5N9vqySrh4idE/f4TBpXwPxOGZep/PQ9UZo24Mw9fZcT0HmCcKRJGCqCPvT1lpZNEa3NJKJc8Iqep7ofGmwiogu7KygwvneAl1hO01uGAUIp/mWQwdzMWR2KqpJ+GalqfBr0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1r3uY+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1r3uY+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747DC1F00AC4
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 16:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784048001;
	bh=0VzhcQ3TbNcRXUGeYBueFZFv24RV1o/OXjdezi1v6tQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E1r3uY+x+WGH6+VjJnl1AH6Mj+sWlH1aOQPD8gTXX56nmK5h1DAY79kRgMZPKSkph
	 mAlARgqUdXxCNg7hbt/r1xN/TnzHiY/t0ql9yBvc1Y7fj03rxbivvR+Zc0mbRoeUpE
	 OphxUNuHoMlsTs+ATHs/sfYomKKAMLCka5kCs/R9oRioPYqiKMG/fZ51nbKS5Gw4V3
	 8u0o4LWA2lRR5fnkc8LlFo+a+j6ropkJ98gc1tXjqbNbVxhJ3VBekVjiKa3VzbcekO
	 F7+dQSh4KAMpQNJdH69PY6RNGpTJTU+sgywChLif7diH8TZ4BYJP8ODo4QAwi9CAsw
	 fa0h/eadwyjpg==
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso2520610f8f.1
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 09:53:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpLlGByUdqAIfBOb4RUNEhkEQhgFW/ISAwTULf6MhoUyVeDYhsgOvFw65hi7AiLltw301fyWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJylCsv3netlCou7l+oSzUKYrbI3pXp3nL9IoCL/cRW+O+wlEH
	WEpp1gajMg5uvbgj+WWlHBXSi4FznoYB2hkWujDReIwFMjz/XYxBqgZxYBnsGpVRhDhltmSSiQv
	QsGZ5hK/dMYgiHYZ+kT7kLUg8SpmEdkA=
X-Received: by 2002:a5d:6f02:0:b0:47f:4c5a:dc76 with SMTP id
 ffacd0b85a97d-47f4c5adc92mr2158778f8f.56.1784048000025; Tue, 14 Jul 2026
 09:53:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
 <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com> <CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
 <20260714155310.2e17473c@pumpkin>
In-Reply-To: <20260714155310.2e17473c@pumpkin>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Jul 2026 00:53:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS2Rw0MYaKMzd0t3ZJ-4ni47wUwLrgkm3pjaxKu7Y1R+A@mail.gmail.com>
X-Gm-Features: AUfX_mxUG4JDOr_aCDQ6KxqLKnoL2Q3SIMy_T89bCZi2fahn_0CYpA5etLAVIss
Message-ID: <CAJF2gTS2Rw0MYaKMzd0t3ZJ-4ni47wUwLrgkm3pjaxKu7Y1R+A@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: David Laight <david.laight.linux@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, 
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, Zong Li <zong.li@sifive.com>, cuiyunhui@bytedance.com, 
	yuanzhu@bytedance.com, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 10:53=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Tue, 14 Jul 2026 21:24:19 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Robin Murphy <robin.murphy@arm.=
com> wrote:
> > >
> > > On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote:
> > > > The RISC-V IOMMU specification [1] permits 64-bit registers to be a=
ccessed
> > > > using two 32-bit transactions, high half first, and leaves the sing=
le-copy
> > > > atomicity of 8-byte IOMMU register accesses unspecified.
> > > >
> > > > Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() he=
lpers
> > > > for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low=
 half,
> > > > then read the high half and compose the register value from the pol=
led low
> > > > half. HPM counter reads require a rollover-aware sequence and remai=
n
> > > > outside these accessors.
> > > >
> > > > This follows the 32-bit access direction proposed by Guo Ren [2] an=
d uses
> > > > the generic non-atomic MMIO helpers suggested by David Laight.
> > > >
> > > > [1] https://docs.riscv.org/reference/iommu/
> > > > [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel=
.org
> > > >
> > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > > > ---
> > > > Changes in v3:
> > > > - Use the DDTP access sequence from [1]: retain the low half return=
ed by
> > > >    BUSY polling, read only the high half, and compose the DDTP valu=
e from
> > > >    those two 32-bit reads.
> > > >
> > > > Changes in v2:
> > > > - Rework the patch based on Guo Ren's earlier proposal [1].
> > > > - Drop the build-time option and use 32-bit accesses unconditionall=
y.
> > > > - Drop the global lock and use the generic high-low MMIO helpers, a=
s
> > > >    suggested by David Laight.
> > > > - Poll DDTP.BUSY through its low half.
> > > >
> > > > Link to v1: [2]
> > > > Specification discussion: [3]
> > > >
> > > > [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kerne=
l.org
> > > > [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng=
.jasper@bytedance.com
> > > > [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> > > >
> > > >   drivers/iommu/riscv/iommu.c | 9 ++++++---
> > > >   drivers/iommu/riscv/iommu.h | 9 +++------
> > > >   2 files changed, 9 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iomm=
u.c
> > > > index cec3ddd7ab1..d647b71ebec 100644
> > > > --- a/drivers/iommu/riscv/iommu.c
> > > > +++ b/drivers/iommu/riscv/iommu.c
> > > > @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_de=
vice *iommu)
> > > >
> > > >   #define riscv_iommu_read_ddtp(iommu) ({ \
> > > >       u64 ddtp; \
> > > > -     riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp=
, \
> > > > -                               !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10=
, \
> > > > +     u32 ddtp_lo, ddtp_hi; \
> > > > +     riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp=
_lo, \
> > > > +                               !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY),=
 10, \
> > > >                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> > > > +     ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP +=
 4); \
> > >
> > > It looks like whenever you read DDTP you're only really looking at th=
e
> > > BUSY/MODE fields anyway, so does this actually need to read the upper
> > > bits of PPN at all? (The spec says they don't even need to be written=
 on
> > > RV32 either)
> >
> > The motivation is not RV32 compatibility. It addresses RV64 platforms
> > where the IOMMU control plane can only be accessed via 32-bit MMIO.
> >
> > >
> > > > +     ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
> > > >       ddtp; })
> > > >
> > > >   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iom=
mu)
> > > > @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct risc=
v_iommu_device *iommu)
> > > >        * regular boot flow and disable translation when we boot int=
o a kexec
> > > >        * kernel and the previous kernel left them enabled.
> > > >        */
> > > > -     ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > > > +     ddtp =3D riscv_iommu_read_ddtp(iommu);
> > > >       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > >               return -EBUSY;
> > > >
> > > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iomm=
u.h
> > > > index 46df79dd549..1b03790fbe1 100644
> > > > --- a/drivers/iommu/riscv/iommu.h
> > > > +++ b/drivers/iommu/riscv/iommu.h
> > > > @@ -11,6 +11,7 @@
> > > >   #ifndef _RISCV_IOMMU_H_
> > > >   #define _RISCV_IOMMU_H_
> > > >
> > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > >   #include <linux/iommu.h>
> > > >   #include <linux/types.h>
> > > >   #include <linux/iopoll.h>
> > > > @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_dev=
ice *iommu);
> > > >       readl_relaxed((iommu)->reg + (addr))
> > > >
> > > >   #define riscv_iommu_readq(iommu, addr) \
> > > > -     readq_relaxed((iommu)->reg + (addr))
> > > > +     hi_lo_readq_relaxed((iommu)->reg + (addr))
> > >
> > > This seems unnecessary (similarly for writeq() below) - once you've
> > > included the header, then it automatically provides readq{_relaxed}()
> > > for RV32 via the non-atomic implementation, and wherever atomicity
> > > doesn't matter, then as written there seems to be no reason for RV64 =
to
> > > stop using the regular arch readq().
> > >
> > > Not that it makes any difference to me either way, but I don't see an=
y
> > > real issue with the spec - if software *may* make a 64-bit access to =
any
> > > 64-bit register unconditionally, then that can only imply that hardwa=
re
> > > *must* be able to accommodate RV64 software choosing to do so, and
> > > therefore must support *both* 32b and 64b accesses in general, except
> > > perhaps on RV32-only systems if software could never make 64b accesse=
s
> > > in the first place. If 64b single-copy atomicity is not
> > > required/specified then it should be valid to achieve that by just
> > > sticking a downsizer in the upstream interconnect to split 64b access=
es
> > > into 32bx2 incremental bursts.
> > >
> > > If do actually you need this as an erratum workaround to support
> > > specific hardware which has misinterpreted the spec then I think you
> > > should be clear about that. Otherwise, adding speculative "workaround=
s"
> > > which (slightly) penalise hardware that got it right, while inviting
> > > future hardware to get it wrong, doesn't seem like the right way to g=
o
> > > at all...
> >
> > The only three 64-bit registers the driver ever touches are DDTP,
> > CAPABILITIES, and MSI_CFG_TBL_ADDR. None of them is on any
> > performance-critical or hot path. Even if native 64-bit MMIO accesses
> > were used, there would be no observable performance benefit.
> > Therefore, this change does not penalize any hardware.
> >
> > Regarding the specification, there remains substantial disagreement
> > over whether 64-bit accesses are mandatory. The relevant sentence uses
> > the word =E2=80=9Cmay=E2=80=9D (=E2=80=9Cmay be accessed using either a=
 32-bit or a 64-bit
> > access=E2=80=9D). Per RFC 2119, =E2=80=9Cmay=E2=80=9D does not express =
a requirement. Because
> > every existing implementation already provides working 32-bit MMIO
> > access, we believe the safer and less controversial choice is to use
> > the portable 32-bit path via the generic hi-lo helpers.
> >
>
> There is also this clause:
>         The 8-byte IOMMU registers are defined in such a way that softwar=
e can
>         perform two individual 4-byte accesses, or hardware can perform t=
wo
>         independent 4-byte transactions resulting from an 8-byte access,
>         to the high and low halves of the register, in that order, as lon=
g as
>         the register semantics, with regard to side-effects, are respecte=
d
>         between the two software accesses, or two hardware transactions,
>         respectively.
>
> I'm not sure what the relevance of the high-low order is.
> It could mean, for example, that a read of the high word can latch the lo=
w
> for the next read - so that you get an atomic 64bit read.
> That might be ok if hardware splits the 64bit read, but if software does =
it
> it isn't going to go well unless the driver locks all (and it might be al=
l)
> slave accesses.
> In the worst case there might be a single latch for all odd word reads.
> Writes could be worse!
>
> Hardware can be that broken.
> I remember a PCI slave that terminated reads requesting 'cycle rerun'
> and then assumed that the following reads would be repeats of the same
> read, not reads of a different address by the other cpu.
> It didn't do writes properly either, I've forgotten the exact details
> but I think a second (third?) write overwrite some latches.

This is precisely why the specification leaves the single-copy
atomicity of an 8-byte IOMMU register access UNSPECIFIED. If a 64-bit
MMIO register were implemented with atomic semantics, 32-bit accesses
using lw/sw might require implicit mechanisms, such as latching half
the register for subsequent accesses. Such mechanisms could lead to
exactly the kind of interleaving problem you described.

This is one reason hardware may favor straightforward, latch-free
32-bit MMIO transactions. The example you mentioned further
illustrates the robustness of treating each 32-bit MMIO access as an
independent transaction without relying on hidden latch semantics.

Using 32-bit MMIO accesses for DDTP, CAPABILITIES, and
MSI_CFG_TBL_ADDR in this driver introduces no meaningful performance
overhead and provides broader compatibility without disadvantaging any
RISC-V IOMMU implementation.

--=20
Best Regards
 Guo Ren
