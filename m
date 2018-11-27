From: Honghui Zhang <honghui.zhang@mediatek.com>
Subject: Re: [PATCH 4/9] iommu: mtk_iommu: make it explicitly non-modular
Date: Tue, 27 Nov 2018 09:25:46 +0800
Message-ID: <1543281946.3753.2.camel@mhfsdcap03>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
         <1543271498-28966-5-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543271498-28966-5-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

On Mon, 2018-11-26 at 17:31 -0500, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config MTK_IOMMU_V1
> drivers/iommu/Kconfig:  bool "MTK IOMMU Version 1 (M4U gen1) Support"
> 
> ...meaning that it currently is not being built as a module by anyone.
> 
> Lets remove the modular code that is essentially orphaned, so that
> when reading the driver there is no doubt it is builtin-only.
> 
> Since module_init was not even used by this driver, the init ordering
> remains unchanged with this commit.
> 
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Honghui Zhang <honghui.zhang@mediatek.com>
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>  drivers/iommu/mtk_iommu_v1.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 27867b862d7a..5fbf3cecb87f 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -1,4 +1,6 @@
>  /*
> + * IOMMU API for MTK architected m4u v1 implementations
> + *
>   * Copyright (c) 2015-2016 MediaTek Inc.
>   * Author: Honghui Zhang <honghui.zhang@mediatek.com>
>   *
> @@ -35,7 +37,7 @@
>  #include <linux/spinlock.h>
>  #include <asm/barrier.h>
>  #include <asm/dma-iommu.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>  #include <dt-bindings/memory/mt2701-larb-port.h>
>  #include <soc/mediatek/smi.h>
>  #include "mtk_iommu.h"
> @@ -704,15 +706,4 @@ static int __init m4u_init(void)
>  {
>  	return platform_driver_register(&mtk_iommu_driver);
>  }
> -
> -static void __exit m4u_exit(void)
> -{
> -	return platform_driver_unregister(&mtk_iommu_driver);
> -}
> -
>  subsys_initcall(m4u_init);
> -module_exit(m4u_exit);
> -
> -MODULE_DESCRIPTION("IOMMU API for MTK architected m4u v1 implementations");
> -MODULE_AUTHOR("Honghui Zhang <honghui.zhang@mediatek.com>");
> -MODULE_LICENSE("GPL v2");

Hi, Paul,
Thanks for your patch.

I would like the patch tile be:
iommu/mediatek: make it explicitly non-modular

except that,

Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>
