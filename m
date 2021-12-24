Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8901AC433F5
	for <iommu@archiver.kernel.org>; Fri, 24 Dec 2021 06:44:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1EBC4160F;
	Fri, 24 Dec 2021 06:44:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gZbTeMvwmwnk; Fri, 24 Dec 2021 06:44:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B316D414C3;
	Fri, 24 Dec 2021 06:44:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 891F4C002F;
	Fri, 24 Dec 2021 06:44:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9B4E1C0012
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 06:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82863832C7
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 06:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 03wreK1FPYbG for <iommu@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 06:44:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7D799831F5
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 06:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640328282; x=1671864282;
 h=message-id:date:mime-version:cc:to:references:from:
 subject:in-reply-to:content-transfer-encoding;
 bh=7Xc5dzX2sN4TanzEABvQdPekw88Sa8jkaWd1YmxT05k=;
 b=F8IMUxZdOJZ3esji1vQTU2wfJFJQCQFBnoyX/s2+IjragJuFs8MuacLd
 vOvxE6dM5fvsVFs/QjFqXr8pkcNtjcVAjrdq8+od8VsGD8v+d8LxS7uCd
 NUXB1kDeW17Z51CM9QXVdJinaiqdE81uxvxGB/o4PgbcIw0V9WXAza0j0
 qNf6qntapUCP40ObTBIZNCiTNRek+MFnfaxmK19XMI1NPVlHGAmfpOEpq
 tAgDRkYduV5vNogzoMBc70fjRZ9CRVkHwioW2SUvxuyNJvrQGnKa6LohV
 rsHFQ232dzkjqqDjz8Xc+BaaDaNY0zqTYEdLUEgACMu4NinbDISFAcSt5 w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="241161423"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="241161423"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 22:44:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="468769790"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.212.152])
 ([10.254.212.152])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 22:44:28 -0800
Message-ID: <254d6e52-0644-6600-8f30-5331ed961298@linux.intel.com>
Date: Fri, 24 Dec 2021 14:44:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
 <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
 <20211221184609.GF1432915@nvidia.com>
 <aebbd9c7-a239-0f89-972b-a9059e8b218b@arm.com>
 <20211223005712.GA1779224@nvidia.com>
 <fea0fc91-ac4c-dfe4-f491-5f906bea08bd@linux.intel.com>
 <20211223140300.GC1779224@nvidia.com>
 <50b8bb0f-3873-b128-48e8-22f6142f7118@linux.intel.com>
 <20211224025036.GD1779224@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
In-Reply-To: <20211224025036.GD1779224@nvidia.com>
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

Hi Jason,

On 2021/12/24 10:50, Jason Gunthorpe wrote:
> On Fri, Dec 24, 2021 at 09:30:17AM +0800, Lu Baolu wrote:
>> Hi Jason,
>>
>> On 12/23/21 10:03 PM, Jason Gunthorpe wrote:
>>>>> I think it would be clear why iommu_group_set_dma_owner(), which
>>>>> actually does detatch, is not the same thing as iommu_attach_device().
>>>> iommu_device_set_dma_owner() will eventually call
>>>> iommu_group_set_dma_owner(). I didn't get why
>>>> iommu_group_set_dma_owner() is special and need to keep.
>>> Not quite, they would not call each other, they have different
>>> implementations:
>>>
>>> int iommu_device_use_dma_api(struct device *device)
>>> {
>>> 	struct iommu_group *group = device->iommu_group;
>>>
>>> 	if (!group)
>>> 		return 0;
>>>
>>> 	mutex_lock(&group->mutex);
>>> 	if (group->owner_cnt != 0 ||
>>> 	    group->domain != group->default_domain) {
>>> 		mutex_unlock(&group->mutex);
>>> 		return -EBUSY;
>>> 	}
>>> 	group->owner_cnt = 1;
>>> 	group->owner = NULL;
>>> 	mutex_unlock(&group->mutex);
>>> 	return 0;
>>> }
>> It seems that this function doesn't work for multi-device groups. When
>> the user unbinds all native drivers from devices in the group and start
>> to bind them with vfio-pci and assign them to user, how could iommu know
>> whether the group is viable for user?
> It is just a mistake, I made this very fast. It should work as your
> patch had it with a ++. More like this:
> 
> int iommu_device_use_dma_api(struct device *device)
> {
> 	struct iommu_group *group = device->iommu_group;
> 
> 	if (!group)
> 		return 0;
> 
> 	mutex_lock(&group->mutex);
> 	if (group->owner_cnt != 0) {
> 		if (group->domain != group->default_domain ||
> 		    group->owner != NULL) {
> 			mutex_unlock(&group->mutex);
> 			return -EBUSY;
> 		}
> 	}
> 	group->owner_cnt++;
> 	mutex_unlock(&group->mutex);
> 	return 0;
> }
> 
>>> See, we get rid of the enum as a multiplexor parameter, each API does
>>> only wnat it needs, they don't call each other.
>> I like the idea of removing enum parameter and make the API name
>> specific. But I didn't get why they can't call each other even the
>> data in group is the same.
> Well, I think when you type them out you'll find they don't work the
> same. Ie the iommu_group_set_dma_owner() does __iommu_detach_group()
> which iommu_device_use_dma_api() definately doesn't want to
> do. iommu_device_use_dma_api() checks the domain while
> iommu_group_set_dma_owner() must not.
> 
> This is basically the issue, all the places touching ownercount are
> superficially the same but each use different predicates. Given the
> predicate is more than half the code I wouldn't try to share the rest
> of it. But maybe when it is all typed in something will become
> obvious?
> 

Get you and agree with you. For the remaining comments, let me wait and
listen what Robin will comment.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
