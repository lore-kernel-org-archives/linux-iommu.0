Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426F519412E
	for <iommu@lists.linux.dev>; Thu, 29 Aug 2024 13:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939891; cv=none; b=q5to3Uy/ADSONUL2BnzezuIiW7MDmRftVtulqWWsTUa4TFYYW8mPRMo51OrNAvSKmNXE+LM1jOT08ZxtJhalkXNfNYcorDOPSG5No6E16exqSxEg4c1L+7AfiJgZzdvbM35butnB0eItFXgh6fbtpNCaEHU3WNq4QIfzuLOuOQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939891; c=relaxed/simple;
	bh=b5BaD0XeRvTetfsx5mFLuPPc+7NMzlcP6j2F9w9nt14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k68euXBLuRLWcEoq4Hx5qVWYwHaf0NnN0NuLeA+dylbRAVvG9j008lkpzJFQ7wNpffhwcPNz7zph/89YPsFj1I+O2f1dlGK+xfZUqTqqplLMiHs3Uned4Y3XEN2DRX4+FHk+RbtXnOnasTBLre7n9G9cM8DGNoW+HWw62I1XXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FCBADA7;
	Thu, 29 Aug 2024 06:58:34 -0700 (PDT)
Received: from [10.57.16.245] (unknown [10.57.16.245])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D4A5E3F66E;
	Thu, 29 Aug 2024 06:58:06 -0700 (PDT)
Message-ID: <ecf53bd6-6047-4ce5-92e9-41651e7ade15@arm.com>
Date: Thu, 29 Aug 2024 14:58:04 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] driver core: platform: Call iommu_release_device in
 dma_cleanup
To: Sachin Parekh <sachinparekh@google.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org, will@kernel.org
Cc: lokeshvutla@google.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev
References: <20240829120504.2976612-1-sachinparekh@google.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20240829120504.2976612-1-sachinparekh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-08-29 1:05 pm, Sachin Parekh wrote:
> Installing a kernel module that has an iommu node in its
> device tree increments corresponding iommu kernel module
> reference count during driver_register.
> Removing the same kernel module doesn't decrement the
> iommu reference count resulting in error while
> removing the iommu kernel module
> 
>      $ modprobe arm-smmu-v3
>      $ modprobe test_module
>      $ modprobe -r test_module
>      $ modprobe -r arm-smmu-v3
>      modprobe: can't unload module arm_smmu_v3: Resource temporarily unavailable
> 
> Cause:
>      platform_driver_register
>          ...
>          -> platform_dma_configure
>              ...
>              -> iommu_probe_device (Increments reference count)
> 
>      platform_driver_unregister
>          ...
>          -> platform_dma_cleanup
>              ...
>              -> No corresponding iommu_release_device call
> 
> Fix:
>      Call iommu_release_device in platform_dma_cleanup to remove the
>      iommu from the corresponding kernel module

There is nothing to fix here, the current behaviour is correct and 
expected. It appears the comment in of_iommu_configure() got lost, but 
the equivalent in acpi_iommu_configure_id() is still there - the dodgy 
iommu_probe_device() calls at those points still logically represent the 
same operation which should have happened via iommu_bus_notifier() or 
iommu_device_register(), it's just being replayed later for hacky reasons.

IOMMU groups are supposed to be tied to the lifetime of the struct 
device, and unbinding a driver does not make the device itself go away - 
if the devicetree says it exists, then the IOMMU layer knows that. 
Modular IOMMU drivers are still not really intended to be removable, 
unless all their client devices can actually be removed form the system 
(and/or the IOMMU driver is being tested without any clients present).

Thanks,
Robin.

> Signed-off-by: Sachin Parekh <sachinparekh@google.com>
> ---
>   drivers/base/platform.c | 3 +++
>   drivers/iommu/iommu.c   | 3 +--
>   include/linux/iommu.h   | 1 +
>   3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 4c3ee6521ba5..c8125325a5e9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1467,6 +1467,9 @@ static void platform_dma_cleanup(struct device *dev)
>   
>   	if (!drv->driver_managed_dma)
>   		iommu_device_unuse_default_domain(dev);
> +
> +	if (dev_of_node(dev))
> +		iommu_release_device(dev);
>   }
>   
>   static const struct dev_pm_ops platform_dev_pm_ops = {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index ed6c5cb60c5a..495f548fd4b9 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -92,7 +92,6 @@ static const char * const iommu_group_resv_type_string[] = {
>   
>   static int iommu_bus_notifier(struct notifier_block *nb,
>   			      unsigned long action, void *data);
> -static void iommu_release_device(struct device *dev);
>   static struct iommu_domain *
>   __iommu_group_domain_alloc(struct iommu_group *group, unsigned int type);
>   static int __iommu_attach_device(struct iommu_domain *domain,
> @@ -663,7 +662,7 @@ static void __iommu_group_remove_device(struct device *dev)
>   	iommu_group_put(group);
>   }
>   
> -static void iommu_release_device(struct device *dev)
> +void iommu_release_device(struct device *dev)
>   {
>   	struct iommu_group *group = dev->iommu_group;
>   
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 04cbdae0052e..2f9cb7d9dadf 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1049,6 +1049,7 @@ void dev_iommu_priv_set(struct device *dev, void *priv);
>   
>   extern struct mutex iommu_probe_device_lock;
>   int iommu_probe_device(struct device *dev);
> +void iommu_release_device(struct device *dev);
>   
>   int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
