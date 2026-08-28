Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAC92C0261
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 02:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885544; cv=pass; b=ArsSj5tCchoCLQJPY6W/Or71EY0XQO2x55MskZXzt0BOIFcEZJ/dxv683zqxPoBHCPMGL/Iqafi/nxjPlMhahf440Ykl7tELUT/gKL//ysgnvD9cJ7cu+4r2F98iR8tmoJhIWQtVvyQB6Iu3vECD0jLz9DERtLoAA+5j9lOFUrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885544; c=relaxed/simple;
	bh=jVA0PcZIH71MOyCtuzwmqMkCrpkwsifi0+vB2mTyXio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gXmu0i8MR3e70aoHLb+0MhL6yPHdKY/sltOyLWiviDdLMUriBomPRR7NfgUBeLUwPZyi6pzzP3J9iVdY6JR9apKUHLK7CMdGLusM7T9h3erXfsSAkwAMxx64H+bAIwiHN5g+RJhbcO12A/kazOqZxfIlC//9CNX+88aFjPQVCPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=D9+CQMzG; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="D9+CQMzG"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c25420fe973so99220466b.0
        for <iommu@lists.linux.dev>; Thu, 27 Aug 2026 19:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787885541; cv=none;
        d=google.com; s=arc-20260327;
        b=rAuisJG/7ace14+dHj5LbCgjjIG8xEvYjbk1MVJGtJvdH4zSSxilM5ybcBrQzq2tWk
         UJ63gDqxzuptLZv6gHPr0WpoFUYtcK3xjhls4XiVflSMTPVBb/XGd+s5SD/hrzCEniKt
         Nj01tTwLhJ79jarr4qikM9rBrbIV5rJbo1MhyrPLBFlskAKX1JA0qu0j53OCNKCYOKN6
         kF9Jyv56CYChiUE7thoip95Q783gv9quk8Rd9vVZ9KuQVJkcGSff8/2yXMS0OfpRVXmh
         4hnbL5kmNfX3JMpxUkvjL+fQrx/B1PTB/WP08PgNEUzXlKKYc6B9Ffm/IRpSPOlM/eT9
         gO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8h8ajQ5iXnMhCt1P+yDUVUP4cBmcnCV7lKhnpULiS68=;
        fh=m2xxPGZa8rbx9hsGxyKMoZOl1WMfwPKpGSxYwfYejVg=;
        b=bEdwOhy4YfjNbI74NCmkv7s6ud9ht7CeGJd4CWrlnPAo68ZHf5XMPfj3XU1LzFGag4
         PsowPtrbipbSJANIGoYtd5l5b8WZMTSNMG2lYgLGtoIJqfUt4Hif8n0XvBlRyDmxDfLj
         LN+SlQh4JNQsboTTpocFyKRvPOsQgTaB5iM2rd3xMu0rjBeWdthotv9GDmnJzVkhYT/o
         8x4TJDO/oVFtFFAeprF47L4Tek9jReqCTNwXzb9kGWpSEIebCaNWk8d/Sezo0UBy8mEr
         nnCMnf++p3Nh5a8LyEiW5MmHcW2ZD2GbpVz/4n+bYmRCz76xH8wZQ/+h6EUDDEDwUEjD
         aiXQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787885541; x=1788490341; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8h8ajQ5iXnMhCt1P+yDUVUP4cBmcnCV7lKhnpULiS68=;
        b=D9+CQMzGsXXawlkJOZztbIL7iB95yJ+nle7Zsf0eu2TsWGqI6GBzW6S/H1qzi3l3Vd
         f/4kVmjgJxw2XsjcvUzGoAqHOiD+jDE6oc47p9Co1QRYZd1sPrU3GTD7GLOTTvenLCtR
         VYZ3Lnj/KTagtTrWi/634OEuEAdQPTjecKSXkBAHjL+MxRqq9tRCxR/tbm/6fOZdKSSc
         lvmlYxX9wuJD8oKhqd5d1moclpCj4XaDn+pVov/besZJPS2grQUlL1nOichzrF5m5QzT
         fGVJoCf6p9Tbtcn5eLOojvyf1BAPCF4JZ1A9U8kGS5xkY0GFaQ4euEWk3JjgVCxoevHj
         ZbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787885541; x=1788490341;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8h8ajQ5iXnMhCt1P+yDUVUP4cBmcnCV7lKhnpULiS68=;
        b=UOOcvvhrJrNVZz+17yqP067qq99xeN2bd6X32B4uhk+JDUUQvJ0S3mV44GCAh//GeN
         SJZUuW8B1rAKLfm3hvwlkwxM+yoWB1x2ZqUuVNladjwcn96KbEo5BP+EVaquV7YIQoYK
         U+bMaKluf6UruS6oP67TTxE2IlSRRCPqX9uDvMx/tXjQvn4Z4CT6noMf147S/JNin8m+
         JGlt/EmNAHSDYuI3im/PY1QWa642O9FM6qO+XwIil0GnUkxcGjXWgH1YQWVUPLaUH51n
         RPhU9Oa6OSvD+2lhDbWLO0CxIyxS8mJJoVHc9De79c6nDAsvE4YBlLppOogz1ZqTxabe
         RlUQ==
