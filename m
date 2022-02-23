Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E824C433F5
	for <iommu@archiver.kernel.org>; Wed, 23 Feb 2022 18:00:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C12A382983;
	Wed, 23 Feb 2022 18:00:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TBJQoNY-g6qf; Wed, 23 Feb 2022 18:00:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2CCE880F5C;
	Wed, 23 Feb 2022 18:00:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F76C001A;
	Wed, 23 Feb 2022 18:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E99DAC0011
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C452C82865
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:00:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UkVtfKhasYn5 for <iommu@lists.linux-foundation.org>;
 Wed, 23 Feb 2022 18:00:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id E0AC380F5C
 for <iommu@lists.linux-foundation.org>; Wed, 23 Feb 2022 18:00:17 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA723D6E;
 Wed, 23 Feb 2022 10:00:16 -0800 (PST)
Received: from [10.57.40.147] (unknown [10.57.40.147])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C7A5F3F70D;
 Wed, 23 Feb 2022 10:00:10 -0800 (PST)
Message-ID: <f830c268-daca-8e8f-a429-0c80496a7273@arm.com>
Date: Wed, 23 Feb 2022 18:00:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v6 01/11] iommu: Add dma ownership management interfaces
Content-Language: en-GB
To: Lu Baolu <baolu.lu@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson
 <alex.williamson@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>
References: <20220218005521.172832-1-baolu.lu@linux.intel.com>
 <20220218005521.172832-2-baolu.lu@linux.intel.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220218005521.172832-2-baolu.lu@linux.intel.com>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, kvm@vger.kernel.org,
 Stuart Yoder <stuyoder@gmail.com>, rafael@kernel.org,
 David Airlie <airlied@linux.ie>, linux-pci@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 Jonathan Hunter <jonathanh@nvidia.com>, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>,
 Jacob jun Pan <jacob.jun.pan@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 Diana Craciun <diana.craciun@oss.nxp.com>,
 Dan Williams <dan.j.williams@intel.com>, Li Yang <leoyang.li@nxp.com>,
 Will Deacon <will@kernel.org>, Dmitry Osipenko <digetx@gmail.com>
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

On 2022-02-18 00:55, Lu Baolu wrote:
[...]
> +/**
> + * iommu_group_claim_dma_owner() - Set DMA ownership of a group
> + * @group: The group.
> + * @owner: Caller specified pointer. Used for exclusive ownership.
> + *
> + * This is to support backward compatibility for vfio which manages
> + * the dma ownership in iommu_group level. New invocations on this
> + * interface should be prohibited.
> + */
> +int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner)
> +{
> +	int ret = 0;
> +
> +	mutex_lock(&group->mutex);
> +	if (group->owner_cnt) {

To clarify the comment buried in the other thread, I really think we 
should just unconditionally flag the error here...

> +		if (group->owner != owner) {
> +			ret = -EPERM;
> +			goto unlock_out;
> +		}
> +	} else {
> +		if (group->domain && group->domain != group->default_domain) {
> +			ret = -EBUSY;
> +			goto unlock_out;
> +		}
> +
> +		group->owner = owner;
> +		if (group->domain)
> +			__iommu_detach_group(group->domain, group);
> +	}
> +
> +	group->owner_cnt++;
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_claim_dma_owner);
> +
> +/**
> + * iommu_group_release_dma_owner() - Release DMA ownership of a group
> + * @group: The group.
> + *
> + * Release the DMA ownership claimed by iommu_group_claim_dma_owner().
> + */
> +void iommu_group_release_dma_owner(struct iommu_group *group)
> +{
> +	mutex_lock(&group->mutex);
> +	if (WARN_ON(!group->owner_cnt || !group->owner))
> +		goto unlock_out;
> +
> +	if (--group->owner_cnt > 0)
> +		goto unlock_out;

...and equivalently just set owner_cnt directly to 0 here. I don't see a 
realistic use-case for any driver to claim the same group more than 
once, and allowing it in the API just feels like opening up various 
potential corners for things to get out of sync.

I think that's the only significant concern I have left with the series 
as a whole - you can consider my other grumbles non-blocking :)

Thanks,
Robin.

> +
> +	/*
> +	 * The UNMANAGED domain should be detached before all USER
> +	 * owners have been released.
> +	 */
> +	if (!WARN_ON(group->domain) && group->default_domain)
> +		__iommu_attach_group(group->default_domain, group);
> +	group->owner = NULL;
> +
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_release_dma_owner);
> +
> +/**
> + * iommu_group_dma_owner_claimed() - Query group dma ownership status
> + * @group: The group.
> + *
> + * This provides status query on a given group. It is racey and only for
> + * non-binding status reporting.
> + */
> +bool iommu_group_dma_owner_claimed(struct iommu_group *group)
> +{
> +	unsigned int user;
> +
> +	mutex_lock(&group->mutex);
> +	user = group->owner_cnt;
> +	mutex_unlock(&group->mutex);
> +
> +	return user;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
