Return-Path: <SRS0=SEpV=QF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9260C433F5
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 15:51:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6287A613DB
	for <iommu@archiver.kernel.org>; Thu, 18 Nov 2021 15:51:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6287A613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DF8860A41;
	Thu, 18 Nov 2021 15:51:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5ZwzU8nl2154; Thu, 18 Nov 2021 15:51:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EC23F60B30;
	Thu, 18 Nov 2021 15:51:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED79C001E;
	Thu, 18 Nov 2021 15:51:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA87CC0012
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 15:51:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 98B2F8186E
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 15:51:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EM9XjOoELqDa for <iommu@lists.linux-foundation.org>;
 Thu, 18 Nov 2021 15:51:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8EBEA81758
 for <iommu@lists.linux-foundation.org>; Thu, 18 Nov 2021 15:51:02 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9545D6D;
 Thu, 18 Nov 2021 07:51:01 -0800 (PST)
Received: from [10.57.82.45] (unknown [10.57.82.45])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3CA33F766;
 Thu, 18 Nov 2021 07:50:59 -0800 (PST)
Message-ID: <2f17b812-367c-da75-a2a6-0c16a93cf4a3@arm.com>
Date: Thu, 18 Nov 2021 15:50:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH 1/2] dt-bindings: Add Arm SMMUv3 PMCG binding
Content-Language: en-GB
To: Rob Herring <robh+dt@kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20211116113536.69758-1-jean-philippe@linaro.org>
 <20211116113536.69758-2-jean-philippe@linaro.org>
 <CAL_JsqJ6v6HKA3ifQoeVh+2iABL7fBPCS0ntTXb0BA8LO0vi8g@mail.gmail.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <CAL_JsqJ6v6HKA3ifQoeVh+2iABL7fBPCS0ntTXb0BA8LO0vi8g@mail.gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2021-11-17 23:19, Rob Herring wrote:
> On Tue, Nov 16, 2021 at 5:52 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
>>
>> Add binding for the Arm SMMUv3 PMU. Each node represents a PMCG, and is
>> placed as a sibling node of the SMMU. Although the PMCGs registers may
>> be within the SMMU MMIO region, they are separate devices, and there can
>> be multiple PMCG devices for each SMMU (for example one for the TCU and
>> one for each TBU).
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>> ---
>>   .../bindings/iommu/arm,smmu-v3-pmcg.yaml      | 67 +++++++++++++++++++
>>   1 file changed, 67 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
>> new file mode 100644
>> index 000000000000..a893e071fdb4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3-pmcg.yaml
>> @@ -0,0 +1,67 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iommu/arm,smmu-v3-pmcg.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Arm SMMUv3 Performance Monitor Counter Group
>> +
>> +maintainers:
>> +  - Will Deacon <will@kernel.org>
>> +  - Robin Murphy <Robin.Murphy@arm.com>
>> +
>> +description: |+
> 
> Don't need '|+' if no formatting to preserve.
> 
>> +  An SMMUv3 may have several Performance Monitor Counter Group (PMCG).
>> +  They are standalone performance monitoring units that support both
>> +  architected and IMPLEMENTATION DEFINED event counters.
> 
> Humm, I don't know that I agree they are standalone. They could be I
> guess, but looking at the MMU-600 spec the PMCG looks like it's just a
> subset of registers in a larger block. This seems similar to MPAM
> (which I'm working on a binding for) where it's just a register map
> and interrupts, but every other possible resource is unspecified by
> the architecture.

They're "standalone" in the sense that they don't have to be part of an 
SMMU, they could be part of a PCIe root complex or other SoC device that 
couples to an SMMU (e.g. anything that can speak AMBA DTI, in the case 
of our SMMU implementations).

In fact our SMMU TBUs are pretty much separate devices themselves, they 
just *only* speak DTI, so access to their registers is proxied through 
the TCU programming interface.

> The simplest change from this would be just specifying that the PMCG
> is child node(s) of whatever it is part of. The extreme would be this
> is all part of the SMMU binding (i.e. reg entry X is PMCG registers,
> interrupts entry Y is pmu irq).

Being a child of its associated device doesn't seem too bad 
semantically, however how would we describe a PMCG as a child of a PCIe 
node when its "reg" property still exists in the parent address space 
and not PCI config/memory space like any of its siblings? Also in 
practical terms, consuming that binding in Linux and getting the things 
to probe when it may want to be independent of whether we even 
understand the parent node at all could be... unpleasant.

Robin.

>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^pmu@[0-9a-f]*"
> 
> s/*/+/
> 
> Need at least 1 digit.
> 
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +        - enum:
>> +          - hisilicon,smmu-v3-pmcg-hip08
>> +        - const: arm,smmu-v3-pmcg
>> +      - const: arm,smmu-v3-pmcg
>> +
>> +  reg:
>> +    description: |
>> +      Base addresses of the PMCG registers. Either a single address for Page 0
>> +      or an additional address for Page 1, where some registers can be
>> +      relocated with SMMU_PMCG_CFGR.RELOC_CTRS.
>> +    minItems: 1
>> +    maxItems: 2
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  msi-parent: true
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |+
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    pmu@2b420000 {
>> +            compatible = "arm,smmu-v3-pmcg";
>> +            reg = <0 0x2b420000 0 0x1000>,
>> +                  <0 0x2b430000 0 0x1000>;
>> +            interrupts = <GIC_SPI 80 IRQ_TYPE_EDGE_RISING>;
>> +            msi-parent = <&its 0xff0000>;
>> +    };
>> +
>> +    pmu@2b440000 {
>> +            compatible = "arm,smmu-v3-pmcg";
>> +            reg = <0 0x2b440000 0 0x1000>,
>> +                  <0 0x2b450000 0 0x1000>;
>> +            interrupts = <GIC_SPI 81 IRQ_TYPE_EDGE_RISING>;
>> +            msi-parent = <&its 0xff0000>;
>> +    };
>> --
>> 2.33.1
>>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
