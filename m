Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD45B654
	for <iommu@lists.linux.dev>; Mon,  9 Oct 2023 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-5a229ac185aso53275367b3.1
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 02:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696845099; x=1697449899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcpLpgd1f1+Ipojmn8r+iB3J9d+aLm5CFxyQ8kyrL4E=;
        b=Rt/oi0s7qw5uXLgRRu0Fn/qZ+v5mPGiQvZi1L0zTMOQdvE1/IWzN1AAJLvuGO+nSgV
         LxAa9cLFOUgpCMqnA4g2GgNk5BEvUnGayQpWqZgzQPvWmYmEKVH/+yU6qdFBN0cfzzKF
         qOOAPYLiYRP2sDCkJ04fzClgOqvf6+dBdAGCW//t5Keql6KtkdwzRbMGMbnjo47XF7Y5
         2s+ZDvbLwJm9oSqDk5poGDL4/PGFG1bLSKK1/xRPJceP4WudJiEzINSvPJkwgUrpFm4H
         fNy1Zp2a/casjwqMcNpk3lfE8vMmUtQwD9C8/joVmql+9A+HrfS0/iSp1S/pHLwTI21r
         IsQQ==
X-Gm-Message-State: AOJu0YyUQ7N6B0k8X2TN57TVlubIB8fv+bH4ksskdekjWqG8QlIttjNt
	sCWxLCHhRxUEMdDxzjYTMrYufzDA7yOFiw==
X-Google-Smtp-Source: AGHT+IH2LzpSat5gqrwn7be4qAVHfkim53i14R6XvWiHUl951+oQnWP48i8rF08lY4u/3Uu0qD1FTg==
X-Received: by 2002:a0d:ea95:0:b0:5a1:ed8d:111f with SMTP id t143-20020a0dea95000000b005a1ed8d111fmr15597609ywe.1.1696845099357;
        Mon, 09 Oct 2023 02:51:39 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id fv3-20020a05690c370300b005463e45458bsm853448ywb.123.2023.10.09.02.51.38
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 02:51:38 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-d84c24a810dso4783275276.2
        for <iommu@lists.linux.dev>; Mon, 09 Oct 2023 02:51:38 -0700 (PDT)
X-Received: by 2002:a25:18c1:0:b0:d81:61fd:ef5d with SMTP id
 184-20020a2518c1000000b00d8161fdef5dmr11643273yby.27.1696845098183; Mon, 09
 Oct 2023 02:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-2-hch@lst.de>
 <CAMuHMdWiYDQ5J7R7hPaVAYgXqJvpjdksoF6X-zHrJ_80Ly4XfQ@mail.gmail.com>
 <20231009091625.GB22463@lst.de> <CAMuHMdUZNewD-QC8J7MWSBP197Vc169meOjjK6=b7M11kVjUzg@mail.gmail.com>
 <20231009094330.GA24836@lst.de>
In-Reply-To: <20231009094330.GA24836@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Oct 2023 11:51:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2FXdUHtjYW8JyXGBgHhR8De0vp3Ee77e6G8Vbs3gG8Q@mail.gmail.com>
Message-ID: <CAMuHMdV2FXdUHtjYW8JyXGBgHhR8De0vp3Ee77e6G8Vbs3gG8Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, linux-riscv <linux-riscv@lists.infradead.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>, 
	"Lad, Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>, arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

CC soc

On Mon, Oct 9, 2023 at 11:43=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Mon, Oct 09, 2023 at 11:34:55AM +0200, Geert Uytterhoeven wrote:
> > The fix you are referring too is probably commit c1ec4b450ab729e3
> > ("soc: renesas: Make ARCH_R9A07G043 (riscv version) depend
> > on NONPORTABLE") in next-20231006 and later.  It is not yet upstream.
> >
> > Still, it merely makes ARCH_R9A07G043 (which selects DMA_GLOBAL_POOL)
> > depend on ARCH_R9A07G043.
> > RISCV_DMA_NONCOHERENT still selects DMA_DIRECT_REMAP, so both can end
> > up being enabled.
>
> Ok, so we need to actually fix this properly.  Lad, can you respin
> the fix to not select DMA_DIRECT_REMAP, for ARCH_R9A07G043?

ARCH_R9A07G043 does not select DMA_DIRECT_REMAP directly,
RISCV_DMA_NONCOHERENT does.  And there are other users of
RISCV_DMA_NONCOHERENT (RISCV_ISA_ZICBOM and ERRATA_THEAD_CMO).
Should the selection of DMA_DIRECT_REMAP moved to their users?

Note that the fix is already in soc/for-next, so we need coordination
with the soc people.

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
