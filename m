Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC5113D525
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718797426; cv=none; b=GZD5Mt3AcsG76p88suM/9XPea/NEsR5PhLrhbEW2TI14NwrBlQmKKQkYrplKSicOGtXKAnGt2eSMPYBd8L9D+/PfIrjvINc+Bc5Wyo/aL0yaqEjRuCcIWQnC6T2fVtuykQDptgKJZ/yCwFEcdZ66xu52MHZkCrtg6JGIY1zwnOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718797426; c=relaxed/simple;
	bh=oy1/VM1O8VGib8ShF+vmAO2orh7g2NVW3kzaz8SZj0E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlMBuNy4TtV1v03eYIkJiI5mJd6od98mIkI2Cl5Z8EewornIO0HcFgTtIYRJUy/iBxHIHfGXHcnRB7wGIqqtrw6u8nPdqFH+vxiIg5ecBvZYjopLlt0qi9y3kKGSroZbBN2NPGR0Ip/qHD7Mj4jf6urt7+q5i6Ue2By0Jq8l8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=j+V2pT/W; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="j+V2pT/W"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso133734766b.1
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 04:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718797422; x=1719402222; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GnjH/kkjRKyzu3uDJd3BYblSPtIV4vK9xdASoNfbuQ=;
        b=j+V2pT/WnmBASlUEEQxe38XzE5YcH1bkJj1omhdXX10A963IzzzFK9405J9euvymmG
         23/fxUjHgJabVtkzha8rV5xxpOlWo0SiQZ9VMnxBdXWNBK+STPG4KOEeFhQoXKtuv+85
         e0Oq9vUNW2iv0KSqKTYfekvf7yfT4ddlRcamY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718797422; x=1719402222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GnjH/kkjRKyzu3uDJd3BYblSPtIV4vK9xdASoNfbuQ=;
        b=iEAJ2LRa7LZzPKjPuFBGGZFPG9FSeXiTxUy5A95dgZJexj8we/XuyfvbdaxOKrc0FZ
         GEY4K2pnNRGyV7L0lnziiIuvyims3w1r4/2eT9U0mo7g90C0WmbO43gWwfSWEcRfV1uo
         yvtpAftnBSdMqCErsuqE0LveYO/J5xeXXTxlRHWWDzLR8PjUsVUplNFA4dzWQC9VNfVB
         T2tzdrqSXm4xpAWYQkL9AVbZ9LECMXWOSY8HKzSOLsXmQDvMQIt2H4Yp8FYcmFr1M2eL
         35UueZis2+6dlGEJvUqiZgQNhvNn8Vo9bOB/F+LPHEFKWyPsOztMUVeUw4r2fA1ZVBn8
         e58A==
X-Forwarded-Encrypted: i=1; AJvYcCW5A7uvMWOU+be+6xIvAm+eKXFdmu8c0jl985z1TJbgWenopBhjWvesP/uhdMnKiTuKOodZoRte3uBk7YUiYDpJ2iPy0OA=
X-Gm-Message-State: AOJu0YwDn27/WCl0SsSFFVeCXquVECoicWRT/ebUa+vHgrKZI43FMVT2
	9Z1wWV+uYp9idpeAwPnaa3Jpt9dKn0lqbDheM1Us4H/SUi75awn9OEEp/oxjYuidM0I8DNmOd35
	mZ3Fw81puN5vbwXCf68diV3G76UeexSGQcUXR0Q==
X-Google-Smtp-Source: AGHT+IGplUBkcMqY8uT1JRiuzDGzVXRTpzbLVQnHZpBqUjCb4F+5Ertt8EMo+fxpvX3PCFzTSeyWlk0dbPDgVFMbMQ0=
X-Received: by 2002:a17:907:c089:b0:a6f:b201:8530 with SMTP id
 a640c23a62f3a-a6fb2018b1emr85834466b.31.1718797422501; Wed, 19 Jun 2024
 04:43:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com> <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
In-Reply-To: <0e03afd6-46be-4fc7-a974-bf506d8e503c@arm.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 13:43:31 +0200
Message-ID: <CAOf5uwkU1qCxC=OamNHLq3d3SZGVuX8_eh1_MYt6TELT4C1j5Q@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Robin Murphy <robin.murphy@arm.com>
Cc: Alberto Secondi <albertosecondi@gmail.com>, hch@lst.de, m.szyprowski@samsung.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Robin

On Wed, Jun 19, 2024 at 12:36=E2=80=AFPM Robin Murphy <robin.murphy@arm.com=
> wrote:
>
> On 2024-06-19 10:17 am, Alberto Secondi wrote:
> > ------ Tessian Warning ------
> >
> > Be careful, the email's sending address "albertosecondi@gmail[.]com" ha=
s never been seen on your company's network before today
> >
> > This warning message will be removed if you reply to or forward this em=
ail to a recipient outside of your organization.
> >
> > ---- Tessian Warning End ----
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
>
> No. If a system has devices naturally capable of >32-bit DMA, and memory
> at >32-bit system physical addresses, but only a 32-bit interconnect in
> between, that needs to be described properly in Devicetree/ACPI, not
> hacked around with completely non-portable kernel bodges.
>

commit 4251a3ac4de9625a284a9c046cc915487e9b2a5e
Author: Lucas Stach <l.stach@pengutronix.de>
Date:   Tue May 4 10:20:51 2021 +0200

    arm64: dts: imx8mm: specify dma-ranges

    DMA addressing capabilities on i.MX8MM are limited by the interconnect,
    same as on i.MX8MQ. Add dma-ranges to the the peripheral bus to let
    the kernel know about this.

    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
    Tested-by: Frieder Schrempf <frieder.schrempf@kontron.de>
    Signed-off-by: Shawn Guo <shawnguo@kernel.org>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 64aa38fd2b6e0..e7648c3b83905 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -261,6 +261,7 @@ soc@0 {
                #address-cells =3D <1>;
                #size-cells =3D <1>;
                ranges =3D <0x0 0x0 0x0 0x3e000000>;
+               dma-ranges =3D <0x40000000 0x0 0x40000000 0xc0000000>;
                nvmem-cells =3D <&imx8mm_uid>;
                nvmem-cell-names =3D "soc_unique_id";


Somenthing like this should already do it?

Michael

> Thanks,
> Robin.
>
> > Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> > Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> > ---
> >   include/linux/dma-mapping.h | 4 ++++
> >   kernel/dma/Kconfig          | 8 ++++++++
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index f693aafe221f..629220a777e3 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -74,7 +74,11 @@
> >    */
> >   #define DMA_MAPPING_ERROR           (~(dma_addr_t)0)
> >
> > +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> > +#define DMA_BIT_MASK(n)      (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<=
(n))-1))
> > +#else
> >   #define DMA_BIT_MASK(n)     (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
> > +#endif
> >
> >   #ifdef CONFIG_DMA_API_DEBUG
> >   void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)=
;
> > diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> > index c06e56be0ca1..0a27eafed808 100644
> > --- a/kernel/dma/Kconfig
> > +++ b/kernel/dma/Kconfig
> > @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
> >   config ARCH_DMA_ADDR_T_64BIT
> >       def_bool 64BIT || PHYS_ADDR_T_64BIT
> >
> > +config ARCH_64BIT_HAS_DMA32_ONLY
> > +        bool "64bit System has DMA32 only"
> > +        depends on ARCH_DMA_ADDR_T_64BIT
> > +        default n
> > +     help
> > +       This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> > +       64-bit systems that have DMA support limited to 32 bits.
> > +
> >   config ARCH_HAS_DMA_SET_MASK
> >       bool
> >
>
