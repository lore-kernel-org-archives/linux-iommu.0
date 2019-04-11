From: Stanimir Varbanov via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: msm8998: Add PCIe PHY and RC
	nodes
Date: Thu, 11 Apr 2019 12:09:37 +0300
Message-ID: <8ada0472-0692-2f03-b52f-c1702bb0c33d@mm-sol.com>
References: <5eedbe6d-f440-1a77-8a7e-81a920e3a0e7@free.fr>
	<186f7ca2-84e2-a37e-79e6-f1fec8e25374@free.fr>
	<3f32cfb9-6528-9f5e-85db-cee89fdcfc5d@mm-sol.com>
	<8ee2ca1b-2a0d-0c98-f770-a47b5b529295@free.fr>
Reply-To: Stanimir Varbanov <svarbanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <8ee2ca1b-2a0d-0c98-f770-a47b5b529295-GANU6spQydw@public.gmane.org>
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
To: Marc Gonzalez <marc.w.gonzalez-GANU6spQydw@public.gmane.org>, Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jeffrey Hugo <jhugo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, MSM <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Manu Gautam <mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Marc,

On 4/11/19 11:44 AM, Marc Gonzalez wrote:
> On 10/04/2019 17:32, Stanimir Varbanov wrote:
> 
>> Few comments inline.
> 
> I'll send v3.
> 
> Changes:
> 	- Move all X-names props *after* corresponding X(s) prop
> 	- Drop comments
> 
> 
>>> +			iommu-map = <0x100 &anoc1_smmu 0x1480 1>;
>>
>> iommu-map-mask? It is optional but I had to ask :)
> 
> The only RID in the system is 0x100.
> 
> # lspci
> 00:00.0 PCI bridge: Qualcomm Device 0105
> 01:00.0 Ethernet controller: Qualcomm Atheros AR8151 v2.0 Gigabit Ethernet (rev c0)
> 
> Since we just want to map 0x100, we don't need an iommu-map-mask.

Do you see warnings during boot about missing property?

> 
> 
>>> +			/* PCIe Fundamental Reset */
>>
>> this comment is useless :) please drop it
> 
> IMO, "perst" is a poor name. Can you guess what it stands for?

The name is got from PCIE base specification. See 6.6.1.
Conventional Reset from "PCI EXPRESS BASE SPECIFICATION, REV. 3.0"

-- 
regards,
Stan
