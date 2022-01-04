Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CA9C433F5
	for <iommu@archiver.kernel.org>; Tue,  4 Jan 2022 10:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 064F160B71;
	Tue,  4 Jan 2022 10:08:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G1CE0GP_1f-U; Tue,  4 Jan 2022 10:08:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BBB7860B0E;
	Tue,  4 Jan 2022 10:08:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9843FC002F;
	Tue,  4 Jan 2022 10:08:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9EA2C001E
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CABB540352
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=infradead.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9bXkedP_9FAd for <iommu@lists.linux-foundation.org>;
 Tue,  4 Jan 2022 10:08:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9EC0D402E7
 for <iommu@lists.linux-foundation.org>; Tue,  4 Jan 2022 10:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=CeJbcRxNatDqSOdUSkpsMyqknIzDwpPrhNR0CEO5Mq8=; b=m7Jy2ahpCJtNi/CxWcKT+8g2bW
 M/mvq/JPDSk4aKt3yvYyJRZG0BRhvNwzvsXh/MXyH2x93E6otKVA6SJ+cxzoi4eHH85S44DRDdhPC
 HzdbvbxYSB/7s3snhVQtPxXldOLnyjWzXgMlOOVI2L2DXq1VWGdt5UOyFhy7dKiI+F6Hfvm9WZMds
 QQgA+lL32KheVZ7FfZFHW7gursD0fzb5VP8DEvAMCynajQAHzCQFf3OZqZBEpTYekqKHScn0BoP2s
 LJfx104qTzGAHt3i9tcORQeQN3dRRqvV/uwx36zT6scluWeDr5r2Cf6kfridj1T2fBFSnku6V1HM9
 vV76sNVA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1n4gjY-00B65Z-Bp; Tue, 04 Jan 2022 10:08:00 +0000
Date: Tue, 4 Jan 2022 02:08:00 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 01/14] iommu: Add dma ownership management interfaces
Message-ID: <YdQcgFhIMYvUwABV@infradead.org>
References: <20220104015644.2294354-1-baolu.lu@linux.intel.com>
 <20220104015644.2294354-2-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220104015644.2294354-2-baolu.lu@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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

On Tue, Jan 04, 2022 at 09:56:31AM +0800, Lu Baolu wrote:
> Multiple devices may be placed in the same IOMMU group because they
> cannot be isolated from each other. These devices must either be
> entirely under kernel control or userspace control, never a mixture.
> 
> This adds dma ownership management in iommu core and exposes several
> interfaces for the device drivers and the device userspace assignment
> framework (i.e. vfio), so that any conflict between user and kernel
> controlled DMA could be detected at the beginning.
> 
> The device driver oriented interfaces are,
> 
> 	int iommu_device_use_dma_api(struct device *dev);
> 	void iommu_device_unuse_dma_api(struct device *dev);
> 
> Devices under kernel drivers control must call iommu_device_use_dma_api()
> before driver probes. The driver binding process must be aborted if it
> returns failure.
> 
> The vfio oriented interfaces are,
> 
> 	int iommu_group_set_dma_owner(struct iommu_group *group,
> 				      void *owner);
> 	void iommu_group_release_dma_owner(struct iommu_group *group);
> 	bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> 
> The device userspace assignment must be disallowed if the set dma owner
> interface returns failure.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  include/linux/iommu.h |  31 ++++++++
>  drivers/iommu/iommu.c | 161 +++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 189 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index de0c57a567c8..568f285468cf 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -682,6 +682,13 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  void iommu_sva_unbind_device(struct iommu_sva *handle);
>  u32 iommu_sva_get_pasid(struct iommu_sva *handle);
>  
> +int iommu_device_use_dma_api(struct device *dev);
> +void iommu_device_unuse_dma_api(struct device *dev);
> +
> +int iommu_group_set_dma_owner(struct iommu_group *group, void *owner);
> +void iommu_group_release_dma_owner(struct iommu_group *group);
> +bool iommu_group_dma_owner_claimed(struct iommu_group *group);
> +
>  #else /* CONFIG_IOMMU_API */
>  
>  struct iommu_ops {};
> @@ -1082,6 +1089,30 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>  {
>  	return NULL;
>  }
> +
> +static inline int iommu_device_use_dma_api(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static inline void iommu_device_unuse_dma_api(struct device *dev)
> +{
> +}
> +
> +static inline int
> +iommu_group_set_dma_owner(struct iommu_group *group, void *owner)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_group_release_dma_owner(struct iommu_group *group)
> +{
> +}
> +
> +static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_IOMMU_API */
>  
>  /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8b86406b7162..ff0c8c1ad5af 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -48,6 +48,8 @@ struct iommu_group {
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
> +	unsigned int owner_cnt;
> +	void *owner;
>  };
>  
>  struct group_device {
> @@ -289,7 +291,12 @@ int iommu_probe_device(struct device *dev)
>  	mutex_lock(&group->mutex);
>  	iommu_alloc_default_domain(group, dev);
>  
> -	if (group->default_domain) {
> +	/*
> +	 * If device joined an existing group which has been claimed
> +	 * for none kernel DMA purpose, avoid attaching the default
> +	 * domain.
> +	 */
> +	if (group->default_domain && !group->owner) {
>  		ret = __iommu_attach_device(group->default_domain, dev);
>  		if (ret) {
>  			mutex_unlock(&group->mutex);
> @@ -2320,7 +2327,7 @@ static int __iommu_attach_group(struct iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (group->default_domain && group->domain != group->default_domain)
> +	if (group->domain && group->domain != group->default_domain)
>  		return -EBUSY;
>  
>  	ret = __iommu_group_for_each_dev(group, domain,
> @@ -2357,7 +2364,11 @@ static void __iommu_detach_group(struct iommu_domain *domain,
>  {
>  	int ret;
>  
> -	if (!group->default_domain) {
> +	/*
> +	 * If group has been claimed for none kernel DMA purpose, avoid
> +	 * re-attaching the default domain.
> +	 */

none kernel reads odd.  But maybe drop that and just say 'claimed
already' ala:

	/*
	 * If the group has been claimed already, do not re-attach the default
	 * domain.
	 */
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
