Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848B42BC4E
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784062943; cv=none; b=qWfu+Igvqu62SVTZ2KLWhjbqn1bFaKDkWmM4X+K3ZQL0D3sTItAwLTCmsbEMM7E4tEMWkG0uhOsC/EUX3XGFuuzqQ+AoWMLdmiPyAVma783wlJItFzVKbm6vw0slTeeNE1mKCWwqCREOUYYunfwHB8Q05IvMoIrPWDozD5BOQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784062943; c=relaxed/simple;
	bh=3Kno23UernUyxvsqyFovL/19JIeexLpAXGvyQAz+Pfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hqz1k1excPZkfMcP5ivDPqUaZoEmznke76f5Tj2Sk7Ce+qUqJeMfffClGg4ZRc/GdnJXhWAAjAZaRin7CFq/Q4IDkDGXYyHT+lHhG6azRiG+iK4Rhc8vYy3GI9kGeRyF4XOudnq1O3hgidTiZEQa/tzyV8m8k6Y3jvIkhb6lsfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRHjREHe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRHjREHe"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4728c12ba97so2137260f8f.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784062939; x=1784667739; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rF+I37AHgFT2tFAT9wyxmGe1KHl9HXqH6cXLVyI8Vxo=;
        b=qRHjREHeNY5qlZ85MjdHR97nBTtFrzHTHe8CiXE1hPAKgUHVcxC0qcBuJoS0/QJ9zJ
         Dckg6dQ1H774iCeHTGBnfaq2pj3axVvUMmTqOmAVvhsdMeYc9qvgznE+Vy5VJzmycBuW
         N5EEESuLolTVSdqrMxLhBcp051AW8M6CNzbkr2nxW3MevYWOMIG7wqNYgu1uJ+qtR0A0
         0YN8ric6itVxbhoSV08n2ct/IT6L5rwN7Gv4PaUAO2MEpeIaZOzfO4tHLfrrjkNgGqXC
         LJ1eKd67feAOIiHFmJrrYEi82e0K58Kj2RtNBglP9V/qz2qGhg3tQIQf17LFZT52zVMd
         Xacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784062939; x=1784667739;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rF+I37AHgFT2tFAT9wyxmGe1KHl9HXqH6cXLVyI8Vxo=;
        b=pWAe8v+9dTahRFXcjhLrRpc7azfChPVydhVab9rzIUkrGz55FI17zjCWD3ZhPk5tr+
         IKInCFWwoM/4tvATgJLnYpKsWKHX2sPTIIAQ+crHJ9Z94YGG6eID+SNRiDzbZ7o2TzAR
         nLPaELurdufvnBlrC9qugUBcpvNK1b4UoEL6TAwhiC180Gpcy2AjopyhtcyPvrDZ/tEV
         OwQmNVmiEtkv++5e21q+70TqmvcpmTVTSHD6D+ApPDzVQgS1iwEvH4MlCrSb//gSrm0O
         eeSEi7rzO+X0uiB0q+MYzEwqh7Rjw/fXKne58xfE9lqXSVhi760W1P0MNtmpucY+Cma2
         DK+g==
X-Forwarded-Encrypted: i=1; AHgh+RqTYM7YRTeIPgBmdrIzkYMlREqaeUY0BDJSCof4R4R5uDEvSDgeSzlRfCpHcJ4fYqvpq4Zx6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxkalQJlRg7Gk9oGD8c5Vx41P6Dj4mISh/A/faAr1UnaaS5Ve0m
	sjSaPULkwYin8YFGbcr3aL0cpe9KDkXlm0wPrK4wMqbeYiW5tC9MjF1S
