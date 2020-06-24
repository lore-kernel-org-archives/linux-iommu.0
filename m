Return-Path: <SRS0=9F5p=AF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 819E0C433E1
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EB72072E
	for <iommu@archiver.kernel.org>; Wed, 24 Jun 2020 06:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EB72072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id E503887D39;
	Wed, 24 Jun 2020 06:54:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hXAJRCDgDU7X; Wed, 24 Jun 2020 06:54:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2FE987BE0;
	Wed, 24 Jun 2020 06:54:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B64C0C0888;
	Wed, 24 Jun 2020 06:54:57 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DE70C016F
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 06:54:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E97EE87D25
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 06:54:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LoIYIwb-SmLd for <iommu@lists.linux-foundation.org>;
 Wed, 24 Jun 2020 06:54:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by whitealder.osuosl.org (Postfix) with ESMTPS id C218987BE0
 for <iommu@lists.linux-foundation.org>; Wed, 24 Jun 2020 06:54:54 +0000 (UTC)
IronPort-SDR: B2uemUaP6ra/+asg5NSbzAQigE1V8XvmH8rDe4uav+RQOPUdm4pVe5Q4f6n0J8S3zc9mm1tZlJ
 qIrJ+UnW0jtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="143458881"
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="143458881"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2020 23:54:54 -0700
IronPort-SDR: pA3PTVMILCzC6XLeHyCYohah+2CFAn8+IEkWI2O7GjGT8tAuYipPYbAtjuNA87abS/nCEiKTel
 vGKOK9jGZU3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,274,1589266800"; d="scan'208";a="423273922"
Received: from msaix-mobl2.ccr.corp.intel.com (HELO [10.255.28.245])
 ([10.255.28.245])
 by orsmga004.jf.intel.com with ESMTP; 23 Jun 2020 23:54:50 -0700
Subject: Re: [PATCH v3 4/5] iommu/uapi: Handle data and argsz filled by users
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Alex Williamson <alex.williamson@redhat.com>
References: <1592931837-58223-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1592931837-58223-5-git-send-email-jacob.jun.pan@linux.intel.com>
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <84491857-4a7e-e669-3cf5-615b010930e4@linux.intel.com>
Date: Wed, 24 Jun 2020 14:54:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592931837-58223-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Hi Jacob,

On 2020/6/24 1:03, Jacob Pan wrote:
> IOMMU UAPI data has a user filled argsz field which indicates the data
> length comes with the API call. User data is not trusted, argsz must be
> validated based on the current kernel data size, mandatory data size,
> and feature flags.
> 
> User data may also be extended, results in possible argsz increase.
> Backward compatibility is ensured based on size and flags checking.
> Details are documented in Documentation/userspace-api/iommu.rst
> 
> This patch adds sanity checks in both IOMMU layer and vendor code, where
> VT-d is the only user for now.
> 
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>   drivers/iommu/intel/svm.c |  3 ++
>   drivers/iommu/iommu.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++---
>   include/linux/iommu.h     |  7 ++--
>   3 files changed, 98 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 713b3a218483..237db56878c0 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -244,6 +244,9 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
>   	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
>   		return -EINVAL;
>   
> +	if (data->argsz != offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
> +		return -EINVAL;

Need to do size check in intel_iommu_sva_invalidate() as well?

> +
>   	if (!dev_is_pci(dev))
>   		return -ENOTSUPP;
>   
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index d43120eb1dc5..4a025c429b41 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1951,22 +1951,108 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
>   int iommu_cache_invalidate(struct iommu_domain *domain, struct device *dev,
> -			   struct iommu_cache_invalidate_info *inv_info)
> +			void __user *uinfo)

Nit: keep it aligned.

