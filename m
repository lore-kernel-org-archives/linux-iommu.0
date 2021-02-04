Return-Path: <SRS0=5Yk+=HG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F65C433E0
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:25:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0888B64FB2
	for <iommu@archiver.kernel.org>; Thu,  4 Feb 2021 23:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0888B64FB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id B56E78729A;
	Thu,  4 Feb 2021 23:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BfF+7UyY4NGw; Thu,  4 Feb 2021 23:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E833C87297;
	Thu,  4 Feb 2021 23:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1D0BC07FD;
	Thu,  4 Feb 2021 23:25:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 404BEC013A
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D72B02DF03
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:25:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SmwlJWwQA76L for <iommu@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 23:25:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 by silver.osuosl.org (Postfix) with ESMTPS id 0FD1A20471
 for <iommu@lists.linux-foundation.org>; Thu,  4 Feb 2021 23:25:52 +0000 (UTC)
Received: by mail-ot1-f50.google.com with SMTP id v1so5140832ott.10
 for <iommu@lists.linux-foundation.org>; Thu, 04 Feb 2021 15:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=v2nkVg18wGZEoa8kUGTJqurwpIhtPaAbXmqRIWrxCUE=;
 b=lcGQCBmCAhK9z1DAk27qo4bYzLfYYiW/onw0M70MTSwd7smDtZ/jqQvSuWIAoddCGr
 u02kBUrXHg1EMTsXnJKkHEnlpo4gMJDuuYh55uDgQrehfVKpdBJhS58ahPQZVWdMpb0M
 QwT/vb3x7fNpYzhwVE8iLnJRqj7idYk52upfbj0yd4+4tb3fGs4Gb+yuxj1w3kRycGvr
 Vq7MVrAd7bHjhJD/yCAxs1L62qhw7v/vTxpgddBxri9NScQfvpdUS9bkdVIQpncGQ6kd
 O4JKehh67uNwwN3F3N6AR47+oQjVcHrb5+F8GuX4fxsoBFT5X2oz8qpj3VUFH40MxmCx
 SHXw==
X-Gm-Message-State: AOAM530FhrSGqG2iYoylwGym1tRMFGNZrzy/KVakOpjwb8EeetdXUWjZ
 bgkvIU/8e4SZQaQEfnWGfg==
X-Google-Smtp-Source: ABdhPJwJqr3wnatNUe8DWoShRTE94TDBe87ONFVy1DR98EDCJ7JzDYuizEWR+rUsPGi1b34+LdMtCQ==
X-Received: by 2002:a05:6830:1f4e:: with SMTP id
 u14mr1333850oth.65.1612481151222; 
 Thu, 04 Feb 2021 15:25:51 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w10sm1445771oih.8.2021.02.04.15.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Feb 2021 15:25:50 -0800 (PST)
Received: (nullmailer pid 1311195 invoked by uid 1000);
 Thu, 04 Feb 2021 23:25:49 -0000
Date: Thu, 4 Feb 2021 17:25:49 -0600
From: Rob Herring <robh@kernel.org>
To: Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iommu: add bindings for sprd iommu
Message-ID: <20210204232549.GA1305874@robh.at.kernel.org>
References: <20210203090727.789939-1-zhang.lyra@gmail.com>
 <20210203090727.789939-2-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210203090727.789939-2-zhang.lyra@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chunyan Zhang <chunyan.zhang@unisoc.com>, Sheng Xu <sheng.xu@unisoc.com>,
 iommu@lists.linux-foundation.org, Baolin Wang <baolin.wang7@gmail.com>,
 Orson Zhai <orsonzhai@gmail.com>, Robin Murphy <robin.murphy@arm.com>
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

On Wed, Feb 03, 2021 at 05:07:26PM +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> This iommu module can be used by Unisoc's multimedia devices, such as
> display, Image codec(jpeg) and a few signal processors, including
> VSP(video), GSP(graphic), ISP(image), and CPP(camera pixel processor), etc.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../devicetree/bindings/iommu/sprd,iommu.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> new file mode 100644
> index 000000000000..4fc99e81fa66
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> @@ -0,0 +1,72 @@
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
> +      - sprd,iommu-v1
> +
> +  "#iommu-cells":
> +    const: 0
> +    description:
> +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> +      additional information needs to associate with its master device.
> +      Please refer to the generic bindings document for more details,
> +      Documentation/devicetree/bindings/iommu/iommu.txt
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Not required if 'sprd,iommu-regs' is defined.
> +
> +  clocks:
> +    description:
> +      Reference to a gate clock phandle, since access to some of IOMMUs are
> +      controlled by gate clock, but this is not required.
> +
> +  sprd,iommu-regs:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Reference to a syscon phandle plus 1 cell, the syscon defines the
> +      register range used by the iommu and the media device, the cell
> +      defines the offset for iommu registers. Since iommu module shares
> +      the same register range with the media device which uses it.
> +
> +required:
> +  - compatible
> +  - "#iommu-cells"
> +
> +oneOf:
> +  - required:
> +      - reg
> +  - required:
> +      - sprd,iommu-regs
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    iommu_disp: iommu-disp {
> +      compatible = "sprd,iommu-v1";
> +      sprd,iommu-regs = <&dpu_regs 0x800>;

If the IOMMU is contained within another device, then it should just be 
a child node of that device. Or just make 'dpu_regs' an IOMMU provider 
(i.e. just add #iommu-cells to it).

> +      #iommu-cells = <0>;
> +    };
> +
> +  - |
> +    iommu_jpg: iommu-jpg {
> +      compatible = "sprd,iommu-v1";
> +      sprd,iommu-regs = <&jpg_regs 0x300>;
> +      #iommu-cells = <0>;
> +      clocks = <&mm_gate 1>;
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
