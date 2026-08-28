Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBBE3E9C32
	for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906536; cv=pass; b=EheffZM6eUwWej+mFNmTicpu2D6PA4+FnpxBM3iJvZqOMEd0IYhJPe/St5M02n0uiCt3DXIiGSD+4ERKU1Pb5jl7P1oM6SBSZILujBZ8e0WzD0ZJH1IwUDJunO9YRQhMkctWAiBFoXfEt8/krTJD4nI/yCXXwGc3g3FqP6vtNq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906536; c=relaxed/simple;
	bh=fEE+65zMqX/ESlt+j6tEmMpTDakYWgxrcLiEmC0Yq0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRMnWZ9hiIYZmkjCoVsP/y0E4Ee8fPHUzNjtd6JIMfAj4skViI5gYWUHLEZqYYPzd5nZIZI5T+sOj5UERb1Jd8ebL6xt8HkfTT1PxH67UmHyLLNBh6SZyzQTzVAsS86VZbPgG0ZwGcY87g99kQuaPuzQ2Lx0PGDlzwDS0Qg3Efw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=mj0PPoRr; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mj0PPoRr"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c247f6687dcso128482266b.2
        for <iommu@lists.linux.dev>; Fri, 28 Aug 2026 01:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787906532; cv=none;
        d=google.com; s=arc-20260327;
        b=FqRgkMmtQDe2cYMxfjIf/D4T1S77JcN6SNx9KcHbO00tL5tlUTYxZg8t62kjCTuIx5
         2IRErquDqBTzG04lpd8Tz+lY06EkcLWw7nrcHL6VxoJWQYVzmyfV6gHA7eNnc4V7PWUk
         eErZ4jtGZh6C5tWBYVsC8OWLjKiZmUJby+Lg0i1MPgZWAhwTIIip3OmJh1F2nbizSLwR
         aJ0tTalGgzSnpDfoH6i5y3/dIup2yT7S/10ri5YQNumdOe5oQoxZWv2NsYTS89e5IeYA
         wZUSw2clpdumVnsnCzPlt9pfSkt4p2DoZ1hSHlO7H1OmCM1J0efRL37rFbN61fPqb9lB
         YDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ezFi05tPQzp8t++/2HJlKxh2g0ZUNbvpyQdfBqWin94=;
        fh=s6/6nAEi1osy+/VF8Tf04uv8ABvDVQo7qsJ9tts0nI0=;
        b=FWHImzGHg376WmOcX8htz8WDyllhutpsGAG1GI/egc2KYZk/CHASvifhGCjI58vBct
         mX4AsNOOstcRiyAsQ/R/WZrF8QhxxWio07NfS6KrSVCT9hgAqxBHaBsR4PyosCjOIC7J
         J6xmlwSdUcB7+cvKiP1Fs+KLsE4GDrSso6Y6IqnAiZD6mt5Z5TuVfSOOwpR7NNRDeqmZ
         La4cYn1jtPUL+Q7S12IaeTTSv8NJ7XfdAe3YzOFuBjbjTB5NQUh+WEyNjNUx2u/io1EQ
         OVwx4c+RkFgZsuDqAg5LUYnyCCcyFfhcOkMp3xpRx1Tfa7MTaJnccCjxS50T203Z7O+3
         FwkA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787906532; x=1788511332; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ezFi05tPQzp8t++/2HJlKxh2g0ZUNbvpyQdfBqWin94=;
        b=mj0PPoRrHwLFgtjrMFn9B1s+jz/v+drM5XekRsdLGM9GhloNv2Xe6PlChKkNy9U+wH
         oYAdhchprWpqT8/t4hhjVa/IvEwRmrfyMCowGmv7PSzMHM/8L2V2nvp36uFuUNSzi1DX
         ylW+r6CzqE5jXdbh6Akh+OVK3eg5WS/K07dXOYp6EtS9xICAsiXZrVKE13Wf8c3lksDf
         W1E/7clMs+gRizrMELxGwJ+ktE0sltXrWNrRVxQhY6RuXZ5c5YTnAYPafUMI8EfVSpps
         ubWKA45fsR7G4C9/m10dcMtDX3aIgA/q8Mf8RA+1wEqMYm/ktDFLyhv1VeF+VSFTNvxP
         r/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906532; x=1788511332;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ezFi05tPQzp8t++/2HJlKxh2g0ZUNbvpyQdfBqWin94=;
        b=Lt1dOMABfwcnYTga4nVWrHYv5G6cmoSAkt2+utDbrgd8+18KtJWcmVtiEViEjdze/B
         SSP0BHTLQWrkBLnp7MY+D5TUCdeFUQkj41zBR8bFDA9E9Hb3Sn44BanDb9K+o4a5W/7a
         PYK9VkAUYUZXu3w5c3/3daA9ELY/yuDFM8uJcmnpW/rfwKNoGtcJYHBbXQnkG0PaGFnE
         EGiVn+sHXF7Hb1wlsFXR/YzA8N2pf0oi4ux1DljfUadvSQs2Z3+A6dSOfF5nWQcodCgF
         iboUI3aoEup9FKrS6fsQUs+AA7hNcPoZ23d0v/kTCPecaqtD18YqqU7xQQ0knE29yyzi
         2yNQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqbqy6u0i7pQN7VcTM1APJ4kD+j4CYjGZq1K+8fgPeX4KrAlUPfmjomQaBmj8cuGGMJXezQ+w==@lists.linux.dev
