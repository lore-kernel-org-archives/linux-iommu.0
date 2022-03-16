Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBC5C433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 17:49:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0209A611D4;
	Wed, 16 Mar 2022 17:49:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wx5jD-4iys-v; Wed, 16 Mar 2022 17:49:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7B6AA60F8C;
	Wed, 16 Mar 2022 17:49:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 416A0C0012;
	Wed, 16 Mar 2022 17:49:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A434FC000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:49:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B5224171E
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:49:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uADjqWZLbN6Y for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 17:49:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id 511324171A
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 17:49:28 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687391476;
 Wed, 16 Mar 2022 10:49:27 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1AE3F66F;
 Wed, 16 Mar 2022 10:49:25 -0700 (PDT)
Message-ID: <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
Date: Wed, 16 Mar 2022 17:49:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Limonciello, Mario" <Mario.Limonciello@amd.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjIgQfmcw6fydkXd@lahna>
Cc: "michael.jamet@intel.com" <michael.jamet@intel.com>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>, "hch@lst.de" <hch@lst.de>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2022-03-16 17:37, Mika Westerberg wrote:
> Hi Mario,
> 
> On Wed, Mar 16, 2022 at 05:24:38PM +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>> On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
>>>>> What we want is to make sure the Tunneled PCIe ports get the full
>>> IOMMU
>>>>> protection. In case of the discrete above it is also fine if all the
>>>>> devices behind the PCIe root port get the full IOMMU protection. Note in
>>>>> the integrated all the devices are "siblings".
>>>>
>>>> Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
>>>> place :(
>>>>
>>>> Is there an easy way to get from the struct tb to a PCI device representing
>>>> the end of its relevant tunnel, or do we have a circular dependency
>>> problem
>>>> where the latter won't appear until we've authorised it (and thus the
>>> IOMMU
>>>> layer won't know about it yet either)?
>>>
>>> The PCIe root ports (and the PCIe downstream ports) are there already
>>> even without "authorization".
>>>
>>> There is a way to figure out the "tunneled" PCIe ports by looking at
>>> certain properties and we do that already actually. The BIOS has the
>>> following under these ports:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
>>> .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
>>> for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
>>> ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
>>> 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
>>> C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
>>> p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
>>> &amp;reserved=0
>>>
>>> and the ports will have dev->external_facing set to 1. Perhaps looking
>>> at that field helps here?
>>
>> External facing isn't a guarantee from the firmware though.  It's something we
>> all expect in practice, but I think it's better to look at the ones that are from
>> the _DSD usb4-host-interface to be safer.
> 
> Right but then we have the discrete ones with the DVSEC that exposes the
> tunneled ports :(
> 
>> Mika, you might not have seen it yet, but I sent a follow up diff in this thread
>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy to do
>> so as well as I confirmed it helps my original intent too).
> 
> I saw it now and I'm thinking are we making this unnecessary complex? I
> mean Microsoft solely depends on the DMAR platform opt-in flag:
> 
>    https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> We also do turn on full IOMMU mappings in that case for devices that are
> marked as external facing by the same firmware that provided the DMAR
> bit. If the user decides to disable IOMMU from command line for instance
> then we expect she knows what she is doing.

Yeah, if external_facing is set correctly then we can safely expect the 
the IOMMU layer to do the right thing, so in that case it probably is OK 
to infer that if an IOMMU is present for the NHI then it'll be managing 
that whole bus hierarchy. What I'm really thinking about here is whether 
we can defend against a case when external_facing *isn't* set, so we 
treat the tunnelled ports as normal PCI buses, assume it's OK since 
we've got an IOMMU and everything else is getting translation domains by 
default, but then a Thunderbolt device shows up masquerading the VID:DID 
of something that gets a passthrough quirk, and thus tricks its way 
through the perceived protection.

Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