X-Forwarded-Encrypted: i=1; AHgh+RrQQXRBGot897T5+L6OqRZ3L6DgDKsScwqMxo9R1QKScU+MhpecTA2tL2SNaQ6fPZcMIls+lQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lzb2f8qOeb/dWrtMeBA1KlW5rWcMNVNP0pUWKK+Rt5OOC1HdES
	Y8Ze50VAqGbj1tHjge/15ZdmoOGx+dcLCJOeY5Pg/AUEeI/By2tZGICFKQoHR92qsMoqaHmc2bf
	Q0Ygzr5VueMQH0zXOqgFg8zwE44IAtOCe5kPUoZclDA==
X-Gm-Gg: AR+sD13glZbiZYgSU06on8U5xqo2vF0vR5sV3a6V4/eZc1K8sBH7w4pDDOLpuuafr4/
	zT0SS8qnACxcuxQJHxO/XJPuZsb5H+H3i4oKRrU2u0CPL+P0n5Mie6Hd8QnqjaQCBLvyDs3JNyE
	0Vfak/I/JiDAzLOs/az21P+JqfflKeTRXZ1NUFjTC73E8RPm7OLYYdVtR9H9u9xWxIWYQ8X12ux
	wWSKQyefVPVBNB5KJkkUjDkmoBo8hi1tvk6NE1TwpZJLfAkQvS+qDgItarQzezUViKnDv1fkKEA
	LImOg4EkrNjlGSfAfsqobjMSiou2oDj5G/fq1UXz61bvUCuzAWwCYZJ2tQ==
X-Received: by 2002:a17:907:a091:b0:c16:8adf:f183 with SMTP id
 a640c23a62f3a-c255742f3e2mr190741766b.14.1787885540701; Thu, 27 Aug 2026
 19:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com>
 <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn> <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
 <20260618143634.7f3dd6c5@pumpkin>
