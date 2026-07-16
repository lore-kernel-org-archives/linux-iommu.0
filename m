Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312E3815DF
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 04:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784174672; cv=none; b=CgeB/IHDQbkCSL1A7yTqfDHIDWGP0vIgEL9RghP5yfLnTkCzTC9Z25PnRiTStsXI5bScBdcbvmDfiVQghvUX+KsYllvHrvF6vTKnxAjDHN2mP/spfHXGD7I/TOEeh2TT2JamYDoBtWiMwQE76XrX70RMdWCkxgAu4QmCzsWVH7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784174672; c=relaxed/simple;
	bh=Fg94SJn9u78gDw8siCO7WM02w6Epyqex4JqIlKwaAzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Da6O/Lh2As6idUGUgaOrcokHJnVDa+OtyTRMXaLEK4CnKFD6lAPTZ1VV2HyR/kMkt5vJrIeju7XnnnJNZp53h7Qh6d+XyL11smCIuiWYsAvMY0Z6FvcqZvj1KaR1nBEPTyCbyyIAwS1fg9Gk5f+GGQxWE2aWheahFjKvXRLG6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiCEY2Zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiCEY2Zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476291F00AC4
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 04:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784174671;
	bh=Fg94SJn9u78gDw8siCO7WM02w6Epyqex4JqIlKwaAzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aiCEY2ZnI36PlbsS0Dnca0aUGUuB93v2+rNSdP7sTvxx63CkeSiJun7SJ9/pa6cYV
	 N+wQCTB2GC0K/u/xrCu7m7SWlK9wT4iFGM++K4vDlZJfNWvOsRL1gcv2Ayul0pSWDE
	 JR+8uISKgcGnS/90no5aTvzy6nAD2+OmxoGrNadSbXmTdwA5GZ5GrCGtjt/NW98kye
	 GC8pzxeQ56DIeKU7w9rnAM3inE0xMvO5rcSZ9Y9oart1PHbcWu1/9QZvdtcKvuOZKY
	 EGbjr9aucS1hsb6DVbxSrwksi5TdT6OkkxXFhBqolcVG03Cr8rlZ9DBvlV8IjJKw38
	 9mjRFv2wReTIQ==
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so4504402f8f.2
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 21:04:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rr1YkYYRG1LUx2k6awm419nfUcXFZdyr9wy6BCG7T3KS77Bct1q4sJRYOk8RsszCq2nAJhouw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxphZfpAUQegNUxUec0deFQ3tSBdjR7fNCmsKpPtpmn4wUH5lID
	Xv2m+qe5HNTXRz0+k1BVMnsZR6VsK9lMSGYEpU8fReumw6382Qzj8LXIsSjpPmBQXxXS+A5xcQK
	n+CzHbRVuyDdQAzvRYHp3vUathjOdqMw=
X-Received: by 2002:a05:6000:2dc7:b0:46a:8fab:eb44 with SMTP id
 ffacd0b85a97d-47f4fcc818bmr6139658f8f.1.1784174669875; Wed, 15 Jul 2026
 21:04:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
 <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com> <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
 <20260715094305.2783-1-cp0613@linux.alibaba.com> <CANXhq0pvrXDJyE_dA-3z2tHnVndvxOm7kLRvnF9T+_r8cUHXug@mail.gmail.com>
In-Reply-To: <CANXhq0pvrXDJyE_dA-3z2tHnVndvxOm7kLRvnF9T+_r8cUHXug@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 16 Jul 2026 12:04:16 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSr5dCma3xgPdFpe9RNUg+V2U1io8_0tJWuCuCPFhWyfA@mail.gmail.com>
X-Gm-Features: AUfX_mysGsAvg7iNzvdRvGw-pNaOqcW0q9z1nRCbVt3xaj4MNFhD3CndE7GiKE0
Message-ID: <CAJF2gTSr5dCma3xgPdFpe9RNUg+V2U1io8_0tJWuCuCPFhWyfA@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Zong Li <zong.li@sifive.com>
Cc: Chen Pei <cp0613@linux.alibaba.com>, Robin Murphy <robin.murphy@arm.com>, 
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 11:13=E2=80=AFAM Zong Li <zong.li@sifive.com> wrote=
:
>
> On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.co=
m> wrote:
> >
> > On Tue, Jul 14, 2026 at 09:55:19PM +0800, Guo Ren wrote:
> > > The specification is deliberately precise. It uses "may", not "shall"
> > > or "must". We should not introduce speculative implications that brea=
k
> > > the spec's consistency on RV32. The safe and portable interpretation
> > > is that software is explicitly allowed to use 32-bit accesses for
> > > these registers on any system, which is exactly what this patch does.
> >
> > The RV32 argument is quite compelling. The RISC-V IOMMU is a
> > platform-level IP that must serve both RV32 and RV64 software stacks.
> > Mandating 64-bit MMIO accesses would directly conflict with RV32, where
> > such accesses are impossible =E2=80=94 so any interpretation that turns=
 "may be
