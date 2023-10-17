Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F03D38E
	for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5a7af52ee31so65530817b3.2
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:31:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697531503; x=1698136303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei9tALPoBKhoksEnlBgw5HOrFsYUFtyrr5JUw29UL+E=;
        b=sLnZLKdQDjw5lbKd/Oo+tBbIjJg9xq4Pevhsrb8XRXOFQJVCkfovJo1pq7hYAreaFB
         LuCRssU7vIqeP6U15H38IasboTXqXz7nf5/3UAZ+gpZC3u9Fumf78LPYZUHNuY4NdkP9
         wFS5yvfaLayyjnOFcMx5qKoJ71Cv74f+he93XXmB0CEHPsvpFRgSaNcuCITYnRFBAFo3
         e3+DB6L1dkHnWYJSyM5Ql7QvsScNrVDrYF3jOQiG3pnabItbXMWuHwwbXQfRu6rSFgIN
         iTtqZxSYN50jqMbHGliUN2qS7cfdkspXTlOd7tIEMIss2KESMOMYpHxXpIHXgqkQxoPX
         A4hw==
X-Gm-Message-State: AOJu0YwHrpsIJWMujbUJhRQdZ+1pfv7TJjvKnPhnZCTSZQ3QxxwC95GF
	K0y3zEklcRs8kcuzZzu+BR1quR8BeP8w9g==
X-Google-Smtp-Source: AGHT+IGLpfUx5w2dfldhjM44FHLzX3wWgK5navxkNagH2Lub/Ytuh25wOt8yQJlQPEkwn1TvfrRZxg==
X-Received: by 2002:a0d:d802:0:b0:5a7:af7d:cee7 with SMTP id a2-20020a0dd802000000b005a7af7dcee7mr1680613ywe.6.1697531502955;
        Tue, 17 Oct 2023 01:31:42 -0700 (PDT)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id o63-20020a0dfe42000000b0059a34cfa2a5sm431709ywf.67.2023.10.17.01.31.42
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 01:31:42 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-5a7c08b7744so65373287b3.3
        for <iommu@lists.linux.dev>; Tue, 17 Oct 2023 01:31:42 -0700 (PDT)
X-Received: by 2002:a0d:db0e:0:b0:59f:7f8e:dc4a with SMTP id
 d14-20020a0ddb0e000000b0059f7f8edc4amr1605644ywe.22.1697531502538; Tue, 17
 Oct 2023 01:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com> <20231009125843.GA7272@lst.de>
 <eedf951d-901c-40d8-91f2-0f13d33b7d4e@linux-m68k.org> <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
In-Reply-To: <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Oct 2023 10:31:30 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxs=DQZWYfoxE4Jk4cc4qHUb_P65qf+xRvsooQ6ob8mw@mail.gmail.com>
Message-ID: <CAMuHMdWxs=DQZWYfoxE4Jk4cc4qHUb_P65qf+xRvsooQ6ob8mw@mail.gmail.com>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 11:12=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Tue, Oct 10, 2023 at 4:45=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org=
> wrote:
> > On 9/10/23 22:58, Christoph Hellwig wrote:
> > > On Mon, Oct 09, 2023 at 11:29:12AM +0100, Robin Murphy wrote:
> > >> It looks a bit odd that this ends up applying to all of Coldfire, wh=
ile the
> > >> associated cache flush only applies to the M532x platform, which imp=
lies
> > >> that we'd now be relying on the non-coherent allocation actually bei=
ng
> > >> coherent on other Coldfire platforms.
> > >>
> > >> Would it work to do something like this to make sure dma-direct does=
 the
> > >> right thing on such platforms (which presumably don't have caches?),=
 and
> > >> then reduce the scope of this FEC hack accordingly, to clean things =
up even
> > >> better?
> > >
> > > Probably.  Actually Greg comment something along the lines last
> > > time, and mentioned something about just instruction vs instruction
> > > and data cache.
> >
> > I just elaborated on that point a little in response to Robin's email.
> >
> > >>
> > >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> > >> index b826e9c677b2..1851fa3fe077 100644
> > >> --- a/arch/m68k/Kconfig.cpu
> > >> +++ b/arch/m68k/Kconfig.cpu
> > >> @@ -27,6 +27,7 @@ config COLDFIRE
> > >>      select CPU_HAS_NO_BITFIELDS
> > >>      select CPU_HAS_NO_CAS
> > >>      select CPU_HAS_NO_MULDIV64
> > >> +    select DMA_DEFAULT_COHERENT if !MMU && !M523x
> > >
> > > Although it would probably make more sense to simply not select
> > > CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and
> > > CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU for these platforms and not
> > > build the non-coherent code at all.  This should also include
> > > all coldfire platforms with mmu (M54xx/M548x/M5441x).  Then
> > > again for many of the coldfire platforms the Kconfig allows
> > > to select CACHE_WRITETHRU/CACHE_COPYBACK which looks related.
> > >
> > > Greg, any chance you could help out with the caching modes on
> > > coldfire and legacy m68knommu?
> >
> > Sure, yep. I am not aware that the legacy 68000 or 68328 had any caches
> > at all.
>
> 68000 (and derivatives like 68*328) does not have any cache.
> 68360 (which is no longer supported by Linux) is based on CPU32, and
> does not seem to have any caches, although the documentation does
> mention the use of "external cache memories".

As M68K selects NO_DMA if !MMU && !COLDFIRE anyway, this doesn't
matter for legacy^Wclassic m68knommu.

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
