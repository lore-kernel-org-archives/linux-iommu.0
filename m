From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH v9 01/16] iommu/exynos: do not include removed header
Date: Thu, 08 Aug 2013 15:42:24 +0200
Message-ID: <21505674.fdNgPGp76O@amdc1227>
References: <002501ce941a$e3d87f40$ab897dc0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <002501ce941a$e3d87f40$ab897dc0$@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Cho KyongHo <pullip.cho@samsung.com>
Cc: 'Linux ARM Kernel' <linux-arm-kernel@lists.infradead.org>, 'Linux IOMMU' <iommu@lists.linux-foundation.org>, 'Linux Kernel' <linux-kernel@vger.kernel.org>, 'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, 'Joerg Roedel' <joro@8bytes.org>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Prathyush' <prathyush.k@samsung.com>, 'Rahul Sharma' <rahul.sharma@samsung.com>, 'Subash Patel' <supash.ramaswamy@linaro.org>, 'Grant Grundler' <grundler@chromium.org>, 'Antonios Motakis' <a.motakis@virtualopensystems.com>, kvmarm@lists.cs.columbia.edu, 'Sachin Kamat' <sachin.kamat@linaro.org>
List-Id: iommu@lists.linux-foundation.org

Hi KyongHo,

On Thursday 08 of August 2013 18:37:25 Cho KyongHo wrote:
> This commit remove <mach/sysmmu.h> which is removed.

I would prefer a more meaningful commit message, something among following 
lines:

8<---
Commit 25e9d28d92 (ARM: EXYNOS: remove system mmu initialization from 
exynos tree) removed arch/arm/mach-exynos/mach/sysmmu.h header without 
removing remaining use of it from exynos-iommu driver, thus causing a 
compilation error.

This patch fixes the error by removing respective include line from exynos-
iommu.c.
--->8

Also a sentence explaining why linux/kernel.h header must be included would 
be nice.

> Signed-off-by: Cho KyongHo <pullip.cho@samsung.com>

Please note that as far as I'm aware of, tags should be made using western 
name writing convention, i.e. starting with first name.

Best regards,
Tomasz

> ---
>  drivers/iommu/exynos-iommu.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
> index 3f32d64..233f382 100644
> --- a/drivers/iommu/exynos-iommu.c
> +++ b/drivers/iommu/exynos-iommu.c
> @@ -12,6 +12,7 @@
>  #define DEBUG
>  #endif
> 
> +#include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> @@ -29,8 +30,6 @@
>  #include <asm/cacheflush.h>
>  #include <asm/pgtable.h>
> 
> -#include <mach/sysmmu.h>
> -
>  /* We does not consider super section mapping (16MB) */
>  #define SECT_ORDER 20
>  #define LPAGE_ORDER 16
