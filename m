From: Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
Subject: Re: [RFC PATCH 29/30] vfio: Add support for Shared Virtual Memory
Date: Wed, 26 Apr 2017 08:53:40 +0200
Message-ID: <f5745241-83b0-0945-7616-4b59d7ebcd48@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
	<20170227195441.5170-30-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170227195441.5170-30-jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: Shanker Donthineni <shankerd-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Harv Abdulhamid <harba-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nate Watterson <nwatters-Rm6X0d1/PG5y9aJCnZT0Uw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jean,

On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
> Add two new ioctl for VFIO devices. VFIO_DEVICE_BIND_TASK creates a bond
> between a device and a process address space, identified by a
> device-specific ID named PASID. This allows the device to target DMA
> transactions at the process virtual addresses without a need for mapping
> and unmapping buffers explicitly in the IOMMU. The process page tables are
> shared with the IOMMU, and mechanisms such as PCI ATS/PRI may be used to
> handle faults. VFIO_DEVICE_UNBIND_TASK removed a bond identified by a
> PASID.
>
> Also add a capability flag in device info to detect whether the system and
> the device support SVM.
>
> Users need to specify the state of a PASID when unbinding, with flags
> VFIO_PASID_RELEASE_FLUSHED and VFIO_PASID_RELEASE_CLEAN. Even for PCI,
> PASID invalidation is specific to each device and only partially covered
> by the specification:
>
> * Device must have an implementation-defined mechanism for stopping the
>   use of a PASID. When this mechanism finishes, the device has stopped
>   issuing transactions for this PASID and all transactions for this PASID
>   have been flushed to the IOMMU.
>
> * Device may either wait for all outstanding PRI requests for this PASID
>   to finish, or issue a Stop Marker message, a barrier that separates PRI
>   requests affecting this instance of the PASID from PRI requests
>   affecting the next instance. In the first case, we say that the PASID is
>   "clean", in the second case it is "flushed" (and the IOMMU has to wait
>   for the Stop Marker before reassigning the PASID.)
>
> We expect similar distinctions for platform devices. Ideally there should
> be a callback for each PCI device, allowing the IOMMU to ask the device to
> stop using a PASID. When the callback returns, the PASID is either flushed
> or clean and the return value tells which.
>
> For the moment I don't know how to implement this callback for PCI, so if
> the user forgets to call unbind with either "clean" or "flushed", the
> PASID is never reused. For platform devices, it might be simpler to
> implement since we could associate an invalidate_pasid callback to a DT
> compatible string, as is currently done for reset.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/vfio/pci/vfio_pci.c |  24 ++++++++++
>  drivers/vfio/vfio.c         | 104 ++++++++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/vfio.h   |  55 +++++++++++++++++++++++
>  3 files changed, 183 insertions(+)
>
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 324c52e3a1a4..3d7733f94891 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -22,6 +22,7 @@
>  #include <linux/mutex.h>
>  #include <linux/notifier.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
> @@ -623,6 +624,26 @@ int vfio_pci_register_dev_region(struct vfio_pci_device *vdev,
>  	return 0;
>  }
>

[...]

>
>  	kfree(device);
> @@ -1622,6 +1651,75 @@ static int vfio_device_fops_release(struct inode *inode, struct file *filep)
>  	return 0;
>  }
>
> +static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
> +			   unsigned long arg)
> +{
> +	int ret;
> +	unsigned long minsz;
> +
> +	struct vfio_device_svm svm;
> +	struct vfio_task *vfio_task;
> +
> +	minsz = offsetofend(struct vfio_device_svm, pasid);
> +
> +	if (copy_from_user(&svm, (void __user *)arg, minsz))
> +		return -EFAULT;
> +
> +	if (svm.argsz < minsz)
> +		return -EINVAL;
> +
> +	if (cmd == VFIO_DEVICE_BIND_TASK) {
> +		struct task_struct *task = current;
> +
> +		ret = iommu_bind_task(device->dev, task, &svm.pasid, 0, NULL);
> +		if (ret)
> +			return ret;
> +
> +		vfio_task = kzalloc(sizeof(*vfio_task), GFP_KERNEL);
> +		if (!vfio_task) {
> +			iommu_unbind_task(device->dev, svm.pasid,
> +					  IOMMU_PASID_CLEAN);
> +			return -ENOMEM;
> +		}
> +
> +		vfio_task->pasid = svm.pasid;
> +
> +		mutex_lock(&device->tasks_lock);
> +		list_add(&vfio_task->list, &device->tasks);
> +		mutex_unlock(&device->tasks_lock);
> +
> +	} else {
> +		int flags = 0;
> +
> +		if (svm.flags & ~(VFIO_SVM_PASID_RELEASE_FLUSHED |
> +				  VFIO_SVM_PASID_RELEASE_CLEAN))
> +			return -EINVAL;
> +
> +		if (svm.flags & VFIO_SVM_PASID_RELEASE_FLUSHED)
> +			flags = IOMMU_PASID_FLUSHED;
> +		else if (svm.flags & VFIO_SVM_PASID_RELEASE_CLEAN)
> +			flags = IOMMU_PASID_CLEAN;
> +
> +		mutex_lock(&device->tasks_lock);
> +		list_for_each_entry(vfio_task, &device->tasks, list) {
> +			if (vfio_task->pasid != svm.pasid)
> +				continue;
> +
> +			ret = iommu_unbind_task(device->dev, svm.pasid, flags);
> +			if (ret)
> +				dev_warn(device->dev, "failed to unbind PASID %u\n",
> +					 vfio_task->pasid);
> +
> +			list_del(&vfio_task->list);
> +			kfree(vfio_task);

Please use list_for_each_entry_safe.

Thanks,
Tomasz
