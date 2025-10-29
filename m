Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2755348882
	for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754103; cv=none; b=lh4urALJiESwv6GZ2ENFkJQI3bTkclWfTN1x6gRFy0BiG32yDLh54ZCOLCvSBVRwLKS0Jm1vEtoNa2HWHNdnFtyfigmQd3ZGRIQD0XiRKn6Pbg9si2P1VPfZMwm62QZ5yOXM1apnJ01Ksden/7NLYya9d6kvlmYKbfez9yMBKYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754103; c=relaxed/simple;
	bh=x7hF+/Cp6WC101sN6xlMTM+BgF2Pmoe9fIFD9LQyyDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ8Pu6cAGREBo1MXCuS2o5nBhcOnvBIr5cb+k9hWoGEzcj/EUvV1hxEzZjWYF/UseSxuQBwkspxFWLf7lw4eCDKG19OqaOXXO+4RzwMAKTdL+FvjKdwLJFYVwWlj7avyP1/2kt4JAtrulRYzfSUmABIHwqNPUuauARLyINgs4bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5569a25c697so11520e0c.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 09:08:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754101; x=1762358901;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/ipYGthC0MioeorbLHvDmgjrqF5uNCNGBSSRMGKMZ4=;
        b=N7LNSLERru4Z9f9XiQUWuDoWvXBHhAABBpa58g1wgSPEiiwN22jcnS44nywRHpolGq
         gslvdH/+gaCgON38BME/Ver4P0Nz5GRJf6upqJe8ZXWl862+H4NLXmcjjySK0Gg8jism
         HNVnVdKaXedHPvWoKVrlnW4Xwz4XXArrrpeXxL4fg12xn5BeJ892YTk8svoA4LN1iZiU
         zwELdl8daGtx/fX+v3TUe441VD+ouF8EjVgJbeCIpmDkN1sesSB4X9AmiqjNA02n3zy5
         L88fumgdbrX9E+YSzz3aIIp5m5JvvDacLKCDQ04nRHHH2NvTHfGtlao4svVgdw6xm9ce
         i4Zw==
X-Gm-Message-State: AOJu0YxkdftjQgGVSm2xbTvHP2pAUMZdaXg9O/woofSPH67B4vG/zzQE
	KRX7sJYR/vB31wqP/2GI70FbHMmtZPwUoLL53Ajwyzs2np3yrfNgbHIOxerpXorp
X-Gm-Gg: ASbGncvHQpuQtnJ+DQ3tVL6h8YmsrXjtFGe9ir8+i1CCxBRIQr4/dpalcBY7gWvEdmW
	GKtBlSPEbXLq7SDcl+VTH+ANjJ40DahrH/wXLdtelW9fNF/HkdZ8GESDavMIlXJ/h6Bq/mVdGXl
	UYk4qTx8pRuEKFEUlMJgOf9uyfbW2lQXFqlEvx/Ott7kk8Ddmf0rXqm7Wtc3BoLCSwG2nB957Pp
	g0VnyxUgRT4FWcDNUMhSWUETca9L9ADf3SL5ujTPDCk4bI7qB/Kis+cwiWs4Nn3pFYOfNJGEAGp
	v4PP0ehRlUTqaSq18RHroSdAieGR+q9Jd+GMr4Gy6I2d8Th5ebxeZ1e5j5oUZXNgqkyaXGkvWfW
	Gdw6+PjyoniWsxJWuZPtVld5GY/VYx/vyeGgUfG98AgUDlKC1Cdwb88piIHZEM9CT9THIUhs6Ip
	PzUazIaarBWiJD/QyIL7hqJfdqzvpIpDZumeMk+xIcUcO5FWPJTQLd
X-Google-Smtp-Source: AGHT+IERrAK26RK1JirX35qtREeHiMRashsnXVf075yJ+X9gUPOaViIZ7jvMg5IT/9wMJ3nPiybIxg==
X-Received: by 2002:a05:6122:8c24:b0:557:c345:f48 with SMTP id 71dfb90a1353d-5581410662cmr1274082e0c.6.1761754100282;
        Wed, 29 Oct 2025 09:08:20 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-557ddb337a9sm5511578e0c.13.2025.10.29.09.08.18
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 09:08:18 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5db3de55cf4so67950137.0
        for <iommu@lists.linux.dev>; Wed, 29 Oct 2025 09:08:18 -0700 (PDT)
