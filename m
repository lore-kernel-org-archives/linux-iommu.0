Return-Path: <SRS0=Ppoz=A4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649E3C433E1
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 15:58:24 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 287F1204EA
	for <iommu@archiver.kernel.org>; Fri, 17 Jul 2020 15:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxzWlfBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 287F1204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D4A6D204E3;
	Fri, 17 Jul 2020 15:58:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 16TYe-6+Roon; Fri, 17 Jul 2020 15:58:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 26610203D4;
	Fri, 17 Jul 2020 15:58:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 14429C07FF;
	Fri, 17 Jul 2020 15:58:22 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 489A3C0733
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 15:58:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2FCF4860C9
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 15:58:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0cM4qbVoSIYG for <iommu@lists.linux-foundation.org>;
 Fri, 17 Jul 2020 15:58:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 994B0860C0
 for <iommu@lists.linux-foundation.org>; Fri, 17 Jul 2020 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595001498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3A+dweEAjNZ389Y/3wgAp6Vu2VD5eyEaWPM10r/UltY=;
 b=NxzWlfBhkRsjrdJQrmv6e+ro1YCF/Ma7ahaIu7iAO/P3c8Q7FGulscYtoyc7CFCidgKT5t
 ubHQ2+sThQnlkgoSOurdB9Oir88ItGkeJU415qIj5+ooECNkHx5wv6Ic0KjDpNq+HOllOF
 gWh2eoFn6dVcNdylJQMtPm3EYnHY6ec=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-Pem6iQVpPxKMMr4qOYaDUw-1; Fri, 17 Jul 2020 11:58:14 -0400
X-MC-Unique: Pem6iQVpPxKMMr4qOYaDUw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34C838018A1;
 Fri, 17 Jul 2020 15:58:12 +0000 (UTC)
