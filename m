Return-Path: <SRS0=FZ/Z=M3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA0DC4320A
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:53:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D14610FB
	for <iommu@archiver.kernel.org>; Wed,  4 Aug 2021 18:53:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 55D14610FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1525F40538;
	Wed,  4 Aug 2021 18:53:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UGN3wIIMA4Ll; Wed,  4 Aug 2021 18:53:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9E3A9401D2;
	Wed,  4 Aug 2021 18:53:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78067C001A;
	Wed,  4 Aug 2021 18:53:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A51DAC000E
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:53:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8643740686
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:53:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rd9GH5-Lq8er for <iommu@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 18:53:41 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E63F44061A
 for <iommu@lists.linux-foundation.org>; Wed,  4 Aug 2021 18:53:40 +0000 (UTC)
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74]
 helo=diego.localnet)
 by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <heiko@sntech.de>)
 id 1mBM1J-0002cI-Lo; Wed, 04 Aug 2021 20:53:37 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: joro@8bytes.org, will@kernel.org, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 08/25] iommu/rockchip: Drop IOVA cookie management
Date: Wed, 04 Aug 2021 20:53:36 +0200
Message-ID: <4512656.mogB4TqSGs@diego>
In-Reply-To: <0d25511c58981ecd0a1f3006dc1c30a73fb7d377.1628094601.git.robin.murphy@arm.com>
References: <cover.1628094600.git.robin.murphy@arm.com>
 <0d25511c58981ecd0a1f3006dc1c30a73fb7d377.1628094601.git.robin.murphy@arm.com>
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org,
 iommu@lists.linux-foundation.org, rajatja@google.com,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Am Mittwoch, 4. August 2021, 19:15:36 CEST schrieb Robin Murphy:
> The core code bakes its own cookies now.
> 
> CC: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>


On a Rockchip rk3288 (arm32), rk3399 (arm64) and px30 (arm64)
with the graphics pipeline using the iommu

Tested-by: Heiko Stuebner <heiko@sntech.de>
Acked-by: Heiko Stuebner <heiko@sntech.de>


Works now nicely on both arm32 and arm64


Thanks
Heiko


> 
> ---
> 
> v3: Also remove unneeded include
> ---
>  drivers/iommu/rockchip-iommu.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 9febfb7f3025..5cb260820eda 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -10,7 +10,6 @@
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
> -#include <linux/dma-iommu.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/errno.h>
>  #include <linux/interrupt.h>
> @@ -1074,10 +1073,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  	if (!rk_domain)
>  		return NULL;
>  
> -	if (type == IOMMU_DOMAIN_DMA &&
> -	    iommu_get_dma_cookie(&rk_domain->domain))
> -		goto err_free_domain;
> -
>  	/*
>  	 * rk32xx iommus use a 2 level pagetable.
>  	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
> @@ -1085,7 +1080,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  	 */
>  	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
>  	if (!rk_domain->dt)
> -		goto err_put_cookie;
> +		goto err_free_domain;
>  
>  	rk_domain->dt_dma = dma_map_single(dma_dev, rk_domain->dt,
>  					   SPAGE_SIZE, DMA_TO_DEVICE);
> @@ -1106,9 +1101,6 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>  
>  err_free_dt:
>  	free_page((unsigned long)rk_domain->dt);
> -err_put_cookie:
> -	if (type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&rk_domain->domain);
>  err_free_domain:
>  	kfree(rk_domain);
>  
> @@ -1137,8 +1129,6 @@ static void rk_iommu_domain_free(struct iommu_domain *domain)
>  			 SPAGE_SIZE, DMA_TO_DEVICE);
>  	free_page((unsigned long)rk_domain->dt);
>  
> -	if (domain->type == IOMMU_DOMAIN_DMA)
> -		iommu_put_dma_cookie(&rk_domain->domain);
>  	kfree(rk_domain);
>  }
>  
> 




_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
