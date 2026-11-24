Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795562577;
	b=cFqW/Ye74oXG+2id7ob8Wmlv2s2uRa+O+rFe1VslMorC+T/dr8f3aU2zzcvRa6/p8S7v
	 OeAvrfR0mFc0pBBF6gC9G7SKzEerqvtOwfJH/+QRgd9ynTxwZuJM654G3RGO+65ZwhKJl
	 ADa3ZJaf9TPl5Iq3tpdCG6ykW2dDkx3TzYLcZ8/hn4VN44QzMzks3tGsanksGnFc9eatw
	 2MgeHCRGfXFyjTmwmqSlpVIL2T6n0qxNEDwF1j8OgaKXLvTUAnIGTJi3QaSD45drQNeEM
	 r4ap2z683ZGlTHeKLeHh+lBQk8aQBg1SiM6nXQz2xX979IWeg6jGrok6DUd6hX4n9gA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+rTqiyEyTcsjP0xyYZP/sz2SwheWx3kWrvomWaMtpJ4=;
	b=vuIuCMEsyyG353oF79AsFBw7OE8lTEPWnOyFCXcGEmQRPYiD92g92/3GjTayCEfnpraA
	 5MFZOYANCVvV7LwAlzolAWXHjkTSNuxXBq5CXA4wLDOBYkqufnlElR0e5KChAVzvDCtdI
	 EyXCCPQSOYKu7LX9JK6bEZBcmES0c0H0Js0p2Ju548jbo9kz3AS+RZbBMGGQOd01f6/TW
	 rJFOvvTPkPp+Ft0jCAvM5vH+SYeMWyTu+UI4gxv3ptUAlUkwUQ++NvP5m5EqZU7HeyC9I
	 qE+jxZkUMmJhLa5x26DU6810y+86KOGXvNTNtIZzEjHT56w/rx1N2pnu8GfC+ekwr7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiXHZcBr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA15606A33D
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 23:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FA15606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TiXHZcBr
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so7893703a12.1
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 15:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795562575; cv=none;
        d=google.com; s=arc-20260327;
        b=G1jEMKwV6nkTQnOL5o0NfMeyscPzlP5UeycQkCF/y5kH37mjlS0Nmvd9jVYABjseh7
         WTcGofvaFMTfN6jauElU5lzo027a4ab2JJ/AmZ68roWHP6+V3skMvBgbw4rRfw7ymrfZ
         kpbEzkIgZO5d2TmzRnzhtDjs7he/GdSVYBu909kzc/Ij+o1fo301DY1bhFS/y7dUq536
         TJIasI7YxzpKNNtNjKpdqXJ0GxQg3X8Dn91ZnWhmoqa8JAQdkKb2gt205i8J2xiUq3V7
         a8Xhb3M1QiERjLPjXUlJ7pIl4e1Y5S6MzdsF/h/oUN4MMW4GQkMfXShwvis9gENElFrS
         0d9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+rTqiyEyTcsjP0xyYZP/sz2SwheWx3kWrvomWaMtpJ4=;
        fh=QSzTTlL6SCzcp9IpLNam+GpESxCVTUDDOBVOvvyXEQ0=;
        b=fns9zw+AGTdk+1vQleq0ITD1IShM+1n9EEJvkBGGJJJD5wu7CTbRH9ZtqKSgV4CWeX
         /gmoFWItw85NZYZtcqODbTGq4zJCuQB6f3WRlvlXLz1YFUUqrO9xrb9YD8C0466hlntu
         Uk5SAZCMhXHFMjsU58PC56EERHSceIIleSwXwnCc42SGLNYkV2zijovGGoI7CUZzfc6S
         8/ZrVROEDNVt9ijHchH3KlbyepXzR1TT7RPEmcxR9K6FBHyhjLYz9aZI2ZWNVPZqeE8Q
         mCMXtx2qrTaaLDNiKNePwxD1Oiv8K8FY6Q9wJkRSRxRneB5jJtrvzRf4Ow/KqIA2Lpgs
         apKg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795562575; x=1796167375; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+rTqiyEyTcsjP0xyYZP/sz2SwheWx3kWrvomWaMtpJ4=;
        b=TiXHZcBr+zGyCM8/LnSrTnONo/QO3AmfuwKkKWU8Bev7fapUfw1GvWKRNby+tAbuUr
         8L9yNuiArj3IGZvz6hIImnMT7Td5rnTkA7rPV3KRS75r847AsNwcR5Zcl96ppxHQy76o
         faV4SDWTTeXZrOq7AmGv05l3cwUez45RmOLf4pdlcctSNyxs62LTlAI7K66lKF1FIhmX
         QlEb2t0zPJSQUZtFWnV6Qa2Smqh6LnC/3P7fYl4p8WEtjUvVWAiI0OZmbHcWq1t20iNR
         q4iyX7gI4xNc5DtUtqg0GFO34MLFEsPfvW75vRqfjsEPE25VL3UZ4tom3bXNjJANjEzQ
         LSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795562575; x=1796167375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rTqiyEyTcsjP0xyYZP/sz2SwheWx3kWrvomWaMtpJ4=;
        b=PLSzN0CT1Zg0n8xLG4oPlIF8kldfhNd4w/4Hz1N0tgnmPYn2g7kMAnjPBRdQ5ZhJer
         aDed7w8bpiKEd/FERSETWJoVWXIqUIV8MFDWIyUIC+393tugdpTIe7C1PJMTDJimx1/1
         twy2ZsaTZYKmah0jYUASp4WFKPaPmjlMC9O7SUyyrOrNMKe2kf4vBaT/Eci2DU0G7puz
         wxOWpbcXDmfNqw/vjgpNvr/TxqT6iM+SWdXBI7XX/jnvg5n8zVWRXBZQbbuKn77dAiVO
         7m4pUcvtd+skp+YObPtNC2yRrOgnva0D2J6L1Rsx8VoUAb6xotCK5O/sAjeb9PV7Kr0l
         EAAg==
