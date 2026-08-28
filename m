Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6263AA1A6
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 07:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903537; cv=none; b=PoUqJFn9w3NYErq/aXsWlVM6MGaOSUFwZT9ZisPIYFiyKorCjTGE5xbnoXUnFY4yHlH/fko31NxGSNRW7+BzfpnCyqMAcToQdX6hM3xwYsUt99sbffWSu/us0sJdzUV8/4WfnVZ7s1IVNBR3oYEpjQUJGAtxhKxPRosE4pfRvZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903537; c=relaxed/simple;
	bh=u/tGPPqBBEVd8O2Hj/FgEbwAVUSqAv9cUQZB1DooYEY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hvCpetPlUJWVBERFM3fOW0YgGA7+E2/mPKz94MGF+zbwtnbFTKu7aIbo7zlvywxio4e2tOMW6Ped7cvK9wb6EBdtIQQUQLYG1evb2KnKkXgb9C0+ihvSblbSWeJiCRtAC5bwcKxTZ0xLIA3Q07o6bESzsfh6dIi4lHgiDiZWqR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akWd2SWf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akWd2SWf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49557167508so6269865e9.1
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 00:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903534; x=1788508334; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dg/MQ8inXuFFEbvgK+mHsA3iNLAg+xiUDh4PfNOolRQ=;
        b=akWd2SWfYBGjthsid0NG1wSV6KLuHgz6RZgicw//meokdNTYIz/EJbY5XG+W9/c145
         MR0BTvfosJUoKmZQWWd7MEZACIF2AY5PNI8mmD0dvEIk3trEyVpxHsMvbzJloKB0+cEM
         dg2JWKG7IPY9NjVKECIiM/xw1oURXwP6PmAJNmVRVMX+/sfs55Ke5Hg1txDsCZz0NeUQ
         gnfgVa2JL8ZHcVuieZaEA5CKXffOtGPVLNCWNSVjyMgJ/JpC4d4nzxt5eeDIYCy54j/o
         DVZr03agMbmjiUOPHpFMt6GaNfWAqRDIPoXQYFymap/9GECPj9U8c1HCehn+2Nr4RYxV
         bdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903534; x=1788508334;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dg/MQ8inXuFFEbvgK+mHsA3iNLAg+xiUDh4PfNOolRQ=;
        b=DHOJvLyqOM6ihlzdV3aR1wt79AjR1+pYiE5zXtakfrExDAz0+glChDCkPdG0EB119t
         8kXz7h6bdmi0OyRQdC2SyKnVsT7bsUp9rsFYjLliJGJV0qXyo5FEj5TO/yH8l4XqDqwb
         0lYfKmTsAMjb1AAsHQzUrrI+eBKxA8XYI9KeYL72ldATDKb1eNvqYJlumCiFiv2eJ4hI
         rWr8kis4e8GtwCWRAicGZc+m9WN8kxTnma3VsCEgCKhEaOcwjZe6URW73khr5I/Ocdcb
         tdb8EeZbbkwgwZ61aw/VNpFYUK8EiSC2z4ZEJgJSBYuMOML7NWY99haCINuHBOBCDRv3
         P6Dg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8v4ZKllMcr1xfY1kmRMI4xnIviolSbl0EVCaAGQMswolMSVJvT8+E7YhRsGIc2NZgiixxxQ==@lists.linux.dev
X-Gm-Message-State: AFuF++mUqqfbQe0mQOiFZIydREDO84WEBVqXKoqSDLv8KJ33i6EmBbXN
	4WXYSzB7QrnUkL3hf8t67B5oR0x0ZTLKhGiD+fLo9/6dpEBx7iEGBTGf
X-Gm-Gg: AR+sD12IX4djOixf6ufAFaRG914LyRuw+uI9e3oPUGmJHR8QQ38nxwnokvGNn72Vs6r
	7nLwZVQx32XVlJQoXJebZuwYj2VnroMBQNtIxTolIykW5PjmxpaEeHXXY2JxHDLzAXuihpgDRGM
	fGF6o04mUC3q+jFaC0zj0Hf7YmmKg6pTKIpdsUj89JINHp2tjXPAl0f04+q81/FDDrMX8JrexBh
	61Dn9beoG5FN4Ef3E8nyAP/D7KkwsdEdCO71xIuz7IelOZXWdbq7uxuiPoopARhYH5UsH7uyT9t
	HDg2IQ1GusBztvCFMfwOTNbtthgQlhx9sj/QVbKLoj7XkbTvzwuyKBINxO50cYfaVCVd/uU3p+d
	KqBlp58nmoXD1k9PtMHAn5VkRAywD0e0Gs63d3Fhhdj07+kRn1VKgehCXh5hGkm9sUmpdtz2izo
	K4TvNuNLCOsQo3B3RENLmQTDRvU8l9sOYKEPohtr/GR2l2fHLNJXlfVRQahuBYoXD2FM39DsHG8
	ZudFv11Xzf++K8KxgksTQLeUg==
X-Received: by 2002:a05:600c:1394:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49b91c47b6bmr60078885e9.9.1787903533497;
        Fri, 28 Aug 2026 00:52:13 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b95013d06sm41438895e9.12.2026.08.28.00.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:52:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:52:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Zong Li <zong.li@sifive.com>
