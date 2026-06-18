Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D453E6390
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776311; cv=none; b=XmORGx90VGLbgOESy1xjb8r4mwD+TtU8QoQhD6dd/zWI8qQThTVSRh9ZsMZRJJeJNFHKhTMsFDVKBnE6SKnilmEmjc5Z7VZUKuUVKdFQIVn1NGh0RVs7kyxvLHErSYhtAAZJfWwJlp7OZZbB76l3/HlL8CdiAZEzQBKPfVEskXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776311; c=relaxed/simple;
	bh=FQnRLrPkW5EQtEhmwTyQGrHFTaFRacfjuW2DKadWRJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aUajlb58++wo34hO2aM6dndMOh56wagNwHCf+WdYIRudH1q475qbTz92wszZ888CmDsjwbqBY+lzPulrTiVKSS7F/5iuCNV5RM/AK4oAWh/IysDwJy9GbqgbXoQRIi5TBE/Vbqx1c3jWRfHwCRx2YwnSdwOj98X0q8UCOfW+vkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpGm0ZjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpGm0ZjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9E51F01559
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 09:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781776309;
	bh=5WBnHo66G1Z7kP1ps9fkGG5FNnxRZK0tyCX5GLx+Nbo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cpGm0ZjSP3N4uwVtWpmuSnM96r5rT1Z5oKO2hL1HENahHADeiaMm9pJo+gw01emuo
	 i/J1Cr0v7nhzFy8/Lanpia9/aDWf67Mb6iryXe8fOyGmV7NgAbD4d6ChQTaPLMGQii
	 16NZoKXmGboUa9jKqUOwZCohs2je7MChs4/S3SoLqRS8tL326Y3fC6LiBWiEngRdIW
	 MIQVY7AG0TqjEdWdxKaU2eMCQnILvhuFWc7KYvLbp4Pjj1u+rFdXhHk3mgTzCoVHig
	 TR1QuhVddbePIszIIBQ0mh0CF4zqBQt2NxeuJvkpGmrpcddnI8xlUE1ILT4h7zGZm2
	 za1UTEkafDgpg==
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4631679f204so778339f8f.0
        for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 02:51:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/jAML6kYkoJ0GM6MmJ8msgdojGaVe0BuLZxgZsGbgFa5l4tX2ekEUvvB6nbImPwS1csLv3Ag==@lists.linux.dev
X-Gm-Message-State: AOJu0YyKYnWfnq/uPGMeD32laiDHwnSlV8/CtmL2wZZEZSl7mPQEx2KD
	cFhQYcgFpfpkSoYB01GPPjU6AvGpPDfOo0bfvI1fgOpqWrM+foXb6tOCT5My3uKkXdiR3Xet4IC
	Of8TbEScqrbIYirUJ25llqkgnzBPY7Cs=
X-Received: by 2002:a5d:5651:0:b0:461:a15a:4160 with SMTP id
 ffacd0b85a97d-463978b2374mr3919774f8f.13.1781776307962; Thu, 18 Jun 2026
 02:51:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260615123821.373248-1-guoren@kernel.org> <7c490aeb-a3d9-4fe9-81de-f9662577851d@iscas.ac.cn>
 <CAJF2gTQ+-gpvUDtOh99aKP2-iDJy3MYOWti9k2Ntd0-J0MXqxQ@mail.gmail.com> <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
In-Reply-To: <e051d822-d0be-4a88-ba86-ec9b5905fd1e@iscas.ac.cn>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 18 Jun 2026 17:51:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
X-Gm-Features: AVVi8CcuSWc4MKvQ8rcvmy1iBZVy1e7sFg0-ZToAG3k3v5HDIXUflW0rEu43oHo
Message-ID: <CAJF2gTRH6x78A3J5HJ5kUM47aDv8R0yFr8LRP+7jiLX4GL3ssg@mail.gmail.com>
Subject: Re: [PATCH v1] iommu/riscv: Support 32-bit register accesses
To: Vivian Wang <wangruikang@iscas.ac.cn>, zhangzhanpeng.jasper@bytedance.com
Cc: alex@ghiti.fr, aou@eecs.berkeley.edu, cuiyunhui@bytedance.com, 
	iommu@lists.linux.dev, joro@8bytes.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, luxu.kernel@bytedance.com, 
	palmer@dabbelt.com, pjw@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, will@kernel.org, yuanzhu@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vivian,

As noted in the RISC-V IOMMU Specification, Chapter 6:
> Whether an 8-byte access to an IOMMU register is single-copy atomic is UN=
SPECIFIED, and such an access may appear, internally to the IOMMU, as if tw=
o separate 4-byte accesses =E2=80=94 first to the high half and second to t=
he low half =E2=80=94 were performed.

