From: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 2/9] iommu/vt-d: Decouple idr bond pointer from svm
Date: Tue, 1 May 2018 09:21:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE74EB@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
 <1523934202-21669-3-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523934202-21669-3-git-send-email-baolu.lu@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lu Baolu <baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>, "Pan, Jacob jun" <jacob.jun.pan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jacob Pan <jacob.jun.pan@linux.intel.com>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu@linux.intel.com]
> Sent: Tuesday, April 17, 2018 11:03 AM
> Subject: [PATCH 2/9] iommu/vt-d: Decouple idr bond pointer from svm
> 
> As we move the PASID idr out of SVM code and make it serving
> as a global PASID name space, the consumer can specify a ptr
> to bind it with a PASID. We shouldn't assume that each PASID
> will be bond with a ptr of struct intel_svm anymore.
> This patch cleans up a idr_for_each_entry() usage in the SVM
> code. It's required to replace the SVM-specific idr with the
> global PASID idr.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Looks good to me.
Reviewed-by: Liu, Yi L <yi.l.liu@intel.com>

Regards,
Yi Liu
>  drivers/iommu/intel-svm.c   | 14 ++++++++++----
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index e8cd984..983af0c 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -298,6 +298,7 @@ static const struct mmu_notifier_ops intel_mmuops = {
>  };
> 
>  static DEFINE_MUTEX(pasid_mutex);
> +static LIST_HEAD(global_svm_list);
> 
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops
> *ops)
>  {
> @@ -329,13 +330,13 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
> 
>  	mutex_lock(&pasid_mutex);
>  	if (pasid && !(flags & SVM_FLAG_PRIVATE_PASID)) {
> -		int i;
> +		struct intel_svm *t;
> 
> -		idr_for_each_entry(&iommu->pasid_idr, svm, i) {
> -			if (svm->mm != mm ||
> -			    (svm->flags & SVM_FLAG_PRIVATE_PASID))
> +		list_for_each_entry(t, &global_svm_list, list) {
> +			if (t->mm != mm || (t->flags & SVM_FLAG_PRIVATE_PASID))
>  				continue;
> 
> +			svm = t;
>  			if (svm->pasid >= pasid_max) {
>  				dev_warn(dev,
>  					 "Limited PASID width. Cannot use existing
> PASID %d\n",
> @@ -404,6 +405,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  		svm->mm = mm;
>  		svm->flags = flags;
>  		INIT_LIST_HEAD_RCU(&svm->devs);
> +		INIT_LIST_HEAD(&svm->list);
>  		ret = -ENOMEM;
>  		if (mm) {
>  			ret = mmu_notifier_register(&svm->notifier, mm);
> @@ -430,6 +432,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  		 */
>  		if (cap_caching_mode(iommu->cap))
>  			intel_flush_pasid_dev(svm, sdev, svm->pasid);
> +
> +		list_add_tail(&svm->list, &global_svm_list);
>  	}
>  	list_add_rcu(&sdev->list, &svm->devs);
> 
> @@ -485,6 +489,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm-
> >notifier, svm->mm);
> 
> +					list_del(&svm->list);
> +
>  					/* We mandate that no page faults may be
> outstanding
>  					 * for the PASID when
> intel_svm_unbind_mm() is called.
>  					 * If that is not obeyed, subtle errors will
> happen.
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ef169d6..795717e 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -486,6 +486,7 @@ struct intel_svm {
>  	int flags;
>  	int pasid;
>  	struct list_head devs;
> +	struct list_head list;
>  };
> 
>  extern int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct
> intel_svm_dev *sdev);
> --
> 2.7.4
