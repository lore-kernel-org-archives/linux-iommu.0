Return-Path: <SRS0=qNYd=BA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8944FC433E1
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:11:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5030D20709
	for <iommu@archiver.kernel.org>; Tue, 21 Jul 2020 23:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5030D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 23DFA883A1;
	Tue, 21 Jul 2020 23:11:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vDzXfhJSbDgq; Tue, 21 Jul 2020 23:11:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id E71BC88305;
	Tue, 21 Jul 2020 23:11:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D6397C088E;
	Tue, 21 Jul 2020 23:11:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A35ECC016F
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:11:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8BBF286B91
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:11:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XewWnXlXwEXb for <iommu@lists.linux-foundation.org>;
 Tue, 21 Jul 2020 23:11:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6C5FB86A63
 for <iommu@lists.linux-foundation.org>; Tue, 21 Jul 2020 23:11:27 +0000 (UTC)
IronPort-SDR: SZ78U6f8ydYdab/HBNmZ0a4R+3cEyEE4AT1jIQPlb7rFBmwxTQWUEjet94dqITFi7xF5ihWuFX
 Z6km2p0lb2ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129812120"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="129812120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2020 16:11:26 -0700
IronPort-SDR: C7qpFthRpY7j1xN5UN4w9e70yD8qizRyIMSpLkg2/PQ1Z2P+sYuxVyqfjVS0D/Qg4zalvOPhN8
 ADbrdQw/L+8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; d="scan'208";a="432176133"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga004.jf.intel.com with ESMTP; 21 Jul 2020 16:11:26 -0700
Date: Tue, 21 Jul 2020 16:18:12 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v5 4/5] iommu/uapi: Handle data and argsz filled by users
Message-ID: <20200721161812.3ca8cf63@jacob-builder>
In-Reply-To: <20200717135954.6ddbbac9@x1.home>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594925117-64892-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200717135954.6ddbbac9@x1.home>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph
 Hellwig <hch@infradead.org>, iommu@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>
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

