From: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 1/4] Docs: dt: document qcom iommu bindings
Date: Fri, 26 May 2017 14:22:06 -0400
Message-ID: <CAF6AEGsZ8BHBS4U7odd90Fq0V1zK0BOVs-3HdPTC1Dg4n-z_og@mail.gmail.com>
References: <20170525173340.26904-1-robdclark@gmail.com> <20170525173340.26904-2-robdclark@gmail.com>
 <be8c6290-7127-ad2b-d3d7-48029379ab3e@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <be8c6290-7127-ad2b-d3d7-48029379ab3e@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Archit Taneja <architt@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, May 26, 2017 at 7:33 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 25/05/17 18:33, Rob Clark wrote:
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 121 +++++++++++++++++++++
>>  1 file changed, 121 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> new file mode 100644
>> index 0000000..0d50f84
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> @@ -0,0 +1,121 @@
>> +* QCOM IOMMU v1 Implementation
>> +
>> +Qualcomm "B" family devices which are not compatible with arm-smmu have
>> +a similar looking IOMMU but without access to the global register space,
>> +and optionally requiring additional configuration to route context irqs
>> +to non-secure vs secure interrupt line.
>> +
>> +** Required properties:
>> +
>> +- compatible       : Should be one of:
>> +
>> +                        "qcom,msm8916-iommu"
>> +
>> +                     Followed by "qcom,msm-iommu-v1".
>> +
>> +- clock-names      : Should be a pair of "iface" (required for IOMMUs
>> +                     register group access) and "bus" (required for
>> +                     the IOMMUs underlying bus access).
>> +
>> +- clocks           : Phandles for respective clocks described by
>> +                     clock-names.
>> +
>> +- #address-cells   : must be 1.
>> +
>> +- #size-cells      : must be 1.
>> +
>> +- #iommu-cells     : Must be 1.
>
> You need to document what the value in the cell means for this binding.
> AFAICS it looks to be the hardware context bank index, but I wonder if
> it might be simpler to use the child node index instead.

yeah, it is the ctx bank idx.. I suppose it could work either way.  I
guess the advantage of ctx bank index is that it wouldn't shift if
adding child nodes incrementally (which at least might be more likely
for someone wiring up things incrementally when bringing up a new SoC
without docs.. and we've had a few cases of that).

(Ie. I think there were some cases where there are gaps in the context
banks.. and not really sure if those where just context banks that
downstream kernel didn't bother using or what.)

>> +- ranges           : Base address and size of the iommu context banks.
>> +
>> +- qcom,iommu-secure-id  : secure-id.
>> +
>> +- List of sub-nodes, one per translation context bank.  Each sub-node
>> +  has the following required properties:
>> +
>> +  - compatible     : Should be one of:
>> +        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
>> +        - "qcom,msm-iommu-v1-sec" : secure context bank
>> +  - reg            : Base address and size of context bank within the iommu
>> +  - interrupts     : The context fault irq.
>> +
>> +** Optional properties:
>> +
>> +- reg              : Base address and size of the SMMU local base, should
>> +                     be only specified if the iommu requires configuration
>> +                     for routing of context bank irq's to secure vs non-
>> +                     secure lines.  (Ie. if the iommu contains secure
>> +                     context banks)
>> +
>> +
>> +** Examples:
>> +
>> +     apps_iommu: iommu@1e20000 {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             #iommu-cells = <1>;
>> +             compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
>> +             ranges = <0 0x1e20000 0x40000>;
>> +             reg = <0x1ef0000 0x3000>;
>> +             clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +                      <&gcc GCC_APSS_TCU_CLK>;
>> +             clock-names = "iface", "bus";
>> +             qcom,iommu-secure-id = <17>;
>> +
>> +             // mdp_0:
>> +             iommu-ctx@4000 {
>> +                     compatible = "qcom,msm-iommu-v1-ns";
>> +                     reg = <0x4000 0x1000>;
>> +                     interrupts = <GIC_SPI 70 0>;
>> +             };
>> +
>> +             // venus_ns:
>> +             iommu-ctx@5000 {
>> +                     compatible = "qcom,msm-iommu-v1-sec";
>> +                     reg = <0x5000 0x1000>;
>> +                     interrupts = <GIC_SPI 70 0>;
>> +             };
>> +     };
>> +
>> +     gpu_iommu: iommu@1f08000 {
>> +             #address-cells = <1>;
>> +             #size-cells = <1>;
>> +             #iommu-cells = <1>;
>> +             compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
>> +             ranges = <0 0x1f08000 0x10000>;
>> +             clocks = <&gcc GCC_SMMU_CFG_CLK>,
>> +                      <&gcc GCC_GFX_TCU_CLK>;
>> +             clock-names = "iface", "bus";
>> +             qcom,iommu-secure-id = <18>;
>> +
>> +             // gfx3d_user:
>> +             iommu-ctx@1f09000 {
>
> @1000?
>
>> +                     compatible = "qcom,msm-iommu-v1-ns";
>> +                     reg = <0x1000 0x1000>;
>> +                     interrupts = <GIC_SPI 241 0>;
>> +             };
>> +
>> +             // gfx3d_priv:
>> +             iommu-ctx@1f0a000 {
>
> @2000?

oh, yes, right.. I'll fix that

BR,
-R

>
> Robin.
>
>> +                     compatible = "qcom,msm-iommu-v1-ns";
>> +                     reg = <0x2000 0x1000>;
>> +                     interrupts = <GIC_SPI 242 0>;
>> +             };
>> +     };
>> +
>> +     ...
>> +
>> +     venus: video-codec@1d00000 {
>> +             ...
>> +             iommus = <&apps_iommu 5>;
>> +     };
>> +
>> +     mdp: mdp@1a01000 {
>> +             ...
>> +             iommus = <&apps_iommu 4>;
>> +     };
>> +
>> +     gpu@01c00000 {
>> +             ...
>> +             iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
>> +     };
>>
>
