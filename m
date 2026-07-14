Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6762448C8C5
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784040798; cv=none; b=WTmOx4MVyOSudhCoeBqiL9sxi5AqbXSsgOkQBW+NV73HkfJ2bmnSXEoZZU74PjD36eYcOteqwPRPV29GEMVR/6/bqi8U+ZkXf+nB2aFoJNA3qU4uVupchLb6bSTGBY/g4NI0eRm49he7MAY9ii+aUFw9YaltGSSA22ohKAN90WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784040798; c=relaxed/simple;
	bh=Xo3watiwcFJTp0DI7j9qzLePC/4mR79ZkMl/gbtKsKg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szW7ViL8s4ptb2vhjH9dnDf0moLHJ3j2DOfTBl2wmFvly7mMAkbjWm1nKVRJA5AlpiDDGBHzrGNmvBsAR/g2rmIFQJnzjpTOuALo7uc0BGWwZllacK6wmRrT1Bf/f6o/34HQOX6SuCfBDULqdx2WnVHoKiGDg4G2TfBZjz2Djqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggDaMTew; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggDaMTew"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b27c7451so12829995e9.0
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 07:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784040793; x=1784645593; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pbWrlFJpCsAWWpngb8AaY/VxYoSajEZxkhMh3lUDPkg=;
        b=ggDaMTewuVzU8SfrrTjOEdNfOcC6ZeXYIBpBoQuhQq+lB782PZwQKSyEGiB2ho04BP
         QhciFmXeypmhnD7XSpvboxc0qsji/074AL1B52AEhmX8aHIyJkf+luq+6OHCuyR3lcQQ
         gLr6rQ2ssJxHkIUIeLwrus9RYpppm5TAFrveVOSZ9ApZxE8hTUpS5mmQ1eYnLF//ALKs
         5zAk7H8ylFTpCqMXdjb+XEy0tyrwmJKhjpRuMs5noOpXCrTxwRi+CJkMhSlH/jvB7Smy
         jbZBnbNy4a2gV5OKSCRCXdA1ER3ezFxmNKgYUbbXXeRtlcjwFMHIhEXIK+r+iCdZJdur
         bNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784040793; x=1784645593;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pbWrlFJpCsAWWpngb8AaY/VxYoSajEZxkhMh3lUDPkg=;
        b=skpWNhKx1WByOVwfPBzutN+nJVOl/fyRafiY6A6SyAA4qJf7LToKSenHcERxGnnZyN
         EX/Jx/P8cDPz7/glyN2wNHlbC1Y8u95f93JsnuJZOIQub1zVTowLSj8lMFt2gWr1YpXy
         Qyl1qQ8azf4ltPa1O3SaI9uDjdm64f3oO0+HNj0gpWceFxsRqRDyvLS0jAvS/wiCAfAu
         iKcEPFvYbnE4dy/PJFukgtJODs18Z41yiX8xymgRzi0+/QSlmqSaULaMDoYM4e2abj6E
         wnKtBJBEJTZJMelUQid0N0FYHjSxVTbYISpx0qktvEBjTV4dCN1kQ2+mrwtrPiq0zYTa
         z/mw==
X-Forwarded-Encrypted: i=1; AHgh+Rqm0MH0ehpXBDAa8Bq/FguSwv772xsTCq0mSnZ30Tms6/3VxD6Aq+e6xqb1PHJ8aeNQeuIY2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTLpPnerKlJCDsG9GItV7qygEv0ZnBvKClegxdGbAA4pkf2+VR
	SOBP0P/YnksedruiC6aXJnLGezilxzD8QYGBTGG3Lf+InO2RH7q90ObT
X-Gm-Gg: AfdE7ckeBOUg3zl1rMA0FX7bTGah9l1BQZtDXGCo5mJr0+74DRrxy8fsrcN9fRsDvrh
	EbK3gQIVG9mEY3CitI+3Uy1zAoM8q2KV4upAOII+WpW8UNNDcRLdSPCedozaAlhUYGnDH6pB3vP
	yPFzyw4WkTjwmYY0nhEca7GGuGyGUbIJ9R68BU+3h9kMYvk7c3unlCKysfixRXn6HjnvzYVVw+/
	WY3IO/IsXdSOfTj94uH0VbNGsKbf2CMlOV1rrQoWat7M2vKa/+xOjvowuzMjpLtm8IWxv+k6Vvc
	y+/72nVFPB2XC2n3FgqJReXG3hJidjOlC2kbl0MXo+q+dYRKotzaUY/ZYZy3YBJ8RvZwwwV+2R+
	6YpDQp/T5Ws3Ap+ki7my0dMjQIyFsj3Q+PBy9gVpFZTastCVU8mdomqeclWDQwlci6s70VlsCXi
	t3KYDU9mZIv12e57V34EGFF+5/cVh6QOFQxKXYArlq634lYFvJ0jngEt7wfYFE
