Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE29E1A59B
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 09:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5a7fb84f6ceso50904797b3.1
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 02:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697447543; x=1698052343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lc70JsqUxydN6ziam4wYfEF4cooz3zSobnEoW7SHk6M=;
        b=KV40DINK8rPxbrcgq0rgLeOiOm1QVFduoQjkAbRfXgOabwbp56CT8Iue7h1hAaY6ca
         ZDXUVM3GKl8WBjoUIbrQGOWUHlZHySHi2oEBMUjuynQXqGi2h/k+ypr2Yal/0NBwGSiJ
         dQVfyYBl801d+Y4hADqjvVOEFK0pHWeXTooXjfNK9cQbbAVGQfzZmjq0MYJAdRRtlZqw
         W7KkI9Wde59dBzG5Nu4nxw4df9tT6aRDX2dBnKmchkGi1AtfpvgAMsmSXr6WaKIMrlvy
         7Ze+s6sOWKV9ZTZSO6Q+S90k4pJLS9t+cfooyTBtAm8mxGbj7EyIzwgpmiz+bgYM58SJ
         6x+g==
X-Gm-Message-State: AOJu0YxLrgIZuJDV8Uepa0dPeMx0mB+f1ONsAgbjKQM2oYNC1R5D5y2U
	/ia4eSu5GPfgTit0toR3LFmhqGVD3ie+kQ==
X-Google-Smtp-Source: AGHT+IEqgS1K2bN7kjyIh9ua5CpRjnePMuQgu+zwI2SVrlso53wFvGx3ngExFLo0S1j4utjiB5qyLQ==
X-Received: by 2002:a81:8d52:0:b0:5a5:575:b222 with SMTP id w18-20020a818d52000000b005a50575b222mr32141918ywj.23.1697447543581;
        Mon, 16 Oct 2023 02:12:23 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id c18-20020a81df12000000b0059ae483b89dsm2043119ywn.50.2023.10.16.02.12.22
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Oct 2023 02:12:23 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5a7fb84f6ceso50904597b3.1
        for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 02:12:22 -0700 (PDT)
X-Received: by 2002:a0d:d5c1:0:b0:5a8:1ffe:eb4e with SMTP id
 x184-20020a0dd5c1000000b005a81ffeeb4emr9258455ywd.34.1697447542485; Mon, 16
 Oct 2023 02:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de>
 <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com> <20231009125843.GA7272@lst.de> <eedf951d-901c-40d8-91f2-0f13d33b7d4e@linux-m68k.org>
In-Reply-To: <eedf951d-901c-40d8-91f2-0f13d33b7d4e@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Oct 2023 11:12:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
Message-ID: <CAMuHMdVis0F02J1D7C2=MgShswt+2-4vCV076Mb3q4weagUY1A@mail.gmail.com>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, 
	Jim Quinlan <james.quinlan@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Tue, Oct 10, 2023 at 4:45=E2=80=AFPM Greg Ungerer <gerg@linux-m68k.org> =
wrote:
> On 9/10/23 22:58, Christoph Hellwig wrote:
> > On Mon, Oct 09, 2023 at 11:29:12AM +0100, Robin Murphy wrote:
> >> It looks a bit odd that this ends up applying to all of Coldfire, whil=
e the
> >> associated cache flush only applies to the M532x platform, which impli=
es
> >> that we'd now be relying on the non-coherent allocation actually being
> >> coherent on other Coldfire platforms.
> >>
> >> Would it work to do something like this to make sure dma-direct does t=
he
> >> right thing on such platforms (which presumably don't have caches?), a=
nd
> >> then reduce the scope of this FEC hack accordingly, to clean things up=
 even
> >> better?
> >
> > Probably.  Actually Greg comment something along the lines last
> > time, and mentioned something about just instruction vs instruction
> > and data cache.
>
> I just elaborated on that point a little in response to Robin's email.
>
> >>
> >> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> >> index b826e9c677b2..1851fa3fe077 100644
> >> --- a/arch/m68k/Kconfig.cpu
> >> +++ b/arch/m68k/Kconfig.cpu
> >> @@ -27,6 +27,7 @@ config COLDFIRE
> >>      select CPU_HAS_NO_BITFIELDS
> >>      select CPU_HAS_NO_CAS
> >>      select CPU_HAS_NO_MULDIV64
> >> +    select DMA_DEFAULT_COHERENT if !MMU && !M523x
> >
> > Although it would probably make more sense to simply not select
> > CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and
> > CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU for these platforms and not
> > build the non-coherent code at all.  This should also include
> > all coldfire platforms with mmu (M54xx/M548x/M5441x).  Then
> > again for many of the coldfire platforms the Kconfig allows
> > to select CACHE_WRITETHRU/CACHE_COPYBACK which looks related.
> >
> > Greg, any chance you could help out with the caching modes on
> > coldfire and legacy m68knommu?
>
> Sure, yep. I am not aware that the legacy 68000 or 68328 had any caches
> at all.

68000 (and derivatives like 68*328) does not have any cache.
68360 (which is no longer supported by Linux) is based on CPU32, and
does not seem to have any caches, although the documentation does
mention the use of "external cache memories".

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
