From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v1 2/3] arm64: dts: qcom: msm8998: Add PCIe SMMU node
Date: Fri, 29 Mar 2019 18:29:21 +0000
Message-ID: <5aa56120-b686-194b-36d6-8177b5749a19@arm.com>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<82ab78ee-4a38-4eee-f064-272b6f964f17@free.fr>
	<e7c8137a-2408-a71a-f722-199a86a75d13@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <e7c8137a-2408-a71a-f722-199a86a75d13-GANU6spQydw@public.gmane.org>
Content-Language: en-GB
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 29/03/2019 10:51, Marc Gonzalez wrote:
> On 28/03/2019 18:05, Marc Gonzalez wrote:
> 
>> ANOC1 SMMU filters PCIe accesses.
> 
> I'm not sure this description is entirely accurate...
> 
> ANOC likely stands for "Application Network-On-Chip"
> 
> 
>>   arch/arm64/boot/dts/qcom/msm8998.dtsi | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> index f9a922fdae75..5a1c0961b281 100644
>> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
>> @@ -606,6 +606,21 @@
>>   			#thermal-sensor-cells = <1>;
>>   		};
>>   
>> +		anoc1_smmu: arm,smmu@1680000 {
>> +			compatible = "qcom,msm8996-smmu-v2", "qcom,smmu-v2";
> 
> Maybe I should instead use "qcom,msm8998-smmu-v2", "qcom,smmu-v2";
> and define "qcom,msm8998-smmu-v2" in
> Documentation/devicetree/bindings/iommu/arm,smmu.txt ?

Yes please.

> (Would the Documentation change need to be in a separate patch?)

That's generally preferred, yes.

> 
>> +			reg = <0x01680000 0x10000>;
>> +			#iommu-cells = <1>;
> 
> I'm not sure about this property. IIRC, Robin said <0> is not valid,
> but I don't have any iommus prop, only iommu-map.

You have to join the dots between the various bindings a little, but the 
iommu-base part of each iommu-map entry is an IOMMU specifier, and IOMMU 
specifiers are #iommu-cells long.

To cut a long story short, 1 is definitely appropriate, because 
arm-smmu's definition of a 2-cell specifier wouldn't make much sense in 
the iommu-map context (and the current code for parsing iommu-map 
actually just assumes 1 anyway).

>> +
>> +			#global-interrupts = <0>;
>> +			interrupts =
>> +				<GIC_SPI 364 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 365 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 366 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 367 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 368 IRQ_TYPE_EDGE_RISING>,
>> +				<GIC_SPI 369 IRQ_TYPE_EDGE_RISING>;
>> +		};
>> +
> 
> The rest of the node looks fairly straight-forward.

You should probably have some "bus" and "iface" clocks too, per the 
requirement of "qcom,smmu-v2". Maybe Vivek might know what's relevant 
for MSM8998?

> 
> DT code was adapted from:
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-8998.dtsi?h=LE.UM.1.3.r3.25#n18
> 
> I left out the so-called implementation-defined init:
> 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/arch/arm/boot/dts/qcom/msm-arm-smmu-impl-defs-8998.dtsi?h=LE.UM.1.3.r3.25#n123
> 
> Should I try to merge this part in mainline?
> (I don't have any documentation for it though.)

"pls no :("

I'm not sure what route the path takes from "DT describes the platform" 
to get to "DT lists opaque register addresses and magic data to write 
into them", but I imagine it might involve getting hit in the head along 
the way.

Robin.
