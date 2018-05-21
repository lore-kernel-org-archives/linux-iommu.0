From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
Date: Mon, 21 May 2018 15:51:29 +0100
Message-ID: <5775e215-9a71-355a-98f5-397f1917b7f7@arm.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
	<20180511190641.23008-14-jean-philippe.brucker@arm.com>
	<20180517165845.00000cc9@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180517165845.00000cc9-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jonathan Cameron <Jonathan.Cameron-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org, ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rgummal-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, christian.koenig-5C7GfCeVMHo@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 17/05/18 16:58, Jonathan Cameron wrote:
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +				 struct vfio_group *group,
>> +				 struct vfio_mm *vfio_mm)
>> +{
>> +	int ret;
>> +	bool enabled_sva = false;
>> +	struct vfio_iommu_sva_bind_data data = {
>> +		.vfio_mm	= vfio_mm,
>> +		.iommu		= iommu,
>> +		.count		= 0,
>> +	};
>> +
>> +	if (!group->sva_enabled) {
>> +		ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +					       vfio_iommu_sva_init);
>> +		if (ret)
>> +			return ret;
>> +
>> +		group->sva_enabled = enabled_sva = true;
>> +	}
>> +
>> +	ret = iommu_group_for_each_dev(group->iommu_group, &data,
>> +				       vfio_iommu_sva_bind_dev);
>> +	if (ret && data.count > 1)
> 
> Are we safe to run this even if data.count == 1?  I assume that at
> that point we would always not have an iommu domain associated with the
> device so the initial check would error out.

If data.count == 1, then the first bind didn't succeed. But it's not
necessarily a domain missing, failure to bind may come from various
places. If this vfio_mm was already bound to another device then it
contains a valid PASID and it's safe to call unbind(). Otherwise we call
it with PASID -1 (VFIO_INVALID_PASID) and that's a bit of a grey area.
-1 is currently invalid everywhere, but in the future someone might
implement 32 bits of PASIDs, in which case a bond between this dev and
PASID -1 might exist. But I think it's safe for now, and whoever
redefines VFIO_INVALID_PASID when such implementation appears will also
fix this case.

> Just be nice to get rid of the special casing in this error path as then
> could just do it all under if (ret) and make it visually clearer these
> are different aspects of the same error path.

[...]
>>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  				   unsigned int cmd, unsigned long arg)
>>  {
>> @@ -1728,6 +2097,44 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>>  
>>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>>  			-EFAULT : 0;
>> +
>> +	} else if (cmd == VFIO_IOMMU_BIND) {
>> +		struct vfio_iommu_type1_bind bind;
>> +
>> +		minsz = offsetofend(struct vfio_iommu_type1_bind, flags);
>> +
>> +		if (copy_from_user(&bind, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (bind.argsz < minsz)
>> +			return -EINVAL;
>> +
>> +		switch (bind.flags) {
>> +		case VFIO_IOMMU_BIND_PROCESS:
>> +			return vfio_iommu_type1_bind_process(iommu, (void *)arg,
>> +							     &bind);
> 
> Can we combine these two blocks given it is only this case statement that is different?

That would be nicer, though I don't know yet what's needed for vSVA (by
Yi Liu on Cc), which will add statements to the switches.

Thanks,
Jean

> 
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +
>> +	} else if (cmd == VFIO_IOMMU_UNBIND) {
>> +		struct vfio_iommu_type1_bind bind;
>> +
>> +		minsz = offsetofend(struct vfio_iommu_type1_bind, flags);
>> +
>> +		if (copy_from_user(&bind, (void __user *)arg, minsz))
>> +			return -EFAULT;
>> +
>> +		if (bind.argsz < minsz)
>> +			return -EINVAL;
>> +
>> +		switch (bind.flags) {
>> +		case VFIO_IOMMU_BIND_PROCESS:
>> +			return vfio_iommu_type1_unbind_process(iommu, (void *)arg,
>> +							       &bind);
>> +		default:
>> +			return -EINVAL;
>> +		}
>>  	}
