Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE185207DF7
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083093; cv=none; b=T5xco7sv2qcQf8eWuPa9xHB8GRtXl8CEEx60gdVZRH3vE4qRNetfH7XGpdlTkv0GDtgQFyZdkpADVN6Tv5P054OagxJaFBrkGPEFI94j+wRZT/q64TyHXcBvIGh0jmQxykD/NGv0r2sxxSW+xav348uxSAiz5WZtsW3Bu5mDbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083093; c=relaxed/simple;
	bh=t7ogfaVTvySxkqGPk0yI0dEbU3do0D4LhOAigElym2Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+jHtGr+px+k4gUL1O+ZBXpcNCPHZ8DPsMZP97w7v/DfEXOad4xIhf7wHT/yW7Hdlvt5m39rcYnaaYZmsD5+kIpFliF/yhxhurTrjpREsFRd2rvvKaPPiVl59CgBjQw/Y+Sop7IV+cnNFQM70eBZ2e83TwnUqUDacsQot56bgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh6FhEeV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh6FhEeV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0A31F00A3E
	for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 02:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083091;
	bh=xCKA1OnIEoqdyGHH2Y9rSaUmi8nm4ceje4cNYAmVNDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jh6FhEeVXotR8rkkq0tyPzeuxA//GwS1fkkqyoxsMBEcaG3z7vuuKdpopZcyp11Cd
	 XNe5j9IybbfarhrRFuSyBgM4lmmj7gpl7zVSVXECpfEPGrZOxl8qrs3qq9up1X/BRB
	 yIz4AEqjwcbeNPW4tCW8JYjzKCm7zodrISgVTZhlvNNQafB2WTkVVfOKNKL1x9NtA6
	 FKierekkHCKy8BW9Gm8bXmpNaCMv3OaUkEtIW82MOgTPcq8YlVTQgXL87u8dYM592l
	 CEvMz1/IGV4M11mEg+PeEBgfzffBJvrxnIA6khLBUeCviQ3ZbWazWPshyDqpM/zUZw
	 R5xi/2FM4Rx1g==
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-47122683cf3so2748992f8f.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 19:38:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp7aTVUp1E8xeyZyhQp9g6wZRwTVMnSx/WbsqnBPjSm0ZUEe0Ow2ckaniTnOaxLo2nLi5xnaw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPKAV7hlOzi02yY7P4J0TUnvznLTk/XdJVFKLkJY5PHPs5GIDQ
	1T1VJapW/dbUTgL/ltTW58hhHRFX3YhSbJZxGGajYWd36/XwPx45DYQ44myFUhS2IQxNNKNw8aG
	C3IcErioIk/aEtTouloFLs0enJ9CL59k=
X-Received: by 2002:a05:6000:2010:b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-47f4634deafmr8780266f8f.27.1784083089906; Tue, 14 Jul 2026
 19:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
 <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com> <CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
 <20260714155310.2e17473c@pumpkin> <CAJF2gTS2Rw0MYaKMzd0t3ZJ-4ni47wUwLrgkm3pjaxKu7Y1R+A@mail.gmail.com>
 <20260714220217.65055d98@pumpkin>
In-Reply-To: <20260714220217.65055d98@pumpkin>
From: Guo Ren <guoren@kernel.org>
Date: Wed, 15 Jul 2026 10:37:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTR3QaNU6z+Q2PtiTvtXZPnQTp7v2C3TfoVom5dZ6AGbhw@mail.gmail.com>
X-Gm-Features: AUfX_mwMCOycib1_b89BSVScmD-El4P2bqJRmYEIHGyhiCFvxdQXcgPE4RD-CTY
Message-ID: <CAJF2gTR3QaNU6z+Q2PtiTvtXZPnQTp7v2C3TfoVom5dZ6AGbhw@mail.gmail.com>
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

On Wed, Jul 15, 2026 at 5:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 15 Jul 2026 00:53:06 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Tue, Jul 14, 2026 at 10:53=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Tue, 14 Jul 2026 21:24:19 +0800
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Robin Murphy <robin.murphy@=
arm.com> wrote:
> > > > >
> > > > > On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote:
> > > > > > The RISC-V IOMMU specification [1] permits 64-bit registers to =
be accessed
> > > > > > using two 32-bit transactions, high half first, and leaves the =
single-copy
> > > > > > atomicity of 8-byte IOMMU register accesses unspecified.
> > > > > >
> > > > > > Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed(=
) helpers
> > > > > > for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the=
 low half,
> > > > > > then read the high half and compose the register value from the=
 polled low
