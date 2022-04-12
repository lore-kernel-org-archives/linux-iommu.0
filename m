Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078EEC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:02:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 736FB416B6;
	Tue, 12 Apr 2022 13:02:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gcw-3VImihvP; Tue, 12 Apr 2022 13:02:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EAB9C41697;
	Tue, 12 Apr 2022 13:02:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8BB29C0033;
	Tue, 12 Apr 2022 13:02:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36B95C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:02:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F47860E42
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:02:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9TUFuTrLUh7O for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:02:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4C11560B09
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649768562; x=1681304562;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=gvqJWcb4v9bvjUM4ccwyUHqiZCCuCXPOz9JdAQU7q4Q=;
 b=QuBO/SLsq9U+fY5fkPww/loUz7+wFww9C94W0atpzp/k+Jy6bTt//T1N
 BOrudYL9aZvUCYwsmMfCwkQmjzmFdInnq9PSwxoQ7+RjxNbQpBSMFfkWL
 87jLnj8iDS4jdLlMLWDsWGwFoy+wo3iIMFyNa/lb3D271q2uc/ASSThtH
 wbvwpTjVoe3y2MXoH9UG2fFyQld2CzplLD4cNNFNzoTgkSMHljOzJtaCf
 Dztm+RPo/3WTZPrN4xVnH8aHhE8dLzB1R1ZUiQiKHWGAy1aVqOAXxgx7e
 wufH7FLSuJqIf7NdyvOz9ibJAvv61Q2ZNtA1FYfQh4qwdADilR83fqvAQ w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262548770"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="262548770"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:02:41 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572756171"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:02:37 -0700
Message-ID: <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
Date: Tue, 12 Apr 2022 21:02:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
 <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276246A53447854DDA8920D8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>
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

On 2022/4/12 15:37, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 1:09 PM
>> On 2022/4/12 11:15, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Sunday, April 10, 2022 6:25 PM
>>>
>>>>
>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>> singleton group, and uses standard PCI bus topology, isolation features,
>>>> and DMA alias quirks to set the flag. If the device came from DT, assume
>>>> it is static and then the singleton attribute can know from the device
>>>> count in the group.
>>>
>>> where does the assumption come from?
>>
>> Hotplug is the only factor that can dynamically affect the
>> characteristics of IOMMU group singleton as far as I can see. If a
>> device node was created from the DT, it could be treated as static,
>> hence we can judge the singleton in iommu probe phase during boot.
> 
> I didn't get this. Let's look at your code in iommu_group_add_device():
> 
>   +	else if (is_of_node(dev_fwnode(dev)))
>   +		group->immutable_singleton =
>   +				(iommu_group_device_count(group) == 1);
> 
> Even if there is a multi-devices group above logic will set the flag when
> the first device in the group is added since at that time there is only
> one device in the group. We need other concrete information  to tell
> it similar to how you walk PCI hierarchy to find out the fact...

This is a small trick to make things simpler. Once more devices are
added to the group, the flag will be flipped. All iommu_group's should
be settled down before any drivers start to consume this flag.

> 
>>>> +	/*
>>>> +	 * The device could be considered to be fully isolated if
>>>> +	 * all devices on the path from the parent to the host-PCI
>>>> +	 * bridge are protected from peer-to-peer DMA by ACS.
>>>> +	 */
>>>> +	if (!pci_is_root_bus(pdev->bus) &&
>>>> +	    !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
>>>> +		return false;
>>>> +
>>>> +	/* Multi-function devices should have ACS enabled. */
>>>> +	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>>>> +		return false;
>>>
>>> Looks my earlier comment was lost, i.e. you can just use
>>> pci_acs_path_enabled(pdev) to cover above two checks.
>>
>> If a device is directly connected to the root bridge and it is not an
>> MFD, do we still need ACS on it? The Intel idxd device seems to be such
>> a device. I had a quick check with lspci, it has no ACS support.
>>
>> I probably missed anything.
>>
> 
> single-function RCiEP doesn't need to implement ACS but this has
> been covered by pci_acs_enabled() and pci_acs_path_enabled().

Cool! I missed this part. :-) Thanks a lot.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
