Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67067C433FE
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 06:49:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F02B4850EF;
	Mon, 13 Dec 2021 06:49:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yJKCf6cgVEbW; Mon, 13 Dec 2021 06:49:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8B42E8506A;
	Mon, 13 Dec 2021 06:49:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E495C002F;
	Mon, 13 Dec 2021 06:49:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E6B2C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 06:49:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31F3E4094F
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 06:49:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=mediatek.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0unmEMwpT2fD for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 06:48:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 71765400D2
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 06:48:57 +0000 (UTC)
X-UUID: 32ab375df4d0450c883b8e6e68f01821-20211213
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=QzfN+FlUlQnx8BtRAnoYm3/IBA3s2vzJNiXDt9dMjuc=; 
 b=ado7JXbk+FUwxEeCldWs/n01lJJyV9VYOwKZu1DXH5Y7n3YYmxmB+BARRhvVhRReprAYcA2qs1ndQPeJit/MRIEEOpuDv5/KDCr3FRZTvkMAgL1RRG5jnQBa86MNwcVc3ldfILxvfXiW5Mxi7C+0nz+feqK4MBWvuLT4mXRrO4U=;
X-UUID: 32ab375df4d0450c883b8e6e68f01821-20211213
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 340885932; Mon, 13 Dec 2021 14:48:52 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; 
 Mon, 13 Dec 2021 14:48:51 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 13 Dec 2021 14:48:49 +0800
Message-ID: <5d1ebe0089acd28032b74e3a180466f418580805.camel@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Correct the minItems
 of clk for larbs
From: Yong Wu <yong.wu@mediatek.com>
To: Rob Herring <robh@kernel.org>
Date: Mon, 13 Dec 2021 14:48:52 +0800
In-Reply-To: <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-2-yong.wu@mediatek.com>
 <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 yi.kuo@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Fri, 2021-12-03 at 17:34 -0600, Rob Herring wrote:
> On Fri, 03 Dec 2021 14:40:24 +0800, Yong Wu wrote:
> > If a platform's larb support gals, there will be some larbs have a
> > one
> > more "gals" clock while the others still only need "apb"/"smi"
> > clocks.
> > then the minItems is 2 and the maxItems is 3.
> > 
> > Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to
> > DT schema")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/memory-controllers/mediatek,smi-larb.yaml          |
> > 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for
> dtbs_check.
> This will change in the future.
> 
> Full log is available here: 
> https://patchwork.ozlabs.org/patch/1563127
> 
> 
> larb@14016000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

I will fix this in next version. This property is not needed in mt8167.

> 
> larb@14017000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> burnet.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> fennel14.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku6.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

Some larbs only have two clocks(apb/smi) in mt8183. thus it is
reasonable for me. I won't fix this in next version.

Please tell me if I miss something.
Thanks.

> 
> larb@15001000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> larb@16010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> burnet.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> fennel14.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku6.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml
> 
> larb@16010000: 'mediatek,larb-id' is a required property
> 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> larb@17010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> burnet.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> fennel14.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> sku6.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> sku1.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
