Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8E01A8C33;
	Thu, 20 Jun 2024 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718878644; cv=none; b=q2H+ep20E1XUsfT/SA1TBuP6bOBBFJ3oZXDyOrRup3gC4weVM87WXazIoNBfp96zZgB5DivVDJWa3eoedetGJwfJx79Y0dUtReFCy9ca63Ho5a1QPirvK+FX4y0RgMQAPYvKhNd9qGvMLqnwzCwz5BZMcLqE3KzsFh9bTPVjbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718878644; c=relaxed/simple;
	bh=1I3ur0ocbWFP4fWAh3mMdb00sUlMHr9RGoHljdDyqIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unnwcQG6w9+mpX481yDQ7kmT7p1HxlSAtjtLVtSpHWY2HBHbVJxR2xgvmHCbNWZyGSPaXRpJbAnXKVEUMW+oF3izpXLYYBlHGO1Q2rZ7K/SuWVLL7+akQy6Mx/5NlNw8N80WdMfksynVItKlYdBX3Op0AKf6tKDeL92vYnPgvo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so8321221fa.2;
        Thu, 20 Jun 2024 03:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718878638; x=1719483438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d+lxYOzrcMs2AvPs+DTpEs/Zqfcyw5bdiw2jrVTDM7w=;
        b=Ew6hrIv5sOnSTDjmJvsa5ZeAugPdUilK7KiBGPe58EkGitDhGGg69vg8AGtjFdIhyq
         VzCw66jx9dUkSZjDZ2pH6TJOLZtzWabYz46+0zSMmFQwPqsUwicNA8slIV36ApnzdV9j
         xakL5gD0TJUTdMpZ8cNGC/08NezCRYRluNrbaG62HiuGJLHZCUrz2l0AD3sX6MYXp6bm
         1HlkdFDg93W/BMgW0xcYnCZnhCau/LZiNNfRNDfgKBeHKYEAOZodJYbF+mjGc+lM8Lut
         Q4ET3LzwA/NgF9GWOeoJsxrLCAvEjLVuB88g21dtqHapbaQ8yEQPasHv15rzltngXLi7
         tgVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHlBodXV+49X78/ky15DP3BTKZ54hq5X+BBzTG4nGsa7E8PPfmOPlUMF082zYeVwMVvOdjustd6fjZ0alOAy3N/18JYbLpS4ShLMlUKGDJ4IGmOimMFZH7qbEAABEtAkCimw==
X-Gm-Message-State: AOJu0YzlNTQAfGnLvRzopqYPPikGP7g/ctn72K+GrRBfiCchUEI1RQxj
	wrfszTKaGWv6eAJgzPTUd/4oXNMx1OGkom45QBSq60Cse6XP/rOSFdsStV0tkd4=
X-Google-Smtp-Source: AGHT+IHtB7K+FwMmpSz69v8FK34osA899bl8Q6COMOCJK6GgQk8omN2LzcNdsheVl+C8pJ4akgeokg==
X-Received: by 2002:a05:6512:3b29:b0:52c:9ab1:a312 with SMTP id 2adb3069b0e04-52ccaa5850bmr4004171e87.4.1718878638183;
        Thu, 20 Jun 2024 03:17:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52caecd7edasm1575195e87.275.2024.06.20.03.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 03:17:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec002caeb3so8320671fa.2;
        Thu, 20 Jun 2024 03:17:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxGfelQdMrxZpRZN7u7fSZnb/oxm89IJ8ki1OxacIdg5IlX+USH9nzsrVZfXUJhMHhzbaF9ifcC1lbW5oCv6LwA/XrWUm6y7FGB/ZKSttsKmviSJHOrM/WeVPKFoyvSaz2ZA==
X-Received: by 2002:a2e:740a:0:b0:2eb:f7a4:7289 with SMTP id
 38308e7fff4ca-2ec3cfe1769mr29351241fa.51.1718878637724; Thu, 20 Jun 2024
 03:17:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240616224056.29159-1-andre.przywara@arm.com> <20240616224056.29159-3-andre.przywara@arm.com>
In-Reply-To: <20240616224056.29159-3-andre.przywara@arm.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 20 Jun 2024 18:17:01 +0800
X-Gmail-Original-Message-ID: <CAGb2v66mFF6ayXtTQk2C9EaH3TJ=3uVJr_y3WvCkdPmVE43S+w@mail.gmail.com>
Message-ID: <CAGb2v66mFF6ayXtTQk2C9EaH3TJ=3uVJr_y3WvCkdPmVE43S+w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] iommu: sun50i: allocate page tables from below 4 GiB
To: Andre Przywara <andre.przywara@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
	Chris Morgan <macromorgan@hotmail.com>, Ryan Walklin <ryan@testtoast.com>, 
	Philippe Simons <simons.philippe@gmail.com>, iommu@lists.linux.dev, 
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 6:42=E2=80=AFAM Andre Przywara <andre.przywara@arm.=
com> wrote:
>
> The Allwinner IOMMU is a strict 32-bit device, with its input addresses,
> the page table root pointer as well as both level's page tables and also
> the target addresses all required to be below 4GB.
> The Allwinner H6 SoC only supports 32-bit worth of physical addresses
> anyway, so this isn't a problem so far, but the H616 and later SoCs exten=
d
> the PA space beyond 32 bit to accommodate more DRAM.
> To make sure we stay within the 32-bit PA range required by the IOMMU,
> force the memory for the page tables to come from below 4GB. by using
> allocations with the DMA32 flag.
> Also reject any attempt to map target addresses beyond 4GB, and print a
> warning to give users a hint while this fails.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

> ---
>  drivers/iommu/sun50i-iommu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
> index dd3f07384624c..20a07f829085d 100644
> --- a/drivers/iommu/sun50i-iommu.c
> +++ b/drivers/iommu/sun50i-iommu.c
> @@ -602,6 +602,14 @@ static int sun50i_iommu_map(struct iommu_domain *dom=
ain, unsigned long iova,
>         u32 *page_table, *pte_addr;
>         int ret =3D 0;
>
> +       /* the IOMMU can only handle 32-bit addresses, both input and out=
put */
> +       if ((uint64_t)paddr >> 32) {
> +               ret =3D -EINVAL;
> +               dev_warn_once(iommu->dev,
> +                             "attempt to map address beyond 4GB\n");
> +               goto out;
> +       }
> +
>         page_table =3D sun50i_dte_get_page_table(sun50i_domain, iova, gfp=
);
>         if (IS_ERR(page_table)) {
>                 ret =3D PTR_ERR(page_table);
> @@ -682,7 +690,8 @@ sun50i_iommu_domain_alloc_paging(struct device *dev)
>         if (!sun50i_domain)
>                 return NULL;
>
> -       sun50i_domain->dt =3D iommu_alloc_pages(GFP_KERNEL, get_order(DT_=
SIZE));
> +       sun50i_domain->dt =3D iommu_alloc_pages(GFP_KERNEL | GFP_DMA32,
> +                                             get_order(DT_SIZE));
>         if (!sun50i_domain->dt)
>                 goto err_free_domain;
>
> @@ -997,7 +1006,7 @@ static int sun50i_iommu_probe(struct platform_device=
 *pdev)
>
>         iommu->pt_pool =3D kmem_cache_create(dev_name(&pdev->dev),
>                                            PT_SIZE, PT_SIZE,
> -                                          SLAB_HWCACHE_ALIGN,
> +                                          SLAB_HWCACHE_ALIGN | SLAB_CACH=
E_DMA32,
>                                            NULL);
>         if (!iommu->pt_pool)
>                 return -ENOMEM;
> --
> 2.39.4
>
