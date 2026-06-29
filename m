Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5717745
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 01:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782695760; cv=pass; b=kSx3si5C/y9XYT8QQJOR9oaYEaXiG9VFvduDV3jjlH5mEqgly5siKi4c3Qlacyg9FVKfsERirInqRzsbwv2Rr6anGEBbXl/LV/6NlAsuwpviAhZLCPdK3vY3CKXUEsmVGKqb4Cw8k14baKQrZn5sO1SswsN+0VK28LyvHXl+nhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782695760; c=relaxed/simple;
	bh=zAuR7THOwobLwULkWsxQJmBDVFUm6+So5/Nsf8QNZCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CJb1jNj71VSqEVB8NS3e+IPpEFMT4NvSmr3QRNAyhHH81dt+PXdbL2Xkollhc20C5PEmbNcIw50sMTMbUCbr+9XAdHD774RE2KBetxP/m9L2AQUA0tfpNWc1Rx/3Az+l86PspcC6bRyoYnmrBJybgnL57etq2WgQ67s8rBu1BuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=bKoc0d6P; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="bKoc0d6P"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so4780164a12.2
        for <iommu@lists.linux.dev>; Sun, 28 Jun 2026 18:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782695757; cv=none;
        d=google.com; s=arc-20260327;
        b=FSp7hnd9RmyFrzNk4J7UNSmjq1ZyI3/MMz2rwEFfW93dMgRaE/Ut32Rl+58arfrMLR
         mYjpIntCRGYOfzLWmz2iB7pRXSNU6wf+RKSnaRA+l+mjmoqg4gtX0izifJbx+++P2XHe
         7ReU+HuhB/upZKoWnd1i6cp1BS+sLgg3NZrSaJ5tGuF2UQln0bECPXgCfTzIswsMQzfF
         b8ULRkDNL/HbwhggrYs9wbSilQwAhDwBEe4EIzvnmfZ4auVS2jNY8km5YB6O4HliteIS
         i5PUDgRYTy8l25hYYR97IX2UiCeTn6dXOfuI8+YgCn2xQzPgFH+uFEdES13un5p+4iRU
         02Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mkIGoNj9/WZkckvb1+KhYqNwSHBnTTepRZw4NPJEdhA=;
        fh=+2lDZ9PLkxBKdBHvxzAI4Gldq6d4wWQytupXEVEHrL8=;
        b=pejdsr2JGVZCClXy6Gn49ZB6widFww2luEF+/Nm0ZR47TZNRO8hwFnZzdrmdesXxFD
         CJs+pMzRswQ6PdZ6oqatjw/Gmd+QXfo8xBLumSHB1Lr4DwznNxuzPUClD7yYEL59E7mT
         KdBp2qRjFL1yzEvQ5rFGMIGS44pS6758CS/3Q5WNeIBnSlJmaYGFaJMSfrJMhb/AVXxH
         Of9miIwNkCynOaJ6C3ajImSut/4oDb/95eOVn+CW3Jb2evD8fEeAfXwGwekyCmjPM/JQ
         nBcYF5/XgiFnZCaMfRTzWHfg9RcdvX1LujgQN0WAAY4retX5guKggxyYh2dFHXzWjjGI
         okIA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1782695757; x=1783300557; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkIGoNj9/WZkckvb1+KhYqNwSHBnTTepRZw4NPJEdhA=;
        b=bKoc0d6PhjguIl48qgNtj0xV3Wcz4nHHXaT7OInn7mW2cMK15G1li5f8H+b406hpOO
         gcA1ZIpAdWb+x4/t5/oGqtowsWA4Tu7CNg+vkqGvy0XFLISl6g/9q/hKK3P6p+H4yHwB
         5YcPeoGLh/8j7BA1X+wVwWhOw9YbgIjvraASc4pSeKFGShYr/NS0xQp1Lke8gnEVcLfg
         EtFQ1ZaDDTs5/dZ+oFDTgSyT/Zma4V5PConbg39DFqAKeJCIb70w9JXqwfYloVENAW4Z
         pAB079+f+tKXBZA7oaFyENny+W8EJ28n3Kp6CK3MTGVMPUxteV/8bAMcExKzPdY2AHx0
         giTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782695757; x=1783300557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mkIGoNj9/WZkckvb1+KhYqNwSHBnTTepRZw4NPJEdhA=;
        b=LulLD/R6Sf2RclpjZnTTR/RJmOKSChh4u3p1uafoyK4Fksr2R0MI4lkpHSenpKXC0E
         LZfwtDT7C6ieJfMR5wSPr7cmuSIktofSC1f1NpaPzHELoiJ5aApMloWxVZfTnVM9ntRu
         aS2zFU8MPBqvpqJ7Vv5rXXVfCxLva6BnKLmUYeahHGtFMiY8fDpk96Er/LVSKKhSppAl
         u7mLACx+vpJCQwRXolvXNOZnXFaCeU7iIdPp8jnNAlTFtwHtSd576QIjZlGios0CU0Bt
         CSSGHX980nyfOoYmoZqzdb7AA+xYcxFQl0AiO/FID4yio2dWeSogwf4F+DPVPHI/D/3W
         cN/w==
