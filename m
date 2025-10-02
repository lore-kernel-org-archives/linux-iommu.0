Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AF256C6C
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759405723; cv=none; b=pkWRXwqsSHSx4RrRrz7EwbZ2SQ39+ZWSiA7jKhN7r1a40DflLpL7V6X0BgnLELVIW/MMTdrd6oON/y7be0PGuaKmBUdtWxIeZLrrB5kYNLYZIvkcNMFmmpqprYeh69Mk44t9bli2MogiA9I3mGSaxDxICWgX3S99/39C1Vjtoq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759405723; c=relaxed/simple;
	bh=FNRlhie3KHd4wCsDZxCRy24JbY25FHsakG6SAIaGnHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hYyT9V4YlnRladdzSGHz4L1MIDg4fgpr68uVr52iJ9nKp2FDonAxcS2YrVsfxihHMozFIsQQ8dhckbqBIS83Y9x/09xSgRZlZZDZEsR8bDIaw2HbecYBq0fXXRFZbiDqgb0mcQfg3jvMGS4KzWcip4FnOZXsQVxY4ICu40Elu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D6B8D168F;
	Thu,  2 Oct 2025 04:48:32 -0700 (PDT)
Received: from [10.57.2.183] (unknown [10.57.2.183])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE76A3F59E;
	Thu,  2 Oct 2025 04:48:37 -0700 (PDT)
Message-ID: <2d94b52c-cffc-40af-930a-20f0130a23ea@arm.com>
Date: Thu, 2 Oct 2025 12:48:35 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] iommu: fix device leaks
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Johan Hovold <johan@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sven Peter <sven@kernel.org>,
 Janne Grunau <j@jannau.net>, Rob Clark <robin.clark@oss.qualcomm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chen-Yu Tsai <wens@csie.org>, Thierry Reding <thierry.reding@gmail.com>,
 Krishna Reddy <vdumpa@nvidia.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250925122756.10910-1-johan@kernel.org>
 <20250930182158.GS2695987@ziepe.ca>
 <0d5d4d02-eb78-43dc-8784-83c0760099f7@arm.com>
 <20251001155851.GW2695987@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20251001155851.GW2695987@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-01 4:58 pm, Jason Gunthorpe wrote:
> On Tue, Sep 30, 2025 at 08:35:01PM +0100, Robin Murphy wrote:
>> On 2025-09-30 7:21 pm, Jason Gunthorpe wrote:
>>> On Thu, Sep 25, 2025 at 02:27:42PM +0200, Johan Hovold wrote:
>>>> This series fixes device leaks in the iommu drivers, which pretty
>>>> consistently failed to drop the reference taken by
>>>> of_find_device_by_node() when looking up iommu platform devices.
>>>
>>> Yes, they are mis-designed in many ways :\
>>
>> Historically they weren't really leaks either, just spare references on a
>> device which at that point could definitely never go away. I suppose now
>> that we finally have the .of_xlate calls in IOMMU registration, it would be
>> possible for some error during probe to cause the IOMMU driver to fail to
>> bind, at which point the references could rightly be considered leaked,
>> however these are all embedded platforms with essentially zero chance of
>> platform device hotplug, especially not of IOMMU devices, so realistically
>> those references still don't matter to anything other than code checkers.
>>
>> In summary; meh.
> 
> Yeah, it isn't a real practical bug, but it still ugly and no doubt
> upsets static tools.
> 
>>> IDK if it is worth fixing like this, or if more effort should be put
>>> to make the drivers use of_xlate properly - the arm smmu drivers show
>>> the only way to use it..
>>
>> The SMMU drivers are really doing the same thing, they just defer that
>> lookup operation to .probe_device time (largely for historical reasons, I
>> think), and they use bus_find_device_by_node()
> 
> However the SMMU drivers are doing this under the
> iommu_probe_device_lock and not stashing the pointer into a drvdata
> where there is no locking protecting it.

Huh? Every .of_xlate call is under probe_device_lock just as much as 
.probe_device calls are; they *have* to be, since they too are in the 
position of working with dev->iommu before dev->iommu_group is set to 
guarantee its stability.

>> It's not racy; if we're calling the .of_xlate op (or really any op for that
>> matter), it's because an IOMMU driver has registered (or is registering) for
>> the given fwnode, which means it is bound to the corresponding struct
>> device.
> 
> It is not racy if you make the very practical assumption there is no
> iommu driver unplug.

