Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2753E28727D
	for <iommu@lists.linux.dev>; Sun,  7 Jun 2026 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780866139; cv=pass; b=WPzAqoM2q1zsWir/H90RL/WgCA1J/qRsoF+lY5FGMSwXxQWmfaRMVHYM9gtIpgURlB6JRV5yoQAIrYgGpHnnPE/irZPqfkN5POghvx0tAhvwkgCoxAvYhTPFcy1TSAxcRyiC5i7cloCAkmpzaQKgJCrYv6wEZTmQEJPwhpgSugg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780866139; c=relaxed/simple;
	bh=+8UdWvNZOrMkx3IvycG3o83qj4YVhpznC6XOZkbSFus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a7KoatYiXcaUek2g8k/t05WSXntKf/gFQGi+UnOFI9VW6Xqy4DReBCAXUOjGZd2EmzveeFIVJzpK5xtu5i4rSZWe6J0IX8KUPSMOoJ64uLlMOrgrv8j5LTSAapLAYmBuP1ur7FSX7dBJIT3t0IJqry2LgBmMjyALXZlKKCvwm/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qBufIAjA; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBufIAjA"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68e5f7c1131so6854884a12.2
        for <iommu@lists.linux.dev>; Sun, 07 Jun 2026 14:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780866137; cv=none;
        d=google.com; s=arc-20240605;
        b=fyTXTaD1XZow1gJGF0aKd2ySPnz+c6VHGMxxQ324uoQ22ZUN+jezZcxfaTtH2I9qlk
         0Q0ot3ifnubEx8JbSHRLQSdib/Hjd7omvCcrqNuLRejBkaj5tMA4Ulh//unE34YKOjcu
         +bYU5RwJ5nPaWB+ghIfxBPLGKdD6VpsW+Tvnpio5G/fQOL8brT0qaL6+lRDu3Sp+EyBf
         PVKtkzxDIbUMbzjAoRcqODpzSMba8ASBBy4rMRwPv1/TBIn9vPaloked1CLtGnZTGGTv
         20EEpCSNEJ4Hz02NOo2esBCptvOyVuv8czWtDyzPnoFNveKmgPSoAavSSb1+jf9WX0CE
         Wvjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
        fh=uQO+x/pfVs29nap3u8BrtwGObUK/h65bQlMd7p52WbE=;
        b=d4Ng/GFA4nt8uA8dmQFxsQI9PLo/CpahjlYQk2JbvmCCmh2pc8dhQahC00B6rHVpy6
         c5tnWveYlQeUubCBRGS/ogTOTT5EzhvmGCWbIEcGZuWfPQcKtDspMEk5otdlkHAthn4m
         ewr0boPWtctQesVmK6kUB/lFLzMu2M+q/iTGVl9havcspYFF8hxnG98VNdijfWAzHKnc
         jQeol16CmVm0KR5/oDhtCT7BbUJ0CpfzmjVaQgmHLgwc/9bnUxFuF6kjbWL9+qTrpjHD
         QOMndT5sQQEBtZgCWzgMymzEzxGjhKu6H3G+WuletqTrvqrz3bW7Yxx8W6DXr01e0x+v
         y4tQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780866137; x=1781470937; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
        b=qBufIAjAIh/bP5CMVwEAZoR2JNWWKGvKhKnqGtWSBgdc2kdDXCteg9wy/DNlczfOP7
         87fesCNvKKB5AinBhL/Z6qkVNV4PAXqtpRUWzPhw/wBh4wyiMNIOlEBpOb3S8paZXlUk
         hUS3w1g3+vK0EEmD4fRP6hfDapRfUQIgG5/e7rpajlhm8oCBE3pvndtDvBvI3H1N5a1M
         tOr76HP61+bT4iADEyYzDt7lVdqSnicuL/eWjRRfmGUXsFApEsvDdJwNU5xNc8bz6q93
         qAiypzbH97F5hjMghp2KjelUvYORZKuPMx7ydlhz/yQuppcqNoFJp4CyRBQwFNklfg1D
         UFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780866137; x=1781470937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+9fNpCsE6s4qptEKDyb1NK+xycGWP9ueu0opDX1ZcA=;
        b=gqiDh/LkYU+ufrzPbLDBEJWOqEy9vodN5DpBc7S3sNDYj6KH26sdtX6ApeEkKV8DpU
         A3OXmJ2g5KaYScG+/F8jX/o23JoiSgQGcabrduQEa3cpoVvRooFtHvbChw/U3qQKcOQ2
         AEm+f0Za1I4IF97q4aegmiL/g1brgI/VnVeYcf2C8JXmYllkaNSrzMGJNwyCrCHK/R67
         FhGhGrEfcAqbvNIEPtsK+Z9bQ6CiqOFTHQwlAaWCdUiwjmklSzgHNf5kW35awsim/7l5
         i9OD2Qf8QMK1Ecd0A8d2UgP1TGb7DO375foxU0bd9GoJh3KLevHmnCCYol+l7QvXz/Kw
         bfAA==
