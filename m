Return-Path: <SRS0=i+j8=MG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BD9C1B08C
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:15:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78BED61396
	for <iommu@archiver.kernel.org>; Wed, 14 Jul 2021 21:15:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78BED61396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4317F83D5F;
	Wed, 14 Jul 2021 21:15:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DIlM4VmFUm_j; Wed, 14 Jul 2021 21:15:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3787C83D65;
	Wed, 14 Jul 2021 21:15:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0973BC001D;
	Wed, 14 Jul 2021 21:15:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 346B7C000E
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:15:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 212D64056A
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:15:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ImWZf6SUyYSa for <iommu@lists.linux-foundation.org>;
 Wed, 14 Jul 2021 21:15:04 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com
 [209.85.166.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2F0354051B
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 21:15:04 +0000 (UTC)
Received: by mail-il1-f177.google.com with SMTP id b14so2989627ilf.7
 for <iommu@lists.linux-foundation.org>; Wed, 14 Jul 2021 14:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=syAXapfi/1thpY4jHBRfGcWzIDr/Y3HxhpyKckHASlE=;
 b=gXohvm8R9K4tWC1BVWi+34GKFWUXil6cTz6dsOPhkMSE5VDKCeMzQEuGV93Ob0cKyr
 nox2O6dzfio34S88Wk+b06d+RmTWfe+SODVEoMLwRGU3ukWM4dJD4b4SeDeEQh9nthWM
 m3olv36/ohb7B8ZOvMg5vYfvML2jClmIKZqmCpG93zn6hFqn5WBnF8OHV9Y5V7daFlBu
 RXJ4dvNnm3tyRazEiY2Foua7zV2Qc74J3jS5CUV8SYyEity5Xg2k3KGypxX2JiFRzyig
 JAU7IWZyjCTItMSmKOS149qykYhAtYx9dvO3TIfvI/Q7yd14PcTrUTFafIdWipLn7R1T
 miUA==
X-Gm-Message-State: AOAM533NiJ1fImyZRWfq4ksalK3XyqQ1aRHMprtqmxqHcX6TfoniYRzD
 GcPUiuhHx+9ZmjxwoQ0ItQ==
X-Google-Smtp-Source: ABdhPJyMeqk2FAY7bitNJyippP/0WZgYEXD6g1bDCjmESNtNzj4EVp5q3IV9YBKg+MrxY8yXpakmdw==
X-Received: by 2002:a92:d8c5:: with SMTP id l5mr7989064ilo.79.1626297303292;
 Wed, 14 Jul 2021 14:15:03 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
 by smtp.gmail.com with ESMTPSA id x9sm1692459iov.45.2021.07.14.14.14.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jul 2021 14:14:49 -0700 (PDT)
Received: (nullmailer pid 3536623 invoked by uid 1000);
 Wed, 14 Jul 2021 21:14:44 -0000
Date: Wed, 14 Jul 2021 15:14:44 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 02/24] dt-bindings: mediatek: mt8195: Add binding for
 infra IOMMU
Message-ID: <20210714211444.GA3531980@robh.at.kernel.org>
References: <20210630023504.18177-1-yong.wu@mediatek.com>
 <20210630023504.18177-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210630023504.18177-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, linux-mediatek@lists.infradead.org,
 chao.hao@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anan.sun@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jun 30, 2021 at 10:34:42AM +0800, Yong Wu wrote:
> In mt8195, we have a new IOMMU that is for INFRA IOMMU. its masters
> mainly are PCIe and USB. Different with MM IOMMU, all these masters
> connect with IOMMU directly, there is no mediatek,larbs property for
> infra IOMMU.
> 
> Another thing is about PCIe ports. currently the function
> "of_iommu_configure_dev_id" only support the id number is 1, But our
> PCIe have two ports, one is for reading and the other is for writing.
> see more about the PCIe patch in this patchset. Thus, I only list
> the reading id here and add the other id in our driver.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml         | 14 +++++++++++++-
>  .../dt-bindings/memory/mt8195-memory-port.h    | 18 ++++++++++++++++++
>  include/dt-bindings/memory/mtk-memory-port.h   |  2 ++
>  3 files changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> index 9b04630158c8..6f3ff631c06b 100644
> --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> @@ -79,6 +79,7 @@ properties:
>            - mediatek,mt8192-m4u  # generation two
>            - mediatek,mt8195-iommu-vdo        # generation two
>            - mediatek,mt8195-iommu-vpp        # generation two
> +          - mediatek,mt8195-iommu-infra      # generation two
>  
>        - description: mt7623 generation one
>          items:
> @@ -129,7 +130,6 @@ required:
>    - compatible
>    - reg
>    - interrupts
> -  - mediatek,larbs
>    - '#iommu-cells'
>  
>  allOf:
> @@ -161,6 +161,18 @@ allOf:
>        required:
>          - power-domains
>  
> +  - if:
> +      not:
> +        properties:
> +          compatible:
> +            items:
> +              enum:
> +                - mediatek,mt8195-iommu-infra