>   {
> +	struct iommu_cache_invalidate_info inv_info;
> +	unsigned long minsz, maxsz;
> +
>   	if (unlikely(!domain->ops->cache_invalidate))
>   		return -ENODEV;
>   
> -	return domain->ops->cache_invalidate(domain, dev, inv_info);
> +	/* Current kernel data size is the max to be copied from user */
> +	maxsz = sizeof(struct iommu_cache_invalidate_info);
> +	memset((void *)&inv_info, 0, maxsz);
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
> +	/*
> +	 * User might be using a newer UAPI header, we shall let IOMMU vendor
> +	 * driver decide on what size it needs. Since the UAPI data extension
> +	 * can be vendor specific, larger argsz could be the result of extension
> +	 * for one vendor but it should not affect another vendor.
> +	 */
> +	/*
> +	 * User might be using a newer UAPI header which has a larger data
> +	 * size, we shall support the existing flags within the current
> +	 * size.
> +	 */
> +	if (inv_info.argsz > maxsz)
> +		inv_info.argsz = maxsz;
> +
> +	/* Checking the exact argsz based on generic flags */
> +	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
> +		inv_info.argsz != offsetofend(struct iommu_cache_invalidate_info,
> +					granu.addr_info))
> +		return -EINVAL;
> +
> +	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
> +		inv_info.argsz != offsetofend(struct iommu_cache_invalidate_info,
> +					granu.pasid_info))
> +		return -EINVAL;
> +
> +	/* Copy the remaining user data _after_ minsz */
> +	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
> +				inv_info.argsz - minsz))
> +		return -EFAULT;
> +
> +	return domain->ops->cache_invalidate(domain, dev, &inv_info);
>   }
>   EXPORT_SYMBOL_GPL(iommu_cache_invalidate);
>   
> -int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -			   struct device *dev, struct iommu_gpasid_bind_data *data)
> +int iommu_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
> +						void __user *udata)
>   {
> +
> +	struct iommu_gpasid_bind_data data;
> +	unsigned long minsz, maxsz;
> +
>   	if (unlikely(!domain->ops->sva_bind_gpasid))
>   		return -ENODEV;
>   
> -	return domain->ops->sva_bind_gpasid(domain, dev, data);
> +	/* Current kernel data size is the max to be copied from user */
> +	maxsz = sizeof(struct iommu_gpasid_bind_data);
> +	memset((void *)&data, 0, maxsz);
> +
> +	/*
> +	 * No new spaces can be added before the variable sized union, the
> +	 * minimum size is the offset to the union.
> +	 */
> +	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
> +
> +	/* Copy minsz from user to get flags and argsz */
> +	if (copy_from_user(&data, udata, minsz))
> +		return -EFAULT;
> +
> +	/* Fields before variable size union is mandatory */
> +	if (data.argsz < minsz)
> +		return -EINVAL;
> +	/*
> +	 * User might be using a newer UAPI header, we shall let IOMMU vendor
> +	 * driver decide on what size it needs. Since the guest PASID bind data
> +	 * can be vendor specific, larger argsz could be the result of extension
> +	 * for one vendor but it should not affect another vendor.
> +	 */
> +	if (data.argsz > maxsz)
> +		data.argsz = maxsz;
> +
> +	/* Copy the remaining user data _after_ minsz */
> +	if (copy_from_user((void *)&data + minsz, udata + minsz,
> +				data.argsz - minsz))
> +		return -EFAULT;
> +
> +
> +	return domain->ops->sva_bind_gpasid(domain, dev, &data);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_bind_gpasid);
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 5f0b7859d2eb..a688fea42ae5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -432,9 +432,10 @@ extern void iommu_detach_device(struct iommu_domain *domain,
>   				struct device *dev);
>   extern int iommu_cache_invalidate(struct iommu_domain *domain,
>   				  struct device *dev,
> -				  struct iommu_cache_invalidate_info *inv_info);
> +				  void __user *uinfo);
> +
>   extern int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -		struct device *dev, struct iommu_gpasid_bind_data *data);
> +				struct device *dev, void __user *udata);
>   extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
>   				struct device *dev, ioasid_t pasid);
>   extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
> @@ -1062,7 +1063,7 @@ iommu_cache_invalidate(struct iommu_domain *domain,
>   	return -ENODEV;
>   }
>   static inline int iommu_sva_bind_gpasid(struct iommu_domain *domain,
> -				struct device *dev, struct iommu_gpasid_bind_data *data)
> +				struct device *dev, void __user *udata)
>   {
>   	return -ENODEV;
>   }
> 

Best regards,
baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
