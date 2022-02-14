Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E92C4332F
	for <iommu@archiver.kernel.org>; Mon, 14 Feb 2022 11:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75D8860EF5;
	Mon, 14 Feb 2022 11:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CJVxjvfP09sX; Mon, 14 Feb 2022 11:39:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3B64060DB2;
	Mon, 14 Feb 2022 11:39:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 103EBC001A;
	Mon, 14 Feb 2022 11:39:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88568C000B
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:39:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6785081383
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:39:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CEJzs2EsNvbC for <iommu@lists.linux-foundation.org>;
 Mon, 14 Feb 2022 11:39:40 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from theia.8bytes.org (8bytes.org
 [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9011381353
 for <iommu@lists.linux-foundation.org>; Mon, 14 Feb 2022 11:39:40 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id 727E836D; Mon, 14 Feb 2022 12:39:37 +0100 (CET)
Date: Mon, 14 Feb 2022 12:39:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v1 3/8] iommu: Extend iommu_at[de]tach_device() for
 multi-device groups
Message-ID: <Ygo/eCRFnraY01WA@8bytes.org>
References: <20220106022053.2406748-1-baolu.lu@linux.intel.com>
 <20220106022053.2406748-4-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220106022053.2406748-4-baolu.lu@linux.intel.com>
Cc: Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Dmitry Osipenko <digetx@gmail.com>,
 Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
 Chaitanya Kulkarni <kch@nvidia.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Thu, Jan 06, 2022 at 10:20:48AM +0800, Lu Baolu wrote:
>  int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  {
>  	struct iommu_group *group;
> -	int ret;
> +	int ret = 0;
> +
> +	if (domain->type != IOMMU_DOMAIN_UNMANAGED)
> +		return -EINVAL;
>  
>  	group = iommu_group_get(dev);
>  	if (!group)
>  		return -ENODEV;
>  
> -	/*
> -	 * Lock the group to make sure the device-count doesn't
> -	 * change while we are attaching
> -	 */
>  	mutex_lock(&group->mutex);
> -	ret = -EINVAL;
> -	if (iommu_group_device_count(group) != 1)
> -		goto out_unlock;
> +	if (group->owner_cnt) {
> +		/*
> +		 * Group has been used for kernel-api dma or claimed explicitly
> +		 * for exclusive occupation. For backward compatibility, device
> +		 * in a singleton group is allowed to ignore setting the
> +		 * drv.no_kernel_api_dma field.
> +		 */
> +		if ((group->domain == group->default_domain &&
> +		     iommu_group_device_count(group) != 1) ||
> +		    group->owner) {
> +			ret = -EBUSY;
> +			goto unlock_out;
> +		}
> +	}
>  
> -	ret = __iommu_attach_group(domain, group);
> +	if (!group->attach_cnt) {
> +		ret = __iommu_attach_group(domain, group);
> +		if (ret)
> +			goto unlock_out;
> +	} else {
> +		if (group->domain != domain) {
> +			ret = -EPERM;
> +			goto unlock_out;
> +		}
> +	}
>  
> -out_unlock:
> +	group->owner_cnt++;
> +	group->attach_cnt++;
> +
> +unlock_out:
>  	mutex_unlock(&group->mutex);
>  	iommu_group_put(group);

This extends iommu_attach_device() to behave as iommu_attach_group(),
changing the domain for the whole group. Wouldn't it be better to scrap
the iommu_attach_device() interface instead and only rely on
iommu_attach_group()? This way it is clear that a call changes the whole
group.

IIUC this work is heading towards allowing multiple domains in one group
as long as the group is owned by one entity. That is a valid
requirement, but the way to get there is in my eyes:

	1) Introduce a concept of a sub-group (or whatever we want to
	   call it), which groups devices together which must be in the
	   same domain because they use the same request ID and thus
	   look all the same to the IOMMU.

	2) Keep todays IOMMU groups to group devices together which can
	   bypass the IOMMU when talking to each other, like
	   multi-function devices and devices behind a no-ACS bridge.

	3) Rework group->domain and group->default_domain, eventually
	   moving them to sub-groups.

This is an important distinction to make and also the reason the
iommu_attach/detach_device() interface will always be misleading. Item
1) in this list will also be beneficial to other parts of the iommu
code, namely iommu-dma code which can have finer-grained DMA-API domains
with sub-groups instead of groups.

Regards,

	Joerg

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