X-Gm-Message-State: AFuF++k46zGVDYVOIgNHTdmfSizobiM/Btw7F7aZOBN2rmLonxc4t0JW
	A9wly2SFLqHEA5wdagr0ixoWT+pzoLUf8V4WEEkIUcSHqzKcuX0rUjS5iKTDl7oYV/BaxCuxbCS
	16iCXNrR0RLh6isEAb0NIoDVX22RKI93U43E8dQEeCw==
X-Gm-Gg: AR+sD12zKKyxsMg4wOsfKsSlgL+11NZ4Kdcge2QlBmaduA2MlFNcUJAa/Ejab8wMkaN
	zFLPOZcX/rm/p3xq+PVAC5CH6d9YxZpYqauHUI3YdPC/NepcEKS1DpiuX43fYz4TaYlL9aJV8WL
	uMt3olC9FG9N1BMYczuydejxqd/30sbzMmgWkr2mRSwLTM9AtfGz48gFmdJq0wEUBXgIVFKLIZy
	YLgxP9ICjQv1Q9vBLIxyDHVPQ4wsktw4X8MvzYXZQ4ny2TBUuoa8sD2fKNJ54qmAiMBbRFutzyS
	4ACPvDlbfYZyiYRoyvgTstOKFw+UkY77ci+dzDKjtVezVAY=
X-Received: by 2002:a17:906:f596:b0:c24:c22c:6372 with SMTP id
 a640c23a62f3a-c2556bc89ddmr380599066b.5.1787906532051; Fri, 28 Aug 2026
 01:42:12 -0700 (PDT)
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
 <20260618143634.7f3dd6c5@pumpkin> <CANXhq0qtt7U3jKEB4drvSn7gg55nwWm8VFnfY-NRGjBaWVr_MQ@mail.gmail.com>
 <20260828085211.2c8e6b74@pumpkin>
In-Reply-To: <20260828085211.2c8e6b74@pumpkin>
From: Zong Li <zong.li@sifive.com>
Date: Fri, 28 Aug 2026 16:41:57 +0800
X-Gm-Features: AcwNN1Vs0PjxxPtn0TUC_KuzAnVZJvtJ55ltk6ptl2Y2t9swn9PGcyLQJdEC5LA
Message-ID: <CANXhq0q0pRXbL3sA9hFoFh6YGJh+M8SDUcXNhsHDA433mFb8+w@mail.gmail.com>
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