X-Forwarded-Encrypted: i=1; AFNElJ+lHr6eZcZN9Eg1IKYgaGI/U4ALmSkoX32UAjtk6/lLP7l7dCyBgUA73305aun45kK3BvbUKw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywk5XrAY2IuU4Vq0V7iDDCWEjF3atRE3tN/5wABv5MnpclH3YqT
	T8VOsA9fTQXrazDeg8ecmH7iF6l99yhGGbGncHQOy01aaIsLixJRCNJXz14BWKL7wo4Jhub9loO
	X4BHBVoj+ML8MFWc1hSBZBKmdQYJohAU=
X-Gm-Gg: Acq92OHkcizkzUVrjUTIlWQbreuuq1XA3v8Gx09FZk5jHrA53ntHbuXJKqihnpdWCpF
	/lDvb5stzdn4erfVNV4KkLMQ5L61FlZaELnQyB77lOoVfF6JSzpTIn+coWYCigemykvjJoIVb1Y
	U7u39Tzau1mKMjO5uwbMw1jhZBvgRpE8kADD3F8BHY7jJTYuXoYG0eQKMFli9H0Ao53EWdiuaW3
	FTHLvLZtT9ecvggewi0WKhH73fZBlOa8jx7N4MTRcYVZvWBaVv9VtVfW+qzwvUAGpSKa56LaAfM
	jJRH3kRBYwz1V9mt8eY1L1cifvj14uAGGlw0n9Rn3UG0j7qzSsM=
X-Received: by 2002:a17:907:2718:b0:bea:f4e0:c7b9 with SMTP id
 a640c23a62f3a-bf370d638ccmr437637066b.19.1780866136465; Sun, 07 Jun 2026
 14:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604135255.62682-1-midgy971@gmail.com> <20260604135255.62682-7-midgy971@gmail.com>
 <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
In-Reply-To: <e44b506e-e9d2-48e3-acea-ab28b7be9b37@rock-chips.com>
From: Midgy Balon <midgy971@gmail.com>
Date: Sun, 7 Jun 2026 23:05:03 +0200
X-Gm-Features: AVVi8Cf-JVkWYJtDYXL1xfOVyosnpbnb7w4PJV4kFFggOhSQTxoQOwyJz0V_ZFQ
Message-ID: <CA+GS1Y16++cztPxdUGLrPA73ENm4vJGFrjm-jP8r=8OQqcMJGA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 6/9] iommu/rockchip: Clear AUTO_GATING bit 1 on the
 RK356x v1 IOMMU
To: Chaoyi Chen <chaoyi.chen@rock-chips.com>
Cc: Simon Xue <xxm@rock-chips.com>, tomeu@tomeuvizoso.net, ogabbay@kernel.org, 
	heiko@sntech.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chaoyi,

> As I said, it is v2. Could you please try using the code below instead an=
d
> see if it works?
> [ auto_gate =3D read(RK_MMU_AUTO_GATING); auto_gate |=3D BIT(31); write(.=
..) ]

Thanks -- that's clearly the right shape (read-modify-write, before paging =
is
enabled, keeping the reset value instead of my clobbering 0x2).

