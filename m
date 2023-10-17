Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9992611CB6
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-d9ac31cb051so5757327276.3
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697530849; x=1698135649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdUY7Js3MyY72r3pkukYQuEPFyg4hUCkNQ1ukw9r4To=;
        b=Xu2AQKJ88pqG9yL8S/uECEnLV6ig1pz1uItaR5rvlMz8WbKXezW4px0CE2Hd0hVqdm
         VzaGjTFZGtJHxhukr+ItY1ZMMa87/yzna9mKbKzcwyqxWQoCCgDOFAede3lrm2LEBx8I
         LLOZ2UL6cXJql57QckeGLm6EziRbdWB0ntKiyRBwOwR3Yr3J+Wg0bOsoAh9apgpK/TnC
         hjffL/FcJBrpxEpOAEGcJTbwpd7PAXBEeNKiENpasSMixOxwmPlEkspGwBYzxhvRoXfV
         PLJUN9uECzSSk42bfm7ChCsTRiIU4U4t4VWEuZJEHkcUub45baOcUAUDaaqnHJ+vQgAc
         gG3g==
X-Gm-Message-State: AOJu0YwWBM/ZybiknAY8kGNDUqkUBfr0hlp/rmoRCN98tjLDUORhNaZW
	E3VGAoh0zHtz0fu2tc6XfSHh2udSzRYz0w==
X-Google-Smtp-Source: AGHT+IFaNJeLhRfNnoXNFqU5fz8ezyHlP6Tqo0toGbkR8tF0Pra5ZRTvU5/cRprqS6adfiOeamUVPA==
X-Received: by 2002:a25:77c5:0:b0:d9a:44fd:c72b with SMTP id s188-20020a2577c5000000b00d9a44fdc72bmr1378940ybc.13.1697530849369;
        Tue, 17 Oct 2023 01:20:49 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 128-20020a251186000000b00d9ab95777ecsm350820ybr.49.2023.10.17.01.20.47
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:20:47 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a7d532da4bso68024317b3.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:20:47 -0700 (PDT)
X-Received: by 2002:a81:ab41:0:b0:59f:4dcd:227e with SMTP id
 d1-20020a81ab41000000b0059f4dcd227emr1543078ywk.37.1697530847545; Tue, 17 Oct
 2023 01:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de>
In-Reply-To: <20231016054755.915155-5-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 10:20:35 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=Rp8+fcGrZ5fbVDyEZgVMGH_YHMxSTBdHB+zNxw4bxA@mail.gmail.com>
Message-ID: <CAMuHMdW=Rp8+fcGrZ5fbVDyEZgVMGH_YHMxSTBdHB+zNxw4bxA@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from ARCH_R9A07G043
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Selecting DMA_GLOBAL_POOL without the rest of the non-coherent DMA
> infrastructure does not make sense.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/soc/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index f1696d3b5018d0..ea473b4150dfa8 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -338,6 +338,7 @@ config ARCH_R9A07G043
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE
>         select DMA_GLOBAL_POOL
> +       select RISCV_DMA_NONCOHERENT
>         select ERRATA_ANDES if RISCV_SBI
>         select ERRATA_ANDES_CMO if ERRATA_ANDES

With proper sort order, and rebased to soc/for-next:
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

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