X-Gm-Gg: AfdE7cl04FpkFZgBfT+fs2ejeU2PpJk6vHII0yVquUlVLPrPJdgoJglKr5vmpww7OIY
	YQx8+zVQ2lIf+82I/gA+6ItRc95qfpfwDOfntusSjnV+LPS3fXblvM5h6TrOgfv7ENdFItkZ1Mn
	idNk0LMDB2d/paX0ZCghcsHd4mBxubeQ/Jr9NgY6N2YRrNm5vZJlfU1qLNr9TPcGr1jZLgxKVfM
	QUt0ac7KtKDOmeLnIhd2q4MjH0h5DGjleUF5xNqjp6fcMemBKGPP2SdJitQb2EZ9xAQVVzgWRP/
	zTRsCyePWg/APSmiJB8l/6gWlDvZOANFwagzSS+zExit301Jl/iuqR8o109N5jq9eQ44E98l/cT
	84TLtxAxo1DuBvxm+2pqoQD/CVe+/lPOSCphN581xDplKyXEywVlgeuok7o0S3S4yCZRMGK17sD
	CXzXHpcf7diQN5unrmrEk7LjyFpBkxMXi1c2gy/28SBa2yZaWaAw==
X-Received: by 2002:a5d:6f19:0:b0:47e:96f4:4a5b with SMTP id ffacd0b85a97d-47f4fcef3cfmr20784f8f.51.1784062939220;
        Tue, 14 Jul 2026 14:02:19 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm10622252f8f.37.2026.07.14.14.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:02:18 -0700 (PDT)
Date: Tue, 14 Jul 2026 22:02:17 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guo Ren <guoren@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>, Zhanpeng Zhang
 <zhangzhanpeng.jasper@bytedance.com>, Tomasz Jeznach
 <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Vivian Wang <wangruikang@iscas.ac.cn>, Zong Li
 <zong.li@sifive.com>, cuiyunhui@bytedance.com, yuanzhu@bytedance.com,
 iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit
 registers
Message-ID: <20260714220217.65055d98@pumpkin>
In-Reply-To: <CAJF2gTS2Rw0MYaKMzd0t3ZJ-4ni47wUwLrgkm3pjaxKu7Y1R+A@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
	<3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com>
	<CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
	<20260714155310.2e17473c@pumpkin>
	<CAJF2gTS2Rw0MYaKMzd0t3ZJ-4ni47wUwLrgkm3pjaxKu7Y1R+A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jul 2026 00:53:06 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Tue, Jul 14, 2026 at 10:53=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Tue, 14 Jul 2026 21:24:19 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> > =20
> > > On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Robin Murphy <robin.murphy@ar=
m.com> wrote: =20
> > > >
> > > > On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote: =20
> > > > > The RISC-V IOMMU specification [1] permits 64-bit registers to be=
 accessed
