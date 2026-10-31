Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793417516;
	b=crsf/g1W5DU6YIQbSptSLafA508W+ehdSWNW7S53z92F8Xurp9owIABpxB2MPzuAo8MI
	 rziRXqSgDj63j/VVDYSj7GvCzo8u8Z0T4wsX3ZRNhCZRkEWTOtu7+hyIBdRkXlwvqfBsS
	 ICqYDa78iY+kT9M2Jr80boTAeI1S+D0OKcaGe02ltWVpT6Qneabsx9b90+K5wb65HufBA
	 Vop/v9L4X/Um44lE1ndXjV/zMOloOj1bkBTqWj2INV6lE303zePQOCZfX/fwcX9KWsrsd
	 QttSI7ci12kMftdSFucSPvTM3Sealfqma0R0VbxKJGncqmXPdXg1gyU2aRyewRKuDow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793417516;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rLHbC4+lDDiHcUSzGiIbwk8Z172638Yn2PsS3vFu9uU=;
	b=jkzfkqUtmLyVzUWQJ2lExk2W45TIv/I4w/L6gmiQGYxHXPDHV4NM2T8Ua9R9TV/tzuyN
	 6YHcQI7gv6ckJ/CshshIB0E0VKS0n6ztiV78D+cm+99fI3MBiMFCr+lYHMbFIoyj1WIFM
	 LwLz45o3JfTVw8JSBiCwdCMic++pOCEt3atRmFY1/IycubU31RNs8H27Q+JyngOFf0Hq4
	 6npIwn+uV1ukUhjhBO9tLASMRd5in6znJNikJNkYvplvWcA092uiRapMnoJlk0sW+0LfO
	 w3YB1PZc1C4KIQJcmYzrlKMyYG+E8KSoGMqJSQcF7PBUJAF1rmufgs9XE/gRF0Wu6uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DIxRI63d;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DBB606A31C
	for <iommu@lists.linux.dev>; Sat, 31 Oct 2026 03:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DBB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DIxRI63d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793417515; x=1824953515;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a1HqAOPP9Oaz4fcr/v/BgaOGnVyjVL1Un5uMnnR69Ko=;
  b=DIxRI63dnPXRwC0qkp6P7CdUiVA1rlOe84zFR0FH0OYOmwqT6SZQeo9d
   3zewd3pNA5TIsKiNC5na2uDmfQNJ5BBSf2H3zqB2nE45dYuZEQHr8p0yW
   886nO9Hc//G5/XxT/uLKBsr2uBXxozEuU5CRhYXiDCu8NOVG4U9mo+mQV
   e9BErCVhU3QlryXC7ygAFMnT5uxVq+4PXSjhLOXWdvXPMhVZbIcfCozdk
   sd2Ggy9h018coTgzVacYeYCUV7WMMLAR8lC3VocDIseOaW0T1raNrV0B/
   cDt6kOOr0X9tmm8phzaNkmKNY9YXk77ZRYfTzdc/wxs8GRWvzjlkkCsEP
   g==;
X-CSE-ConnectionGUID: QOcTxpiRTHqw/qtK/zQwZg==
X-CSE-MsgGUID: WJ2tXXAyQ32cZSF09EFIsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11951"; a="2188437"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2188437"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 20:31:54 -0700
X-CSE-ConnectionGUID: xnfxOGolSbmMqgKJk+YThw==
X-CSE-MsgGUID: 7oZumnmqQTiTG64vXHzjJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5742937"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 20:31:50 -0700
Message-ID: <07a7f12c-3cd8-4c03-9304-af89c32e0b46@linux.intel.com>
Date: Sat, 31 Oct 2026 11:31:47 +0800
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, Pranjal Shrivastava <praan@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma
 <vipinsh@google.com>, Ankit Soni <Ankit.Soni@amd.com>,
 Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v6 16/18] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-17-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-17-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
> Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
> the APIs exported by the IOMMU core to preserve/unpreserve device.
> 
> The LUO token of the preserved iommufd is fetched and returned back to
> the caller as that can be used during restore to get the restored
> iommufd.
> 
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/iommufd/device.c          | 156 ++++++++++++++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h |   6 +
>   include/linux/iommufd.h                 |  29 +++++
>   3 files changed, 191 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> index a664c70a6fe7..c8ea2e288240 100644
> --- a/drivers/iommu/iommufd/device.c
> +++ b/drivers/iommu/iommufd/device.c
> @@ -2,6 +2,7 @@
>   /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
>    */
>   #include <linux/iommu.h>
> +#include <linux/iommu-liveupdate.h>
>   #include <linux/iommufd.h>
>   #include <linux/pci-ats.h>
>   #include <linux/slab.h>
> @@ -686,6 +687,10 @@ int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
>   	int rc;
>   
>   	mutex_lock(&igroup->lock);
> +	if (iommufd_device_is_preserved(idev)) {
> +		rc = -EBUSY;
> +		goto err_unlock;
> +	}
>   
>   	attach = xa_cmpxchg(&igroup->pasid_attach, pasid, NULL,
>   			    XA_ZERO_ENTRY, GFP_KERNEL);
> @@ -868,6 +873,10 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>   	int rc;
>   
>   	mutex_lock(&igroup->lock);
> +	if (iommufd_device_is_preserved(idev)) {
> +		rc = -EBUSY;
> +		goto err_unlock;
> +	}
>   
>   	attach = xa_load(&igroup->pasid_attach, pasid);
>   	if (!attach) {
> @@ -1747,3 +1756,150 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
>   	iommufd_put_object(ucmd->ictx, &idev->obj);
>   	return rc;
>   }

Why is there no such check in iommufd_hw_pagetable_detach()?

> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +static bool _iommufd_device_has_pasid_attachments(struct iommufd_device *idev)
> +{
> +	struct iommufd_group *igroup = idev->igroup;
> +	unsigned long start = IOMMU_NO_PASID;
> +
> +	if (xa_find_after(&igroup->pasid_attach, &start, UINT_MAX, XA_PRESENT))
> +		return true;
> +
> +	return false;
> +}
> +
> +/**
> + * iommufd_device_preserve() - Preserve an iommufd device across live update
> + * @s: Live update session
> + * @idev: Target iommufd device
> + * @iommufd_tokenp: Pointer to store outgoing iommufd token
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int iommufd_device_preserve(struct liveupdate_session *s,
> +			    struct iommufd_device *idev,
> +			    u64 *iommufd_tokenp)
> +{
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +	struct iommufd_group *igroup;
> +	int ret;
> +
> +	if (!idev)
> +		return -EINVAL;
> +
> +	if (iommufd_device_is_noiommu(idev))
> +		return -EOPNOTSUPP;
> +
> +	igroup = idev->igroup;
> +	mutex_lock(&igroup->lock);
> +	if (idev->liveupdate_preserved) {
> +		ret = -EBUSY;
> +		goto out;
> +	}
> +
> +	if (_iommufd_device_has_pasid_attachments(idev)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +	if (!attach) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	if (!xa_load(&attach->device_array, idev->obj.id)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	hwpt = attach->hwpt;
> +	if (!hwpt_is_paging(hwpt)) {
> +		ret = -EOPNOTSUPP;
> +		goto out;
> +	}
> +
> +	hwpt_paging = to_hwpt_paging(hwpt);
> +	ret = liveupdate_get_token_outgoing(s, idev->ictx->file, iommufd_tokenp);
> +	if (ret)
> +		goto out;
> +
> +	if (!hwpt_paging->liveupdate_preserved) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = iommu_preserve_device(hwpt_paging->common.domain,
> +				    idev->dev,
> +				    *iommufd_tokenp);
> +
> +	if (!ret) {
> +		igroup->num_liveupdate_preserved++;
> +		idev->liveupdate_preserved = true;
> +	}
> +out:
> +	mutex_unlock(&igroup->lock);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_preserve, "IOMMUFD");
> +
> +/**
> + * iommufd_device_unpreserve() - Unpreserve an iommufd device
> + * @s: Live update session
> + * @idev: Target iommufd device
> + */
> +void iommufd_device_unpreserve(struct liveupdate_session *s,
> +			       struct iommufd_device *idev)
> +{
> +	struct iommufd_hwpt_paging *hwpt_paging;
> +	struct iommufd_hw_pagetable *hwpt;
> +	struct iommufd_attach *attach;
> +	struct iommufd_group *igroup;
> +
> +	if (!idev)
> +		return;
> +
> +	igroup = idev->igroup;
> +	mutex_lock(&igroup->lock);
> +	if (!idev->liveupdate_preserved)
> +		goto out;
> +
> +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> +	if (!attach) {
> +		WARN(1, "IOMMU_NO_PASID attachment not found");
> +		goto out;
> +	}
> +
> +	hwpt = attach->hwpt;
> +	if (WARN(!hwpt_is_paging(hwpt), "Attached HWPT is not a paging HWPT"))
> +		goto out;
> +
> +	hwpt_paging = to_hwpt_paging(hwpt);
> +	if (!hwpt_paging->liveupdate_preserved) {
> +		WARN(1, "Attached domain is not preserved");
> +		goto out;
> +	}
> +
> +	iommu_unpreserve_device(hwpt_paging->common.domain, idev->dev);
> +	igroup->num_liveupdate_preserved--;
> +	idev->liveupdate_preserved = false;
> +out:
> +	mutex_unlock(&igroup->lock);
> +}
> +EXPORT_SYMBOL_NS_GPL(iommufd_device_unpreserve, "IOMMUFD");
> +
> +/**
> + * iommufd_device_is_preserved() - Check if an iommufd device is preserved
> + * @idev: Target iommufd device
> + *
> + * Return: true if preserved, false otherwise.
> + */
> +bool iommufd_device_is_preserved(struct iommufd_device *idev)
> +{
> +	return idev && idev->igroup && idev->igroup->num_liveupdate_preserved;
> +}

