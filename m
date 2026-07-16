Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC23D5663
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190226; cv=none; b=qcaF0/AcalmWtzgalRqCfTFStqDtGKPvwsu+hkJS7jfL7tOPnw9nZx9urlHJEgifT2+RxPMtAfSwXRfzov1g50K05qFfD8prOj/lY/RhGrgCIDUi2f5RFopIkId5AuhqEN1OoLvokV5W8E5rhZrhWyrkVMwOOUSHg27aQm0fdQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190226; c=relaxed/simple;
	bh=7eW+yjkKShr4UFe5cm7UUv/d8+LG95CprClzkvwKIvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z9AGr+sWJtnMsmzQ9KF/tN//KT93qKB0TqMObLffD5K82u7R5OcVhdjUz2HcvA/e4qkKto0UwvTJtPlMfjah85B17GnFj6HDCH2xHYeQNBtQYUSwNO4iv6g7Crnxo5M5XxfwCtiZQdAioDoUZa6aNSDxgVcM3z6xf2nbBLuL4MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WawRMKVG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WawRMKVG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9588F1F00ACF
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784190223;
	bh=7eW+yjkKShr4UFe5cm7UUv/d8+LG95CprClzkvwKIvs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=WawRMKVGQs14/iwKyxoNnO6BzMP/dxo2mb/nc0oDoEHYAWC6ffntPstfatHKCV9KA
	 0aNFxtZnuYITbUX9QZgblVJlY9pdlQ6Jiw6ohcbAscZQIfCe/W6r8TAzHD81S228XA
	 +d57qPhwM0ODrLueA7ZKoyWCMB+zv9WEx5KJZXpyi1DBRYZrVLmiVRq2S9RD3Wjkut
	 rN5SgLEudZSt8nq+gp0b1ekPvOHdeGyfEsZkuT1XzZHzUbmjfXEF0tK5w7dRlU7jL6
	 TEp1mkp852RgGznsH274PEGPVGNhrz49c8u0oMlTbe9avl7PHSg7rEAUrqXOaF6Xie
	 d85mAwfQkrF8g==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so22763185e9.2
        for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 01:23:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RragWbey2m7eeZfWyUAHW64iFBBky2L+m5m2TanMe+/5R+jC4bCi0WXVE35mK6ht8Ojs6nQxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzD9AtjOxu7M6mSU7V3LtHAveq8zcCcEfzzU7AzmLJg66OioU+O
	agvKR0aW6Z5KoSVB196z0OXq8i7fDSU9p+VUDrYMWEGdxXgMXGugpsldPuatZ4SsPuqLtrFw80k
	yFvHBMFF7Y7GzBhH2o7Lzs7vnZb04F74=
X-Received: by 2002:a05:600c:4f8a:b0:493:bcef:565c with SMTP id
 5b1f17b1804b1-493f87d5865mr214530245e9.1.1784190222056; Thu, 16 Jul 2026
 01:23:42 -0700 (PDT)
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
 <CAJF2gTSr5dCma3xgPdFpe9RNUg+V2U1io8_0tJWuCuCPFhWyfA@mail.gmail.com> <CANXhq0oVHw4JfGOrpUX=Hq6krm0myfCx7WhAG9rqZhuH0+D6kQ@mail.gmail.com>
In-Reply-To: <CANXhq0oVHw4JfGOrpUX=Hq6krm0myfCx7WhAG9rqZhuH0+D6kQ@mail.gmail.com>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 16 Jul 2026 16:23:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0ZkMfSQu+rKuD7m6LGouABH_RKSia544B7DeoidZFOg@mail.gmail.com>
X-Gm-Features: AUfX_my5b0EYRhcGArV6GlQb-nRgDj9jktauXWEqcujO1JMrwGtyDQk80VMTT_A
Message-ID: <CAJF2gTS0ZkMfSQu+rKuD7m6LGouABH_RKSia544B7DeoidZFOg@mail.gmail.com>
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

On Thu, Jul 16, 2026 at 2:59=E2=80=AFPM Zong Li <zong.li@sifive.com> wrote:
>
> On Thu, Jul 16, 2026 at 12:04=E2=80=AFPM Guo Ren <guoren@kernel.org> wrot=
e:
> >
> > On Thu, Jul 16, 2026 at 11:13=E2=80=AFAM Zong Li <zong.li@sifive.com> w=
rote:
> > >
> > > On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Chen Pei <cp0613@linux.alibab=
a.com> wrote:
> > > >
> > > > On Tue, Jul 14, 2026 at 09:55:19PM +0800, Guo Ren wrote:
> > > > > The specification is deliberately precise. It uses "may", not "sh=
all"
> > > > > or "must". We should not introduce speculative implications that =
break
> > > > > the spec's consistency on RV32. The safe and portable interpretat=
ion
> > > > > is that software is explicitly allowed to use 32-bit accesses for
> > > > > these registers on any system, which is exactly what this patch d=
oes.
> > > >
> > > > The RV32 argument is quite compelling. The RISC-V IOMMU is a
> > > > platform-level IP that must serve both RV32 and RV64 software stack=
s.
> > > > Mandating 64-bit MMIO accesses would directly conflict with RV32, w=
here
> > > > such accesses are impossible =E2=80=94 so any interpretation that t=
urns "may be
> > > > accessed using either a 32-bit or a 64-bit access" into an implicit
> > > > hardware requirement for 64-bit accesses breaks the spec's own
> > > > consistency on RV32.
> > > >
> > > > The RFC 2119 argument is equally strong. In RFC 2119 terms, "MAY" m=
eans
> > > > an item is truly optional =E2=80=94 a specification should express =
obligations
> > > > through these well-defined normative keywords, not leave them to be
> > > > inferred from everyday-language intuition. If the spec authors had
> > > > intended to require hardware to support 64-bit accesses, they would=
 have