> > > > > > half. HPM counter reads require a rollover-aware sequence and r=
emain
> > > > > > outside these accessors.
> > > > > >
> > > > > > This follows the 32-bit access direction proposed by Guo Ren [2=
] and uses
> > > > > > the generic non-atomic MMIO helpers suggested by David Laight.
> > > > > >
> > > > > > [1] https://docs.riscv.org/reference/iommu/
> > > > > > [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@ke=
rnel.org
> > > > > >
> > > > > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > > > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > > > > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.c=
om>
> > > > > > ---
> > > > > > Changes in v3:
> > > > > > - Use the DDTP access sequence from [1]: retain the low half re=
turned by
> > > > > >    BUSY polling, read only the high half, and compose the DDTP =
value from
> > > > > >    those two 32-bit reads.
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Rework the patch based on Guo Ren's earlier proposal [1].
> > > > > > - Drop the build-time option and use 32-bit accesses unconditio=
nally.
> > > > > > - Drop the global lock and use the generic high-low MMIO helper=
s, as
> > > > > >    suggested by David Laight.
> > > > > > - Poll DDTP.BUSY through its low half.
> > > > > >
> > > > > > Link to v1: [2]
> > > > > > Specification discussion: [3]
> > > > > >
> > > > > > [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@k=
ernel.org
> > > > > > [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhan=
peng.jasper@bytedance.com
> > > > > > [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> > > > > >
> > > > > >   drivers/iommu/riscv/iommu.c | 9 ++++++---
> > > > > >   drivers/iommu/riscv/iommu.h | 9 +++------
> > > > > >   2 files changed, 9 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/=
iommu.c
> > > > > > index cec3ddd7ab1..d647b71ebec 100644
> > > > > > --- a/drivers/iommu/riscv/iommu.c
> > > > > > +++ b/drivers/iommu/riscv/iommu.c
> > > > > > @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iomm=
u_device *iommu)
> > > > > >
> > > > > >   #define riscv_iommu_read_ddtp(iommu) ({ \
> > > > > >       u64 ddtp; \
> > > > > > -     riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, =
ddtp, \
> > > > > > -                               !(ddtp & RISCV_IOMMU_DDTP_BUSY)=
, 10, \
> > > > > > +     u32 ddtp_lo, ddtp_hi; \
> > > > > > +     riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, =
ddtp_lo, \
> > > > > > +                               !(ddtp_lo & RISCV_IOMMU_DDTP_BU=
SY), 10, \
> > > > > >                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> > > > > > +     ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DD=
TP + 4); \
> > > > >
> > > > > It looks like whenever you read DDTP you're only really looking a=
t the
> > > > > BUSY/MODE fields anyway, so does this actually need to read the u=
pper
> > > > > bits of PPN at all? (The spec says they don't even need to be wri=
tten on
> > > > > RV32 either)
> > > >
> > > > The motivation is not RV32 compatibility. It addresses RV64 platfor=
ms
> > > > where the IOMMU control plane can only be accessed via 32-bit MMIO.
> > > >
> > > > >
> > > > > > +     ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
> > > > > >       ddtp; })
> > > > > >
> > > > > >   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device =
*iommu)
> > > > > > @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct =
riscv_iommu_device *iommu)
> > > > > >        * regular boot flow and disable translation when we boot=
 into a kexec
> > > > > >        * kernel and the previous kernel left them enabled.
> > > > > >        */
> > > > > > -     ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > > > > > +     ddtp =3D riscv_iommu_read_ddtp(iommu);
> > > > > >       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > > > > >               return -EBUSY;
> > > > > >
> > > > > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/=
iommu.h
> > > > > > index 46df79dd549..1b03790fbe1 100644
> > > > > > --- a/drivers/iommu/riscv/iommu.h
> > > > > > +++ b/drivers/iommu/riscv/iommu.h
> > > > > > @@ -11,6 +11,7 @@
> > > > > >   #ifndef _RISCV_IOMMU_H_
> > > > > >   #define _RISCV_IOMMU_H_
> > > > > >
> > > > > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > > > > >   #include <linux/iommu.h>
> > > > > >   #include <linux/types.h>
> > > > > >   #include <linux/iopoll.h>
> > > > > > @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu=
_device *iommu);
> > > > > >       readl_relaxed((iommu)->reg + (addr))
> > > > > >
> > > > > >   #define riscv_iommu_readq(iommu, addr) \
> > > > > > -     readq_relaxed((iommu)->reg + (addr))
> > > > > > +     hi_lo_readq_relaxed((iommu)->reg + (addr))
> > > > >
> > > > > This seems unnecessary (similarly for writeq() below) - once you'=
ve
> > > > > included the header, then it automatically provides readq{_relaxe=
d}()
> > > > > for RV32 via the non-atomic implementation, and wherever atomicit=
y
> > > > > doesn't matter, then as written there seems to be no reason for R=
V64 to
> > > > > stop using the regular arch readq().
> > > > >
> > > > > Not that it makes any difference to me either way, but I don't se=
e any
> > > > > real issue with the spec - if software *may* make a 64-bit access=
 to any
