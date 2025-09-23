Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCA246BB4
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 01:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591213; cv=none; b=Z8nNQJ93cp10Kwhc8NjOMNOcnk0amQAUKwQZ+erg0jXDr6DQ2Y4HN9G1c4uKuAwgXjdun2U2H52jVYrmfxekJh0yuAlxISSD6WglHPKnE6sbnVCEmFGl1FEe06tmIDX3HpU2NIXIElDJ+6Fc2LLnLSJPrjHUC5nATgPV00c8cAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591213; c=relaxed/simple;
	bh=RtQ68dc88HyxiXQwg9nWrLqDLMBOIn5jG2fLVurd+No=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=cfN+/IqDJz1v7FANKxGgDtrIkl7+tA7FGnHb71XhdTgLfCOKk5J6suAx9HmPBuyaE8fmMaMs4D0YL4UPH3lwkQxU3DmIk93vlwSsXZA9LfyzDKIUEEyMQfyNVO0JGxkcjnXRxZ25PKSevxmCG/z7zQ4mvcGYpgNYjRS6Zln0eag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=IAskNEoV; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="IAskNEoV"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758591201; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=aIqrGvWECZHymrVA7saNx4G2xh41R7RZE9RVmcQnxdM=;
	b=IAskNEoVpl7ZX+9bLHEF+26zIHgsqWuOwVyLwi62/LXTocrcNWN7wCtfugeSiAaRO5rE2Yi7A3SDOrNV0GTycVqYQCGgsWQaa28QzFtzZHaFDSGSQzFs9NoINTC2s/FN0JJiInnFyJ8L9VLJZ1tsY+fr1G20BruAo4p1VM/EsVI=
Received: from 30.178.82.20(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wociq5D_1758591199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Sep 2025 09:33:20 +0800
Message-ID: <638675e3-4d86-40f6-88dd-4a6e826aac51@linux.alibaba.com>
Date: Tue, 23 Sep 2025 09:33:19 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH v2] iommu: Fix iommu selftest running test mock domain
 fail
From: Guixin Liu <kanie@linux.alibaba.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
References: <20250916090333.68179-1-kanie@linux.alibaba.com>
In-Reply-To: <20250916090333.68179-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Gently ping...

Best Regards,
Guixin Liu

在 2025/9/16 17:03, Guixin Liu 写道:
> When intel_iommu=on is enabled and the iommu selftests are executed,
> we observed multiple test case failures. Our investigation revealed
> that both the Intel iommu driver and the mock iommu driver registered
> iommu_device instances with fwnode=NULL, and both were added to the
> iommu_device_list. Later, when the mock iommu driver attempted to
> create a device, iommu_init_device attempted to retrieve the iommu_ops
> by searching the iommu_device_list using the provided fwnode
> (which was NULL).
> Since the iommu_device registered by the Intel iommu driver appeared
> earlier in the list, it was matched first instead of the mock iommu
> driver's iommu_device. This ultimately caused probe_device to fail.
>
> Fix this by alloc a software fwnode for mock iommu driver's iommu_device,
> and set it to the device which mock iommu driver created.
>
> Test by "make -C toosl/testing/selftests TARGETS=iommu run_tests":
> PASSED: 229 / 229 tests passed.
>
> In addition, this issue is also can be found on amd platform, and
> also tested on a amd machine.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Tested-by: Qinyun Tan <qinyuntan@linux.alibaba.com>
> ---
> Changes from v1 to v2:
> - Remove print when iommu_fwspec_init() fail.
>
>   drivers/iommu/iommu.c            | 12 ++++++++++++
>   drivers/iommu/iommufd/selftest.c |  9 +++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee1..cda5e1c039aa 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -304,6 +304,7 @@ void iommu_device_unregister_bus(struct iommu_device *iommu,
>   				 struct notifier_block *nb)
>   {
>   	bus_unregister_notifier(bus, nb);
> +	fwnode_remove_software_node(iommu->fwnode);
>   	iommu_device_unregister(iommu);
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_unregister_bus);
> @@ -326,6 +327,14 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>   	if (err)
>   		return err;
>   
> +	iommu->fwnode = fwnode_create_software_node(NULL, NULL);
> +	if (IS_ERR(iommu->fwnode)) {
> +		iommu->fwnode = NULL;
> +		dev_err(iommu->dev, "add property failed:%d\n", err);
> +		bus_unregister_notifier(bus, nb);
> +		return err;
> +	}
> +
>   	spin_lock(&iommu_device_lock);
>   	list_add_tail(&iommu->list, &iommu_device_list);
>   	spin_unlock(&iommu_device_lock);
> @@ -335,6 +344,7 @@ int iommu_device_register_bus(struct iommu_device *iommu,
>   		iommu_device_unregister_bus(iommu, bus, nb);
>   		return err;
>   	}
> +	WRITE_ONCE(iommu->ready, true);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(iommu_device_register_bus);
> @@ -555,6 +565,7 @@ static struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>   }
>   
>   DEFINE_MUTEX(iommu_probe_device_lock);
> +EXPORT_SYMBOL_GPL(iommu_probe_device_lock);
>   
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
> @@ -2914,6 +2925,7 @@ void iommu_fwspec_free(struct device *dev)
>   		dev_iommu_fwspec_set(dev, NULL);
>   	}
>   }
> +EXPORT_SYMBOL_GPL(iommu_fwspec_free);
>   
>   int iommu_fwspec_add_ids(struct device *dev, const u32 *ids, int num_ids)
>   {
> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> index 61686603c769..632efba3b77a 100644
> --- a/drivers/iommu/iommufd/selftest.c
> +++ b/drivers/iommu/iommufd/selftest.c
> @@ -1126,12 +1126,21 @@ static struct mock_dev *mock_dev_create(unsigned long dev_flags)
>   		goto err_put;
>   	}
>   
> +	mutex_lock(&iommu_probe_device_lock);
> +	rc = iommu_fwspec_init(&mdev->dev, mock_iommu.iommu_dev.fwnode);
> +	if (rc) {
> +		mutex_unlock(&iommu_probe_device_lock);
> +		goto err_put;
> +	}
> +	mutex_unlock(&iommu_probe_device_lock);
> +
>   	rc = device_add(&mdev->dev);
>   	if (rc)
>   		goto err_put;
>   	return mdev;
>   
>   err_put:
> +	iommu_fwspec_free(&mdev->dev);
>   	put_device(&mdev->dev);
>   	return ERR_PTR(rc);
>   }

