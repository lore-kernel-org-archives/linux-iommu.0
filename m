Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B880526B2DA
	for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763634227; cv=none; b=moE0hK88KSoOjciho3CzJ5tziUHnG11es8B7QUVJhXD3rhrl5Kcfv/aMopp89pa2yLMAzNQLXtmlOWS0TOyJ/gW2J1QMYWEyH10Kp/X1kJJ64S4jMFZdCZHMEQMpbIn0pxrcA9eTjpMXwN5LOXbU1yQEhB5XX9ufQPCJWU0pLyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763634227; c=relaxed/simple;
	bh=KjvXAbH7/GZFMTiVaSj8oMiOI6hItZY5jHsJJofH2pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LyUz9+iaM4arMN8R723xM9kkrRgl+N4fm1qRiFcPdMJpM7ii9CkXsIv1F5++ZM0EYTsGiOGP/w/NDfBF+93tCYGzVrErcT9wOxv/I62Bnbyzh1UKXW+D5EBU0CrhzGF3m4I2fghs9asTH/icAu6smGYz/H4cJ1q0oL8o2EjQUJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930E9339;
	Thu, 20 Nov 2025 02:23:34 -0800 (PST)
Received: from [10.57.87.140] (unknown [10.57.87.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51E7B3F740;
	Thu, 20 Nov 2025 02:23:39 -0800 (PST)
Message-ID: <c23f72a6-24a4-41c4-b5f5-70a8589f1199@arm.com>
Date: Thu, 20 Nov 2025 10:23:36 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: iommu: Add NVIDIA Tegra CMDQV support
To: Ashish Mhetre <amhetre@nvidia.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, will@kernel.org
Cc: joro@8bytes.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
 jgg@ziepe.ca, nicolinc@nvidia.com, linux-tegra@nvidia.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
References: <20251031062959.1521704-1-amhetre@nvidia.com>
 <20251031062959.1521704-3-amhetre@nvidia.com>
 <20251031-witty-sociable-chachalaca-b73dbc@kuoka>
 <4f6496de-d3c8-4701-a9b4-6f695018eb5e@nvidia.com>
 <ef5bcd93-c88b-4242-be31-a3a4765fe5d8@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <ef5bcd93-c88b-4242-be31-a3a4765fe5d8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-11-20 6:07 am, Ashish Mhetre wrote:
> 
> On 11/3/2025 7:24 PM, Ashish Mhetre wrote:
>>
>> On 10/31/2025 1:44 PM, Krzysztof Kozlowski wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Fri, Oct 31, 2025 at 06:29:58AM +0000, Ashish Mhetre wrote:
>>>> The Command Queue Virtualization (CMDQV) hardware is part of the
>>>> SMMUv3 implementation on NVIDIA Tegra SoCs. It assists in
>>>> virtualizing the command queue for the SMMU.
>>> If this is specific to Nvidia, then I think you need specific front
>>> compatible and disallow it for other vendors.
>>
>> Yes, CMDQV is specific to Nvidia. There isn't currently a vendor-specific
>> compatible for Nvidia's arm,smmu-v3 implementation. Would it be 
>> acceptable
>> to document this as Nvidia-specific in the description? Or can we add a
>> new Nvidia-specific compatible string like "nvidia,smmu-v3" if that's
>> preferred and use conditional schema to restrict the property?
> 
> Hi Will, Robin,
> 
> Do you have any suggestions on this? I have followed existing ACPI approach
> for implementing DT support.

No, the way the ACPI binding is implemented has the lookup going *from* 
the CMDQV node back to the SMMU instance (via the matching identifier) - 
this is entirely the opposite. The literal DT equivalent would be to use 
for_each_matching_node/for_each_compatible_node to scan the CMDQV nodes 
for a property indicating the relevant SMMU.

I'm not hugely fussed either way though - since the fact is the Tegra234 
SMMU does have this custom modification, a specific 
"nvidia,tegra234-smmu", "arm,smmu-v3" compatible isn't inappropriate, 
even if it really doesn't make any difference to architectural SMMU 
operation without awareness of the other CMDQV nodes.

Thanks,
Robin.

> Will it be fine to add separate compatible 
> string
> for Nvidia Tegra264 SMMU to restrict the usage of CMDQV?
> 
>>>> Add a new device tree binding document for nvidia,tegra264-cmdqv.
>>>>
>>>> Also update the arm,smmu-v3 binding to include an optional nvidia,cmdqv
>>>> property. This property is a phandle to the CMDQV device node, allowing
>>>> the SMMU driver to associate with its corresponding CMDQV instance.
>>>>
>>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>>> ---
>>>>   .../bindings/iommu/arm,smmu-v3.yaml           | 10 ++++
>>>>   .../bindings/iommu/nvidia,tegra264-cmdqv.yaml | 46 +++++++++++++++ 
>>>> ++++
>>>>   2 files changed, 56 insertions(+)
>>>>   create mode 100644 Documentation/devicetree/bindings/iommu/ 
>>>> nvidia,tegra264-cmdqv.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu- 
>>>> v3.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> index 75fcf4cb52d9..edc0c20a0c80 100644
>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu-v3.yaml
>>>> @@ -58,6 +58,15 @@ properties:
>>>>
>>>>     msi-parent: true
>>>>
>>>> +  nvidia,cmdqv:
>>>> +    description: |
>>>> +      A phandle to its pairing CMDQV extension for an 
>>>> implementation on NVIDIA
>>>> +      Tegra SoC.
>>>> +
>>>> +      If this property is absent, CMDQ-Virtualization won't be used 
>>>> and SMMU
>>>> +      will only use its own CMDQ.
>>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>>> +
>>>>     hisilicon,broken-prefetch-cmd:
>>>>       type: boolean
>>>>       description: Avoid sending CMD_PREFETCH_* commands to the SMMU.
>>>> @@ -92,4 +101,5 @@ examples:
>>>>               dma-coherent;
>>>>               #iommu-cells = <1>;
>>>>               msi-parent = <&its 0xff0000>;
>>>> +            nvidia,cmdqv = <&cmdqv>;
>>>>       };
>>>> diff --git a/Documentation/devicetree/bindings/iommu/ 
>>>> nvidia,tegra264-cmdqv.yaml b/Documentation/devicetree/bindings/ 
>>>> iommu/nvidia,tegra264-cmdqv.yaml
>>>> new file mode 100644
>>>> index 000000000000..f22c370278a3
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/iommu/nvidia,tegra264- 
>>>> cmdqv.yaml
>>>> @@ -0,0 +1,46 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: NVIDIA Tegra264 CMDQV
>>> Missing blank line
>>
>> Ack, I will correct this in V2.
>>>> +description: |
>>> Do not need '|' unless you need to preserve formatting.
>>
>> Okay, I'll remove this in next version.
>>>> +  The CMDQ-Virtualization hardware block is part of the SMMUv3 
>>>> implementation
>>>> +  on Tegra264 SoCs. It assists in virtualizing the command queue 
>>>> for the SMMU.
>>>> +
>>>> +maintainers:
>>>> +  - NVIDIA Corporation <linux-tegra@nvidia.com>
>>> No. It should be a person. If entire Nvidia cannot find a person, I
>>> don't think we are interested in having this in the kernel.
>>
>> Okay, I'll add Nicolin as maintainer.
>>>> +
>>>> +properties:
>>>> +  compatible:
>>>> +    const: nvidia,tegra264-cmdqv
>>>> +
>>>> +  reg:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupts:
>>>> +    maxItems: 1
>>>> +
>>>> +  interrupt-names:
>>>> +    items:
>>>> +      - const: cmdqv
>>> Drop interript names, obvious.
>>
>> Sure, I will update in V2.
>>>> +
>>>> +required:
>>>> +  - compatible
>>>> +  - reg
>>>> +  - interrupts
>>>> +  - interrupt-names
>>>> +
>>>> +additionalProperties: false
>>>> +
>>>> +examples:
>>>> +  - |
>>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>>> +
>>>> +    cmdqv: cmdqv@8105200000 {
>>> Drop unused label
>>
>> Okay, I will remove the label.
>>> Best regards,
>>> Krzysztof
>>>
