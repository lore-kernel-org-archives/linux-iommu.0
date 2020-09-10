Return-Path: <SRS0=7VEr=CT=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1EFC43461
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:06:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D0C20BED
	for <iommu@archiver.kernel.org>; Thu, 10 Sep 2020 22:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D3fgLNra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D0C20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 93A8D87736;
	Thu, 10 Sep 2020 22:06:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m+w4N5ii0UOz; Thu, 10 Sep 2020 22:06:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C29CD87735;
	Thu, 10 Sep 2020 22:06:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3B9EC0052;
	Thu, 10 Sep 2020 22:06:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4CC9BC0051
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3AA728778C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k27B8NmEWvqR for <iommu@lists.linux-foundation.org>;
 Thu, 10 Sep 2020 22:06:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D841D8778D
 for <iommu@lists.linux-foundation.org>; Thu, 10 Sep 2020 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599775561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RnbUoGq7xwlkckcej6HmOURWq1SLDS1pk1FaTeyjhKo=;
 b=D3fgLNragIKoJhgUySfTj73gQtOvd7Gu1nVjSpz/88bRbCiYJ+0PWV+ryQzMiUoQkEtnjr
 au+GyioVAN6+G5u92k3shhYuuemJ4ii3bhjWnVZ2dGlHOLlXFGC1myZoQmuxDs1eHS+SsU
 P2ZDMSHPXqJ209EB9sWgVsv5WE0Q9kw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-xtVDWkvJNJqf0IYWvWalPg-1; Thu, 10 Sep 2020 18:05:57 -0400
X-MC-Unique: xtVDWkvJNJqf0IYWvWalPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4123C1084CA2;
 Thu, 10 Sep 2020 22:05:49 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 02B537512B;
 Thu, 10 Sep 2020 22:05:47 +0000 (UTC)
Date: Thu, 10 Sep 2020 16:05:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/5] iommu: Add iommu_at(de)tach_subdev_group()
Message-ID: <20200910160547.0a8b9891@w520.home>
In-Reply-To: <20200901033422.22249-3-baolu.lu@linux.intel.com>
References: <20200901033422.22249-1-baolu.lu@linux.intel.com>
 <20200901033422.22249-3-baolu.lu@linux.intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