X-Received: by 2002:a05:600c:8b65:b0:493:f478:4c71 with SMTP id 5b1f17b1804b1-493f8885308mr139772165e9.7.1784040792394;
        Tue, 14 Jul 2026 07:53:12 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508724786sm82851595e9.3.2026.07.14.07.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 07:53:12 -0700 (PDT)
Date: Tue, 14 Jul 2026 15:53:10 +0100
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
Message-ID: <20260714155310.2e17473c@pumpkin>
In-Reply-To: <CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
	<3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com>
	<CAJF2gTSscdfFxtLHMO5Lw_Yax_GHOV6iKyX_xqZ==p7A8=wDAQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 21:24:19 +0800
Guo Ren <guoren@kernel.org> wrote:

> On Tue, Jul 14, 2026 at 8:27=E2=80=AFPM Robin Murphy <robin.murphy@arm.co=
m> wrote:
> >
> > On 13/07/2026 1:29 pm, Zhanpeng Zhang wrote: =20
> > > The RISC-V IOMMU specification [1] permits 64-bit registers to be acc=
essed
> > > using two 32-bit transactions, high half first, and leaves the single=
-copy
> > > atomicity of 8-byte IOMMU register accesses unspecified.
> > >
> > > Use the generic hi_lo_readq_relaxed() and hi_lo_writeq_relaxed() help=
ers
> > > for ordinary 64-bit IOMMU registers. For DDTP, poll BUSY in the low h=
alf,
> > > then read the high half and compose the register value from the polle=
d low
> > > half. HPM counter reads require a rollover-aware sequence and remain
> > > outside these accessors.
> > >
> > > This follows the 32-bit access direction proposed by Guo Ren [2] and =
uses
> > > the generic non-atomic MMIO helpers suggested by David Laight.
> > >
> > > [1] https://docs.riscv.org/reference/iommu/
> > > [2] https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.o=
rg
> > >
> > > Suggested-by: Guo Ren <guoren@kernel.org>
> > > Suggested-by: David Laight <david.laight.linux@gmail.com>
> > > Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
> > > ---
> > > Changes in v3:
> > > - Use the DDTP access sequence from [1]: retain the low half returned=
 by