Cc: Guo Ren <guoren@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>,
 zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu,
 cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org,
 robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org,
 yuanzhu@bytedance.com
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
Message-ID: <20260828085211.2c8e6b74@pumpkin>
In-Reply-To: <CANXhq0qtt7U3jKEB4drvSn7gg55nwWm8VFnfY-NRGjBaWVr_MQ@mail.gmail.com>
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
	<20260615123821.373248-1-guoren@kernel.org>
	<7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
	<CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
	<e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
	<CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
	<20260618143634.7f3dd6c5@pumpkin>
	<CANXhq0qtt7U3jKEB4drvSn7gg55nwWm8VFnfY-NRGjBaWVr_MQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 28 Aug 2026 10:52:08 +0800
Zong Li <zong.li@sifive.com> wrote:

> On Fri, Jun 19, 2026 at 12:02=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 18 Jun 2026 17:51:34 +0800
> > Guo Ren <guoren@kernel.org> wrote:
> > =20
> > > Hi Vivian,
> > >
> > > As noted in the RISC-V IOMMU Specification, Chapter 6: =20
> > > > Whether an 8-byte access to an IOMMU register is single-copy atomic=
 is UNSPECIFIED, and such an access may appear, internally to the IOMMU, as=
 if two separate 4-byte accesses =E2=80=94 first to the high half and secon=
d to the low half =E2=80=94 were performed. =20
> > >
> > > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> > > not clearly defined in the current ratified RISC-V IOMMU
> > > specification. To handle this correctly, the Linux RISC-V IOMMU driver
> > > should fall back to 32-bit MMIO accesses when reading 64-bit registers
> > > (e.g., performance counters). The behavior of 32-bit MMIO accesses is
> > > more precisely defined in the RISC-V IOMMU specification.
> > >
> > > Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
> > > MMIO) based on the current ratified RISC-V IOMMU specification, and
> > > this driver does not appear to benefit from 64-bit MMIO access either.
> > > Performance is fundamentally constrained by bus latency; assuming that
> > > simply reducing the number of accesses will improve performance is an
> > > oversimplification that ignores the underlying hardware
> > > characteristics. =20
> >
> > If the bus latency is significant it is almost certainly worth using
> > memory accesses to avoid re-reading the hi register.
> >
> > Something like this might work:
> >
> > static volatile u32 hi_prev, lo_prev;
> >
> >         u32 hi =3D read_reg_hi();
> >         u32 lo =3D read_reg_lo();
> >
> >         if (lo <=3D lo_prev || hi !=3D hi_prev) {
> >                 u32 hi_tmp =3D read_reg_hi;
> >                 if (hi_tmp !=3D hi) {
> >                         hi =3D hi_tmp;
> >                         lo =3D 0;
> >                 }
> >                 lo_prev =3D ~0u;
> >                 hi_prev =3D hi;
> >         }
> >         lo_prev =3D lo;
> >         return (u64)hi << 32 | lo;
> > =20
>=20
> Hi Daivd,
>=20
> I included this in my v5 of the IOMMU PMU series, but we noticed that
> sashiko-bot AI reported two issues:

I did say 'something like this' might work....

David

>=20
> 1: The lo_prev is immediately overwritten:
> The trailing 'pmu->lo_prev[idx] =3D lo;' is outside the if block and
> runs unconditionally, so the 'lo_prev =3D ~0u' is clobbered before the
> function even returns. It never survives to the next call. lo_prev
> ends up holding the guessed value (typically 0) instead, which is a
> perfectly ordinary small number, and the intended "always re-verify
> next time" behaviour never happens. The sentinel write was effectively
> dead code.
>=20
> 2: The wrap check itself can miss a wrap
> Here is a concrete sequence. Assume a previous call left hi_prev =3D 1
> and lo_prev =3D 5, i.e. the counter was 0x1_00000005. Some time later
> the counter has advanced close to 0x1_FFFFFFFF:
>=20
>   1. hi =3D readl(addr + 4)  -> counter is 0x1_FFFFFFF0, so hi =3D 1
>   2. the counter crosses the boundary and becomes 0x2_00000008
>   3. lo =3D readl(addr)      -> lo =3D 8
>=20
> The check then evaluates:
>=20
>   lo (8) <=3D lo_prev (5)   -> false
>   hi (1) !=3D hi_prev (1)   -> false
>=20
> Both are false, so the fast path is taken and 0x1_00000008 is
> returned. The true value is 0x2_00000008, so the result is short by
> 2^32 and the third read of the high half never even executes.
>=20
> Both situations share the same root cause: It puts the reliable check
> (the third read) inside an if guarded by the unreliable cross-call
> heuristic 'lo <=3D lo_prev || hi !=3D hi_prev)'
> Case 1 is an issue in the bookkeeping that heuristic depends on, and
> case 2 shows that even with correct bookkeeping the heuristic is not
> sound.
>=20
> To make everything simpler, I would use your first version for the
> latest IOMMU PMU series:
>=20
>         hi =3D read_hi();
>         lo =3D read_lo();
>         if (hi !=3D read_hi()) {
>                 // Pick a value that happened while doing the reads.
>                 hi++;
>                 lo =3D 0;
>         }
>=20
> > It shouldn't need any locking but the accesses do need to be ordered.
> >
> >         David
> >
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv =20

