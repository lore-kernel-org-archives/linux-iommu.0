Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB96C433F5
	for <iommu@archiver.kernel.org>; Thu, 13 Jan 2022 06:06:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 76C4C41632;
	Thu, 13 Jan 2022 06:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TLbcVdD6MzkL; Thu, 13 Jan 2022 06:06:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4AB0C41615;
	Thu, 13 Jan 2022 06:06:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21659C0030;
	Thu, 13 Jan 2022 06:06:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 493E2C001E
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4505560DFD
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4FXBJWhGf4NJ for <iommu@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 06:06:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7645260DA5
 for <iommu@lists.linux-foundation.org>; Thu, 13 Jan 2022 06:06:28 +0000 (UTC)
X-UUID: 5f6d5294ddcc45a5baa37963d31ac327-20220113
X-UUID: 5f6d5294ddcc45a5baa37963d31ac327-20220113
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
 (envelope-from <yong.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
 with ESMTP id 1853387206; Thu, 13 Jan 2022 14:06:23 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 13 Jan 2022 14:06:21 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 14:06:20 +0800
Message-ID: <1eb2bc6432aa5a1c0371542457a86764df77153b.camel@mediatek.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: memory: mtk-smi: Fix the larb
 clock/clock-names dtbs warning
From: Yong Wu <yong.wu@mediatek.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>, Rob Herring
 <robh+dt@kernel.org>
Date: Thu, 13 Jan 2022 14:06:20 +0800
In-Reply-To: <b8b8fe77-2ea8-d05c-5fa2-d4cae01baba5@canonical.com>
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-3-yong.wu@mediatek.com>
 <b8b8fe77-2ea8-d05c-5fa2-d4cae01baba5@canonical.com>
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK: N
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org, yi.kuo@mediatek.com,
 srv_heupstream@mediatek.com, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

On Wed, 2022-01-12 at 11:18 +0100, Krzysztof Kozlowski wrote:
> On 11/01/2022 07:39, Yong Wu wrote:
> > Mute the warning from "make dtbs_check":
> > 
> > larb@14017000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 	...
> > 
> > larb@16010000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 
> > larb@17010000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 
> > If a platform's larb supports gals, there will be some larbs have
> > one
> > more "gals" clock while the others still only need "apb"/"smi"
> > clocks,
> > then the minItems for clock and clock-names are 2.
> > 
> > Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to
> > DT schema")
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 6
> > +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > b/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > index 80907e357892..884c0c74e5e4 100644
> > --- a/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > +++ b/Documentation/devicetree/bindings/memory-
> > controllers/mediatek,smi-larb.yaml
> > @@ -80,10 +80,10 @@ allOf:
> >      then:
> >        properties:
> >          clock:
> 
> Separate patch:
> This should be clocks. The same in second if. Now it is simply not
> working...
> 
> > -          items:
> 
> Putting min/maxItems under items is wrong. The second if also needs
> the
> fixing. Please make it a separate patch before this one.

Oh. I will use a new patch for renaming "clock" to "clocks" and
removing the "items".

Thanks.

> 
> The schema was clearly not tested before...
> 
> 
> > -            minItems: 3
> > -            maxItems: 3
> > +          minItems: 2
> > +          maxItems: 3
> >          clock-names:
> > +          minItems: 2
> >            items:
> >              - const: apb
> >              - const: smi
> > 
> 
> 
> Best regards,
> Krzysztof

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
