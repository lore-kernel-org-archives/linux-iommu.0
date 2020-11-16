Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A0FC55ABD
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:56:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F37520829
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 19:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDE9to1s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F37520829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E441F87052;
	Mon, 16 Nov 2020 19:56:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F5nSohwdUydZ; Mon, 16 Nov 2020 19:56:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2CF2D86FA1;
	Mon, 16 Nov 2020 19:56:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E7480C0891;
	Mon, 16 Nov 2020 19:56:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93447C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7AEC987049
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:56:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFGbCybXfGgS for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 19:56:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 62D4186FA1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 19:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605556597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0bA4pw5q7HHQg8TpZjusnVos/EyOd9oFFb9XD9wHdZQ=;
 b=dDE9to1siFCi4UoOIT9a5mHll6oq0GuEheiyMclmUXE+jixnwpSVkH5W3yh3u5xx2EGfBS
 hoQNTdAnqSU6PUbGyYUSL3zxCON2K07npaYZNSiwDS2e++0ibeV6pQsjqxyoRW+Uw5Y9No
 MPwusWNtW0E1bSN39uAfJmO6mevWWg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-5Rg_nuSINhuae9dCIcPnLw-1; Mon, 16 Nov 2020 14:56:35 -0500
X-MC-Unique: 5Rg_nuSINhuae9dCIcPnLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18B43802B6D;
 Mon, 16 Nov 2020 19:56:33 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3514819C66;
 Mon, 16 Nov 2020 19:56:32 +0000 (UTC)
Date: Mon, 16 Nov 2020 12:56:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 1/1] vfio/type1: Add subdev_ioasid callback to
 vfio_iommu_driver_ops
Message-ID: <20201116125631.2d043fcd@w520.home>
In-Reply-To: <20201112022407.2063896-1-baolu.lu@linux.intel.com>
References: <20201112022407.2063896-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, kvm@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Robin Murphy <robin.murphy@arm.com>
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

On Thu, 12 Nov 2020 10:24:07 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Add API for getting the ioasid of a subdevice (vfio/mdev). This calls
> into the backend IOMMU module to get the actual value or error number
> if ioasid for subdevice is not supported. The physical device driver
> implementations which rely on the vfio/mdev framework for mediated
> device user level access could typically consume this interface like
> below:
> 
> 	struct device *dev = mdev_dev(mdev);
> 	unsigned int pasid;
> 	int ret;
> 
> 	ret = vfio_subdev_ioasid(dev, &pasid);
> 	if (ret < 0)
> 		return ret;
> 
>          /* Program device context with pasid value. */
>          ....


Seems like an overly specific callback.  We already export means for
you to get a vfio_group, test that a device is an mdev, and get the
iommu device from an mdev.  So you can already test whether a given
device is an mdev with an iommu backing device that supports aux
domains.  The only missing piece seems to be that you can't get the
domain for a group in order to retrieve the pasid.  So why aren't we
exporting a callback that given a vfio_group provides the iommu domain?
Thanks,

Alex

> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/vfio/vfio.c             | 34 ++++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c | 57 +++++++++++++++++++++++++++++++++
>  include/linux/vfio.h            |  4 +++
>  3 files changed, 95 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 2151bc7f87ab..4931e1492921 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2331,6 +2331,40 @@ int vfio_unregister_notifier(struct device *dev, enum vfio_notify_type type,
>  }
>  EXPORT_SYMBOL(vfio_unregister_notifier);
>  
> +int vfio_subdev_ioasid(struct device *dev, unsigned int *id)
> +{
> +	struct vfio_container *container;
> +	struct vfio_iommu_driver *driver;
> +	struct vfio_group *group;
> +	int ret;
> +
> +	if (!dev || !id)
> +		return -EINVAL;
> +
> +	group = vfio_group_get_from_dev(dev);
> +	if (!group)
> +		return -ENODEV;
> +
> +	ret = vfio_group_add_container_user(group);
> +	if (ret)
> +		goto out;
> +
> +	container = group->container;
> +	driver = container->iommu_driver;
> +	if (likely(driver && driver->ops->subdev_ioasid))
> +		ret = driver->ops->subdev_ioasid(container->iommu_data,
> +						 group->iommu_group, id);
> +	else
> +		ret = -ENOTTY;
> +
> +	vfio_group_try_dissolve_container(group);
> +
> +out:
> +	vfio_group_put(group);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vfio_subdev_ioasid);
> +
>  /**
>   * Module/class support
>   */
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 67e827638995..f94cc7707d7e 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2980,6 +2980,62 @@ static int vfio_iommu_type1_dma_rw(void *iommu_data, dma_addr_t user_iova,
>  	return ret;
>  }
>  
> +static int vfio_iommu_type1_subdev_ioasid(void *iommu_data,
> +					  struct iommu_group *iommu_group,
> +					  unsigned int *id)
> +{
> +	struct vfio_iommu *iommu = iommu_data;
> +	struct vfio_domain *domain = NULL, *d;
> +	struct device *iommu_device = NULL;
> +	struct bus_type *bus = NULL;
> +	int ret;
> +
> +	if (!iommu || !iommu_group || !id)
> +		return -EINVAL;
> +
> +	mutex_lock(&iommu->lock);
> +	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
> +	if (ret)
> +		goto out;
> +
> +	if (!vfio_bus_is_mdev(bus)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = iommu_group_for_each_dev(iommu_group, &iommu_device,
> +				       vfio_mdev_iommu_device);
> +	if (ret || !iommu_device ||
> +	    !iommu_dev_feature_enabled(iommu_device, IOMMU_DEV_FEAT_AUX)) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		if (find_iommu_group(d, iommu_group)) {
> +			domain = d;
> +			break;
> +		}
> +	}
> +
> +	if (!domain) {
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	ret = iommu_aux_get_pasid(domain->domain, iommu_device);
> +	if (ret > 0) {
> +		*id = ret;
> +		ret = 0;
> +	} else {
> +		ret = -ENOSPC;
> +	}
> +
> +out:
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
>  	.name			= "vfio-iommu-type1",
>  	.owner			= THIS_MODULE,
> @@ -2993,6 +3049,7 @@ static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
>  	.register_notifier	= vfio_iommu_type1_register_notifier,
>  	.unregister_notifier	= vfio_iommu_type1_unregister_notifier,
>  	.dma_rw			= vfio_iommu_type1_dma_rw,
> +	.subdev_ioasid		= vfio_iommu_type1_subdev_ioasid,
>  };
>  
>  static int __init vfio_iommu_type1_init(void)
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 38d3c6a8dc7e..6dcf09a2796d 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -90,6 +90,9 @@ struct vfio_iommu_driver_ops {
>  					       struct notifier_block *nb);
>  	int		(*dma_rw)(void *iommu_data, dma_addr_t user_iova,
>  				  void *data, size_t count, bool write);
> +	int		(*subdev_ioasid)(void *iommu_data,
> +					 struct iommu_group *group,
> +					 unsigned int *id);
>  };
>  
>  extern int vfio_register_iommu_driver(const struct vfio_iommu_driver_ops *ops);
> @@ -125,6 +128,7 @@ extern int vfio_group_unpin_pages(struct vfio_group *group,
>  
>  extern int vfio_dma_rw(struct vfio_group *group, dma_addr_t user_iova,
>  		       void *data, size_t len, bool write);
> +extern int vfio_subdev_ioasid(struct device *dev, unsigned int *id);
>  
>  /* each type has independent events */
>  enum vfio_notify_type {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
