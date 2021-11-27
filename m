Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3601C433EF
	for <iommu@archiver.kernel.org>; Sat, 27 Nov 2021 02:47:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B22B409B7;
	Sat, 27 Nov 2021 02:47:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VN-GN2fYcWeL; Sat, 27 Nov 2021 02:47:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 855B4409B4;
	Sat, 27 Nov 2021 02:47:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F0FAC0012;
	Sat, 27 Nov 2021 02:47:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA475C000A
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:47:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 95D9E82C84
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:47:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O34St2AIRxQI for <iommu@lists.linux-foundation.org>;
 Sat, 27 Nov 2021 02:47:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0B8B082C5E
 for <iommu@lists.linux-foundation.org>; Sat, 27 Nov 2021 02:47:01 +0000 (UTC)
X-UUID: 63097bdb89564466aacb8ffc82d8cb9c-20211127
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=ujgxNDgOxn13iafpFO6sRZICJ73MLq1oFrLOiv1fYeY=; 
 b=bPmANuoT3cfKXUNqiiCIKIBt36G5QsT5X1foyd6PeX8RDglm4eoXsdsdzOiQLfyxvLnjJUNQQ7x+RBMns+IqBm5AIbKu7ltcdy/u9XRkTjZNLyVeNg2nXZyZCj/z9wMAZRwagN5KI/8k1+yQZ73y7AJ7TWxNAecP+bhl8z43yow=;
X-UUID: 63097bdb89564466aacb8ffc82d8cb9c-20211127
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1665839108; Sat, 27 Nov 2021 10:46:57 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Nov 2021 10:46:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sat, 27 Nov 2021 10:46:55 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Nov 2021 10:46:54 +0800
Message-ID: <afb46ad6ca9477a2bf71233858406caa6ccb1588.camel@mediatek.com>
Subject: Re: [PATCH 2/2] iommu/mediatek: always check runtime PM status in
 tlb flush range callback
From: Yong Wu <yong.wu@mediatek.com>
To: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
 <iommu@lists.linux-foundation.org>
Date: Sat, 27 Nov 2021 10:46:54 +0800
In-Reply-To: <20211122104400.4160-3-dafna.hirschfeld@collabora.com>
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
 <20211122104400.4160-3-dafna.hirschfeld@collabora.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>, open
 list <linux-kernel@vger.kernel.org>, "moderated
 list:MEDIATEK IOMMU DRIVER" <linux-mediatek@lists.infradead.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 Will Deacon <will@kernel.org>, "moderated
 list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>,
 linux-media@vger.kernel.org
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

On Mon, 2021-11-22 at 12:44 +0200, Dafna Hirschfeld wrote:
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
> index 28dc4b95b6d9..b0535fcfd1d7 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -227,16 +227,13 @@ static void
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
> @@ -261,8 +258,7 @@ static void
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
