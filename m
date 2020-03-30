Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BC25C2D0F0
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 22:48:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498E420771
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 22:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498E420771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0F316882A1;
	Mon, 30 Mar 2020 22:48:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9z2EOh7TbcwX; Mon, 30 Mar 2020 22:48:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6794287EE8;
	Mon, 30 Mar 2020 22:48:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57D7CC1D7E;
	Mon, 30 Mar 2020 22:48:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48B75C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:48:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 31989867B9
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:48:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Khzil2kyOgHu for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 22:48:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id CF1EB86722
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 22:48:02 +0000 (UTC)
IronPort-SDR: dD04YdVOXhsJNSBh/WV/MIrDgkwYJgZgSIqY6vY3QLs3CpPiQYWf7XCpDQnPjL/9FYKBEW+jj5
 jeCJqCdG+xfQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 15:48:01 -0700
IronPort-SDR: i97vZJR5ktMMM+dp55CFmc3Kqqh7WBc3ZRE3nTH07I8CqEkH+oVCCiHYYJoeveySTEKNLVURcb
 m4qq0q9JstvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,325,1580803200"; d="scan'208";a="237507838"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga007.jf.intel.com with ESMTP; 30 Mar 2020 15:48:01 -0700
Date: Mon, 30 Mar 2020 15:53:48 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V10 06/11] iommu/vt-d: Add bind guest PASID support
Message-ID: <20200330155348.11ec6b8f@jacob-builder>
In-Reply-To: <62d2c2a1-0594-c647-1f2c-4d74c7b84d9a@redhat.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-7-git-send-email-jacob.jun.pan@linux.intel.com>
 <62d2c2a1-0594-c647-1f2c-4d74c7b84d9a@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: Yi L <yi.l.liu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, Jonathan Cameron <jic23@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Sun, 29 Mar 2020 15:40:22 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi,
