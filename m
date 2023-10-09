Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0717D1
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 08:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a24b03e22eso51936077b3.0
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 01:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696841050; x=1697445850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dqNLFjHn3fj/AL0iMyf/yawddLiaq23Wu30A3Gzqckk=;
        b=Qi1oQhwXaDLuL5xRtYAKm2KwR4s+EDFWghiDmXB4odRJkLV8VGv6sboTpC/PS68obo
         0DlMEx5SQsVYCVZds35R0ZS9nDQxHoCpqD9hFRB1KzK4muSLbrLzbqzm9+g/V80iDaCT
         AZU+zJVTdFzhV/9aaPP8ans6jtNjh55/f3RqObVXJcavgpuk9Zq/WO4gYJJ1cg9wL5wK
         wajZTBqg9K7UXHPFyQ8M0hNocFJoFeK4eSHeOp0CvCZTWYoYBmu5fZwO9CzGxB6RvUin
         11iIrZQwMIvp+J3bGctR9CO5X+MsrxAC4MV4o97fZtJkW13kTjeGn8TsLDJCa45SUB87
         Utag==
X-Gm-Message-State: AOJu0YwClh1J0xlKWkWCWHhRRaSIE6TgzF/hiVlgkKJZ/xGrW5R4u28g
	7Sc1OaAmWm3dXcK/nE+Vg1dvK/NXyueVfg==
X-Google-Smtp-Source: AGHT+IF1vprTYVqI+VTruURTm49IsqYlb/m8q4I/SVfu8A8fIj1UySENm1YwEPp6HjK353bexypXLQ==
X-Received: by 2002:a81:7309:0:b0:59b:2458:f608 with SMTP id o9-20020a817309000000b0059b2458f608mr15798458ywc.30.1696841049758;
        Mon, 09 Oct 2023 01:44:09 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id j190-20020a0df9c7000000b00582b239674esm3526813ywf.129.2023.10.09.01.44.09
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 01:44:09 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5a2379a8b69so51658887b3.2
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 01:44:09 -0700 (PDT)
X-Received: by 2002:a0d:d808:0:b0:59b:d796:2a55 with SMTP id
 a8-20020a0dd808000000b0059bd7962a55mr17521321ywe.1.1696841049412; Mon, 09 Oct
 2023 01:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-2-hch@lst.de>
In-Reply-To: <20231009074121.219686-2-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 10:43:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com>
Message-ID: <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, Oct 9, 2023 at 9:41=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
> CONFIG_DMA_GLOBAL_POOL can't be combined with other dma-coherent
> allocators.  Add dependencies to Kconfig to document this, and make
> kconfig complain about unment dependencies if someone tries.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -135,6 +135,8 @@ config DMA_COHERENT_POOL
>
>  config DMA_GLOBAL_POOL
>         select DMA_DECLARE_COHERENT
> +       depends on !ARCH_HAS_DMA_SET_UNCACHED
> +       depends on !DMA_DIRECT_REMAP
>         bool
>
>  config DMA_DIRECT_REMAP

riscv defconfig + CONFIG_NONPORTABLE=3Dy + CONFIG_ARCH_R9A07G043=3Dy:

WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
  Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMAP [=
=3Dy]
  Selected by [y]:
  - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONPORTA=
BLE [=3Dy]

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
