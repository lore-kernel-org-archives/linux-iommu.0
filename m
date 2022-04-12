Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483FDC433F5
	for <iommu@archiver.kernel.org>; Tue, 12 Apr 2022 13:10:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E60C9404A8;
	Tue, 12 Apr 2022 13:10:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EfEixIFe-uhH; Tue, 12 Apr 2022 13:10:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id DC21A40189;
	Tue, 12 Apr 2022 13:10:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B04AFC0033;
	Tue, 12 Apr 2022 13:10:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D3B5C002C
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D85D641697
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:10:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ymi3qYMRwFym for <iommu@lists.linux-foundation.org>;
 Tue, 12 Apr 2022 13:10:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 125BC4167A
 for <iommu@lists.linux-foundation.org>; Tue, 12 Apr 2022 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1649769010; x=1681305010;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=FtOtwsR/6/Gleg8tQpLT6Wl9kjWox0FUNsf+RY7PPeY=;
 b=a0/YrpcIulkatJlJ0exuQ11Ek0HXmXVYSpz0gz53Jg9sz5F1KtGOBNEb
 K/AXikQn3bolQhe3mDbz0pPTFTOKm/W5pcDUGfK2bapsOzNFdKeKQEM/6
 19oN1+YBLwxLIs0VT4frEd3n8i52F0E+S54HLJTUjSgJMqGUjdJ6B2cnd
 64DaEBT3+xICRFvjWOwFX9l6WeblFc0XNdJWpnAgfvwRQvhOdIInxM4/7
 E7Qme+1h3OiQImFEw5NONocoqHyG/icSnWOQDBp/FM9WAxC7Hne4z0X/3
 5gsKTBGGRDvhQGNy318hk5OgZk4RUfwSi4+nKpOWS/wUGvqpXDVW4l0EC Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244252783"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="244252783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:10:09 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; d="scan'208";a="572758885"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174])
 ([10.254.210.174])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Apr 2022 06:10:05 -0700
Message-ID: <06240213-dbc6-ea1c-ca49-28663387ac70@linux.intel.com>
Date: Tue, 12 Apr 2022 21:10:03 +0800
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
 <BN9PR11MB527689614CBD807A113493B48CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527689614CBD807A113493B48CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/4/12 15:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>> @@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group
>> *group, struct device *dev)
>>   	list_add_tail(&device->list, &group->devices);
>>   	if (group->domain  && !iommu_is_attach_deferred(dev))
>>   		ret = __iommu_attach_device(group->domain, dev);
>> +
>> +	/*
>> +	 * Use standard PCI bus topology, isolation features, and DMA
>> +	 * alias quirks to set the immutable singleton attribute. If
>> +	 * the device came from DT, assume it is static and then
>> +	 * singleton can know from the device count in the group.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		group->immutable_singleton =
>> +				pci_immutably_isolated(to_pci_dev(dev));
>> +	else if (is_of_node(dev_fwnode(dev)))
>> +		group->immutable_singleton =
>> +				(iommu_group_device_count(group) == 1);
>> +
> 
> btw probably we also want to check when a 2nd device is added
> to a group marked as singleton, just in case some weird thing happens?

It depends on how we judge whether the group to which a DT device
belongs is a singleton. As I explained in another thread, current trick
doesn't support doing this.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
