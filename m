Return-Path: <SRS0=k0pT=6I=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD005C54FCB
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 10:47:54 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FD4C2064A
	for <iommu@archiver.kernel.org>; Fri, 24 Apr 2020 10:47:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FD4C2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 73AB4236B5;
	Fri, 24 Apr 2020 10:47:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id db-ANGxMWrq7; Fri, 24 Apr 2020 10:47:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B3A7C203ED;
	Fri, 24 Apr 2020 10:47:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99E39C1AE2;
	Fri, 24 Apr 2020 10:47:52 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D2644C0175
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id C881B86D1E
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hAmaldRbiAPv for <iommu@lists.linux-foundation.org>;
 Fri, 24 Apr 2020 10:47:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7D05486D0F
 for <iommu@lists.linux-foundation.org>; Fri, 24 Apr 2020 10:47:49 +0000 (UTC)
IronPort-SDR: 7PJ8wrMdtOIk2xF221zlvIFEXituRLR2wThQ96okMzZO0+70pwRn4sfKhpkI4ppm/BoJhC2OSF
 DuvGyUO52nGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Apr 2020 03:47:48 -0700
IronPort-SDR: 4jfscZje6XFsH7bnDeSKlIxwJVjGHpi18BthSL7AG92+Vv7SgYegtt7xBo+P87YMLoWFy2KqcN
 ooQq2iXSjGNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; d="scan'208";a="457867868"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga006.fm.intel.com with ESMTP; 24 Apr 2020 03:47:48 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Apr 2020 03:47:48 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 24 Apr 2020 03:47:48 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Fri, 24 Apr 2020 18:47:46 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Lu Baolu
 <baolu.lu@linux.intel.com>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Eric Auger
 <eric.auger@redhat.com>
Subject: RE: [PATCH v12 4/8] iommu/vt-d: Add bind guest PASID support
Thread-Topic: [PATCH v12 4/8] iommu/vt-d: Add bind guest PASID support
Thread-Index: AQHWGA07P/Y0YIR4Wk2h1r/XlOUTm6iIEVWg
Date: Fri, 24 Apr 2020 10:47:45 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D8A0D03@SHSMSX104.ccr.corp.intel.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1587495165-80096-5-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1587495165-80096-5-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: Christoph Hellwig <hch@infradead.org>,
 Alex Williamson <alex.williamson@redhat.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Cameron <jic23@kernel.org>
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

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Wednesday, April 22, 2020 2:53 AM
> 
> When supporting guest SVA with emulated IOMMU, the guest PASID
> table is shadowed in VMM. Updates to guest vIOMMU PASID table
> will result in PASID cache flush which will be passed down to
> the host as bind guest PASID calls.

Above description is not accurate. Guest PASID table updates don't
'result in' PASID cache flush automatically. What about:
--
The guest needs to invalidate the PASID cache for any update to
guest PASID table. Those invalidation requests are intercepted
by the VMM and passed down to the host as binding guest PASID
calls.
--
> 
> For the SL page tables, it will be harvested from device's
> default domain (request w/o PASID), or aux domain in case of
> mediated device.
> 
>     .-------------.  .---------------------------.
>     |   vIOMMU    |  | Guest process CR3, FL only|
>     |             |  '---------------------------'
>     .----------------/
>     | PASID Entry |--- PASID cache flush -
>     '-------------'                       |
>     |             |                       V
>     |             |                CR3 in GPA
>     '-------------'
> Guest
> ------| Shadow |--------------------------|--------
>       v        v                          v
> Host
>     .-------------.  .----------------------.
>     |   pIOMMU    |  | Bind FL for GVA-GPA  |
>     |             |  '----------------------'
>     .----------------/  |
>     | PASID Entry |     V (Nested xlate)
>     '----------------\.------------------------------.
>     |             |   |SL for GPA-HPA, default domain|
>     |             |   '------------------------------'
>     '-------------'
> Where:
>  - FL = First level/stage one page tables
>  - SL = Second level/stage two page tables
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c |   4 +
>  drivers/iommu/intel-svm.c   | 204
> ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/intel-iommu.h |   8 +-
>  include/linux/intel-svm.h   |  17 ++++
>  4 files changed, 232 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 9c01e391a931..8862d6b0ef21 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -6179,6 +6179,10 @@ const struct iommu_ops intel_iommu_ops = {
>  	.dev_disable_feat	= intel_iommu_dev_disable_feat,
>  	.is_attach_deferred	= intel_iommu_is_attach_deferred,
>  	.pgsize_bitmap		= INTEL_IOMMU_PGSIZES,
> +#ifdef CONFIG_INTEL_IOMMU_SVM
> +	.sva_bind_gpasid	= intel_svm_bind_gpasid,
> +	.sva_unbind_gpasid	= intel_svm_unbind_gpasid,
> +#endif
>  };
> 
>  static void quirk_iommu_igfx(struct pci_dev *dev)
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 2998418f0a38..69b2070b843d 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -226,6 +226,210 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>  		if ((d) != (sdev)->dev) {} else
> 
> +static inline void intel_svm_free_if_empty(struct intel_svm *svm, u64 pasid)
> +{
> +	if (list_empty(&svm->devs)) {
> +		ioasid_set_data(pasid, NULL);
> +		kfree(svm);
> +	}
> +}

