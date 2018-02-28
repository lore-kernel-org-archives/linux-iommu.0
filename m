From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Date: Wed, 28 Feb 2018 16:25:37 +0000
Message-ID: <e428976f-c381-309a-be57-264fea5c9b18@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-38-jean-philippe.brucker@arm.com>
	<1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1e76c66c-952e-71bd-d831-d3a1ded9559c-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
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
To: Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Sudeep Holla <Sudeep.Holla-5wv7dgnIgG8@public.gmane.org>, "christian.koenig-5C7GfCeVMHo@public.gmane.org" <christian.koenig-5C7GfCeVMHo@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 28/02/18 01:26, Sinan Kaya wrote:
[...]
>> +static int vfio_iommu_sva_init(struct device *dev, void *data)
>> +{
> 
> data is not getting used.

That's the pointer passed to "iommu_group_for_each_dev", NULL at the
moment. Next version of this patch will keep some state in data to
ensure one device per group.

>> +
>> +	int ret;
>> +
>> +	ret = iommu_sva_device_init(dev, IOMMU_SVA_FEAT_PASID |
>> +				    IOMMU_SVA_FEAT_IOPF, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iommu_register_mm_exit_handler(dev, vfio_iommu_mm_exit);
>> +}
>> +
>> +static int vfio_iommu_sva_shutdown(struct device *dev, void *data)
>> +{
>> +	iommu_sva_device_shutdown(dev);
>> +	iommu_unregister_mm_exit_handler(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +				 struct vfio_group *group,
>> +				 struct vfio_mm *vfio_mm)
>> +{
>> +	int ret;
>> +	int pasid;
>> +
>> +	if (!group->sva_enabled) {
>> +		ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +					       vfio_iommu_sva_init);
>> +		if (ret)
>> +			return ret;
>> +
>> +		group->sva_enabled = true;
>> +	}
>> +
>> +	ret = iommu_sva_bind_group(group->iommu_group, vfio_mm->mm, &pasid,
>> +				   IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF,
>> +				   vfio_mm);
>> +	if (ret)
>> +		return ret;
> 
> don't you need to clean up the work done by vfio_iommu_sva_init() here.

Yes I suppose we can, if we enabled during this bind

[...]
>> +static long vfio_iommu_type1_bind_process(struct vfio_iommu *iommu,
>> +					  void __user *arg,
>> +					  struct vfio_iommu_type1_bind *bind)
>> +{
>> +	struct vfio_iommu_type1_bind_process params;
>> +	struct vfio_domain *domain;
>> +	struct vfio_group *group;
>> +	struct vfio_mm *vfio_mm;
>> +	struct mm_struct *mm;
>> +	unsigned long minsz;
>> +	int ret = 0;
>> +
>> +	minsz = sizeof(*bind) + sizeof(params);
>> +	if (bind->argsz < minsz)
>> +		return -EINVAL;
>> +
>> +	arg += sizeof(*bind);
>> +	if (copy_from_user(&params, arg, sizeof(params)))
>> +		return -EFAULT;
>> +
>> +	if (params.flags & ~VFIO_IOMMU_BIND_PID)
>> +		return -EINVAL;
>> +
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
> 
> I think you can merge mm failure in both states.

Yes, I think vfio_iommu_get_mm_by_vpid could return NULL instead of an
error pointer, and we can throw -ESRCH in all cases (the existing
get_task_mm() failure in this driver does return -ESRCH, so it would be
consistent.)

[...]
>> +	/*
>> +	 * We can't simply unbind a foreign process by PASID, because the
>> +	 * process might have died and the PASID might have been reallocated to
>> +	 * another process. Instead we need to fetch that process mm by PID
>> +	 * again to make sure we remove the right vfio_mm. In addition, holding
>> +	 * the mm guarantees that mm_users isn't dropped while we unbind and the
>> +	 * exit_mm handler doesn't fire. While not strictly necessary, not
>> +	 * having to care about that race simplifies everyone's life.
>> +	 */
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
>> +
> 
> I think you can merge mm failure in both states.

ok

>> +	ret = -ESRCH;
>> +	mutex_lock(&iommu->lock);
>> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
>> +		if (vfio_mm->mm != mm)
>> +			continue;
>> +
> 
> these loops look wierd 
> 1. for loops + break 
> 2. for loops + goto
> 
> how about closing the for loop here. and then return here if not vfio_mm
> not found.

ok

>> +		vfio_iommu_unbind(iommu, vfio_mm);
>> +		list_del(&vfio_mm->next);
>> +		kfree(vfio_mm);
>> +		ret = 0;
>> +		break;
>> +	}
>> +	mutex_unlock(&iommu->lock);
>> +	mmput(mm);
>> +
>> +	return ret;
>> +}
>> +
> 

Thanks,
Jean
