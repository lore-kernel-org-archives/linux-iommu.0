Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9646B9
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 13:15:46 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id t25so2744879lfg.7
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y48E6PDFxhOGhAYVKqWlob2V1GffQky6+hara5tcdLo=;
        b=x9Hqw1BTgXzHKBiG2OLYcS2qRp7Sz3flmFvjdYEncU8GDBZQGFzRHDqWvl2GZEQzWs
         FsmPaPtuFGaiqKXQ0rgYuY1IJvGT9XHaKIiGie3uBqCYb5yZUxsGKCGerqVb/EDy2MQy
         BrkIPlpMjIIODx0OZIpPfuVTK/CPTmssfDzD87fRsv5/iF7Rkgzt3wvFTahxaqIGZ+wF
         b0LxvmpRxROYRG7PvrgPGM3wSIagrIcIKwRXmd8quwYVM2XgRpqq7+pGhei6aj5AEZ1a
         ZxtNyfAEF5Qg5TkVb401bU9vk1vAqt7Jy4UkztS6JIJpbx4jaxv5mhURfqXHgOZyi+xk
         gVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y48E6PDFxhOGhAYVKqWlob2V1GffQky6+hara5tcdLo=;
        b=Ri8pqQLjW2YkrXvHoT/DPgfWMoRufTtC9bN1QLoJbkKh3OLe9vX1aWy+sTjEoPUBdK
         rjgkh3MUYPZ7yDA/rLszAt3WqnnIF7M4sHASjbKiWXOzZ7OGbk18Uh8isEnJug3qTngN
         X0BhvBRf97kpJ86wBdA6ac0t89xL7hsvjrJawh2QMxVkMj6f++Gg6JuJLwX1ol1OFjZL
         FgwECq8LL2kdfmdnKEnSoAab94PV5U1ebVyolq9Kb+755L2Cevkqzpi2z9MXAAS7rf8z
         EkBElGBuXlDR5wyzOlOlYz8/xaSs50ZMrvE7IiyivbdjK6xaDV27/+muIpiyA2+4ErRq
         JEpg==
X-Gm-Message-State: AJIora91W6V5ZUPD4hTDZNhxDkK6Q+dhS+EKCtUEPIlejl0xrY2M2SNK
	SazVe9dbkle0ZAsFaXVto92tRNzW1Me0uxBvyqs0og==
X-Google-Smtp-Source: AGRyM1umM56+JO1HV8nicFnjzJ1pyPk04eb7pywiBmEsbAuvhiuDTIjoJzE4r2MPwg7ysTsXe877jrrGJ/WnekYwUVQ=
X-Received: by 2002:a05:6512:139a:b0:48a:1a73:8adc with SMTP id
 p26-20020a056512139a00b0048a1a738adcmr1218415lfa.226.1657804544526; Thu, 14
 Jul 2022 06:15:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
 <20220710230603.13526-5-semen.protsenko@linaro.org> <4d198463-fedc-a5d9-6804-63c134da76e7@linaro.org>
In-Reply-To: <4d198463-fedc-a5d9-6804-63c134da76e7@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Thu, 14 Jul 2022 16:15:33 +0300
Message-ID: <CAPLW+4ktP0_W_OgjAoK3BXOFaEiXvP1qNGCc-iQyr2fNL1srug@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] iommu/exynos: Use lookup based approach to access registers
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Jul 2022 at 19:52, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

[snip]

> > +static void sysmmu_write(struct sysmmu_drvdata *data, size_t idx, u32 val)
> > +{
> > +     writel(val, data->sfrbase + data->regs[idx]);
>
> Beside what Robin wrote, I also don't think these wrappers actually
> help, because you reverse arguments comparing to writel.
>
> How about having a per-variant structure with offsets and using it like:
>
> #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
> writel(CTRL_ENABLE, SYSMMU_REG(data, mmu_ctrl_reg))
>
> Would that be more readable?
>

Yes, this looks better for my taste too. I tend to get a tunnel vision
when working with downstream code for a while. But I noticed that that
approach is used sometimes as well, e.g. in
drivers/pinctrl/samsung/pinctrl-exynos-arm64.c (in struct
samsung_pin_bank_type). Anyway, I've reworked it exactly as you
suggested, will send v2 soon. Thanks!

>
> Best regards,
> Krzysztof
