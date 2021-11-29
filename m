Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDA7C433EF
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 04:03:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA22040247;
	Mon, 29 Nov 2021 04:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pnZgdbodDdwt; Mon, 29 Nov 2021 04:03:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4861340236;
	Mon, 29 Nov 2021 04:03:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBC5AC001C;
	Mon, 29 Nov 2021 04:03:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 13DC6C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 04:03:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EA3BC4036E
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 04:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SNpcRFrCu3FA for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 04:03:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE49840265
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 04:03:37 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="299288303"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; d="scan'208";a="299288303"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2021 20:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; d="scan'208";a="458985855"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga006.jf.intel.com with ESMTP; 28 Nov 2021 20:03:29 -0800
Subject: Re: [PATCH v2 02/17] driver core: Add dma_unconfigure callback in
 bus_type
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20211128025051.355578-1-baolu.lu@linux.intel.com>
 <20211128025051.355578-3-baolu.lu@linux.intel.com>
 <YaM3slBGozqxsQ+m@kroah.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <0eca1892-a063-a695-ac35-0ac1e2de28e0@linux.intel.com>
Date: Mon, 29 Nov 2021 12:03:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YaM3slBGozqxsQ+m@kroah.com>
Content-Language: en-US
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Will Deacon <will@kernel.org>,
 Ashok Raj <ashok.raj@intel.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Kevin Tian <kevin.tian@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, Dan Williams <dan.j.williams@intel.com>,
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

On 11/28/21 4:02 PM, Greg Kroah-Hartman wrote:
> On Sun, Nov 28, 2021 at 10:50:36AM +0800, Lu Baolu wrote:
>> The bus_type structure defines dma_configure() callback for bus drivers
>> to configure DMA on the devices. This adds the paired dma_unconfigure()
>> callback and calls it during driver unbinding so that bus drivers can do
>> some cleanup work.
>>
>> One use case for this paired DMA callbacks is for the bus driver to check
>> for DMA ownership conflicts during driver binding, where multiple devices
>> belonging to a same IOMMU group (the minimum granularity of isolation and
>> protection) may be assigned to kernel drivers or user space respectively.
>>
>> Without this change, for example, the vfio driver has to listen to a bus
>> BOUND_DRIVER event and then BUG_ON() in case of dma ownership conflict.
>> This leads to bad user experience since careless driver binding operation
>> may crash the system if the admin overlooks the group restriction. Aside
>> from bad design, this leads to a security problem as a root user, even with
>> lockdown=integrity, can force the kernel to BUG.
>>
>> With this change, the bus driver could check and set the DMA ownership in
>> driver binding process and fail on ownership conflicts. The DMA ownership
>> should be released during driver unbinding.
>>
>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>> Link: https://lore.kernel.org/linux-iommu/20210922123931.GI327412@nvidia.com/
>> Link: https://lore.kernel.org/linux-iommu/20210928115751.GK964074@nvidia.com/
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> ---
>>   include/linux/device/bus.h | 3 +++
>>   drivers/base/dd.c          | 7 ++++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
>> index a039ab809753..ef54a71e5f8f 100644
>> --- a/include/linux/device/bus.h
>> +++ b/include/linux/device/bus.h
>> @@ -59,6 +59,8 @@ struct fwnode_handle;
>>    *		bus supports.
>>    * @dma_configure:	Called to setup DMA configuration on a device on
>>    *			this bus.
>> + * @dma_unconfigure:	Called to cleanup DMA configuration on a device on
>> + *			this bus.
> 
> "dma_cleanup()" is a better name for this, don't you think?

I agree with you. dma_cleanup() is more explicit and better here.

> 
> thanks,
> 
> greg k-h
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