This is saying all items are 'mediatek,mt8195-iommu-infra'. Other 
schemas prevent that, but really this should be:

compatible:
  contains:
    const: mediatek,mt8195-iommu-infra

> +
> +    then:
> +      required:
> +        - mediatek,larbs
> +
>  additionalProperties: false
>  
>  examples:
> diff --git a/include/dt-bindings/memory/mt8195-memory-port.h b/include/dt-bindings/memory/mt8195-memory-port.h
> index 783bcae8cdea..67afad848725 100644
> --- a/include/dt-bindings/memory/mt8195-memory-port.h
> +++ b/include/dt-bindings/memory/mt8195-memory-port.h
> @@ -387,4 +387,22 @@
>  #define M4U_PORT_L28_CAM_DRZS4NO_R1		MTK_M4U_ID(28, 5)
>  #define M4U_PORT_L28_CAM_TNCSO_R1		MTK_M4U_ID(28, 6)
>  
> +/* infra iommu ports */
> +/* PCIe1: read: BIT16; write BIT17. */
> +#define M4U_PORT_INFRA_PCIE1			MTK_IFAIOMMU_PERI_ID(16)
> +/* PCIe0: read: BIT18; write BIT19. */
> +#define M4U_PORT_INFRA_PCIE0			MTK_IFAIOMMU_PERI_ID(18)
> +#define M4U_PORT_INFRA_SSUSB_P3_R		MTK_IFAIOMMU_PERI_ID(20)
> +#define M4U_PORT_INFRA_SSUSB_P3_W		MTK_IFAIOMMU_PERI_ID(21)
> +#define M4U_PORT_INFRA_SSUSB_P2_R		MTK_IFAIOMMU_PERI_ID(22)
> +#define M4U_PORT_INFRA_SSUSB_P2_W		MTK_IFAIOMMU_PERI_ID(23)
> +#define M4U_PORT_INFRA_SSUSB_P1_1_R		MTK_IFAIOMMU_PERI_ID(24)
> +#define M4U_PORT_INFRA_SSUSB_P1_1_W		MTK_IFAIOMMU_PERI_ID(25)
> +#define M4U_PORT_INFRA_SSUSB_P1_0_R		MTK_IFAIOMMU_PERI_ID(26)
> +#define M4U_PORT_INFRA_SSUSB_P1_0_W		MTK_IFAIOMMU_PERI_ID(27)
> +#define M4U_PORT_INFRA_SSUSB2_R			MTK_IFAIOMMU_PERI_ID(28)
> +#define M4U_PORT_INFRA_SSUSB2_W			MTK_IFAIOMMU_PERI_ID(29)
> +#define M4U_PORT_INFRA_SSUSB_R			MTK_IFAIOMMU_PERI_ID(30)
> +#define M4U_PORT_INFRA_SSUSB_W			MTK_IFAIOMMU_PERI_ID(31)
> +
>  #endif
> diff --git a/include/dt-bindings/memory/mtk-memory-port.h b/include/dt-bindings/memory/mtk-memory-port.h
> index 7d64103209af..2f68a0511a25 100644
> --- a/include/dt-bindings/memory/mtk-memory-port.h
> +++ b/include/dt-bindings/memory/mtk-memory-port.h
> @@ -12,4 +12,6 @@
>  #define MTK_M4U_TO_LARB(id)		(((id) >> 5) & 0x1f)
>  #define MTK_M4U_TO_PORT(id)		((id) & 0x1f)
>  
> +#define MTK_IFAIOMMU_PERI_ID(port)	MTK_M4U_ID(0, port)
> +
>  #endif
> -- 
> 2.18.0
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