Received: from [10.36.115.54] (ovpn-115-54.ams2.redhat.com [10.36.115.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9BF1D724C2;
 Fri, 17 Jul 2020 15:58:06 +0000 (UTC)
Subject: Re: [PATCH v5 4/5] iommu/uapi: Handle data and argsz filled by users
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1594925117-64892-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1594925117-64892-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <a3814db0-3d99-7752-c9d7-91f032d4eb0f@redhat.com>
Date: Fri, 17 Jul 2020 17:58:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1594925117-64892-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Christoph Hellwig <hch@infradead.org>, David Woodhouse <dwmw2@infradead.org>
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

Hi Jacob,
On 7/16/20 8:45 PM, Jacob Pan wrote:

Could you share a branch? I was not able to apply this on either
iommu/next or master?

> IOMMU UAPI data has a user filled argsz field which indicates the data
> length comes with the API call.
s/ comes with the API call/ of the structure
 User data is not trusted, argsz must be
> validated based on the current kernel data size, mandatory data size,
> and feature flags.
> 
> User data may also be extended, results in possible argsz increase.
s/results/resulting
> Backward compatibility is ensured based on size and flags checking.
flags is missing in iommu_cache_invalidate_info.
> 
> This patch adds sanity checks in the IOMMU layer. In addition to argsz,
> reserved/unused fields in padding, flags, and version are also checked.
> Details are documented in Documentation/userspace-api/iommu.rst
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  include/linux/iommu.h |  20 ++++--
>  2 files changed, 200 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d43120eb1dc5..fe30a940d19e 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1950,36 +1950,214 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device);
>  
> +/*
> + * Check flags and other user privided data for valid combinations. We also
s/privided/provided
> + * make sure no reserved fields or unused flags are not set. This is to ensure
s/not// ?
> + * not breaking userspace in the future when these fields or flags are used.
> + */
> +static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
> +{
> +	u32 mask;
> +
> +	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
increased version number?
> +		return -EINVAL;
> +
> +	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
> +	if (info->cache & ~mask)
> +		return -EINVAL;
> +
> +	if (info->granularity >= IOMMU_INV_GRANU_NR)
> +		return -EINVAL;
> +
> +	switch (info->granularity) {
> +	case IOMMU_INV_GRANU_ADDR:
> +		mask = IOMMU_INV_ADDR_FLAGS_PASID |
> +			IOMMU_INV_ADDR_FLAGS_ARCHID |
> +			IOMMU_INV_ADDR_FLAGS_LEAF;
> +
> +		if (info->granu.addr_info.flags & ~mask)
> +			return -EINVAL;
> +		break;
> +	case IOMMU_INV_GRANU_PASID:
> +		mask = IOMMU_INV_PASID_FLAGS_PASID |
> +			IOMMU_INV_PASID_FLAGS_ARCHID;
> +		if (info->granu.pasid_info.flags & ~mask)
> +			return -EINVAL;
> +
> +		break;
> +	case IOMMU_INV_GRANU_DOMAIN:
> +		/* No flags to check */
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (info->padding[0] || info->padding[1])
padding has become "__u8	padding[6];" in 2/5

> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
>  int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> -			   struct iommu_cache_invalidate_info *inv_info)
> +			   void __user *uinfo)
>  {
> +	struct iommu_cache_invalidate_info inv_info = { 0 };
> +	u32 minsz, maxsz;
> +	int ret = 0;
> +
>  	if (unlikely(!domain->ops->cache_invalidate))
>  		return -ENODEV;
>  
> -	return domain->ops->cache_invalidate(domain, dev, inv_info);
> +	/* Current kernel data size is the max to be copied from user */
> +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> +
> +	/*
> +	 * No new spaces can be added before the variable sized union, the
> +	 * minimum size is the offset to the union.
> +	 */
> +	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
> +
> +	/* Copy minsz from user to get flags and argsz */
> +	if (copy_from_user(&inv_info, uinfo, minsz))
> +		return -EFAULT;
> +
> +	/* Fields before variable size union is mandatory */
> +	if (inv_info.argsz < minsz)
> +		return -EINVAL;
> +
> +	/* PASID and address granu requires additional info beyond minsz */
s/requires/require
> +	if (inv_info.argsz == minsz &&
> +		((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
> +			(inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
> +		return -EINVAL;
> +	/*
> +	 * User might be using a newer UAPI header which has a larger data
> +	 * size, we shall support the existing flags within the current
> +	 * size. Copy the remaining user data _after_ minsz but not more
> +	 * than the current kernel supported size.
> +	 */
> +	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
> +				min(inv_info.argsz, maxsz) - minsz))
> +		return -EFAULT;
> +
> +	/* Now the argsz is validated, check the content */
> +	ret = iommu_check_cache_invl_data(&inv_info);
> +	if (ret)
> +		return ret;
> +
> +	return domain->ops->cache_invalidate(domain, dev, &inv_info);
>  }
>  EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
>  
> -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -			   struct device *dev, struct iommu_gpasid_bind_data *data)
> +
> +static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
>  {
> +	u32 mask;
> +	int i;
> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
> +		return -EINVAL;
> +
> +	/* Check all supported format, for now just VT-d */
> +	mask = IOMMU_PASID_FORMAT_INTEL_VTD;
> +	if (data->format & ~mask)
> +		return -EINVAL;
> +
> +	/* Check all flags */
> +	mask = IOMMU_SVA_GPASID_VAL;
> +	if (data->flags & ~mask)
> +		return -EINVAL;
> +
> +	/* Check reserved padding fields */
> +	for (i = 0; i < 12; i++) {
now 8
> +		if (data->padding[i])
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int iommu_sva_prepare_bind_data(void __user *udata,
> +				       struct iommu_gpasid_bind_data *data)
> +{
> +	u32 minsz, maxsz;
> +
> +	/* Current kernel data size is the max to be copied from user */
> +	maxsz = sizeof(struct iommu_gpasid_bind_data);
> +	memset((void *)data, 0, maxsz);
> +
> +	/*
> +	 * No new spaces can be added before the variable sized union, the
> +	 * minimum size is the offset to the union.
> +	 */
> +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> +
> +	/* Copy minsz from user to get flags and argsz */
> +	if (copy_from_user(data, udata, minsz))
> +		return -EFAULT;
> +
> +	/* Fields before variable size union is mandatory */
> +	if (data->argsz < minsz)
> +		return -EINVAL;
> +	/*
> +	 * User might be using a newer UAPI header, we shall let IOMMU vendor
> +	 * driver decide on what size it needs. Since the guest PASID bind data
> +	 * can be vendor specific, larger argsz could be the result of extension
> +	 * for one vendor but it should not affect another vendor.
> +	 * Copy the remaining user data _after_ minsz
> +	 */
> +	if (copy_from_user((void *)data + minsz, udata + minsz,
> +				min(data->argsz, maxsz) - minsz))
> +		return -EFAULT;
> +
> +	return iommu_check_bind_data(data);
> +}
> +
> +int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> +						void __user *udata)
change of proto not described in the commit msg
> +{
> +
> +	struct iommu_gpasid_bind_data data;
> +	int ret;
> +
>  	if (unlikely(!domain->ops->sva_bind_gpasid))
>  		return -ENODEV;
>  
> -	return domain->ops->sva_bind_gpasid(domain, dev, data);
> +	ret = iommu_sva_prepare_bind_data(udata, &data);
> +	if (ret)
> +		return ret;
> +
> +	return domain->ops->sva_bind_gpasid(domain, dev, &data);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
>  
>  int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> -			     ioasid_t pasid)
> +			struct iommu_gpasid_bind_data *data)
This change and the introduction of iommu_uapi_sva_unbind_gpasid look
unrelated to this patch, at least not described in the commit msg.
>  {
>  	if (unlikely(!domain->ops->sva_unbind_gpasid))
>  		return -ENODEV;
>  
> -	return domain->ops->sva_unbind_gpasid(dev, pasid);
> +	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
>  }
>  EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
>  
> +int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
> +			void __user *udata)
> +{
> +	struct iommu_gpasid_bind_data data;
> +	int ret;
> +
> +	if (unlikely(!domain->ops->sva_bind_gpasid))
> +		return -ENODEV;
> +
> +	ret = iommu_sva_prepare_bind_data(udata, &data);
> +	if (ret)
> +		return ret;
> +
> +	return iommu_sva_unbind_gpasid(domain, dev, &data);
> +}
> +EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
> +
>  static void __iommu_detach_device(struct iommu_domain *domain,
>  				  struct device *dev)
>  {
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..439f34a7b5b2 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -432,11 +432,14 @@ extern void iommu_detach_device(struct iommu_domain *domain,
>  				struct device *dev);
>  extern int iommu_cache_invalidate(struct iommu_domain *domain,
>  				  struct device *dev,
> -				  struct iommu_cache_invalidate_info *inv_info);
> +				  void __user *uinfo);
> +
>  extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -		struct device *dev, struct iommu_gpasid_bind_data *data);
> +				struct device *dev, void __user *udata);
> +extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
> +				        struct device *dev, void __user *udata);
not motivated in the commit msg. I think change of proto and addition of
iommu_sva_unbind_gpasid would deserve a separate patch.
>  extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, ioasid_t pasid);
> +				   struct device *dev, struct iommu_gpasid_bind_data *data);
>  extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
>  extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
>  extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
> @@ -1062,13 +1065,20 @@ iommu_cache_invalidate(struct iommu_domain *domain,
>  	return -ENODEV;
>  }
>  static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, struct iommu_gpasid_bind_data *data)
> +				struct device *dev, void __user *udata)
>  {
>  	return -ENODEV;
>  }
>  
>  static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> -					   struct device *dev, int pasid)
> +					   struct device *dev, void __user *udata)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int __iommu_sva_unbind_gpasid(struct iommu_domain *domain,
> +					struct device *dev,
> +					struct iommu_gpasid_bind_data *data)
>  {
>  	return -ENODEV;
>  }
> 

Thanks

Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
