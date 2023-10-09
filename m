Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C6623C0
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 09:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-59f7f46b326so51486077b3.0
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 02:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696844109; x=1697448909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xr8BhwyyAKTpcM9iiIvbHN9gtfLY84lyd2lf3mY1OqM=;
        b=LuK3hAaVM5ca9UnCmnVK0r6i/p7tHMR9AyrtOglemC76z9u3jbmlHDdVyAJM7XZr1V
         /JGZtajC7boOPX0wsyeGhR27y3I2F+pbp1u8BN672Kixq48WqIlO+cKfzS49Qe4Rvv8w
         rYEvs/lXog0S+RgnzPGj7ptoc5jrWFGQJlwPZQGPZ87oekJTVTShHgBrk8MmZnPJNe1n
         tBBWAzFo4Q+njA6qwufWoMRVQQI9U/WxKac0DluDurlc8oE4CjnhVi+kZn0BartYNm6E
         rDPWCkO12r+4QrXamx6EaPhqXKw5BC2I42M1l5Qoi6GUoETKGwr5w6X8fHBze8HUnp0C
         CxBA==
X-Gm-Message-State: AOJu0Yxs+qsM1dQ2V6WWNHBkhCGwkyP+ZQF7Z5RLCz/iXujNM0qLLVWW
	vUXXT+ye5BTpmmjUDk7J5CSpRU2K5IlqhA==
X-Google-Smtp-Source: AGHT+IHuzodzqhhiyRS+JQAzwtFLWYHcxk7am6PBZSrC/250XQo523a8LmqJO+WRctDTPlWT5FM/rA==
X-Received: by 2002:a25:698f:0:b0:d91:92c8:9052 with SMTP id e137-20020a25698f000000b00d9192c89052mr13656039ybc.8.1696844109083;
        Mon, 09 Oct 2023 02:35:09 -0700 (PDT)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 64-20020a250a43000000b00d814d8dfd69sm3000717ybk.27.2023.10.09.02.35.08
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:35:08 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-59f6e6b7600so51131567b3.3
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 02:35:08 -0700 (PDT)
X-Received: by 2002:a81:8246:0:b0:58d:f1fe:5954 with SMTP id
 s67-20020a818246000000b0058df1fe5954mr15164085ywf.32.1696844108593; Mon, 09
 Oct 2023 02:35:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-2-hch@lst.de>
 <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com> <20231009091625.GB22463@lst.de>
In-Reply-To: <20231009091625.GB22463@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 11:34:55 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
Message-ID: <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 11:16=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Mon, Oct 09, 2023 at 10:43:57AM +0200, Geert Uytterhoeven wrote:
> > >  config DMA_DIRECT_REMAP
> >
> > riscv defconfig + CONFIG_NONPORTABLE=3Dy + CONFIG_ARCH_R9A07G043=3Dy:
> >
> > WARNING: unmet direct dependencies detected for DMA_GLOBAL_POOL
> >   Depends on [n]: !ARCH_HAS_DMA_SET_UNCACHED [=3Dn] && !DMA_DIRECT_REMA=
P [=3Dy]
> >   Selected by [y]:
> >   - ARCH_R9A07G043 [=3Dy] && SOC_RENESAS [=3Dy] && RISCV [=3Dy] && NONP=
ORTABLE [=3Dy]
>
> And that's exactly what this patch is supposed to show.  RISCV must not
> select DMA_DIRECT_REMAP at the same time as DMA_GLOBAL_POOL.  I though
> the fix for that just went upstream?

The fix you are referring too is probably commit c1ec4b450ab729e3
("soc: renesas: Make ARCH_R9A07G043 (riscv version) depend
on NONPORTABLE") in next-20231006 and later.  It is not yet upstream.

Still, it merely makes ARCH_R9A07G043 (which selects DMA_GLOBAL_POOL)
depend on ARCH_R9A07G043.
RISCV_DMA_NONCOHERENT still selects DMA_DIRECT_REMAP, so both can end
up being enabled.

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
