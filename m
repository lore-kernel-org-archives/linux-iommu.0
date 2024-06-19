Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B6481728
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789363; cv=none; b=JA9q1MbFaFza+ukd6eKOHzBTvHws6K1tPAuGjlPCRcUfkHwnEABc7rJkjCfuYBe3j60Row1yRxrkpoKxQpRIQmi/KJvEfwbhRbFuShkeOk4ijGyyFmfdyHzyL/gxjVG6dfNDruT1rtzhL1Gqg07Z/INcKpcJU0kCYfEviWXVkPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789363; c=relaxed/simple;
	bh=cv7531rMfIX0TJSEu7BFmlypNRmwdNE0oRm/RjGb3/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oOx9ENGK9r4xvwuLP4F4QY3/j4vb1IEphzTaOFoNqg++9GIVRZgMvdPgOfMK1njSl/tq9plU+aNjHKjHT5MehHfEWO0qWnz6aJtRdx/+wl3/ijEyh4TkqK0p5ZcehCX/27jH38jdmy4fKmEuXAYRIAHEqhcbIb6Tcq/UFO17pW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=QuGDDQvx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="QuGDDQvx"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a6f7b785a01so437785466b.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718789359; x=1719394159; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V60tWSEyq0vsAXnVJoNACpk/lcgOsGBfMMUaz3AVbmM=;
        b=QuGDDQvxuA+LqhEcZEggdmDYx/Ys+qq/dKPfBlNDZuq2ss5SZznUU+O9YCvD8GNQkS
         1cZ1AKnqErNu0JStNfDUOLZ8qpIdx/jnQXtwhDlhvZP/iUqkMhoBD4Zkt725iS43fxXR
         qU9PxDF48n2ZU6P432gngmIHks14WwA2sF+/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789359; x=1719394159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V60tWSEyq0vsAXnVJoNACpk/lcgOsGBfMMUaz3AVbmM=;
        b=pO7i/G3chEDeE18Deb1rwZFR4q/1cBZtixghhlBusYv/IVxtI3kZnblpXAQ7XDN6GM
         UDb/FK4cWmqfrsTrpRTMsl6K7YMSgYkL4/nngf+9ey0SNm6QfaAVAsjKb7hQ1mb078Pj
         lxjViv6CftyZTgiFBAtmAtuM7vWICOGoaXkSTuCNMT5+9huxtd7bKp2d1Ffg5XDr82CX
         hCh1ZMEm1gYo2FHsFwf29lWQ0tCPpXZcnIFMz/a70lrAIj0c0L+ywDH/qYNpFXNZpHTr
         Fv/clzb18KYYMy//3lP9nSslV3k3tiEpTqSyyTBDxrH1aDu4NIfnYEOP3A5wBuPyYpJO
         vv/A==
X-Forwarded-Encrypted: i=1; AJvYcCU+f7fHtoA42D909dl5Or6fKJSn3Y+3BV6nLLPZwU2+Tv8OlRLLGWx4o3DP+Wzhn1eVVVJq7Ac5RntK7c5yo5MJxvopHAc=
X-Gm-Message-State: AOJu0Yx/U9G82umh0aloXH4/6IOab1DKN9yPQsa/cFNzVoIJbDUOa/ro
	5XrErnJGVR/mde/nicuWvsueZ4Mrol9tC68fpXlJ9A1beF8FCMNc4EfF6aMWU8o9GuY/ZPJwqN4
	eBLImQS8ePmf+kw3n1YLxJE3ssD+ofwscsxV4vg==
X-Google-Smtp-Source: AGHT+IFb76x7Pucfvd16pWEowxfrmojNsl7zxPiv/9dMvlT25uSbZQ+OJ1X3ubz+svkccGvvchtJv/7pS3EQVnBm5Bk=
X-Received: by 2002:a17:907:a809:b0:a6f:86fe:c495 with SMTP id
 a640c23a62f3a-a6fab7718aemr117097866b.49.1718789359465; Wed, 19 Jun 2024
 02:29:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com> <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
In-Reply-To: <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 11:29:08 +0200
Message-ID: <CAOf5uwkJxpge=JdtQv_nu7zWaN4weD43kBKqM1qAR4h5tuRjfw@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Alberto Secondi <albertosecondi@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alberto

On Wed, Jun 19, 2024 at 11:23=E2=80=AFAM Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
>
> Hi Alberto
>
> On Wed, Jun 19, 2024 at 11:20=E2=80=AFAM Alberto Secondi
> <albertosecondi@gmail.com> wrote:
> >
> > From: Alberto Secondi <alberto.secondi@abinsula.com>
> >
> > The kernel assumes that 64-bit systems have 64-bit DMA support through
> > CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, sev=
eral
> > iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit =
support.
> > This results in several drivers requesting DMA_BIT_MASK(64), which caus=
es
> > malfunctions, particularly when systems have more than 3GB of DRAM (ver=
ified
> > with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, =
a new
> > config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems wit=
h 32-bit
> > DMA, which adjusts DMA_BIT_MASK(n) accordingly.
> >
> > Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> > Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> > ---
> >  include/linux/dma-mapping.h | 4 ++++
> >  kernel/dma/Kconfig          | 8 ++++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index f693aafe221f..629220a777e3 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,7 +74,11 @@
> >   */
> >  #define DMA_MAPPING_ERROR              (~(dma_addr_t)0)
> >
> > +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> > +#define DMA_BIT_MASK(n)        (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL=
<<(n))-1))
> > +#else
> >  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))=
-1))
> > +#endif
> >
>
> How can this fit configuration where you want to have one Kernel image
> for several arm64 machine?
>

I'm not an expert here but:

 @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not a=
ll
 *         hardware supports 64-bit addresses for consistent allocations
 *         such descriptors.

This looks more connected to what you are looking for.

Michael


> Michael
>
> >  #ifdef CONFIG_DMA_API_DEBUG
> >  void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c06e56be0ca1..0a27eafed808 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
> >  config ARCH_DMA_ADDR_T_64BIT
> >         def_bool 64BIT || PHYS_ADDR_T_64BIT
> >
> > +config ARCH_64BIT_HAS_DMA32_ONLY
> > +        bool "64bit System has DMA32 only"
> > +        depends on ARCH_DMA_ADDR_T_64BIT
> > +        default n
> > +       help
> > +         This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> > +         64-bit systems that have DMA support limited to 32 bits.
> > +
> >  config ARCH_HAS_DMA_SET_MASK
> >         bool
> >
> > --
> > 2.34.1
> >
> >
