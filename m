Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D729C433EF
	for <iommu@archiver.kernel.org>; Wed, 15 Jun 2022 09:53:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B15CB831A7;
	Wed, 15 Jun 2022 09:53:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nh8oDFHtO7Qo; Wed, 15 Jun 2022 09:53:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6EC5982DDE;
	Wed, 15 Jun 2022 09:53:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3122EC0039;
	Wed, 15 Jun 2022 09:53:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3A51C002D
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 09:53:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C4C4B606C0
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 09:53:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xj0_QTK6kDFK for <iommu@lists.linux-foundation.org>;
 Wed, 15 Jun 2022 09:53:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88B45605D8
 for <iommu@lists.linux-foundation.org>; Wed, 15 Jun 2022 09:53:25 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B68F7152B;
 Wed, 15 Jun 2022 02:53:24 -0700 (PDT)
Received: from [10.57.7.82] (unknown [10.57.7.82])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD563F792;
 Wed, 15 Jun 2022 02:53:23 -0700 (PDT)
Message-ID: <10eaa3b1-4cf7-a7b6-a7f6-111a486a343a@arm.com>
Date: Wed, 15 Jun 2022 10:53:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
From: Steven Price <steven.price@arm.com>
Subject: Re: [RESEND PATCH v8 01/11] iommu: Add DMA ownership management
 interfaces
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220418005000.897664-2-baolu.lu@linux.intel.com>
Content-Language: en-GB
In-Reply-To: <20220418005000.897664-2-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Jason Gunthorpe <jgg@nvidia.com>,
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

On 18/04/2022 01:49, Lu Baolu wrote:
> Multiple devices may be placed in the same IOMMU group because they
> cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture.
> 
> This adds dma ownership management in iommu core and exposes several
> interfaces for the device drivers and the device userspace assignment
> framework (i.e. VFIO), so that any conflict between user and kernel
> controlled dma could be detected at the beginning.
> 
> The device driver oriented interfaces are,
> 
> 	int iommu_device_use_default_domain(struct device *dev);
> 	void iommu_device_unuse_default_domain(struct device *dev);
> 
> By calling iommu_device_use_default_domain(), the device driver tells
> the iommu layer that the device dma is handled through the kernel DMA
> APIs. The iommu layer will manage the IOVA and use the default domain
> for DMA address translation.
> 
> The device user-space assignment framework oriented interfaces are,
> 
> 	int iommu_group_claim_dma_owner(struct iommu_group *group,
> 					void *owner);
> 	void iommu_group_release_dma_owner(struct iommu_group *group);
> 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> 
> The device userspace assignment must be disallowed if the DMA owner
> claiming interface returns failure.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

I'm seeing a regression that I've bisected to this commit on a Firefly
RK3288 board. The display driver fails to probe properly because
__iommu_attach_group() returns -EBUSY. This causes long hangs and splats
as the display flips timeout.

The call stack to __iommu_attach_group() is:

 __iommu_attach_group from iommu_attach_device+0x64/0xb4
 iommu_attach_device from rockchip_drm_dma_attach_device+0x20/0x50
 rockchip_drm_dma_attach_device from vop_crtc_atomic_enable+0x10c/0xa64
 vop_crtc_atomic_enable from drm_atomic_helper_commit_modeset_enables+0xa8/0x290
 drm_atomic_helper_commit_modeset_enables from drm_atomic_helper_commit_tail_rpm+0x44/0x8c
 drm_atomic_helper_commit_tail_rpm from commit_tail+0x9c/0x180
 commit_tail from drm_atomic_helper_commit+0x164/0x18c
 drm_atomic_helper_commit from drm_atomic_commit+0xac/0xe4
 drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x284
 drm_client_modeset_commit_atomic from drm_client_modeset_commit_locked+0x60/0x1c8
 drm_client_modeset_commit_locked from drm_client_modeset_commit+0x24/0x40
 drm_client_modeset_commit from drm_fb_helper_set_par+0xb8/0xf8
 drm_fb_helper_set_par from drm_fb_helper_hotplug_event.part.0+0xa8/0xc0
 drm_fb_helper_hotplug_event.part.0 from output_poll_execute+0xb8/0x224

> @@ -2109,7 +2115,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (group->default_domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain)
>  		return -EBUSY;
>  
>  	ret = __iommu_group_for_each_dev(group, domain,

Reverting this 'fixes' the problem for me. The follow up 0286300e6045
("iommu: iommu_group_claim_dma_owner() must always assign a domain")
doesn't help.

Adding some debug printks I can see that domain is a valid pointer, but
both default_domain and blocking_domain are NULL.

I'm using the DTB from the kernel tree (rk3288-firefly.dtb).

Any ideas?

Thanks,

Steve
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
