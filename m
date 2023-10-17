Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D31328AE
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7af20c488so66915437b3.1
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697532212; x=1698137012;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iF8pGgwx9ER+JexQPULvEbdhCYC/MDFSezGeWG3jTqw=;
        b=chf95nGHrGit6iKWk+gn81yrlM444t5jwLknbKuCcIp7ghmaOgSCMM9GrIFQQqr30X
         NS0Xg5Lx5rYiF4plZ45fYKoE2J36jmQN9TK3nfbLiy8Cbg6Qdi/iN8+7BF2YnTjOUiJx
         kQlcmfdqBiH0jhWcteWOvTYRnQI7mFfJktlyTyAPGfdfIgVHynuvRMjL9cZxzS0RzgFQ
         tWpwdegOdmmD8veyE8+SDy2mMKZYUaaHHjZf9NKypvvRL496PWgPPmVvNVB2LJA0b3NN
         TjWIW+qVYrnY8pRGdM0YviSa9WCS9Hhz1cP1tI8VfIq7OWYsOOwCEk1F7SeOZZbd+boy
         jcNw==
X-Gm-Message-State: AOJu0YyScoOfYxMcliBiLsFio5Y+ZmJmSAAYS04Ea7TUDj3GeOSy2y3e
	AOw68SZlAYjsiTnoxC5tbeBplSMMB1jmOQ==
X-Google-Smtp-Source: AGHT+IEdKF0bh7hnLAxhmAEB2yhX/+KfKlu8lJ4sj8P9CaNj/efUc8dyge44VtW5VRzfw/guHqFtMg==
X-Received: by 2002:a81:77d5:0:b0:5a7:c646:b3ed with SMTP id s204-20020a8177d5000000b005a7c646b3edmr1623455ywc.34.1697532212298;
        Tue, 17 Oct 2023 01:43:32 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id u140-20020a0deb92000000b0059bc980b1eesm440593ywe.6.2023.10.17.01.43.31
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:43:31 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-579de633419so66667387b3.3
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:43:31 -0700 (PDT)
X-Received: by 2002:a0d:f786:0:b0:583:a3ab:b950 with SMTP id
 h128-20020a0df786000000b00583a3abb950mr1213954ywf.50.1697532211155; Tue, 17
 Oct 2023 01:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-11-hch@lst.de>
In-Reply-To: <20231016054755.915155-11-hch@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 10:43:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXonOxTT7OuTtmyYR346F569aQE0ErhAx8qfsGxWUp+Sg@mail.gmail.com>
Message-ID: <CAMuHMdXonOxTT7OuTtmyYR346F569aQE0ErhAx8qfsGxWUp+Sg@mail.gmail.com>
Subject: Re: [PATCH 10/12] net: fec: use dma_alloc_noncoherent for data cache
 enabled coldfire
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

Hi Christoph,

On Mon, Oct 16, 2023 at 7:48=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> Coldfire platforms with data caches can't properly implement
> dma_alloc_coherent and currently just return noncoherent memory from
> dma_alloc_coherent.
>
> The fec driver than works around this with a flush of all caches in the
> receive path. Make this hack a little less bad by using the explicit
> dma_alloc_noncoherent API and documenting the hacky cache flushes so
> that the DMA API level hack can be removed.
>
> Also replace the check for CONFIG_M532x for said hack with a check
> for COLDFIRE && !COLDFIRE_COHERENT_DMA.  While m532x is the only such
> platform with a fec module, this makes the code more consistent and
> easier to follow.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -406,6 +406,70 @@ static void fec_dump(struct net_device *ndev)
>         } while (bdp !=3D txq->bd.base);
>  }
>
> +/*
> + * Coldfire does not support DMA coherent allocations, and has historica=
lly used
> + * a band-aid with a manual flush in fec_enet_rx_queue.
> + */
> +#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
> +static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *=
handle,
> +               gfp_t gfp)
> +{
> +       return dma_alloc_noncoherent(dev, size, handle, DMA_BIDIRECTIONAL=
, gfp);
> +}
> +
> +static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr=
,
> +               dma_addr_t handle)
> +{
> +       dma_free_noncoherent(dev, size, cpu_addr, handle, DMA_BIDIRECTION=
AL);
> +}
> +#else /* CONFIG_COLDFIRE && !CONFIG_COLDFIRE_COHERENT_DMA */

!CONFIG_COLDFIRE || CONFIG_COLDFIRE_COHERENT_DMA

> +static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *=
handle,
> +               gfp_t gfp)
> +{
> +       return dma_alloc_coherent(dev, size, handle, gfp);
> +}
> +
> +static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr=
,
> +               dma_addr_t handle)
> +{
> +       dma_free_coherent(dev, size, cpu_addr, handle);
> +}
> +#endif /* !CONFIG_COLDFIRE && !CONFIG_COLDFIRE_COHERENT_DMA */

!CONFIG_COLDFIRE || CONFIG_COLDFIRE_COHERENT_DMA

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
