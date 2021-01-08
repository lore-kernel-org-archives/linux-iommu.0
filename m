Return-Path: <SRS0=te8u=GL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030D9C433DB
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 02:25:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EC6223601
	for <iommu@archiver.kernel.org>; Fri,  8 Jan 2021 02:25:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC6223601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D624E86BA6;
	Fri,  8 Jan 2021 02:25:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FNx9TTTt4bXw; Fri,  8 Jan 2021 02:25:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A741D86B90;
	Fri,  8 Jan 2021 02:25:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 874DAC088B;
	Fri,  8 Jan 2021 02:25:50 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1859BC013A
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 02:25:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F323486BA6
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 02:25:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lAFabqaL_Hs3 for <iommu@lists.linux-foundation.org>;
 Fri,  8 Jan 2021 02:25:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com
 [209.85.166.182])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 5315486B90
 for <iommu@lists.linux-foundation.org>; Fri,  8 Jan 2021 02:25:48 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id w17so8814166ilj.8
 for <iommu@lists.linux-foundation.org>; Thu, 07 Jan 2021 18:25:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hre6xfB6NrLqQ3dXVlKDAfHEjfp9rD+sjidZkUWhifo=;
 b=g2yY5mZVR1gStW3eBF8ApkCnQ7F/m1MMQJZwLocwZooni+njR+y46pq7dkcs42kEKJ
 WRD9cEnKG6FHfyd9azi63+MGr5Y5LaK7fABZ5qYIuSAZxcvhYsdrPMNfwZsuM0szhGb3
 nOwEtf0+ULe8pDv75iY4TO9QbvWU41C5ODW+DJSVCLN8ctFsiwNmEJnHAEAGFqOsy4GR
 a2N7DPhDPBsXZBCyHsRQOGQEttM/fDd38PlCI7BjKbTMfXSENEZE1jzXYBx0a69kne7s
 YNQC5BCHnjpKWdt4YoNy22PfxosMbfxnWyi0BcE3Sqt+boUJgK6i5oHAcr1dMNBc4j5F
 6xsw==
X-Gm-Message-State: AOAM532Ur9xdmd3yRSruDXbTFADdsFA3g75VLze5pX6bQfMugvH1Hw29
 BRAm8zqi/uvxboyLMflzTA==
X-Google-Smtp-Source: ABdhPJy6+5gcSiBXjrC4K+yGR0iKJSoDzy7Ki/YVuyrvV6OQ5PDNXOa+TAV4NklLz8zbiPyYZrPUSw==
X-Received: by 2002:a05:6e02:1786:: with SMTP id
 y6mr1718502ilu.74.1610072747732; 
 Thu, 07 Jan 2021 18:25:47 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id h17sm4536936ioz.12.2021.01.07.18.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Jan 2021 18:25:46 -0800 (PST)
Received: (nullmailer pid 1747334 invoked by uid 1000);
 Fri, 08 Jan 2021 02:25:45 -0000
Date: Thu, 7 Jan 2021 19:25:45 -0700
From: Rob Herring <robh@kernel.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
Message-ID: <20210108022545.GA1744725@robh.at.kernel.org>
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201223111633.1711477-1-zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sheng Xu <sheng.xu@unisoc.com>, iommu@lists.linux-foundation.org,
 Kevin Tang <kevin.tang@unisoc.com>, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>
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

On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This patch only adds bindings to support display iommu, support for others
> would be added once finished tests with those devices, such as Image
> codec(jpeg) processor, a few signal processors, including VSP(video),
> GSP(graphic), ISP(image), and camera CPP, etc.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> new file mode 100644
> index 000000000000..4d9a578a7cc9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2020 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc IOMMU and Multi-media MMU
> +
> +maintainers:
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,iommu-disp

Needs to be Soc specific. Is this block specific to display subsys or 
that just happens to be where the instance is?

> +
> +  reg:
> +    maxItems: 1
> +
> +  "#iommu-cells":
> +    const: 0
> +    description:
> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> +      additional information needs to associate with its master device.
> +      Please refer to the generic bindings document for more details,
> +      Documentation/devicetree/bindings/iommu/iommu.txt
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#iommu-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu_disp: iommu@63000000 {
> +      compatible = "sprd,iommu-disp";
> +      reg = <0x63000000 0x880>;
> +      #iommu-cells = <0>;
> +    };
> +
> +...
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
