From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/9] Docs: dt: document qcom iommu bindings
Date: Thu, 23 Mar 2017 22:45:05 -0400
Message-ID: <CAF6AEGsoWPhZ6x-uexGKKUJwtSsn2h+MSg1tjtBdtoPGmARAEg@mail.gmail.com>
References: <20170314151811.17234-1-robdclark@gmail.com>
	<20170314151811.17234-4-robdclark@gmail.com>
	<20170323222137.okq227mgsmsjy5zf@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170323222137.okq227mgsmsjy5zf@rob-hp-laptop>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-msm <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Mar 23, 2017 at 6:21 PM, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Mar 14, 2017 at 11:18:05AM -0400, Rob Clark wrote:
>> Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/iommu/qcom,iommu.txt       | 113 +++++++++++++++++++++
>>  1 file changed, 113 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> new file mode 100644
>> index 0000000..fd5b7fa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>> @@ -0,0 +1,113 @@
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
>> +- clock-names      : Should be a pair of "iface" (required for IOMMUs
>> +                     register group access) and "bus" (required for
>> +                     the IOMMUs underlying bus access).
>> +- clocks           : Phandles for respective clocks described by
>> +                     clock-names.
>> +- #address-cells   : must be 1.
>> +- #size-cells      : must be 1.
>> +- #iommu-cells     : Must be 1.
>> +- ranges           : Base address and size of the iommu context banks.
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
>
> You didn't document the fallback above. Maybe just drop it if only a few
> chips have this iommu.

not completely sure I understand what you want..

I think more than a few chips.. I suspect it is more like everything
after the last "a" family devices (snapdragon 600?) and before 820..
(well, more or less at least a few years worth of devices, stuff that
seems likely to be able to run an upstream kernel would be 800, 805,
808, 810.. and I guess there are some cut down 6xx and 4xx variants of
those)

I guess qcom_iommu wouldn't care about all the various 32b devices
(since they aren't going to use 64b page tables).. 808/810, I'm not
100% sure about..

>> +             ranges = <0 0x1e20000 0x40000>;
>> +             reg = <0x1ef0000 0x3000>;
>
> When you have both reg and ranges, use reg value for the unit-address.

whoops, I thought I fixed that

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
> iommu-ctx@1000

will fix, thx

BR,
-R

>> +                     compatible = "qcom,msm-iommu-v1-ns";
>> +                     reg = <0x1000 0x1000>;
>> +                     interrupts = <GIC_SPI 241 0>;
>> +             };
>> +
>> +             // gfx3d_priv:
>> +             iommu-ctx@1f0a000 {
>
> iommu-ctx@2000
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
>> --
>> 2.9.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
