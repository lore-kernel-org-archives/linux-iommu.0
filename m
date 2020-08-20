Return-Path: <SRS0=3GNe=B6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_WP_DIRINDEX
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB174C433E1
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:49:47 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 721162075E
	for <iommu@archiver.kernel.org>; Thu, 20 Aug 2020 21:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AcpSZlVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 721162075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 2D11D228E2;
	Thu, 20 Aug 2020 21:49:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T-Dail82u1zd; Thu, 20 Aug 2020 21:49:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 91818228A4;
	Thu, 20 Aug 2020 21:49:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7FD82C07FF;
	Thu, 20 Aug 2020 21:49:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A6351C0051
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:49:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7DCAE228BA
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:49:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id goy5gOQeeckc for <iommu@lists.linux-foundation.org>;
 Thu, 20 Aug 2020 21:49:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 0EF71228A4
 for <iommu@lists.linux-foundation.org>; Thu, 20 Aug 2020 21:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597960180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/SGQdOIGqJRv/JTZUfj1nigkzEJpxbggpHyJJW2C1s=;
 b=AcpSZlVVQR8dFOJomoVPFv1/1KJzxcYozqCaESz3YBh0AlKF1iRuuNRkLWcqfCMUImBCpn
 hPRz/NASoK/KV/vuBfZuVloggq3TC3HnYtCG2UDJno+IZWy2NoQvOv4EFmGDrP8MEziTqD
 jp7cPBDV6AVyUx00M40YlMRMKRhSZTo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-uzFfsYIJMcmgsgWzc7zHIQ-1; Thu, 20 Aug 2020 17:49:24 -0400
X-MC-Unique: uzFfsYIJMcmgsgWzc7zHIQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB9781015C9C;
 Thu, 20 Aug 2020 21:49:02 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9E5E7B90C;
 Thu, 20 Aug 2020 21:48:53 +0000 (UTC)
Date: Thu, 20 Aug 2020 15:48:53 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v6 12/15] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Message-ID: <20200820154853.21b660d2@x1.home>
In-Reply-To: <1595917664-33276-13-git-send-email-yi.l.liu@intel.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-13-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, stefanha@gmail.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com,
 jun.j.tian@intel.com
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

On Mon, 27 Jul 2020 23:27:41 -0700
Liu Yi L <yi.l.liu@intel.com> wrote:

> Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> is used to achieve flexible device sharing across domains (e.g. VMs).
> Also there are hardware assisted mediated pass-through solutions from
> platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain

Or a physical IOMMU backing device.

> concept, which means mdevs are protected by an iommu domain which is
> auxiliary to the domain that the kernel driver primarily uses for DMA
> API. Details can be found in the KVM presentation as below:
> 
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf

I think letting the line exceed 80 columns is preferable so that it's
clickable.  Thanks,

Alex

> This patch extends NESTING_IOMMU ops to IOMMU-backed mdev devices. The
> main requirement is to use the auxiliary domain associated with mdev.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> CC: Jun Tian <jun.j.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
> v5 -> v6:
> *) add review-by from Eric Auger.
> 
> v1 -> v2:
> *) check the iommu_device to ensure the handling mdev is IOMMU-backed
> ---
>  drivers/vfio/vfio_iommu_type1.c | 40 ++++++++++++++++++++++++++++++++++++----
>  1 file changed, 36 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index bf95a0f..9d8f252 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2379,20 +2379,41 @@ static int vfio_iommu_resv_refresh(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static struct device *vfio_get_iommu_device(struct vfio_group *group,
> +					    struct device *dev)
> +{
> +	if (group->mdev_group)
> +		return vfio_mdev_get_iommu_device(dev);
> +	else
> +		return dev;
> +}
> +
>  static int vfio_dev_bind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	return iommu_uapi_sva_bind_gpasid(dc->domain, dev, (void __user *)arg);
> +	return iommu_uapi_sva_bind_gpasid(dc->domain, iommu_device,
> +					  (void __user *)arg);
>  }
>  
>  static int vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
>  
> -	iommu_uapi_sva_unbind_gpasid(dc->domain, dev, (void __user *)arg);
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
> +
> +	iommu_uapi_sva_unbind_gpasid(dc->domain, iommu_device,
> +				     (void __user *)arg);
>  	return 0;
>  }
>  
> @@ -2401,8 +2422,13 @@ static int __vfio_dev_unbind_gpasid_fn(struct device *dev, void *data)
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	struct iommu_gpasid_bind_data *unbind_data =
>  				(struct iommu_gpasid_bind_data *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	iommu_sva_unbind_gpasid(dc->domain, dev, unbind_data);
> +	iommu_sva_unbind_gpasid(dc->domain, iommu_device, unbind_data);
>  	return 0;
>  }
>  
> @@ -3060,8 +3086,14 @@ static int vfio_dev_cache_invalidate_fn(struct device *dev, void *data)
>  {
>  	struct domain_capsule *dc = (struct domain_capsule *)data;
>  	unsigned long arg = *(unsigned long *)dc->data;
> +	struct device *iommu_device;
> +
> +	iommu_device = vfio_get_iommu_device(dc->group, dev);
> +	if (!iommu_device)
> +		return -EINVAL;
>  
> -	iommu_uapi_cache_invalidate(dc->domain, dev, (void __user *)arg);
> +	iommu_uapi_cache_invalidate(dc->domain, iommu_device,
> +				    (void __user *)arg);
>  	return 0;
>  }
>  

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
