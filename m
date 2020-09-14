Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A56C2BBD1
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 23:22:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46D6D20936
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 23:22:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D6D20936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D3FFE86234;
	Mon, 14 Sep 2020 23:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vFhwx1aKtWHQ; Mon, 14 Sep 2020 23:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2A47286214;
	Mon, 14 Sep 2020 23:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14851C0864;
	Mon, 14 Sep 2020 23:22:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FB49C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 23:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 737E787019
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 23:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ov4Jwp876bvq for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 23:22:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 28B0387028
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 23:22:07 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id j2so2022713ioj.7
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 16:22:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uBJaBVM5qSlFTMBKBPrOEf8kKcQcYDcZTztd+soUSx4=;
 b=GLQ5vrRn+SF8Tsba0cVAHf1zq1OpE2cF8uoazO8NLZqkTwCxO/v+1ChEwv4ZJ/qkz0
 Ae0Hu0NvtF8ZDBgP7zVBA7spsnO8JHdOPuBAT5e2hCII5eI+GYZGC+QZu//QE/pmZm1c
 a4/aPGJRf3wy9C6zJ4IrxAym22vz9r6/ctSFuo9xe0NTbrZEWt6d8Wfu+zB5W96+wZcw
 JVWFwaf3tRVLG73CrIuzbpcLRNcEad7iCMytvipEUG99408p+oNIjKp7fmkZjhw9i0Ww
 bd3/Hr+quKFhKeo4aZ0RQC/ds/muACWG34r8YX5E5fj2E9OaBW/JENopo4s6AymvD6s8
 67iA==
X-Gm-Message-State: AOAM5334ATFShrLnfPxJfsSzAESfUt1xj+tgo901ZR7pKy1IX186KAXJ
 yjcOJ/rK8eSi+rYjl/5ytw==
X-Google-Smtp-Source: ABdhPJyjhpRe595cAwHbYUZWFvDATVusi2POp3kZjIUBYWVD1rY+NkcI7WXZM4X4jBE2OGqhNcCKPQ==
X-Received: by 2002:a02:778e:: with SMTP id g136mr15690979jac.49.1600125726390; 
 Mon, 14 Sep 2020 16:22:06 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id i9sm4129664ilj.71.2020.09.14.16.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 16:22:05 -0700 (PDT)
Received: (nullmailer pid 465226 invoked by uid 1000);
 Mon, 14 Sep 2020 23:22:04 -0000
Date: Mon, 14 Sep 2020 17:22:04 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v2 01/23] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
Message-ID: <20200914232204.GA457962@bogus>
References: <20200905080920.13396-1-yong.wu@mediatek.com>
 <20200905080920.13396-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200905080920.13396-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 Tomasz Figa <tfiga@google.com>, iommu@lists.linux-foundation.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, anan.sun@mediatek.com,
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

