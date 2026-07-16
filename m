Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90BD2EEE6C
	for <iommu@lists.linux.dev>; Thu, 16 Jul 2026 03:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784171622; cv=pass; b=YN8jyvH66GUye/mEiEfW0CJxTLuMZ37XLHISogqURAvUMtshoraM5Y/OtAIDnETANYFSAEjylKd93FGnljx5UyE9a1GBFZDlOpz1PtnxcaJqtPCYQtL8QbYOfmmvqf6J0zfAISNNZS08hyAIwMyc+V58GullY9J9WJUHaiD4l90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784171622; c=relaxed/simple;
	bh=UM2OezOyRvHBevtE0lxLMLuRathg1UInDTjZPXP8nn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=umDG4ZktQT79QDbivF/A6rmU9uLQ46gBF/y+EZ5+gQPo0TNyny96//D6D930CuMNEvX+zbbbj2l2VLnuXDny8ucFsCP4QHjKzivV12pUh4QnGXu9Da6flB+Gq59u0qJFQhH2zTjCXlHfvmr8Q3PVnzBTnU88S2hOzPX+dOMfGVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=RDV1eWxf; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RDV1eWxf"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c5fda04a8so9544223a12.1
        for <iommu@lists.linux.dev>; Wed, 15 Jul 2026 20:13:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784171619; cv=none;
        d=google.com; s=arc-20260327;
        b=nc5cLKH7aocNRujTUhmhAmOiAyUd+jcjCi9nx71b3KnCARwaljNuwwH0aOeMDTqQIN
         BHSuq+/rSZPk+Ral1tQs90hrgO2C+FkGanbcQ89g3+jfjVsyGrb5ljp2MUDWtD7eEx3X
         v8p0YzIj58PGVliwzmqENon9WQ0sRTKxlXS0JXM7Zg/JAg4qXJBgsDcRviMS+DqpGvJ8
         6ZDYl+pBSkUYDsP5uuxhGTL/0Kfuw0j4mib5FihpVHULjFGzao3i3/ePG1SEO4vlkGo+
         Ifb1kI8ay3z7BaYZxDDbGZAzGuq9GBeaCezAUMdeYoUc9dCTQDBcV5luZMXUreg34b2c
         jroQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UM2OezOyRvHBevtE0lxLMLuRathg1UInDTjZPXP8nn0=;
        fh=BSwWxPb2Y5SIP4MJkSxWcVztUl9cOCLqhU1D5zl/ujQ=;
        b=LzKsi3xL6SLNUh8HJRyzyIHsEe16JVLJ1T/NLF4SD/vKLOAhTCgG4m/ZZbOz/A1kLk
         aPQuDEk5qreL0mKAUqbYt2Q1aTMkvavDpGD+dczQOa6g6X078nSQuanJQvR2jdMijBwY
         CvFh3weeOT7KpQ9ywWEorsUNGsbhRODujaQi4DywPM1UDxOUU0yzNyQ2DcLBRQRP3xcF
         dc0lLCU1vFP27JI5sj7QJN2xA8amQ5qeQUQH6iz61aoOK/ckiaWYGZCR1ujBWfeP9i+W
         JJLybvOh2U9bBUwFqT9bs09wRZjYPUHG4c2CYNlWEh0Crc7K+5sjjQ30bvEiOTdjevJA
         xO3g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1784171619; x=1784776419; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UM2OezOyRvHBevtE0lxLMLuRathg1UInDTjZPXP8nn0=;
        b=RDV1eWxfYlZ+DBfrkdcoK3LTMibPTc4GvXULyZi/cxCb2HD3FhrEkwOhUmIGQA/n4m
         WThQpMX3cnq97xw3UWcnujx4xOAEjsryzn8dzhke4ZxdPPdKe/E+WUwY8F6jPLQIh6jY
         UkDQZAURKij1z66kmL1n+g0qrBiHxOylQw7b+vRxUyGViU9ebYJXyxatcDna2mkvQstP
         gtWYozUZ0bNodYUaautQ8YnKHNaPGs7fvjH4Ow0OLo4X8LcLNKTyNV537qvYUDHg6L/F
         yvxGM1jLtKZDx5VKB9elG9n3au6ItpD41I0u1i3sLHOkPXlMTJsfC3uOAJlM17qKkN3E
         mFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784171619; x=1784776419;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UM2OezOyRvHBevtE0lxLMLuRathg1UInDTjZPXP8nn0=;
        b=kbYcORXgu7WADj94polcR2mU4WWpM8LCp3/fKn4u664IDlxjHYPnJymY2foYZNgAx3
         LwoUrDkKn5qpa60pB1UOXiyoNKS1LEMLWDPn7xqBiByit59MUR60pynkryQWplGhu2Qn
         UFTXTAe3lwqKiqm8dCiHz3JaLHVIyt2wvIjYOhOjm4nvGf6BchkPR9NcDow9K/r/q2jh
         UcpvUIYfyztLEyErJtBIZxBnuV/BafdAngWAEethooptmDgiiNuYV2mOMnWCUoo/1F0T
         uzvdJObdI3xxnhTcF7xtSPuR069LASn1TM3ouEr66Gerjx9EuC/Pm27SFfqlCrcXF0aL
         1A2Q==
X-Forwarded-Encrypted: i=1; AHgh+RooIHUDQmJqXp6xBEqtX6lY80QeHGze5FtKC+4StAt/CUTKINNZw37F5rLyn+y+nDMiqXgX+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz+6DF5AY8R6N+sgfTz4tbgE/993/gpOyfKAmVeDm0mo9EQTjm
	DW+U9goaJvFx/mezIstIgysw+dJ+rHwlMN96F0gkMD0YHicRacV7CiKIacIUmO4n+G4jkQhsQ0N
	YPBg343T+xZlAgcq7dLpodJyg16vHJnGndvR6l5CtZA==