> > > > > 64-bit register unconditionally, then that can only imply that ha=
rdware
> > > > > *must* be able to accommodate RV64 software choosing to do so, an=
d
> > > > > therefore must support *both* 32b and 64b accesses in general, ex=
cept
> > > > > perhaps on RV32-only systems if software could never make 64b acc=
esses
> > > > > in the first place. If 64b single-copy atomicity is not
> > > > > required/specified then it should be valid to achieve that by jus=
t
> > > > > sticking a downsizer in the upstream interconnect to split 64b ac=
cesses
> > > > > into 32bx2 incremental bursts.
> > > > >
> > > > > If do actually you need this as an erratum workaround to support
> > > > > specific hardware which has misinterpreted the spec then I think =
you
> > > > > should be clear about that. Otherwise, adding speculative "workar=
ounds"
> > > > > which (slightly) penalise hardware that got it right, while invit=
ing
> > > > > future hardware to get it wrong, doesn't seem like the right way =
to go
> > > > > at all...
> > > >
> > > > The only three 64-bit registers the driver ever touches are DDTP,
> > > > CAPABILITIES, and MSI_CFG_TBL_ADDR. None of them is on any
> > > > performance-critical or hot path. Even if native 64-bit MMIO access=
es
> > > > were used, there would be no observable performance benefit.
> > > > Therefore, this change does not penalize any hardware.
> > > >
> > > > Regarding the specification, there remains substantial disagreement
> > > > over whether 64-bit accesses are mandatory. The relevant sentence u=
ses
> > > > the word =E2=80=9Cmay=E2=80=9D (=E2=80=9Cmay be accessed using eith=
er a 32-bit or a 64-bit
> > > > access=E2=80=9D). Per RFC 2119, =E2=80=9Cmay=E2=80=9D does not expr=
ess a requirement. Because
> > > > every existing implementation already provides working 32-bit MMIO
> > > > access, we believe the safer and less controversial choice is to us=
e
> > > > the portable 32-bit path via the generic hi-lo helpers.
> > > >
> > >
> > > There is also this clause:
> > >         The 8-byte IOMMU registers are defined in such a way that sof=
tware can
> > >         perform two individual 4-byte accesses, or hardware can perfo=
rm two
> > >         independent 4-byte transactions resulting from an 8-byte acce=
ss,
> > >         to the high and low halves of the register, in that order, as=
 long as
> > >         the register semantics, with regard to side-effects, are resp=
ected
> > >         between the two software accesses, or two hardware transactio=
ns,
> > >         respectively.
> > >
> > > I'm not sure what the relevance of the high-low order is.
> > > It could mean, for example, that a read of the high word can latch th=
e low
> > > for the next read - so that you get an atomic 64bit read.
> > > That might be ok if hardware splits the 64bit read, but if software d=
oes it
> > > it isn't going to go well unless the driver locks all (and it might b=
e all)
> > > slave accesses.
> > > In the worst case there might be a single latch for all odd word read=
s.
> > > Writes could be worse!
> > >
> > > Hardware can be that broken.
> > > I remember a PCI slave that terminated reads requesting 'cycle rerun'
> > > and then assumed that the following reads would be repeats of the sam=
e
> > > read, not reads of a different address by the other cpu.
> > > It didn't do writes properly either, I've forgotten the exact details
> > > but I think a second (third?) write overwrite some latches.
> >
> > This is precisely why the specification leaves the single-copy
> > atomicity of an 8-byte IOMMU register access UNSPECIFIED. If a 64-bit
> > MMIO register were implemented with atomic semantics, 32-bit accesses
> > using lw/sw might require implicit mechanisms, such as latching half
> > the register for subsequent accesses. Such mechanisms could lead to
> > exactly the kind of interleaving problem you described.
>
> Right, but it also says you must do high-low.
> The only reason for that would be to allow hardware that requires
> that ordering - which means the software better do both accesses
> in that order.
> The second half of the sentence seems to let the hardware update
> half the register from a 32bit access (as you might expect).

The RV IOMMU specification does not restrict the order of software
accesses, and high-to-low ordering is for hardware 64-bit MMIO
accesses; the spec does not mention any latch requirement. Therefore,
we cannot assert that this ordering exists to support latching =E2=80=94 th=
is
remains speculation. Although I consider the speculation plausible, it
cannot be regarded as a mandatory requirement imposed by the
specification on hardware; these are two separate matters.

The specification is ambiguous about the atomicity of 64-bit MMIO
access and explicitly states that such atomicity is UNSPECIFIC. This
ambiguity likely arises from the hardware latching behavior associated
with atomicity (as you mentioned). Consequently, leaving it as
UNSPECIFIC does not encourage hardware implementations to provide
atomic 64-bit MMIO access. If 64-bit MMIO access does not guarantee
atomicity, then what advantage does it actually offer?


>
> The whole thing is misleading/confusing.
> And, reading the full page, the system that doesn't support 64bit
> accesses is probably non-conformant as well.
>

According to RFC 2119, the term =E2=80=9Cmay=E2=80=9D carries no mandatory =
force. It
is incorrect to interpret normative language in the specification
through everyday intuition rather than its formal meaning. The
specification does not explicitly require that RV64 software "must"
perform 64-bit MMIO accesses to 64-bit registers. In the absence of
such a direct requirement, no obligation can be inferred.

Since the IOMMU is a bus-attached device that must remain accessible
to RV32 systems, mandating 64-bit accesses for RV32 would be
self-contradictory.
A clear logical consequence follows directly from the specification:
Because the RISC-V IOMMU explicitly supports RV32 software, a pure
32-bit MMIO access model is valid and must be accommodated.

--=20
Best Regards
 Guo Ren
