Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793337161;
	b=Qg4D7ZLCgSMEWUz5Ws3RM8lu/EmLm6o4PjtlkudNHlSkjV2FJix3d+5eImn+l2paKZio
	 1nzxN4Fh/nCJgNP5Ebwx6QdYQjxQEjywag15IxCKkyJbekfiMPangRknc88m8n4wuLgM2
	 7jR934hdSOspXnDpqe8KHPUNYXkS0bW2sdY6HnePJSw1uV6GfGcapM9Bk2gnWe3RtQQlS
	 zmzgDRstwB2bqHt2LDtUwtN7bly41ehqQq6D1RO0mSbkeDfv8bWSjs7eagP286swGheNY
	 8SOmCEo1lpsNu+ur7tUm0diyG4ZwMvfp+Qq020fBuJDjiLAEOJU4guwBmf5vQG6Spvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793337161;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9zcaqLkIJCJ8/g2u2g9v1+SwkL0kqK7mo9nrgKHyYmU=;
	b=gAAA1CsjgDxGU0RTuXNiWn6byzH7n8tRwnKYVb/W+vQWk1waOOsCi+CWmu7yM+IySwAU
	 kOdyCqLJUUURyMVXpFxK0Gicj65bv3BORkr/jR9klVwdnl3gl4xS1Ni8kqoj5PrTqLgbH
	 1WfblKGPeLuW898HdGkjNSZgUGV4mpJjQkcGVDPGTHUVDjRPhwc9roxahv5MmeKvY2wC3
	 iQ43GJIfogtJ+f80gJZ7HwndknZPQQzSnd0WsfpzMQJP29b9zsbAnIkiXwW34cz3qr+k9
	 oNuZdDErbPLxMKAJp2oj5OhNAm8p/+9k02lYa+8FNksEMVDXphPOFYfhiEicDbLuLWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mi7nuHvo;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79D606A31A
	for <iommu@lists.linux.dev>; Fri, 30 Oct 2026 05:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF79D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mi7nuHvo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793337160; x=1824873160;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZFujzdybpllUA2fX9jvBk5gF4tQUbpjo+1BrXn9uaT8=;
  b=mi7nuHvoN5QHkVvFZwyhB1oFU8MpVWlkWHhgU7IeEW3HK0Vt/5AUfdds
   nDU4PUht3fq/OoyUA8xW2MrLGtn1INiPAKsMOrsdYO+NyLme12eglFghD
   mhXMlAArJhDQFB+K+JR2KMd62ku4rEP+WJvbnRPvcdUArp1cabIrYhTPK
   DWBV/EWkvwyB61Fhe0g/6YgU1XCXS6dl+U1M68UgDPUrGYKZYpM+qJiDf
   b7DT5w2WXAWUTHMgymZcTs46P16i2ceoizPSthSb6Yul2YNs8v+stIWIg
   KGEIgwaRzqxa9C2SjSZyVDOOz/fBNuqpXfONPXacV4H7mxF1/3G56AYJ1
   A==;