Do we really need a function form instead of putting the 4 lines directly 
after the 'out' label?

> +
> +int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device
> *dev,
> +			  struct iommu_gpasid_bind_data *data)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct dmar_domain *dmar_domain;
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = 0;
> +
> +	if (WARN_ON(!iommu) || !data)
> +		return -EINVAL;

well, why not checking !dev together?

> +
> +	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
> +	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
> +		return -EINVAL;
> +
> +	if (dev_is_pci(dev)) {
> +		/* VT-d supports devices with full 20 bit PASIDs only */
> +		if (pci_max_pasids(to_pci_dev(dev)) != PASID_MAX)
> +			return -EINVAL;
> +	} else {
> +		return -ENOTSUPP;
> +	}
> +
> +	/*
> +	 * We only check host PASID range, we have no knowledge to check
> +	 * guest PASID range.
> +	 */
> +	if (data->hpasid <= 0 || data->hpasid >= PASID_MAX)
> +		return -EINVAL;
> +
> +	dmar_domain = to_dmar_domain(domain);
> +
> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, data->hpasid, NULL);
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	if (svm) {
> +		/*
> +		 * If we found svm for the PASID, there must be at
> +		 * least one device bond, otherwise svm should be freed.
> +		 */
> +		if (WARN_ON(list_empty(&svm->devs))) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +
> +		for_each_svm_dev(sdev, svm, dev) {
> +			/* In case of multiple sub-devices of the same pdev
> +			 * assigned, we should allow multiple bind calls with
> +			 * the same PASID and pdev.
> +			 */
> +			sdev->users++;
> +			goto out;

in last review Eric raised the open about what about binding the same
PASID to the same pdev multiple times. We discussed that should be
disallowed. Here can you check whether aux_domain is enabled on pdev
to restrict multiple-binding only for sub-devices?

> +		}
> +	} else {
> +		/* We come here when PASID has never been bond to a
> device. */
> +		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
> +		if (!svm) {
> +			ret = -ENOMEM;
> +			goto out;
> +		}
> +		/* REVISIT: upper layer/VFIO can track host process that bind
> +		 * the PASID. ioasid_set = mm might be sufficient for vfio to
> +		 * check pasid VMM ownership. We can drop the following
> line
> +		 * once VFIO and IOASID set check is in place.
> +		 */

there is no check below this comment. Following lines are simply
initializing the svm fields.

> +		svm->mm = get_task_mm(current);
> +		svm->pasid = data->hpasid;
> +		if (data->flags & IOMMU_SVA_GPASID_VAL) {
> +			svm->gpasid = data->gpasid;
> +			svm->flags |= SVM_FLAG_GUEST_PASID;
> +		}
> +		ioasid_set_data(data->hpasid, svm);
> +		INIT_LIST_HEAD_RCU(&svm->devs);
> +		mmput(svm->mm);
> +	}
> +	sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> +	if (!sdev) {
> +		/*
> +		 * If this is a new PASID that never bond to a device, then
> +		 * the device list must be empty which indicates struct svm
> +		 * was allocated in this function.
> +		 */
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	sdev->dev = dev;
> +	sdev->users = 1;
> +
> +	/* Set up device context entry for PASID if not enabled already */
> +	ret = intel_iommu_enable_pasid(iommu, sdev->dev);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to enable PASID
> capability\n");

print hpasid 

> +		kfree(sdev);
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		goto out;
> +	}
> +
> +	/*
> +	 * PASID table is per device for better security. Therefore, for
> +	 * each bind of a new device even with an existing PASID, we need to
> +	 * call the nested mode setup function here.
> +	 */
> +	spin_lock(&iommu->lock);
> +	ret = intel_pasid_setup_nested(iommu,
> +				       dev,
> +				       (pgd_t *)data->gpgd,
> +				       data->hpasid,
> +				       &data->vtd,
> +				       dmar_domain,
> +				       data->addr_width);
> +	if (ret) {
> +		dev_err_ratelimited(dev, "Failed to set up PASID %llu in
> nested mode, Err %d\n",
> +				    data->hpasid, ret);
> +		/*
> +		 * PASID entry should be in cleared state if nested mode
> +		 * set up failed. So we only need to clear IOASID tracking
> +		 * data such that free call will succeed.
> +		 */
> +		kfree(sdev);
> +		intel_svm_free_if_empty(svm, data->hpasid);
> +		spin_unlock(&iommu->lock);
> +		goto out;
> +	}
> +	spin_unlock(&iommu->lock);

spin_unlock can be moved before if(ret)?

