Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F020B29422
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2IxY6C0"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4a13374a1e8so1763949e0c.1
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 08:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697470906; x=1698075706; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy2a+mH7vHRMC2bqIVFdXE4pfKJ8ZD9dY9NH9f8mIfg=;
        b=i2IxY6C07oCmh0obRrBrI3TyQibUe3JIimf+rU9bS4Nf4ViLacihuuJQ/BxG9xKLC4
         Hdzz8WUUPFNZveSPKzLol/QzTbxY/lK9NVA26dc7FeVoEI+BjJUK2FD0llCLNVSpngJF
         28SVocWRtZWwIHXWY5tnZxYSNfPnWH5xSJLcDQ7ciCrREPMSd5XaG7s/1ZPvNdQhINR0
         IQsqqa+irx88Pu4lpMRyr+f/G1K+UfTsbC7lBM9XWmkvC1A49DKtMmukBjIq+jnnITOY
         3HjwlDJUq6JUY7ioLf1XgjdFwBG4SbzZ3gQpYovG6A+hTziFWZmei74TgwxbXQxu7rFE
         ZWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697470906; x=1698075706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy2a+mH7vHRMC2bqIVFdXE4pfKJ8ZD9dY9NH9f8mIfg=;
        b=ogHE4V+W/vDe93/ktukHimqBQAOYNHXoE4M/7RsbGvZZVEbFFc1z97W46K1IBhCeRH
         zbaSLbGxJncMeG21GUw2L2A1aFOBD3QKlI8lWdIxZAg4gaiXG1gRMt9vsb7ZQk4GcJkz
         kmdXAVSVp0mGbN2iPoBfOXYhz727lkybdlGHM5uFh9AiYDn9hxduLp5eeWJQYuEkyJ+m
         5wlkyyWCXBZeyXjXrkTnVqfmVodrS81El75p9AAjnziINmRDH64QE8XoF3Yl9PdSoLR+
         fjKwW8PiXJiq/vBzLUZrvSOKOuWxat+AEecpVVUiowf1rboEs1j1CLl7tIY2H6cgMG7k
         BtsQ==
X-Gm-Message-State: AOJu0Yx+WMYmBfnRdaxYTxyBbiFvrOTmZkS+b3mWqsqLzPtX9OyAa0Gp
	pZmhRw4+qUDrMUT2wnF/uYzkFoV85x/G8bbd+d0=
X-Google-Smtp-Source: AGHT+IGux325FOhiB0DGfuNAaDcad8gGCTORm2m4I3eBqk5dFYW6m/Pa7EpUDnkf3lePkwaOdU4GJYHkEbhbyUtux/E=
X-Received: by 2002:a1f:ed41:0:b0:495:dcd0:471 with SMTP id
 l62-20020a1fed41000000b00495dcd00471mr28745613vkh.5.1697470905828; Mon, 16
 Oct 2023 08:41:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-4-hch@lst.de>
In-Reply-To: <20231016054755.915155-4-hch@lst.de>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 16 Oct 2023 16:40:29 +0100
Message-ID: <CA+V-a8sdZa8TiTsjY+u3rywFsXY2yKmZ0vWg900NMxVc_NRX7Q@mail.gmail.com>
Subject: Re: [PATCH 03/12] soc: renesas: ARCH_R9A07G043 depends on !RISCV_ISA_ZICBOM
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
> ARCH_R9A07G043 has it's own non-standard global pool based DMA coherent
> allocator, which conflicts with the remap based RISCV_ISA_ZICBOM version.
> Add a proper dependency.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/soc/renesas/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
> index 880c544bb2dfda..f1696d3b5018d0 100644
> --- a/drivers/soc/renesas/Kconfig
> +++ b/drivers/soc/renesas/Kconfig
> @@ -334,6 +334,7 @@ if RISCV
>  config ARCH_R9A07G043
>         bool "RISC-V Platform support for RZ/Five"
>         depends on NONPORTABLE
> +       depends on !RISCV_ISA_ZICBOM
>         select ARCH_RZG2L
>         select AX45MP_L2_CACHE
>         select DMA_GLOBAL_POOL
> --
> 2.39.2
>