Therefore, the atomicity of 64-bit MMIO accesses is UNSPECIFIED and
not clearly defined in the current ratified RISC-V IOMMU
specification. To handle this correctly, the Linux RISC-V IOMMU driver
should fall back to 32-bit MMIO accesses when reading 64-bit registers
(e.g., performance counters). The behavior of 32-bit MMIO accesses is
more precisely defined in the RISC-V IOMMU specification.

Thus, many hardware vendors implement 32-bit MMIO (rather than 64-bit
MMIO) based on the current ratified RISC-V IOMMU specification, and
this driver does not appear to benefit from 64-bit MMIO access either.
Performance is fundamentally constrained by bus latency; assuming that
simply reducing the number of accesses will improve performance is an
oversimplification that ignores the underlying hardware
characteristics.

Hi Zhang,

The hardware targeted by the 32-bit MMIO access in your patch is
precisely the kind that deserves the official ACPI HID RSCV0004 and
Devicetree compatible string (riscv,iommu). It is rather the hardware
that supports only 64-bit MMIO access =E2=80=94 whose atomicity is explicit=
ly
left as UNSPECIFIED by the RISC-V IOMMU specification =E2=80=94 that should=
 be
relegated to a non-standard ACPI ID. That is what truly constitutes
poor hardware design.

I will consistently support your position of adopting 32-bit MMIO
access in this patch, and will advocate for making it the default
behavior in the Linux RISC-V IOMMU driver, as it better aligns with
the intent of the RISC-V IOMMU specification.

--
Best Regards
 Guo Ren

On Thu, Jun 18, 2026 at 3:33=E2=80=AFPM Vivian Wang <wangruikang@iscas.ac.c=
n> wrote:
>
> On 6/18/26 11:45, Guo Ren wrote:
> > On Thu, Jun 18, 2026 at 11:20=E2=80=AFAM Vivian Wang <wangruikang@iscas=
.ac.cn> wrote:
> >> On 6/15/26 20:38, Guo Ren wrote:
> >>> Hi Zhanpeng Zhang,
> >>>
> >>> I noticed you posted a similar fix recently. However, I had already
> >>> submitted a similar solution back in September 2025 [1]. It would be
> >>> great if you could review it. A few concerns with the current patch:
> >>>
> >>> 1. Using spin_lock_irqsave in such a small semantic structure is
> >>> unnecessary. IRQ protection should be provided by the higher-level
> >>> IOMMU driver interfaces. Many existing call sites already handle IRQ
> >>> disabling, so adding it here feels redundant and adds avoidable
> >>> overhead.
> >>>
> >>> 2. More critically, the RISCV_IOMMU_32BIT_ACCESS Kconfig option is
> >>> problematic. According to the RISC-V IOMMU specification (Software
> >>> Guidelines, =E2=80=9CReading and writing IOMMU registers=E2=80=9D):
> >>>
> >>>> Registers that are 64-bit wide may be accessed using either a 32-bit
> >>>> or a 64-bit access.
> >>> This clearly requires that any hardware supporting 64-bit MMIO access
> >>> must also support 32-bit MMIO access. Therefore, the IOMMU driver sho=
uld
> >>> be built on a 32-bit access base for maximum hardware compatibility.
> >> I agree that the driver should be build with 32-bit accesses to suppor=
t
> >> these hardware. However there's one minor thing that I want to propose
> >> regarding this, for the sake of clarity:
> >>
> >> RISC-V IOMMU implementations that do not support 64-bit accesses are n=
ot
> >> fully compliant with the RISC-V IOMMU specification and should not use
> >> the standard RISC-V identifiers, namely:
> >>
> >> - Devicetree compatible riscv,iommu
> >> - ACPI HID RSCV0004
> >>
> >> This, in my opinion, is not only the right thing to do (not claiming t=
o
> >> be standard hardware without actually being standard hardware), but al=
so
> >> saves a lot of trouble for operating system developers (yes, there are
> >> RISC-V operating systems other than Linux out there), since invalid IO
> >> accesses usually manifest as mysterious access faults (that would
> >> usually suggest an incorrect IOMMU address), or worse, system hangs.
> >>
> >> I would appreciate if the hardware vendors shipping 32-bit-access-only
> >> IOMMUs would consider this.
> >>
> >> Vivian "dramforever" Wang
> >>
> > 32-bit MMIO access is explicitly supported by the RISC-V IOMMU
> > specification and is a valid choice (64-bit MMIO access is optional).
>
> Hmm... I think it's optional in software but not optional in hardware,
> but the specs are not super clear on this. I've opened a GitHub issue to
> ask:
>
>     https://github.com/riscv-non-isa/riscv-iommu/issues/765
>
> > 64-bit MMIO access is not "free" =E2=80=94 it consumes additional inter=
connect
> > hardware resources.
> >
> > Could you elaborate on the concrete benefit of using 64-bit MMIO
> > access in this driver, for these non-PMU registers? A clear
> > justification would help evaluate whether the trade-off is worthwhile.
> >
> >
>