> > > > > using two 32-bit transactions, high half first, and leaves the si=
ngle-copy
> > > > > atomicity of 8-byte IOMMU register accesses unspecified.
> > > > >
> > > > > Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() =
helpers
> > > > > for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the l=
ow half,
> > > > > then read the high half and compose the register value from the p=
olled low
> > > > > half. HPM counter reads require a rollover-aware sequence and rem=
ain
> > > > > outside these accessors.
> > > > >
> > > > > This follows the 32-bit access direction proposed by Guo Ren [2] =
and uses
> > > > > the generic non-atomic MMIO helpers suggested by David Laight.
> > > > >
> > > > > [1] https://docs.riscv.org/reference/iommu/
> > > > > [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kern=
el.org
> > > > >
> > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > > > > ---
> > > > > Changes in v3:
> > > > > - Use the DDTP access sequence from [1]: retain the low half retu=
rned by
> > > > >    BUSY polling, read only the high half, and compose the DDTP va=
lue from
> > > > >    those two 32-bit reads.
> > > > >
> > > > > Changes in v2:
> > > > > - Rework the patch based on Guo Ren's earlier proposal [1].
> > > > > - Drop the build-time option and use 32-bit accesses unconditiona=
lly.
> > > > > - Drop the global lock and use the generic high-low MMIO helpers,=
 as
> > > > >    suggested by David Laight.
> > > > > - Poll DDTP.BUSY through its low half.
> > > > >
> > > > > Link to v1: [2]
> > > > > Specification discussion: [3]
> > > > >
> > > > > [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@ker=
nel.org
> > > > > [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpe=
ng.jasper@bytedance.com
> > > > > [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> > > > >
> > > > >   drivers/iommu/riscv/iommu.c | 9 ++++++---
> > > > >   drivers/iommu/riscv/iommu.h | 9 +++------
> > > > >   2 files changed, 9 insertions(+), 9 deletions(-)
> > > > >
> > > > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/io=
mmu.c
> > > > > index cec3ddd7ab1..d647b71ebec 100644
> > > > > --- a/drivers/iommu/riscv/iommu.c
> > > > > +++ b/drivers/iommu/riscv/iommu.c
> > > > > @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_=
device *iommu)
> > > > >
> > > > >   #define riscv_iommu_read_ddtp(iommu) ({ \
> > > > >       u64 ddtp; \
> > > > > -     riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, dd=
tp, \
> > > > > -                               !(ddtp & RISCV_IOMMU_DDTP_BUSY), =
10, \
> > > > > +     u32 ddtp_lo, ddtp_hi; \
> > > > > +     riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, dd=
tp_lo, \
> > > > > +                               !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY=
), 10, \
> > > > >                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> > > > > +     ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP=
 + 4); \ =20
> > > >
> > > > It looks like whenever you read DDTP you're only really looking at =
the
> > > > BUSY/MODE fields anyway, so does this actually need to read the upp=
er
> > > > bits of PPN at all? (The spec says they don't even need to be writt=
en on
> > > > RV32 either) =20
> > >
> > > The motivation is not RV32 compatibility. It addresses RV64 platforms
> > > where the IOMMU control plane can only be accessed via 32-bit MMIO.
> > > =20
> > > > =20
> > > > > +     ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
> > > > >       ddtp; })
> > > > >
> > > > >   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *i=
ommu)
> > > > > @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct ri=
scv_iommu_device *iommu)
> > > > >        * regular boot flow and disable translation when we boot i=
nto a kexec
> > > > >        * kernel and the previous kernel left them enabled.
> > > > >        */
> > > > > -     ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > > > > +     ddtp =3D riscv_iommu_read_ddtp(iommu);
> > > > >       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > > >               return -EBUSY;
> > > > >
> > > > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/io=
mmu.h
> > > > > index 46df79dd549..1b03790fbe1 100644
> > > > > --- a/drivers/iommu/riscv/iommu.h
> > > > > +++ b/drivers/iommu/riscv/iommu.h
> > > > > @@ -11,6 +11,7 @@
> > > > >   #ifndef _RISCV_IOMMU_H_
> > > > >   #define _RISCV_IOMMU_H_
> > > > >
> > > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > > >   #include <linux/iommu.h>
> > > > >   #include <linux/types.h>
> > > > >   #include <linux/iopoll.h>
> > > > > @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_d=
evice *iommu);
> > > > >       readl_relaxed((iommu)->reg + (addr))
> > > > >
> > > > >   #define riscv_iommu_readq(iommu, addr) \
> > > > > -     readq_relaxed((iommu)->reg + (addr))
> > > > > +     hi_lo_readq_relaxed((iommu)->reg + (addr)) =20
> > > >
> > > > This seems unnecessary (similarly for writeq() below) - once you've
> > > > included the header, then it automatically provides readq{_relaxed}=
()
> > > > for RV32 via the non-atomic implementation, and wherever atomicity
> > > > doesn't matter, then as written there seems to be no reason for RV6=
4 to
> > > > stop using the regular arch readq().
> > > >
> > > > Not that it makes any difference to me either way, but I don't see =
any
> > > > real issue with the spec - if software *may* make a 64-bit access t=
o any
> > > > 64-bit register unconditionally, then that can only imply that hard=
ware
> > > > *must* be able to accommodate RV64 software choosing to do so, and
> > > > therefore must support *both* 32b and 64b accesses in general, exce=
pt
> > > > perhaps on RV32-only systems if software could never make 64b acces=
ses
> > > > in the first place. If 64b single-copy atomicity is not
> > > > required/specified then it should be valid to achieve that by just
> > > > sticking a downsizer in the upstream interconnect to split 64b acce=
sses
> > > > into 32bx2 incremental bursts.
> > > >
> > > > If do actually you need this as an erratum workaround to support
> > > > specific hardware which has misinterpreted the spec then I think you
> > > > should be clear about that. Otherwise, adding speculative "workarou=
nds"
> > > > which (slightly) penalise hardware that got it right, while inviting
> > > > future hardware to get it wrong, doesn't seem like the right way to=
 go
