Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7ECC433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 23:20:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09F261BB6
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 23:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C09F261BB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7C817404CD;
	Wed, 17 Nov 2021 23:20:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D27FxXlGIcnJ; Wed, 17 Nov 2021 23:20:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EF4FE4024E;
	Wed, 17 Nov 2021 23:20:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB6DC002E;
	Wed, 17 Nov 2021 23:20:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 664F7C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 23:20:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 413AC82477
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 23:20:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jDp0JycyOOIe for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 23:20:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 240198246D
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 23:20:04 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1CF761BD3
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 23:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1637191203;
 bh=ljTiLvzG7o9miaf+PiBSRpKybCCJX219LlLPvIIbSRk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=RHRfyZMKroozcJehDE7vGjJEy5SiGQ7hpHla3uoiKAtnc71hBaHIxTBQrVWQBHD7U
 DTyJzu/tAVgFlPbQ+OMb68sz50/mhnsVKi+bnts86Hzk6lDJYmZ9ZRhoPhgBtdRhkc
 7HTbyws/dqmUI6DJxw1f4HFYySATti/yMt9vQxYZaHndmOiVdYC8w4kPMP+GKI4lmL
 uGuSGlgx8zg4TGyRZfUg6DXEdLP43MQ8Z1gDhbyxzyUeUdIQLB1nkKpD+It8FrA0/r
 rYLphcaUrMVNFdOP0cKl5RqjAs65QG8BjTHffseODOqtfTKtxGA1eoveATnOE7VEhv
 nE0T4al5bRGcA==
Received: by mail-qv1-f46.google.com with SMTP id jo22so3182268qvb.13
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 15:20:03 -0800 (PST)
X-Gm-Message-State: AOAM532FRO/fUrUOEOQgeYJnVXAEY1Us3gmAjSy3iNtgxlK76ojyDR+6
 VNu/7SGgQPRT70j0uz/MutBJgMNQHBHOF7RolQ==
X-Google-Smtp-Source: ABdhPJyl4UtXwfvOz/nvoaclbR+2WYqHAJ7Xq6Wh5OV9pYS9fvtIjN2HCdJ+OgdYl6Z3NYwl5T/xYfAWmTWXKdFYjdY=
X-Received: by 2002:a05:6214:27ee:: with SMTP id
 jt14mr59508225qvb.5.1637191202788; 
 Wed, 17 Nov 2021 15:20:02 -0800 (PST)
MIME-Version: 1.0
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-2-jean-philippe@linaro.org>
In-Reply-To: <20211116113536.69758-2-jean-philippe@linaro.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 17 Nov 2021 17:19:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ6v6HKA3ifQoeVh+2iABL7fBPCS0ntTXb0BA8LO0vi8g@mail.gmail.com>
Message-ID: <CAL_JsqJ6v6HKA3ifQoeVh+2iABL7fBPCS0ntTXb0BA8LO0vi8g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add Arm SMMUv3 PMCG binding
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>,
 Linux IOMMU <iommu@lists.linux-foundation.org>, uchida.jun@socionext.com,
 Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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

On Tue, Nov 16, 2021 at 5:52 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> Add binding for the Arm SMMUv3 PMU. Each node represents a PMCG, and is
> placed as a sibling node of the SMMU. Although the PMCGs registers may
> be within the SMMU MMIO region, they are separate devices, and there can
> be multiple PMCG devices for each SMMU (for example one for the TCU and
> one for each TBU).
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
>
> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
> new file mode 100644
> index 000000000000..a893e071fdb4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iommu/arm,smmu-v3-pmcg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Arm SMMUv3 Performance Monitor Counter Group
> +
> +maintainers:
> +  - Will Deacon <will@kernel.org>
> +  - Robin Murphy <Robin.Murphy@arm.com>
> +
> +description: |+

Don't need '|+' if no formatting to preserve.

> +  An SMMUv3 may have several Performance Monitor Counter Group (PMCG).
> +  They are standalone performance monitoring units that support both
> +  architected and IMPLEMENTATION DEFINED event counters.

Humm, I don't know that I agree they are standalone. They could be I
guess, but looking at the MMU-600 spec the PMCG looks like it's just a
subset of registers in a larger block. This seems similar to MPAM
(which I'm working on a binding for) where it's just a register map
and interrupts, but every other possible resource is unspecified by
the architecture.

The simplest change from this would be just specifying that the PMCG
is child node(s) of whatever it is part of. The extreme would be this
is all part of the SMMU binding (i.e. reg entry X is PMCG registers,
interrupts entry Y is pmu irq).

> +
> +properties:
> +  $nodename:
> +    pattern: "^pmu@[0-9a-f]*"

s/*/+/

Need at least 1 digit.

> +  compatible:
> +    oneOf:
> +      - items:
> +        - enum:
> +          - hisilicon,smmu-v3-pmcg-hip08
> +        - const: arm,smmu-v3-pmcg
> +      - const: arm,smmu-v3-pmcg
> +
> +  reg:
> +    description: |
> +      Base addresses of the PMCG registers. Either a single address for Page 0
> +      or an additional address for Page 1, where some registers can be
> +      relocated with SMMU_PMCG_CFGR.RELOC_CTRS.
> +    minItems: 1
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  msi-parent: true
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |+
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    pmu@2b420000 {
> +            compatible = "arm,smmu-v3-pmcg";
> +            reg = <0 0x2b420000 0 0x1000>,
> +                  <0 0x2b430000 0 0x1000>;
> +            interrupts = <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>;
> +            msi-parent = <&its 0xff0000>;
> +    };
> +
> +    pmu@2b440000 {
> +            compatible = "arm,smmu-v3-pmcg";
> +            reg = <0 0x2b440000 0 0x1000>,
> +                  <0 0x2b450000 0 0x1000>;
> +            interrupts = <GIC_SPI 81 IRQ_TYPE_EDGE_RISING>;
> +            msi-parent = <&its 0xff0000>;
> +    };
> --
> 2.33.1
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