X-Gm-Gg: AfdE7cm6uNI1vv71fnnhxlNzlmfO1/g9GRzkA87A5BgPRS/m/P8DlnxznZlR3BpUxfU
	3nDpem5qglxGeyaNL16Df/5cSe13hmgzG2q62Rp+4fqrlOZJYBICStmP4+KUeiQ4uPKwz6wCoGf
	JPUouUSlz0Hw7ul4S4Ttr39r0crCVy4qvoiCoXiiPy6HX5kVDlgCfRCTjt3B2qT9VWynfqFnZFK
	JZHzLHZYRuUGxGEceUL4hmQiYIFsUVEtYFKO+ZcqiBfQpPsFB0OQMMAoqLGTZh9
X-Received: by 2002:a05:6402:d0e:b0:697:d475:9692 with SMTP id
 4fb4d7f45d1cf-69cd2a0067cmr5743576a12.11.1784171619065; Wed, 15 Jul 2026
 20:13:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260615064855.90316-1-zhangzhanpeng.jasper@bytedance.com>
 <20260713122903.9458-1-zhangzhanpeng.jasper@bytedance.com>
 <3591a185-d0b5-4cb0-a0d5-ae9608a4e244@arm.com> <CAJF2gTT7TPA+K+JgkvvUtb0x5BSzfox+s5rG8OtrP0QzPetHFw@mail.gmail.com>
 <20260715094305.2783-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260715094305.2783-1-cp0613@linux.alibaba.com>
From: Zong Li <zong.li@sifive.com>
Date: Thu, 16 Jul 2026 11:13:28 +0800
X-Gm-Features: AUfX_mwSlLuBkXLYWkCx82Cd69Su-eA8XLoXsfXduJDZmMHngIn0tQiburCm1Ms
Message-ID: <CANXhq0pvrXDJyE_dA-3z2tHnVndvxOm7kLRvnF9T+_r8cUHXug@mail.gmail.com>
Subject: Re: [PATCH v3] iommu/riscv: Use 32-bit MMIO accesses for 64-bit registers
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: Guo Ren <guoren@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
	Tomasz Jeznach <tomasz.jeznach@linux.dev>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	David Laight <david.laight.linux@gmail.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	cuiyunhui@bytedance.com, yuanzhu@bytedance.com, iommu@lists.linux.dev, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 5:43=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com>=
 wrote:
>
> On Tue, Jul 14, 2026 at 09:55:19PM +0800, Guo Ren wrote:
> > The specification is deliberately precise. It uses "may", not "shall"
> > or "must". We should not introduce speculative implications that break
> > the spec's consistency on RV32. The safe and portable interpretation
> > is that software is explicitly allowed to use 32-bit accesses for
> > these registers on any system, which is exactly what this patch does.
>
> The RV32 argument is quite compelling. The RISC-V IOMMU is a
> platform-level IP that must serve both RV32 and RV64 software stacks.
> Mandating 64-bit MMIO accesses would directly conflict with RV32, where
> such accesses are impossible =E2=80=94 so any interpretation that turns "=
may be
> accessed using either a 32-bit or a 64-bit access" into an implicit
> hardware requirement for 64-bit accesses breaks the spec's own
> consistency on RV32.
>
> The RFC 2119 argument is equally strong. In RFC 2119 terms, "MAY" means
> an item is truly optional =E2=80=94 a specification should express obliga=
tions
> through these well-defined normative keywords, not leave them to be
> inferred from everyday-language intuition. If the spec authors had
> intended to require hardware to support 64-bit accesses, they would have
> said "must" or "shall".
>
> Given both points, treating 32-bit MMIO accesses as the default for the
> RISC-V IOMMU driver is the safe, portable, and more inclusive choice: it
> is explicitly permitted on every conformant implementation, whereas
> 64-bit access atomicity is left unspecified.
>
> Acked-by: Chen Pei <cp0613@linux.alibaba.com>
>

It seems that we might not need to worry about RV32. The
io-64-nonatomic-hi-lo.h header will automatically replace writeq/readq
with hi_lo_writeq/readq in RV32 build. Therefore, perhaps we can just
focus our discussion on RV64: whether the driver should use
readq/writeq to access 64-bit registers on RV64 systems.

Actually, in my previous IOMMU PMU series, I shared a similar view to Robin=
's:
"Revisiting the spec regarding the UNSPECIFIED 8-byte atomic access,
this might imply that the hardware itself will handle the split into
two 4-byte accesses and internally manage its own trigger logic.
Because of this, for RV64 systems, software might simply use standard
8-byte writes (e.g., writeq). Delegating the access handling to the
hardware is likely the best way to maximize compatibility across all
vendor implementations."
More details: https://lists.infradead.org/pipermail/linux-riscv/2026-July/0=
94099.html

I also checked the GitHub discussions. The IOMMU spec author seems to
have clarified that the hardware should be able to handle naturally
aligned 64-bit accesses from the software.
More details: https://github.com/riscv-non-isa/riscv-iommu/issues/765

From my perspective, since the author has already clarified the
intent, it might be better for us to focus on improving and updating
the spec to make it clearer. This could be a better approach than
changing the driver to fit an unclear spec.
What does everyone think about this? If we all agree, I would be happy
to send a new version of the IOMMU PMU series using 64-bit accesses
again for RV64.

> Thanks,
> Pei
>
