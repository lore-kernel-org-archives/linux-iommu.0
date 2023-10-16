Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E1A2943E
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVyxwDXV"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4a19dac27c4so1956786e0c.1
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 08:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470858; x=1698075658; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6JyrPV6/isChg/aWoV8Vdox7jNb/LeSH8h9ZE9RQZ4k=;
        b=hVyxwDXVVeX9BtJ0Ns5lCujaIEM1eFDFD2UmjSrTBqjYeBSco9jjZibvElCTgF9FLo
         xErqwsjfollGM1OeH60TG7EatjolZZt6agxdn5czH9G9YhSW5vh6+0v55yj9IjuzCqIq
         K2nGT4Ct6biZv0EOFbH0BJfi98lXlqKXAwOdPFLiZkx40kpDB56+oNo2tmBDbq0fvlDZ
         6gFKoiyjiSxUc+td7C1ViWTduPFtqMYYMWd+V/IqwHcG+0vJiEOs9IOjQlaZ/bvIY7nb
         THa7BtaN7vdrN2Z9TXU9bNKLy6SmIGO3k+kXSVUNafdOdQ4GHaYBxoBXlARsZHfnexY2
         XlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470858; x=1698075658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6JyrPV6/isChg/aWoV8Vdox7jNb/LeSH8h9ZE9RQZ4k=;
        b=cuXz9k+WZnW5cja4r/7DPr95E6mZZ56q4T0OvG1vh99mfHNzVDjwO0QGuAkF/Xue8T
         +ZIMjsAkcvSLtxQRvrK4EqpliIEW3rictIiCcvHSm1DSu/sbGSD1QqewUC2i5dBmDO1c
         LUU2WNFFtkTmtGVPd3VJinrYY83+ZUhUkV9avcHj9S8DXVs+EqUZw7M7q+OdBMy8+T5w
         uuOaPMsACBN+MxpRLKzhYOV1aomTvUBAL/Ft5rorWhSWMSGCFYW42Ti+TZ2VCDeSrDK4
         mJGjIjTdMUHAN36640yOZAiXnQJILI5C01tkXpgpfMCoMi694RDJUF+XyhG94AoXLLs/
         Wbag==
X-Gm-Message-State: AOJu0YzDoMeRkZbqQMC6zRqqoWZTu1ZHBxilRBUH1UAKgyz81NUDRbyI
	XZMkxsQJireV0M6vw7FE4ai/XGzKZb8sadcHFhE=
X-Google-Smtp-Source: AGHT+IEUS6diCI0qP0NzRCHHthfHGe1z+pXjLCt2SKZVkH+NQW/kPzzEZY2133jtIGuI9wooUY358mw8Vy0zXSvuQs4=
X-Received: by 2002:a1f:4ec4:0:b0:4a4:887:514c with SMTP id
 c187-20020a1f4ec4000000b004a40887514cmr8133579vkb.6.1697470858089; Mon, 16
 Oct 2023 08:40:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-3-hch@lst.de>
In-Reply-To: <20231016054755.915155-3-hch@lst.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 16 Oct 2023 16:39:40 +0100
Message-ID: <CA+V-a8va9W7Gpgr22RcPHL=fJvbViMjrpUfqKekcQ+rSZeYebw@mail.gmail.com>
Subject: Re: [PATCH 02/12] riscv: only select DMA_DIRECT_REMAP from RISCV_ISA_ZICBOM
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@linux-m68k.org>, iommu@lists.linux.dev, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, 
	linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 6:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> RISCV_DMA_NONCOHERENT is also used for whacky non-standard
> non-coherent ops that use different hooks in dma-direct.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0ac0b538379718..9c48fecc671918 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -273,7 +273,6 @@ config RISCV_DMA_NONCOHERENT
>         select ARCH_HAS_SYNC_DMA_FOR_CPU
>         select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>         select DMA_BOUNCE_UNALIGNED_KMALLOC if SWIOTLB
> -       select DMA_DIRECT_REMAP if MMU
>
>  config RISCV_NONSTANDARD_CACHE_OPS
>         bool
> @@ -549,6 +548,7 @@ config RISCV_ISA_ZICBOM
>         depends on RISCV_ALTERNATIVE
>         default y
>         select RISCV_DMA_NONCOHERENT
> +       select DMA_DIRECT_REMAP
>         help
>            Adds support to dynamically detect the presence of the ZICBOM
>            extension (Cache Block Management Operations) and enable its
> --
> 2.39.2
>
