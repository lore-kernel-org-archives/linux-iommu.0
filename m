From: Tomasz Nowicki <tn@semihalf.com>
Subject: Re: [RFC PATCH 30/30] vfio: Allow to bind foreign task
Date: Wed, 26 Apr 2017 09:25:38 +0200
Message-ID: <b937914a-d215-8223-0846-65271a568170@semihalf.com>
References: <20170227195441.5170-1-jean-philippe.brucker@arm.com>
 <20170227195441.5170-31-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20170227195441.5170-31-jean-philippe.brucker@arm.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Shanker Donthineni <shankerd@qti.qualcomm.com>, kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Joerg Roedel <joro@8bytes.org>, Sinan Kaya <okaya@qti.qualcomm.com>, Will Deacon <will.deacon@arm.com>, iommu@lists.linux-foundation.org, Harv Abdulhamid <harba@qti.qualcomm.com>, Alex Williamson <alex.williamson@redhat.com>, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, Nate Watterson <nwatters@qti.qualcomm.com>
List-Id: iommu@lists.linux-foundation.org

On 27.02.2017 20:54, Jean-Philippe Brucker wrote:
> Let the process that owns the device create an address space bond on
> behalf of another process. We add a pid argument to the BIND_TASK ioctl,
> allowing the caller to bind a foreign task. The expected program flow in
> this case is:
>
> * Process A creates the VFIO context and initializes the device.
> * Process B asks A to bind its address space.
> * Process A issues an ioctl to the VFIO device fd with BIND_TASK(pid).
>   It may communicate the given PASID back to process B or keep track of it
>   internally.
> * Process B asks A to perform transactions on its virtual address.
> * Process A launches transaction tagged with the given PASID.
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> ---
>  drivers/vfio/vfio.c       | 35 +++++++++++++++++++++++++++++++++--
>  include/uapi/linux/vfio.h | 15 +++++++++++++++
>  2 files changed, 48 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c4505d8f4c61..ecc5d07e3dbb 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/pci.h>
> +#include <linux/ptrace.h>
>  #include <linux/rwsem.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -1660,7 +1661,7 @@ static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
>  	struct vfio_device_svm svm;
>  	struct vfio_task *vfio_task;
>
> -	minsz = offsetofend(struct vfio_device_svm, pasid);
> +	minsz = offsetofend(struct vfio_device_svm, pid);
>
>  	if (copy_from_user(&svm, (void __user *)arg, minsz))
>  		return -EFAULT;
> @@ -1669,9 +1670,39 @@ static long vfio_svm_ioctl(struct vfio_device *device, unsigned int cmd,
>  		return -EINVAL;
>
>  	if (cmd == VFIO_DEVICE_BIND_TASK) {
> -		struct task_struct *task = current;
> +		struct mm_struct *mm;
> +		struct task_struct *task;
> +
> +		if (svm.flags & ~VFIO_SVM_PID)
> +			return -EINVAL;
> +
> +		if (svm.flags & VFIO_SVM_PID) {
> +			rcu_read_lock();
> +			task = find_task_by_vpid(svm.pid);
> +			if (task)
> +				get_task_struct(task);
> +			rcu_read_unlock();
> +			if (!task)
> +				return -ESRCH;
> +
> +			/*
> +			 * Ensure process has RW access on the task's mm
> +			 * FIXME:
> +			 * - I think this ought to be in the IOMMU API
> +			 * - I'm assuming permission is never revoked during the
> +			 *   task's lifetime. Might be mistaken.
> +			 */
> +			mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> +			if (!mm || IS_ERR(mm))

I know this is RFC patch but considering we will keep this as is, we 
need here:
+put_task_struct(task);


> +				return IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +			mmput(mm);
> +		} else {
> +			get_task_struct(current);
> +			task = current;
> +		}
>
>  		ret = iommu_bind_task(device->dev, task, &svm.pasid, 0, NULL);
> +		put_task_struct(task);
>  		if (ret)
>  			return ret;
>

Thanks,
Tomasz
