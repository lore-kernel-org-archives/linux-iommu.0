From: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v1 1/3] PCI: qcom: Setup PCIE20_PARF_BDF_TRANSLATE_N
Date: Tue, 2 Apr 2019 12:44:00 +0200
Message-ID: <46bfbfd7-a650-f78f-fd2f-32f84e434382@free.fr>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<958ae127-3aa2-6824-c875-e3012644ed3d@free.fr>
	<58b4db00-a0fa-5058-99ee-c11c8e2fa529@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <58b4db00-a0fa-5058-99ee-c11c8e2fa529-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Stanimir Varbanov <svarbanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/04/2019 10:08, Stanimir Varbanov wrote:

> On 3/28/19 7:01 PM, Marc Gonzalez wrote:
> 
>> Initialize PCIE20_PARF_BDF_TRANSLATE_N for ops_2_3_2.
>>
>> Signed-off-by: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>
>> ---
>>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
>> index 0ed235d560e3..5e5522a427b8 100644
>> --- a/drivers/pci/controller/dwc/pcie-qcom.c
>> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
>> @@ -54,6 +54,7 @@
>>  #define PCIE20_PARF_LTSSM			0x1B0
>>  #define PCIE20_PARF_SID_OFFSET			0x234
>>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>> +#define PCIE20_PARF_BDF_TRANSLATE_N		0x250
>>  
>>  #define PCIE20_ELBI_SYS_CTRL			0x04
>>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
>> @@ -602,6 +603,9 @@ static int qcom_pcie_init_2_3_2(struct qcom_pcie *pcie)
>>  	val |= BIT(31);
>>  	writel(val, pcie->parf + PCIE20_PARF_AXI_MSTR_WR_ADDR_HALT_V2);
>>  
>> +	val = PCI_DEVID(1, 0);
>> +	writel(val, pcie->parf + PCIE20_PARF_BDF_TRANSLATE_N);
> 
> I wonder, shouldn't this register manipulation happen in common code
> e.g. pcie-designware-host.c

I don't think so. PARF (PCIe Auxiliary Register File) appears to be
a vendor-specific area. Perhaps someone with access to the Designware
documentation could check. (Though it is possible that several vendors
have implemented exactly the same PARF layout.)

> and of course the manipulation should be conditional because
> not all platforms might have iommu.

My patch tweaks PCIE20_PARF_BDF_TRANSLATE_N in qcom_pcie_init_2_3_2()
which means 8996 and 8998 only (and possibly sdm660)

$ git grep smmu-exist vendor -- arch/arm/boot/dts/qcom
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8996.dtsi:             qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8998-interposer-sdm660.dtsi:           qcom,smmu-exist;
vendor:arch/arm/boot/dts/qcom/msm8998.dtsi:             qcom,smmu-exist;

https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/pci/host/pci-msm.c?h=LE.UM.1.3.r3.25#n3880


> Also, could we have more generic iommu-map description like the one for
> sdm845 at [1] ?

I assume you meant https://patchwork.kernel.org/patch/10831293/

I don't think that such a map is quite right for msm8998 -- and even
for sdm845 :-p

There is only a single PCIe master, other than the root complex:

# lspci
00:00.0 PCI bridge: Qualcomm Device 0105
01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)

Hence iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
i.e. map stream-id 0x1480 to device-id 01:00.0

We could pick a different stream-id for 0x100 but I don't see any
advantage (??) in doing so...

If a SoC designer took the msm8998 and added a PCIe bridge to support
multiple PCIe EPs, then they would override the iommu-map in their
board-specific DTS.


I do have a nagging feeling that this patch is not perfect for 3 reasons:

1) Did msm8996 PCIe work without tweaking PCIE20_PARF_BDF_TRANSLATE_N?
If so, why? What is the difference with msm8998 PCIe?
"MSM8998 does not have static SID configuration for PCIe."
What about MSM8996?

2) OF: /soc/pci@1c00000: no iommu-map translation for rid 0x0 on           (null)
The kernel warns that the root complex has no asssigned stream-id.
I'm not sure that's actually an issue...

3) I just blindly write PCI_DEVID(1, 0) to PCIE20_PARF_BDF_TRANSLATE_N

To be really generic, I would have to walk the iommu-map and do

for_each_iommu_map_entry
	offset = PCIE20_PARF_BDF_TRANSLATE_N + (out_base - 0x1480) * 4;
	writel(rid_base, pcie->parf + offset);

Perhaps do this in of_pci_iommu_init() ?
Maybe have to tweak of_map_rid() or duplicate some code...

On first approximation, maybe I can just do the blind write, but only
for 8998. That way, I don't change anything for the other platforms.

Comments?

Regards.
