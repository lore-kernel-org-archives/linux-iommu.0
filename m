From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
Date: Tue, 20 Feb 2018 11:26:48 +0000
Message-ID: <5789fb21-dd4b-85a3-e5fc-7212a01fecc7@arm.com>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
	<20180212183352.22730-38-jean-philippe.brucker@arm.com>
	<20180216123329.10f6dc23@w520.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180216123329.10f6dc23-DGNDKt5SQtizQB+pC5nmwQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <ilias.apalodimas-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <xuzaibo-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Will Deacon <Will.Deacon-5wv7dgnIgG8@public.gmane.org>, "okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <bharatku-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Catalin Marinas <Catalin.Marinas-5wv7dgnIgG8@public.gmane.org>, "rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org" <rfranz-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, rjw@rjwyso
List-Id: iommu@lists.linux-foundation.org

On 16/02/18 19:33, Alex Williamson wrote:
[...]
>> +static int vfio_iommu_sva_init(struct device *dev, void *data)
>> +{
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
> 
> Typically the order would be reverse of the setup, is it correct this
> way?

I don't think it matters either way, but ABBA order would be nicer.
Registering mm_exit handler before sva_device_init is probably best.

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
> 
> Seems were at an unknown state here, do we need to undo any that
> succeeded?

I think we do. However following the discussion on patch 2/37 it seems
we should limit SVA to singular groups for the moment, disallowing it if
the group has more than one device. Handling compound groups is
complicated and hopefully not needed by SVA systems. So I'd like to
change the logic here and ensure group_for_each_dev only calls sva_init
once.

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
> 
> I don't understand how this works for a process that has exited, the
> mm_exit function gets called to clear vfio_mm.mm, the above may or may
> not work (could be new ptrace'able process with same pid), but it won't
> match the mm below, so is the vfio_mm that mm_exit zapped forever stuck
> in this list until the container is destroyed?

Yes, it's not nice. mm_exit() is called with a spinlock held, so it
can't take the iommu->lock and modify mm_list.
vfio_iommu_type1_unbind_process() could do a bit of garbage collection
and remove all defunct vfio_mm, if they're not held by any iommu_bond
anymore.

But I think iommu_notifier_release (patch 5/37) can actually release the
lock temporarily if it's careful about concurrent list modifications
(and takes a ref to the given bond), in which case we can remove this
mm_exit() constraint and simplify the VFIO patch.

[...]
>> +/*
>> + * Only mode supported at the moment is VFIO_IOMMU_BIND_PROCESS, which takes
>> + * vfio_iommu_type1_bind_process in data.
>> + */
>> +struct vfio_iommu_type1_bind {
>> +	__u32	argsz;
>> +	__u32	mode;
> 
> s/mode/flags/
> 
>> +#define VFIO_IOMMU_BIND_PROCESS		(1 << 0)
>> +	__u8	data[];
>> +};
> 
> I'm not convinced having a separate vfio_iommu_type1_bind_process
> struct is necessary.  It seems like we always expect to return a pasid,
> only the pid is optional, but that could be handled by a single
> structure with a flag bit to indicate a pid bind is requested.

We were planning to reuse VFIO_IOMMU_BIND for PASID table binding as
well. So vfio_iommu_type1_bind::flags would either be
VFIO_IOMMU_BIND_PROCESS or VFIO_IOMMU_BIND_PASID_TABLE, and
vfio_iommu_type1_bind::data is an union of vfio_iommu_type1_bind_process
and vfio_iommu_type1_bind_pasid_table

https://patchwork.kernel.org/patch/9701025/

> 
>> +
>> +/*
>> + * VFIO_IOMMU_BIND - _IOWR(VFIO_TYPE, VFIO_BASE + 22, struct vfio_iommu_bind)
> 
> vfio_iommu_type1_bind

Thanks,
Jean
