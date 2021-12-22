Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB00C433F5
	for <iommu@archiver.kernel.org>; Wed, 22 Dec 2021 04:22:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 107E0405CF;
	Wed, 22 Dec 2021 04:22:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s3tZDh8nhv3W; Wed, 22 Dec 2021 04:22:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A84824013E;
	Wed, 22 Dec 2021 04:22:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72D14C001E;
	Wed, 22 Dec 2021 04:22:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9541CC0012
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 04:22:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D793405CF
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 04:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JmYc23QvuIvY for <iommu@lists.linux-foundation.org>;
 Wed, 22 Dec 2021 04:22:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E55284013E
 for <iommu@lists.linux-foundation.org>; Wed, 22 Dec 2021 04:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1640146962; x=1671682962;
 h=cc:subject:to:references:from:message-id:date:
 mime-version:in-reply-to:content-transfer-encoding;
 bh=Cyl3EnNuBUB+YdjCSptEMAFJt9rmebRqepgSebgdx4Q=;
 b=eubJVPpDfPtfrTBLcr3Gs8dpVBwAY9MKpAwC33JbHbznSW4/tnJzoyaH
 CdDNZXb2dyV0HotKeaLxBwZEDccTTzvbqVG9JTZmJgkJMP6Z4L8uN6mmo
 gyqum56B1quamhPBqn3US5q0KwHNcN4K4x6nn/Eog1BO4XpFGAaU0reyn
 C8FIrU3OF5kCfsTW4qYIDLnKhrMt6FPsZc9IYywIbtZw9wotSbGPwu8fH
 ucYMpr1xzy121jluY2Rn5hKznZFeAjdrr/lS+4NgN8dyp6sMw9SNHKIEZ
 N2YBRqDg5C2Nw+oB3lW3Pet1IcooeEGx232MiBPZIxo8A0h21+Fc0AWoz Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="220553625"
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; d="scan'208";a="220553625"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2021 20:22:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,225,1635231600"; d="scan'208";a="664154927"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118])
 ([10.239.159.118])
 by fmsmga001.fm.intel.com with ESMTP; 21 Dec 2021 20:22:34 -0800
Subject: Re: [PATCH v4 07/13] iommu: Add iommu_at[de]tach_device_shared() for
 multi-device groups
To: Jason Gunthorpe <jgg@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
References: <20211217063708.1740334-1-baolu.lu@linux.intel.com>
 <20211217063708.1740334-8-baolu.lu@linux.intel.com>
 <dd797dcd-251a-1980-ca64-bb38e67a526f@arm.com>
 <20211221184609.GF1432915@nvidia.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <ced7f89a-8857-a8bb-be06-aaaabb4cdf09@linux.intel.com>
Date: Wed, 22 Dec 2021 12:22:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211221184609.GF1432915@nvidia.com>
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
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>
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

On 12/22/21 2:46 AM, Jason Gunthorpe wrote:
>> It's worth taking a step back and realising that overall, this is really
>> just a more generalised and finer-grained extension of what 426a273834ea
>> already did for non-group-aware code, so it makes little sense*not*  to
>> integrate it into the existing interfaces.
> This is taking 426a to it's logical conclusion and*removing*  the
> group API from the drivers entirely. This is desirable because drivers
> cannot do anything sane with the group.
> 
> The drivers have struct devices, and so we provide APIs that work in
> terms of struct devices to cover both driver use cases today, and do
> so more safely than what is already implemented.
> 
> Do not mix up VFIO with the driver interface, these are different
> things. It is better VFIO stay on its own and not complicate the
> driver world.

Per Joerg's previous comments:

https://lore.kernel.org/linux-iommu/20211119150612.jhsvsbzisvux2lga@8bytes.org/

The commit 426a273834ea came only in order to disallow attaching a
single device within a group to a different iommu_domain. So it's
reasonable to improve the existing iommu_attach/detach_device() to cover
all cases. How about below code? Did I miss anything?

int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
{
         struct iommu_group *group;
         int ret = 0;

         group = iommu_group_get(dev);
         if (!group)
                 return -ENODEV;

         mutex_lock(&group->mutex);
         if (group->attach_cnt) {
                 if (group->domain != domain) {
                         ret = -EBUSY;
                         goto unlock_out;
                 }
         } else {
                 ret = __iommu_attach_group(domain, group);
                 if (ret)
                         goto unlock_out;
         }

         group->attach_cnt++;
unlock_out:
         mutex_unlock(&group->mutex);
         iommu_group_put(group);

         return ret;
}
EXPORT_SYMBOL_GPL(iommu_attach_device);

void iommu_detach_device_shared(struct iommu_domain *domain, struct 
device *dev)
{
         struct iommu_group *group;

         group = iommu_group_get(dev);
         if (WARN_ON(!group))
                 return;

         mutex_lock(&group->mutex);
         if (WARN_ON(!group->attach_cnt || group->domain != domain)
                 goto unlock_out;

         if (--group->attach_cnt == 0)
                 __iommu_detach_group(domain, group);

unlock_out:
         mutex_unlock(&group->mutex);
         iommu_group_put(group);
}
EXPORT_SYMBOL_GPL(iommu_detach_device);

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
