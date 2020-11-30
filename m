Return-Path: <SRS0=awBX=FE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50359C63777
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 20:57:42 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE8A2074A
	for <iommu@archiver.kernel.org>; Mon, 30 Nov 2020 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4qTdxW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE8A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2DE0986CAC;
	Mon, 30 Nov 2020 20:57:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ij5JtC-eaQ32; Mon, 30 Nov 2020 20:57:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 559BB86CA1;
	Mon, 30 Nov 2020 20:57:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FC61C163C;
	Mon, 30 Nov 2020 20:57:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C1B4C0052
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 20:57:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id EEEC385EEF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 20:57:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id H8dsIOQhihZG for <iommu@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 20:57:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D70E385DE1
 for <iommu@lists.linux-foundation.org>; Mon, 30 Nov 2020 20:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606769856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cq1No4dPtLmGbI2mqBJ+VtaVWU0d8csbHMbJytzQmX0=;
 b=U4qTdxW9R2WIenKyHG3fA3rQwjgHR9DhF/lj6hdKGvqtiTrUYpjJSjDhgWKAiKD2yXwTis
 I2cMsuax1/gxZFQCpxcPp0YfB+RHI+YB6l6DvQVp2SucOoMYwFCIWbxXLbfKgYlOjoW2su
 mNfb1Cfz4hpNnkVBZ+eOMK/LM3VRnd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-Y7lpk6YDNsqnK6zdensHaA-1; Mon, 30 Nov 2020 15:57:29 -0500
X-MC-Unique: Y7lpk6YDNsqnK6zdensHaA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71B6E1005D59;
 Mon, 30 Nov 2020 20:57:27 +0000 (UTC)
Received: from w520.home (ovpn-112-10.phx2.redhat.com [10.3.112.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 656B219C71;
 Mon, 30 Nov 2020 20:57:26 +0000 (UTC)
Date: Mon, 30 Nov 2020 13:57:25 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v2 1/1] vfio/type1: Add vfio_group_domain()
Message-ID: <20201130135725.70fdf17f@w520.home>
In-Reply-To: <20201126012726.1185171-1-baolu.lu@linux.intel.com>
References: <20201126012726.1185171-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Will Deacon <will@kernel.org>, Cornelia Huck <cohuck@redhat.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Thu, 26 Nov 2020 09:27:26 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Add the API for getting the domain from a vfio group. This could be used
> by the physical device drivers which rely on the vfio/mdev framework for
> mediated device user level access. The typical use case like below:
> 
> 	unsigned int pasid;
> 	struct vfio_group *vfio_group;
> 	struct iommu_domain *iommu_domain;
> 	struct device *dev = mdev_dev(mdev);
> 	struct device *iommu_device = mdev_get_iommu_device(dev);
> 
> 	if (!iommu_device ||
> 	    !iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX))
> 		return -EINVAL;
> 
> 	vfio_group = vfio_group_get_external_user_from_dev(dev);(dev);
> 	if (IS_ERR_OR_NULL(vfio_group))
> 		return -EFAULT;
> 
> 	iommu_domain = vfio_group_domain(vfio_group);
> 	if (IS_ERR_OR_NULL(iommu_domain)) {
> 		vfio_group_put_external_user(vfio_group);
> 		return -EFAULT;
> 	}
> 
> 	pasid = iommu_aux_get_pasid(iommu_domain, iommu_device);
> 	if (pasid < 0) {
> 		vfio_group_put_external_user(vfio_group);
> 		return -EFAULT;
> 	}
> 
> 	/* Program device context with pasid value. */
> 	...
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio.c             | 18 ++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c | 23 +++++++++++++++++++++++
>  include/linux/vfio.h            |  3 +++
>  3 files changed, 44 insertions(+)
> 
> Change log:
>  - v1: https://lore.kernel.org/linux-iommu/20201112022407.2063896-1-baolu.lu@linux.intel.com/
>  - Changed according to comments @ https://lore.kernel.org/linux-iommu/20201116125631.2d043fcd@w520.home/
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 2151bc7f87ab..62c652111c88 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2331,6 +2331,24 @@ int vfio_unregister_notifier(struct device *dev, enum vfio_notify_type type,
>  }
>  EXPORT_SYMBOL(vfio_unregister_notifier);
>  
> +struct iommu_domain *vfio_group_domain(struct vfio_group *group)
> +{
> +	struct vfio_container *container;
> +	struct vfio_iommu_driver *driver;
> +
> +	if (!group)
> +		return ERR_PTR(-EINVAL);
> +
> +	container = group->container;
> +	driver = container->iommu_driver;
> +	if (likely(driver && driver->ops->group_domain))
> +		return driver->ops->group_domain(container->iommu_data,
> +						 group->iommu_group);
> +	else
> +		return ERR_PTR(-ENOTTY);
> +}
> +EXPORT_SYMBOL(vfio_group_domain);


_GPL?  I don't see that there's a way for a driver to get the
vfio_group pointer that's not already _GPL.


> +
>  /**
>   * Module/class support
>   */
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 67e827638995..783f18f21b95 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2980,6 +2980,28 @@ static int vfio_iommu_type1_dma_rw(void *iommu_data, dma_addr_t user_iova,
>  	return ret;
>  }
>  
> +static void *vfio_iommu_type1_group_domain(void *iommu_data,
> +					   struct iommu_group *iommu_group)
> +{
> +	struct vfio_iommu *iommu = iommu_data;
> +	struct iommu_domain *domain = NULL;
> +	struct vfio_domain *d;
> +
> +	if (!iommu || !iommu_group)
> +		return ERR_PTR(-EINVAL);
> +
> +	mutex_lock(&iommu->lock);
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (find_iommu_group(d, iommu_group)) {
> +			domain = d->domain;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&iommu->lock);
> +
> +	return domain;
> +}


Why does this return void* rather than struct iommu_domain*, and why
does the error case return an ERR_PTR but the not-found case returns
NULL?  Thanks,

Alex


> +
>  static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
>  	.name			= "vfio-iommu-type1",
>  	.owner			= THIS_MODULE,
> @@ -2993,6 +3015,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
>  	.register_notifier	= vfio_iommu_type1_register_notifier,
>  	.unregister_notifier	= vfio_iommu_type1_unregister_notifier,
>  	.dma_rw			= vfio_iommu_type1_dma_rw,
> +	.group_domain		= vfio_iommu_type1_group_domain,
>  };
>  
>  static int __init vfio_iommu_type1_init(void)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 38d3c6a8dc7e..a0613a6f21cc 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -90,6 +90,7 @@ struct vfio_iommu_driver_ops {
>  					       struct notifier_block *nb);
>  	int		(*dma_rw)(void *iommu_data, dma_addr_t user_iova,
>  				  void *data, size_t count, bool write);
> +	void		*(*group_domain)(void *iommu_data, struct iommu_group *group);
>  };
>  
>  extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> @@ -126,6 +127,8 @@ extern int vfio_group_unpin_pages(struct vfio_group *group,
>  extern int vfio_dma_rw(struct vfio_group *group, dma_addr_t user_iova,
>  		       void *data, size_t len, bool write);
>  
> +extern struct iommu_domain *vfio_group_domain(struct vfio_group *group);
> +
>  /* each type has independent events */
>  enum vfio_notify_type {
>  	VFIO_IOMMU_NOTIFY = 0,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
