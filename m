Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE119C433EF
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 15:44:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5E6C06FC52;
	Thu, 13 Jan 2022 15:44:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlNNaLOdOxF8; Thu, 13 Jan 2022 15:44:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5409660D9C;
	Thu, 13 Jan 2022 15:44:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3DCC1C0030;
	Thu, 13 Jan 2022 15:44:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52172C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 15:44:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 405D56FC2E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 15:44:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id s_vGlGs1Tpd1 for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 15:44:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A343660D9C
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 15:44:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: kholk11) with ESMTPSA id 4A7421F45F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1642088653;
 bh=OCoO1qcOvbTSRnl8cd3s4VLrF0+nSIp3C4F6axnFvE4=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hsYI0QU8kAEuHKcWn3ygTE6VlGWOluTXSPxAG10x0EfTk8xP/aPZdqBXt3qK4W8Ml
 rceQtiuf3bRX9VlepakMKRs9MSJnsNg+585JsW1WLe92vTGLmMBPn397qbf5btoP3y
 EmD/TIkY5531qS8GGM9vjfXTA71dhsi7GJ1ebWj73I+MW9k16hRjQ51x8Wg5OoyOSF
 GPCIEXc8oA7FHLuiOXcaQZQSJANTVsxFsbz94T215pZv8P6RDeK7eVpeD7n/fq4QU8
 53Eii705xxn0RpbtXLhOgFmQ72DVjdbon6GUg3NVJb5iYk6FRcB/2SivSLFdSbhkmx
 LDEY4dqU+RZvA==
Subject: Re: [PATCH v3 2/7] dt-bindings: memory: mtk-smi: No need
 mediatek,larb-id for mt8167
To: Yong Wu <yong.wu@mediatek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-3-yong.wu@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Message-ID: <65919fad-3fbc-728d-4f14-5490b59e30a9@collabora.com>
Date: Thu, 13 Jan 2022 16:44:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113111057.29918-3-yong.wu@mediatek.com>
Content-Language: en-US
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, anthony.huang@mediatek.com, anan.sun@mediatek.com,
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

Il 13/01/22 12:10, Yong Wu ha scritto:
> Mute the warning from "make dtbs_check":
> 
> larb@14016000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@15001000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> larb@16010000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> As the description of mediatek,larb-id, the property is only
> required when the larbid is not consecutive from its IOMMU point of view.
> 
> Also, from the description of mediatek,larbs in
> Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml, all the larbs
> must sort by the larb index.
> 
> In mt8167, there is only one IOMMU HW and three larbs. The drivers already
> know its larb index from the mediatek,larbs property of IOMMU, thus no
> need this property.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