> +	svm->flags |= SVM_FLAG_GUEST_MODE;
> +
> +	init_rcu_head(&sdev->rcu);
> +	list_add_rcu(&sdev->list, &svm->devs);
> + out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> +
> +int intel_svm_unbind_gpasid(struct device *dev, int pasid)
> +{
> +	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> +	struct intel_svm_dev *sdev;
> +	struct intel_svm *svm;
> +	int ret = -EINVAL;
> +
> +	if (WARN_ON(!iommu))
> +		return -EINVAL;
> +
> +	mutex_lock(&pasid_mutex);
> +	svm = ioasid_find(NULL, pasid, NULL);
> +	if (!svm) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (IS_ERR(svm)) {
> +		ret = PTR_ERR(svm);
> +		goto out;
> +	}
> +
> +	for_each_svm_dev(sdev, svm, dev) {
> +		ret = 0;
> +		sdev->users--;
> +		if (!sdev->users) {
> +			list_del_rcu(&sdev->list);
> +			intel_pasid_tear_down_entry(iommu, dev, svm-
> >pasid);
> +			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> +			/* TODO: Drain in flight PRQ for the PASID since it
> +			 * may get reused soon, we don't want to
> +			 * confuse with its previous life.
> +			 * intel_svm_drain_prq(dev, pasid);
> +			 */
> +			kfree_rcu(sdev, rcu);
> +
> +			if (list_empty(&svm->devs)) {
> +				/*
> +				 * We do not free the IOASID here in that
> +				 * IOMMU driver did not allocate it.
> +				 * Unlike native SVM, IOASID for guest use
> was
> +				 * allocated prior to the bind call.
> +				 * In any case, if the free call comes before
> +				 * the unbind, IOMMU driver will get notified
> +				 * and perform cleanup.
> +				 */
> +				ioasid_set_data(pasid, NULL);
> +				kfree(svm);
> +			}

is it safer moving above empty check outside of the loop?

> +		}
> +		break;
> +	}
> +out:
> +	mutex_unlock(&pasid_mutex);
> +	return ret;
> +}
> +
>  int intel_svm_bind_mm(struct device *dev, int *pasid, int flags, struct
> svm_dev_ops *ops)
>  {
>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 6da03f627ba3..c8ce2336f8d8 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -706,7 +706,9 @@ struct dmar_domain *find_domain(struct device
> *dev);
>  extern void intel_svm_check(struct intel_iommu *iommu);
>  extern int intel_svm_enable_prq(struct intel_iommu *iommu);
>  extern int intel_svm_finish_prq(struct intel_iommu *iommu);
> -
> +int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device
> *dev,
> +			  struct iommu_gpasid_bind_data *data);
> +int intel_svm_unbind_gpasid(struct device *dev, int pasid);
>  struct svm_dev_ops;
> 
>  struct intel_svm_dev {
> @@ -723,9 +725,13 @@ struct intel_svm_dev {
>  struct intel_svm {
>  	struct mmu_notifier notifier;
>  	struct mm_struct *mm;
> +
>  	struct intel_iommu *iommu;
>  	int flags;
>  	int pasid;
> +	int gpasid; /* Guest PASID in case of vSVA bind with non-identity host
> +		     * to guest PASID mapping.
> +		     */

/* in case that guest PASID is different from host PASID */

>  	struct list_head devs;
>  	struct list_head list;
>  };
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index d7c403d0dd27..c19690937540 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -44,6 +44,23 @@ struct svm_dev_ops {
>   * do such IOTLB flushes automatically.
>   */
>  #define SVM_FLAG_SUPERVISOR_MODE	(1<<1)
> +/*
> + * The SVM_FLAG_GUEST_MODE flag is used when a guest process bind to a
> device.
> + * In this case the mm_struct is in the guest kernel or userspace, its life

this statement is confusing. We still have mm_struct in the host side to
claim the ownership of a PASID.

> + * cycle is managed by VMM and VFIO layer. For IOMMU driver, this API

why is a flag becoming an API?

> provides
> + * means to bind/unbind guest CR3 with PASIDs allocated for a device.
> + */
> +#define SVM_FLAG_GUEST_MODE	(1<<2)
> +/*
> + * The SVM_FLAG_GUEST_PASID flag is used when a guest has its own PASID
> space,
> + * which requires guest and host PASID translation at both directions. We
> keep
> + * track of guest PASID in order to provide lookup service to device drivers.
> + * One such example is a physical function (PF) driver that supports
> mediated
> + * device (mdev) assignment. Guest programming of mdev configuration
> space can
> + * only be done with guest PASID, therefore PF driver needs to find the
> matching
> + * host PASID to program the real hardware.

I feel such example doesn't belong here, which is purely userspace policy.
Here just describe what the flag is for should be sufficient.

> + */
> +#define SVM_FLAG_GUEST_PASID	(1<<3)
> 
>  #ifdef CONFIG_INTEL_IOMMU_SVM
> 
> --
> 2.7.4

Thanks
Kevin

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
