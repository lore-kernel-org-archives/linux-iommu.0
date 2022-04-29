Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F5FC433FE
	for <iommu@archiver.kernel.org>; Fri, 29 Apr 2022 06:27:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 06F9241C18;
	Fri, 29 Apr 2022 06:27:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJXepvZzwsZJ; Fri, 29 Apr 2022 06:27:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5000441C11;
	Fri, 29 Apr 2022 06:27:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 298A8C0039;
	Fri, 29 Apr 2022 06:27:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6F1FC002D
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B0A6083459
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:27:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ugn3bn5sObeP for <iommu@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:27:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EC5D482ED1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Apr 2022 06:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651213661; x=1682749661;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=SuKUMbuCFeOAQ3RN6lPTsfmXavMFIzZF1jAdEMe+Jcw=;
 b=D0rpZx68KQUnfxFbjFo1z2Gk+ZimrlW2tPnDB0cvJ4r+Sh1nA7q/SDMB
 pcUoZXLlHVQSahZrAHcG2fYXe1CGnXcWGLZzZUlrw52xmTrVKHPOkPoY4
 PuyaDYAjdVVqUCGfvZd3n3PvGSgvBx83qa5oO3UMdKWJQ0OpWgjC0/+fo
 TrMoyvB7LnBoNpK+SKecgDilyZj+lxbCPLzvFVcgT1dZlkuYGh5uWSHSx
 50Ww/HFZVrdTUzYaTkZml3jtNjLi300zzb9pDn7J+BeLQEjA1Ize7HCV6
 uom2HJ/hgqQIbdmH9JWD36Ll6HVzlzwf47RjSg65JzE7whkioxaNqlV+q Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246464359"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="246464359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:27:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; d="scan'208";a="581921103"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95])
 ([10.249.170.95])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2022 23:27:36 -0700
Message-ID: <47d16a5f-23de-fb84-6958-5329ef08fb25@linux.intel.com>
Date: Fri, 29 Apr 2022 14:27:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 03/12] iommu: Add attach/detach_dev_pasid domain ops
Content-Language: en-US
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-4-baolu.lu@linux.intel.com> <YmqqaXtqev9FUJo7@myrica>
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqqaXtqev9FUJo7@myrica>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On 2022/4/28 22:53, Jean-Philippe Brucker wrote:
> On Thu, Apr 21, 2022 at 01:21:12PM +0800, Lu Baolu wrote:
>> Attaching an IOMMU domain to a PASID of a device is a generic operation
>> for modern IOMMU drivers which support PASID-granular DMA address
>> translation. Currently visible usage scenarios include (but not limited):
>>
>>   - SVA (Shared Virtual Address)
>>   - kernel DMA with PASID
>>   - hardware-assist mediated device
>>
>> This adds a pair of common domain ops for this purpose and adds helpers
>> to attach/detach a domain to/from a {device, PASID}. Some buses, like
>> PCI, route packets without considering the PASID value. Thus a DMA target
>> address with PASID might be treated as P2P if the address falls into the
>> MMIO BAR of other devices in the group. To make things simple, these
>> interfaces only apply to devices belonging to the singleton groups, and
>> the singleton is immutable in fabric i.e. not affected by hotplug.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> [...]
>> +/*
>> + * Use standard PCI bus topology, isolation features, and DMA
>> + * alias quirks to check the immutable singleton attribute. If
>> + * the device came from DT, assume it is static and then
>> + * singleton can know from the device count in the group.
>> + */
>> +static bool device_group_immutable_singleton(struct device *dev)
>> +{
>> +	struct iommu_group *group = iommu_group_get(dev);
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
>> +
>> +	if (dev_is_pci(dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +		/*
>> +		 * The device could be considered to be fully isolated if
>> +		 * all devices on the path from the device to the host-PCI
>> +		 * bridge are protected from peer-to-peer DMA by ACS.
>> +		 */
>> +		if (!pci_acs_path_enabled(pdev, NULL, REQ_ACS_FLAGS))
>> +			return false;
>> +
>> +		/* Filter out devices which has any alias device. */
>> +		if (pci_for_each_dma_alias(pdev, has_pci_alias, pdev))
>> +			return false;
> 
> Aren't aliases already added to the group by pci_device_group()?  If so
> it's part of the count check above

You are right. pci_device_group() has already covered pci aliases.

> 
>> +
>> +		return true;
>> +	}
>> +
>> +	/*
>> +	 * If the device came from DT, assume it is static and then
>> +	 * singleton can know from the device count in the group.
>> +	 */
>> +	return is_of_node(dev_fwnode(dev));
> 
> I don't think DT is relevant here because a platform device enumerated
> through ACPI will also have its own group. It should be safe to stick to
> what the IOMMU drivers declare with their device_group() callback. Except
> for PCI those groups should be immutable so we can return true here.

Fair enough. My code is too restrict. The group singleton is immutable
as long as the fabric is static or ACS (or similar) technology is
implemented. Currently we only need to care about PCI as far as I can
see.

> Thanks,
> Jean
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
