Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F740C433EF
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 11:03:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32261415F6;
	Wed,  6 Apr 2022 11:03:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0T3qIwMDaDhb; Wed,  6 Apr 2022 11:03:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9195640882;
	Wed,  6 Apr 2022 11:03:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59DA6C002C;
	Wed,  6 Apr 2022 11:03:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5BE82C0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 11:03:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 32017610C0
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 11:03:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w6Ct7viLA8g9 for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 11:03:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5DDEC610BC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649242999; x=1680778999;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ZgeY5au0/JYbpMr1ByPbrAcDmwZzKH4hE93co6HLIk4=;
 b=Wjx+M5b7XH6ENZc7yg32fquctLHo7NY7fn570Ato6av34It3NIAWyrvT
 ARBdjwjbEv6j14NGe5RuBtmuouLMuLfSMn8+kqJYcG0By8RKSjchrqmGq
 Azszwj8YTNOsTonee84mHtLeDt2eS2ZaZM8L9OoSdhmFaY6SrGC4jWx2I
 4riw5ew4S99QW2iZtFlco7X4Z6N715Ru/kQqWJZykUXikQQR8c1+qgeX0
 x4ggShlSWKy3SS+PDgSx2PKIhvCp6PLZw2GMtmogWgYwCz+j8EQRdEIFs
 KW+gCg5JhHCfcrKnaf7///X60uKmyQl8VguY8m6J8U8Te7eRTT8R2Vmny g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324186734"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="324186734"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 04:03:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; d="scan'208";a="570465683"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.82])
 ([10.254.215.82])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2022 04:03:14 -0700
Message-ID: <a5542ef5-bacc-f527-0295-ffdedefcbdd9@linux.intel.com>
Date: Wed, 6 Apr 2022 19:03:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
 <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
 <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527646AB4F3FE8E9F97ECB8D8CE79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Christoph Hellwig <hch@infradead.org>,
 "Alex Williamson \(alex.williamson@redhat.com\)" <alex.williamson@redhat.com>,
 "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
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

On 2022/4/6 18:44, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Wednesday, April 6, 2022 6:02 PM
>>
>> Hi Kevin,
>>
>> On 2022/4/2 15:12, Tian, Kevin wrote:
>>>>>> Add a flag to the group that positively indicates the group can never
>>>>>> have more than one member, even after hot plug. eg because it is
>>>>>> impossible due to ACS, or lack of bridges, and so on.
>>>>> OK, I see your point. It essentially refers to a singleton group which
>>>>> is immutable to hotplug.
>>>> Yes, known at creation time, not retroactively enforced because
>>>> someone used SVA
>>>>
>>> We may check following conditions to set the immutable flag when
>>> a new group is created for a device in pci_device_group():
>>>
>>> 1) ACS is enabled in the upstream path of the device;
>>> 2) the device is single function or ACS is enabled on a multi-function device;
>>> 3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
>>> 4) no 'dma aliasing' on this device;
>>>
>>> The last one is a bit conservative as it also precludes a device which aliasing
>>> dma due to quirks from being treated as a singleton group. But doing so
>>> saves the effort on trying to separate different aliasing scenarios as defined
>>> in pci_for_each_dma_alias(). Probably we can go this way as the first step.
>>>
>>> Once the flag is set on a group no other event can change it. If a new
>>> identified device hits an existing singleton group in pci_device_group()
>>> then it's a bug.
>>
>> How about below implementation?
>>
>> /* callback for pci_for_each_dma_alias() */
>> static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
>> {
>> 	return -EEXIST;
>> }
>>
>> static bool pci_dev_is_immutably_isolated(struct pci_dev *pdev)
>> {
>> 	/* Skip bridges. */
>> 	if (pci_is_bridge(pdev))
>> 		return false;
>>
>> 	/* Either connect to root bridge or the ACS-enabled bridge. */
>> 	if (!pci_is_root_bus(pdev->bus) &&
>> 	    !pci_acs_enabled(pdev->bus->self, REQ_ACS_FLAGS))
>> 		return false;
> 
> it's not sufficient to just check the non-root bridge itself. This needs to
> cover the entire path from the bridge to the root port, as pci_device_group()
> does.

Yes! You are right.

> 
>>
>> 	/* ACS is required for MFD. */
>> 	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>> 		return false;
> 
> Above two checks be replaced by a simple check as below:
> 
> 	if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
> 		return false;

If !pdev->multifunction, do we still need to start from the device
itself? ACS is only for MFDs and bridges, do I understand it right?
Do we need to consider the SRIOV case?

> 
>>
>> 	/* Make sure no PCI alias. */
>> 	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
>> 		return false;
>>
>> 	return true;
>> }
>>
>> I didn't get why do we need to check the PCI_EXP_TYPE_ENDPOINT device
>> type. Can you please elaborate a bit more?
>>
> 
> I didn't know there is a pci_is_bridge() facility thus be conservative
> to restrict it to only endpoint device. If checking pci_is_bridge() alone
> excludes any hotplug possibility, then it's definitely better.

Okay! Thanks!

> Thanks
> Kevin

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
