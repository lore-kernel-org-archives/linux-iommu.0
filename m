From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] VFIO: do pasid table binding
Date: Thu, 11 May 2017 18:29:56 +0800
Message-ID: <20170511102956.GE2931@gmail.com>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
 <1493201525-14418-7-git-send-email-yi.l.liu@intel.com>
 <9441ea23-1867-f59a-1ae3-be5afa4d51da@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9441ea23-1867-f59a-1ae3-be5afa4d51da@gmail.com>
Sender: kvm-owner@vger.kernel.org
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, alex.williamson@redhat.com, peterx@redhat.com, tianyu.lan@intel.com, kevin.tian@intel.com, ashok.raj@intel.com, jean-philippe.brucker@arm.com, jasowang@redhat.com, qemu-devel@nongnu.org, jacob.jun.pan@intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, May 09, 2017 at 03:55:20PM +0800, Xiao Guangrong wrote:
> 
> 
> On 04/26/2017 06:12 PM, Liu, Yi L wrote:
> >From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> >
> >This patch adds IOCTL processing in vfio_iommu_type1 for
> >VFIO_IOMMU_SVM_BIND_TASK. Binds the PASID table bind by
> >calling iommu_ops->bind_pasid_table to link the whole
> >PASID table to pIOMMU.
> >
> >For VT-d, it is linking the guest PASID table to host pIOMMU.
> >This is key point to support SVM virtualization on VT-d.
> >
> >Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >---
> >  drivers/vfio/vfio_iommu_type1.c | 72 +++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >
> >diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> >index b3cc33f..30b6d48 100644
> >--- a/drivers/vfio/vfio_iommu_type1.c
> >+++ b/drivers/vfio/vfio_iommu_type1.c
> >@@ -1512,6 +1512,50 @@ static int vfio_domains_have_iommu_cache(struct vfio_iommu *iommu)
> >  	return ret;
> >  }
> >+struct vfio_svm_task {
> >+	struct iommu_domain *domain;
> >+	void *payload;
> >+};
> >+
> >+static int bind_pasid_tbl_fn(struct device *dev, void *data)
> >+{
> >+	int ret = 0;
> >+	struct vfio_svm_task *task = data;
> >+	struct pasid_table_info *pasidt_binfo;
> >+
> >+	pasidt_binfo = task->payload;
> >+	ret = iommu_bind_pasid_table(task->domain, dev, pasidt_binfo);
> >+	return ret;
> >+}
> >+
> >+static int vfio_do_svm_task(struct vfio_iommu *iommu, void *data,
> >+				int (*fn)(struct device *, void *))
> >+{
> >+	int ret = 0;
> >+	struct vfio_domain *d;
> >+	struct vfio_group *g;
> >+	struct vfio_svm_task task;
> >+
> >+	task.payload = data;
> >+
> >+	mutex_lock(&iommu->lock);
> >+
> >+	list_for_each_entry(d, &iommu->domain_list, next) {
> >+		list_for_each_entry(g, &d->group_list, next) {
> >+			if (g->iommu_group != NULL) {
> >+				task.domain = d->domain;
> >+				ret = iommu_group_for_each_dev(
> >+					g->iommu_group, &task, fn);
> >+				if (ret != 0)
> >+					break;
> >+			}
> >+		}
> >+	}
> >+
> >+	mutex_unlock(&iommu->lock);
> >+	return ret;
> >+}
> >+
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> >@@ -1582,6 +1626,34 @@ static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> >+	} else if (cmd == VFIO_IOMMU_SVM_BIND_TASK) {
> >+		struct vfio_device_svm hdr;
> >+		u8 *data = NULL;
> >+		int ret = 0;
> >+
> >+		minsz = offsetofend(struct vfio_device_svm, length);
> >+		if (copy_from_user(&hdr, (void __user *)arg, minsz))
> >+			return -EFAULT;
> >+
> >+		if (hdr.length == 0)
> >+			return -EINVAL;
> >+
> >+		data = memdup_user((void __user *)(arg + minsz),
> >+					hdr.length);
> 
> You should check the @length is at least sizeof(struct pasid_table_info) as
> kernel uses it as pasid_table_info, a evil application can crash kernel.

Yes, thx for the remind.

Thanks,
Yi L 