How is it different from

	return idev && idev->liveupdate_preserved;

?

Device preservation requires a singleton group, so these two are
effectively the same. However, the latter seems more straightforward
given the function's name. Or anything I overlooked?

> +EXPORT_SYMBOL_NS_GPL(iommufd_device_is_preserved, "IOMMUFD");
> +#endif
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 69d902b69b82..4760fffd2512 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -507,6 +507,9 @@ struct iommufd_group {
>   	struct xarray pasid_attach;
>   	struct iommufd_sw_msi_maps required_sw_msi;
>   	phys_addr_t sw_msi_start;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int num_liveupdate_preserved;
> +#endif
>   };
>   
>   /*
> @@ -524,6 +527,9 @@ struct iommufd_device {
>   	bool enforce_cache_coherency;
>   	struct iommufd_vdevice *vdev;
>   	bool destroying;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	bool liveupdate_preserved;
> +#endif
>   };
>   
>   static inline struct iommufd_device *
> diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
> index 6e7efe83bc5d..80382aceca18 100644
> --- a/include/linux/iommufd.h
> +++ b/include/linux/iommufd.h
> @@ -9,6 +9,7 @@
>   #include <linux/err.h>
>   #include <linux/errno.h>
>   #include <linux/iommu.h>
> +#include <linux/liveupdate.h>
>   #include <linux/refcount.h>
>   #include <linux/types.h>
>   #include <linux/xarray.h>
> @@ -213,6 +214,15 @@ int iommufd_access_rw(struct iommufd_access *access, unsigned long iova,
>   int iommufd_vfio_compat_ioas_get_id(struct iommufd_ctx *ictx, u32 *out_ioas_id);
>   int iommufd_vfio_compat_ioas_create(struct iommufd_ctx *ictx);
>   int iommufd_vfio_compat_set_no_iommu(struct iommufd_ctx *ictx);
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +int iommufd_device_preserve(struct liveupdate_session *s,
> +			    struct iommufd_device *idev,
> +			    u64 *iommufd_tokenp);
> +void iommufd_device_unpreserve(struct liveupdate_session *s,
> +			       struct iommufd_device *idev);
> +bool iommufd_device_is_preserved(struct iommufd_device *idev);
> +#endif
>   #else /* !CONFIG_IOMMUFD */
>   static inline struct iommufd_ctx *iommufd_ctx_from_file(struct file *file)
>   {
> @@ -397,4 +407,23 @@ static inline void iommufd_viommu_destroy_mmap(struct iommufd_viommu *viommu,
>   {
>   	_iommufd_destroy_mmap(viommu->ictx, &viommu->obj, offset);
>   }
> +
> +#if !IS_ENABLED(CONFIG_IOMMU_LIVEUPDATE) || !IS_ENABLED(CONFIG_IOMMUFD)
> +static inline int iommufd_device_preserve(struct liveupdate_session *s,
> +					  struct iommufd_device *idev,
> +					  u64 *iommufd_tokenp)
> +{
> +	return 0;

Why does it return success when IOMMU_LIVEUPDATE is disabled?

> +}
> +
> +static inline void iommufd_device_unpreserve(struct liveupdate_session *s,
> +					     struct iommufd_device *idev)
> +{
> +}
> +
> +static inline bool iommufd_device_is_preserved(struct iommufd_device *idev)
> +{
> +	return false;
> +}
> +#endif
>   #endif

Thanks,
baolu
