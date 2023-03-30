Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79021C2E0
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 07:31:41 +0000 (UTC)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5416698e889so339487687b3.2
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 00:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680161500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LxN0r0AhgneifQhzqL4mjT7JfsmxnYyFrUEJ452tNfU=;
        b=wcWk3K43uOF7o+/DIraGqiorCACro1j3xHUjEgSCNMh1nSNigrWFd3KWgLF6Npz43Y
         bgwYIfbfHBeCpXwyftFfGN+deF0HkE+Fn26sPrUbcGvA35GXa9FZakqYJj8/1OYDbtGC
         IiFxcfV1eM3vZaU+7nIjXyRVhkqKpjCKtfeMKIsMecFdxASceDajmUFMaDuxYrmQ2FRV
         HhTEkdSSShQF/mkNz1szuVTok+6Xk8SRcCE5EKMgRWT6qUWK9zyYiDbncRKsS6mQpBuZ
         XYzsX4rLP7qT9YAtZBNSIiZCCQUYGzvfAoGndyJ+swG6OM0bxh4BcKWmHBwkS1LPGoHS
         VVJQ==
X-Gm-Message-State: AAQBX9eHXK8GmydsTvw8EcdqTyf+Gq20V7uZPC9W3Zdkq5ij2db/lLcf
	e4spJTNPbMB1GmJ6upPA2dHR6OOLZSYbng==
X-Google-Smtp-Source: AKy350aj6+Aw21snG7iT5mfN6oIKP6Weu106dLXUOpZuHHSjAcCa2+Emv9yB/sach//l7Twjda3mcw==
X-Received: by 2002:a81:1b46:0:b0:52e:ff80:3287 with SMTP id b67-20020a811b46000000b0052eff803287mr4801281ywb.9.1680161500113;
        Thu, 30 Mar 2023 00:31:40 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id e66-20020a811e45000000b00545a08184a8sm3394010ywe.56.2023.03.30.00.31.39
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:31:39 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id p203so22331374ybb.13
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 00:31:39 -0700 (PDT)
X-Received: by 2002:a25:1185:0:b0:a27:3ecc:ffe7 with SMTP id
 127-20020a251185000000b00a273eccffe7mr2687305ybr.3.1680161499271; Thu, 30 Mar
 2023 00:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230330060105.29460-1-rdunlap@infradead.org> <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
In-Reply-To: <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Mar 2023 09:31:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
Message-ID: <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Thu, Mar 30, 2023 at 8:25=E2=80=AFAM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
> > On riscv64, linux-next-20233030 (and for several days earlier),
> > there is a kconfig warning:
> >
> > WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >   Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST=
 [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >   Selected by [y]:
> >   - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] |=
| COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >
> > and build errors:
> >
> > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140':
> > io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io_p=
gtable_ops'
> > riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168':
> > io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_pg=
table_ops'
> > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> > ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_ops=
'
> > riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> > ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable_o=
ps'
> >
> > Add RISCV as an allowed ARCH dependency to fix these problems.
> >
> > Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: iommu@lists.linux.dev
> > Cc: Conor Dooley <conor@kernel.org>
> > Cc: linux-riscv@lists.infradead.org
> > ---
> >  drivers/iommu/Kconfig |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> > --- a/drivers/iommu/Kconfig
> > +++ b/drivers/iommu/Kconfig
> > @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
> >  config IOMMU_IO_PGTABLE_LPAE
> >       bool "ARMv7/v8 Long Descriptor Format"
>
> I'm probably missing something here, but why would we want to enable
> "ARMv7/v8 Long Descriptor Format" on RISC-V?

Indeed, we should not enable it, unless compile-testing.

> Would it not be better to make the Renesas depend on, rather than
> select the option? It does seem highly arch specific, and I feel like
> Geert previously mentioned that the RZ/Five (their RISC-V offering)
> didn't use it.

I think the IPMMU_VMSA dependency should gain

        depends on ARM || ARM64 || COMPILE_TEST

> >       select IOMMU_IO_PGTABLE
> > -     depends on ARM || ARM64 || COMPILE_TEST
> > +     depends on ARM || ARM64 || RISCV || COMPILE_TEST
> >       depends on !GENERIC_ATOMIC64    # for cmpxchg64()
> >       help
> >         Enable support for the ARM long descriptor pagetable format.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
