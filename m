Return-Path: <SRS0=HAYh=TN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CF5C04AA7
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:36:12 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B149A20862
	for <iommu@archiver.kernel.org>; Mon, 13 May 2019 13:36:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B149A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 74D73DA1;
	Mon, 13 May 2019 13:36:12 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6055B265
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:36:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id B363427B
	for <iommu@lists.linux-foundation.org>;
	Mon, 13 May 2019 13:36:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C1F980D;
	Mon, 13 May 2019 06:36:10 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C91D3F71E;
	Mon, 13 May 2019 06:36:09 -0700 (PDT)
Subject: Re: [ARM SMMU] Dynamic StreamID allocation
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Pankaj Bansal <pankaj.bansal@nxp.com>, Will Deacon <will.deacon@arm.com>,
	Joerg Roedel <joro@8bytes.org>
References: <VI1PR0401MB24969CE24E4FB91EC8551DEBF10C0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
	<f0c3abd6-7b9f-8b68-14fa-3c6cf393ddc9@arm.com>
	<VI1PR0401MB249699B9BA183B18997532D0F10F0@VI1PR0401MB2496.eurprd04.prod.outlook.com>
	<662f966d-aad9-10a4-7326-374c0bb26020@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <702f90c6-8016-8478-9443-af34e4dd8336@arm.com>
Date: Mon, 13 May 2019 14:36:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <662f966d-aad9-10a4-7326-374c0bb26020@arm.com>
Content-Language: en-GB
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	Varun Sethi <V.Sethi@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 13/05/2019 13:42, Jean-Philippe Brucker wrote:
> On 13/05/2019 08:09, Pankaj Bansal wrote:
>> Hi Jean,
>>
>>> -----Original Message-----
>>> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> Sent: Friday, 10 May, 2019 07:07 PM
>>> To: Pankaj Bansal <pankaj.bansal@nxp.com>; Will Deacon
>>> <will.deacon@arm.com>; Robin Murphy <robin.murphy@arm.com>; Joerg
>>> Roedel <joro@8bytes.org>
>>> Cc: iommu@lists.linux-foundation.org; Varun Sethi <V.Sethi@nxp.com>; linux-
>>> arm-kernel@lists.infradead.org; Nipun Gupta <nipun.gupta@nxp.com>
>>> Subject: Re: [ARM SMMU] Dynamic StreamID allocation
>>>
>>> On 10/05/2019 13:33, Pankaj Bansal wrote:
>>>> Hi Will/Robin/Joerg,
>>>>
>>>> I am s/w engineer from NXP India Pvt. Ltd.
>>>> We are using SMMU-V3 in one of NXP SOC.
>>>> I have a question about the SMMU Stream ID allocation in linux.
>>>>
>>>> Right now the Stream IDs allocated to a device are mapped via device tree to
>>> the device.
>>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felix
>>>> ir.bootlin.com%2Flinux%2Flatest%2Fsource%2FDocumentation%2Fdevicetree%
>>>> 2Fbindings%2Fiommu%2Farm%2Csmmu-
>>> v3.txt%23L39&amp;data=02%7C01%7Cpankaj
>>>> .bansal%40nxp.com%7C3cbe8bd4827e425afd0f08d6d54c925e%7C686ea1d3b
>>> c2b4c6
>>>>
>>> fa92cd99c5c301635%7C0%7C0%7C636930922220665343&amp;sdata=vIG5u5n
>>> XR5iRp
>>>> uuuGjeFxKBtA5f5ohf91znXX0QWm1c%3D&amp;reserved=0
>>>>
>>>> As the device tree is passed from bootloader to linux, we detect all the stream
>>> IDs needed by a device in bootloader and add their IDs in respective device
>>> nodes.
>>>> For each PCIE Endpoint (a unique BDF (Bus Device Function)) on PCIE bus, we
>>> are assigning a unique Stream ID in bootloader.
>>>>
>>>> However, this poses an issue with PCIE hot plug.
>>>> If we plug in a pcie device while linux is running, a unique BDF is assigned to
>>> the device, for which there is no stream ID in device tree.
>>>>
>>>> How can this problem be solved in linux?
>>>
>>> Assuming the streamID associated to a BDF is predictable (streamID = BDF
>>> + constant), using the iommu-map property should just work:
>>>
>>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Felixir.boo
>>> tlin.com%2Flinux%2Flatest%2Fsource%2FDocumentation%2Fdevicetree%2Fbind
>>> ings%2Fpci%2Fpci-
>>> iommu.txt&amp;data=02%7C01%7Cpankaj.bansal%40nxp.com%7C3cbe8bd482
>>> 7e425afd0f08d6d54c925e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
>>> %7C636930922220665343&amp;sdata=GkkovEnvhd5dN%2BGdh%2FnKCyW5Cd
>>> EnLDP3cWTrk%2B%2FO7EQ%3D&amp;reserved=0
>>>
>>> It describes the streamIDs of all possible BDFs, including hotplugged functions.
>>
>> You mean that we should increase the "length" parameter (in (rid-base,iommu,iommu-base,length) touple) ?
>> This would cater to any *new* Bus Device Function being detected on PCIE bus?
>> Is that right ?
> 
> No, the iommu-map solution only works when you can predict at boot time
> which streamID will correspond to any BDF, for example if the PCIe
> controller or firmware automatically assigns streamID = BDF.
> 
>> Right now when we make iommu-map in bootloader, we are giving one RID per BDF:
>> https://elixir.bootlin.com/u-boot/latest/source/drivers/pci/pcie_layerscape_fixup.c#L168
> 
> Right, that won't work with hotplug. You can't derive a unique streamID
> from any BDF at boot, if the streamID range is limited to 16 values on
> this hardware.

Furthermore, does U-Boot enumerate all possible SR-IOV capabilities, or 
is this already broken regardless of hotplug?

> Maybe you could move this allocator to the Linux Layerscape driver, and
> call iommu_fwspec_add_ids() from there, rather than using iommu-map? Not
> sure how feasible that is, but it might still be the simplest.

Assuming there's still the same silly 7-bit limitation as LS2085, you 
could in theory carve out that entire space of ICIDs to allow a static 
mapping like this:

	iommu-map-mask = <0x0f07>;
	iommu-map = <0x000 &smmu 0x00 0x8>,
		    <0x100 &smmu 0x08 0x8>,
		    <0x200 &smmu 0x10 0x8>,
		    <0x300 &smmu 0x18 0x8>,
		    <0x400 &smmu 0x20 0x8>,
		    <0x500 &smmu 0x28 0x8>,
		    <0x600 &smmu 0x30 0x8>,
		    <0x700 &smmu 0x38 0x8>,
		    <0x800 &smmu 0x40 0x8>,
		    <0x900 &smmu 0x48 0x8>,
		    <0xa00 &smmu 0x50 0x8>,
		    <0xb00 &smmu 0x58 0x8>,
		    <0xc00 &smmu 0x60 0x8>,
		    <0xd00 &smmu 0x68 0x8>,
		    <0xe00 &smmu 0x70 0x8>,
		    <0xf00 &smmu 0x78 0x8>;

That gives you 16 buses before IDs start aliasing awkwardly (any devices 
sharing a bus will alias per-function, but that's probably acceptable 
since they'd likely get grouped together anyway).

Either way the IOMMU layer itself is actually relatively easy-going 
these days. Even with the existing approach, if you could just update 
Linux's internal idea of the firmware data before the bus_add_device() 
call happens for the hotplugged device, then things should just work. 
You're also going to face the exact same problem for ITS Device IDs, 
though, and things may be less forgiving there.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
