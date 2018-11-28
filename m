From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 5/9] iommu: ipmmu-vmsa: make it explicitly non-modular
Date: Wed, 28 Nov 2018 12:50:12 +0000
Message-ID: <cdded4c3-4bc5-39b3-ebc9-64fa145c9242@arm.com>
References: <1543271498-28966-1-git-send-email-paul.gortmaker@windriver.com>
 <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543271498-28966-6-git-send-email-paul.gortmaker@windriver.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Gortmaker <paul.gortmaker@windriver.com>, Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
List-Id: iommu@lists.linux-foundation.org

On 26/11/2018 22:31, Paul Gortmaker wrote:
> The Kconfig currently controlling compilation of this code is:
> 
> drivers/iommu/Kconfig:config IPMMU_VMSA
> drivers/iommu/Kconfig:        bool "Renesas VMSA-compatible IPMMU"
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
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: iommu@lists.linux-foundation.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> ---
>   drivers/iommu/ipmmu-vmsa.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 9e2655f1c1bf..de39ef992d8a 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -1,6 +1,8 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /*
>    * IPMMU VMSA

Nit: this line doesn't convey any information that the module 
description below doesn't also say far more clearly, so you may as well 
just replace it entirely.

Robin.

> + * IOMMU API for Renesas VMSA-compatible IPMMU
> + * Author: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>    *
>    * Copyright (C) 2014 Renesas Electronics Corporation
>    */
> @@ -14,7 +16,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/io.h>
>   #include <linux/iommu.h>
> -#include <linux/module.h>
> +#include <linux/init.h>
>   #include <linux/of.h>
>   #include <linux/of_device.h>
>   #include <linux/of_iommu.h>
> @@ -968,7 +970,6 @@ static const struct of_device_id ipmmu_of_ids[] = {
>   	},
>   };
>   
> -MODULE_DEVICE_TABLE(of, ipmmu_of_ids);
>   
>   static int ipmmu_probe(struct platform_device *pdev)
>   {
> @@ -1140,15 +1141,4 @@ static int __init ipmmu_init(void)
>   	setup_done = true;
>   	return 0;
>   }
> -
> -static void __exit ipmmu_exit(void)
> -{
> -	return platform_driver_unregister(&ipmmu_driver);
> -}
> -
>   subsys_initcall(ipmmu_init);
> -module_exit(ipmmu_exit);
> -
> -MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
> -MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
> -MODULE_LICENSE("GPL v2");
> 
