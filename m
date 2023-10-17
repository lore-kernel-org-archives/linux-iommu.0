Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849623D3AB
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 10:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a82f176860so46235857b3.1
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697539495; x=1698144295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPRdJ+3TN8Zmg5SzFNo5gq2GpoI/z77WwxmQGbYRfiU=;
        b=CWBsk6FcR8f4CUnWm534EIx1UscgZlosh6Niyyk6kCwPDcGzAeAY2y6nW40T5VAUBL
         77QBM7yDQzKkq4kj97v72gzzby7pZ6zvIsCahGV9v9Bx8FXolVnRGBXqvbuuXm1hHYDG
         SwAVfWwNKemaCPmhZsWgd2fW+ZGOKL0zRY2rQa8r3l0YGV5/yGIax531OLa+ugdQ3J6M
         /0RbizP5MPP/ZsLRu05EUgC4QG+GFpc8mgWREowafrNc69mQKk4l28fWLKex9wn8Lf8Z
         pmdnRSIcVZb9yuoXnppFxGbdnZwKYmFVedYJu0OX3Ye64zqrOp6sLqEc2UpDpXP3GHTo
         JJvQ==
X-Gm-Message-State: AOJu0YwJNJ/w9wRTS3ILIi3tJKdN1DFqfqrcXxDn4RHNeNKcccWPM1PP
	Z8ncIi66PuLPH47EXZ5A7dsxu50vEhp6gA==
X-Google-Smtp-Source: AGHT+IGlxS78S99GxtLTkza/ApmakFAWbtxpUv2CQtC6TQSsOlaJlx5Al9idBFPpZDjTjXn38kbg4w==
X-Received: by 2002:a05:690c:f0b:b0:5a7:b1d9:70cb with SMTP id dc11-20020a05690c0f0b00b005a7b1d970cbmr2699704ywb.2.1697539495157;
        Tue, 17 Oct 2023 03:44:55 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id m127-20020a0de385000000b0059b2be24f88sm491749ywe.143.2023.10.17.03.44.54
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 03:44:54 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5a81ab75f21so51451957b3.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 03:44:54 -0700 (PDT)
X-Received: by 2002:a81:4996:0:b0:592:ffc:c787 with SMTP id
 w144-20020a814996000000b005920ffcc787mr1937845ywa.30.1697539494112; Tue, 17
 Oct 2023 03:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231016054755.915155-1-hch@lst.de> <20231016054755.915155-5-hch@lst.de>
 <20231016-pantyhose-tall-7565b6b20fb9@wendy> <20231016131745.GB26484@lst.de>
In-Reply-To: <20231016131745.GB26484@lst.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 12:44:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXVZz=YWMAgzUzme-U3qxYeLdi66xw2CGubpesGy+ZjRw@mail.gmail.com>
Message-ID: <CAMuHMdXVZz=YWMAgzUzme-U3qxYeLdi66xw2CGubpesGy+ZjRw@mail.gmail.com>
Subject: Re: [PATCH 04/12] soc: renesas: select RISCV_DMA_NONCOHERENT from ARCH_R9A07G043
To: Christoph Hellwig <hch@lst.de>
Cc: Conor Dooley <conor.dooley@microchip.com>, Greg Ungerer <gerg@linux-m68k.org>, 
	iommu@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>, arm-soc <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Mon, Oct 16, 2023 at 3:17=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
> On Mon, Oct 16, 2023 at 01:52:57PM +0100, Conor Dooley wrote:
> > > +   select RISCV_DMA_NONCOHERENT
> > >     select ERRATA_ANDES if RISCV_SBI
> > >     select ERRATA_ANDES_CMO if ERRATA_ANDES
> >
> > Since this Kconfig menu has changed a bit in linux-next, the selects
> > are unconditional here, and ERRATA_ANDES_CMO will in turn select
> > RISCV_DMA_NONCOHERENT.
>
> Oh, looks like another patch landed there in linux-next.  I had
> waited for the previous one go go upstream in -rc6.  Not sure
> how to best handle this conflict.

I think the easiest is to ask soc to apply this series?

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
