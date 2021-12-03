Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6A7C433EF
	for <iommu@archiver.kernel.org>; Fri,  3 Dec 2021 23:34:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F0CD81BA8;
	Fri,  3 Dec 2021 23:34:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pm4Gnk38MU15; Fri,  3 Dec 2021 23:34:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B280380F1A;
	Fri,  3 Dec 2021 23:34:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88094C001E;
	Fri,  3 Dec 2021 23:34:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3615FC0012
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 23:34:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1D21E6069D
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 23:34:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3--8hN-kQ33g for <iommu@lists.linux-foundation.org>;
 Fri,  3 Dec 2021 23:34:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2880660658
 for <iommu@lists.linux-foundation.org>; Fri,  3 Dec 2021 23:34:31 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 h19-20020a9d3e53000000b0056547b797b2so5389083otg.4
 for <iommu@lists.linux-foundation.org>; Fri, 03 Dec 2021 15:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=YiLKOo6UjENxJNlcLLad7PuFG7LasjEMP8sQf/vfoCY=;
 b=WvkTxFdK/EXGsAuAI5oDFsYiKEOLopfkCFiPtBuxCJUjVUUhmT2tu+bRV46dAh77ae
 xMD943t6h6U7KeqJ72FkivVp6z7U997WEPE5NJQchrskpTAuYoBPdJsWodYpLk4gpUfi
 nJ0THZX0SnLZCOYDpsiFcQ505s2mvV+/etm1kftc89dR2xBR71aP5xNHjDCmNJPv4Bth
 rnLPCx6YHCd9MAaaI9oKInsOdCiozzxyVKydM6Wvsam4wNu50rQFaW6GitkZRN+mvGxt
 9O6XfWj2ycn0B8A/FtDk8FPe+h9kMl86UtZi2ppoIW6A2OvZvDT1EwtDWliV+s7bn5oc
 pNzw==
X-Gm-Message-State: AOAM532cjNv8NH9D2q+cknv8UAAi1KueLEgaz93BYRisGrT5GLlqkk/b
 IOQJvS2GkiDWPyFYJRZGJQ==
X-Google-Smtp-Source: ABdhPJzaChXSNEtZQrVDuuBqE4OOoH38CUdgHcZapsCQUiGSTfOcqkFwFK52oIJ1fUrqoQYuBMT/Hw==
X-Received: by 2002:a9d:7a5a:: with SMTP id z26mr19045138otm.297.1638574470251; 
 Fri, 03 Dec 2021 15:34:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id o19sm1051377oiw.22.2021.12.03.15.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Dec 2021 15:34:29 -0800 (PST)
Received: (nullmailer pid 1043013 invoked by uid 1000);
 Fri, 03 Dec 2021 23:34:15 -0000
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
In-Reply-To: <20211203064027.14993-2-yong.wu@mediatek.com>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-2-yong.wu@mediatek.com>
Subject: Re: [PATCH 1/4] dt-bindings: memory: mediatek: Correct the minItems
 of clk for larbs
Date: Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.281202.1043012.nullmailer@robh.at.kernel.org>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 yi.kuo@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, Will Deacon <will@kernel.org>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 03 Dec 2021 14:40:24 +0800, Yong Wu wrote:
> If a platform's larb support gals, there will be some larbs have a one
> more "gals" clock while the others still only need "apb"/"smi" clocks.
> then the minItems is 2 and the maxItems is 3.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1563127


larb@14016000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@14017000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

larb@15001000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@16010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

larb@16010000: 'mediatek,larb-id' is a required property
	arch/arm64/boot/dts/mediatek/mt8167-pumpkin.dt.yaml

larb@17010000: clock-names: ['apb', 'smi'] is too short
	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-damu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel14.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-fennel-sku6.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-juniper-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kappa.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-kenzo.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-willow-sku1.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kakadu.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku16.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku272.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku288.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-kodama-sku32.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku0.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-kukui-krane-sku176.dt.yaml
	arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dt.yaml

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
