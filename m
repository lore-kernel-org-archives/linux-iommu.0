Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45024C433EF
	for <iommu@archiver.kernel.org>; Thu,  2 Jun 2022 13:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C25BB400D2;
	Thu,  2 Jun 2022 13:44:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ygUKBhkLj2fE; Thu,  2 Jun 2022 13:43:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 90F5F40AFA;
	Thu,  2 Jun 2022 13:43:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45391C0032;
	Thu,  2 Jun 2022 13:43:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE80FC002D
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 13:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CEEA641797
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 13:43:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnOB1nSCVkCN for <iommu@lists.linux-foundation.org>;
 Thu,  2 Jun 2022 13:43:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 87AA64150F
 for <iommu@lists.linux-foundation.org>; Thu,  2 Jun 2022 13:43:56 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-e5e433d66dso6765059fac.5
 for <iommu@lists.linux-foundation.org>; Thu, 02 Jun 2022 06:43:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hQGK49GF9DeJULgey4jAcL7Oa6D8j/sPMETA1NkIOJc=;
 b=kwtIV+Ljf4Rqkgf0kFRFRm55C65rwvQhMNEMJqrNc3OwWKfUJFUa7NtlwFK/9jhbFj
 6vCyC8Xy0QgBLuXBqWJKVf/mKmh0mthiM86JxGyySB9qesrhXOJkRvbMtFr7ubu8wLdh
 lXoZOAvRWSsEpd/pkrZ2+tidXAAj30kXFHQmPQAGA3iba9Okf5nBOYgsajpPFnHnMDxV
 QB4XlDxkeJsY1418LUpQvWf+iIr6cSZtGY+SiJ796ynjgD+WGtMuvtBYSC7pVEcxLby2
 dUaWaq3Knr/hc7dW1rYkdQLgUeXRhOEx8vvZoaTPblof39xeGBKzQbNfns6Xp6CUG81p
 U5DQ==
X-Gm-Message-State: AOAM531PfZXfHPNV7AFtYn4YPi9wHY6ZxieKwiiIvXJbp8uLZ19rV6U9
 Oe5ZY1rPCTB8DbTm2JVaMw==
X-Google-Smtp-Source: ABdhPJzL70GYPEawMMZyFEupbpoldLQk6350MsIEKUwqginMohKYrSm6Ju3LfMU8fTraG27RUbk8xA==
X-Received: by 2002:a05:6871:b0f:b0:f3:3687:524b with SMTP id
 fq15-20020a0568710b0f00b000f33687524bmr2642992oab.131.1654177435454; 
 Thu, 02 Jun 2022 06:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 t18-20020a4adbd2000000b0040eb1d3f43dsm2330707oou.2.2022.06.02.06.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jun 2022 06:43:55 -0700 (PDT)
Received: (nullmailer pid 2175981 invoked by uid 1000);
 Thu, 02 Jun 2022 13:43:54 -0000
Date: Thu, 2 Jun 2022 08:43:54 -0500
From: Rob Herring <robh@kernel.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 2/3] iommu: bindings: Add binding documentation for
 Toshiba Visconti5 IOMMU device
Message-ID: <20220602134354.GA2170842-robh@kernel.org>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220525013147.2215355-3-nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
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

On Wed, May 25, 2022 at 10:31:46AM +0900, Nobuhiro Iwamatsu wrote:
> Add documentation for the binding of Toshiba Visconti5 SoC's IOMMU.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .../bindings/iommu/toshiba,visconti-atu.yaml  | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> new file mode 100644
> index 000000000000..af8d6688fa70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/toshiba,visconti-atu.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: GPL-2.0-only

Dual license: GPL-2.0-only OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/toshiba,visconti-atu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Toshiba ARM SoC Visconti5 IOMMU (ATU)
> +
> +maintainers:
> +  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> +
> +description: |+
> +  IOMMU (ATU) driver can bse used for Visconti5's multimedia IPs, such as

Bindings are for hardware, not drivers.

> +  DCNN (Deep Convolutional Neural Network), VIIF(Video Input), VOIF(Video
> +  output), and others.
> +
> +properties:
> +  compatible:
> +    const: toshiba,visconti-atu
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#iommu-cells":
> +    const: 0
> +
> +  toshiba,max-entry:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The size of entry for address
> +    enum:
> +      - 16
> +      - 32
> +
> +  toshiba,reserved-entry:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The reserve number of entry address.
> +    default: 0
> +    minimum: 0
> +    maximum: 32

These 2 need a better description of what they are for.

> +
> +required:
> +  - compatible
> +  - reg
> +  - "#iommu-cells"
> +  - toshiba,max-entry
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        atu_affine0: iommu@1400f000 {

Drop unused labels.

> +            compatible = "toshiba,visconti-atu";
> +            reg = <0 0x1400F000 0 0x1000>;
> +            toshiba,max-entry = <16>;
> +            toshiba,reserved-entry = <1>;
> +            #iommu-cells = <0>;
> +        };
> +    };
> -- 
> 2.36.0
> 
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
