Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFEC8835
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 16:12:02 +0000 (UTC)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-54184571389so363270387b3.4
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 09:12:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680192721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ASMwRAXSxQ56uzRQV9rpj0YNrKR/hLF/lFweUlSAcY=;
        b=GeUrQrmlmFTtlXpuyxVuPpfhWtJlWHeKUtUFcI48bhPcvQX2BzK0jkbqSSbDboRX5W
         aexTfC8J9DmqvEgC24OFNL5h4ZGjGD+UteF/NhjNI7WOmmis+K5Vyf45tVRur/5D/Ozu
         QK1K8UI3nleNziy4fVhPeSjXeO2JFs1OchtC9haSqfuHSA+T9p8ifr5be8F7zMG0c9ep
         YscSX+Q+0FWZ+wD+LEOgCNN4qt6F/RCMgtVbU5kb1YaRQVJolxqIka8XZr97fZtWpyxU
         3tmMMckQayS7qsSSBHW+9u8uy3liukcqkYieOt/+669+HHq4eSZi8icZxpO3yzBnGKq0
         FaKw==
X-Gm-Message-State: AAQBX9em04JJsuknvjodx2SL0w7kNdfCGjtKzzfQDpecEK99i+k8uieF
	vGTBIc2EalEOSlKzpdEWPgbSTQf9bR4YiaE7
X-Google-Smtp-Source: AKy350bckPXowusi8floZvEUGfCP4AHHR13qbjC06w9vNPvhT79OFDW7Y6OFmhEa4/kjfMp+q0oshQ==
X-Received: by 2002:a0d:dd0a:0:b0:545:64b3:3941 with SMTP id g10-20020a0ddd0a000000b0054564b33941mr24199549ywe.26.1680192720960;
        Thu, 30 Mar 2023 09:12:00 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id df15-20020a05690c0f8f00b00545a08184absm3571733ywb.59.2023.03.30.09.11.59
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 09:12:00 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536af432ee5so364075517b3.0
        for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 09:11:59 -0700 (PDT)
X-Received: by 2002:a81:b65f:0:b0:545:611c:8d19 with SMTP id
 h31-20020a81b65f000000b00545611c8d19mr12055261ywk.4.1680192719618; Thu, 30
 Mar 2023 09:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230330060105.29460-1-rdunlap@infradead.org> <e1b6f12a-899b-4985-8725-556bcb5d0991@spud>
 <CAMuHMdW2r1f7C_BdXn9BnDktLwHjBA_0Kvq6OeLJ1sZ7azhqkg@mail.gmail.com> <b712f5c8-9486-8e4a-63cd-6b176572244f@infradead.org>
In-Reply-To: <b712f5c8-9486-8e4a-63cd-6b176572244f@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 30 Mar 2023 18:11:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
Message-ID: <CAMuHMdX_=T9EB=rE_p9XO2-MtaV3jNkX76_PxYd9wi17NhaYHQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: PGTABLE_LPAE is also for RISCV
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org, 
	geert+renesas@glider.be
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Thu, Mar 30, 2023 at 5:48=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org=
> wrote:
> On 3/30/23 00:31, Geert Uytterhoeven wrote:
> > On Thu, Mar 30, 2023 at 8:25=E2=80=AFAM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> >> On Wed, Mar 29, 2023 at 11:01:05PM -0700, Randy Dunlap wrote:
> >>> On riscv64, linux-next-20233030 (and for several days earlier),
> >>> there is a kconfig warning:
> >>>
> >>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> >>>   Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TE=
ST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >>>   Selected by [y]:
> >>>   - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy]=
 || COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
> >>>
> >>> and build errors:
> >>>
> >>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L140'=
:
> >>> io-pgtable-arm.c:(.init.text+0x1e8): undefined reference to `alloc_io=
_pgtable_ops'
> >>> riscv64-linux-ld: drivers/iommu/io-pgtable-arm.o: in function `.L168'=
:
> >>> io-pgtable-arm.c:(.init.text+0xab0): undefined reference to `free_io_=
pgtable_ops'
> >>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L140':
> >>> ipmmu-vmsa.c:(.text+0xbc4): undefined reference to `free_io_pgtable_o=
ps'
> >>> riscv64-linux-ld: drivers/iommu/ipmmu-vmsa.o: in function `.L0 ':
> >>> ipmmu-vmsa.c:(.text+0x145e): undefined reference to `alloc_io_pgtable=
_ops'
> >>>
> >>> Add RISCV as an allowed ARCH dependency to fix these problems.
> >>>
> >>> Fixes: d286a58bc8f4 ("iommu: Tidy up io-pgtable dependencies")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>> Cc: iommu@lists.linux.dev
> >>> Cc: Conor Dooley <conor@kernel.org>
> >>> Cc: linux-riscv@lists.infradead.org
> >>> ---
> >>>  drivers/iommu/Kconfig |    2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> >>> --- a/drivers/iommu/Kconfig
> >>> +++ b/drivers/iommu/Kconfig
> >>> @@ -32,7 +32,7 @@ config IOMMU_IO_PGTABLE
> >>>  config IOMMU_IO_PGTABLE_LPAE
> >>>       bool "ARMv7/v8 Long Descriptor Format"
> >>
> >> I'm probably missing something here, but why would we want to enable
> >> "ARMv7/v8 Long Descriptor Format" on RISC-V?
> >
> > Indeed, we should not enable it, unless compile-testing.
> >
> >> Would it not be better to make the Renesas depend on, rather than
> >> select the option? It does seem highly arch specific, and I feel like
> >> Geert previously mentioned that the RZ/Five (their RISC-V offering)
> >> didn't use it.
> >
> > I think the IPMMU_VMSA dependency should gain
> >
> >         depends on ARM || ARM64 || COMPILE_TEST
>
> so like this?
> Or did you mean to drop the ARCH_RENESAS part also?
>
>
>  config IPMMU_VMSA
>         bool "Renesas VMSA-compatible IPMMU"
> -       depends on ARCH_RENESAS || COMPILE_TEST
> +       depends on ARCH_RENESAS || ARM || ARM64 || COMPILE_TEST

No, you want "depends on (ARCH_RENESAS && (ARM || ARM64)) || COMPILE_TEST",
which is a bit hard to read.

Hence I really meant adding that line, i.e.:

     config IPMMU_VMSA
           bool "Renesas VMSA-compatible IPMMU"
           depends on ARCH_RENESAS || COMPILE_TEST
    +      depends on ARM || ARM64 || COMPILE_TEST

>
> The failing config file has ARCH_RENESAS=3Dy.  After the change above, I =
still get:
>
> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>   Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST [=
=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>   Selected by [y]:
>   - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] || =
ARM || ARM64 || COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
--=20
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
