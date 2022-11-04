Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC36A79FA
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 13:23:10 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id l2so4830871pld.13
        for <iommu@lists.linux.dev>; Fri, 04 Nov 2022 06:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FGHJvH5/D8AJZ7n2XCmfVLOv2o6AE51FHJzxEvvVE44=;
        b=BpgoUe38NeL/o/D6Jm/NVObs1UqmNYQJk47LgTYcILr2lQXRlv/9sKM9HQlcgVBo0R
         e3kReny/m+oeMyWwL0tjLmEL4kp4brYzECmLyzQ48cBxDVInWKvOqaLLSTdoO+ESr0D8
         b2nbQqakZKOmyEuAtCtFW8azxaP6+sAXeqQlw2ZPvraYgBjcTajNMFH1c4v6S/dhAG3u
         tsASK1xNJzPqojy1VufjKAS7Mg8UdRZERLoY8fECuiWNbS2QEfSoQ8xsKzkmOvYQZjMb
         AG2z8+ZMVLFMjk/Ux8j1YMCjdfGFzQb1DcAcbIgjE9r12h0MJjHglgvkQug6WRA6+EFn
         tqYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGHJvH5/D8AJZ7n2XCmfVLOv2o6AE51FHJzxEvvVE44=;
        b=V6MwIsH7E/rvyVwaZaBWMWxNbAiLxoJNzqQGtnTtWuVZ6nVnDSErqBd5cRviNSFMnR
         HV9OZIw/5ZQVESa8fA+vbm4EuhMrjq28VNvjBBa1PChcXMfYyMVGnSBr+eVvbLF96vt1
         JGUnGmnj1yw7biKq+4/6L4mHkchKgv3DkIkT1iS2NQmK/Ol0nBWkmT+ugwtj5npd3LY8
         uJIrRCRGJ9ps+OaKm9LcTIKAOcyeyVWx9akZ3I2d/MxFH95uaIjTSsCuxMMMACFTdFG1
         +8rjB3G145uiC8SrIYdHF5LGMrXY16+9fZVG09SIfyFUXKJkJgSRSr400VhbS4zmJuO1
         ApXQ==
X-Gm-Message-State: ACrzQf31pWFtz43dMopi9yo9jU85euGbwEkU1Cu3kereI4ad3Zut1xeu
	PnIlevrHo5lMLppmdUVwMSkJknKAEb4VCEU78InoIQ==
X-Google-Smtp-Source: AMsMyM7BZsnvLNkCl2tAKwLlXTokCs8ai7sZntekz1mF/3r2vOjkKVkB/V/1pWQJoW8MHgAqbU9RpQ0IY7WaYqrOulA=
X-Received: by 2002:a17:902:e952:b0:17c:7aaa:c679 with SMTP id
 b18-20020a170902e95200b0017c7aaac679mr35952660pll.74.1667568190214; Fri, 04
 Nov 2022 06:23:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CGME20221103195201eucas1p2a6ec2df41ebac3d9ccbb0b252c2cad34@eucas1p2.samsung.com>
 <20221103195154.21495-1-semen.protsenko@linaro.org> <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
In-Reply-To: <a7d9cd18-a328-209c-c89f-afdcb7db3eb0@samsung.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 4 Nov 2022 14:22:57 +0100
Message-ID: <CAPLW+4nrehDSNbjNzh5jWVWH3dMoN+YmXPQfpaTrqB1jjzHT-w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] iommu/exynos: Convert to a module
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Joerg Roedel <joro@8bytes.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Janghyuck Kim <janghyuck.kim@samsung.com>, Cho KyongHo <pullip.cho@samsung.com>, 
	Daniel Mentz <danielmentz@google.com>, David Virag <virag.david003@gmail.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Nov 2022 at 13:10, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 03.11.2022 20:51, Sam Protsenko wrote:
> > As exynos-iommu driver is not a critical platform driver, it can be
> > converted to a loadable module to avoid loading it on non-Exynos
> > platforms in order to improve the RAM footprint. This patch series
> > converts it to a module and does some related cleanups. IOMMU/DMA
> > specifics were taken into the account, so remove/exit methods weren't
> > added.
> >
> > There are two drivers using CONFIG_EXYNOS_IOMMU in their code:
> > DRM_EXYNOS and S5P_MFC. Both were checked, and only a slight change was
> > needed for S5P_MFC driver (patch #6).
>
> Funny, compiling this driver as a module revealed an issue in the driver
> initialization sequence, here is a fix that need to be applied before
> this patchset:
>
> https://lore.kernel.org/all/20221104115511.28256-1-m.szyprowski@samsung.com/
>

I wonder why I didn't stumble upon that issue. Anyway, the fix looks
valid. I'll wait until you finish looking into that NULL pointer
dereference, and then we can figure out how to organize our patches.
Maybe I could send v3, including your patches in the beginning of the
series, etc.

> Besides that, the driver nukes with NULL pointer dereference in
> exynos_iommu_of_xlate() when compiled as a module on ARM 64bit
> Exynos5433 based TM2e board. ARM 32bit based board works fine. I'm
> checking this issue now.
>

Thanks for looking into that, Marek! I've tested the modularization
patch series using my emulated translation driver [1,2]. It works
fine, but exynos_iommu_of_xlate() is only executed once in my case,
when the test driver module is loaded. It's finished successfully
though. Not sure what is the cause of NULL pointer dereferences you're
seeing, alas I still don't have real users of SysMMU driver on my
platform, and my test driver is the only way for me to test it. Please
let me know if I can help in any way (e.g. I can trace some calls on
my board for you).

[1] https://github.com/joe-skb7/linux/blob/e850-96-mainline-iommu/drivers/iommu/samsung-iommu-test.c#L263
[2] https://github.com/joe-skb7/linux/blob/e850-96-mainline-iommu/arch/arm64/boot/dts/exynos/exynos850.dtsi#L477



> > Changes in v2:
> >    - Extracted the "shutdown" method addition into a separate patch
> >    - Added MODULE_DEVICE_TABLE(of, ...) to support hot-plug loading
> >    - Added MODULE_ALIAS("platform:exynos-sysmmu")
> >    - Added fix for S5P_MFC driver to work correctly with EXYNOS_IOMMU=m
> >    - Fixed checkpatch coding style suggestion with "--strict" flag
> >    - Rebased on top of most recent joro/iommu.git:next
> >
> > Sam Protsenko (6):
> >    iommu: Export iommu_group_default_domain() API
> >    iommu/exynos: Fix retval on getting clocks in probe
> >    iommu/exynos: Modularize the driver
> >    iommu/exynos: Implement shutdown driver method
> >    iommu/exynos: Rearrange the platform driver code
> >    media: platform: Use IS_ENABLED() to check EXYNOS_IOMMU in s5p_mfc
> >
> >   drivers/iommu/Kconfig                         |   2 +-
> >   drivers/iommu/exynos-iommu.c                  | 355 +++++++++---------
> >   drivers/iommu/iommu.c                         |   1 +
> >   .../platform/samsung/s5p-mfc/s5p_mfc_iommu.h  |   4 +-
> >   4 files changed, 191 insertions(+), 171 deletions(-)
> >
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>
