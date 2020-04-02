Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URI_WP_DIRINDEX autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B157C43331
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 20:34:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5700720678
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 20:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlGUyp1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5700720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1C28F207A8;
	Thu,  2 Apr 2020 20:34:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DpBC2D6FSm4E; Thu,  2 Apr 2020 20:34:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9072520774;
	Thu,  2 Apr 2020 20:34:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 77DF3C1D74;
	Thu,  2 Apr 2020 20:34:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0736CC07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:34:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F1F6C8908C
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:34:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ANc2EV6+Bzf4 for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 20:34:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5124D8908A
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585859661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ietQ1ekQOzxzT5ovszXdfNoG3WOzxptqDEC/u1Ud83U=;
 b=QlGUyp1gjDEO1DfoeUcevd+5vjKCAcbIhpN1jHUdrVdus8Sh4CeU+fdpM/R63GtWm8vq+B
 FXHK3VLXOr+1Gi130XF1M8VDvh8XQTyxsV/ntDD1kEExGDbvRmhGSI3YeAEKRfaN7hP5jS
 9j66ew2RZ0NSGTrL31KsLq+I7W/ruDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-DFSBZ6cTNdOUh55AKs7n4w-1; Thu, 02 Apr 2020 16:33:53 -0400
X-MC-Unique: DFSBZ6cTNdOUh55AKs7n4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D1381083EAA;
 Thu,  2 Apr 2020 20:33:51 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCF191147C6;
 Thu,  2 Apr 2020 20:33:42 +0000 (UTC)
Date: Thu, 2 Apr 2020 14:33:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed mdevs
Message-ID: <20200402143342.1e10c498@w520.home>
In-Reply-To: <1584880325-10561-9-git-send-email-yi.l.liu@intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-9-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: jean-philippe@linaro.org, kevin.tian@intel.com, ashok.raj@intel.com,
 kvm@vger.kernel.org, jun.j.tian@intel.com, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, yi.y.sun@intel.com, hao.wu@intel.com
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

On Sun, 22 Mar 2020 05:32:05 -0700
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Liu Yi L <yi.l.liu@intel.com>
> 
> Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> are used to achieve flexible device sharing across domains (e.g. VMs).
> Also there are hardware assisted mediated pass-through solutions from
> platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> concept, which means mdevs are protected by an iommu domain which is
> aux-domain of its physical device. Details can be found in the KVM
> presentation from Kevin Tian. IOMMU-backed equals to IOMMU-capable.
> 
> https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> 
> This patch supports NESTING IOMMU for IOMMU-backed mdevs by figuring
> out the physical device of an IOMMU-backed mdev and then invoking IOMMU
> requests to IOMMU layer with the physical device and the mdev's aux
> domain info.
> 
> With this patch, vSVA (Virtual Shared Virtual Addressing) can be used
> on IOMMU-backed mdevs.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> CC: Jun Tian <jun.j.tian@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 937ec3f..d473665 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -132,6 +132,7 @@ struct vfio_regions {
>  
>  struct domain_capsule {
>  	struct iommu_domain *domain;
> +	struct vfio_group *group;
>  	void *data;
>  };
>  
> @@ -148,6 +149,7 @@ static int vfio_iommu_for_each_dev(struct vfio_iommu *iommu,
>  	list_for_each_entry(d, &iommu->domain_list, next) {
>  		dc.domain = d->domain;
>  		list_for_each_entry(g, &d->group_list, next) {
> +			dc.group = g;
>  			ret = iommu_group_for_each_dev(g->iommu_group,
>  						       &dc, fn);
>  			if (ret)
> @@ -2347,7 +2349,12 @@ static int vfio_bind_gpasid_fn(struct device *dev, void *data)
>  	struct iommu_gpasid_bind_data *gbind_data =
>  		(struct iommu_gpasid_bind_data *) dc->data;
>  
> -	return iommu_sva_bind_gpasid(dc->domain, dev, gbind_data);
> +	if (dc->group->mdev_group)
> +		return iommu_sva_bind_gpasid(dc->domain,
> +			vfio_mdev_get_iommu_device(dev), gbind_data);

But we can't assume an mdev device is iommu backed, so this can call
with NULL dev, which appears will pretty quickly segfault
intel_svm_bind_gpasid.

> +	else
> +		return iommu_sva_bind_gpasid(dc->domain,
> +						dev, gbind_data);
>  }
>  
>  static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> @@ -2356,8 +2363,13 @@ static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
>  	struct iommu_gpasid_bind_data *gbind_data =
>  		(struct iommu_gpasid_bind_data *) dc->data;
>  
> -	return iommu_sva_unbind_gpasid(dc->domain, dev,
> +	if (dc->group->mdev_group)
> +		return iommu_sva_unbind_gpasid(dc->domain,
> +					vfio_mdev_get_iommu_device(dev),
>  					gbind_data->hpasid);

Same

> +	else
> +		return iommu_sva_unbind_gpasid(dc->domain, dev,
> +						gbind_data->hpasid);
>  }
>  
>  /**
> @@ -2429,7 +2441,12 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
>  	struct iommu_cache_invalidate_info *cache_inv_info =
>  		(struct iommu_cache_invalidate_info *) dc->data;
>  
> -	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
> +	if (dc->group->mdev_group)
> +		return iommu_cache_invalidate(dc->domain,
> +			vfio_mdev_get_iommu_device(dev), cache_inv_info);

And again

> +	else
> +		return iommu_cache_invalidate(dc->domain,
> +						dev, cache_inv_info);
>  }
>  
>  static long vfio_iommu_type1_ioctl(void *iommu_data,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