On Fri, Aug 28, 2026 at 3:52=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 28 Aug 2026 10:52:08 +0800
> Zong Li <zong.li@sifive.com> wrote:
>
> > On Fri, Jun 19, 2026 at 12:02=E2=80=AFAM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Thu, 18 Jun 2026 17:51:34 +0800
> > > Guo Ren <guoren@kernel.org> wrote:
> > >
> > > > Hi Vivian,
> > > >
> > > > As noted in the RISC-V IOMMU Specification, Chapter 6:
> > > > > Whether an 8-byte access to an IOMMU register is single-copy atom=
ic is UNSPECIFIED, and such an access may appear, internally to the IOMMU, =
as if two separate 4-byte accesses =E2=80=94 first to the high half and sec=
ond to the low half =E2=80=94 were performed.
> > > >
> > > > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
> > > > not clearly defined in the current ratified RISC-V IOMMU
> > > > specification. To handle this correctly, the Linux RISC-V IOMMU dri=
ver
> > > > should fall back to 32-bit MMIO accesses when reading 64-bit regist=
ers
> > > > (e.g., performance counters). The behavior of 32-bit MMIO accesses =
is
> > > > more precisely defined in the RISC-V IOMMU specification.
> > > >
> > > > Thus, many hardware vendors implement 32-bit MMIO (rather than 64-b=
it
> > > > MMIO) based on the current ratified RISC-V IOMMU specification, and
> > > > this driver does not appear to benefit from 64-bit MMIO access eith=
er.
> > > > Performance is fundamentally constrained by bus latency; assuming t=
hat
> > > > simply reducing the number of accesses will improve performance is =
an
> > > > oversimplification that ignores the underlying hardware
> > > > characteristics.
> > >
> > > If the bus latency is significant it is almost certainly worth using
> > > memory accesses to avoid re-reading the hi register.
> > >
> > > Something like this might work:
> > >
> > > static volatile u32 hi_prev, lo_prev;
> > >
> > >         u32 hi =3D read_reg_hi();
> > >         u32 lo =3D read_reg_lo();
> > >
> > >         if (lo <=3D lo_prev || hi !=3D hi_prev) {
> > >                 u32 hi_tmp =3D read_reg_hi;
> > >                 if (hi_tmp !=3D hi) {
> > >                         hi =3D hi_tmp;
> > >                         lo =3D 0;
> > >                 }
> > >                 lo_prev =3D ~0u;
> > >                 hi_prev =3D hi;
> > >         }
> > >         lo_prev =3D lo;
> > >         return (u64)hi << 32 | lo;
> > >
> >
> > Hi Daivd,
> >
> > I included this in my v5 of the IOMMU PMU series, but we noticed that
> > sashiko-bot AI reported two issues:
>
> I did say 'something like this' might work....
>

Got it! Thanks for clarifying. Just to share with you and everyone
here, I will go with the previous version. Thanks again!

> David
>
> >
> > 1: The lo_prev is immediately overwritten:
> > The trailing 'pmu->lo_prev[idx] =3D lo;' is outside the if block and
> > runs unconditionally, so the 'lo_prev =3D ~0u' is clobbered before the
> > function even returns. It never survives to the next call. lo_prev
> > ends up holding the guessed value (typically 0) instead, which is a
> > perfectly ordinary small number, and the intended "always re-verify
> > next time" behaviour never happens. The sentinel write was effectively
> > dead code.
> >
> > 2: The wrap check itself can miss a wrap
> > Here is a concrete sequence. Assume a previous call left hi_prev =3D 1
> > and lo_prev =3D 5, i.e. the counter was 0x1_00000005. Some time later
> > the counter has advanced close to 0x1_FFFFFFFF:
> >
> >   1. hi =3D readl(addr + 4)  -> counter is 0x1_FFFFFFF0, so hi =3D 1
> >   2. the counter crosses the boundary and becomes 0x2_00000008
> >   3. lo =3D readl(addr)      -> lo =3D 8
> >
> > The check then evaluates:
> >
> >   lo (8) <=3D lo_prev (5)   -> false
> >   hi (1) !=3D hi_prev (1)   -> false
> >
> > Both are false, so the fast path is taken and 0x1_00000008 is
> > returned. The true value is 0x2_00000008, so the result is short by
> > 2^32 and the third read of the high half never even executes.
> >
> > Both situations share the same root cause: It puts the reliable check
> > (the third read) inside an if guarded by the unreliable cross-call
> > heuristic 'lo <=3D lo_prev || hi !=3D hi_prev)'
> > Case 1 is an issue in the bookkeeping that heuristic depends on, and
> > case 2 shows that even with correct bookkeeping the heuristic is not
> > sound.
> >
> > To make everything simpler, I would use your first version for the
> > latest IOMMU PMU series:
> >
> >         hi =3D read_hi();
> >         lo =3D read_lo();
> >         if (hi !=3D read_hi()) {
> >                 // Pick a value that happened while doing the reads.
> >                 hi++;
> >                 lo =3D 0;
> >         }
> >
> > > It shouldn't need any locking but the accesses do need to be ordered.
> > >
> > >         David
> > >
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
