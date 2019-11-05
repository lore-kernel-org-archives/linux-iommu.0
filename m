Return-Path: <SRS0=ZmA0=Y5=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 392A8C5DF60
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 23:35:55 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38DC21929
	for <iommu@archiver.kernel.org>; Tue,  5 Nov 2019 23:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVXLrvf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38DC21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id AC5B0DD4;
	Tue,  5 Nov 2019 23:35:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id F3296DB2
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 23:35:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-2.mimecast.com [205.139.110.61])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 3F5EE27B
	for <iommu@lists.linux-foundation.org>;
	Tue,  5 Nov 2019 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1572996952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	content-transfer-encoding:content-transfer-encoding:
	in-reply-to:in-reply-to:references:references;
	bh=czdzSvV3k1c+hHQwlkGWN41Rge6L8DF10GFMATNbkS8=;
	b=GVXLrvf/XGM+WZSY9wdXscs6XAIeKRrO9tkTjsIn3tAAtfWIvyei4qJ5XK55eo6Yi/VBBy
	/8QXrcdYlN/dDVss1WLBhVb4mLA1Jmo1EWBsaf1+x9Q4tCtJqkHedFYb+V1NeoXvZJDtzf
	knCQkH1ar849rmjdqUtOxdBAngq01D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
	[209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
	us-mta-430-DPhczA-8O0CgFmaXYaOmVg-1; Tue, 05 Nov 2019 18:35:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09E02477;
	Tue,  5 Nov 2019 23:35:47 +0000 (UTC)
Received: from x1.home (ovpn-116-110.phx2.redhat.com [10.3.116.110])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 305AD608AC;
	Tue,  5 Nov 2019 23:35:38 +0000 (UTC)
Date: Tue, 5 Nov 2019 16:35:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [RFC v2 2/3] vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20191105163537.1935291c@x1.home>
In-Reply-To: <1571919983-3231-3-git-send-email-yi.l.liu@intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-3-git-send-email-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: DPhczA-8O0CgFmaXYaOmVg-1
X-Mimecast-Spam-Score: 0
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
	jean-philippe.brucker@arm.com, jun.j.tian@intel.com,
	iommu@lists.linux-foundation.org, yi.y.sun@intel.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Thu, 24 Oct 2019 08:26:22 -0400
Liu Yi L <yi.l.liu@intel.com> wrote:

> This patch adds VFIO_IOMMU_PASID_REQUEST ioctl which aims
> to passdown PASID allocation/free request from the virtual
> iommu. This is required to get PASID managed in system-wide.
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 114 ++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h       |  25 +++++++++
>  2 files changed, 139 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index cd8d3a5..3d73a7d 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -2248,6 +2248,83 @@ static int vfio_cache_inv_fn(struct device *dev, void *data)
>  	return iommu_cache_invalidate(dc->domain, dev, &ustruct->info);
>  }
>  
> +static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
> +					 int min_pasid,
> +					 int max_pasid)
> +{
> +	int ret;
> +	ioasid_t pasid;
> +	struct mm_struct *mm = NULL;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +	mm = get_task_mm(current);
> +	/* Track ioasid allocation owner by mm */
> +	pasid = ioasid_alloc((struct ioasid_set *)mm, min_pasid,
> +				max_pasid, NULL);

Are we sure we want to tie this to the task mm vs perhaps the
vfio_iommu pointer?

> +	if (pasid == INVALID_IOASID) {
> +		ret = -ENOSPC;
> +		goto out_unlock;
> +	}
> +	ret = pasid;
> +out_unlock:
> +	mutex_unlock(&iommu->lock);
> +	if (mm)
> +		mmput(mm);
> +	return ret;
> +}
> +
> +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> +				       unsigned int pasid)
> +{
> +	struct mm_struct *mm = NULL;
> +	void *pdata;
> +	int ret = 0;
> +
> +	mutex_lock(&iommu->lock);
> +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/**
> +	 * REVISIT:
> +	 * There are two cases free could fail:
> +	 * 1. free pasid by non-owner, we use ioasid_set to track mm, if
> +	 * the set does not match, caller is not permitted to free.
> +	 * 2. free before unbind all devices, we can check if ioasid private
> +	 * data, if data != NULL, then fail to free.
> +	 */
> +	mm = get_task_mm(current);
> +	pdata = ioasid_find((struct ioasid_set *)mm, pasid, NULL);
> +	if (IS_ERR(pdata)) {
> +		if (pdata == ERR_PTR(-ENOENT))
> +			pr_err("PASID %u is not allocated\n", pasid);
> +		else if (pdata == ERR_PTR(-EACCES))
> +			pr_err("Free PASID %u by non-owner, denied", pasid);
> +		else
> +			pr_err("Error searching PASID %u\n", pasid);

This should be removed, errno is sufficient for the user, this just
provides the user with a trivial DoS vector filling logs.

> +		ret = -EPERM;

But why not return PTR_ERR(pdata)?

> +		goto out_unlock;
> +	}
> +	if (pdata) {
> +		pr_debug("Cannot free pasid %d with private data\n", pasid);
> +		/* Expect PASID has no private data if not bond */
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +	ioasid_free(pasid);

We only ever get here with pasid == NULL?!  Something is wrong.  Should
that be 'if (!pdata)'?  (which also makes that pr_debug another DoS
vector)

> +
> +out_unlock:
> +	if (mm)
> +		mmput(mm);
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -2370,6 +2447,43 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  					    &ustruct);
>  		mutex_unlock(&iommu->lock);
>  		return ret;
> +
> +	} else if (cmd == VFIO_IOMMU_PASID_REQUEST) {
> +		struct vfio_iommu_type1_pasid_request req;
> +		int min_pasid, max_pasid, pasid;
> +
> +		minsz = offsetofend(struct vfio_iommu_type1_pasid_request,
> +				    flag);
> +
> +		if (copy_from_user(&req, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (req.argsz < minsz)
> +			return -EINVAL;
> +
> +		switch (req.flag) {

This works, but it's strange.  Let's make the code a little easier for
the next flag bit that gets used so they don't need to rework this case
statement.  I'd suggest creating a VFIO_IOMMU_PASID_OPS_MASK that is
the OR of the ALLOC/FREE options, test that no bits are set outside of
that mask, then AND that mask as the switch arg with the code below.

> +		/**
> +		 * TODO: min_pasid and max_pasid align with
> +		 * typedef unsigned int ioasid_t
> +		 */
> +		case VFIO_IOMMU_PASID_ALLOC:
> +			if (copy_from_user(&min_pasid,
> +				(void __user *)arg + minsz, sizeof(min_pasid)))
> +				return -EFAULT;
> +			if (copy_from_user(&max_pasid,
> +				(void __user *)arg + minsz + sizeof(min_pasid),
> +				sizeof(max_pasid)))
> +				return -EFAULT;
> +			return vfio_iommu_type1_pasid_alloc(iommu,
> +						min_pasid, max_pasid);
> +		case VFIO_IOMMU_PASID_FREE:
> +			if (copy_from_user(&pasid,
> +				(void __user *)arg + minsz, sizeof(pasid)))
> +				return -EFAULT;
> +			return vfio_iommu_type1_pasid_free(iommu, pasid);
> +		default:
> +			return -EINVAL;
> +		}
>  	}
>  
>  	return -ENOTTY;
> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> index ccf60a2..04de290 100644
> --- a/include/uapi/linux/vfio.h
> +++ b/include/uapi/linux/vfio.h
> @@ -807,6 +807,31 @@ struct vfio_iommu_type1_cache_invalidate {
>  };
>  #define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE + 24)
>  
> +/*
> + * @flag=VFIO_IOMMU_PASID_ALLOC, refer to the @min_pasid and @max_pasid fields
> + * @flag=VFIO_IOMMU_PASID_FREE, refer to @pasid field
> + */
> +struct vfio_iommu_type1_pasid_request {
> +	__u32	argsz;
> +#define VFIO_IOMMU_PASID_ALLOC	(1 << 0)
> +#define VFIO_IOMMU_PASID_FREE	(1 << 1)
> +	__u32	flag;
> +	union {
> +		struct {
> +			int min_pasid;
> +			int max_pasid;
> +		};
> +		int pasid;

Perhaps:

		struct {
			u32 min;
			u32 max;
		} alloc_pasid;
		u32 free_pasid;

(note also the s/int/u32/)

> +	};
> +};
> +
> +/**
> + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 27,
> + *				struct vfio_iommu_type1_pasid_request)
> + *
> + */
> +#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 27)
> +
>  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
>  
>  /*

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
