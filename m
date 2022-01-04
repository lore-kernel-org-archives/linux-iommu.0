Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A0EDC433EF
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 22:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA25B40879;
	Tue,  4 Jan 2022 22:21:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vPp9EF9HHI9b; Tue,  4 Jan 2022 22:21:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 988F440341;
	Tue,  4 Jan 2022 22:21:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79891C0030;
	Tue,  4 Jan 2022 22:21:51 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB4F3C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:21:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B4C0E80C33
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:21:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 27jirDFWQMfd for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 22:21:48 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A313780C30
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 22:21:48 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id
 w19-20020a056830061300b0058f1dd48932so48439087oti.11
 for <iommu@lists.linux-foundation.org>; Tue, 04 Jan 2022 14:21:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sIRIjVAxLAvaKX3Gc+RLn9a30jBouaD7oSrdlD+iXfE=;
 b=WZOwgPeK5zS7Pmm1I/0ryxp88ne8K3r+FxXIN8VMXZhnYT+O1abaGKJ5Lw6Lfldkhj
 0mwtWEw1SVKexftNELPmYLzOGCZbgInJz71g+zmwZ9wOaRQrt6+sDN2vvNlMQV1S717L
 468nTX+ONtu+1aT7ZCU6O7X1X9wpP+cJSqukFGrEW8fmyFkJXIJb4a2sSw6IJQLcFYot
 VJuV9LzvIBZle8YAuLb9eInJEbKFjDHU7KSNbshJSES9b5HFQY47lPVMprJpkWO7EaO0
 hCvFWp/UOF7pPvZdgl5UY6j18YGgvauGqkdqyUSJesmdsQXQ8wLLSJSYmyQeJ9+QOC48
 kTHQ==
X-Gm-Message-State: AOAM532Dt6cEz8sDnV2c5+PAOj3y4+ye0f2h0kihPU7lkyXJWGPhRaOa
 EwZNVJgp9LY3pJzJLM1yeA==
X-Google-Smtp-Source: ABdhPJw8C1rfqCqeEc1yJ6y1fz2F7Ico3ryaw4i0Lv3vcZ/SE0/FYv4dcM2+FX1/udDTK4lTMH9bqA==
X-Received: by 2002:a9d:744f:: with SMTP id p15mr37327564otk.314.1641334907595; 
 Tue, 04 Jan 2022 14:21:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id q26sm7263643ooc.17.2022.01.04.14.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jan 2022 14:21:46 -0800 (PST)
Received: (nullmailer pid 1549908 invoked by uid 1000);
 Tue, 04 Jan 2022 22:21:45 -0000
Date: Tue, 4 Jan 2022 16:21:45 -0600
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: iommu: Convert msm,iommu-v0 to yaml
Message-ID: <YdTIeRjM5PkJbpbO@robh.at.kernel.org>
References: <20211225193556.66804-1-david@ixit.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211225193556.66804-1-david@ixit.cz>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Andy Gross <agross@kernel.org>, Will Deacon <will@kernel.org>,
 ~okias/devicetree@lists.sr.ht
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

