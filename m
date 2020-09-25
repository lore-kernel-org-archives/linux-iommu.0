Return-Path: <SRS0=3fVv=DC=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B5D3C4363D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 15:59:11 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D7422B2D
	for <iommu@archiver.kernel.org>; Fri, 25 Sep 2020 15:59:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D7422B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9DDB786E3E;
	Fri, 25 Sep 2020 15:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ETZdZwqziV9R; Fri, 25 Sep 2020 15:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1EEEE86D6F;
	Fri, 25 Sep 2020 15:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0288CC0859;
	Fri, 25 Sep 2020 15:59:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4EEEC0051
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9042B8761E
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wGdLyg2sH7dA for <iommu@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 15:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id E6A2587108
 for <iommu@lists.linux-foundation.org>; Fri, 25 Sep 2020 15:59:04 +0000 (UTC)
IronPort-SDR: IKLmuFZvQ8WfmXVInYwf3EkogSbqNWpG/1qMX3OM6tUqJh6kGwk1dFovSBLrHjKrUMLGpuahEP
 wVsdM8a1bl1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158965241"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="158965241"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 08:59:03 -0700
IronPort-SDR: u2lScz7p+jXuEaVemEFcSztUjUhrRhEnr5bXEhUoXkPGAUQRAEsQl/K6pLG3qG2GndyRoqpAlj
 0gHai0Hko3gg==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; d="scan'208";a="383528566"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2020 08:59:03 -0700
Date: Fri, 25 Sep 2020 09:01:10 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v11 5/6] iommu/uapi: Handle data and argsz filled by users
Message-ID: <20200925090110.6c168f17@jacob-builder>
In-Reply-To: <20200925094636.GC490533@myrica>
References: <1600975460-64521-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1600975460-64521-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200925094636.GC490533@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-api@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Alex Williamson <alex.williamson@redhat.com>, Wu Hao <hao.wu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>, Yi Sun <yi.y.sun@intel.com>
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

Hi Jean-Philippe,

On Fri, 25 Sep 2020 11:46:36 +0200, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:

> On Thu, Sep 24, 2020 at 12:24:19PM -0700, Jacob Pan wrote:
> > IOMMU user APIs are responsible for processing user data. This patch
> > changes the interface such that user pointers can be passed into IOMMU
> > code directly. Separate kernel APIs without user pointers are introduced
> > for in-kernel users of the UAPI functionality.
> > 
> > IOMMU UAPI data has a user filled argsz field which indicates the data
> > length of the structure. User data is not trusted, argsz must be
> > validated based on the current kernel data size, mandatory data size,
> > and feature flags.
> > 
> > User data may also be extended, resulting in possible argsz increase.
> > Backward compatibility is ensured based on size and flags (or
> > the functional equivalent fields) checking.
> > 
> > This patch adds sanity checks in the IOMMU layer. In addition to argsz,
> > reserved/unused fields in padding, flags, and version are also checked.
> > Details are documented in Documentation/userspace-api/iommu.rst
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>  
> 
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Some comments below in case you're resending, but nothing important.
> 
Thanks for the review, I will respin.

