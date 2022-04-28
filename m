Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB7CC433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Apr 2022 08:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CC048827C9;
	Thu, 28 Apr 2022 08:18:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LDYGUsS0iP8e; Thu, 28 Apr 2022 08:18:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADE0D825FE;
	Thu, 28 Apr 2022 08:18:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 907C3C0039;
	Thu, 28 Apr 2022 08:18:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7AE66C002D
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:18:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6909560AEA
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:18:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DRCmoGXG5Jr4 for <iommu@lists.linux-foundation.org>;
 Thu, 28 Apr 2022 08:18:32 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BB73160A88
 for <iommu@lists.linux-foundation.org>; Thu, 28 Apr 2022 08:18:32 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id B9DF42FB; Thu, 28 Apr 2022 10:18:30 +0200 (CEST)
Date: Thu, 28 Apr 2022 10:18:29 +0200
From: Joerg Roedel <joro@8bytes.org>
To: cgel.zte@gmail.com
Subject: Re: [PATCH] iommu: add null pointer check
Message-ID: <YmpN1ZVZMrU9ZJ3e@8bytes.org>
References: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220329055322.2375563-1-lv.ruyi@zte.com.cn>
Cc: Lv Ruyi <lv.ruyi@zte.com.cn>, iommu@lists.linux-foundation.org,
 Zeal Robot <zealci@zte.com.cn>, will@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 29, 2022 at 05:53:22AM +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> kmem_cache_zalloc is a memory allocation function which can return NULL
> when some internal memory errors happen. Add null pointer check to avoid
> dereferencing null pointer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 69a4a62dc3b9..43849c027298 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -152,6 +152,10 @@ static void attach_device(struct fsl_dma_domain *dma_domain, int liodn, struct d
>  	}
>  
>  	info = kmem_cache_zalloc(iommu_devinfo_cache, GFP_ATOMIC);
> +	if (!info) {
> +		spin_unlock_irqrestore(&device_domain_lock, flags);
> +		return;
> +	}

Such errors need to be propagated.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
