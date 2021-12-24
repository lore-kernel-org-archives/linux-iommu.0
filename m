Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C190BC433EF
	for <iommu@archiver.kernel.org>; Fri, 24 Dec 2021 01:30:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 603C181570;
	Fri, 24 Dec 2021 01:30:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nV_milteiQnb; Fri, 24 Dec 2021 01:30:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CC708343B;
	Fri, 24 Dec 2021 01:30:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03489C002F;
	Fri, 24 Dec 2021 01:30:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4B112C0012
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 01:30:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3DAAD400D0
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 01:30:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=intel.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W0kFHEPWvUMR for <iommu@lists.linux-foundation.org>;
 Fri, 24 Dec 2021 01:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 15866400CB
 for <iommu@lists.linux-foundation.org>; Fri, 24 Dec 2021 01:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640309452; x=1671845452;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=JjtBgOF28/vwd8lH1VxYSdGqqqEZptc6KfCcvvY2TOw=;
 b=X9QeyJaA5Dg37V3+JnyAj1bAKn+QQ39u9+YCmpmbcs7IWFfuxjeYFGTv
 7Y9XRqWsa9MUAsXEIPRepjOc1vPGqLdNr9gPOho5CFgzDpex49r7oKRHa
 fVqAXPZ7HnYwG9F4eT6gXxMTxdtvDa4jUGX6oMWh6a66adzTS8cXLCSL8
 PwZzUMigz6KiVJE1XcSUUZLnH9ci5cGTqK2oJOusiKHZgiiRF8QfP1w3+
 7oweTcpJ39qv3vsIWo4dmSAAZJxaqfZR6C77za8jfZMoAntV9D6oW0WvE
 TKDKDsiRBUIpyiBi8FA/JIX8sKWyhvH0tWuWAzexU9zKovUIY6j5tY41L A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10207"; a="301672018"
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="301672018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Dec 2021 17:30:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,231,1635231600"; d="scan'208";a="664737519"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 17:30:43 -0800
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
 <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
 <20211221184609.GF1432915@nvidia.com>
 <aebbd9c7-a239-0f89-972b-a9059e8b218b@arm.com>
 <20211223005712.GA1779224@nvidia.com>
 <fea0fc91-ac4c-dfe4-f491-5f906bea08bd@linux.intel.com>
 <20211223140300.GC1779224@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <50b8bb0f-3873-b128-48e8-22f6142f7118@linux.intel.com>
Date: Fri, 24 Dec 2021 09:30:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211223140300.GC1779224@nvidia.com>
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

Hi Jason,

On 12/23/21 10:03 PM, Jason Gunthorpe wrote:
>>> I think it would be clear why iommu_group_set_dma_owner(), which
>>> actually does detatch, is not the same thing as iommu_attach_device().
>> iommu_device_set_dma_owner() will eventually call
>> iommu_group_set_dma_owner(). I didn't get why
>> iommu_group_set_dma_owner() is special and need to keep.
> Not quite, they would not call each other, they have different
> implementations:
> 
> int iommu_device_use_dma_api(struct device *device)
> {
> 	struct iommu_group *group = device->iommu_group;
> 
> 	if (!group)
> 		return 0;
> 
> 	mutex_lock(&group->mutex);
> 	if (group->owner_cnt != 0 ||
> 	    group->domain != group->default_domain) {
> 		mutex_unlock(&group->mutex);
> 		return -EBUSY;
> 	}
> 	group->owner_cnt = 1;
> 	group->owner = NULL;
> 	mutex_unlock(&group->mutex);
> 	return 0;
> }

It seems that this function doesn't work for multi-device groups. When
the user unbinds all native drivers from devices in the group and start
to bind them with vfio-pci and assign them to user, how could iommu know
whether the group is viable for user?

> 
> int iommu_group_set_dma_owner(struct iommu_group *group, struct file *owner)
> {
> 	mutex_lock(&group->mutex);
> 	if (group->owner_cnt != 0) {
> 		if (group->owner != owner)
> 			goto err_unlock;
> 		group->owner_cnt++;
> 		mutex_unlock(&group->mutex);
> 		return 0;
> 	}
> 	if (group->domain && group->domain != group->default_domain)
> 		goto err_unlock;
> 
> 	__iommu_detach_group(group->domain, group);
> 	group->owner_cnt = 1;
> 	group->owner = owner;
> 	mutex_unlock(&group->mutex);
> 	return 0;
> 
> err_unlock;
> 	mutex_unlock(&group->mutex);
> 	return -EBUSY;
> }
> 
> It is the same as how we ended up putting the refcounting logic
> directly into the iommu_attach_device().
> 
> See, we get rid of the enum as a multiplexor parameter, each API does
> only wnat it needs, they don't call each other.

I like the idea of removing enum parameter and make the API name
specific. But I didn't get why they can't call each other even the
data in group is the same.

> 
> We don't need _USER anymore because iommu_group_set_dma_owner() always
> does detatch, and iommu_replace_group_domain() avoids ever reassigning
> default_domain. The sepecial USER behavior falls out automatically.

This means we will grow more group-centric interfaces. My understanding
is the opposite that we should hide the concept of group in IOMMU
subsystem, and the device drivers only faces device specific interfaces.

The iommu groups are created by the iommu subsystem. The device drivers
don't play any role in determining which device belongs to which group.
So the iommu interfaces for device driver shouldn't rely on the group.

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
