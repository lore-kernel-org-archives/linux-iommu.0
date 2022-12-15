Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7049F28E7
	for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 09:04:47 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id g7so4673762qts.1
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 01:04:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lu90K/ctwOLQV8gWvT0jknM3Lq9BYGH2KzhYwJnHx5A=;
        b=ZFi1SCCnN9kpEm98qT0OdmM3okWLRqe2+WnJ2H4lgLTWDagmrnOQhwYOBTmeeKadWv
         qXxNrVyruJn4J0ofZpqsSdRDoq6xXkyLLoBDbaWvyej+RX1Zz3HB1V/Qm/UNKA7UYgrA
         yyiJANB6kZL16nQrVxQGUaHvLeI4OdXOSghkre9xWPUwAH/Kf/eIlQfS8obZnECBt8mA
         +dtXOtXuda7MKMDssn3jmf2Xd0w0H7XyCceC8xQqrxIO2Kw/NhQv1Ym69RMo2BqiUM/7
         3XaICNtf7LeX5gorHWhjqmZ7ZfAq4XCAFBSHryUPByVHYMzdxjMhYPMAC7ZFh1Vq63dG
         mzkA==
X-Gm-Message-State: ANoB5pniOUVfNyqjHgzhagLDPKaMCMmrALr0VWjdGEt2kTFQi9Vt0GNH
	Etg6DrkeSrFhwTAfw8xUlCOE3ZeTIS+Biw==
X-Google-Smtp-Source: AA0mqf6i4FAoAw0Wl2wWkSpYoYNq2KlyzqtBcwvPXL+h51CKxMGqv6hn4Fa2vz+bVCRYE/cqXz6e8g==
X-Received: by 2002:ac8:5196:0:b0:3a8:2ccb:f55d with SMTP id c22-20020ac85196000000b003a82ccbf55dmr7438591qtn.33.1671095086185;
        Thu, 15 Dec 2022 01:04:46 -0800 (PST)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id s1-20020a05620a0bc100b006bb2cd2f6d1sm11635193qki.127.2022.12.15.01.04.45
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 01:04:45 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id d131so2755414ybh.4
        for <iommu@lists.linux.dev>; Thu, 15 Dec 2022 01:04:45 -0800 (PST)
X-Received: by 2002:a25:d655:0:b0:6fc:1c96:c9fe with SMTP id
 n82-20020a25d655000000b006fc1c96c9femr34391603ybg.36.1671095085279; Thu, 15
 Dec 2022 01:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20221214180409.7354-1-palmer@rivosinc.com> <8DACBAC8-F220-4DA7-BCC2-4E2ED9E3E03E@kernel.org>
 <b8665f9d-44cf-5719-c206-5eb622978b1a@arm.com> <OSZPR01MB7019D761845E3AC9E30F2D2DAAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: <OSZPR01MB7019D761845E3AC9E30F2D2DAAE09@OSZPR01MB7019.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Dec 2022 10:04:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUt7coFBx-+mXJcf7E0f5S_Q_Rmb6VVq-4E7_m99GXyRw@mail.gmail.com>
Message-ID: <CAMuHMdUt7coFBx-+mXJcf7E0f5S_Q_Rmb6VVq-4E7_m99GXyRw@mail.gmail.com>
Subject: Re: [PATCH] RISC-V: Disable IPMMU_VMSA on rv32
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Conor Dooley <conor@kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Palmer Dabbelt <palmer@rivosinc.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Prabhakar,

On Wed, Dec 14, 2022 at 10:40 PM Prabhakar Mahadev Lad
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > From: Robin Murphy <robin.murphy@arm.com>
> > On 2022-12-14 19:46, Conor Dooley wrote:
> > > On 14 December 2022 10:04:09 GMT-08:00, Palmer Dabbelt <palmer@rivosinc.com> wrote:
> > >> Without this I get a Kconfig warning and then subsequent build
> > >> failure when building allmodconfig on rv32.
> > >>
> > >> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
> > >>   Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64
> > [=y])
> > >>   Selected by [y]:
> > >>   - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] ||
> > >> COMPILE_TEST [=y]
> > >
> > > This here is your problem afaict
> > > I got a report from lkp about it yesterday, "blaming" Prabhakar for it:
> > > https://jpn01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore
> > > .kernel.org%2Fall%2F202212142355.b7vf3Jh0-lkp%40intel.com%2F&amp;data=
> > > 05%7C01%7Cprabhakar.mahadev-lad.rj%40bp.renesas.com%7Ca51ccd27ccda45e7
> > > 53c208dade16c553%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C63806648
> > > 6632283001%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> > > iLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=FshRCpnIoU0b
> > > c38MYnesotcgOV4JT%2FXVOidbDMpAWbc%3D&amp;reserved=0
> > >
> > > I hate selects, just ignores the dependency :(
> > >
> > >   && !GENERIC_ATOMIC64 [=y])
> >
> > I think the existing assumption was that ARCH_RENESAS implied !GENERIC_ATOMIC64. If that is no longer
> > true then please feel free to adjust drivers/iommu/Kconfig to suit.
> >
> IPMMU is not available on Renesas RISCV SoCs, so maybe something like below?
>
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -283,7 +283,7 @@ config EXYNOS_IOMMU_DEBUG
>
>  config IPMMU_VMSA
>         bool "Renesas VMSA-compatible IPMMU"
> -       depends on ARCH_RENESAS || (COMPILE_TEST && !GENERIC_ATOMIC64)
> +       depends on (ARCH_RENESAS && !RISCV) || (COMPILE_TEST && !GENERIC_ATOMIC64)

Negative dependencies on a symbol like that tend to need future
extension.

What about

    depends on ARCH_RENESAS || COMPILE_TEST
    depends on !GENERIC_ATOMIC64

instead?

That does mean the question will show up on RV64, too.
Adding

    depends on ARM || ARM64 || COMPILE_TEST

(like we sort of had before commit 97215a7df4351fdd
("iommu/renesas: Expand COMPILE_TEST coverage")
would fix that.

>         select IOMMU_API
>         select IOMMU_IO_PGTABLE_LPAE
>         select ARM_DMA_USE_IOMMU

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
