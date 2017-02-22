From: "Sricharan" <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: RE: [PATCH 2/2] iommu: add qcom_iommu
Date: Wed, 22 Feb 2017 18:56:46 +0530
Message-ID: <008201d28d0f$53d59da0$fb80d8e0$@codeaurora.org>
References: <20170215215743.5673-1-robdclark@gmail.com>
	<20170215215743.5673-2-robdclark@gmail.com>
	<008001d28cee$6527d4e0$2f777ea0$@codeaurora.org>
	<CAF6AEGv5Qmmaj6eS2og1k6694Axr0oO5HUsktVj-jZOH9SHEGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAF6AEGv5Qmmaj6eS2og1k6694Axr0oO5HUsktVj-jZOH9SHEGA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-us
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Rob Clark' <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: 'Mark Rutland' <mark.rutland-5wv7dgnIgG8@public.gmane.org>, 'linux-arm-msm' <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Will Deacon' <will.deacon-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Rob,

<..>

>>>+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
>>>@@ -0,0 +1,45 @@
>>>+* QCOM IOMMU Implementation
>>>+
>>>+Qualcomm "B" family devices which are not compatible with arm-smmu have
>>>+a similar looking IOMMU but without access to the global register space.
>>>+This is modelled as separate IOMMU devices which have just a single
>>>+master.
>>>+
>>>+** Required properties:
>>>+
>>>+- compatible    : Should be one of:
>>>+
>>>+                        "qcom,msm8916-iommu-context-bank"
>>>+
>>>+                  depending on the particular implementation and/or the
>>>+                  version of the architecture implemented.
>>>+
>>>+- reg           : Base address and size of the SMMU.  And optionally,
>>>+                  if present, the "smmu_local_base"
>>>+
>>>+- interrupts    : The context fault irq.
>>>+
>>>+- #iommu-cells  : Must be 0
>>>+
>>>+- qcom,iommu-ctx-asid   : context ASID
>>>+
>>>+- qcom,iommu-secure-id  : secure-id
>>>+
>>>+- clocks        : The interface clock (iface_clk) and bus clock (bus_clk)
>>>+
>>>+** Examples:
>>>+
>>>+      mdp_iommu: iommu-context-bank@1e24000 {
>>>+              compatible = "qcom,msm8916-iommu-context-bank";
>>>+              reg = <0x1e24000 0x1000
>>>+                      0x1ef0000 0x3000>;
>>>+              reg-names = "iommu_base", "smmu_local_base";
>>>+              interrupts = <GIC_SPI 70 0>;
>>>+              qcom,iommu-ctx-asid = <4>;
>>>+              qcom,iommu-secure-id = <17>;
>>
>> This is not an per context bank property and can be programmed for an
>> given iommu only once. So we call qcom_iommu_sec_init for
>> each context bank once, which does not look correct. Similarly for
>> smmu_local_base as well. So should this be handled using an global
>> once for all contexts ?
>
>yeah, smmu_local_base and secure-id would be duplicate for all context
>banks that are part of the same actual iommu.  (But it was Robin's
>suggestion to just model this as separate context-bank devices, since
>we cannot touch the global space).
>
>Did I misunderstand the downstream driver code?  It looked like
>qcom_scm_restore_sec_cfg() was called once on first attach per
>context-bank, not globally for the entire iommu, which is what I'm
>doing with this driver.  But I haven't yet tried to enable other
>context-banks in the apps iommu yet.
>

The downstream driver seems to be calling the sec_cfg once
for an iommu when a context is attached for the first time and not for
the subsequent's contexts that are attached. So, means programmed
only once and not for every context. I see it that way. Anyways when you
add more than context-banks, we can see if that causes trouble..

Regards,
 Sricharan