On Sat, Sep 05, 2020 at 04:08:58PM +0800, Yong Wu wrote:
> Convert MediaTek IOMMU to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         | 103 ------------
>  .../bindings/iommu/mediatek,iommu.yaml        | 150 ++++++++++++++++++
>  2 files changed, 150 insertions(+), 103 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt b/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> deleted file mode 100644
> index c1ccd8582eb2..000000000000
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
> +++ /dev/null
> @@ -1,103 +0,0 @@
> -* Mediatek IOMMU Architecture Implementation
> -
> -  Some Mediatek SOCs contain a Multimedia Memory Management Unit (M4U), and
> -this M4U have two generations of HW architecture. Generation one uses flat
> -pagetable, and only supports 4K size page mapping. Generation two uses the
> -ARM Short-Descriptor translation table format for address translation.
> -
> -  About the M4U Hardware Block Diagram, please check below:
> -
> -              EMI (External Memory Interface)
> -               |
> -              m4u (Multimedia Memory Management Unit)
> -               |
> -          +--------+
> -          |        |
> -      gals0-rx   gals1-rx    (Global Async Local Sync rx)
> -          |        |
> -          |        |
> -      gals0-tx   gals1-tx    (Global Async Local Sync tx)
> -          |        |          Some SoCs may have GALS.
> -          +--------+
> -               |
> -           SMI Common(Smart Multimedia Interface Common)
> -               |
> -       +----------------+-------
> -       |                |
> -       |             gals-rx        There may be GALS in some larbs.
> -       |                |
> -       |                |
> -       |             gals-tx
> -       |                |
> -   SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
> -   (display)         (vdec)
> -       |                |
> -       |                |
> - +-----+-----+     +----+----+
> - |     |     |     |    |    |
> - |     |     |...  |    |    |  ... There are different ports in each larb.
> - |     |     |     |    |    |
> -OVL0 RDMA0 WDMA0  MC   PP   VLD
> -
> -  As above, The Multimedia HW will go through SMI and M4U while it
> -access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
> -smi local arbiter and smi common. It will control whether the Multimedia
> -HW should go though the m4u for translation or bypass it and talk
> -directly with EMI. And also SMI help control the power domain and clocks for
> -each local arbiter.
> -  Normally we specify a local arbiter(larb) for each multimedia HW
> -like display, video decode, and camera. And there are different ports
> -in each larb. Take a example, There are many ports like MC, PP, VLD in the
> -video decode local arbiter, all these ports are according to the video HW.
> -  In some SoCs, there may be a GALS(Global Async Local Sync) module between
> -smi-common and m4u, and additional GALS module between smi-larb and
> -smi-common. GALS can been seen as a "asynchronous fifo" which could help
> -synchronize for the modules in different clock frequency.
> -
> -Required properties:
> -- compatible : must be one of the following string:
> -	"mediatek,mt2701-m4u" for mt2701 which uses generation one m4u HW.
> -	"mediatek,mt2712-m4u" for mt2712 which uses generation two m4u HW.
> -	"mediatek,mt6779-m4u" for mt6779 which uses generation two m4u HW.
> -	"mediatek,mt7623-m4u", "mediatek,mt2701-m4u" for mt7623 which uses
> -						     generation one m4u HW.
> -	"mediatek,mt8173-m4u" for mt8173 which uses generation two m4u HW.
> -	"mediatek,mt8183-m4u" for mt8183 which uses generation two m4u HW.
> -- reg : m4u register base and size.
> -- interrupts : the interrupt of m4u.
> -- clocks : must contain one entry for each clock-names.
> -- clock-names : Only 1 optional clock:
> -  - "bclk": the block clock of m4u.
> -  Here is the list which require this "bclk":
> -  - mt2701, mt2712, mt7623 and mt8173.
> -  Note that m4u use the EMI clock which always has been enabled before kernel
> -  if there is no this "bclk".
> -- mediatek,larbs : List of phandle to the local arbiters in the current Socs.
> -	Refer to bindings/memory-controllers/mediatek,smi-larb.txt. It must sort
> -	according to the local arbiter index, like larb0, larb1, larb2...
> -- iommu-cells : must be 1. This is the mtk_m4u_id according to the HW.
> -	Specifies the mtk_m4u_id as defined in
> -	dt-binding/memory/mt2701-larb-port.h for mt2701, mt7623
> -	dt-binding/memory/mt2712-larb-port.h for mt2712,
> -	dt-binding/memory/mt6779-larb-port.h for mt6779,
> -	dt-binding/memory/mt8173-larb-port.h for mt8173, and
> -	dt-binding/memory/mt8183-larb-port.h for mt8183.
> -
> -Example:
> -	iommu: iommu@10205000 {
> -		compatible = "mediatek,mt8173-m4u";
> -		reg = <0 0x10205000 0 0x1000>;
> -		interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> -		clocks = <&infracfg CLK_INFRA_M4U>;
> -		clock-names = "bclk";
> -		mediatek,larbs = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
> -		#iommu-cells = <1>;
> -	};
> -
> -Example for a client device:
> -	display {
> -		compatible = "mediatek,mt8173-disp";
> -		iommus = <&iommu M4U_PORT_DISP_OVL0>,
> -			 <&iommu M4U_PORT_DISP_RDMA0>;
> -		...
> -	};
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> new file mode 100644
> index 000000000000..d7b31bda3e35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -0,0 +1,150 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/mediatek,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek IOMMU Architecture Implementation
> +
> +maintainers:
> +  - Yong Wu <yong.wu@mediatek.com>
> +  - Chao Hao <chao.hao@mediatek.com>
> +
> +description: |+
> +  Some MediaTek SOCs contain a Multimedia Memory Management Unit (M4U), and
> +  this M4U have two generations of HW architecture. Generation one uses flat
> +  pagetable, and only supports 4K size page mapping. Generation two uses the
> +  ARM Short-Descriptor translation table format for address translation.
> +
> +  About the M4U Hardware Block Diagram, please check below:
> +
> +                EMI (External Memory Interface)
> +                 |
> +                m4u (Multimedia Memory Management Unit)
> +                 |
> +            +--------+
> +            |        |
> +        gals0-rx   gals1-rx    (Global Async Local Sync rx)
> +            |        |
> +            |        |
> +        gals0-tx   gals1-tx    (Global Async Local Sync tx)
> +            |        |          Some SoCs may have GALS.
> +            +--------+
> +                 |
> +             SMI Common(Smart Multimedia Interface Common)
> +                 |
> +         +----------------+-------
> +         |                |
> +         |             gals-rx        There may be GALS in some larbs.
> +         |                |
> +         |                |
> +         |             gals-tx
> +         |                |
> +     SMI larb0        SMI larb1   ... SoCs have several SMI local arbiter(larb).
> +     (display)         (vdec)
> +         |                |
> +         |                |
> +   +-----+-----+     +----+----+
> +   |     |     |     |    |    |
> +   |     |     |...  |    |    |  ... There are different ports in each larb.
> +   |     |     |     |    |    |
> +  OVL0 RDMA0 WDMA0  MC   PP   VLD
> +
> +  As above, The Multimedia HW will go through SMI and M4U while it
> +  access EMI. SMI is a bridge between m4u and the Multimedia HW. It contain
> +  smi local arbiter and smi common. It will control whether the Multimedia
> +  HW should go though the m4u for translation or bypass it and talk
> +  directly with EMI. And also SMI help control the power domain and clocks for
> +  each local arbiter.
> +
> +  Normally we specify a local arbiter(larb) for each multimedia HW
> +  like display, video decode, and camera. And there are different ports
> +  in each larb. Take a example, There are many ports like MC, PP, VLD in the
> +  video decode local arbiter, all these ports are according to the video HW.
> +
> +  In some SoCs, there may be a GALS(Global Async Local Sync) module between
> +  smi-common and m4u, and additional GALS module between smi-larb and
> +  smi-common. GALS can been seen as a "asynchronous fifo" which could help
> +  synchronize for the modules in different clock frequency.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt2701-m4u #mt2701 generation one HW
> +      - mediatek,mt2712-m4u #mt2712 generation two HW
> +      - mediatek,mt6779-m4u #mt6779 generation two HW
> +      - mediatek,mt7623-m4u, mediatek,mt2701-m4u #mt7623 generation one HW