In-Reply-To: <20260618143634.7f3dd6c5@pumpkin>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 10:52:08 +0800
X-Gm-Features: AcwNN1XwesBjMwTR7nVyOfHazvWEdcWRn6IE55RF21RXQf02dtzp-bwH5tm1dh0
Message-ID: <CANXhq0qtt7U3jKEB4drvSn7gg55nwWm8VFnfY-NRGjBaWVr_MQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: David Laight <david.laight.linux@gmail.com>
Cc: Guo Ren <guoren@kernel.org>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 12:02=E2=80=AFAM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Thu, 18 Jun 2026 17:51:34 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > Hi Vivian,
> >
> > As noted in the RISC-V IOMMU Specification, Chapter 6:
> > > Whether an 8-byte access to an IOMMU register is single-copy atomic i=
s UNSPECIFIED, and such an access may appear, internally to the IOMMU, as i=
f two separate 4-byte accesses =E2=80=94 first to the high half and second =
to the low half =E2=80=94 were performed.
> >
> > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> > not clearly defined in the current ratified RISC-V IOMMU
> > specification. To handle this correctly, the Linux RISC-V IOMMU driver
> > should fall back to 32-bit MMIO accesses when reading 64-bit registers
> > (e.g., performance counters). The behavior of 32-bit MMIO accesses is
> > more precisely defined in the RISC-V IOMMU specification.
> >
> > Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
> > MMIO) based on the current ratified RISC-V IOMMU specification, and
> > this driver does not appear to benefit from 64-bit MMIO access either.
> > Performance is fundamentally constrained by bus latency; assuming that
> > simply reducing the number of accesses will improve performance is an
> > oversimplification that ignores the underlying hardware
> > characteristics.
>
> If the bus latency is significant it is almost certainly worth using
> memory accesses to avoid re-reading the hi register.
>
> Something like this might work:
>
> static volatile u32 hi_prev, lo_prev;
>
>         u32 hi =3D read_reg_hi();
>         u32 lo =3D read_reg_lo();
>
>         if (lo <=3D lo_prev || hi !=3D hi_prev) {
>                 u32 hi_tmp =3D read_reg_hi;
>                 if (hi_tmp !=3D hi) {
>                         hi =3D hi_tmp;
>                         lo =3D 0;
>                 }
>                 lo_prev =3D ~0u;
>                 hi_prev =3D hi;
>         }
>         lo_prev =3D lo;
>         return (u64)hi << 32 | lo;
>

Hi Daivd,

I included this in my v5 of the IOMMU PMU series, but we noticed that
sashiko-bot AI reported two issues:

1: The lo_prev is immediately overwritten:
The trailing 'pmu->lo_prev[idx] =3D lo;' is outside the if block and
runs unconditionally, so the 'lo_prev =3D ~0u' is clobbered before the
function even returns. It never survives to the next call. lo_prev
ends up holding the guessed value (typically 0) instead, which is a
perfectly ordinary small number, and the intended "always re-verify
next time" behaviour never happens. The sentinel write was effectively
dead code.

2: The wrap check itself can miss a wrap
Here is a concrete sequence. Assume a previous call left hi_prev =3D 1
and lo_prev =3D 5, i.e. the counter was 0x1_00000005. Some time later
the counter has advanced close to 0x1_FFFFFFFF:

  1. hi =3D readl(addr + 4)  -> counter is 0x1_FFFFFFF0, so hi =3D 1
  2. the counter crosses the boundary and becomes 0x2_00000008
  3. lo =3D readl(addr)      -> lo =3D 8

The check then evaluates:

  lo (8) <=3D lo_prev (5)   -> false
  hi (1) !=3D hi_prev (1)   -> false

Both are false, so the fast path is taken and 0x1_00000008 is
returned. The true value is 0x2_00000008, so the result is short by
2^32 and the third read of the high half never even executes.

Both situations share the same root cause: It puts the reliable check
(the third read) inside an if guarded by the unreliable cross-call
heuristic 'lo <=3D lo_prev || hi !=3D hi_prev)'
Case 1 is an issue in the bookkeeping that heuristic depends on, and
case 2 shows that even with correct bookkeeping the heuristic is not
sound.

To make everything simpler, I would use your first version for the
latest IOMMU PMU series:

        hi =3D read_hi();
        lo =3D read_lo();
        if (hi !=3D read_hi()) {
                // Pick a value that happened while doing the reads.
                hi++;
                lo =3D 0;
        }

> It shouldn't need any locking but the accesses do need to be ordered.
>
>         David
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