> > accessed using either a 32-bit or a 64-bit access" into an implicit
> > hardware requirement for 64-bit accesses breaks the spec's own
> > consistency on RV32.
> >
> > The RFC 2119 argument is equally strong. In RFC 2119 terms, "MAY" means
> > an item is truly optional =E2=80=94 a specification should express obli=
gations
> > through these well-defined normative keywords, not leave them to be
> > inferred from everyday-language intuition. If the spec authors had
> > intended to require hardware to support 64-bit accesses, they would hav=
e
> > said "must" or "shall".
> >
> > Given both points, treating 32-bit MMIO accesses as the default for the
> > RISC-V IOMMU driver is the safe, portable, and more inclusive choice: i=
t
> > is explicitly permitted on every conformant implementation, whereas
> > 64-bit access atomicity is left unspecified.
> >
> > Acked-by: Chen Pei <cp0613@linux.alibaba.com>
> >
>
> It seems that we might not need to worry about RV32. The
> io-64-nonatomic-hi-lo.h header will automatically replace writeq/readq
> with hi_lo_writeq/readq in RV32 build. Therefore, perhaps we can just
> focus our discussion on RV64: whether the driver should use
> readq/writeq to access 64-bit registers on RV64 systems.

The RV32 argument here concerns the interpretation of the
specification, not the Linux implementation. Some people interpret the
statement, =E2=80=9CRegisters that are 64-bit wide may be accessed using
either a 32-bit or a 64-bit access,=E2=80=9D as imposing an obligation on
every hardware implementation to support native 64-bit MMIO accesses.
However, RV32 provides a direct counterexample that undermines the
validity of this interpretation. The IOMMU is a platform-level
component that may be controlled either by an RV32 MCU running an RTOS
or by an RV64 processor running Linux. On an RV32 platform, software
can access a 64-bit register only through multiple 32-bit
transactions. How, then, can this sentence be interpreted as
unconditionally requiring the hardware to support native 64-bit MMIO
accesses?

Moreover, even if =E2=80=9Cmay=E2=80=9D is interpreted in the RFC 2119 sens=
e, MAY does
not impose a mandatory requirement. We should therefore avoid
inferring hardware obligations from assumptions or implications that
are not explicitly stated in the specification.

>
> Actually, in my previous IOMMU PMU series, I shared a similar view to Rob=
in's:
> "Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> this might imply that the hardware itself will handle the split into
> two 4-byte accesses and internally manage its own trigger logic.
> Because of this, for RV64 systems, software might simply use standard
> 8-byte writes (e.g., writeq). Delegating the access handling to the
> hardware is likely the best way to maximize compatibility across all
> vendor implementations."
> More details: https://lists.infradead.org/pipermail/linux-riscv/2026-July=
/094099.html
>
> I also checked the GitHub discussions. The IOMMU spec author seems to
> have clarified that the hardware should be able to handle naturally
> aligned 64-bit accesses from the software.
> More details: https://github.com/riscv-non-isa/riscv-iommu/issues/765
>
> From my perspective, since the author has already clarified the
> intent, it might be better for us to focus on improving and updating
> the spec to make it clearer. This could be a better approach than
> changing the driver to fit an unclear spec.
> What does everyone think about this? If we all agree, I would be happy
> to send a new version of the IOMMU PMU series using 64-bit accesses
> again for RV64.

This issue has already become highly contentious and directly affects
real hardware implementations. Any attempt to revise the specification
must first clarify whether the current wording actually mandates
support for 64-bit MMIO accesses. If the specification is unclear on
this point, then no such mandatory requirement can reasonably be
imposed on existing hardware implementations.

--
Best Regards
 Guo Ren