> > > > said "must" or "shall".
> > > >
> > > > Given both points, treating 32-bit MMIO accesses as the default for=
 the
> > > > RISC-V IOMMU driver is the safe, portable, and more inclusive choic=
e: it
> > > > is explicitly permitted on every conformant implementation, whereas
> > > > 64-bit access atomicity is left unspecified.
> > > >
> > > > Acked-by: Chen Pei <cp0613@linux.alibaba.com>
> > > >
> > >
> > > It seems that we might not need to worry about RV32. The
> > > io-64-nonatomic-hi-lo.h header will automatically replace writeq/read=
q
> > > with hi_lo_writeq/readq in RV32 build. Therefore, perhaps we can just
> > > focus our discussion on RV64: whether the driver should use
> > > readq/writeq to access 64-bit registers on RV64 systems.
> >
> > The RV32 argument here concerns the interpretation of the
> > specification, not the Linux implementation. Some people interpret the
>
> Yes. However, since these patches are indeed trying to modify the
> Linux implementation, we might not need to worry about this here. On
> RV32, regardless of whether the IOMMU hardware supports native 64-bit
> MMIO accesses, Linux automatically uses two 4-byte accesses for 64-bit
> registers.

The RV32 argument highlights a logical inconsistency in interpreting
=E2=80=9CRegisters that are 64-bit wide may be accessed using either a 32-b=
it
or a 64-bit access=E2=80=9D as implying that hardware must support native
64-bit MMIO accesses.

Please note that an IOMMU is a platform-level device and is not
inherently tied to either RV32 or RV64. It may be accessed by any bus
master in the system. RV32 is cited here not to discuss how Linux
implements these accesses, but to demonstrate that an unconditional
requirement for the hardware to support native 64-bit MMIO accesses
would be logically inconsistent.


>
> > statement, =E2=80=9CRegisters that are 64-bit wide may be accessed usin=
g
> > either a 32-bit or a 64-bit access,=E2=80=9D as imposing an obligation =
on
> > every hardware implementation to support native 64-bit MMIO accesses.
> > However, RV32 provides a direct counterexample that undermines the
> > validity of this interpretation. The IOMMU is a platform-level
> > component that may be controlled either by an RV32 MCU running an RTOS
> > or by an RV64 processor running Linux. On an RV32 platform, software
> > can access a 64-bit register only through multiple 32-bit
> > transactions. How, then, can this sentence be interpreted as
> > unconditionally requiring the hardware to support native 64-bit MMIO
> > accesses?
> >
> > Moreover, even if =E2=80=9Cmay=E2=80=9D is interpreted in the RFC 2119 =
sense, MAY does
> > not impose a mandatory requirement. We should therefore avoid
> > inferring hardware obligations from assumptions or implications that
> > are not explicitly stated in the specification.
> >
> > >
> > > Actually, in my previous IOMMU PMU series, I shared a similar view to=
 Robin's:
> > > "Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> > > this might imply that the hardware itself will handle the split into
> > > two 4-byte accesses and internally manage its own trigger logic.
> > > Because of this, for RV64 systems, software might simply use standard
> > > 8-byte writes (e.g., writeq). Delegating the access handling to the
> > > hardware is likely the best way to maximize compatibility across all
> > > vendor implementations."
> > > More details: https://lists.infradead.org/pipermail/linux-riscv/2026-=
July/094099.html
> > >
> > > I also checked the GitHub discussions. The IOMMU spec author seems to
> > > have clarified that the hardware should be able to handle naturally
> > > aligned 64-bit accesses from the software.
> > > More details: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> > >
> > > From my perspective, since the author has already clarified the
> > > intent, it might be better for us to focus on improving and updating
> > > the spec to make it clearer. This could be a better approach than
> > > changing the driver to fit an unclear spec.
> > > What does everyone think about this? If we all agree, I would be happ=
y
> > > to send a new version of the IOMMU PMU series using 64-bit accesses
> > > again for RV64.
> >
> > This issue has already become highly contentious and directly affects
> > real hardware implementations. Any attempt to revise the specification
> > must first clarify whether the current wording actually mandates
> > support for 64-bit MMIO accesses. If the specification is unclear on
> > this point, then no such mandatory requirement can reasonably be
> > imposed on existing hardware implementations.
> >
>
> Yes, I agree. That is why I think we might focus on making the spec
> clearer before changing the driver. Would it make sense to continue
> the discussion on IOMMU spec GitHub? Perhaps reopen the same issue or
> create a new one.

I agree that the issue should be reopened. However, I do not think it
should necessarily block this patch, since it makes the driver use the
32-bit MMIO access path explicitly supported by the current
specification. The correctness of the patch can be reviewed based on
the required access ordering and register-specific semantics,
independently of the broader discussion about mandatory support for
64-bit MMIO transactions.

If the current specification does not clearly establish a mandatory
requirement for 64-bit MMIO accesses, any future clarification should
avoid retroactively invalidating existing implementations that were
built according to a reasonable reading of the current text.

If support for 64-bit MMIO transactions is intended to be optional,
that capability could be explicitly defined, along with an appropriate
mechanism for software to discover it.

Making such support unconditionally mandatory through a later
specification change would require careful consideration of the
compatibility impact on existing hardware.

--
Best Regards
 Guo Ren