On Sat, Dec 25, 2021 at 08:35:55PM +0100, David Heidelberg wrote:
> Convert Qualcomm IOMMU v0 implementation to yaml format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - fix wrong path in binding $id
>  - comment qcom,mdp4 node example (we don't want to validate it yet)
> 
>  .../bindings/iommu/msm,iommu-v0.txt           | 64 -------------
>   .../bindings/iommu/qcom,iommu-v0.yaml         | 96 +++++++++++++++++++

qcom,apq8064-iommu.yaml

At this point, I don't think we'll get a 2nd user.

>  2 files changed, 96 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt b/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> deleted file mode 100644
> index 20236385f26e..000000000000
> --- a/Documentation/devicetree/bindings/iommu/msm,iommu-v0.txt
> +++ /dev/null
> @@ -1,64 +0,0 @@
> -* QCOM IOMMU
> -
> -The MSM IOMMU is an implementation compatible with the ARM VMSA short
> -descriptor page tables. It provides address translation for bus masters outside
> -of the CPU, each connected to the IOMMU through a port called micro-TLB.
> -
> -Required Properties:
> -
> -  - compatible: Must contain "qcom,apq8064-iommu".
> -  - reg: Base address and size of the IOMMU registers.
> -  - interrupts: Specifiers for the MMU fault interrupts. For instances that
> -    support secure mode two interrupts must be specified, for non-secure and
> -    secure mode, in that order. For instances that don't support secure mode a
> -    single interrupt must be specified.
> -  - #iommu-cells: The number of cells needed to specify the stream id. This
> -		  is always 1.
> -  - qcom,ncb:	  The total number of context banks in the IOMMU.
> -  - clocks	: List of clocks to be used during SMMU register access. See
> -		  Documentation/devicetree/bindings/clock/clock-bindings.txt
> -		  for information about the format. For each clock specified
> -		  here, there must be a corresponding entry in clock-names
> -		  (see below).
> -
> -  - clock-names	: List of clock names corresponding to the clocks specified in
> -		  the "clocks" property (above).
> -		  Should be "smmu_pclk" for specifying the interface clock
> -		  required for iommu's register accesses.
> -		  Should be "smmu_clk" for specifying the functional clock
> -		  required by iommu for bus accesses.
> -
> -Each bus master connected to an IOMMU must reference the IOMMU in its device
> -node with the following property:
> -
> -  - iommus: A reference to the IOMMU in multiple cells. The first cell is a
> -	    phandle to the IOMMU and the second cell is the stream id.
> -	    A single master device can be connected to more than one iommu
> -	    and multiple contexts in each of the iommu. So multiple entries
> -	    are required to list all the iommus and the stream ids that the
> -	    master is connected to.
> -
> -Example: mdp iommu and its bus master
> -
> -                mdp_port0: iommu@7500000 {
> -			compatible = "qcom,apq8064-iommu";
> -			#iommu-cells = <1>;
> -			clock-names =
> -			    "smmu_pclk",
> -			    "smmu_clk";
> -			clocks =
> -			    <&mmcc SMMU_AHB_CLK>,
> -			    <&mmcc MDP_AXI_CLK>;
> -			reg = <0x07500000 0x100000>;
> -			interrupts =
> -			    <GIC_SPI 63 0>,
> -			    <GIC_SPI 64 0>;
> -			qcom,ncb = <2>;
> -		};
> -
> -		mdp: qcom,mdp@5100000 {
> -			compatible = "qcom,mdp";
> -			...
> -			iommus = <&mdp_port0 0
> -				  &mdp_port0 2>;
> -		};
> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> new file mode 100644
> index 000000000000..6f166c30b9ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu-v0.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +
> +$id: "http://devicetree.org/schemas/iommu/qcom,iommu-v0.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm IOMMU for APQ8064
> +
> +maintainers:
> +  - Will Deacon <will@kernel.org>
> +
> +description: >
> +  The MSM IOMMU is an implementation compatible with the ARM VMSA short
> +  descriptor page tables. It provides address translation for bus masters
> +  outside of the CPU, each connected to the IOMMU through a port called micro-TLB.
> +
> +properties:
> +  compatible:
> +    const: qcom,apq8064-iommu
> +
> +  clocks:
> +    items:
> +      - description: interface clock for register accesses
> +      - description: functional clock for bus accesses
> +
> +  clock-names:
> +    oneOf:
> +      - items:
> +          - const: smmu_pclk
> +          - const: smmu_clk
> +      - items:
> +          - const: smmu_pclk
> +          - const: iommu_clk

Where did this come from? It wasn't documented before.

> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: >
> +      Specifiers for the MMU fault interrupts. For instances that
> +      support secure mode two interrupts must be specified, for non-secure and
> +      secure mode, in that order. For instances that don't support secure mode a
> +      single interrupt must be specified.

minItems: 1
items:
  - description: non-secure irq...
  - description: ...


> +
> +  "#iommu-cells":
> +    const: 1
> +
> +  qcom,ncb:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The total number of context banks in the IOMMU.
> +
> +# Each bus master connected to an IOMMU must reference the IOMMU
> +# in its device node with the following property:

What property? No need to describe how the iommu binding works.

> +#   A reference to the IOMMU in multiple cells. The first cell is a
> +#   phandle to the IOMMU and the second cell is the stream id.
> +#   A single master device can be connected to more than one iommu
> +#   and multiple contexts in each of the iommu. So multiple entries
> +#   are required to list all the iommus and the stream ids that the
> +#   master is connected to.

Put the cells description under #iommu-cells.

> +
> +required:
> +  - clocks
> +  - clock-names
> +  - reg
> +  - interrupts
> +  - qcom,ncb
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,mmcc-msm8960.h>
> +
> +    mdp_port0: iommu@7500000 {
> +            compatible = "qcom,apq8064-iommu";
> +            #iommu-cells = <1>;
> +            clock-names =
> +                "smmu_pclk",
> +                "smmu_clk";
> +            clocks =
> +                <&clk SMMU_AHB_CLK>,
> +                <&clk MDP_AXI_CLK>;
> +            reg = <0x07500000 0x100000>;
> +            interrupts =
> +                <0 63 0>,
> +                <0 64 0>;
> +            qcom,ncb = <2>;
> +    };
> +
> +    /* mdp: mdp@5100000 {
> +            compatible = "qcom,mdp4";
> +            ...
> +
> +            iommus = <&mdp_port0 0
> +                      &mdp_port0 2>;
> +    };*/
> -- 
> 2.34.1
> 
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
