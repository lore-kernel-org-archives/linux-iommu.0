Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FA5358375
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 06:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784185176; cv=pass; b=lRXX1lpKMiTxL5e3qAA+rzUBUHfAZ4/ZHb4U4ZXafBWT+yJOJwg+JSePF6INAs34nrgErWi7LzP0J6R7YSwNS8S/YXseT+9xqysmE37MH0TCYdu/rXUcleYJJeovNKmg3TSXyGaXkMtlgvhqX1FpKcElchgEa0Y9PJRX9Xcc2f0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784185176; c=relaxed/simple;
	bh=rJEpjDlPs3yOQlXKQrAmfZ261we5xzkiCRUoBJBPTp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GDQ6whZxjkS0tozInRqWJQIlC3Tv+VFVwnYtXPPdoggntIRybhKMgx0M4SrPLZavv3Js7tl/aijQpGa2g43FvSGGMktd0Bt1SM6UlIypw7JW/fpelTYjsaRFjTd+8VsaNYIGFtmSfH0NXxaGMLM9RV2lrDLU4aML4+gpA6ogp6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=PW7KPftx; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="PW7KPftx"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69c7ab350e9so6986631a12.0
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 23:59:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784185173; cv=none;
        d=google.com; s=arc-20260327;
        b=TGzNLoYri2Tst2pM5ogmS0A3i/ETTh3zK3ioGnStjSiYyDuS/8/M52zdFnhcrk6954
         RZCThZjl1aFv3uuKyyBz2PDd1HbBdjGJousrhg+PVyC3TkaBOJN+TA1dz1hbDOHN2PgP
         wATpqdzVatLQqUZtDGLhGwm9SVEGepkEhhIOqalKGfdU5vHXk6eDTpyQFEr5vKZB2sxk
         GgfBIG86N1L/MVqEbeaLgnrn7j1S76wSGE7ZjLF29l6BSJddF8FUp2QBPqezLsI53uqp
         jKfB/431kIzkD+aiMBas5rAOT2tu5A8uWLePoai0tdBdj87AJKu+0wCdMZmgBaOMyd+c
         01uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k/t3c9uOY85dN4pWWCwyVJjxaFCEzSl5NE8E0QuBvs0=;
        fh=dV2xEiGmOKBnngpCz4s5mS0NqDh22xo3u+1HiatGE10=;
        b=EVsHcQd8UqgJdAmnGAjBLzp/U4I+89fI5m+oWe2NxqLMAhbRkyL4jWYVWWdvmO/ILS
         nBE2x0TWC5fsD6Iy1YExlg1PPCZLQiCyWCHZFBItShuDVyBC2Ea/cpqyCsRI43pgtDk4
         +z/ANOAQ2g63z2MQfhnmymkiVRAUbphBt3Q37SiprB8/efHHr2zgbffGD6JvM351LSVQ
         5IMYVVL1sldbEkP70PCSza/3YJ1WtCks+ZSD7KGOVaWg2UDL6oSUF2oOb8ERW+hfNkcV
         RZIp1JLDoLDxNsQ7oLl7R6RKT00cs/7gvkiyYUCg2xe4k0CshF8gdghFeT/2MZpBVnLt
         5tmQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784185173; x=1784789973; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/t3c9uOY85dN4pWWCwyVJjxaFCEzSl5NE8E0QuBvs0=;
        b=PW7KPftxogM3O7Z3d/k2fThwf6O9CQNFUZAMvpIUJZe5mpG+dYpIIks7cqGKzs8i8S
         PDx/YLLR5RUK8RKFcZZZnxJmctm1ZFLUTIIt74MbAYal8jTmTBNnAarQEHDuCLIXs103
         YRA7gSiy7oVptkaBxR5ua6KkgF1u/ID2IzKfhT6y8JPHfcSgihLfeRNNP6aNj1orqky5
         TgzdyH12WJe6TSJ+kQ+UsYiYqy/TQ8UDWtM8PWN6vWB1J7+KjQO5H+hp6pa8A0fTEs2q
         cyPg6HbOhGixs8TW1TtdRIO6+iuAXFtNn4RsgTKtq0XmXshpdBf8J0CUCz5IGxCX25MV
         2jAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784185173; x=1784789973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/t3c9uOY85dN4pWWCwyVJjxaFCEzSl5NE8E0QuBvs0=;
        b=a5MlTO0v+sbrkXf+cHOd3Msi1Ykp171yro6xbNlUwx5+O5zlfoi9h9iySabIZpcoWM
         WDTRYwxRtUdHxMfRKxDjNiOXnuxVxXcldeb4F5m4bouU96dbCXwVr0jlfFiQ2H+wCKGB
         OdGqXkCBgrAfjq39qpjDKeG3kO1KRqHv2PjcVDbl3qkDjpyA/z/6AJIw3CKOasSCWN//
         n1jb537Sa6RkMzcate1GGzKKWjRmCtyXYJRpe+rRiqnF/hAyjnqzygH0rvAjxWAKW6H7
         AdfD//4+ycwtf0AVLIIbS1by9nWhgV3TdP7VNguMrOCfOH0IF9fyVmXWTFmvX7olgI4d
         8raA==
