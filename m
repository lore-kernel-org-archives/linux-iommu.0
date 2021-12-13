Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E60C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 07:53:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8918A60EFA;
	Mon, 13 Dec 2021 07:53:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vkLLfIGq8sUR; Mon, 13 Dec 2021 07:53:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E475660789;
	Mon, 13 Dec 2021 07:53:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6AAFC001E;
	Mon, 13 Dec 2021 07:53:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DBB6AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D311C80C93
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:53:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FA-ex9ZEPACA for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 07:53:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E90485A21
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 07:53:30 +0000 (UTC)
X-UUID: 57532857ba324863b30b86ee5b258dab-20211213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=Qje268K+koi4R/car/RXG6pCHuYVAIpCtFKrTVwyePw=; 
 b=hEUQeaDAIt80yzZnHJXhppfyMwu8hQHG3Son84yVkg1qjkaXt4/UZ66oTZJJ47UtSsCdK0uizxcRxqxTtKZzjTJxbpnVl2vCOZBMiPLT9mhnGV8snhbemCrfJ3PITWoW9nsNHD1gkXPuyeCZB4yQhGmEgqt3cCbuNqmJicS39AY=;
X-UUID: 57532857ba324863b30b86ee5b258dab-20211213
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1184157638; Mon, 13 Dec 2021 15:53:24 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 13 Dec 2021 15:53:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Dec 2021 15:53:22 +0800
Message-ID: <00161c73917e4c811a34228ff9729ef22141190d.camel@mediatek.com>
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Always check runtime PM status
 in tlb flush range callback
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Date: Mon, 13 Dec 2021 15:53:25 +0800
In-Reply-To: <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: open list <linux-kernel@vger.kernel.org>, sebastian.reichel@collabora.com,
 iommu@lists.linux-foundation.org,
 "moderated list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com, Will
 Deacon <will@kernel.org>, "moderated list:ARM/Mediatek SoC support"
 <linux-arm-kernel@lists.infradead.org>, linux-media@vger.kernel.org
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

On Wed, 2021-12-08 at 14:07 +0200, Dafna Hirschfeld wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> In case of v4l2_reqbufs() it is possible, that a TLB flush is done
> without runtime PM being enabled. In that case the "Partial TLB flush
> timed out, falling back to full flush" warning is printed.
> 
> Commit c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> introduced has_pm as optimization to avoid checking runtime PM
> when there is no power domain attached. But without the PM domain
> there is still the device driver's runtime PM suspend handler, which
> disables the clock. Thus flushing should also be avoided when there
> is no PM domain involved.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> ---
>  drivers/iommu/mtk_iommu.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 342aa562ab6a..dd2c08c54df4 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -225,16 +225,13 @@ static void
> mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  					   size_t granule,
>  					   struct mtk_iommu_data *data)
>  {
> -	bool has_pm = !!data->dev->pm_domain;
>  	unsigned long flags;
>  	int ret;
>  	u32 tmp;
>  
>  	for_each_m4u(data) {
> -		if (has_pm) {
> -			if (pm_runtime_get_if_in_use(data->dev) <= 0)
> -				continue;
> -		}
> +		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> +			continue;
>  
>  		spin_lock_irqsave(&data->tlb_lock, flags);
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> @@ -259,8 +256,7 @@ static void
> mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
>  		spin_unlock_irqrestore(&data->tlb_lock, flags);
>  
> -		if (has_pm)
> -			pm_runtime_put(data->dev);
> +		pm_runtime_put(data->dev);
>  	}
>  }
>  
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