I rebuilt v7.1-rc6 (with the rocket RK3568 series + your per-device-ops wor=
k)
using your bit-31 version and tested it on a ROCK 3B: the NPU IOMMU comes u=
p and
services the NPU's DMA cleanly -- the NPU probes, attaches its domain, and =
runs
repeated conv submissions with no DMA_READ_ERROR and no page-walk stall. No
regression from the write.

To be precise about what I can and can't show: I tested both ways on v7.1-r=
c6 --
with your bit-31 write, and on the reset value (0x3) -- and the NPU
IOMMU services
the NPU's reads with zero faults in both cases (no DMA_READ_ERROR, no page-=
walk
stall). So I don't have a failing baseline here that bit-31 visibly
fixes. Is the
AUTO_GATING write needed on current mainline, or only under conditions I'm =
not
reproducing (a particular traffic pattern / silicon rev)? I'll keep the pat=
ch in
your form unless you'd prefer to drop it.

One question so I document it correctly: what does bit 31 of RK_MMU_AUTO_GA=
TING
control on the v2 block -- is it a master "disable internal auto clock-gati=
ng"
for the page-table walker (i.e. so a TLB-miss walk's AXI master keeps its c=
lock
to completion)? The RK3568 TRM I have doesn't cover the IOMMU registers, so=
 a
one-line description would let me write an accurate comment.



Kind regards,
Midgy

Le ven. 5 juin 2026 =C3=A0 03:59, Chaoyi Chen <chaoyi.chen@rock-chips.com> =
a =C3=A9crit :
>
> Hello Midgy,
>
> On 6/4/2026 9:52 PM, Midgy BALON wrote:
> > On the RK356x v1 IOMMU, RK_MMU_AUTO_GATING resets to 0x3. Bit 1 enables
> > auto clock-gating of the page-table walker, so the walker's AXI master
> > loses its clock between transactions; a TLB-miss page walk then never
> > completes and the IOMMU is left stuck (PAGING_ENABLED, never IDLE).
> >
> > Clear bit 1 (keeping bit 0, the slave-port gate) once paging is enabled
> > so the walker keeps its clock. This is required for the RK3568 NPU MMU.
> >
> > Signed-off-by: Midgy BALON <midgy971@gmail.com>
> > ---
> >  drivers/iommu/rockchip-iommu.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 4da80136933c4..e3d8b6e9ca12b 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -953,6 +953,18 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
> >
> >       ret =3D rk_iommu_enable_paging(iommu);
> >
> > +     if (!ret) {
> > +             /*
> > +              * RK356x v1 IOMMU: RK_MMU_AUTO_GATING bit 1 enables page=
-walker
> > +              * auto clock-gating; the walker's AXI master then loses =
its clock
> > +              * between transactions and a TLB-miss page walk never co=
mpletes,
> > +              * leaving the IOMMU stuck (PAGING_ENABLED, never IDLE). =
 Clear
> > +              * bit 1 (keep bit 0, the slave-port gate) once paging is=
 enabled.
> > +              */
> > +             for (i =3D 0; i < iommu->num_mmu; i++)
> > +                     rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATIN=
G, 0x2);
> > +     }
> > +
> >  out_disable_stall:
> >       rk_iommu_disable_stall(iommu);
> >  out_disable_clocks:
>
> As I said, it is v2. Could you please try using the code below
> instead and see if it works? Thank you.
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iomm=
u.c
> index 0013cf196c57..89e3a83a0251 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -930,6 +930,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>         struct iommu_domain *domain =3D iommu->domain;
>         struct rk_iommu_domain *rk_domain =3D to_rk_domain(domain);
>         int ret, i;
> +       u32 auto_gate;
>
>         ret =3D clk_bulk_enable(iommu->num_clocks, iommu->clocks);
>         if (ret)
> @@ -948,6 +949,10 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>                                rk_ops->mk_dtentries(rk_domain->dt_dma));
>                 rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CAC=
HE);
>                 rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_I=
RQ_MASK);
> +
> +               auto_gate =3D rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_=
GATING);
> +               auto_gate |=3D BIT(31);
> +               rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_=
gate);
>         }
>
>         ret =3D rk_iommu_enable_paging(iommu);
>
> --
> Best,
> Chaoyi
