Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8114FC433FE
	for <iommu@archiver.kernel.org>; Wed, 16 Mar 2022 19:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1818A40128;
	Wed, 16 Mar 2022 19:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S4dQUtwVlIEs; Wed, 16 Mar 2022 19:18:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82A29400AF;
	Wed, 16 Mar 2022 19:18:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42D3DC0012;
	Wed, 16 Mar 2022 19:18:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14251C000B
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DE70B400BA
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:18:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9DyIKvQLsZfq for <iommu@lists.linux-foundation.org>;
 Wed, 16 Mar 2022 19:18:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8F7D0400AF
 for <iommu@lists.linux-foundation.org>; Wed, 16 Mar 2022 19:18:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BB11476;
 Wed, 16 Mar 2022 12:18:03 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CE03F7F5;
 Wed, 16 Mar 2022 12:18:02 -0700 (PDT)
Message-ID: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Date: Wed, 16 Mar 2022 19:17:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On 2022-03-16 18:34, Limonciello, Mario wrote:
> [Public]
> 
>>> Can the USB4 CM make the device links in the DVSEC case perhaps too?  I
>> would
>>> think we want that anyway to control device suspend ordering.
>>>
>>> If I had something discrete to try I'd dust off the DVSEC patch I wrote
>> before to
>>> try it, but alas all I have is integrated stuff on my hand.
>>>
>>>>>> Mika, you might not have seen it yet, but I sent a follow up diff in this
>>>> thread
>>>>>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy
>> to
>>>> do
>>>>>> so as well as I confirmed it helps my original intent too).
>>>>>
>>>>> I saw it now and I'm thinking are we making this unnecessary complex? I
>>>>> mean Microsoft solely depends on the DMAR platform opt-in flag:
>>>>>
>>>>>
>>>>
>>>
>>> I think Microsoft doesn't allow you to turn off the IOMMU though or put it
>> in
>>> passthrough through on the kernel command line.
>>>
>>>>> We also do turn on full IOMMU mappings in that case for devices that
>> are
>>>>> marked as external facing by the same firmware that provided the
>> DMAR
>>>>> bit. If the user decides to disable IOMMU from command line for
>> instance
>>>>> then we expect she knows what she is doing.
>>>>
>>>> Yeah, if external_facing is set correctly then we can safely expect the
>>>> the IOMMU layer to do the right thing, so in that case it probably is OK
>>>> to infer that if an IOMMU is present for the NHI then it'll be managing
>>>> that whole bus hierarchy. What I'm really thinking about here is whether
>>>> we can defend against a case when external_facing *isn't* set, so we
>>>> treat the tunnelled ports as normal PCI buses, assume it's OK since
>>>> we've got an IOMMU and everything else is getting translation domains
>> by
>>>> default, but then a Thunderbolt device shows up masquerading the
>> VID:DID
>>>> of something that gets a passthrough quirk, and thus tricks its way
>>>> through the perceived protection.
>>>>
>>>> Robin.
>>>
>>> Unless it happened after 5.17-rc8 looking at the code I think that's Intel
>>> specific behavior though at the moment (has_external_pci).  I don't see it
>>> in a generic layer.
>>
>> Ah, it's not necessarily the most obvious thing -
>> pci_dev->external_facing gets propagated through to pci_dev->untrusted
>> by set_pcie_untrusted(), and it's that that's then checked by
>> iommu_get_def_domain_type() to enforce a translation domain regardless
>> of default passthrough or quirks. It's then further checked by
>> iommu-dma's dev_is_untrusted() to enforce bounce-buffering to avoid data
>> leakage in sub-page mappings too.
>>
> 
> Ah thanks for explaining it, that was immediately obvious to me.
> 
>>> In addition to the point Robin said about firmware not setting external
>> facing
>>> if the IOMMU was disabled on command line then iommu_dma_protection
>>> would be showing the wrong values meaning userspace may choose to
>>> authorize the device automatically in a potentially unsafe scenario.
>>>
>>> Even if the user "knew what they were doing", I would expect that we still
>>> do our best to protect them from themselves and not advertise something
>>> that will cause automatic authorization.
>>
>> Might it be reasonable for the Thunderbolt core to check early on if any
>> tunnelled ports are not marked as external facing, and if so just tell
>> the user that iommu_dma_protection is off the table and anything they
>> authorise is at their own risk?
>>
>> Robin.
> 
> How about in iommu_dma_protection_show to just check that all the device
> links to the NHI are marked as untrusted?
> 
> Then if there are device links missing we solve that separately (discrete USB4
> DVSEC case we just need to make those device links).

The feeling I'm getting from all this is that if we've got as far as 
iommu_dma_protection_show() then it's really too late to meaningfully 
mitigate bad firmware. We should be able to detect missing 
untrusted/external-facing properties as early as nhi_probe(), and if we 
could go into "continue at your own risk" mode right then *before* 
anything else happens, it all becomes a lot easier to reason about. If 
there's a strong enough impetus from Microsoft for system vendors to get 
their firmware right, hopefully we can get away with not trying too hard 
to cope with systems that haven't.

I'm inclined to send v2 of this patch effectively going back to my 
original (even simpler) cleanup, just now with much more reasoning about 
why it isn't doing more :)

Cheers,
Robin.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