> 
> On 3/21/20 12:27 AM, Jacob Pan wrote:
> > When supporting guest SVA with emulated IOMMU, the guest PASID
> > table is shadowed in VMM. Updates to guest vIOMMU PASID table
> > will result in PASID cache flush which will be passed down to
> > the host as bind guest PASID calls.
> > 
> > For the SL page tables, it will be harvested from device's
> > default domain (request w/o PASID), or aux domain in case of
> > mediated device.
> > 
> >     .-------------.  .---------------------------.
> >     |   vIOMMU    |  | Guest process CR3, FL only|
> >     |             |  '---------------------------'
> >     .----------------/
> >     | PASID Entry |--- PASID cache flush -
> >     '-------------'                       |
> >     |             |                       V
> >     |             |                CR3 in GPA
> >     '-------------'
> > Guest
> > ------| Shadow |--------------------------|--------
> >       v        v                          v
> > Host
> >     .-------------.  .----------------------.
> >     |   pIOMMU    |  | Bind FL for GVA-GPA  |
> >     |             |  '----------------------'
> >     .----------------/  |
> >     | PASID Entry |     V (Nested xlate)
> >     '----------------\.------------------------------.
> >     |             |   |SL for GPA-HPA, default domain|
> >     |             |   '------------------------------'
> >     '-------------'
> > Where:
> >  - FL = First level/stage one page tables
> >  - SL = Second level/stage two page tables
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> > ---
> >  drivers/iommu/intel-iommu.c |   4 +
> >  drivers/iommu/intel-svm.c   | 224
> > ++++++++++++++++++++++++++++++++++++++++++++
> > include/linux/intel-iommu.h |   8 +- include/linux/intel-svm.h   |
> > 17 ++++ 4 files changed, 252 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c
> > b/drivers/iommu/intel-iommu.c index e599b2537b1c..b1477cd423dd
> > 100644 --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -6203,6 +6203,10 @@ const struct iommu_ops intel_iommu_ops = {
> >  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
> >  	.is_attach_deferred	=
> > intel_iommu_is_attach_deferred, .pgsize_bitmap		=
> > INTEL_IOMMU_PGSIZES, +#ifdef CONFIG_INTEL_IOMMU_SVM
> > +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> > +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> > +#endif
> >  };
> >  
> >  static void quirk_iommu_igfx(struct pci_dev *dev)
> > diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> > index d7f2a5358900..47c0deb5ae56 100644
> > --- a/drivers/iommu/intel-svm.c
> > +++ b/drivers/iommu/intel-svm.c
> > @@ -226,6 +226,230 @@ static LIST_HEAD(global_svm_list);
> >  	list_for_each_entry((sdev), &(svm)->devs, list)	\
> >  		if ((d) != (sdev)->dev) {} else
> >  
> > +int intel_svm_bind_gpasid(struct iommu_domain *domain,
> > +			struct device *dev,
> > +			struct iommu_gpasid_bind_data *data)
> > +{
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *ddomain;
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = 0;
> > +
> > +	if (WARN_ON(!iommu) || !data)
> > +		return -EINVAL;
> > +
> > +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> > +	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> > +		return -EINVAL;
> > +
> > +	if (dev_is_pci(dev)) {
> > +		/* VT-d supports devices with full 20 bit PASIDs
> > only */
> > +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> > +			return -EINVAL;
> > +	} else {
> > +		return -ENOTSUPP;
> > +	}
> > +
> > +	/*
> > +	 * We only check host PASID range, we have no knowledge to
> > check
> > +	 * guest PASID range nor do we use the guest PASID.  
> nit : "nor do we use the guest PASID". Well the guest PASID FLAG is
> checked below and if set, svm->gpasid is set ;-)
Yes, it is a little contradictory, I will remove the use.

I meant we don;t really use the gpasid for real work in host driver :)

> > +	 */
> > +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> > +		return -EINVAL;
> > +
> > +	ddomain = to_dmar_domain(domain);
> > +
> > +	/* Sanity check paging mode support match between host and
> > guest */
> > +	if (data->addr_width == ADDR_WIDTH_5LEVEL &&
> > +	    !cap_5lp_support(iommu->cap)) {
> > +		pr_err("Cannot support 5 level paging requested by
> > guest!\n");
> > +		return -EINVAL;  
> nit: This check also is done in intel_pasid_setup_nested with an extra
> check:
Good catch, I will remove this.

> +	switch (addr_width) {
> +	case ADDR_WIDTH_5LEVEL:
> +		if (cpu_feature_enabled(X86_FEATURE_LA57) &&
> +			cap_5lp_support(iommu->cap)) {
> 
> > +	}
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	svm = ioasid_find(NULL, data->hpasid, NULL);
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> > +	if (svm) {
> > +		/*
> > +		 * If we found svm for the PASID, there must be at
> > +		 * least one device bond, otherwise svm should be
> > freed.
> > +		 */
> > +		if (WARN_ON(list_empty(&svm->devs))) {
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +
> > +		if (svm->mm == get_task_mm(current) &&
> > +		    data->hpasid == svm->pasid &&
> > +		    data->gpasid == svm->gpasid) {
> > +			pr_warn("Cannot bind the same guest-host
> > PASID for the same process\n");
> > +			mmput(svm->mm);
> > +			ret = -EINVAL;
> > +			goto out;
> > +		}
> > +		mmput(current->mm);
> > +
> > +		for_each_svm_dev(sdev, svm, dev) {
> > +			/* In case of multiple sub-devices of the
> > same pdev
> > +			 * assigned, we should allow multiple bind
> > calls with
> > +			 * the same PASID and pdev.
> > +			 */
> > +			sdev->users++;
> > +			goto out;
> > +		}
> > +	} else {
> > +		/* We come here when PASID has never been bond to
> > a device. */
> > +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> > +		if (!svm) {
> > +			ret = -ENOMEM;
> > +			goto out;
> > +		}
> > +		/* REVISIT: upper layer/VFIO can track host
> > process that bind the PASID.
> > +		 * ioasid_set = mm might be sufficient for vfio to
> > check pasid VMM
> > +		 * ownership.
> > +		 */
> > +		svm->mm = get_task_mm(current);
> > +		svm->pasid = data->hpasid;
> > +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> > +			svm->gpasid = data->gpasid;
> > +			svm->flags |= SVM_FLAG_GUEST_PASID;
> > +		}
> > +		ioasid_set_data(data->hpasid, svm);
> > +		INIT_LIST_HEAD_RCU(&svm->devs);
> > +		mmput(svm->mm);
> > +	}
> > +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> > +	if (!sdev) {
> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}  
> nit: the above 4 lines are duplicated 3 times. Might be worth a
> helper.
Good point, I will add a helper like this

static inline void intel_svm_free_if_empty(struct intel_svm *svm, u64 pasid)
{
	if (list_empty(&svm->devs)) {
		ioasid_attach_data(pasid, NULL);
		kfree(svm);
	}
}



> > +		ret = -ENOMEM;
> > +		goto out;
> > +	}
> > +	sdev->dev = dev;
> > +	sdev->users = 1;
> > +
> > +	/* Set up device context entry for PASID if not enabled
> > already */
> > +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to enable PASID
> > capability\n");  
> unlimited tracing upon userspace call? Don't know what is the best
> policy.
Good point. Perhaps just use dev_err_ratelimited for all user calls?

> > +		kfree(sdev);
> > +		/*
> > +		 * If this this a new PASID that never bond to a
> > device, then
> > +		 * the device list must be empty which indicates
> > struct svm
> > +		 * was allocated in this function.
> > +		 */
> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * For guest bind, we need to set up PASID table entry as
> > follows:
> > +	 * - FLPM matches guest paging mode
> > +	 * - turn on nested mode
> > +	 * - SL guest address width matching
> > +	 */
> > +	ret = intel_pasid_setup_nested(iommu,
> > +				       dev,
> > +				       (pgd_t *)data->gpgd,
> > +				       data->hpasid,
> > +				       &data->vtd,
> > +				       ddomain,
> > +				       data->addr_width);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set up PASID %llu in
> > nested mode, Err %d\n",
> > +			data->hpasid, ret);
> > +		/*
> > +		 * PASID entry should be in cleared state if
> > nested mode
> > +		 * set up failed. So we only need to clear IOASID
> > tracking
> > +		 * data such that free call will succeed.
> > +		 */
> > +		kfree(sdev);
> > +		if (list_empty(&svm->devs)) {
> > +			ioasid_set_data(data->hpasid, NULL);
> > +			kfree(svm);
> > +		}  
> 
> > +		goto out;
> > +	}
> > +	svm->flags |= SVM_FLAG_GUEST_MODE;
> > +
> > +	init_rcu_head(&sdev->rcu);
> > +	list_add_rcu(&sdev->list, &svm->devs);
> > + out:
> > +	mutex_unlock(&pasid_mutex);
> > +	return ret;
> > +}
> > +
> > +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> > +{
> > +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct intel_svm_dev *sdev;
> > +	struct intel_svm *svm;
> > +	int ret = -EINVAL;
> > +
> > +	if (WARN_ON(!iommu))
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&pasid_mutex);
> > +	svm = ioasid_find(NULL, pasid, NULL);
> > +	if (!svm) {
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	if (IS_ERR(svm)) {
> > +		ret = PTR_ERR(svm);
> > +		goto out;
> > +	}
> > +
> > +	for_each_svm_dev(sdev, svm, dev) {
> > +		ret = 0;
> > +		sdev->users--;
> > +		if (!sdev->users) {
> > +			list_del_rcu(&sdev->list);
> > +			intel_pasid_tear_down_entry(iommu, dev,
> > svm->pasid);
> > +			/* TODO: Drain in flight PRQ for the PASID
> > since it
> > +			 * may get reused soon, we don't want to
> > +			 * confuse with its previous life.
> > +			 * intel_svm_drain_prq(dev, pasid);
> > +			 */
> > +			kfree_rcu(sdev, rcu);
> > +
> > +			if (list_empty(&svm->devs)) {
> > +				/*
> > +				 * We do not free PASID here until
> > explicit call
> > +				 * from VFIO to free. The PASID
> > life cycle
> > +				 * management is largely tied to
> > VFIO management
> > +				 * of assigned device life cycles.
> > In case of
> > +				 * guest exit without a explicit
> > free PASID call,
> > +				 * the responsibility lies in VFIO
> > layer to free
> > +				 * the PASIDs allocated for the
> > guest.
> > +				 * For security reasons, VFIO has
> > to track the
> > +				 * PASID ownership per guest
> > anyway to ensure
> > +				 * that PASID allocated by one
> > guest cannot be
> > +				 * used by another.
> > +				 */
> > +				ioasid_set_data(pasid, NULL);
> > +				kfree(svm);
> > +			}
> > +		}
> > +		break;
> > +	}
> > +out:
> > +	mutex_unlock(&pasid_mutex);
> > +
> > +	return ret;
> > +}
> > +
> >  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags,
> > struct svm_dev_ops *ops) {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > diff --git a/include/linux/intel-iommu.h
> > b/include/linux/intel-iommu.h index eda1d6687144..85b05120940e
> > 100644 --- a/include/linux/intel-iommu.h
> > +++ b/include/linux/intel-iommu.h
> > @@ -681,7 +681,9 @@ struct dmar_domain *find_domain(struct device
> > *dev); extern void intel_svm_check(struct intel_iommu *iommu);
> >  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
> >  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> > -
> > +extern int intel_svm_bind_gpasid(struct iommu_domain *domain,
> > +		struct device *dev, struct iommu_gpasid_bind_data
> > *data); +extern int intel_svm_unbind_gpasid(struct device *dev, int
> > pasid); struct svm_dev_ops;
> >  
> >  struct intel_svm_dev {
> > @@ -698,9 +700,13 @@ struct intel_svm_dev {
> >  struct intel_svm {
> >  	struct mmu_notifier notifier;
> >  	struct mm_struct *mm;
> > +
> >  	struct intel_iommu *iommu;
> >  	int flags;
> >  	int pasid;
> > +	int gpasid; /* Guest PASID in case of vSVA bind with
> > non-identity host
> > +		     * to guest PASID mapping.
> > +		     */
> >  	struct list_head devs;
> >  	struct list_head list;
> >  };
> > diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> > index d7c403d0dd27..c19690937540 100644
> > --- a/include/linux/intel-svm.h
> > +++ b/include/linux/intel-svm.h
> > @@ -44,6 +44,23 @@ struct svm_dev_ops {
> >   * do such IOTLB flushes automatically.
> >   */
> >  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> > +/*
> > + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind
> > to a device.
> > + * In this case the mm_struct is in the guest kernel or userspace,
> > its life
> > + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this
> > API provides
> > + * means to bind/unbind guest CR3 with PASIDs allocated for a
> > device.
> > + */
> > +#define SVM_FLAG_GUEST_MODE	(1<<2)
> > +/*
> > + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own
> > PASID space,
> > + * which requires guest and host PASID translation at both
> > directions. We keep
> > + * track of guest PASID in order to provide lookup service to
> > device drivers.
> > + * One such example is a physical function (PF) driver that
> > supports mediated
> > + * device (mdev) assignment. Guest programming of mdev
> > configuration space can
> > + * only be done with guest PASID, therefore PF driver needs to
> > find the matching
> > + * host PASID to program the real hardware.
> > + */
> > +#define SVM_FLAG_GUEST_PASID	(1<<3)
> >  
> >  #ifdef CONFIG_INTEL_IOMMU_SVM
> >  
> >   
> Thanks
> 
> Eric
> 

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