X-Received: by 2002:a05:6102:4a89:b0:5d6:1564:d7f1 with SMTP id
 ada2fe7eead31-5db906b8f37mr1467931137.36.1761754098557; Wed, 29 Oct 2025
 09:08:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251027004816.562965-1-den@valinux.co.jp>
In-Reply-To: <20251027004816.562965-1-den@valinux.co.jp>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 29 Oct 2025 17:08:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
X-Gm-Features: AWmQ_blrV7P_F3R16HOIrRem1UqE4h3nEa2JhxUtyuN9Q8vEJnpLXJhqDTLYNJo
Message-ID: <CAMuHMdVtR_8OZG2XrD5PHY+ybaH4dudya4VXNXD3iHktdDyF8w@mail.gmail.com>
Subject: Re: [PATCH] iommu: ipmmu-vmsa: Add DMA controllers to devices_allowlist
To: Koichiro Den <den@valinux.co.jp>
Cc: iommu@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com
Content-Type: text/plain; charset="UTF-8"

Hi Den-san,

On Mon, 27 Oct 2025 at 02:26, Koichiro Den <den@valinux.co.jp> wrote:
> Add Renesas DMA controller devices to the devices_allowlist to enable
> their use with the IPMMU. This allows DMA channels to operate through
> the IOMMU when enabled.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Thanks for your patch!

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -741,7 +741,9 @@ static const char * const devices_allowlist[] = {
>         "ee100000.mmc",
>         "ee120000.mmc",
>         "ee140000.mmc",
> -       "ee160000.mmc"
> +       "ee160000.mmc",
> +       "e7350000.dma-controller",
> +       "e7351000.dma-controller"

While your change looks correct to me, it causes DMA mapping failures on
Gray Hawk Single and Sparrow Hawk when IPMMU support is enabled
(on renesas-drivers-2025-10-28-v6.18-rc3 with renesas_defconfig
+ CONFIG_IPMMU_VMSA=y):

    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor

0xe656000c = HSCIF2 Transmit FIFO data register.

With "#define DEBUG" added to drivers/dma/sh/rcar-dmac.c:

    rcar-dmac e7351000.dma-controller: chan1: failed to map 1@0x00000000e656000c
    sh-sci e6560000.serial: Failed preparing Tx DMA descriptor
    rcar-dmac e7351000.dma-controller: chan2: map 1@0x00000000e6560014
to 0x00000000fff82014 dir: DMA_TO_DEVICE
    rcar-dmac e7351000.dma-controller: chan2: chunk
00000000e5110c20/000000005e0ede90 sgl 0@000000000d8c5440, 256/256
0x00000000fff82014 -> 0x00000000ffed6000
    rcar-dmac e7351000.dma-controller: chan2: submit #2@000000005e0ede90
    rcar-dmac e7351000.dma-controller: chan2: chunk
0000000025f2f66c/00000000e5f0dd15 sgl 0@0000000064f1067f, 256/256
0x00000000fff82014 -> 0x00000000ffed6100
    rcar-dmac e7351000.dma-controller: chan2: submit #3@00000000e5f0dd15
    rcar-dmac e7351000.dma-controller: chan2: queue chunk
00000000e5110c20: 256@0x00000000fff82014 -> 0x00000000ffed6000

0xe6560014 = HSCIF2 Receive FIFO data register

Comparing to the CONFIG_IPMMU_VMSA=n case:

    rcar-dmac e7351000.dma-controller: chan1: map 1@0x00000000e656000c
to 0x00000000e656000c dir: DMA_FROM_DEVICE
    rcar-dmac e7351000.dma-controller: chan1: chunk
0000000096396eb4/00000000f35357b6 sgl 0@0000000013546bf6, 74/74
0x0000000489ab5000 -> 0x00000000e656000c
    rcar-dmac e7351000.dma-controller: chan1: submit #2@00000000f35357b6
    rcar-dmac e7351000.dma-controller: chan1: queue chunk
0000000096396eb4: 74@0x0000000489ab5000 -> 0x00000000e656000c

This confuses me even more: why no DMA_TO_DEVICE mapping in the
latter case?

>  };
>
>  static bool ipmmu_device_is_allowed(struct device *dev)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
