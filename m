Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5403431E846
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781800865; cv=none; b=kfi774+MGpeuh1yZiw7b0jy+UYJd9q4rsDEhAERg2AzT/Uag6Jm4rrj8/jxvijuInk9zdOBdqDB24v8/XPfLYZagIxEErinYXgfxSuXLHQgBxLTLUM1SykA0DvIJ7D1zW5WJVw90k3nLzhxt6F6CqbhTH3YBdNVKngPe1hhWT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781800865; c=relaxed/simple;
	bh=rFnw8/k0KaPy2GE/tkk9L/t9ucw33GSuDgOBVzNPtZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4EpXz1/8c4XalASpCBS63RVlSCLQLDQ+Hr0T56fLqrLpu+1OU0ZI/hm+ZUoppHAMZcLp+U6UT0MNOPu8X5uMmjbgWGNkg+Yds2+6gLbsrV1shY5Q3BmE+F+E03RWlaVBOYOtO6+ZwZpNF/Mh8j7ymwf5c+jDVIxZFa3kFHt68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K87pGkq7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K87pGkq7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB7C1F01558
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 16:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781800864;
	bh=DwKsFa5RJnYwBMeG4/pXUjfZncf00tGOLypqlsoEZ3I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K87pGkq7XxQ8/poADvsiimC/0anxG7pNT8Fa8JKBz6TALlt5T1vk3N2J5kF2lo9mJ
	 /7BZe6s5WyGnUTqwZbZMxTOaA1zACu+iS4KPN91rlyzqlKUK2qIBgez77UjQxQeQjo
	 ZqZxMTDVosKwxw+OtN9bkskaskx30n+RCixV+cdi2iSBgLIaVN6c012O52a/XlDSry
	 UbtFzpvI+s4YXNuyHGBtSF9kK8H+OEKqt32lJDvTMh049mqb4G37A6kvLWTSpLgu0t
	 oR3cIPcXGmVeLWEsDOVS+xeiwXGyrbF01YGvxxMdcYgT5GcLnUowwHVRj2Jrb1bp9q
	 vlViEmPhD8WSA==
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-490afc47455so4691275e9.2
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:41:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8zn8s1C0nFRr85N7CSe6uIgnkOqHsf+Tq6/1Y8CymBm0vRha4DM3+uenjS7ha2G6GqTffLWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdBUGw4uORgWkEGn0DVm2f48KQaV1GIrio1JMrUG1bNQiL4C5T
	XsMKFDa4czyUVQA4K08NYr2B9QuIbPy9gvqxFGLDuezn0IMiwRZFWUgsYEmm99xHwpoTYZQWlZq
	JLqxDPj1Kx7elwVwYz92nl8WAfJ0XQFc=
X-Received: by 2002:a05:600c:8b23:b0:490:9bc2:bf8b with SMTP id
 5b1f17b1804b1-4923ef4c619mr7649625e9.5.1781800862561; Thu, 18 Jun 2026
 09:41:02 -0700 (PDT)
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
From: Guo Ren <guoren@kernel.org>
Date: Fri, 19 Jun 2026 00:40:47 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
X-Gm-Features: AVVi8CcZhG0mWJZmtdZAhMmhoQz5zhsKhOiiURUGK7ccGb-9Zpcy9ToqnAL-Dt0
Message-ID: <CAJF2gTQqnpHPrE-df_kDZ-Y9g7sSfTQco3jKKnDzkuJfOEKmxQ@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: David Laight <david.laight.linux@gmail.com>
Cc: Vivian Wang <wangruikang@iscas.ac.cn>, zhangzhanpeng.jasper@bytedance.com, 
	alex@ghiti.fr, aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, 
	iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com, 
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 9:36=E2=80=AFPM David Laight
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
> It shouldn't need any locking but the accesses do need to be ordered.
Thank you for the suggestion. However, I believe this feedback is more
relevant to the RISC-V IOMMU HPM patchset [1], as no counter registers
are involved in the current patchset. That said, the idea of improving
the hi-lo-hi slow-path mechanism to better handle high-latency
hardware scenarios is well taken and worth discussing in the
appropriate thread.
[1]: https://lore.kernel.org/linux-riscv/20260208063848.3547817-2-zong.li@s=
ifive.com/

P.S. The hardware I have at hand exhibits very low interconnect
latency. And I have never observed the slow path where hi_tmp !=3D hi
being triggered =E2=80=94 my approach was to remove the retry mechanism
directly in 32-bit mmio mode and run stress tests to check whether
perf stat produced incorrect results. That said, I may have simply
been lucky instead of hw guarantee.

--=20
Best Regards
 Guo Ren