This is not right.

items:
  - const: mediatek,mt7623-m4u
  - const: mediatek,mt2701-m4u

And that has to be under a 'oneOf' with the rest of this.

> +      - mediatek,mt8173-m4u #mt8173 generation two HW
> +      - mediatek,mt8183-m4u #mt8183 generation two HW
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description: |
> +      bclk is optional. here is the list which require this bclk:
> +      mt2701, mt2712, mt7623 and mt8173.
> +      M4U will use the EMI clock which always has been enabled before
> +      kernel if there is no this bclk.
> +    items:
> +      - description: bclk is the block clock.
> +
> +  clock-names:
> +    items:
> +      - const: bclk
> +
> +  mediatek,larbs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: |
> +      List of phandle to the local arbiters in the current Socs.
> +      Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
> +      according to the local arbiter index, like larb0, larb1, larb2...
> +
> +  '#iommu-cells':
> +    const: 1
> +    description: |
> +      This is the mtk_m4u_id according to the HW. Specifies the mtk_m4u_id as
> +      defined in
> +      dt-binding/memory/mt2701-larb-port.h for mt2701 and mt7623,
> +      dt-binding/memory/mt2712-larb-port.h for mt2712,
> +      dt-binding/memory/mt6779-larb-port.h for mt6779,
> +      dt-binding/memory/mt8173-larb-port.h for mt8173,
> +      dt-binding/memory/mt8183-larb-port.h for mt8183.
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - mediatek,larbs
> +  - '#iommu-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8173-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    iommu: iommu@10205000 {
> +            compatible = "mediatek,mt8173-m4u";
> +            reg = <0x10205000 0x1000>;
> +            interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
> +            clocks = <&infracfg CLK_INFRA_M4U>;
> +            clock-names = "bclk";
> +            mediatek,larbs = <&larb0 &larb1 &larb2
> +                              &larb3 &larb4 &larb5>;
> +            #iommu-cells = <1>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/memory/mt8173-larb-port.h>
> +
> +    /* Example for a client device */
> +    display {
> +           compatible = "mediatek,mt8173-disp";
> +           iommus = <&iommu M4U_PORT_DISP_OVL0>,
> +                    <&iommu M4U_PORT_DISP_RDMA0>;
> +     };
> -- 
> 2.18.0
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