X-Forwarded-Encrypted: i=1; AL+hErFmGiUcwxhSX+PflWSm+axEvVUREBUTFhkVe05HcOG/buvTSqx80mhJj3EbMaUTtcDzEJh5oQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9cwWeQWKH0PI9GJ/GgeFKbpqVcHx+LpFpke/Q6EqdNmBJ87kBE
	TCfcO+AaJJgGhsey+K7c2ESxgOYA3ai0Hm/gaYC2mp4HYjXUmdi/vCxD1RFxLhp/QHeEtjlCUXu
	w1oHCUDpzwrxEh+hRRyBs+fnxJrFX/9M=
X-Gm-Gg: AZFdTZdF9E2bhzkw5JK6hjdaGsRf5b63eM+IFDGgglpIQ8l3rGPNZuI8b3Nuf4Mnkk3
	9kkAjydpyMmPtTcCPWQ+3h0bP7RpkMvSrBA3Tnbd4LMA0yjZeC6tNfDZD+NJXsAGP3cPHpryrTx
	Tx5R6/zOCFkEfiDsUds0GYTnEP92ab8W5vb1yc4Fb5ARfDC9Qr6QK5fu6tpzCM5nh1BkaOyiuBT
	8OsBCYjnaGULw2lQMBe/N4rAwvE5ErHa98SuPQ+Pq/B9fJPuDx/agG/oBCam8Ycl7+w9jDl3qEN
	7bA/mkdAuYvXY+mfw/L0TftjACsrwHN4krZd2We/cs+fv4UG3BzjbdfKngD2qxa1wc/YPAkRE3h
	W16c00XmLeCPjc1Pum1DlrtOFywCsCCdgM8WuiM8t8IPJumUBept/7OvY0wEvUqZiBMHM0zDTvJ
	sT8+p/PqQJrCEyNA1Vo6lALBk=
X-Received: by 2002:a05:6402:3551:b0:6bb:2049:ca7a with SMTP id
 4fb4d7f45d1cf-6bb2049ce09mr530944a12.30.1795562574801; Tue, 24 Nov 2026
 15:22:54 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261115103809.1288167-1-linmag7@gmail.com> <20261115103809.1288167-3-linmag7@gmail.com>
 <awVzJMLVw4wUSqky@monoceros>