X-Forwarded-Encrypted: i=1; AHgh+RouAwE0OrHXHmmCS/eUlwyAkdRAEzgA3XPy5ULjlmH32lUtInLdahuCVUj8s6Fas9gbMT69qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzajIeFNewnk/7G200cQvnI11YgjSP4ilTaFNIgPaUnVanBolNV
	dW/6ciOBUB6+r5IzfxvFKu7/xCaCnXphVa3+xCzKNfGJQAw7+/RfgnaHhuzp8F8NHCD3ETLScZ1
	XSKeRJJ86NBmy+tT8j2dfjmKx8YazawngaBz+qwo9QA==
X-Gm-Gg: AfdE7ckYHnV7q34Y6b075FUnuTDjyLv7M49tWxEWWwaQYq+zPFtWbF3+XIUczsNBNNK
	c5dDkpMGiB2Zz5EZ18OO779IsgXGiPYFkC4c6fkvsFgBMk4bSAE6Y9xrn5DbcGalIgS0WqsKw5x
	dMYjSnN4r/ISpdZ3qqU844su/AbRR3j0HrHd+O+ck1oSTFnm4ZeMbRU4yRpNTSRssXDwHnif5E7
	LmJgTH1UnKDY8n379XmzlyyKyHs42WQ1A575GdbadlNHeG8IuO+zNjV0Fhfc/FM
X-Received: by 2002:a05:6402:321e:b0:69a:a4bb:bfc0 with SMTP id
 4fb4d7f45d1cf-69e1987ff9bmr3583774a12.11.1784185172611; Wed, 15 Jul 2026
 23:59:32 -0700 (PDT)
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
 <CAJF2gTSr5dCma3xgPdFpe9RNUg+V2U1io8_0tJWuCuCPFhWyfA@mail.gmail.com>
In-Reply-To: <CAJF2gTSr5dCma3xgPdFpe9RNUg+V2U1io8_0tJWuCuCPFhWyfA@mail.gmail.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 16 Jul 2026 14:59:19 +0800
X-Gm-Features: AUfX_mzOjVgZ4_5LQ1KYd2JxiHtKW7wtejphZ8aGSbkl3NN2noLsgUgBxrHcdCQ
Message-ID: <CANXhq0oVHw4JfGOrpUX=Hq6krm0myfCx7WhAG9rqZhuH0+D6kQ@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Guo Ren <guoren@kernel.org>
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

On Thu, Jul 16, 2026 at 12:04=E2=80=AFPM Guo Ren <guoren@kernel.org> wrote:
>
> On Thu, Jul 16, 2026 at 11:13=E2=80=AFAM Zong Li <zong.li@sifive.com> wro=
te:
> >
> > On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.=
com> wrote:
> > >
> > > On Tue, Jul 14, 2026 at 09:55:19PM +0800, Guo Ren wrote:
> > > > The specification is deliberately precise. It uses "may", not "shal=
l"
> > > > or "must". We should not introduce speculative implications that br=
eak
> > > > the spec's consistency on RV32. The safe and portable interpretatio=
n
> > > > is that software is explicitly allowed to use 32-bit accesses for
> > > > these registers on any system, which is exactly what this patch doe=
s.
> > >
> > > The RV32 argument is quite compelling. The RISC-V IOMMU is a
> > > platform-level IP that must serve both RV32 and RV64 software stacks.
> > > Mandating 64-bit MMIO accesses would directly conflict with RV32, whe=
re
> > > such accesses are impossible =E2=80=94 so any interpretation that tur=
ns "may be
> > > accessed using either a 32-bit or a 64-bit access" into an implicit
> > > hardware requirement for 64-bit accesses breaks the spec's own
> > > consistency on RV32.
> > >
> > > The RFC 2119 argument is equally strong. In RFC 2119 terms, "MAY" mea=
ns
> > > an item is truly optional =E2=80=94 a specification should express ob=
ligations
> > > through these well-defined normative keywords, not leave them to be
> > > inferred from everyday-language intuition. If the spec authors had
> > > intended to require hardware to support 64-bit accesses, they would h=
ave
> > > said "must" or "shall".
> > >
> > > Given both points, treating 32-bit MMIO accesses as the default for t=
he
> > > RISC-V IOMMU driver is the safe, portable, and more inclusive choice:=
 it
