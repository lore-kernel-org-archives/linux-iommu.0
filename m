Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01527C433EF
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 20:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 933CF60B43;
	Mon, 13 Dec 2021 20:30:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXn2XjTGlwIp; Mon, 13 Dec 2021 20:30:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7D68D606F5;
	Mon, 13 Dec 2021 20:30:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 65FD8C002F;
	Mon, 13 Dec 2021 20:30:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E8BC0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:30:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6F2CF81323
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-VZ-fYsX0fn for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 20:30:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 972AF81322
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:30:55 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id q25so24856874oiw.0
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sfYJREk4LthXDmYH+mm6RPH7Unbt5mdqH4JPAcOL8jM=;
 b=TBEA8Fm98UlbJ1ExMykMlyJ2hPc7mWhfh6pqyJlae/WYwmprtjgw3loMmAZGCagN7w
 ZjmxH34GeK+CGScwjdymSAUykBBRqqPv/MJDqLUVksh6OcmdgL6e0P7/Bg8tBCZdBXXO
 mzFT/+2/A/IEYecAsPZUgFFPO9StT/qqXLy3VR4EYLVUsVs7/IJBBzBbB2ijg3VHD13Y
 b4yPToOqncxpkIvSwbnqvF2VOGCA6aISGOdUY0sUEr/oG40uPdNRiLG90k4/9DoLlmpj
 sErR1CHgepbMQ+pl0VLBWJlSFpZ33uJq2mtUKk57o9/pAHa8VJ+hPETxPs145d44UfNh
 HerA==
X-Gm-Message-State: AOAM5305J98SRClzrCyUK8IdDMA4kFoKtnoqaqPH3uyk+rO8+libLqgz
 iC88btIWzYsA8IHxS9MjlQ==
X-Google-Smtp-Source: ABdhPJypg8D572vna64ZqsehAGwqHTe6foFXFeIhphG+rwK2thl/QHujnSj1sQrfMN3EvOBZVoRK9g==
X-Received: by 2002:aca:1a04:: with SMTP id a4mr752400oia.153.1639427454528;
 Mon, 13 Dec 2021 12:30:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id j20sm2305218ota.76.2021.12.13.12.30.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 12:30:53 -0800 (PST)
Received: (nullmailer pid 1519622 invoked by uid 1000);
 Mon, 13 Dec 2021 20:30:52 -0000
Date: Mon, 13 Dec 2021 14:30:52 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Correct the minItems
 of clk for larbs
Message-ID: <YbetfPEoHdyqyo8H@robh.at.kernel.org>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-2-yong.wu@mediatek.com>
 <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
 <5d1ebe0089acd28032b74e3a180466f418580805.camel@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5d1ebe0089acd28032b74e3a180466f418580805.camel@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 yi.kuo@mediatek.com, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, lc.kan@mediatek.com,
 Matthias Brugger <matthias.bgg@gmail.com>, anthony.huang@mediatek.com,
 Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
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

On Mon, Dec 13, 2021 at 02:48:52PM +0800, Yong Wu wrote:
> On Fri, 2021-12-03 at 17:34 -0600, Rob Herring wrote:
> > On Fri, 03 Dec 2021 14:40:24 +0800, Yong Wu wrote:
> > > If a platform's larb support gals, there will be some larbs have a
> > > one
> > > more "gals" clock while the others still only need "apb"/"smi"
> > > clocks.
> > > then the minItems is 2 and the maxItems is 3.
> > > 
> > > Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to
> > > DT schema")
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
> > >  .../bindings/memory-controllers/mediatek,smi-larb.yaml          |
> > > 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for
> > dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: 
> > https://patchwork.ozlabs.org/patch/1563127
> > 
> > 
> > larb@14016000: 'mediatek,larb-id' is a required property
> > 	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml
> 
> I will fix this in next version. This property is not needed in mt8167.
> 
> > 
> > larb@14017000: clock-names: ['apb', 'smi'] is too short
> > 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > burnet.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-
> > fennel14.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > sku1.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-
> > sku6.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-
> > sku16.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > sku0.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-
> > sku1.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
> > 	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml
> 
> Some larbs only have two clocks(apb/smi) in mt8183. thus it is
> reasonable for me. I won't fix this in next version.

You also need to adjust 'clock-names' to allow for 2 items.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
