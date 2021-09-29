Return-Path: <SRS0=Xpq5=OT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4867CC433F5
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:25:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E208B613E6
	for <iommu@archiver.kernel.org>; Wed, 29 Sep 2021 02:25:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E208B613E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFDDE80F57;
	Wed, 29 Sep 2021 02:25:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3Vb8wOxXqLuV; Wed, 29 Sep 2021 02:25:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 819178174C;
	Wed, 29 Sep 2021 02:25:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 54FDCC0011;
	Wed, 29 Sep 2021 02:25:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1B171C000D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:25:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 02E62415DF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:25:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qv0YF6IsjR44 for <iommu@lists.linux-foundation.org>;
 Wed, 29 Sep 2021 02:25:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3987F415CF
 for <iommu@lists.linux-foundation.org>; Wed, 29 Sep 2021 02:25:53 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="285860300"
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="285860300"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 19:25:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,331,1624345200"; d="scan'208";a="476495153"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by orsmga007.jf.intel.com with ESMTP; 28 Sep 2021 19:25:45 -0700
Subject: Re: [RFC 06/20] iommu: Add iommu_device_init[exit]_user_dma interfaces
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20210919063848.1476776-1-yi.l.liu@intel.com>
 <20210919063848.1476776-7-yi.l.liu@intel.com>
 <20210921170943.GS327412@nvidia.com>
 <BN9PR11MB5433DA330D4583387B59AA7F8CA29@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210922123931.GI327412@nvidia.com>
 <BN9PR11MB5433CE19425E85E7F52093278CA79@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210927150928.GA1517957@nvidia.com>
 <BN9PR11MB54337B7F65B98C2335B806938CA89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210928115751.GK964074@nvidia.com>
 <9a314095-3db9-30fc-2ed9-4e46d385036d@linux.intel.com>
 <20210928140712.GL964074@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <4ba3294b-1628-0522-17ff-8aa38ed5a615@linux.intel.com>
Date: Wed, 29 Sep 2021 10:22:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210928140712.GL964074@nvidia.com>
Content-Language: en-US
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "Tian, Kevin" <kevin.tian@intel.com>,
 "parav@mellanox.com" <parav@mellanox.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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

On 9/28/21 10:07 PM, Jason Gunthorpe wrote:
> On Tue, Sep 28, 2021 at 09:35:05PM +0800, Lu Baolu wrote:
>> Another issue is, when putting a device into user-dma mode, all devices
>> belonging to the same iommu group shouldn't be bound with a kernel-dma
>> driver. Kevin's prototype checks this by READ_ONCE(dev->driver). This is
>> not lock safe as discussed below,
>>
>> https://lore.kernel.org/linux-iommu/20210927130935.GZ964074@nvidia.com/
>>
>> Any guidance on this?
> 
> Something like this?
> 
> 
> int iommu_set_device_dma_owner(struct device *dev, enum device_dma_owner mode,
> 			       struct file *user_owner)
> {
> 	struct iommu_group *group = group_from_dev(dev);
> 
> 	spin_lock(&iommu_group->dma_owner_lock);
> 	switch (mode) {
> 		case DMA_OWNER_KERNEL:
> 			if (iommu_group->dma_users[DMA_OWNER_USERSPACE])
> 				return -EBUSY;
> 			break;
> 		case DMA_OWNER_SHARED:
> 			break;
> 		case DMA_OWNER_USERSPACE:
> 			if (iommu_group->dma_users[DMA_OWNER_KERNEL])
> 				return -EBUSY;
> 			if (iommu_group->dma_owner_file != user_owner) {
> 				if (iommu_group->dma_users[DMA_OWNER_USERSPACE])
> 					return -EPERM;
> 				get_file(user_owner);
> 				iommu_group->dma_owner_file = user_owner;
> 			}
> 			break;
> 		default:
> 			spin_unlock(&iommu_group->dma_owner_lock);
> 			return -EINVAL;
> 	}
> 	iommu_group->dma_users[mode]++;
> 	spin_unlock(&iommu_group->dma_owner_lock);
> 	return 0;
> }
> 
> int iommu_release_device_dma_owner(struct device *dev,
> 				   enum device_dma_owner mode)
> {
> 	struct iommu_group *group = group_from_dev(dev);
> 
> 	spin_lock(&iommu_group->dma_owner_lock);
> 	if (WARN_ON(!iommu_group->dma_users[mode]))
> 		goto err_unlock;
> 	if (!iommu_group->dma_users[mode]--) {
> 		if (mode == DMA_OWNER_USERSPACE) {
> 			fput(iommu_group->dma_owner_file);
> 			iommu_group->dma_owner_file = NULL;
> 		}
> 	}
> err_unlock:
> 	spin_unlock(&iommu_group->dma_owner_lock);
> }
> 
> 
> Where, the driver core does before probe:
> 
>     iommu_set_device_dma_owner(dev, DMA_OWNER_KERNEL, NULL)
> 
> pci_stub/etc does in their probe func:
> 
>     iommu_set_device_dma_owner(dev, DMA_OWNER_SHARED, NULL)
> 
> And vfio/iommfd does when a struct vfio_device FD is attached:
> 
>     iommu_set_device_dma_owner(dev, DMA_OWNER_USERSPACE, group_file/iommu_file)

Really good design. It also helps alleviating some pains elsewhere in
the iommu core.

Just a nit comment, we also need DMA_OWNER_NONE which will be set when
the driver core unbinds the driver from the device.

> 
> Jason
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