> > > is explicitly permitted on every conformant implementation, whereas
> > > 64-bit access atomicity is left unspecified.
> > >
> > > Acked-by: Chen Pei <cp0613@linux.alibaba.com>
> > >
> >
> > It seems that we might not need to worry about RV32. The
> > io-64-nonatomic-hi-lo.h header will automatically replace writeq/readq
> > with hi_lo_writeq/readq in RV32 build. Therefore, perhaps we can just
> > focus our discussion on RV64: whether the driver should use
> > readq/writeq to access 64-bit registers on RV64 systems.
>
> The RV32 argument here concerns the interpretation of the
> specification, not the Linux implementation. Some people interpret the

Yes. However, since these patches are indeed trying to modify the
Linux implementation, we might not need to worry about this here. On
RV32, regardless of whether the IOMMU hardware supports native 64-bit
MMIO accesses, Linux automatically uses two 4-byte accesses for 64-bit
registers.

> statement, =E2=80=9CRegisters that are 64-bit wide may be accessed using
> either a 32-bit or a 64-bit access,=E2=80=9D as imposing an obligation on
> every hardware implementation to support native 64-bit MMIO accesses.
> However, RV32 provides a direct counterexample that undermines the
> validity of this interpretation. The IOMMU is a platform-level
> component that may be controlled either by an RV32 MCU running an RTOS
> or by an RV64 processor running Linux. On an RV32 platform, software
> can access a 64-bit register only through multiple 32-bit
> transactions. How, then, can this sentence be interpreted as
> unconditionally requiring the hardware to support native 64-bit MMIO
> accesses?
>
> Moreover, even if =E2=80=9Cmay=E2=80=9D is interpreted in the RFC 2119 se=
nse, MAY does
> not impose a mandatory requirement. We should therefore avoid
> inferring hardware obligations from assumptions or implications that
> are not explicitly stated in the specification.
>
> >
> > Actually, in my previous IOMMU PMU series, I shared a similar view to R=
obin's:
> > "Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
> > this might imply that the hardware itself will handle the split into
> > two 4-byte accesses and internally manage its own trigger logic.
> > Because of this, for RV64 systems, software might simply use standard
> > 8-byte writes (e.g., writeq). Delegating the access handling to the
> > hardware is likely the best way to maximize compatibility across all
> > vendor implementations."
> > More details: https://lists.infradead.org/pipermail/linux-riscv/2026-Ju=
ly/094099.html
> >
> > I also checked the GitHub discussions. The IOMMU spec author seems to
> > have clarified that the hardware should be able to handle naturally
> > aligned 64-bit accesses from the software.
> > More details: https://github.com/riscv-non-isa/riscv-iommu/issues/765
> >
> > From my perspective, since the author has already clarified the
> > intent, it might be better for us to focus on improving and updating
> > the spec to make it clearer. This could be a better approach than
> > changing the driver to fit an unclear spec.
> > What does everyone think about this? If we all agree, I would be happy
> > to send a new version of the IOMMU PMU series using 64-bit accesses
> > again for RV64.
>
> This issue has already become highly contentious and directly affects
> real hardware implementations. Any attempt to revise the specification
> must first clarify whether the current wording actually mandates
> support for 64-bit MMIO accesses. If the specification is unclear on
> this point, then no such mandatory requirement can reasonably be
> imposed on existing hardware implementations.
>

Yes, I agree. That is why I think we might focus on making the spec
clearer before changing the driver. Would it make sense to continue
the discussion on IOMMU spec GitHub? Perhaps reopen the same issue or
create a new one.

> --
> Best Regards
>  Guo Ren
