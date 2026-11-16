Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824360;
	b=O11WLuWZIB0nuaNz1MfNQNYymEP6TZu9Skv3TZfVvNiWmg1RjgYd58QMAsm32il8kwii
	 N7eYPfil/53TmjhIEyY5I54MG3c/HkMAn9awBuTnfla268j2pS0pHh/RbofvE2qscidkC
	 NvLZmggy5gIvOcIAjBEQuRWB4Hf9qN9CK535oD0FeRyR36aGYvvfGjHrU8OGvpiH6S3tO
	 eLtupw2xKZY1eYFFLNc9/zN/ykU8+daogqQPyKnIfWAHGcw9Z3XpRZC0PxTe7tGJY7MR+
	 hip2qAx1mKYr6dqU/nAyMMvoLvONxDzXtoXKhS9g4jMWAtnVnJmmrB2rMAFUdrPIyvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824360;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=z3MXqBBrdYBSbmsQsRqTPyDvyLGQ9DWbEILlQGx/tbc=;
	b=NtR4F2G4g4BhdT9fVxKLZjIgafHIffRwst89bzYBitEhwykkVWjbGuqkZFBo07Ty6VgM
	 sY9lhNaxK/PQ2z+4d9utaV+OPJwMW6Z+/8JxQ5FHh8AeZoEcFQVDXu1F8IuU4rCHy51jS
	 0WMdrecx7Tq5jk3li1U2cVuQRma9cuOj3mXuxOx6EXolotKUbMVqpcFfq5L2gnLDp5Wfv
	 b/NlH8Xfv9IsQrCu2qyM5cw/xqjvkJWs0BlMN2t23h24Qf3+3j4N7ne1AkA0jv197n14Q
	 RQ/vfXAFdBHh+jRpOTxckCWroVBPH+fnurVTTOtO7F6eHHW5IsDVwzN/cfs83ngEx2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nkrn02YO;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818B2606A31C
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 10:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 818B2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nkrn02YO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794824359; x=1826360359;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2WlCAn6Pk+Z5dUXP28WyX0TyGqz8OQa7Xa7A7c6Eer0=;
  b=Nkrn02YOTt/EFCAob7TtC/JUMaeLXAY+JUY9Li2DF5lR9tGD+UyN6Du8
   kdkxEYpsopVj8o5eGD4nh/9H4w65SjbSgzH9OfuKZJ9cH4BCh67vqqzhm
   8vHfG0oLHqx1R25NP9MX4RD8j5juxdB5Dx86gL7FYhCQ+4xMOe7T/CWKZ
   ENB8w91de9Y2Dshzb4q+kSt7aklWQOGh6v5cdCbY7H7c3ePKLq939LK+u
   GO95Ubfysst4w9A1COQX0czmKQxN4eI8uxJgsSdIyK13/AaX3ZQXga8yQ
   RGTTsndR20wsQdDk+xeL6fcTgclAkJr/YLNvO9TOssLTSbYPzc0/IojSi
   w==;
X-CSE-ConnectionGUID: yurXb989TzKiR8F9qY3LGA==
X-CSE-MsgGUID: XMsfDL9mSHqFiTpvg+j5Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3591931"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3591931"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:19:18 -0800
X-CSE-ConnectionGUID: D04pzoWJRgyYip1bxMQS1g==
X-CSE-MsgGUID: dPJVQiuDSwSPeuR0CYsX4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9357980"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.124.249.52]) ([10.124.249.52])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 02:19:14 -0800
Message-ID: <5dc1b3a3-8e9d-4771-b70a-ace7d5b919df@linux.intel.com>
Date: Mon, 16 Nov 2026 18:19:11 +0800
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
Cc: baolu.lu@linux.intel.com, Robin Murphy <robin.murphy@arm.com>,
 Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>,
 Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Pratyush Yadav <pratyush@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 David Matlack <dmatlack@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Pranjal Shrivastava <praan@google.com>, Vipin Sharma <vipinsh@google.com>,
 Ankit Soni <Ankit.Soni@amd.com>, Nicolin Chen <nicolinc@nvidia.com>,
 John Starks <dev@jstarks.net>
Subject: Re: [PATCH v7 05/18] iommu: Implement device and IOMMU HW
 preservation
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261110040828.1774343-1-skhawaja@google.com>
 <20261110040828.1774343-6-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261110040828.1774343-6-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 12:08 PM, Samiullah Khawaja wrote:
> Add IOMMU ops to preserve/unpreserve the device state handled by the
> IOMMU driver. This is IOMMU specific state of the device that needs to
> be preserved for liveupdate. These ops can be implemented by the IOMMU
> drivers that support preservation of devices that have their IOMMU
> domains preserved. During device preservation the state of the
> associated IOMMU is also preserved as dependency.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>   drivers/iommu/iommu-priv.h       |   2 +
>   drivers/iommu/iommu.c            |  32 +++++-
>   drivers/iommu/liveupdate.c       | 191 +++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  76 ++++++++++++
>   include/linux/iommu.h            |  21 ++++
>   5 files changed, 321 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 1f9f886b2c10..8a14d38a3e70 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   
>   void dev_iommu_free(struct device *dev);
>   
> +size_t iommu_group_device_count(struct iommu_group *group);
> +
>   const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>   
>   static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fc..932325e0af41 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -18,6 +18,7 @@
>   #include <linux/errno.h>
>   #include <linux/host1x_context_bus.h>
>   #include <linux/iommu.h>
> +#include <linux/iommu-liveupdate.h>
>   #include <linux/iommufd.h>
>   #include <linux/idr.h>
>   #include <linux/err.h>
> @@ -626,8 +627,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>   
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
> +	struct group_device *gdev, *gdev2;
>   	struct iommu_group *group;
> -	struct group_device *gdev;
>   	int ret;
>   
>   	/*
> @@ -661,6 +662,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   		goto err_put_group;
>   	}
>   
> +	for_each_group_device(group, gdev2) {
> +		if (dev_iommu_has_preserved_state(gdev2->dev)) {
> +			ret = -EBUSY;
> +			goto err_free_gdev;
> +		}
> +	}
> +
>   	/*
>   	 * The gdev must be in the list before calling
>   	 * iommu_setup_default_domain()
> @@ -697,6 +705,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   err_remove_gdev:
>   	list_del(&gdev->list);
> +err_free_gdev:
>   	__iommu_group_free_device(group, gdev);
>   err_put_group:
>   	iommu_deinit_device(dev);
> @@ -3543,6 +3552,27 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>   
> +/**
> + * iommu_group_device_count() - Get the number of devices in a group
> + * @group: The group.
> + *
> + * The device count may change after this function returns, as devices can
> + * be added to or removed from the group. The caller must recheck it if it
> + * needs the count to stay the same.
> + *
> + * Return: the number of devices in the group.
> + */
> +size_t iommu_group_device_count(struct iommu_group *group)
> +{
> +	size_t count;
> +
> +	mutex_lock(&group->mutex);
> +	count = list_count_nodes(&group->devices);
> +	mutex_unlock(&group->mutex);
> +
> +	return count;
> +}
> +
>   static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   				   struct iommu_domain *domain)
>   {

[...]

> +/**
> + * iommu_preserve_device() - Preserve device state across live update
> + * @domain: Associated IOMMU domain
> + * @dev: Device to preserve
> + * @dma_owner_token: Token to identify DMA owner of this device
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 dma_owner_token)
> +{
> +	struct iommu_device_ser *device_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct dev_iommu *iommu;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return -EOPNOTSUPP;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return -EINVAL;
> +
> +	if (iommu_group_device_count(dev->iommu_group) != 1)
> +		return -EOPNOTSUPP;
> +
> +	if (iommu_get_domain_for_dev(dev) != domain)
> +		return -EINVAL;
> +
> +	pdev = to_pci_dev(dev);
> +	iommu = dev->iommu;
> +	if (!iommu->iommu_dev->ops->preserve_device ||
> +	    !iommu->iommu_dev->ops->unpreserve_device ||
> +	    !iommu->iommu_dev->ops->preserve ||
> +	    !iommu->iommu_dev->ops->unpreserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&flb_obj->lock);
> +	if (!domain->domain_ser) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	if (dev_iommu_preserved_state(dev)) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	device_ser = iommu_ser_set_alloc(&flb_obj->device_set);
> +	if (IS_ERR(device_ser)) {
> +		ret = PTR_ERR(device_ser);
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_preserve_locked(iommu->iommu_dev, flb_obj);
> +	if (ret) {
> +		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		goto out_unlock;
> +	}
> +
> +	device_ser->attachment.domain_phys = virt_to_phys(domain->domain_ser);
> +	device_ser->iommu_phys = virt_to_phys(iommu->iommu_dev->iommu_ser);
> +	device_ser->devid = pci_dev_id(pdev);
> +	device_ser->pci_domain_nr = pci_domain_nr(pdev->bus);
> +	device_ser->dma_owner_token = dma_owner_token;
> +
> +	ret = iommu->iommu_dev->ops->preserve_device(dev, device_ser);
> +	if (!ret) {
> +		WRITE_ONCE(dev->iommu->device_ser, device_ser);
> +
> +		/* Validate that no sibling device was added concurrently */
> +		if (iommu_group_device_count(dev->iommu_group) != 1) {
> +			iommu->iommu_dev->ops->unpreserve_device(dev, device_ser);
> +			WRITE_ONCE(dev->iommu->device_ser, NULL);
> +			ret = -EOPNOTSUPP;
> +		}
> +	}
> +
> +	if (ret) {
> +		device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +		goto out_unlock;
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_device);
Only devices in singleton iommu groups can be preserved, and no other
device may join the group while preservation is in progress or the
device remains preserved.

Could we simplify this by adding a flag to struct iommu_group, protected
by group->mutex? For example:

@@ -72,6 +72,9 @@ struct iommu_group {
          */
         unsigned int recovery_cnt;
         void *owner;
+#ifdef CONFIG_IOMMU_LIVEUPDATE
+       bool liveupdate_reserved;
+#endif
  };

A helper could check that the group contains exactly one device and set
the flag atomically under group->mutex. Device probing would reject an
addition if the flag is set.

#ifdef CONFIG_IOMMU_LIVEUPDATE
int iommu_group_reserve_liveupdate(struct iommu_group *group)
{
         int ret = 0;

         mutex_lock(&group->mutex);
         if (group->liveupdate_reserved)
                 ret = -EBUSY;
         else if (list_count_nodes(&group->devices) != 1)
                 ret = -EOPNOTSUPP;
         else
                 group->liveupdate_reserved = true;
         mutex_unlock(&group->mutex);

         return ret;
}

void iommu_group_unreserve_liveupdate(struct iommu_group *group)
{
         mutex_lock(&group->mutex);
         group->liveupdate_reserved = false;
         mutex_unlock(&group->mutex);
}
#endif

The reservation could be taken before calling the driver's preserve
callback and cleared on every failure path and after unpreservation.
This would avoid the second device-count check.

Any thoughts?

Thanks,
baolu
