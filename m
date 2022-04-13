Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1004EC433EF
	for <iommu@archiver.kernel.org>; Wed, 13 Apr 2022 12:02:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A645E40B68;
	Wed, 13 Apr 2022 12:02:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-6B93TkrHqS; Wed, 13 Apr 2022 12:02:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7283C40B55;
	Wed, 13 Apr 2022 12:02:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 48C5FC0033;
	Wed, 13 Apr 2022 12:02:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F110C002C
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 12:02:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D84F40B55
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 12:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id v6TDzxUMHgKn for <iommu@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 12:02:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B6E3F40B60
 for <iommu@lists.linux-foundation.org>; Wed, 13 Apr 2022 12:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649851345; x=1681387345;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=NUwMxQFGv5lhkdI71A37VU5mbkidXa87h31pzAqnuuI=;
 b=nFciB/tvGsxj8uSs3NRDuykH3Gs7ccEdJe9sBH1IVvL123bWKPiGuuu4
 1vFfP1c1CGMHWERSqUlonx3Ftm90cTaPI5SYhNEyWujKT1yaVHQbqTkHs
 2hHONECpJGnSzmM8Cuc0/Syj67gM5Tb/57mzi6aT380g3FWYOYfOBmOmw
 nEl3M7Cf9pCe544hjQFE4bY/Mn9725vW+5TkXLvK+zVzobwqlNMM8SE+F
 rJHq8xEWOJg/oYndFOQFbcXLC6Y0jigiisDb+/8N9B4S9KbA/OYnYFF3R
 DaitoUYnSrXHiinv3TYuIwufkrAbNOrJ3Gs33F8gdv5pehIgEaDOdpOlZ Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="260243913"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="260243913"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 05:02:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; d="scan'208";a="573238690"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.67])
 ([10.254.215.67])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Apr 2022 05:02:20 -0700
Message-ID: <4e29ee5c-9045-e6ba-880b-fda4020c47c9@linux.intel.com>
Date: Wed, 13 Apr 2022 20:02:18 +0800
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
 <6e9bac88-e544-aebe-81ec-d1171239fec3@linux.intel.com>
 <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52762F5C339737F6E75755CB8CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/13 7:32, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, April 12, 2022 9:03 PM
>>
>> On 2022/4/12 15:37, Tian, Kevin wrote:
>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, April 12, 2022 1:09 PM
>>>> On 2022/4/12 11:15, Tian, Kevin wrote:
>>>>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>>>>> Sent: Sunday, April 10, 2022 6:25 PM
>>>>>
>>>>>>
>>>>>> This adds a flag in the iommu_group struct to indicate an immutable
>>>>>> singleton group, and uses standard PCI bus topology, isolation features,
>>>>>> and DMA alias quirks to set the flag. If the device came from DT,
>> assume
>>>>>> it is static and then the singleton attribute can know from the device
>>>>>> count in the group.
>>>>>
>>>>> where does the assumption come from?
>>>>
>>>> Hotplug is the only factor that can dynamically affect the
>>>> characteristics of IOMMU group singleton as far as I can see. If a
>>>> device node was created from the DT, it could be treated as static,
>>>> hence we can judge the singleton in iommu probe phase during boot.
>>>
>>> I didn't get this. Let's look at your code in iommu_group_add_device():
>>>
>>>    +	else if (is_of_node(dev_fwnode(dev)))
>>>    +		group->immutable_singleton =
>>>    +				(iommu_group_device_count(group) == 1);
>>>
>>> Even if there is a multi-devices group above logic will set the flag when
>>> the first device in the group is added since at that time there is only
>>> one device in the group. We need other concrete information  to tell
>>> it similar to how you walk PCI hierarchy to find out the fact...
>>
>> This is a small trick to make things simpler. Once more devices are
>> added to the group, the flag will be flipped. All iommu_group's should
>> be settled down before any drivers start to consume this flag.
>>
> 
> As an immutable flag it cannot be flipped. What about SVA has been
> enabled on the 1st device before the 2nd one is added to the group?

The flipping happens during iommu probe phase before any device driver
binding. Anyway, I have to agree that it doesn't look clever. :-) Let me
try to figure out another way.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
