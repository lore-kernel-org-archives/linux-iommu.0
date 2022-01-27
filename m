Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB54C433EF
	for <iommu@archiver.kernel.org>; Thu, 27 Jan 2022 11:21:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E3E75610A4;
	Thu, 27 Jan 2022 11:21:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id c6Mp14HTdt6h; Thu, 27 Jan 2022 11:21:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BE42760B79;
	Thu, 27 Jan 2022 11:21:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7932DC001A;
	Thu, 27 Jan 2022 11:21:29 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1590DC000B
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:21:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E731240B9F
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:21:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=collabora.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U_U6NQtHG9PI for <iommu@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 11:21:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A77540292
 for <iommu@lists.linux-foundation.org>; Thu, 27 Jan 2022 11:21:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 5C85F1F450BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1643282485;
 bh=3BQWjA3nBp0sP7zgUSrad36ylixDnLmcqKRaTEEAMiM=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TqymkiTkmc8ouV09E5rSvKQgI1FdJ0efS27pK79aps2Jzy7Z8w/Cy0sDkt8Yn9gFO
 KGMCLUBeNBWSc5d+ZeCKWEwex3xbBOCP4CNz28lYh1Fi7qKWXjkkQusXvM2/mUT8LE
 Wa2H+R+DwBAgfDM6IOoGwx9cOkPsIgj7mGW3g/pFQskGpDN3uaaEJyglRNEh9Rb2mK
 XBmZeF9jONOMblSQQygM6bv8s/ecqlK1rrkjNVkqNffmePAeiOMJUkylg17LZCVPuK
 e6tEGjEP6a9LpBl4OFu6G3DSTcKyWWfs4QJsLckJsJhdTG07bQOJoz8zABH0/KTkil
 g9B6Tw63fHj6A==
Subject: Re: [PATCH v4 32/35] iommu/mediatek: Get the proper bankid for multi
 banks
To: Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Will Deacon <will@kernel.org>
References: <20220125085634.17972-1-yong.wu@mediatek.com>
 <20220125085634.17972-33-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <0dce6a25-6e45-efcc-3235-b8b7be81ea4f@collabora.com>
Date: Thu, 27 Jan 2022 12:21:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220125085634.17972-33-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 chengci.xu@mediatek.com, xueqi.zhang@mediatek.com,
 linux-kernel@vger.kernel.org, libo.kang@mediatek.com,
 yen-chang.chen@mediatek.com, iommu@lists.linux-foundation.org,
 yf.wang@mediatek.com, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, mingyuan.ma@mediatek.com,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Il 25/01/22 09:56, Yong Wu ha scritto:
> We preassign some ports in a special bank via the new defined
> banks_portmsk. Put it in the plat_data means it is not expected to be
> adjusted dynamically.
> 
> If the iommu id in the iommu consumer's dtsi node is inside this
> banks_portmsk, then we switch it to this special iommu bank, and
> initialise the IOMMU bank HW.
> 
> Each a bank has the independent pgtable(4GB iova range). Each a bank
> is a independent iommu domain/group. Currently we don't separate different
> iova ranges inside a bank.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>   drivers/iommu/mtk_iommu.c | 39 ++++++++++++++++++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 22586d1aed72..c6de9304bbc6 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -191,6 +191,7 @@ struct mtk_iommu_plat_data {
>   
>   	u8                  banks_num;
>   	bool                banks_enable[MTK_IOMMU_BANK_MAX];
> +	unsigned int        banks_portmsk[MTK_IOMMU_BANK_MAX];

I would prefer to see u32 here instead... but maybe that's just a
personal preference, it doesn't really matter.

In any case:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