On Fri, 17 Jul 2020 13:59:54 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Thu, 16 Jul 2020 11:45:16 -0700
> Jacob Pan <jacob.jun.pan@linux.intel.com> wrote:
> 
> > IOMMU UAPI data has a user filled argsz field which indicates the
> > data length comes with the API call. User data is not trusted,
> > argsz must be validated based on the current kernel data size,
> > mandatory data size, and feature flags.
> > 
> > User data may also be extended, results in possible argsz increase.
> > Backward compatibility is ensured based on size and flags checking.
> > 
> > This patch adds sanity checks in the IOMMU layer. In addition to
> > argsz, reserved/unused fields in padding, flags, and version are
> > also checked. Details are documented in
> > Documentation/userspace-api/iommu.rst
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/iommu.c | 192
> > ++++++++++++++++++++++++++++++++++++++++++++++++--
> > include/linux/iommu.h |  20 ++++-- 2 files changed, 200
> > insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index d43120eb1dc5..fe30a940d19e 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1950,36 +1950,214 @@ int iommu_attach_device(struct
> > iommu_domain *domain, struct device *dev) }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +/*
> > + * Check flags and other user privided data for valid
> > combinations. We also
> > + * make sure no reserved fields or unused flags are not set. This
> > is to ensure
> > + * not breaking userspace in the future when these fields or flags
> > are used.
> > + */
> > +static int iommu_check_cache_invl_data(struct
> > iommu_cache_invalidate_info *info) +{
> > +	u32 mask;
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
> > +		/* No flags to check */
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (info->padding[0] || info->padding[1])
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> >  int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > -			   struct iommu_cache_invalidate_info
> > *inv_info)
> > +			   void __user *uinfo)
> >  {
> > +	struct iommu_cache_invalidate_info inv_info = { 0 };
> > +	u32 minsz, maxsz;
> > +	int ret = 0;
> > +
> >  	if (unlikely(!domain->ops->cache_invalidate))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->cache_invalidate(domain, dev,
> > inv_info);
> > +	/* Current kernel data size is the max to be copied from
> > user */
> > +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_cache_invalidate_info,
> > granu); +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(&inv_info, uinfo, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (inv_info.argsz < minsz)
> > +		return -EINVAL;
> > +
> > +	/* PASID and address granu requires additional info beyond
> > minsz */
> > +	if (inv_info.argsz == minsz &&
> > +		((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> > +			(inv_info.granularity ==
> > IOMMU_INV_GRANU_ADDR)))
> > +		return -EINVAL;
> > +	/*
> > +	 * User might be using a newer UAPI header which has a
> > larger data
> > +	 * size, we shall support the existing flags within the
> > current
> > +	 * size. Copy the remaining user data _after_ minsz but
> > not more
> > +	 * than the current kernel supported size.
> > +	 */
> > +	if (copy_from_user((void *)&inv_info + minsz, uinfo +
> > minsz,
> > +				min(inv_info.argsz, maxsz) -
> > minsz))
> > +		return -EFAULT;  
> 
> To further clarify previous comments about maxsz usage:
> 
> s/maxsz/sizeof(inv_info)/
> 
Yes, will remove maxsz.

> > +
> > +	/* Now the argsz is validated, check the content */
> > +	ret = iommu_check_cache_invl_data(&inv_info);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return domain->ops->cache_invalidate(domain, dev,
> > &inv_info); }
> >  EXPORT_SYMBOL_GPL(iommu_cache_invalidate);  
> 
> 
> Remainder of comments for above provided in 1/5.
> 
Got it.

> >  
> > -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> > -			   struct device *dev, struct
> > iommu_gpasid_bind_data *data) +
> > +static int iommu_check_bind_data(struct iommu_gpasid_bind_data
> > *data) {
> > +	u32 mask;
> > +	int i;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
> > +		return -EINVAL;
> > +
> > +	/* Check all supported format, for now just VT-d */
> > +	mask = IOMMU_PASID_FORMAT_INTEL_VTD;
> > +	if (data->format & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* Check all flags */
> > +	mask = IOMMU_SVA_GPASID_VAL;
> > +	if (data->flags & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* Check reserved padding fields */
> > +	for (i = 0; i < 12; i++) {
> > +		if (data->padding[i])
> > +			return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int iommu_sva_prepare_bind_data(void __user *udata,
> > +				       struct
> > iommu_gpasid_bind_data *data) +{
> > +	u32 minsz, maxsz;
> > +
> > +	/* Current kernel data size is the max to be copied from
> > user */
> > +	maxsz = sizeof(struct iommu_gpasid_bind_data);
> > +	memset((void *)data, 0, maxsz);  
> 
> Let the caller pass a zero'd structure.
> 
Sounds good.

> > +
> > +	/*
> > +	 * No new spaces can be added before the variable sized
> > union, the
> > +	 * minimum size is the offset to the union.
> > +	 */
> > +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> > +
> > +	/* Copy minsz from user to get flags and argsz */
> > +	if (copy_from_user(data, udata, minsz))
> > +		return -EFAULT;
> > +
> > +	/* Fields before variable size union is mandatory */
> > +	if (data->argsz < minsz)
> > +		return -EINVAL;
> > +	/*
> > +	 * User might be using a newer UAPI header, we shall let
> > IOMMU vendor
> > +	 * driver decide on what size it needs. Since the guest
> > PASID bind data
> > +	 * can be vendor specific, larger argsz could be the
> > result of extension
> > +	 * for one vendor but it should not affect another vendor.
> > +	 * Copy the remaining user data _after_ minsz
> > +	 */
> > +	if (copy_from_user((void *)data + minsz, udata + minsz,
> > +				min(data->argsz, maxsz) - minsz))  
> 
> 
> We could replace maxsz entirely with sizeof(*data)
will do.

> 
> > +		return -EFAULT;
> > +
> > +	return iommu_check_bind_data(data);
> > +}
> > +
> > +int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > +						void __user
> > *udata)  
> 
> iommu_uapi_sva_bind_gpasid(...
> 
will do. make naming consistent for all UAPIs.

> > +{
> > +
> > +	struct iommu_gpasid_bind_data data;  
> 
> 	= { 0 }
> 
yes, callee does not need to zero out the data.

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
> >  EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
> >  
> >  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct
> > device *dev,
> > -			     ioasid_t pasid)
> > +			struct iommu_gpasid_bind_data *data)
> >  {
> >  	if (unlikely(!domain->ops->sva_unbind_gpasid))
> >  		return -ENODEV;
> >  
> > -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> > +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
> >  
> > +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> > struct device *dev,
> > +			void __user *udata)
> > +{
> > +	struct iommu_gpasid_bind_data data;  
> 
> 	= { 0 };
Ditto

> 
> > +	int ret;
> > +
> > +	if (unlikely(!domain->ops->sva_bind_gpasid))
> > +		return -ENODEV;
> > +
> > +	ret = iommu_sva_prepare_bind_data(udata, &data);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return iommu_sva_unbind_gpasid(domain, dev, &data);
> > +}
> > +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> > +
> >  static void __iommu_detach_device(struct iommu_domain *domain,
> >  				  struct device *dev)
> >  {
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 5f0b7859d2eb..439f34a7b5b2 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -432,11 +432,14 @@ extern void iommu_detach_device(struct
> > iommu_domain *domain, struct device *dev);
> >  extern int iommu_cache_invalidate(struct iommu_domain *domain,  
> 
> uapi
got it.

> 
> >  				  struct device *dev,
> > -				  struct
> > iommu_cache_invalidate_info *inv_info);
> > +				  void __user *uinfo);
> > +
> >  extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,  
> 
> uapi
> 
got it.

> > -		struct device *dev, struct iommu_gpasid_bind_data
> > *data);
> > +				struct device *dev, void __user
> > *udata); +extern int iommu_uapi_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > +				        struct device *dev, void
> > __user *udata); extern int iommu_sva_unbind_gpasid(struct
> > iommu_domain *domain,
> > -				struct device *dev, ioasid_t
> > pasid);
> > +				   struct device *dev, struct
> > iommu_gpasid_bind_data *data); extern struct iommu_domain
> > *iommu_get_domain_for_dev(struct device *dev); extern struct
> > iommu_domain *iommu_get_dma_domain(struct device *dev); extern int
> > iommu_map(struct iommu_domain *domain, unsigned long iova, @@
> > -1062,13 +1065,20 @@ iommu_cache_invalidate(struct iommu_domain
> > *domain, return -ENODEV; }
> >  static inline int iommu_sva_bind_gpasid(struct iommu_domain
> > *domain,
> > -				struct device *dev, struct
> > iommu_gpasid_bind_data *data)
> > +				struct device *dev, void __user
> > *udata) {
> >  	return -ENODEV;
> >  }
> >  
> >  static inline int iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,
> > -					   struct device *dev, int
> > pasid)
> > +					   struct device *dev,
> > void __user *udata) +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int __iommu_sva_unbind_gpasid(struct iommu_domain
> > *domain,  
> 
> 
> These don't match the previous semantics.  Thanks,
> 
My mistake, will fix.

Thanks

> Alex
> 
> > +					struct device *dev,
> > +					struct
> > iommu_gpasid_bind_data *data) {
> >  	return -ENODEV;
> >  }  
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
