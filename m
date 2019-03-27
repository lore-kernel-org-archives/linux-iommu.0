From: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>
Subject: Re: WIP: PCIe on MSM8998
Date: Wed, 27 Mar 2019 18:05:43 +0100
Message-ID: <851f14df-57de-209b-1a8c-c71eabec9d2c@free.fr>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
	<fb5f2b94-34b7-d021-7ac9-832b08138ad4@free.fr>
	<6041e92f-4dbf-c6ce-d92a-220fc8239acb@free.fr>
	<e0a650ce-e7d4-a803-5e08-f998722bf15d@arm.com>
	<b027ad18-f7f4-cf05-b8de-ea951e0dc457@free.fr>
	<2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2e7d4564-01ea-d0bc-51c8-2bc2c116c4cc-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 21/03/2019 00:07, Robin Murphy wrote:

> Unfortunately, having looked around the code, I think I do. 4.4 long 
> predates the iommu-map binding, and in the absence of anything other 
> than the hard-coded SID==RID assumption of arm-smmu at the time, they 
> apparently went and did their own wacky thing[1]. AFAICS the Stream ID 
> appears to be pretty much derived from the PCI topology as I would hope, 
> but it looks like it might depend on some sort of lookup table being 
> programmed appropriately as well.
> 
> Bear in mind that the this is _The Qualcomm Android Kernel_ we're trying 
> to reason about here - playing true to the stereotype, the diff against 
> the mainline driver is significantly bigger than the entire mainline 
> driver itself; the line count of arm-smmu.c alone is pushing 
> 2-and-a-half times that of the file in 4.4.y ;)
> 
> Since the curiosity had set in, I finally got round to dumping the ACPI 
> tables from my Snapdragon 835 laptop, and judging by the IORT it seems 
> like the EFI firmware for Windows machines does provide some set of 
> static ID mappings which could probably transcribe to an iommu-map (if 
> indeed it's valid at all - Windows itself doesn't seem to be even 
> touching PCI here), but I guess the Android BSP might not be so 
> generous. That'll be a question for the Qualcomm folks. FWIW mine 
> interestingly claims that its SMMU instances are all sharing SPI 231 as 
> a global fault interrupt, but whether that's true and/or depends on the 
> runtime firmware, again I really have no idea.
> 
> Robin.
> 
> [1] 
> https://source.codeaurora.org/quic/la/kernel/msm-4.4/tree/drivers/pci/host/pci-msm.c?h=LE.UM.1.3.r3.25&id=f1fa301f977f06dcf990c0452d85e2f67d8cbbf1#n4687

It works at last!

In the root complex DT node, I have:

	iommu-map = <0 &anoc1_smmu 0x1480 0x10000>;
	iommu-map-mask = <0>;

AFAIU, this means: "map every Requester ID onto stream ID 0x1480"

AFAIU, there is only a single end-point on the system: RID 0x100

As you pointed out Robin, we also need to set up some kind of lookup table:

	writel(0x100, pcie->parf + PCIE_0_PCIE20_PARF_BDF_TRANSLATE_n);

AFAIU, this means: "RID 0x100 <-> stream ID 0x1480" (???)


Is this good enough for mainline?

Regards.