X-CSE-ConnectionGUID: pitlWaHcS6CybR3meljkcg==
X-CSE-MsgGUID: 58xu1lq+QrGubBkp7cOFwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1988270"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1988270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 22:12:39 -0700
X-CSE-ConnectionGUID: OsTvw9aRQSiuXg/UtvodRg==
X-CSE-MsgGUID: I6Ld2pQQSFODUThnUAzbNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5462972"
Received: from unknown (HELO [10.238.0.90]) ([10.238.0.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 22:12:34 -0700
Message-ID: <df75f891-05a0-4d47-8705-d6a00c81ff97@linux.intel.com>
Date: Fri, 30 Oct 2026 13:12:31 +0800
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
Subject: Re: [PATCH v6 05/18] iommu: Implement device and IOMMU HW
 preservation
To: Samiullah Khawaja <skhawaja@google.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
 David Woodhouse <dwmw2@infradead.org>
References: <20261025021930.674647-1-skhawaja@google.com>
 <20261025021930.674647-6-skhawaja@google.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20261025021930.674647-6-skhawaja@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/25/2026 10:19 AM, Samiullah Khawaja wrote:
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
>   drivers/iommu/iommu.c            |  72 +++++++++++-
>   drivers/iommu/liveupdate.c       | 189 +++++++++++++++++++++++++++++++
>   include/linux/iommu-liveupdate.h |  76 +++++++++++++
>   include/linux/iommu.h            |  33 ++++++
>   5 files changed, 371 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index 1f9f886b2c10..6b0ef210b32f 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   
>   void dev_iommu_free(struct device *dev);
>   
> +bool iommu_group_is_singleton(struct iommu_group *group);
> +
>   const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>   
>   static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index b486b8bbd1fc..a66363789ca9 100644
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
> @@ -328,6 +329,47 @@ void iommu_device_unregister(struct iommu_device *iommu)
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_unregister);
>   
> +struct iommu_dev_iter {
> +	struct iommu_device *iommu;
> +	iommu_dev_iter_fn fn;
> +};
> +
> +static int _iommu_for_each_dev_cb(struct device *dev, void *data)
> +{
> +	struct iommu_dev_iter *iter = data;
> +
> +	if (dev->iommu && dev->iommu->iommu_dev == iter->iommu)
> +		return iter->fn(dev, iter->iommu);
> +
> +	return 0;
> +}
> +
> +/**
> + * iommu_for_each_dev() - Iterate over all devices attached to an IOMMU
> + * @iommu: IOMMU instance
> + * @fn: Callback to call for each device attached to @iommu
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn)
> +{
> +	struct iommu_dev_iter iter = {
> +		.iommu = iommu,
> +		.fn = fn,
> +	};
> +	int ret;
> +
> +	for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++) {
> +		ret = bus_for_each_dev(iommu_buses[i], NULL, &iter,
> +				       _iommu_for_each_dev_cb);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iommu_for_each_dev);

The function has no locking against iommu probe or release, so the
callback can read dev->iommu while it is being freed or before it is
fully set up.

> +
>   #if IS_ENABLED(CONFIG_IOMMUFD_TEST)
>   void iommu_device_unregister_bus(struct iommu_device *iommu,
>   				 const struct bus_type *bus,
> @@ -626,8 +668,8 @@ DEFINE_MUTEX(iommu_probe_device_lock);
>   
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
> +	struct group_device *gdev, *gdev2;
>   	struct iommu_group *group;
> -	struct group_device *gdev;
>   	int ret;
>   
>   	/*
> @@ -661,6 +703,13 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
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
> @@ -697,6 +746,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   
>   err_remove_gdev:
>   	list_del(&gdev->list);
> +err_free_gdev:
>   	__iommu_group_free_device(group, gdev);
>   err_put_group:
>   	iommu_deinit_device(dev);
> @@ -3543,6 +3593,26 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
>   
> +/**
> + * iommu_group_is_singleton() - Query if group contains exactly one device
> + * @group: The group.
> + *
> + * Return: true if group contains exactly 1 device, false otherwise.
> + */

We discussed this interface before, and the consensus was that such an
interface is not feasible, because the membership of an iommu_group is
not fixed, given the hot-plug support of buses like PCI.

I am fine with the usage model of ensuring the iommu group of a
preserved device to be a singleton, but I don't think we even need such
a kAPI. It should be handled case by case.
> +bool iommu_group_is_singleton(struct iommu_group *group)
> +{
> +	bool ret;
> +
> +	if (!group)
> +		return false;
> +
> +	mutex_lock(&group->mutex);
> +	ret = (list_count_nodes(&group->devices) == 1);
> +	mutex_unlock(&group->mutex);
> +
> +	return ret;
> +}
> +
>   static void iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   				   struct iommu_domain *domain)
>   {
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index b7eda5615189..d1d11b28ae79 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -43,6 +43,9 @@
>   #include <linux/kexec_handover.h>
>   #include <linux/kho_block.h>
>   #include <linux/liveupdate.h>
> +#include <linux/pci.h>
> +
> +#include "iommu-priv.h"
>   
>   /**
>    * struct iommu_ser_set - Set of serialized objects of one type
> @@ -358,3 +361,189 @@ void iommu_unpreserve_domain(struct iommu_domain *domain)
>   	liveupdate_flb_put_outgoing(&iommu_flb);
>   }
>   EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
> +
> +static int iommu_preserve_locked(struct iommu_device *iommu,
> +				 struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	int ret;
> +
> +	if (!iommu->ops->preserve || !iommu->ops->unpreserve)
> +		return -EOPNOTSUPP;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (iommu->iommu_ser) {
> +		iommu->iommu_ser->hdr.ref_count++;
> +		return 0;
> +	}
> +
> +	iommu_hw_ser = iommu_ser_set_alloc(&flb_obj->iommu_set);
> +	if (IS_ERR(iommu_hw_ser))
> +		return PTR_ERR(iommu_hw_ser);
> +
> +	ret = iommu->ops->preserve(iommu, iommu_hw_ser);
> +	if (ret) {
> +		iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		return ret;
> +	}
> +
> +	iommu->iommu_ser = iommu_hw_ser;
> +	return ret;
> +}
> +
> +static void iommu_unpreserve_locked(struct iommu_device *iommu,
> +				    struct iommu_flb_obj *flb_obj)
> +{
> +	struct iommu_hw_ser *iommu_hw_ser = iommu->iommu_ser;
> +
> +	lockdep_assert_held(&flb_obj->lock);
> +	if (WARN_ON(!iommu_hw_ser))
> +		return;
> +
> +	if (WARN_ON_ONCE(!iommu->ops->preserve ||
> +			 !iommu->ops->unpreserve))
> +		return;
> +
> +	iommu_hw_ser->hdr.ref_count--;
> +	if (iommu_hw_ser->hdr.ref_count)
> +		return;
> +
> +	iommu->iommu_ser = NULL;
> +	iommu->ops->unpreserve(iommu, iommu_hw_ser);
> +	iommu_hw_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +}
> +
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
> +	if (!iommu_group_is_singleton(dev->iommu_group))
> +		return -EOPNOTSUPP;
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

Should we check that @domain is actually attached to the device? The
iommu core tracks the device's domain attachment, so what happens if
the caller's @domain doesn't match what the iommu core has recorded?

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
> +		if (!iommu_group_is_singleton(dev->iommu_group)) {
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
> +
> +/**
> + * iommu_unpreserve_device() - Unpreserve device state
> + * @domain: Associated IOMMU domain

@domain is not used anywhere in this function. Why is it needed?

> + * @dev: Device to unpreserve
> + */
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +	struct iommu_device_ser *iommu_device_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	struct dev_iommu *iommu;
> +	int ret;
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	if (!iommu_group_dma_owner_claimed(dev->iommu_group))
> +		return;
> +
> +	iommu = dev->iommu;
> +	if (WARN_ON(!iommu->iommu_dev->ops->unpreserve_device ||
> +		    !iommu->iommu_dev->ops->unpreserve))
> +		return;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	mutex_lock(&flb_obj->lock);
> +	iommu_device_ser = dev_iommu_preserved_state(dev);
> +	if (WARN_ON(!iommu_device_ser))
> +		goto out_unlock;
> +
> +	iommu_device_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +	iommu->iommu_dev->ops->unpreserve_device(dev, iommu_device_ser);
> +	WRITE_ONCE(dev->iommu->device_ser, NULL);
> +
> +	iommu_unpreserve_locked(iommu->iommu_dev, flb_obj);
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_device);
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index caa9778eee2d..cdf8a82b7f1d 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -8,6 +8,7 @@
>   #ifndef _LINUX_IOMMU_LIVEUPDATE_H
>   #define _LINUX_IOMMU_LIVEUPDATE_H
>   
> +#include <linux/device.h>
>   #include <linux/iommu.h>
>   #include <linux/liveupdate.h>
>   #include <linux/kho/abi/iommu.h>
> @@ -15,8 +16,58 @@
>   #ifdef CONFIG_IOMMU_LIVEUPDATE
>   int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>   void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
> +
> +/**
> + * dev_iommu_has_preserved_state() - Check if a device has live update state
> + * @dev: Target device
> + *
> + * Unlike dev_iommu_preserved_state() and dev_iommu_restored_state(), this does
> + * not dereference the serialized state, so it is safe to call without holding
> + * a reference on the live update FLB.
> + *
> + * Return: true if @dev has preserved (outgoing) or restored (incoming) state.
> + */
> +static inline bool dev_iommu_has_preserved_state(struct device *dev)
> +{
> +	return dev->iommu && READ_ONCE(dev->iommu->device_ser);
> +}
> +
> +/**
> + * dev_iommu_preserved_state() - Get preserved state of a device
> + * @dev: Target device
> + *
> + * Return: Pointer to preserved device state, or NULL if not preserved.
> + */
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	struct iommu_device_ser *ser;
> +
> +	if (!dev->iommu)
> +		return NULL;
> +
> +	ser = READ_ONCE(dev->iommu->device_ser);
> +	if (ser && !(ser->hdr.flags & IOMMU_SER_FLAG_INCOMING))
> +		return ser;
> +
> +	return NULL;
> +}
> +
>   int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
>   void iommu_unpreserve_domain(struct iommu_domain *domain);
> +int iommu_preserve_device(struct iommu_domain *domain,
> +			  struct device *dev, u64 dma_owner_token);
> +void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev);
> +
> +/**
> + * iommu_preserved_state() - Get preserved state of an IOMMU instance
> + * @iommu: IOMMU hardware instance
> + *
> + * Return: Pointer to preserved state, or NULL if not preserved.
> + */
> +static inline void *iommu_preserved_state(struct iommu_device *iommu)
> +{
> +	return iommu->iommu_ser;
> +}
>   #else
>   static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
>   {
> @@ -27,6 +78,16 @@ static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handle
>   {
>   }
>   
> +static inline bool dev_iommu_has_preserved_state(struct device *dev)
> +{
> +	return false;
> +}
> +
> +static inline void *dev_iommu_preserved_state(struct device *dev)
> +{
> +	return NULL;
> +}
> +
>   static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
>   {
>   	return -EOPNOTSUPP;
> @@ -35,5 +96,20 @@ static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iomm
>   static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
>   {
>   }
> +
> +static inline int iommu_preserve_device(struct iommu_domain *domain,
> +					struct device *dev, u64 dma_owner_token)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_device(struct iommu_domain *domain, struct device *dev)
> +{
> +}
> +
> +static inline void *iommu_preserved_state(struct iommu_device *iommu)
> +{
> +	return NULL;
> +}
>   #endif
>   #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 71e73c5181b5..35d028fe7126 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -684,6 +684,10 @@ __iommu_copy_struct_to_user(const struct iommu_user_data *dst_data,
>    *               resources shared/passed to user space IOMMU instance. Associate
>    *               it with a nesting @parent_domain. It is required for driver to
>    *               set @viommu->ops pointing to its own viommu_ops
> + * @preserve_device: Preserve state of a device for liveupdate.
> + * @unpreserve_device: Unpreserve state that was preserved earlier.
> + * @preserve: Preserve state of iommu translation hardware for liveupdate.
> + * @unpreserve: Unpreserve state of iommu that was preserved earlier.
>    * @owner: Driver module providing these ops
>    * @identity_domain: An always available, always attachable identity
>    *                   translation.
> @@ -740,6 +744,13 @@ struct iommu_ops {
>   			   struct iommu_domain *parent_domain,
>   			   const struct iommu_user_data *user_data);
>   
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	int (*preserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	void (*unpreserve_device)(struct device *dev, struct iommu_device_ser *device_ser);
> +	int (*preserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +	void (*unpreserve)(struct iommu_device *iommu, struct iommu_hw_ser *iommu_ser);
> +#endif
> +
>   	const struct iommu_domain_ops *default_domain_ops;
>   	struct module *owner;
>   	struct iommu_domain *identity_domain;
> @@ -827,6 +838,7 @@ struct iommu_domain_ops {
>    * @singleton_group: Used internally for drivers that have only one group
>    * @max_pasids: number of supported PASIDs
>    * @ready: set once iommu_device_register() has completed successfully
> + * @iommu_ser: preserved iommu state of outgoing kernel for liveupdate.
>    */
>   struct iommu_device {
>   	struct list_head list;
> @@ -836,6 +848,10 @@ struct iommu_device {
>   	struct iommu_group *singleton_group;
>   	u32 max_pasids;
>   	bool ready;
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_hw_ser *iommu_ser;
> +#endif
>   };
>   
>   /**
> @@ -875,6 +891,8 @@ struct iommu_fault_param {
>    * @pci_32bit_workaround: Limit DMA allocations to 32-bit IOVAs
>    * @require_direct: device requires IOMMU_RESV_DIRECT regions
>    * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
> + * @device_ser: preserved (outgoing) or restored (incoming) liveupdate state
> + *		of this device
>    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -890,6 +908,9 @@ struct dev_iommu {
>   	u32				pci_32bit_workaround:1;
>   	u32				require_direct:1;
>   	u32				shadow_on_flush:1;
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_device_ser		*device_ser;
> +#endif
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,
> @@ -1204,6 +1225,18 @@ static inline void *dev_iommu_priv_get(struct device *dev)
>   
>   void dev_iommu_priv_set(struct device *dev, void *priv);
>   
> +/**
> + * typedef iommu_dev_iter_fn - Callback for iterating IOMMU attached devices
> + * @dev: Attached device
> + * @iommu: IOMMU instance
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +typedef int (*iommu_dev_iter_fn)(struct device *dev,
> +				 struct iommu_device *iommu);
> +
> +int iommu_for_each_dev(struct iommu_device *iommu, iommu_dev_iter_fn fn);
> +
>   extern struct mutex iommu_probe_device_lock;
>   int iommu_probe_device(struct device *dev);
>   

Thanks,
baolu