If the IOMMU code allowed a driver to be removed while it's in the 
middle of calling into that driver, that would hardly be the driver's 
fault. And indeed the driver cannot be removed, because we hold a module 
reference around the call (and if a buggy driver failed to suppress 
manual sysfs unbinding, this case is frankly one of the smallest drops 
in the ocean of catastrophic consequences there.)

> Anyhow, I drafted a nice fix for all of this. After all the rework it
> is trivial for the core code to pass in the struct iommu_device * to
> probe and then most of the drivers just drop this ugly code
> completely.
 >
 > https://github.com/jgunthorpe/linux/commits/iommu-fwspec/

Eww, that is neither nice nor a "fix". Once again it's just piling on a 
load of extra complexity to have multiple 
confusingly-overlapping-but-different ways of doing the same thing, one 
of which is still the exact same one you've decided to object to because 
you've failed to understand it (as demonstrated by the commit message 
below, the obvious bug in the hideous mess below that, and at a glance 
the other patches actively *breaking* at least one driver.)

Thanks,
Robin.

> 
> Jason
> 
> commit cca42a9b5325b96bfd3d74e24628511f537afbe9
> Author: Jason Gunthorpe <jgg@ziepe.ca>
> Date:   Wed Oct 1 09:18:13 2025 -0300
> 
>      iommu: Add a probe_device_fwspec() op
>      
>      For fwspec using drivers the core code has already determined which struct
>      iommu_device instance the fwspec is linked to. It can trivially pass that
>      instance pointer into the driver.
>      
>      This frees fwspec drivers from having to repeat the work of trying to find
>      the struct iommu_device for the fwspec.
>      
>      Non-fwspec drivers (x86/etc) continue to use the old probe function which
>      is called on the first non-fwspec iommu driver registered.
>      
>      This is only usable by drivers that support a single iommu instance per
>      device. There are some drivers (msm, exynos, dart) that do have an iommus
>      property that list multiple iommu_devices with multiple IDs. They cannot
>      use this simplified mechanism.
>      
>      Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 060ebe330ee163..718a1da8f54710 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -142,6 +142,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
>   				      struct group_device *grp_dev);
>   static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
>   			      const struct iommu_ops *ops);
> +static struct iommu_device *
> +iommu_from_fwnode(const struct fwnode_handle *fwnode);
>   
>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)		\
>   struct iommu_group_attribute iommu_group_attr_##_name =		\
> @@ -406,13 +408,75 @@ void dev_iommu_priv_set(struct device *dev, void *priv)
>   }
>   EXPORT_SYMBOL_GPL(dev_iommu_priv_set);
>   
> +static int iommu_do_probe_device(struct device *dev)
> +{
> +	struct iommu_device *iommu;
> +	int ret;
> +
> +	lockdep_assert_held(&iommu_probe_device_lock);
> +
> +	if (dev->iommu->fwspec) {
> +		struct iommu_device *fwspec_iommu;
> +
> +		fwspec_iommu =
> +			iommu_from_fwnode(dev->iommu->fwspec->iommu_fwnode);
> +		if (!fwspec_iommu)
> +			return -ENODEV;
> +
> +		if (fwspec_iommu->ops->probe_device_fwspec) {
> +			ret = fwspec_iommu->ops->probe_device_fwspec(
> +				fwspec_iommu, dev);
> +			if (ret)
> +				return ret;
> +			iommu = fwspec_iommu;
> +		} else {
> +			iommu = fwspec_iommu->ops->probe_device(dev);
> +			if (IS_ERR(iommu))
> +				return PTR_ERR(iommu);
> +			if (WARN_ON(iommu != fwspec_iommu)) {
> +				ret = -EINVAL;
> +				goto err_release;
> +			}
> +		}
> +	} else {
> +		/*
> +		 * At this point, relevant devices either now have a fwspec
> +		 * which will match ops registered with a non-NULL fwnode, or we
> +		 * can reasonably assume that only one of Intel, AMD, s390, PAMU
> +		 * or legacy SMMUv2 can be present, and that any of their
> +		 * registered instances has suitable ops for probing, and thus
> +		 * cheekily co-opt the same mechanism.
> +		 */
> +		iommu = iommu_from_fwnode(NULL);
> +		if (!iommu)
> +			return -ENODEV;
> +		/* Non fwspec drivers must identify their instance internally */
> +		if (WARN_ON(!iommu->ops->probe_device))
> +			return -EINVAL;
> +		iommu = iommu->ops->probe_device(dev);
> +		if (IS_ERR(iommu))
> +			return PTR_ERR(iommu);
> +	}
> +
> +	if (!try_module_get(iommu->ops->owner)) {
> +		ret = -EINVAL;
> +		goto err_release;
> +	}
> +
> +	dev->iommu->iommu_dev = iommu;
> +
> +err_release:
> +	if (iommu->ops->release_device)
> +		iommu->ops->release_device(dev);
> +	return ret;
> +}
> +
>   /*
>    * Init the dev->iommu and dev->iommu_group in the struct device and get the
>    * driver probed
>    */
>   static int iommu_init_device(struct device *dev)
>   {
> -	const struct iommu_ops *ops;
>   	struct iommu_device *iommu_dev;
>   	struct iommu_group *group;
>   	int ret;
> @@ -434,36 +498,17 @@ static int iommu_init_device(struct device *dev)
>   		if (!dev->iommu || dev->iommu_group)
>   			return -ENODEV;
>   	}
> -	/*
> -	 * At this point, relevant devices either now have a fwspec which will
> -	 * match ops registered with a non-NULL fwnode, or we can reasonably
> -	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
> -	 * be present, and that any of their registered instances has suitable
> -	 * ops for probing, and thus cheekily co-opt the same mechanism.
> -	 */
> -	ops = iommu_fwspec_ops(dev->iommu->fwspec);
> -	if (!ops) {
> -		ret = -ENODEV;
> -		goto err_free;
> -	}
>   
> -	if (!try_module_get(ops->owner)) {
> -		ret = -EINVAL;
> +	ret = iommu_do_probe_device(dev);
> +	if (ret)
>   		goto err_free;
> -	}
> -
> -	iommu_dev = ops->probe_device(dev);
> -	if (IS_ERR(iommu_dev)) {
> -		ret = PTR_ERR(iommu_dev);
> -		goto err_module_put;
> -	}
> -	dev->iommu->iommu_dev = iommu_dev;
> +	iommu_dev = dev->iommu->iommu_dev;
>   
>   	ret = iommu_device_link(iommu_dev, dev);
>   	if (ret)
>   		goto err_release;
>   
> -	group = ops->device_group(dev);
> +	group = iommu_dev->ops->device_group(dev);
>   	if (WARN_ON_ONCE(group == NULL))
>   		group = ERR_PTR(-EINVAL);
>   	if (IS_ERR(group)) {
> @@ -473,17 +518,17 @@ static int iommu_init_device(struct device *dev)
>   	dev->iommu_group = group;
>   
>   	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
> -	if (ops->is_attach_deferred)
> -		dev->iommu->attach_deferred = ops->is_attach_deferred(dev);
> +	if (iommu_dev->ops->is_attach_deferred)
> +		dev->iommu->attach_deferred =
> +			iommu_dev->ops->is_attach_deferred(dev);
>   	return 0;
>   
>   err_unlink:
>   	iommu_device_unlink(iommu_dev, dev);
>   err_release:
> -	if (ops->release_device)
> -		ops->release_device(dev);
> -err_module_put:
> -	module_put(ops->owner);
> +	if (iommu_dev->ops->release_device)
> +		iommu_dev->ops->release_device(dev);
> +	module_put(iommu_dev->ops->owner);
>   err_free:
>   	dev->iommu->iommu_dev = NULL;
>   	dev_iommu_free(dev);
> @@ -2855,9 +2900,10 @@ bool iommu_default_passthrough(void)
>   }
>   EXPORT_SYMBOL_GPL(iommu_default_passthrough);
>   
> -static const struct iommu_device *iommu_from_fwnode(const struct fwnode_handle *fwnode)
> +static struct iommu_device *iommu_from_fwnode(
> +	const struct fwnode_handle *fwnode)
>   {
> -	const struct iommu_device *iommu, *ret = NULL;
> +	struct iommu_device *iommu, *ret = NULL;
>   
>   	spin_lock(&iommu_device_lock);
>   	list_for_each_entry(iommu, &iommu_device_list, list)
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index c30d12e16473df..52e74ccdb4dc79 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -48,6 +48,7 @@ struct iommufd_ctx;
>   struct iommufd_viommu;
>   struct msi_desc;
>   struct msi_msg;
> +struct iommu_device;
>   
>   #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>   #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
> @@ -680,6 +681,8 @@ struct iommu_ops {
>   		struct device *dev, struct iommu_domain *parent, u32 flags,
>   		const struct iommu_user_data *user_data);
>   
> +	int (*probe_device_fwspec)(struct iommu_device *iommu,
> +				   struct device *dev);
>   	struct iommu_device *(*probe_device)(struct device *dev);
>   	void (*release_device)(struct device *dev);
>   	void (*probe_finalize)(struct device *dev);
