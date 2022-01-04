Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC156C43219
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 15:55:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 85F1E414A2;
	Tue,  4 Jan 2022 15:55:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cyeh-nEdX-V6; Tue,  4 Jan 2022 15:55:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 65B08410B1;
	Tue,  4 Jan 2022 15:55:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3A700C002F;
	Tue,  4 Jan 2022 15:55:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F7F8C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4FD6B60D5A
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b1yRJF9ke6RW for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 15:55:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B079C60D57
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 15:55:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 807461F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1641311721;
 bh=V052X6CDRqGtUFJ9/x/emU0xn91Fbjw/PEV/sXPRzeQ=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=DONGLC2hY7afAnjU2pD69F6yoQtckqgDyfVXGrV9S7yr4nBspBHhjw+C5Y7ZfSRD6
 pcy60TFAq9Gjd8ObWJUnIkyC3zKY8Ef47nQx9V7caoOiCp3L4HPd+VWVS7wttJrZI5
 xyhlyiQ8aOFEk4edgoHX+3zuRvz98P58oOa2Sq8up9fu5YN5qUyYbnJ2e1bk03QfBS
 yepEvPax+fe1PvQDBmdlvyGBxehQxCOn+OufgkQuwWjPMUSn1XC31TN1wAIsYqS2oD
 D/fSKoZsUKhuSPi86VkYTS7fq80pyNf1t3DYDePF8KHSV7Kk6FRneoroyM9WRpbcNu
 yL3AUJ3Z3bKpA==
Subject: Re: [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-10-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <bfa33e94-c2e5-5dab-c9af-b674e1669daa@collabora.com>
Date: Tue, 4 Jan 2022 16:55:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-10-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 linux-kernel@vger.kernel.org, yen-chang.chen@mediatek.com,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Hsin-Yi Wang <hsinyi@chromium.org>,
 anan.sun@mediatek.com, linux-arm-kernel@lists.infradead.org
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 23/09/21 13:58, Yong Wu ha scritto:
> The tlb_sync_all is called from these three functions:
> a) flush_iotlb_all: it will be called for each a iommu HW.
> b) tlb_flush_range_sync: it already has for_each_m4u.
> c) in irq: When IOMMU HW translation fault, Only need flush itself.
> 
> Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 18 +++++++-----------
>   1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 6f4f6624e3ac..0b4c30baa864 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -206,19 +206,15 @@ static struct mtk_iommu_domain *to_mtk_domain(struct iommu_domain *dom)
>   
>   static void mtk_iommu_tlb_flush_all(struct mtk_iommu_data *data)
>   {
> -	struct list_head *head = data->hw_list;
> -
> -	for_each_m4u(data, head) {
> -		if (pm_runtime_get_if_in_use(data->dev) <= 0)
> -			continue;
> +	if (pm_runtime_get_if_in_use(data->dev) <= 0)
> +		return;
>   
> -		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> -			       data->base + data->plat_data->inv_sel_reg);
> -		writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> -		wmb(); /* Make sure the tlb flush all done */
> +	writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> +		       data->base + data->plat_data->inv_sel_reg);
> +	writel_relaxed(F_ALL_INVLD, data->base + REG_MMU_INVALIDATE);
> +	wmb(); /* Make sure the tlb flush all done */

There aren't a lot of writes here - not anymore, since you are no longer doing
this for_each_m4u()...
...so, please change writel_relaxed() to writel() calls, allowing you to also
remove the write barrier at the end (since in the non relaxed version, order
is already ensured).

>   
> -		pm_runtime_put(data->dev);
> -	}
> +	pm_runtime_put(data->dev);
>   }
>   
>   static void mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
