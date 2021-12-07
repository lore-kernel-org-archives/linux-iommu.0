Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54728C433F5
	for <iommu@archiver.kernel.org>; Tue,  7 Dec 2021 01:52:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C453D40529;
	Tue,  7 Dec 2021 01:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A8OlJ_kQlP7T; Tue,  7 Dec 2021 01:52:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 654614039D;
	Tue,  7 Dec 2021 01:52:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F68BC002F;
	Tue,  7 Dec 2021 01:52:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0A14C0012
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:52:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id ABEA740183
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S7WyG4grfZcx for <iommu@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 01:52:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D211640135
 for <iommu@lists.linux-foundation.org>; Tue,  7 Dec 2021 01:52:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="217481071"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="217481071"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Dec 2021 17:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; d="scan'208";a="515038186"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga008.jf.intel.com with ESMTP; 06 Dec 2021 17:52:44 -0800
Subject: Re: [PATCH v3 01/18] iommu: Add device dma ownership set/release
 interfaces
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>
References: <20211206015903.88687-1-baolu.lu@linux.intel.com>
 <20211206015903.88687-2-baolu.lu@linux.intel.com>
 <Ya4Ru/GtILJYzI6j@8bytes.org> <20211206150144.GC4670@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <fa30d398-746c-c7d0-830f-40e3aaee16d6@linux.intel.com>
Date: Tue, 7 Dec 2021 09:52:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211206150144.GC4670@nvidia.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Robin Murphy <robin.murphy@arm.com>
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

On 12/6/21 11:01 PM, Jason Gunthorpe wrote:
> On Mon, Dec 06, 2021 at 02:35:55PM +0100, Joerg Roedel wrote:
>> On Mon, Dec 06, 2021 at 09:58:46AM +0800, Lu Baolu wrote:
>>> >From the perspective of who is initiating the device to do DMA, device
>>> DMA could be divided into the following types:
>>>
>>>          DMA_OWNER_DMA_API: Device DMAs are initiated by a kernel driver
>>> 			through the kernel DMA API.
>>>          DMA_OWNER_PRIVATE_DOMAIN: Device DMAs are initiated by a kernel
>>> 			driver with its own PRIVATE domain.
>>> 	DMA_OWNER_PRIVATE_DOMAIN_USER: Device DMAs are initiated by
>>> 			userspace.
>>
>> I have looked at the other iommu patches in this series, but I still
>> don't quite get what the difference in the code flow is between
>> DMA_OWNER_PRIVATE_DOMAIN and DMA_OWNER_PRIVATE_DOMAIN_USER. What are the
>> differences in the iommu core behavior based on this setting?
> 
> USER causes the IOMMU code to spend extra work to never assign the
> default domain. Lu, it would be good to update the comment with this
> detail
> 
> Once in USER mode the domain is always a /dev/null domain or a domain
> controlled by userspace. Never a domain pointing at kernel memory.

Yes. The __iommu_detach_group() re-attaches the default domain
automatically. This is not allowed once in USER mode.

I will update the comments whit this detail.

> 
>>>   struct group_device {
>>> @@ -621,6 +624,7 @@ struct iommu_group *iommu_group_alloc(void)
>>>   	INIT_LIST_HEAD(&group->devices);
>>>   	INIT_LIST_HEAD(&group->entry);
>>>   	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
>>> +	group->dma_owner = DMA_OWNER_NONE;
>>
>>
>> DMA_OWNER_NONE is also questionable. All devices are always in one
>> domain, and the default domain is always the one used for DMA-API, so
>> why isn't the initial value DMA_OWNER_DMA_API?
> 
> 'NONE' means the group is in the default domain but no driver is bound
> and thus DMA isn't being used. Seeing NONE is the only condition when
> it is OK to change the domain.
> 
> This could be reworked to instead rely on the refcount == 0 as the
> signal to know it is OK to change the domain and then we never have
> NONE at all. Lu?

NONE is just a parking state. It's okay to rely on the "refcount == 0"
for state transition as far as I see. I will work towards this.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