On Tue,  1 Sep 2020 11:34:19 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This adds two new APIs for the use cases like vfio/mdev where subdevices
> derived from physical devices are created and put in an iommu_group. The
> new IOMMU API interfaces mimic the vfio_mdev_at(de)tach_domain() directly,
> testing whether the resulting device supports IOMMU_DEV_FEAT_AUX and using
> an aux vs non-aux at(de)tach.
> 
> By doing this we could
> 
> - Set the iommu_group.domain. The iommu_group.domain is private to iommu
>   core (therefore vfio code cannot set it), but we need it set in order
>   for iommu_get_domain_for_dev() to work with a group attached to an aux
>   domain.
> 
> - Prefer to use the _attach_group() interfaces while the _attach_device()
>   interfaces are relegated to special cases.
> 
> Link: https://lore.kernel.org/linux-iommu/20200730134658.44c57a67@x1.home/
> Link: https://lore.kernel.org/linux-iommu/20200730151703.5daf8ad4@x1.home/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 136 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/iommu.h |  20 +++++++
>  2 files changed, 156 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 38cdfeb887e1..fb21c2ff4861 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2757,6 +2757,142 @@ int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_aux_get_pasid);
>  
> +static int __iommu_aux_attach_device(struct iommu_domain *domain,
> +				     struct device *phys_dev,
> +				     struct device *sub_dev)
> +{
> +	int ret;
> +
> +	if (unlikely(!domain->ops->aux_attach_dev))
> +		return -ENODEV;
> +
> +	ret = domain->ops->aux_attach_dev(domain, phys_dev, sub_dev);
> +	if (!ret)
> +		trace_attach_device_to_domain(sub_dev);
> +
> +	return ret;
> +}
> +
> +static void __iommu_aux_detach_device(struct iommu_domain *domain,
> +				      struct device *phys_dev,
> +				      struct device *sub_dev)
> +{
> +	if (unlikely(!domain->ops->aux_detach_dev))
> +		return;
> +
> +	domain->ops->aux_detach_dev(domain, phys_dev, sub_dev);
> +	trace_detach_device_from_domain(sub_dev);
> +}
> +
> +static int __iommu_attach_subdev_group(struct iommu_domain *domain,
> +				       struct iommu_group *group,
> +				       iommu_device_lookup_t fn)
> +{
> +	struct group_device *device;
> +	struct device *phys_dev;
> +	int ret = -ENODEV;
> +
> +	list_for_each_entry(device, &group->devices, list) {
> +		phys_dev = fn(device->dev);
> +		if (!phys_dev) {
> +			ret = -ENODEV;
> +			break;
> +		}
> +
> +		if (iommu_dev_feature_enabled(phys_dev, IOMMU_DEV_FEAT_AUX))
> +			ret = __iommu_aux_attach_device(domain, phys_dev,
> +							device->dev);
> +		else
> +			ret = __iommu_attach_device(domain, phys_dev);
> +
> +		if (ret)
> +			break;
> +	}
> +
> +	return ret;
> +}
> +
> +static void __iommu_detach_subdev_group(struct iommu_domain *domain,
> +					struct iommu_group *group,
> +					iommu_device_lookup_t fn)
> +{
> +	struct group_device *device;
> +	struct device *phys_dev;
> +
> +	list_for_each_entry(device, &group->devices, list) {
> +		phys_dev = fn(device->dev);
> +		if (!phys_dev)
> +			break;


Seems like this should be a continue rather than a break.  On the
unwind path maybe we're relying on holding the group mutex and
deterministic behavior from the fn() callback to unwind to the same
point, but we still have an entirely separate detach interface and I'm
not sure we couldn't end up with an inconsistent state if we don't
iterate each group device here.  Thanks,

Alex

> +
> +		if (iommu_dev_feature_enabled(phys_dev, IOMMU_DEV_FEAT_AUX))
> +			__iommu_aux_detach_device(domain, phys_dev, device->dev);
> +		else
> +			__iommu_detach_device(domain, phys_dev);
> +	}
> +}
> +
> +/**
> + * iommu_attach_subdev_group - attach domain to an iommu_group which
> + *			       contains subdevices.
> + *
> + * @domain: domain
> + * @group:  iommu_group which contains subdevices
> + * @fn:     callback for each subdevice in the @iommu_group to retrieve the
> + *          physical device where the subdevice was created from.
> + *
> + * Returns 0 on success, or an error value.
> + */
> +int iommu_attach_subdev_group(struct iommu_domain *domain,
> +			      struct iommu_group *group,
> +			      iommu_device_lookup_t fn)
> +{
> +	int ret = -ENODEV;
> +
> +	mutex_lock(&group->mutex);
> +	if (group->domain) {
> +		ret = -EBUSY;
> +		goto unlock_out;
> +	}
> +
> +	ret = __iommu_attach_subdev_group(domain, group, fn);
> +	if (ret)
> +		__iommu_detach_subdev_group(domain, group, fn);
> +	else
> +		group->domain = domain;
> +
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_attach_subdev_group);
> +
> +/**
> + * iommu_detach_subdev_group - detach domain from an iommu_group which
> + *			       contains subdevices
> + *
> + * @domain: domain
> + * @group:  iommu_group which contains subdevices
> + * @fn:     callback for each subdevice in the @iommu_group to retrieve the
> + *          physical device where the subdevice was created from.
> + *
> + * The domain must have been attached to @group via iommu_attach_subdev_group().
> + */
> +void iommu_detach_subdev_group(struct iommu_domain *domain,
> +			       struct iommu_group *group,
> +			       iommu_device_lookup_t fn)
> +{
> +	mutex_lock(&group->mutex);
> +	if (!group->domain)
> +		goto unlock_out;
> +
> +	__iommu_detach_subdev_group(domain, group, fn);
> +	group->domain = NULL;
> +
> +unlock_out:
> +	mutex_unlock(&group->mutex);
> +}
> +EXPORT_SYMBOL_GPL(iommu_detach_subdev_group);
> +
>  /**
>   * iommu_sva_bind_device() - Bind a process address space to a device
>   * @dev: the device
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 871267104915..b9df8b510d4f 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -48,6 +48,7 @@ struct iommu_fault_event;
>  typedef int (*iommu_fault_handler_t)(struct iommu_domain *,
>  			struct device *, unsigned long, int, void *);
>  typedef int (*iommu_dev_fault_handler_t)(struct iommu_fault *, void *);
> +typedef struct device *(*iommu_device_lookup_t)(struct device *);
>  
>  struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped    */
> @@ -631,6 +632,12 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>  int iommu_aux_attach_device(struct iommu_domain *domain, struct device *dev);
>  void iommu_aux_detach_device(struct iommu_domain *domain, struct device *dev);
>  int iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev);
> +int iommu_attach_subdev_group(struct iommu_domain *domain,
> +			      struct iommu_group *group,
> +			      iommu_device_lookup_t fn);
> +void iommu_detach_subdev_group(struct iommu_domain *domain,
> +			       struct iommu_group *group,
> +			       iommu_device_lookup_t fn);
>  
>  struct iommu_sva *iommu_sva_bind_device(struct device *dev,
>  					struct mm_struct *mm,
> @@ -1019,6 +1026,19 @@ iommu_aux_get_pasid(struct iommu_domain *domain, struct device *dev)
>  	return -ENODEV;
>  }
>  
> +static inline int
> +iommu_attach_subdev_group(struct iommu_domain *domain, struct iommu_group *group,
> +			  iommu_device_lookup_t fn)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void
> +iommu_detach_subdev_group(struct iommu_domain *domain, struct iommu_group *group,
> +			  iommu_device_lookup_t fn)
> +{
> +}
> +
>  static inline struct iommu_sva *
>  iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
>  {

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