In-Reply-To: <awVzJMLVw4wUSqky@monoceros>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Wed, 25 Nov 2026 00:22:43 +0100
X-Gm-Features: Aa3M54p40jvWYlRgIpwdomsHYhgnFpDsLhI0rv_i2dkIsTGssHPloMOWlC-TIyE
Message-ID: <CA+=Fv5QJxoxEoKxRpm5Hisdf=y+VpmM-s_VBC1tDQ2FTCfb08w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] alpha: enable contiguous memory allocation for
 coherent DMA
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: richard.henderson@linaro.org, mattst88@gmail.com, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-next@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org, 
	Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Uwe,

On Tue, Nov 24, 2026 at 12:32=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@baylibre.com> wrote:
>
> Hello,
>
> On Sun, Nov 15, 2026 at 11:37:43AM +0100, Magnus Lindholm wrote:
> > Select HAVE_DMA_CONTIGUOUS and reserve a default CMA area after the
> > machine has initialized its DMA windows. Prefer top-down placement
> > below the direct-map and usable RAM limits. Skip the default reservatio=
n
> > when no direct-map window exists. Explicit cma=3D ranges retain their
> > generic override semantics; top-down placement is a preference, not a
> > hard lower bound excluding the first 16 MiB.
> >
> > Use dma_alloc_contiguous(), which rejects non-blocking callers, before
> > falling back to alloc_pages_exact(). Pair both paths with
> > dma_free_contiguous(), whose buddy fallback uses free_pages_exact().
> > Skip CMA on the GFP_DMA retry after a mapping failure so it cannot
> > return the same unsuitable CMA pages. Retain zeroing for CMA memory.
> >
> > Round the size up to a page boundary in both allocation and free. CMA
> > allocates size >> PAGE_SHIFT pages, so an unaligned size could otherwis=
e
> > allocate too few pages and overrun the allocation during zeroing. Keep
> > the mapping and unmapping lengths consistent with the aligned size.
> >
> > With CONFIG_DMA_CMA=3Dy, the default CMA_SIZE_MBYTES setting reserves
> > 16 MiB without a cma=3D argument. cma=3D0 disables the default area.
> >
> > Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
> > ---
> >  .../io/dma-contiguous/arch-support.txt        |  2 +-
> >  arch/alpha/Kconfig                            |  1 +
> >  arch/alpha/kernel/pci_iommu.c                 | 19 +++++++++++++------
> >  arch/alpha/kernel/setup.c                     | 15 +++++++++++++++
> >  4 files changed, 30 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/features/io/dma-contiguous/arch-support.txt =
b/Documentation/features/io/dma-contiguous/arch-support.txt
> > index 3c6ce35d704f..6cd205a991f6 100644
> > --- a/Documentation/features/io/dma-contiguous/arch-support.txt
> > +++ b/Documentation/features/io/dma-contiguous/arch-support.txt
> > @@ -6,7 +6,7 @@
> >      -----------------------
> >      |         arch |status|
> >      -----------------------
> > -    |       alpha: | TODO |
> > +    |       alpha: |  ok  |
> >      |         arc: | TODO |
> >      |         arm: |  ok  |
> >      |       arm64: |  ok  |
> > diff --git a/arch/alpha/Kconfig b/arch/alpha/Kconfig
> > index 6ccb2d230326..cddc1f3af209 100644
> > --- a/arch/alpha/Kconfig
> > +++ b/arch/alpha/Kconfig
> > @@ -30,6 +30,7 @@ config ALPHA
> >       select HAVE_ARCH_COMPILER_H
> >       select HAVE_ASM_MODVERSIONS
> >       select HAVE_DEBUG_KMEMLEAK
> > +     select HAVE_DMA_CONTIGUOUS
> >       select HAVE_GUP_FAST
> >       select HAVE_KERNEL_BZIP2
> >       select HAVE_KERNEL_GZIP
> > diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iomm=
u.c
> > index 955b6ca61627..19aa5c05de2b 100644
> > --- a/arch/alpha/kernel/pci_iommu.c
> > +++ b/arch/alpha/kernel/pci_iommu.c
> > @@ -408,15 +408,20 @@ static void *alpha_pci_alloc_coherent(struct devi=
ce *dev, size_t size,
> >  {
> >       struct pci_dev *pdev =3D alpha_gendev_to_pci(dev);
> >       void *cpu_addr;
> > -     long order =3D get_order(size);
> > +     struct page *page;
> >
> > +     size =3D PAGE_ALIGN(size);
> >       gfp &=3D ~GFP_DMA;
> >
> >  try_again:
> > -     cpu_addr =3D (void *)__get_free_pages(gfp | __GFP_ZERO, order);
> > +     /* A low-memory retry must not return the same unsuitable CMA pag=
es. */
> > +     page =3D (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size,=
 gfp);
> > +     if (page)
> > +             cpu_addr =3D page_address(page);
> > +     else
> > +             cpu_addr =3D alloc_pages_exact(size, gfp | __GFP_ZERO);
> >       if (! cpu_addr) {
> > -             printk(KERN_INFO "pci_alloc_consistent: "
> > -                    "get_free_pages failed from %ps\n",
> > +             pr_info("pci_alloc_consistent: allocation failed from %ps=
\n",
> >                       __builtin_return_address(0));
> >               /* ??? Really atomic allocation?  Otherwise we could play
> >                  with vmalloc and sg if we can't find contiguous memory=
.  */
> > @@ -426,7 +431,7 @@ static void *alpha_pci_alloc_coherent(struct device=
 *dev, size_t size,
> >
> >       *dma_addrp =3D pci_map_single_1(pdev, virt_to_phys(cpu_addr), siz=
e, 0);
> >       if (*dma_addrp =3D=3D DMA_MAPPING_ERROR) {
> > -             free_pages((unsigned long)cpu_addr, order);
> > +             dma_free_contiguous(dev, virt_to_page(cpu_addr), size);
>
> On next-20261123 I get a build error on an ARCH=3Dalpha allmodconfig buil=
d
>
> arch/alpha/kernel/pci_iommu.c: In function =E2=80=98alpha_pci_alloc_coher=
ent=E2=80=99:
> arch/alpha/kernel/pci_iommu.c:418:41: error: too few arguments to functio=
n =E2=80=98dma_alloc_contiguous=E2=80=99; expected 4, have 3
>   418 |         page =3D (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(de=
v, size, gfp);
>       |                                         ^~~~~~~~~~~~~~~~~~~~
> In file included from arch/alpha/kernel/pci_iommu.c:14:
> include/linux/dma-map-ops.h:105:14: note: declared here
>   105 | struct page *dma_alloc_contiguous(struct device *dev, size_t size=
, gfp_t gfp,
>       |              ^~~~~~~~~~~~~~~~~~~~
>
> which seems to be a conflict between
>
>         next-20261123~159^2 =3D f03df6019b56 ("alpha: enable contiguous m=
emory allocation for coherent DMA")
>
> from
> https://git.kernel.org/pub/scm/linux/kernel/git/lindholm/alpha.git for-ne=
xt
>
> and
>
>         next-20261123~104^2~23^2~7 =3D 31f7e12d621b ("dma-contiguous: pas=
s the NUMA node to dma_alloc_contiguous()")
>
> from
> https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dma_alloc_=
coherent_node
>
> I guess the right thing to do is to pull
>
>         https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git dm=
a_alloc_coherent_node
>
> into the alpha tree and fix the offending function call in the merge
> commit.

Thanks for catching this and identifying the interacting commits.

I reproduced the error on next-20261123. In
arch/alpha/kernel/pci_iommu.c, I changed:

page =3D (gfp & GFP_DMA) ? NULL : dma_alloc_contiguous(dev, size, gfp);

to:

page =3D (gfp & GFP_DMA) ? NULL :
dma_alloc_contiguous(dev, size, gfp, dev_to_node(dev));

This fixes the allmodconfig pci_iommu.o build. A full DP264 UP build
with CMA enabled also passed, as did an object build with CMA disabled.
The full allmodconfig build hit an unrelated cgroup sample error
involving PATH_MAX and LINE_MAX.

I'd prefer to keep the Alpha tree independent of the DMA series.
Could we coordinate with Jakub and Marek to carry the adjustment in
linux-next and ensure it reaches Linus when both changes are present?
I'm happy to help with further testing.

If that proves awkward, I can remove the CMA patch from for-next and
defer it to a separate Alpha pull request once the DMA changes have
landed, updating the caller then.

Thanks,
Magnus

>
> Best regards
> Uwe
