Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759425D1E3
	for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916383; cv=none; b=JKOcp1kiOQt+SlIQ5M4G2EoLN0+kz76VwS40hDNiaIdQx4JYvjDjWISv/0mX2bGfsuirdeb2biDqHNkHIrEZw7k4ZxkJk5pUlkVEmdtEMJ5OzZaUBsAr56mrRZpefl16yN2auY3aBccUqo8AqExCBeo8n6foiLTw7TK7p0kiWHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916383; c=relaxed/simple;
	bh=KsyhWDZ9vz2zVV4SSVoQ1RCE2E0KDLZcwTuZVzKJ4U8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJRhsNTaKOZ/pZP6ktePt2Qy4UH4pnpulZJvL3HE+TX4LIM54LRkwsgsEGgB3MW0Kzy4WMSwh8/NqNES87jfn/VQkYkKWFovExXc05dqFdFXZmqIwWp2r9rrIeoWq6CrIYzaCkHDJ6MFoRPesIFnQYytI/Rq6EET6fjQ5e03Vqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ab78e6edb99so807412166b.2
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 08:26:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916378; x=1743521178;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ey1ptOkb7OET1t+PI+4h/aljRyEZhfbvKjRYRUk152Y=;
        b=Lg9bGbZkJji7mBrFRWUXN4MsROwLNxRBAJe+KOZS9vNze9XHzFjfXRjFr2yIKFs7MU
         eUVxKz7TflhklznsgZjvmNJ+kDTsIFrPfW66SNeN30HoJ3N8iN90seBKPx4KTkf4aKM+
         3JRr+eZT5l/faFjJosqh6waKrbsM4bqsDw7Mpa5cC3Bvdh1hjqsEEk+fjU5QCWshTu5C
         S5NzERtrO1rNoMyxZlHJdrGHSad9zcFFDKX9revNRasI/XngLYNoIIlzuO4jMvuNxgWN
         dALdrANdqe9rSmsJo0uPuEOUAlH880tgya3t39bKYvVl5T1/alavDj4YlAWjislgDoeI
         4tUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtOFmC/Ai8r7Q1AQa5MKBpjpUF2ann6nqXSbdlphCqbDaHH/rYHLY5/TM0oSVY3InYzqmSiA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrxnJqU711idmBphCcCiJk1GWnYjsYmglDsNuV+kFALIaLi+Mb
	cF5538wzGeG6bJn7y+Tn189k4IZUCbIv+MPDBVawGefrI5BwoUh9PbU4k4t4GcA=
X-Gm-Gg: ASbGncsPZI4bSRqNcVN/MjJLsevtLZc9YWYxvh6fCX/t5bEnG7mCMnVvKo3x28qZ7ue
	w1tpvfNusFhhUzxQUXdhzvso4OwfA+/t+PzgLD+03Bh7P+jEfvruEH6wUOJS+rcO9WoKBEIZHxx
	dGViBISOQzpsvoea2ppxpZS2LwYsmjTbrdnbrmPnVw0q0HOAKgoQDs9X/o/IxD/IilRYFTj9jOa
	a29OqbX+K6nrMJMCc4FB/Wo6fq901OSMnlX02QTDUdbA81QTlW0qlIVrGjtygSKksLHwGzMP4rY
	hp3mkhxSmVdcxUX1xCGe0WADyVbOGR3bBl9aHYUl7mOzgh7IXbeYSsGcc519NYYCQcb9fK+BMN0
	9uAE9pC4=
X-Google-Smtp-Source: AGHT+IGyabeLH+SLi5USs2xfrocMmUBW5Fk8Cdseedb7Z/EU6OMD7ukGSwyPqoV7Cdnhq98XxHR1AQ==
X-Received: by 2002:a17:907:2d87:b0:ac2:fd70:ddb2 with SMTP id a640c23a62f3a-ac3f2086f35mr1673566766b.2.1742916377781;
        Tue, 25 Mar 2025 08:26:17 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efb51cf6sm878484466b.106.2025.03.25.08.26.16
        for <iommu@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:26:16 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab78e6edb99so807404566b.2
        for <iommu@lists.linux.dev>; Tue, 25 Mar 2025 08:26:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCPnNtrYSYN0c113PEf9aIJ1P4xSAzMBk1ZyTNQ52enXEZLQpk49xfnD3a10+748tm+0OWaw==@lists.linux.dev
X-Received: by 2002:a17:907:97c2:b0:ac6:ba92:79c9 with SMTP id
 a640c23a62f3a-ac6ba927fdbmr398008166b.18.1742916376510; Tue, 25 Mar 2025
 08:26:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com>
In-Reply-To: <53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 16:26:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUtCqwzeWY8G+yHiu4biovymDVb_UtjfYPEQYyYr+dP4Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpxwyaVEoL_gG00SX4u4mmS2G73SUcVvP1i1roPtO6YBwlUw4Ll1yY2FDU
Message-ID: <CAMuHMdUtCqwzeWY8G+yHiu4biovymDVb_UtjfYPEQYyYr+dP4Q@mail.gmail.com>
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Register in a sensible order
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Thu, 20 Mar 2025 at 15:41, Robin Murphy <robin.murphy@arm.com> wrote:
> IPMMU registers almost-initialised instances, but misses assigning the
> drvdata to make them fully functional, so initial calls back into
> ipmmu_probe_device() are likely to fail unnecessarily. Reorder this to
> work as it should, also pruning the long-out-of-date comment and adding
> the missing sysfs cleanup on error for good measure.
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Thanks for your patch!

This fixes the

    sata_rcar ee300000.sata: late IOMMU probe at driver bind,
something fishy here!
    WARNING: CPU: 1 PID: 13 at drivers/iommu/iommu.c:571
__iommu_probe_device+0x208/0x38c

I saw on Salvator-XS with R-Car M3-N.

It does not fix the second issue reported, so it is indeed too early for a
"Closes: https://lore.kernel.org/CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com"
tag.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1081,31 +1081,24 @@ static int ipmmu_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       platform_set_drvdata(pdev, mmu);

Nit: perhaps insert a blank line here, before the comment below?

>         /*
>          * Register the IPMMU to the IOMMU subsystem in the following cases:
>          * - R-Car Gen2 IPMMU (all devices registered)
>          * - R-Car Gen3 IPMMU (leaf devices only - skip root IPMMU-MM device)
>          */
> -       if (!mmu->features->has_cache_leaf_nodes || !ipmmu_is_root(mmu)) {
> -               ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL,
> -                                            dev_name(&pdev->dev));
> -               if (ret)
> -                       return ret;
> +       if (mmu->features->has_cache_leaf_nodes && ipmmu_is_root(mmu))
> +               return 0;
>
> -               ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
> -               if (ret)
> -                       return ret;
> -       }
> +       ret = iommu_device_sysfs_add(&mmu->iommu, &pdev->dev, NULL, dev_name(&pdev->dev));
> +       if (ret)
> +               return ret;
>
> -       /*
> -        * We can't create the ARM mapping here as it requires the bus to have
> -        * an IOMMU, which only happens when bus_set_iommu() is called in
> -        * ipmmu_init() after the probe function returns.
> -        */
> +       ret = iommu_device_register(&mmu->iommu, &ipmmu_ops, &pdev->dev);
> +       if (ret)
> +               iommu_device_sysfs_remove(&mmu->iommu);
>
> -       platform_set_drvdata(pdev, mmu);
> -
> -       return 0;
> +       return ret;
>  }
>
>  static void ipmmu_remove(struct platform_device *pdev)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