X-Forwarded-Encrypted: i=1; AHgh+RqP/sbIE37C6KvBu9MbuL1/gT4bAklwEGWNBL5uFXkBogHa3Z3dXEbBY8O//L+wb6QHM7yj/w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhSZbO47aK2UQ0/Vm1yUe7xwLeaqoXmjHBKz/7E0e9/buqEj67
	9P0czvfnFU3QYXNk5VtBmNGbJWolQOqqIneAm0aBC1K1v6I+3TAS+3/yAGEQhmeFYiaWh/i4ofD
	oqhVELAoGORG3PFFaHxtqObHOm/e+L9yBtmVJDUdF6g==
X-Gm-Gg: AfdE7cmdJG62p2SySOmh2RNtDC+cQdEDOOax65hVU4sjs1maEikCHIoSaxu9cGfScM4
	gMtDTKdvwBqB0rF+G1BLajDp9D9NpI1ILTh9S6rJeZ/eh3mL0lUtA+pisxUUm4w9GmqUjZwwyLp
	ZAEfDWfCP5AOSx86hPWeedK/XZwciDuQKwn8sCA5J8ierQtG5cPX6XKem3ZMGvRkaP+LizChm/Q
	aMCCu5ubbnc81OG/yfdSlj/OvRMBT2y/LA/Y6d0Gfvf7pW/N+Z42qTTkGdiayuhW4BcWuqhOqg=
X-Received: by 2002:a05:6402:50c7:b0:698:56e7:8eb3 with SMTP id
 4fb4d7f45d1cf-69856e7906cmr1618583a12.14.1782695757511; Sun, 28 Jun 2026
 18:15:57 -0700 (PDT)
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
 <20260618143634.7f3dd6c5@pumpkin> <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
 <CANXhq0r=hNEF9jVM39fYC-bk7S4bNpWt9H4M3Qh3zo+d3UNRpA@mail.gmail.com> <CAJF2gTQD+PZj1pLpVT0u+q9CAwFMQubF6d3CYS=GDR0-b_fykQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQD+PZj1pLpVT0u+q9CAwFMQubF6d3CYS=GDR0-b_fykQ@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Mon, 29 Jun 2026 09:15:46 +0800
X-Gm-Features: AVVi8Cds7GpMAvxKFJN7_-MdJZZ2NSSYN4ijpQeh5aUC9mstNP0YCeor9he6LBA
Message-ID: <CANXhq0o5z7+mxTptca32Ywr9UY5jrpA89f7fS81A9fG0JS25xw@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Guo Ren <guoren@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	zhangzhanpeng.jasper@bytedance.com, alex@ghiti.fr, aou@eecs.berkeley.edu, 
	cuiyunhui@bytedance.com, iommu@lists.linux.dev, joro@8bytes.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	luxu.kernel@bytedance.com, palmer@dabbelt.com, pjw@kernel.org, 
	robin.murphy@arm.com, tjeznach@rivosinc.com, will@kernel.org, 
	yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 28, 2026 at 4:20=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> Hi Zong Li,
>
> On Tue, Jun 23, 2026 at 5:21=E2=80=AFPM Zong Li <zong.li@sifive.com> wrot=
e:
> >
> > On Fri, Jun 19, 2026 at 1:14=E2=80=AFAM Guo Ren <guoren@kernel.org> wro=
te:
> > >
> > > On Thu, Jun 18, 2026 at 9:36=E2=80=AFPM David Laight
> > > <david.laight.linux@gmail.com> wrote:
> > > >
> > > > On Thu, 18 Jun 2026 17:51:34 +0800
> > > > Guo Ren <guoren@kernel.org> wrote:
> > > >
> > > > > Hi Vivian,
> > > > >
> > > > > As noted in the RISC-V IOMMU Specification, Chapter 6:
> > > > > > Whether an 8-byte access to an IOMMU register is single-copy at=
omic is UNSPECIFIED, and such an access may appear, internally to the IOMMU=
, as if two separate 4-byte accesses =E2=80=94 first to the high half and s=
econd to the low half =E2=80=94 were performed.
> > > > >
> > > > > Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED a=
nd
> > > > > not clearly defined in the current ratified RISC-V IOMMU
> > > > > specification. To handle this correctly, the Linux RISC-V IOMMU d=
river
> > > > > should fall back to 32-bit MMIO accesses when reading 64-bit regi=
sters
> > > > > (e.g., performance counters). The behavior of 32-bit MMIO accesse=
s is
> > > > > more precisely defined in the RISC-V IOMMU specification.
> > > > >
> > > > > Thus, many hardware vendors implement 32-bit MMIO (rather than 64=
-bit
> > > > > MMIO) based on the current ratified RISC-V IOMMU specification, a=
nd
> > > > > this driver does not appear to benefit from 64-bit MMIO access ei=
ther.
> > > > > Performance is fundamentally constrained by bus latency; assuming=
 that
