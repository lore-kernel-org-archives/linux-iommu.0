From: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [RFC PATCH 6/8] VFIO: do pasid table binding
Date: Fri, 12 May 2017 15:59:01 -0600
Message-ID: <20170512155901.011790b6@t450s.home>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
        <1493201525-14418-7-git-send-email-yi.l.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1493201525-14418-7-git-send-email-yi.l.liu@intel.com>
Sender: kvm-owner@vger.kernel.org
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, 26 Apr 2017 18:12:03 +0800
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> 
> This patch adds IOCTL processing in vfio_iommu_type1 for
> VFIO_IOMMU_SVM_BIND_TASK. Binds the PASID table bind by
> calling iommu_ops->bind_pasid_table to link the whole
> PASID table to pIOMMU.
> 
> For VT-d, it is linking the guest PASID table to host pIOMMU.
> This is key point to support SVM virtualization on VT-d.
> 
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/vfio/vfio_iommu_type1.c | 72 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index b3cc33f..30b6d48 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -1512,6 +1512,50 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
>  	return ret;
>  }
>  
> +struct vfio_svm_task {
> +	struct iommu_domain *domain;
> +	void *payload;
> +};
> +
> +static int bind_pasid_tbl_fn(struct device *dev, void *data)
> +{
> +	int ret = 0;
> +	struct vfio_svm_task *task = data;

Maybe avoid "task" or use svm_task to differentiate from task_struct
task used elsewhere in this file.

> +	struct pasid_table_info *pasidt_binfo;
> +
> +	pasidt_binfo = task->payload;
> +	ret = iommu_bind_pasid_table(task->domain, dev, pasidt_binfo);
> +	return ret;
> +}
> +
> +static int vfio_do_svm_task(struct vfio_iommu *iommu, void *data,
> +				int (*fn)(struct device *, void *))
> +{
> +	int ret = 0;
> +	struct vfio_domain *d;
> +	struct vfio_group *g;
> +	struct vfio_svm_task task;
> +
> +	task.payload = data;
> +
> +	mutex_lock(&iommu->lock);
> +
> +	list_for_each_entry(d, &iommu->domain_list, next) {
> +		list_for_each_entry(g, &d->group_list, next) {
> +			if (g->iommu_group != NULL) {

Can it ever be NULL?

> +				task.domain = d->domain;
> +				ret = iommu_group_for_each_dev(
> +					g->iommu_group, &task, fn);
> +				if (ret != 0)
> +					break;
> +			}
> +		}
> +	}
> +
> +	mutex_unlock(&iommu->lock);
> +	return ret;
> +}
> +
>  static long vfio_iommu_type1_ioctl(void *iommu_data,
>  				   unsigned int cmd, unsigned long arg)
>  {
> @@ -1582,6 +1626,34 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
>  
>  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
>  			-EFAULT : 0;
> +	} else if (cmd == VFIO_IOMMU_SVM_BIND_TASK) {
> +		struct vfio_device_svm hdr;
> +		u8 *data = NULL;

But it really should be a struct pasid_table_info.

> +		int ret = 0;
> +
> +		minsz = offsetofend(struct vfio_device_svm, length);
> +		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> +			return -EFAULT;
> +
> +		if (hdr.length == 0)
> +			return -EINVAL;
> +
> +		data = memdup_user((void __user *)(arg + minsz),
> +					hdr.length);
> +		if (IS_ERR(data))
> +			return PTR_ERR(data);
> +
> +		switch (hdr.flags & VFIO_SVM_TYPE_MASK) {
> +		case VFIO_SVM_BIND_PASIDTBL:
> +			ret = vfio_do_svm_task(iommu, data,
> +						bind_pasid_tbl_fn);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		kfree(data);
> +		return ret;
>  	}
>  
>  	return -ENOTTY;
