Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 105AAC433EF
	for <iommu@archiver.kernel.org>; Wed, 25 May 2022 04:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A43E460BD5;
	Wed, 25 May 2022 04:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SXsmjA-0htR7; Wed, 25 May 2022 04:50:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 60AAE60B02;
	Wed, 25 May 2022 04:50:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1DFE5C0032;
	Wed, 25 May 2022 04:50:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61487C002D
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 04:50:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 57E9583F66
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 04:50:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VthDThb8BK8L for <iommu@lists.linux-foundation.org>;
 Wed, 25 May 2022 04:50:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8222583F2E
 for <iommu@lists.linux-foundation.org>; Wed, 25 May 2022 04:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1653454210; x=1684990210;
 h=message-id:date:mime-version:cc:subject:to:references:
 from:in-reply-to:content-transfer-encoding;
 bh=pjZMmEANMCnklIA4vkBd2ENvVE8LwaQZspI3mdFXeHY=;
 b=Bz07Cdun7geUfgE5rloSint2MN1vCaXC2vhxMSOPIRkM/DudzNfMxO5d
 G96PK8kHTkR3DNkpoAhOk5B7vMKYLPkzm7Ebndrnb2N3VhbgAcCAamKPh
 7mywDkNJq8wqUSAzfMzQZXl5XDqKPFy1BBk4/8BkhtPzYRLlR1Wdeetrg
 KYYmB7pRKHL+ev2oGBSiZ8WlJrpWy7UOeAWMz5w6NGfWTRBImOQyK2wQT
 mH9A1G8NZGrlU6pw2kOkDFSjyBabZQpnvOb1TZCXYrdj9Z9ctXahJwap7
 Z/AS6IAe8PmPu/cIyX5MRNJRCFe+Czh94r3vwAoCfSaQjWu5FYM1hTFL+ g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="255778025"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="255778025"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 21:50:09 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; d="scan'208";a="601652421"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139])
 ([10.255.29.139])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 May 2022 21:50:06 -0700
Message-ID: <caae0926-b8f8-a64d-5c33-441e33d0c1dc@linux.intel.com>
Date: Wed, 25 May 2022 12:50:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To: "Tian, Kevin" <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276982C37DFF0FEFC45BDD68CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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

On 2022/5/24 17:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Thursday, May 19, 2022 3:21 PM
>>
>> The iommu_sva_domain represents a hardware pagetable that the IOMMU
>> hardware could use for SVA translation. This adds some infrastructure
>> to support SVA domain in the iommu common layer. It includes:
>>
>> - Add a new struct iommu_sva_domain and new IOMMU_DOMAIN_SVA
>> domain
>>    type.
>> - Add a new domain ops pointer in iommu_ops. The IOMMU drivers that
>>    support SVA should provide the callbacks.
>> - Add helpers to allocate and free an SVA domain.
>> - Add helpers to set an SVA domain to a device and the reverse
>>    operation.
>>
>> Some buses, like PCI, route packets without considering the PASID value.
>> Thus a DMA target address with PASID might be treated as P2P if the
>> address falls into the MMIO BAR of other devices in the group. To make
>> things simple, the attach/detach interfaces only apply to devices
>> belonging to the singleton groups, and the singleton is immutable in
>> fabric i.e. not affected by hotplug.
>>
>> The iommu_set/block_device_pasid() can be used for other purposes,
>> such as kernel DMA with pasid, mediation device, etc. Hence, it is put
>> in the iommu.c.
> 
> usually we have 'set/clear' pair or 'allow/block'. Having 'set' paired
> with 'block' doesn't read very clearly.

Yes. Let's still use the attach/detach semantics.

> 
>> +static bool device_group_immutable_singleton(struct device *dev)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
> 
> what about passing group as the parameter since the caller will
> get the group again right after calling this function? In that case
> the function could be renamed as:
> 
> 	iommu_group_immutable_singleton()
> 
> or be shorter:
> 
> 	iommu_group_fixed_singleton()

Fair enough. I will tune it as below:

+static bool iommu_group_immutable_singleton(struct iommu_group *group)
+{
+       int count;
+
+       mutex_lock(&group->mutex);
+       count = iommu_group_device_count(group);
+       mutex_unlock(&group->mutex);
+
+       if (count != 1)
+               return false;
+
+       /*
+        * The PCI device could be considered to be fully isolated if all
+        * devices on the path from the device to the host-PCI bridge are
+        * protected from peer-to-peer DMA by ACS.
+        */
+       if (dev_is_pci(dev))
+               return pci_acs_path_enabled(to_pci_dev(dev), NULL,
+                                           REQ_ACS_FLAGS);
+
+       /*
+        * Otherwise, the device came from DT/ACPI, assume it is static and
+        * then singleton can know from the device count in the group.
+        */
+       return true;
+}


> 
>> +	int count;
>> +
>> +	if (!group)
>> +		return false;
>> +
>> +	mutex_lock(&group->mutex);
>> +	count = iommu_group_device_count(group);
>> +	mutex_unlock(&group->mutex);
>> +	iommu_group_put(group);
>> +
>> +	if (count != 1)
>> +		return false;
> 
> For non-pci devices above doesn't check anything against immutable.
> Please add some comment to explain why doing so is correct.

Yes, as above code shows.

> 
>> +
>> +	/*
>> +	 * The PCI device could be considered to be fully isolated if all
>> +	 * devices on the path from the device to the host-PCI bridge are
>> +	 * protected from peer-to-peer DMA by ACS.
>> +	 */
>> +	if (dev_is_pci(dev))
>> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
>> +					    REQ_ACS_FLAGS);
>> +
>> +	return true;
>> +}
>> +

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
