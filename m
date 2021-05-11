Return-Path: <SRS0=AxcK=KG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F866C43461
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 06:57:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15F56144F
	for <iommu@archiver.kernel.org>; Tue, 11 May 2021 06:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15F56144F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2FBE1405C4;
	Tue, 11 May 2021 06:57:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hEM8VOu1ZhEt; Tue, 11 May 2021 06:57:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A3A81404B8;
	Tue, 11 May 2021 06:57:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DBCAC000D;
	Tue, 11 May 2021 06:57:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33616C0001
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 181FB4057F
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:57:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X7iuUHYLUPOx for <iommu@lists.linux-foundation.org>;
 Tue, 11 May 2021 06:57:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 067A1404B8
 for <iommu@lists.linux-foundation.org>; Tue, 11 May 2021 06:56:59 +0000 (UTC)
IronPort-SDR: oKkgMKYlYXNZq1R5r00Dye7DSAzXrYiNEDFsslan4XOXCmF7PxBgFTahzODG4w7eCV42hmbsPT
 RVUg2wghF6ng==
X-IronPort-AV: E=McAfee;i="6200,9189,9980"; a="260635845"
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="260635845"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 May 2021 23:56:59 -0700
IronPort-SDR: lTiGtF4iiKlRU9B4tNsIxfnwP9/wWixp0OEe0XI9nF45kfoQX5O7UYY48OUurHC2Odg60+HZiW
 /wNbRYg/nytg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,290,1613462400"; d="scan'208";a="621699609"
Received: from allen-box.sh.intel.com (HELO [10.239.159.128])
 ([10.239.159.128])
 by fmsmga006.fm.intel.com with ESMTP; 10 May 2021 23:56:50 -0700
Subject: Re: [PATCH v8 7/9] vfio/mdev: Add iommu related member in mdev_device
To: Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
References: <20190325013036.18400-1-baolu.lu@linux.intel.com>
 <20190325013036.18400-8-baolu.lu@linux.intel.com>
 <20210406200030.GA425310@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <2d6d3c70-0c6f-2430-3982-2705bfe9f5a6@linux.intel.com>
Date: Tue, 11 May 2021 14:56:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210406200030.GA425310@nvidia.com>
Content-Language: en-US
Cc: kevin.tian@intel.com, ashok.raj@intel.com, tiwei.bie@intel.com,
 Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
 sanjay.k.kumar@intel.com, Kirti Wankhede <kwankhede@nvidia.com>,
 linux-kernel@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 iommu@lists.linux-foundation.org, jacob.jun.pan@intel.com, kvm@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, yi.y.sun@intel.com
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

Hi Jason,

On 4/7/21 4:00 AM, Jason Gunthorpe wrote:
> On Mon, Mar 25, 2019 at 09:30:34AM +0800, Lu Baolu wrote:
>> A parent device might create different types of mediated
>> devices. For example, a mediated device could be created
>> by the parent device with full isolation and protection
>> provided by the IOMMU. One usage case could be found on
>> Intel platforms where a mediated device is an assignable
>> subset of a PCI, the DMA requests on behalf of it are all
>> tagged with a PASID. Since IOMMU supports PASID-granular
>> translations (scalable mode in VT-d 3.0), this mediated
>> device could be individually protected and isolated by an
>> IOMMU.
>>
>> This patch adds a new member in the struct mdev_device to
>> indicate that the mediated device represented by mdev could
>> be isolated and protected by attaching a domain to a device
>> represented by mdev->iommu_device. It also adds a helper to
>> add or set the iommu device.
>>
>> * mdev_device->iommu_device
>>    - This, if set, indicates that the mediated device could
>>      be fully isolated and protected by IOMMU via attaching
>>      an iommu domain to this device. If empty, it indicates
>>      using vendor defined isolation, hence bypass IOMMU.
>>
>> * mdev_set/get_iommu_device(dev, iommu_device)
>>    - Set or get the iommu device which represents this mdev
>>      in IOMMU's device scope. Drivers don't need to set the
>>      iommu device if it uses vendor defined isolation.
>>
>> Cc: Ashok Raj <ashok.raj@intel.com>
>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Cc: Kevin Tian <kevin.tian@intel.com>
>> Cc: Liu Yi L <yi.l.liu@intel.com>
>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>> Suggested-by: Alex Williamson <alex.williamson@redhat.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
>>   drivers/vfio/mdev/mdev_core.c    | 18 ++++++++++++++++++
>>   drivers/vfio/mdev/mdev_private.h |  1 +
>>   include/linux/mdev.h             | 14 ++++++++++++++
>>   3 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
>> index b96fedc77ee5..1b6435529166 100644
>> +++ b/drivers/vfio/mdev/mdev_core.c
>> @@ -390,6 +390,24 @@ int mdev_device_remove(struct device *dev, bool force_remove)
>>   	return 0;
>>   }
>>   
>> +int mdev_set_iommu_device(struct device *dev, struct device *iommu_device)
>> +{
>> +	struct mdev_device *mdev = to_mdev_device(dev);
>> +
>> +	mdev->iommu_device = iommu_device;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(mdev_set_iommu_device);
> 
> I was looking at these functions when touching the mdev stuff and I
> have some concerns.
> 
> 1) Please don't merge dead code. It is a year later and there is still
>     no in-tree user for any of this. This is not our process. Even
>     worse it was exported so it looks like this dead code is supporting
>     out of tree modules.
> 
> 2) Why is this like this? Every struct device already has a connection
>     to the iommu layer and every mdev has a struct device all its own.
> 
>     Why did we need to add special 'if (mdev)' stuff all over the
>     place? This smells like the same abuse Thomas
>     and I pointed out for the interrupt domains.
> 
>     After my next series the mdev drivers will have direct access to
>     the vfio_device. So an alternative to using the struct device, or
>     adding 'if mdev' is to add an API to the vfio_device world to
>     inject what iommu configuration is needed from that direction
>     instead of trying to discover it from a struct device.

Just want to make sure that I understand you correctly.

We should use the existing IOMMU in-kernel APIs to connect mdev with the
iommu subsystem, so that the upper lays don't need to use something
like (if dev_is_mdev) to handle mdev differently. Do I get you
correctly?

> 
> 3) The vfio_bus_is_mdev() and related symbol_get() nonsense in
>     drivers/vfio/vfio_iommu_type1.c has to go, for the same reasons
>     it was not acceptable to do this for the interrupt side either.

Yes. Agreed. I will look into it.

> 
> 4) It seems pretty clear to me this will be heavily impacted by the
>     /dev/ioasid discussion. Please consider removing the dead code now.
> 
> Basically, please fix this before trying to get idxd mdev merged as
> the first user.
> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