> > ---
> >  drivers/iommu/iommu.c      | 199
> > +++++++++++++++++++++++++++++++++++++++++++--
> > include/linux/iommu.h      |  28 +++++-- include/uapi/linux/iommu.h |
> > 1 + 3 files changed, 212 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index 4ae02291ccc2..5c1b7ae48aae 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1961,34 +1961,219 @@ int iommu_attach_device(struct iommu_domain
> > *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +/*
> > + * Check flags and other user provided data for valid combinations. We
> > also
> > + * make sure no reserved fields or unused flags are set. This is to
> > ensure
> > + * not breaking userspace in the future when these fields or flags are
> > used.
> > + */
> > +static int iommu_check_cache_invl_data(struct
> > iommu_cache_invalidate_info *info) +{
> > +	u32 mask;
> > +	int i;
> > +
> > +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> > +	if (info->cache & ~mask)
> > +		return -EINVAL;
> > +
> > +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> > +		return -EINVAL;
> > +
> > +	switch (info->granularity) {
> > +	case IOMMU_INV_GRANU_ADDR:
> > +		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
> > +			return -EINVAL;
> > +
> > +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> > +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> > +			IOMMU_INV_ADDR_FLAGS_LEAF;
> > +
> > +		if (info->granu.addr_info.flags & ~mask)
> > +			return -EINVAL;
> > +		break;
> > +	case IOMMU_INV_GRANU_PASID:
> > +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> > +			IOMMU_INV_PASID_FLAGS_ARCHID;
> > +		if (info->granu.pasid_info.flags & ~mask)
> > +			return -EINVAL;
> > +
> > +		break;
> > +	case IOMMU_INV_GRANU_DOMAIN:
> > +		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
> > +			return -EINVAL;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* Check reserved padding fields */
> > +	for (i = 0; i < sizeof(info->padding); i++) {
> > +		if (info->padding[i])
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > -				struct iommu_cache_invalidate_info
> > *inv_info)
> > +				void __user *uinfo)
> >  {
> > +	struct iommu_cache_invalidate_info inv_info = { 0 };
> > +	u32 minsz;
> > +	int ret = 0;  
> 
> nit: no need to initialize it
> 
got it.

> > +
> >  	if (unlikely(!domain->ops->cache_invalidate))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->cache_invalidate(domain, dev, inv_info);
> > +	/*
> > +	 * No new spaces can be added before the variable sized union,
> > the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_cache_invalidate_info, granu);  
> 
> Why not use offsetofend() to avoid naming the unions?
> 
offsetofend() was used in earlier version but the named union would avoid
future code change if we were to re-purpose the padding fields.
minzs is always at the offsetof the union due to our expansion rules.

> > +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (inv_info.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* PASID and address granu require additional info beyond
> > minsz */
> > +	if (inv_info.argsz == minsz &&
> > +	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> > +		    (inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
> > +		return -EINVAL;  
> 
> Made redundant by the two checks below
> 
Good point! This case is covered by the two checks below.

> > +
> > +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> > +	    inv_info.argsz < offsetofend(struct
> > iommu_cache_invalidate_info, granu.pasid_info))
> > +		return -EINVAL;
> > +
> > +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> > +	    inv_info.argsz < offsetofend(struct
> > iommu_cache_invalidate_info, granu.addr_info))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * User might be using a newer UAPI header which has a larger
> > data
> > +	 * size, we shall support the existing flags within the current
> > +	 * size. Copy the remaining user data _after_ minsz but not
> > more
> > +	 * than the current kernel supported size.
> > +	 */
> > +	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
> > +			   min_t(u32, inv_info.argsz,
> > sizeof(inv_info)) - minsz))
> > +		return -EFAULT;
> > +
> > +	/* Now the argsz is validated, check the content */
> > +	ret = iommu_check_cache_invl_data(&inv_info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->cache_invalidate(domain, dev, &inv_info);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
> >  
> > -int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > -			       struct device *dev, struct
> > iommu_gpasid_bind_data *data) +static int iommu_check_bind_data(struct
> > iommu_gpasid_bind_data *data) +{
> > +	u32 mask;
> > +	int i;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	/* Check the range of supported formats */
> > +	if (data->format >= IOMMU_PASID_FORMAT_LAST)
> > +		return -EINVAL;
> > +
> > +	/* Check all flags */
> > +	mask = IOMMU_SVA_GPASID_VAL;
> > +	if (data->flags & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* Check reserved padding fields */
> > +	for (i = 0; i < sizeof(data->padding); i++) {
> > +		if (data->padding[i])
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int iommu_sva_prepare_bind_data(void __user *udata,
> > +				       struct iommu_gpasid_bind_data
> > *data) {
> > +	u32 minsz;
> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized union,
> > the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> > +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(data, udata, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */  
> 
> "are mandatory", but this comment is a bit redundant.
> 
Yes, it is implied by minsz. But I still feel it adds more clarity. Will
fix the plural.

Thanks!

> Thanks,
> Jean
> 
> > +	if (data->argsz < minsz)
> > +		return -EINVAL;
> > +	/*
> > +	 * User might be using a newer UAPI header, we shall let IOMMU
> > vendor
> > +	 * driver decide on what size it needs. Since the guest PASID
> > bind data
> > +	 * can be vendor specific, larger argsz could be the result of
> > extension
> > +	 * for one vendor but it should not affect another vendor.
> > +	 * Copy the remaining user data _after_ minsz
> > +	 */
> > +	if (copy_from_user((void *)data + minsz, udata + minsz,
> > +			   min_t(u32, data->argsz, sizeof(*data)) -
> > minsz))
> > +		return -EFAULT;
> > +
> > +	return iommu_check_bind_data(data);
> > +}
> > +
> > +int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +			       void __user *udata)
> > +{
> > +	struct iommu_gpasid_bind_data data = { 0 };
> > +	int ret;
> > +
> >  	if (unlikely(!domain->ops->sva_bind_gpasid))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->sva_bind_gpasid(domain, dev, data);
> > +	ret = iommu_sva_prepare_bind_data(udata, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->sva_bind_gpasid(domain, dev, &data);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
> >  
> > -int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > -				 ioasid_t pasid)
> > +int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device
> > *dev,
> > +			     ioasid_t pasid)
> >  {
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >  
> >  	return domain->ops->sva_unbind_gpasid(dev, pasid);
> >  }
> > +EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> > +
> > +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +				 void __user *udata)
> > +{
> > +	struct iommu_gpasid_bind_data data = { 0 };
> > +	int ret;
> > +
> > +	if (unlikely(!domain->ops->sva_bind_gpasid))
> > +		return -ENODEV;
> > +
> > +	ret = iommu_sva_prepare_bind_data(udata, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return iommu_sva_unbind_gpasid(domain, dev, data.hpasid);
> > +}
> >  EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> >  
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 710d5d2691eb..3ca3a40fc80f 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -426,11 +426,14 @@ extern void iommu_detach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> >  				       struct device *dev,
> > -				       struct
> > iommu_cache_invalidate_info *inv_info);
> > +				       void __user *uinfo);
> > +
> >  extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
> > -				      struct device *dev, struct
> > iommu_gpasid_bind_data *data);
> > +				      struct device *dev, void __user
> > *udata); extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					struct device *dev, ioasid_t
> > pasid);
> > +					struct device *dev, void
> > __user *udata); +extern int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > +				   struct device *dev, ioasid_t pasid);
> >  extern struct iommu_domain *iommu_get_domain_for_dev(struct device
> > *dev); extern struct iommu_domain *iommu_get_dma_domain(struct device
> > *dev); extern int iommu_map(struct iommu_domain *domain, unsigned long
> > iova, @@ -1032,22 +1035,29 @@ static inline int
> > iommu_sva_get_pasid(struct iommu_sva *handle) return
> > IOMMU_PASID_INVALID; }
> >  
> > -static inline int iommu_uapi_cache_invalidate(struct iommu_domain
> > *domain,
> > -					      struct device *dev,
> > -					      struct
> > iommu_cache_invalidate_info *inv_info) +static inline int
> > +iommu_uapi_cache_invalidate(struct iommu_domain *domain,
> > +			    struct device *dev,
> > +			    struct iommu_cache_invalidate_info
> > *inv_info) {
> >  	return -ENODEV;
> >  }
> >  
> >  static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > -					     struct device *dev,
> > -					     struct
> > iommu_gpasid_bind_data *data)
> > +					     struct device *dev, void
> > __user *udata) {
> >  	return -ENODEV;
> >  }
> >  
> >  static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					       struct device *dev, int
> > pasid)
> > +					       struct device *dev,
> > void __user *udata) +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> > +					  struct device *dev,
> > +					  ioasid_t pasid)
> >  {
> >  	return -ENODEV;
> >  }
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 5946779ac1f9..66d4ca40b40f 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -322,6 +322,7 @@ struct iommu_gpasid_bind_data {
> >  #define IOMMU_GPASID_BIND_VERSION_1	1
> >  	__u32 version;
> >  #define IOMMU_PASID_FORMAT_INTEL_VTD	1
> > +#define IOMMU_PASID_FORMAT_LAST		2
> >  	__u32 format;
> >  	__u32 addr_width;
> >  #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
> > -- 
> > 2.7.4
> >   


Thanks,

Jacob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