> > > > > simply reducing the number of accesses will improve performance i=
s an
> > > > > oversimplification that ignores the underlying hardware
> > > > > characteristics.
> > > >
> > > > If the bus latency is significant it is almost certainly worth usin=
g
> > > > memory accesses to avoid re-reading the hi register.
> > > >
> > > > Something like this might work:
> > > >
> > > > static volatile u32 hi_prev, lo_prev;
> > > >
> > > >         u32 hi =3D read_reg_hi();
> > > >         u32 lo =3D read_reg_lo();
> > > >
> > > >         if (lo <=3D lo_prev || hi !=3D hi_prev) {
> > > >                 u32 hi_tmp =3D read_reg_hi;
> > > >                 if (hi_tmp !=3D hi) {
> > > >                         hi =3D hi_tmp;
> > > >                         lo =3D 0;
> > > >                 }
> > > >                 lo_prev =3D ~0u;
> > > >                 hi_prev =3D hi;
> > > >         }
> > > >         lo_prev =3D lo;
> > > >         return (u64)hi << 32 | lo;
> > > >
> > > > It shouldn't need any locking but the accesses do need to be ordere=
d.
> > > Thank you for the suggestion. However, I believe this feedback is mor=
e
> > > relevant to the RISC-V IOMMU HPM patchset [1], as no counter register=
s
> > > are involved in the current patchset. That said, the idea of improvin=
g
> > > the hi-lo-hi slow-path mechanism to better handle high-latency
> > > hardware scenarios is well taken and worth discussing in the
> > > appropriate thread.
> > > [1]: https://lore.kernel.org/linux-riscv/20260208063848.3547817-2-zon=
g.li@sifive.com/
> > >
> > > P.S. The hardware I have at hand exhibits very low interconnect
> > > latency. And I have never observed the slow path where hi_tmp !=3D hi
> > > being triggered =E2=80=94 my approach was to remove the retry mechani=
sm
> > > directly in 32-bit mmio mode and run stress tests to check whether
> > > perf stat produced incorrect results. That said, I may have simply
> > > been lucky instead of hw guarantee.
> > >
> >
> >
> > Hi everyone,
> >
> > Thank you for adding me to this discussion. I took some time to read
> > the previous messages.
> > Regarding the GitHub issue mentioned by Vivian, I noticed someone
> > pointed out that the hardware must support 64-bit access.
> >
> >     https://github.com/riscv-non-isa/riscv-iommu/issues/765#issuecommen=
t-4742941894
> >
> > I would like to confirm if that is correct. If so, should we update
> > the spec? And does this mean we do not need to modify the driver?
>
> Currently, no one has proposed updating the SPEC. Discussions are
> still focused on clarifying the meaning of the existing specification.
> There are two main points under discussion: the first has been
> clarified, while the second remains controversial.
>
> The first point =E2=80=94 "Whether an 8-byte access to an IOMMU register =
is
> single-copy atomic is UNSPECIFIED" =E2=80=94 is uncontroversial. Ved furt=
her
> explained that such an access may appear internally to the IOMMU as
> two separate 4-byte accesses. Therefore, for hpm COUNTER counters,
> 32-bit MMIO access must be used to guarantee the correct hi-lo-hi
> ordering. Using 64-bit MMIO access can result in a lo-hi-hi-lo
> sequence, because the specification does not define the order in which
> the access may be split and explicitly marks this behavior as
> UNSPECIFIED. At present, there is unanimous agreement on this point,
> that is, "Whether an 8-byte access to an IOMMU register is single-copy
> atomic is UNSPECIFIED".
>
> The second point =E2=80=94 "Registers that are 64-bit wide may be accesse=
d
> using either a 32-bit or a 64-bit access." =E2=80=94 is controversial.
> According to the clear definition in RFC 2119: MAY This word, or the
> adjective "OPTIONAL", mean that an item is truly optional. One vendor
> may choose to include the item because a particular marketplace
> requires it or because the vendor feels that it enhances the product
> while another vendor may omit the same item. An implementation which
> does not include a particular option MUST be prepared to interoperate
> with another implementation which does include the option, though
> perhaps with reduced functionality. In the same vein an implementation
> which does include a particular option MUST be prepared to
> interoperate with another implementation which does not include the
> option (except, of course, for the feature the option provides).
> Consequently, any claim that this wording imposes a requirement for
> hardware to support 64-bit MMIO access has generated significant
> controversy.
>
> The current explicit consensus on the specification is therefore as follo=
ws:
> 1. All hardware must support access to 64-bit registers using 32-bit
> MMIO accesses.
> 2. Only 32-bit MMIO accesses are guaranteed to be single-copy atomic.
>
> From both a single-copy atomicity perspective and a hardware
> requirements standpoint, Linux kernel drivers should currently follow
> the consensus described above and avoid the controversial 64-bit MMIO
> access. Furthermore, I see no performance benefit to using 64-bit MMIO
> accesses in this driver, as the only 64-bit registers involved =E2=80=94 =
such
> as RISCV_IOMMU_REG_DDTP, RISCV_IOMMU_REG_ICVEC, and queue->qbr =E2=80=94 =
are
> not frequently accessed.
>

Thanks for your clarification, I will address this topic in PMU driver
in the next version.

> --
> Best Regards
>  Guo Ren