> > > > at all... =20
> > >
> > > The only three 64-bit registers the driver ever touches are DDTP,
> > > CAPABILITIES, and MSI_CFG_TBL_ADDR. None of them is on any
> > > performance-critical or hot path. Even if native 64-bit MMIO accesses
> > > were used, there would be no observable performance benefit.
> > > Therefore, this change does not penalize any hardware.
> > >
> > > Regarding the specification, there remains substantial disagreement
> > > over whether 64-bit accesses are mandatory. The relevant sentence uses
> > > the word =E2=80=9Cmay=E2=80=9D (=E2=80=9Cmay be accessed using either=
 a 32-bit or a 64-bit
> > > access=E2=80=9D). Per RFC 2119, =E2=80=9Cmay=E2=80=9D does not expres=
s a requirement. Because
> > > every existing implementation already provides working 32-bit MMIO
> > > access, we believe the safer and less controversial choice is to use
> > > the portable 32-bit path via the generic hi-lo helpers.
> > > =20
> >
> > There is also this clause:
> >         The 8-byte IOMMU registers are defined in such a way that softw=
are can
> >         perform two individual 4-byte accesses, or hardware can perform=
 two
> >         independent 4-byte transactions resulting from an 8-byte access,
> >         to the high and low halves of the register, in that order, as l=
ong as
> >         the register semantics, with regard to side-effects, are respec=
ted
> >         between the two software accesses, or two hardware transactions,
> >         respectively.
> >
> > I'm not sure what the relevance of the high-low order is.
> > It could mean, for example, that a read of the high word can latch the =
low
> > for the next read - so that you get an atomic 64bit read.
> > That might be ok if hardware splits the 64bit read, but if software doe=
s it
> > it isn't going to go well unless the driver locks all (and it might be =
all)
> > slave accesses.
> > In the worst case there might be a single latch for all odd word reads.
> > Writes could be worse!
> >
> > Hardware can be that broken.
> > I remember a PCI slave that terminated reads requesting 'cycle rerun'
> > and then assumed that the following reads would be repeats of the same
> > read, not reads of a different address by the other cpu.
> > It didn't do writes properly either, I've forgotten the exact details
> > but I think a second (third?) write overwrite some latches. =20
>=20
> This is precisely why the specification leaves the single-copy
> atomicity of an 8-byte IOMMU register access UNSPECIFIED. If a 64-bit
> MMIO register were implemented with atomic semantics, 32-bit accesses
> using lw/sw might require implicit mechanisms, such as latching half
> the register for subsequent accesses. Such mechanisms could lead to
> exactly the kind of interleaving problem you described.

Right, but it also says you must do high-low.
The only reason for that would be to allow hardware that requires
that ordering - which means the software better do both accesses
in that order.
The second half of the sentence seems to let the hardware update
half the register from a 32bit access (as you might expect).

The whole thing is misleading/confusing.
And, reading the full page, the system that doesn't support 64bit
accesses is probably non-conformant as well.

	David


>=20
> This is one reason hardware may favor straightforward, latch-free
> 32-bit MMIO transactions. The example you mentioned further
> illustrates the robustness of treating each 32-bit MMIO access as an
> independent transaction without relying on hidden latch semantics.
>=20
> Using 32-bit MMIO accesses for DDTP, CAPABILITIES, and
> MSI_CFG_TBL_ADDR in this driver introduces no meaningful performance
> overhead and provides broader compatibility without disadvantaging any
> RISC-V IOMMU implementation.
>=20

