Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCABEC47094
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 16:52:52 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7381D613E9
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 16:52:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7381D613E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C4B940133;
	Thu, 10 Jun 2021 16:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mpnvSEeoABNQ; Thu, 10 Jun 2021 16:52:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 01334400F3;
	Thu, 10 Jun 2021 16:52:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB991C000E;
	Thu, 10 Jun 2021 16:52:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBA35C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:52:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DDEEB60A4F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:52:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZEqar03ZSP8V for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 16:52:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 06A9B60A3F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 16:52:48 +0000 (UTC)
Received: by mail-ot1-f46.google.com with SMTP id
 q5-20020a9d66450000b02903f18d65089fso314954otm.11
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 09:52:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xmSSSTzI1G/+6aJZJ8BoKiXXr7B+qXzntJBgHmeug3Y=;
 b=IfGvZBF2SmjNTx9W81jbsiyibHFHT81ZOhffhBm9dzYjB4iuGlv3r5mKi+lZqBtaEP
 u0K9Ix4cttrrcUddIeNwwWXnLFrsXGnEnDjTPuC1gVA4Ga0FV37yCy5c9o8DqCqsqyon
 gTRs/MVZJlR5p0O1BVDlX61W8MP8nYGEY+R2O4xYqgXICf1o19jwqEyrd5eXLcYsdDo2
 LOfwAa0UKDNqaAFKUf62fFXvTJWbBgfa81W96TT5j00jarHvFbjijf1aja9J0lCpAVl0
 FGxnHgtFkTCoHa6IezxsAG53svm5PI+PPiAOP/g81lvk50aNM6T19GgPDOO3MAJNiZ91
 CmwA==
X-Gm-Message-State: AOAM533qC+h15m0/sFM7N3pu1VSi5qB10xIN6VnddmkQIqhPueT4R7gd
 lkW1nNVw0Ug/Rw0FXSVQWA==
X-Google-Smtp-Source: ABdhPJyxJx2yyoRpM5CWFF+cVvOk3Yz7iEbL+70+P4FScA/iA6sbd53xkBffuUIqKvda7xsVEg0IYQ==
X-Received: by 2002:a9d:6d0e:: with SMTP id o14mr3267889otp.90.1623343968019; 
 Thu, 10 Jun 2021 09:52:48 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.113])
 by smtp.gmail.com with ESMTPSA id t15sm643045oie.14.2021.06.10.09.52.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 09:52:47 -0700 (PDT)
Received: (nullmailer pid 1955270 invoked by uid 1000);
 Thu, 10 Jun 2021 16:52:44 -0000
Date: Thu, 10 Jun 2021 11:52:44 -0500
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH v3 2/3] dt-bindings: iommu: add DART iommu bindings
Message-ID: <20210610165244.GA1948260@robh.at.kernel.org>
References: <20210603085003.50465-1-sven@svenpeter.dev>
 <20210603085003.50465-3-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210603085003.50465-3-sven@svenpeter.dev>
Cc: devicetree@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>,
 Will Deacon <will@kernel.org>, Hector Martin <marcan@marcan.st>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Alexander Graf <graf@amazon.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed.mediouni@caramail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org, Stan Skowronek <stan@corellium.com>
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

On Thu, Jun 03, 2021 at 10:50:02AM +0200, Sven Peter wrote:
> DART (Device Address Resolution Table) is the iommu found on Apple
> ARM SoCs such as the M1.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  .../devicetree/bindings/iommu/apple,dart.yaml | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/apple,dart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> new file mode 100644
> index 000000000000..db21ca07d121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/apple,dart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple DART IOMMU
> +
> +maintainers:
> +  - Sven Peter <sven@svenpeter.dev>
> +
> +description: |+
> +  Apple SoCs may contain an implementation of their Device Address
> +  Resolution Table which provides a mandatory layer of address
> +  translations for various masters.
> +
> +  Each DART instance is capable of handling up to 16 different streams
> +  with individual pagetables and page-level read/write protection flags.
> +
> +  This DART IOMMU also raises interrupts in response to various
> +  fault conditions.
> +
> +properties:
> +  compatible:
> +    const: apple,t8103-dart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Reference to the gate clock phandle if required for this IOMMU.
> +      Optional since not all IOMMUs are attached to a clock gate.
> +
> +  '#iommu-cells':
> +    const: 1
> +    description:
> +      Has to be one. The single cell describes the stream id emitted by
> +      a master to the IOMMU.
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#iommu-cells'
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    dart1: iommu@82f80000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f80000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +
> +    master1 {
> +      iommus = <&{/dart1} 0>;

/dart1 is a path, but 'dart1' is a label. You need '&dart1' (or 
'&{/iommu@82f80000}' but that doesn't really work here because the 
examples get prefixed with /example-n/...)

With that fixed,

Reviewed-by: Rob Herring <robh@kernel.org>


> +    };
> +
> +  - |+
> +    dart2a: iommu@82f00000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f00000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +    dart2b: iommu@82f80000 {
> +      compatible = "apple,t8103-dart";
> +      reg = <0x82f80000 0x4000>;
> +      interrupts = <1 781 4>;
> +      #iommu-cells = <1>;
> +    };
> +
> +    master2 {
> +      iommus = <&{/dart2a} 0>, <&{/dart2b} 1>;
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 673cadd5107a..4373d63f9ccf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1240,6 +1240,12 @@ L:	linux-input@vger.kernel.org
>  S:	Odd fixes
>  F:	drivers/input/mouse/bcm5974.c
>  
> +APPLE DART IOMMU DRIVER
> +M:	Sven Peter <sven@svenpeter.dev>
> +L:	iommu@lists.linux-foundation.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iommu/apple,dart.yaml
> +
>  APPLE SMC DRIVER
>  M:	Henrik Rydberg <rydberg@bitmath.org>
>  L:	linux-hwmon@vger.kernel.org
> -- 
> 2.25.1
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
