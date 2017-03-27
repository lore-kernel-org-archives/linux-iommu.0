From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/9] Docs: dt: document qcom iommu bindings
Date: Mon, 27 Mar 2017 14:10:48 -0500
Message-ID: <CAL_JsqJxccRy8GnRyNuZPERPH9z_i30ATPB9sz5E9PN6_pbqxA@mail.gmail.com>
References: <20170314151811.17234-1-robdclark@gmail.com> <20170314151811.17234-4-robdclark@gmail.com>
 <20170323222137.okq227mgsmsjy5zf@rob-hp-laptop> <CAF6AEGsoWPhZ6x-uexGKKUJwtSsn2h+MSg1tjtBdtoPGmARAEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <CAF6AEGsoWPhZ6x-uexGKKUJwtSsn2h+MSg1tjtBdtoPGmARAEg@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rob Clark <robdclark@gmail.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 23, 2017 at 9:45 PM, Rob Clark <robdclark@gmail.com> wrote:
> On Thu, Mar 23, 2017 at 6:21 PM, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Mar 14, 2017 at 11:18:05AM -0400, Rob Clark wrote:
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>>> ---
>>>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 113 +++++++++++++++++++++
>>>  1 file changed, 113 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>> new file mode 100644
>>> index 0000000..fd5b7fa
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>> @@ -0,0 +1,113 @@
>>> +* QCOM IOMMU v1 Implementation
>>> +
>>> +Qualcomm "B" family devices which are not compatible with arm-smmu have
>>> +a similar looking IOMMU but without access to the global register space,
>>> +and optionally requiring additional configuration to route context irqs
>>> +to non-secure vs secure interrupt line.
>>> +
>>> +** Required properties:
>>> +
>>> +- compatible       : Should be one of:
>>> +
>>> +                        "qcom,msm8916-iommu"
>>> +
>>> +- clock-names      : Should be a pair of "iface" (required for IOMMUs
>>> +                     register group access) and "bus" (required for
>>> +                     the IOMMUs underlying bus access).
>>> +- clocks           : Phandles for respective clocks described by
>>> +                     clock-names.
>>> +- #address-cells   : must be 1.
>>> +- #size-cells      : must be 1.
>>> +- #iommu-cells     : Must be 1.
>>> +- ranges           : Base address and size of the iommu context banks.
>>> +- qcom,iommu-secure-id  : secure-id.
>>> +
>>> +- List of sub-nodes, one per translation context bank.  Each sub-node
>>> +  has the following required properties:
>>> +
>>> +  - compatible     : Should be one of:
>>> +        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
>>> +        - "qcom,msm-iommu-v1-sec" : secure context bank
>>> +  - reg            : Base address and size of context bank within the iommu
>>> +  - interrupts     : The context fault irq.
>>> +
>>> +** Optional properties:
>>> +
>>> +- reg              : Base address and size of the SMMU local base, should
>>> +                     be only specified if the iommu requires configuration
>>> +                     for routing of context bank irq's to secure vs non-
>>> +                     secure lines.  (Ie. if the iommu contains secure
>>> +                     context banks)
>>> +
>>> +
>>> +** Examples:
>>> +
>>> +     apps_iommu: iommu@1e20000 {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             #iommu-cells = <1>;
>>> +             compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
>>
>> You didn't document the fallback above. Maybe just drop it if only a few
>> chips have this iommu.
>
> not completely sure I understand what you want..
>
> I think more than a few chips.. I suspect it is more like everything
> after the last "a" family devices (snapdragon 600?) and before 820..
> (well, more or less at least a few years worth of devices, stuff that
> seems likely to be able to run an upstream kernel would be 800, 805,
> 808, 810.. and I guess there are some cut down 6xx and 4xx variants of
> those)

Okay, then you just need to list qcom,msm-iommu-v1 above. Something
like 'followed by "qcom,msm-iommu-v1"' at the end of the list of
compatibles.

Rob
