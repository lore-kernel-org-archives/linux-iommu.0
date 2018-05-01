From: "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH 8/9] iommu/vt-d: Use per-domain pasid table
Date: Tue, 1 May 2018 09:23:57 +0000
Message-ID: <A2975661238FB949B60364EF0F2C257439BE7558@SHSMSX104.ccr.corp.intel.com>
References: <1523934202-21669-1-git-send-email-baolu.lu@linux.intel.com>
	<1523934202-21669-9-git-send-email-baolu.lu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1523934202-21669-9-git-send-email-baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
To: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> Sent: Tuesday, April 17, 2018 11:03 AM
> 
> This patch replaces current per iommu pasid table with
> the new added per domain pasid table. Each svm-capable
> PCI device will have its own pasid table.

This is not accurate. pasid table is per-iommu domain. May
more accurate "Each svm-capable PCI device will be configed
with a pasid table which shares with other svm-capable device
within its iommu domain"

Can include my reviewed by after refining the description.

Reviewed-by: Liu, Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Thanks,
Yi Liu
> 
> Cc: Ashok Raj <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> Cc: Kevin Tian <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Cc: Liu Yi L <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/intel-iommu.c |  6 +++---
>  drivers/iommu/intel-svm.c   | 37 +++++++++++++++++++++++++------------
>  2 files changed, 28 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index d4f9cea..5fe7f91 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5191,7 +5191,7 @@ int intel_iommu_enable_pasid(struct intel_iommu
> *iommu, struct intel_svm_dev *sd
>  	if (!(ctx_lo & CONTEXT_PASIDE)) {
>  		if (iommu->pasid_state_table)
>  			context[1].hi = (u64)virt_to_phys(iommu-
> >pasid_state_table);
> -		context[1].lo = (u64)virt_to_phys(iommu->pasid_table) |
> +		context[1].lo = (u64)virt_to_phys(domain->pasid_table) |
>  			intel_iommu_get_pts(domain);
> 
>  		wmb();
> @@ -5259,8 +5259,8 @@ struct intel_iommu *intel_svm_device_to_iommu(struct
> device *dev)
>  		return NULL;
>  	}
> 
> -	if (!iommu->pasid_table) {
> -		dev_err(dev, "PASID not enabled on IOMMU; cannot enable
> SVM\n");
> +	if (!intel_pasid_get_table(dev)) {
> +		dev_err(dev, "No PASID table for device; cannot enable SVM\n");
>  		return NULL;
>  	}
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 3abc94f..3b14819 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -256,6 +256,7 @@ static void intel_flush_pasid_dev(struct intel_svm *svm,
> struct intel_svm_dev *s
>  static void intel_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  {
>  	struct intel_svm *svm = container_of(mn, struct intel_svm, notifier);
> +	struct pasid_entry *pasid_table;
>  	struct intel_svm_dev *sdev;
> 
>  	/* This might end up being called from exit_mmap(), *before* the page
> @@ -270,11 +271,16 @@ static void intel_mm_release(struct mmu_notifier *mn,
> struct mm_struct *mm)
>  	 * page) so that we end up taking a fault that the hardware really
>  	 * *has* to handle gracefully without affecting other processes.
>  	 */
> -	svm->iommu->pasid_table[svm->pasid].val = 0;
> -	wmb();
> -
>  	rcu_read_lock();
>  	list_for_each_entry_rcu(sdev, &svm->devs, list) {
> +		pasid_table = intel_pasid_get_table(sdev->dev);
> +		if (!pasid_table)
> +			continue;
> +
> +		pasid_table[svm->pasid].val = 0;
> +		/* Make sure the entry update is visible before translation. */
> +		wmb();
> +
>  		intel_flush_pasid_dev(svm, sdev, svm->pasid);
>  		intel_flush_svm_range_dev(svm, sdev, 0, -1, 0, !svm->mm);
>  	}
> @@ -295,6 +301,7 @@ static LIST_HEAD(global_svm_list);
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct svm_dev_ops
> *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct pasid_entry *pasid_table;
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm = NULL;
>  	struct mm_struct *mm = NULL;
> @@ -302,7 +309,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  	int pasid_max;
>  	int ret;
> 
> -	if (WARN_ON(!iommu || !iommu->pasid_table))
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (WARN_ON(!iommu || !pasid_table))
>  		return -EINVAL;
> 
>  	if (dev_is_pci(dev)) {
> @@ -380,8 +388,8 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  		}
>  		svm->iommu = iommu;
> 
> -		if (pasid_max > iommu->pasid_max)
> -			pasid_max = iommu->pasid_max;
> +		if (pasid_max > intel_pasid_max_id)
> +			pasid_max = intel_pasid_max_id;
> 
>  		/* Do not use PASID 0 in caching mode (virtualised IOMMU) */
>  		ret = intel_pasid_alloc_id(svm,
> @@ -414,7 +422,7 @@ int intel_svm_bind_mm(struct device *dev, int *pasid, int
> flags, struct svm_dev_
>  		if (cpu_feature_enabled(X86_FEATURE_LA57))
>  			pasid_entry_val |= PASID_ENTRY_FLPM_5LP;
> 
> -		iommu->pasid_table[svm->pasid].val = pasid_entry_val;
> +		pasid_table[svm->pasid].val = pasid_entry_val;
> 
>  		wmb();
> 
> @@ -442,6 +450,7 @@ EXPORT_SYMBOL_GPL(intel_svm_bind_mm);
> 
>  int intel_svm_unbind_mm(struct device *dev, int pasid)
>  {
> +	struct pasid_entry *pasid_table;
>  	struct intel_svm_dev *sdev;
>  	struct intel_iommu *iommu;
>  	struct intel_svm *svm;
> @@ -449,7 +458,8 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
> 
>  	mutex_lock(&pasid_mutex);
>  	iommu = intel_svm_device_to_iommu(dev);
> -	if (!iommu || !iommu->pasid_table)
> +	pasid_table = intel_pasid_get_table(dev);
> +	if (!iommu || !pasid_table)
>  		goto out;
> 
>  	svm = intel_pasid_lookup_id(pasid);
> @@ -472,11 +482,14 @@ int intel_svm_unbind_mm(struct device *dev, int pasid)
>  				intel_flush_pasid_dev(svm, sdev, svm->pasid);
>  				intel_flush_svm_range_dev(svm, sdev, 0, -1,
> 0, !svm->mm);
>  				kfree_rcu(sdev, rcu);
> +				pasid_table[svm->pasid].val = 0;
> +				/*
> +				 * Make sure the entry update is visible
> +				 * before translation.
> +				 */
> +				wmb();
> 
>  				if (list_empty(&svm->devs)) {
> -					svm->iommu->pasid_table[svm->pasid].val
> = 0;
> -					wmb();
> -
>  					intel_pasid_free_id(svm->pasid);
>  					if (svm->mm)
>  						mmu_notifier_unregister(&svm-
> >notifier, svm->mm);
> @@ -509,7 +522,7 @@ int intel_svm_is_pasid_valid(struct device *dev, int pasid)
> 
>  	mutex_lock(&pasid_mutex);
>  	iommu = intel_svm_device_to_iommu(dev);
> -	if (!iommu || !iommu->pasid_table)
> +	if (!iommu)
>  		goto out;
> 
>  	svm = intel_pasid_lookup_id(pasid);
> --
> 2.7.4
