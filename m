Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BF57F490
	for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718789020; cv=none; b=kFHCxb+TTXNA+ao2rOjIBhgj517H1yT30l2awUnoX9q4HCCZ+MBgqnU6zNW1ekG7idJB8o28QFyiTaP2CQ5ChWEu0oiJ+6vEkR1R3r/mRGiQ5VFDSQYkXqDX28F9WeBB+15J2WF8fRkbBuBMU7EWEYck0QIeUSidLP5tMdeN1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718789020; c=relaxed/simple;
	bh=c6mCFLDwnEj0M0yPmsIQCRB4t/fBDoZ4qwONT/Fjbec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIqXDryCPUCchFiiNVSHeYIae2Xmse64/YD2FRQNvW1hPoC2Ie8ZJd+FdBCAcUyHwxxZ60REKBGgNfkr4EL0ZAaTMAWdkWQictyCKgvzg4MJLix36wP9lwmjyAH7sBrAsCPZKzMiSUG6xkE/DeUsi9XxiY53Qp76/GHGO21sjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=HQi6BQjg; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="HQi6BQjg"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6ef46d25efso777753966b.0
        for <iommu@lists.linux.dev>; Wed, 19 Jun 2024 02:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1718789017; x=1719393817; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E02jv30Jn5KEyH9ZDrmzhOXntMuebj1OtVrel1S6NPY=;
        b=HQi6BQjgT+VjNsnMcghhllK8eYt7N4/3ZXocjHJek1vvTb183l3ICkuv8bv6kLN+jz
         yxYT2DBKubHcSYek9Sqq0T1CXidh4XWnpaVV19u4ZfmFNN5heSw5zr8u6LHp1T5kk4Ix
         Nn8EPqVARemv2mIJbhP3wDRONnqkl1JQ6y9jY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718789017; x=1719393817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E02jv30Jn5KEyH9ZDrmzhOXntMuebj1OtVrel1S6NPY=;
        b=X+9XtSpv9UraLKloPD5K4WcnogWQDzzx3cn0R+RRzCAnO1PsKW9WZg1/1nQ23qg1qG
         gcCQrNNUOBs6zw0cNtqTCMrbMhP07f2awn3855QvQj4Ps1sI9GObUtcQ2uemjbyqipfX
         Ip0vRiGlHGJdSwDWwInHYwGu+6RzFK+RrOZzInnxa3CHZ24Ua4BIye7Y2NWih7tPC0lg
         15IQuHLjQFj9PSRGSCdLAxcxnay87dAwyON+R+ydMvQ3tb5jWRblHvXUd0I4T3a+zGsD
         bKTptyp908DFdcb3X3rIgHF41euixeQGnf1kef7YU4kHwjRyRHSSZIK76d2Di9H0iiVC
         dW0g==
X-Forwarded-Encrypted: i=1; AJvYcCU/m082o0CYGZHr8pZikBTjY+AtVjgjIHZtbQ10rTDp2fqhmKqH2Zr5kSiu4+ud0ri9mpg1ia7RX4N9VtA7zSOQ/zvW23o=
X-Gm-Message-State: AOJu0Yy08YBl32fRO+Lu4VxQDgsgSse1T3p9MVrB1wixVOG327nGrC8E
	DQaTWWAkgCUtsmAGj19FRg6id7sJmq1oS7W21dVgGAqQaUVY1UXtP7Q2tmDEQTFdMRVsVV+FDaQ
	u0rPCdnQhojx67JIfRBp1H7qgo43Bo7btFOEG9w==
X-Google-Smtp-Source: AGHT+IFKQvk8lAQ+nFDkshiq3A/6mD+WFlIPkfhgxOHvbp51SeWW3bgS+ClQyEOwinwc3A2jk5hQBWZfiwOzdNFxXfc=
X-Received: by 2002:a17:906:130a:b0:a6f:97b4:d1a5 with SMTP id
 a640c23a62f3a-a6fab648ac6mr95888166b.40.1718789016391; Wed, 19 Jun 2024
 02:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240619091737.669040-1-albertosecondi@gmail.com>
In-Reply-To: <20240619091737.669040-1-albertosecondi@gmail.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 19 Jun 2024 11:23:24 +0200
Message-ID: <CAOf5uwk_i5yA+K=riMcP9r4V9FynRBv2+=P98xUMvmvBtJr4Mg@mail.gmail.com>
Subject: Re: [PATCH] New config added to handle 64-bit systems with 32-bit DMA support
To: Alberto Secondi <albertosecondi@gmail.com>
Cc: hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	alberto.secondi@abinsula.com, Davide Salaris <davide.salaris@abinsula.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alberto

On Wed, Jun 19, 2024 at 11:20=E2=80=AFAM Alberto Secondi
<albertosecondi@gmail.com> wrote:
>
> From: Alberto Secondi <alberto.secondi@abinsula.com>
>
> The kernel assumes that 64-bit systems have 64-bit DMA support through
> CONFIG_ARCH_DMA_ADDR_T_64BIT. This is not always true; for example, sever=
al
> iMX8 systems (verified on iMX8MM and iMX8MP) have DMA with only 32-bit su=
pport.
> This results in several drivers requesting DMA_BIT_MASK(64), which causes
> malfunctions, particularly when systems have more than 3GB of DRAM (verif=
ied
> with the lan743x driver and iMX8 systems with 4GB of DRAM). Therefore, a =
new
> config ARCH_64BIT_HAS_DMA32_ONLY was added to manage 64-bit systems with =
32-bit
> DMA, which adjusts DMA_BIT_MASK(n) accordingly.
>
> Signed-off-by: Alberto Secondi <alberto.secondi@abinsula.com>
> Co-developed-by: Davide Salaris <davide.salaris@abinsula.com>
> ---
>  include/linux/dma-mapping.h | 4 ++++
>  kernel/dma/Kconfig          | 8 ++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f693aafe221f..629220a777e3 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -74,7 +74,11 @@
>   */
>  #define DMA_MAPPING_ERROR              (~(dma_addr_t)0)
>
> +#ifdef CONFIG_ARCH_64BIT_HAS_DMA32_ONLY
> +#define DMA_BIT_MASK(n)        (((n) > 32) ? ((1ULL<<(32))-1) : ((1ULL<<=
(n))-1))
> +#else
>  #define DMA_BIT_MASK(n)        (((n) =3D=3D 64) ? ~0ULL : ((1ULL<<(n))-1=
))
> +#endif
>

How can this fit configuration where you want to have one Kernel image
for several arm64 machine?

Michael

>  #ifdef CONFIG_DMA_API_DEBUG
>  void debug_dma_mapping_error(struct device *dev, dma_addr_t dma_addr);
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index c06e56be0ca1..0a27eafed808 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -36,6 +36,14 @@ config NEED_DMA_MAP_STATE
>  config ARCH_DMA_ADDR_T_64BIT
>         def_bool 64BIT || PHYS_ADDR_T_64BIT
>
> +config ARCH_64BIT_HAS_DMA32_ONLY
> +        bool "64bit System has DMA32 only"
> +        depends on ARCH_DMA_ADDR_T_64BIT
> +        default n
> +       help
> +         This enables forcing the maximum DMA_BIT_MASK to 32 bits for
> +         64-bit systems that have DMA support limited to 32 bits.
> +
>  config ARCH_HAS_DMA_SET_MASK
>         bool
>
> --
> 2.34.1
>
>
