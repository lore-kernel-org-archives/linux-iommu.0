Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5F6C2BA12
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 20:24:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428EC2078B
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 20:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="botOPEzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428EC2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BE9E874F7;
	Thu,  2 Apr 2020 20:24:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPvzB9tz-vhV; Thu,  2 Apr 2020 20:24:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 56BD68749C;
	Thu,  2 Apr 2020 20:24:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4CFC4C1D74;
	Thu,  2 Apr 2020 20:24:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4143C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:24:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D2B5B88D55
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:24:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HcHv1WdGIi+Z for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 20:24:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 07C8F88CC9
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 20:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585859078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=INka0vkxaweJDZ2c3Aa3hlqHFo9UCqLbH2gd4kVK5zY=;
 b=botOPEzopVWrGIZQ16k7FDRD4Uk1rV+mXBR/purkipVzLbGZaGo9wCC9kVNz2whDo13eXo
 Wb2m7tiPdHxWX5Y98/6klwi1whEFngjYc7yAxdODpYKwCP9uWxWHt3fXcxJBFB78ll0k3N
 70wkyBAhWVVziyYckEHhhCYg4ph0ydo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-Bx5KEEKZNgCjKxiXu1j8Eg-1; Thu, 02 Apr 2020 16:24:37 -0400
X-MC-Unique: Bx5KEEKZNgCjKxiXu1j8Eg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43DE51005509;
 Thu,  2 Apr 2020 20:24:35 +0000 (UTC)
Received: from w520.home (ovpn-112-162.phx2.redhat.com [10.3.112.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 898A5DA0F2;
 Thu,  2 Apr 2020 20:24:28 +0000 (UTC)
Date: Thu, 2 Apr 2020 14:24:28 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Message-ID: <20200402142428.2901432e@w520.home>
In-Reply-To: <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
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

On Sun, 22 Mar 2020 05:32:04 -0700
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: Liu Yi L <yi.l.liu@linux.intel.com>
> 
> For VFIO IOMMUs with the type VFIO_TYPE1_NESTING_IOMMU, guest "owns" the
> first-level/stage-1 translation structures, the host IOMMU driver has no
> knowledge of first-level/stage-1 structure cache updates unless the guest
> invalidation requests are trapped and propagated to the host.
> 
> This patch adds a new IOCTL VFIO_IOMMU_CACHE_INVALIDATE to propagate guest
> first-level/stage-1 IOMMU cache invalidations to host to ensure IOMMU cache
> correctness.
> 
> With this patch, vSVA (Virtual Shared Virtual Addressing) can be used safely
> as the host IOMMU iotlb correctness are ensured.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@linux.intel.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 49 +++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       | 22 ++++++++++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index a877747..937ec3f 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2423,6 +2423,15 @@ static long vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
>  	return ret;
>  }
>  
> +static int vfio_cache_inv_fn(struct device *dev, void *data)
> +{
> +	struct domain_capsule *dc = (struct domain_capsule *)data;
> +	struct iommu_cache_invalidate_info *cache_inv_info =
> +		(struct iommu_cache_invalidate_info *) dc->data;
> +
> +	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2629,6 +2638,46 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  		}
>  		kfree(gbind_data);
>  		return ret;
> +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> +		struct vfio_iommu_type1_cache_invalidate cache_inv;
> +		u32 version;
> +		int info_size;
> +		void *cache_info;
> +		int ret;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_cache_invalidate,
> +				    flags);

This breaks backward compatibility as soon as struct
iommu_cache_invalidate_info changes size by its defined versioning
scheme.  ie. a field gets added, the version is bumped, all existing
userspace breaks.  Our minsz is offsetofend to the version field,
interpret the version to size, then reevaluate argsz.

> +
> +		if (copy_from_user(&cache_inv, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (cache_inv.argsz < minsz || cache_inv.flags)
> +			return -EINVAL;
> +
> +		/* Get the version of struct iommu_cache_invalidate_info */
> +		if (copy_from_user(&version,
> +			(void __user *) (arg + minsz), sizeof(version)))
> +			return -EFAULT;
> +
> +		info_size = iommu_uapi_get_data_size(
> +					IOMMU_UAPI_CACHE_INVAL, version);
> +
> +		cache_info = kzalloc(info_size, GFP_KERNEL);
> +		if (!cache_info)
> +			return -ENOMEM;
> +
> +		if (copy_from_user(cache_info,
> +			(void __user *) (arg + minsz), info_size)) {
> +			kfree(cache_info);
> +			return -EFAULT;
> +		}
> +
> +		mutex_lock(&iommu->lock);
> +		ret = vfio_iommu_for_each_dev(iommu, vfio_cache_inv_fn,
> +					    cache_info);

How does a user respond when their cache invalidate fails?  Isn't this
also another case where our for_each_dev can fail at an arbitrary point
leaving us with no idea whether each device even had the opportunity to
perform the invalidation request.  I don't see how we have any chance
to maintain coherency after this faults.

> +		mutex_unlock(&iommu->lock);
> +		kfree(cache_info);
> +		return ret;
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index 2235bc6..62ca791 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -899,6 +899,28 @@ struct vfio_iommu_type1_bind {
>   */
>  #define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 23)
>  
> +/**
> + * VFIO_IOMMU_CACHE_INVALIDATE - _IOW(VFIO_TYPE, VFIO_BASE + 24,
> + *			struct vfio_iommu_type1_cache_invalidate)
> + *
> + * Propagate guest IOMMU cache invalidation to the host. The cache
> + * invalidation information is conveyed by @cache_info, the content
> + * format would be structures defined in uapi/linux/iommu.h. User
> + * should be aware of that the struct  iommu_cache_invalidate_info
> + * has a @version field, vfio needs to parse this field before getting
> + * data from userspace.
> + *
> + * Availability of this IOCTL is after VFIO_SET_IOMMU.

Is this a necessary qualifier?  A user can try to call this ioctl at
any point, it only makes sense in certain configurations, but it should
always "do the right thing" relative to the container iommu config.

Also, I don't see anything in these last few patches testing the
operating IOMMU model, what happens when a user calls them when not
using the nesting IOMMU?

Is this ioctl and the previous BIND ioctl only valid when configured
for the nesting IOMMU type?

> + *
> + * returns: 0 on success, -errno on failure.
> + */
> +struct vfio_iommu_type1_cache_invalidate {
> +	__u32   argsz;
> +	__u32   flags;
> +	struct	iommu_cache_invalidate_info cache_info;
> +};
> +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)

The future extension capabilities of this ioctl worry me, I wonder if
we should do another data[] with flag defining that data as CACHE_INFO.

> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