> > >    BUSY polling, read only the high half, and compose the DDTP value =
from
> > >    those two 32-bit reads.
> > >
> > > Changes in v2:
> > > - Rework the patch based on Guo Ren's earlier proposal [1].
> > > - Drop the build-time option and use 32-bit accesses unconditionally.
> > > - Drop the global lock and use the generic high-low MMIO helpers, as
> > >    suggested by David Laight.
> > > - Poll DDTP.BUSY through its low half.
> > >
> > > Link to v1: [2]
> > > Specification discussion: [3]
> > >
> > > [1]: https://lore.kernel.org/r/20250903144217.837448-1-guoren@kernel.=
org
> > > [2]: https://lore.kernel.org/r/20260615064855.90316-1-zhangzhanpeng.j=
asper@bytedance.com
> > > [3]: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> > >
> > >   drivers/iommu/riscv/iommu.c | 9 ++++++---
> > >   drivers/iommu/riscv/iommu.h | 9 +++------
> > >   2 files changed, 9 insertions(+), 9 deletions(-)
> > >
> > > diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> > > index cec3ddd7ab1..d647b71ebec 100644
> > > --- a/drivers/iommu/riscv/iommu.c
> > > +++ b/drivers/iommu/riscv/iommu.c
> > > @@ -670,9 +670,12 @@ void riscv_iommu_disable(struct riscv_iommu_devi=
ce *iommu)
> > >
> > >   #define riscv_iommu_read_ddtp(iommu) ({ \
> > >       u64 ddtp; \
> > > -     riscv_iommu_readq_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp, \
> > > -                               !(ddtp & RISCV_IOMMU_DDTP_BUSY), 10, \
> > > +     u32 ddtp_lo, ddtp_hi; \
> > > +     riscv_iommu_readl_timeout((iommu), RISCV_IOMMU_REG_DDTP, ddtp_l=
o, \
> > > +                               !(ddtp_lo & RISCV_IOMMU_DDTP_BUSY), 1=
0, \
> > >                                 RISCV_IOMMU_DDTP_TIMEOUT); \
> > > +     ddtp_hi =3D riscv_iommu_readl((iommu), RISCV_IOMMU_REG_DDTP + 4=
); \ =20
> >
> > It looks like whenever you read DDTP you're only really looking at the
> > BUSY/MODE fields anyway, so does this actually need to read the upper
> > bits of PPN at all? (The spec says they don't even need to be written on
> > RV32 either) =20
>=20
> The motivation is not RV32 compatibility. It addresses RV64 platforms
> where the IOMMU control plane can only be accessed via 32-bit MMIO.
>=20
> > =20
> > > +     ddtp =3D ((u64)ddtp_hi << 32) | ddtp_lo; \
> > >       ddtp; })
> > >
> > >   static int riscv_iommu_iodir_alloc(struct riscv_iommu_device *iommu)
> > > @@ -1501,7 +1504,7 @@ static int riscv_iommu_init_check(struct riscv_=
iommu_device *iommu)
> > >        * regular boot flow and disable translation when we boot into =
a kexec
> > >        * kernel and the previous kernel left them enabled.
> > >        */
> > > -     ddtp =3D riscv_iommu_readq(iommu, RISCV_IOMMU_REG_DDTP);
> > > +     ddtp =3D riscv_iommu_read_ddtp(iommu);
> > >       if (ddtp & RISCV_IOMMU_DDTP_BUSY)
> > >               return -EBUSY;
> > >
> > > diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
> > > index 46df79dd549..1b03790fbe1 100644
> > > --- a/drivers/iommu/riscv/iommu.h
> > > +++ b/drivers/iommu/riscv/iommu.h
> > > @@ -11,6 +11,7 @@
> > >   #ifndef _RISCV_IOMMU_H_
> > >   #define _RISCV_IOMMU_H_
> > >
> > > +#include <linux/io-64-nonatomic-hi-lo.h>
> > >   #include <linux/iommu.h>
> > >   #include <linux/types.h>
> > >   #include <linux/iopoll.h>
> > > @@ -70,17 +71,13 @@ void riscv_iommu_disable(struct riscv_iommu_devic=
e *iommu);
> > >       readl_relaxed((iommu)->reg + (addr))
> > >
> > >   #define riscv_iommu_readq(iommu, addr) \
> > > -     readq_relaxed((iommu)->reg + (addr))
> > > +     hi_lo_readq_relaxed((iommu)->reg + (addr)) =20
> >
> > This seems unnecessary (similarly for writeq() below) - once you've
> > included the header, then it automatically provides readq{_relaxed}()
> > for RV32 via the non-atomic implementation, and wherever atomicity
> > doesn't matter, then as written there seems to be no reason for RV64 to
> > stop using the regular arch readq().
> >
> > Not that it makes any difference to me either way, but I don't see any
> > real issue with the spec - if software *may* make a 64-bit access to any
> > 64-bit register unconditionally, then that can only imply that hardware
> > *must* be able to accommodate RV64 software choosing to do so, and
> > therefore must support *both* 32b and 64b accesses in general, except
> > perhaps on RV32-only systems if software could never make 64b accesses
> > in the first place. If 64b single-copy atomicity is not
> > required/specified then it should be valid to achieve that by just
> > sticking a downsizer in the upstream interconnect to split 64b accesses
> > into 32bx2 incremental bursts.
> >
> > If do actually you need this as an erratum workaround to support
> > specific hardware which has misinterpreted the spec then I think you
> > should be clear about that. Otherwise, adding speculative "workarounds"
> > which (slightly) penalise hardware that got it right, while inviting
> > future hardware to get it wrong, doesn't seem like the right way to go
> > at all... =20
>=20
> The only three 64-bit registers the driver ever touches are DDTP,
> CAPABILITIES, and MSI_CFG_TBL_ADDR. None of them is on any
> performance-critical or hot path. Even if native 64-bit MMIO accesses
> were used, there would be no observable performance benefit.
> Therefore, this change does not penalize any hardware.
>=20
> Regarding the specification, there remains substantial disagreement
> over whether 64-bit accesses are mandatory. The relevant sentence uses
> the word =E2=80=9Cmay=E2=80=9D (=E2=80=9Cmay be accessed using either a 3=
2-bit or a 64-bit
> access=E2=80=9D). Per RFC 2119, =E2=80=9Cmay=E2=80=9D does not express a =
requirement. Because
> every existing implementation already provides working 32-bit MMIO
> access, we believe the safer and less controversial choice is to use
> the portable 32-bit path via the generic hi-lo helpers.
>=20

There is also this clause:
	The 8-byte IOMMU registers are defined in such a way that software can
	perform two individual 4-byte accesses, or hardware can perform two
	independent 4-byte transactions resulting from an 8-byte access,
	to the high and low halves of the register, in that order, as long as
	the register semantics, with regard to side-effects, are respected
	between the two software accesses, or two hardware transactions,
	respectively.

I'm not sure what the relevance of the high-low order is.
It could mean, for example, that a read of the high word can latch the low
for the next read - so that you get an atomic 64bit read.
That might be ok if hardware splits the 64bit read, but if software does it
it isn't going to go well unless the driver locks all (and it might be all)
slave accesses.
In the worst case there might be a single latch for all odd word reads.
Writes could be worse!

Hardware can be that broken.
I remember a PCI slave that terminated reads requesting 'cycle rerun'
and then assumed that the following reads would be repeats of the same
read, not reads of a different address by the other cpu.
It didn't do writes properly either, I've forgotten the exact details
but I think a second (third?) write overwrite some latches.

	David

