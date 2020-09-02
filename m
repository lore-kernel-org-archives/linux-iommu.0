Return-Path: <SRS0=BMay=CL=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B79CC433E7
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:37:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693D6207EA
	for <iommu@archiver.kernel.org>; Wed,  2 Sep 2020 21:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693D6207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4AB4C872E9;
	Wed,  2 Sep 2020 21:37:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFwl68yovIFD; Wed,  2 Sep 2020 21:37:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9BF4F86DA3;
	Wed,  2 Sep 2020 21:37:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C362C0052;
	Wed,  2 Sep 2020 21:37:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3C172C0051
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:37:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 12D782043F
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:37:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rHmD1BkeWlOK for <iommu@lists.linux-foundation.org>;
 Wed,  2 Sep 2020 21:37:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 3974F203DD
 for <iommu@lists.linux-foundation.org>; Wed,  2 Sep 2020 21:37:15 +0000 (UTC)
IronPort-SDR: G5KsyhQHcd292xOTXHyaUipLv0XuP8szTCGqpB1U57itlsHwmWohaHK2wYYtd4/bcWznzZx2rK
 6NO6zWar6fNQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="221697715"
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="221697715"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:37:14 -0700
IronPort-SDR: qyQYB3ZXmt5fj4eBpf8lLNCr1WO7gEKO/2AR2PwvgHhqeeNdUlvQZZPTXsXIj61l3VRHXeCpdr
 qD67TT+Si4Hw==
X-IronPort-AV: E=Sophos;i="5.76,384,1592895600"; d="scan'208";a="331571820"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 14:37:14 -0700
Date: Wed, 2 Sep 2020 14:44:21 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v2 3/9] iommu/ioasid: Introduce ioasid_set APIs
Message-ID: <20200902144421.022b6334@jacob-builder>
In-Reply-To: <20200824182848.GB3210689@myrica>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1598070918-21321-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200824182848.GB3210689@myrica>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jacob Pan <jacob.pan.linux@gmail.com>,
 Raj Ashok <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
 LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux-foundation.org,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, Wu Hao <hao.wu@intel.com>
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

On Mon, 24 Aug 2020 20:28:48 +0200
Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Fri, Aug 21, 2020 at 09:35:12PM -0700, Jacob Pan wrote:
> > ioasid_set was introduced as an arbitrary token that are shared by a
> > group of IOASIDs. For example, if IOASID #1 and #2 are allocated
> > via the same ioasid_set*, they are viewed as to belong to the same
> > set.
> > 
> > For guest SVA usages, system-wide IOASID resources need to be
> > partitioned such that VMs can have its own quota and being managed
> > separately. ioasid_set is the perfect candidate for meeting such
> > requirements. This patch redefines and extends ioasid_set with the
> > following new fields:
> > - Quota
> > - Reference count
> > - Storage of its namespace
> > - The token is stored in the new ioasid_set but with optional types
> > 
> > ioasid_set level APIs are introduced that wires up these new data.
> > Existing users of IOASID APIs are converted where a host IOASID set
> > is allocated for bare-metal usage.
> > 
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c |  27 ++-
> >  drivers/iommu/intel/pasid.h |   1 +
> >  drivers/iommu/intel/svm.c   |   8 +-
> >  drivers/iommu/ioasid.c      | 390
> > +++++++++++++++++++++++++++++++++++++++++---
> > include/linux/ioasid.h      |  82 ++++++++-- 5 files changed, 465
> > insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c
> > b/drivers/iommu/intel/iommu.c index a3a0b5c8921d..5813eeaa5edb
> > 100644 --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -42,6 +42,7 @@
> >  #include <linux/crash_dump.h>
> >  #include <linux/numa.h>
> >  #include <linux/swiotlb.h>
> > +#include <linux/ioasid.h>
> >  #include <asm/irq_remapping.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/iommu.h>
> > @@ -103,6 +104,9 @@
> >   */
> >  #define INTEL_IOMMU_PGSIZES	(~0xFFFUL)
> >  
> > +/* PASIDs used by host SVM */
> > +struct ioasid_set *host_pasid_set;
> > +
> >  static inline int agaw_to_level(int agaw)
> >  {
> >  	return agaw + 2;
> > @@ -3103,8 +3107,8 @@ static void intel_vcmd_ioasid_free(ioasid_t
> > ioasid, void *data)
> >  	 * Sanity check the ioasid owner is done at upper layer,
> > e.g. VFIO
> >  	 * We can only free the PASID when all the devices are
> > unbound. */
> > -	if (ioasid_find(NULL, ioasid, NULL)) {
> > -		pr_alert("Cannot free active IOASID %d\n", ioasid);
> > +	if (IS_ERR(ioasid_find(host_pasid_set, ioasid, NULL))) {
> > +		pr_err("Cannot free IOASID %d, not in system
> > set\n", ioasid); return;
> >  	}
> >  	vcmd_free_pasid(iommu, ioasid);
> > @@ -3288,6 +3292,19 @@ static int __init init_dmars(void)
> >  	if (ret)
> >  		goto free_iommu;
> >  
> > +	/* PASID is needed for scalable mode irrespective to SVM */
> > +	if (intel_iommu_sm) {
> > +		ioasid_install_capacity(intel_pasid_max_id);
> > +		/* We should not run out of IOASIDs at boot */
> > +		host_pasid_set = ioasid_alloc_set(NULL,
> > PID_MAX_DEFAULT,
> > +
> > IOASID_SET_TYPE_NULL);
> > +		if (IS_ERR_OR_NULL(host_pasid_set)) {
> > +			pr_err("Failed to enable host PASID
> > allocator %lu\n",
> > +				PTR_ERR(host_pasid_set));
> > +			intel_iommu_sm = 0;
> > +		}
> > +	}
> > +
> >  	/*
> >  	 * for each drhd
> >  	 *   enable fault log
> > @@ -5149,7 +5166,7 @@ static void auxiliary_unlink_device(struct
> > dmar_domain *domain, domain->auxd_refcnt--;
> >  
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		ioasid_free(domain->default_pasid);
> > +		ioasid_free(host_pasid_set, domain->default_pasid);
> >  }
> >  
> >  static int aux_domain_add_dev(struct dmar_domain *domain,
> > @@ -5167,7 +5184,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, int pasid;
> >  
> >  		/* No private data needed for the default pasid */
> > -		pasid = ioasid_alloc(NULL, PASID_MIN,
> > +		pasid = ioasid_alloc(host_pasid_set, PASID_MIN,
> >  				     pci_max_pasids(to_pci_dev(dev))
> > - 1, NULL);
> >  		if (pasid == INVALID_IOASID) {
> > @@ -5210,7 +5227,7 @@ static int aux_domain_add_dev(struct
> > dmar_domain *domain, spin_unlock(&iommu->lock);
> >  	spin_unlock_irqrestore(&device_domain_lock, flags);
> >  	if (!domain->auxd_refcnt && domain->default_pasid > 0)
> > -		ioasid_free(domain->default_pasid);
> > +		ioasid_free(host_pasid_set, domain->default_pasid);
> >  
> >  	return ret;
> >  }
> > diff --git a/drivers/iommu/intel/pasid.h
> > b/drivers/iommu/intel/pasid.h index c9850766c3a9..ccdc23446015
> > 100644 --- a/drivers/iommu/intel/pasid.h
> > +++ b/drivers/iommu/intel/pasid.h
> > @@ -99,6 +99,7 @@ static inline bool pasid_pte_is_present(struct
> > pasid_entry *pte) }
> >  
> >  extern u32 intel_pasid_max_id;
> > +extern struct ioasid_set *host_pasid_set;
> >  int intel_pasid_alloc_id(void *ptr, int start, int end, gfp_t gfp);
> >  void intel_pasid_free_id(int pasid);
> >  void *intel_pasid_lookup_id(int pasid);
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index 37a9beabc0ca..634e191ca2c3 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -551,7 +551,7 @@ intel_svm_bind_mm(struct device *dev, int
> > flags, struct svm_dev_ops *ops, pasid_max = intel_pasid_max_id;
> >  
> >  		/* Do not use PASID 0, reserved for RID to PASID */
> > -		svm->pasid = ioasid_alloc(NULL, PASID_MIN,
> > +		svm->pasid = ioasid_alloc(host_pasid_set,
> > PASID_MIN, pasid_max - 1, svm);
> >  		if (svm->pasid == INVALID_IOASID) {
> >  			kfree(svm);
> > @@ -568,7 +568,7 @@ intel_svm_bind_mm(struct device *dev, int
> > flags, struct svm_dev_ops *ops, if (mm) {
> >  			ret =
> > mmu_notifier_register(&svm->notifier, mm); if (ret) {
> > -				ioasid_free(svm->pasid);
> > +				ioasid_free(host_pasid_set,
> > svm->pasid); kfree(svm);
> >  				kfree(sdev);
> >  				goto out;
> > @@ -586,7 +586,7 @@ intel_svm_bind_mm(struct device *dev, int
> > flags, struct svm_dev_ops *ops, if (ret) {
> >  			if (mm)
> >  				mmu_notifier_unregister(&svm->notifier,
> > mm);
> > -			ioasid_free(svm->pasid);
> > +			ioasid_free(host_pasid_set, svm->pasid);
> >  			kfree(svm);
> >  			kfree(sdev);
> >  			goto out;
> > @@ -655,7 +655,7 @@ static int intel_svm_unbind_mm(struct device
> > *dev, int pasid) kfree_rcu(sdev, rcu);
> >  
> >  			if (list_empty(&svm->devs)) {
> > -				ioasid_free(svm->pasid);
> > +				ioasid_free(host_pasid_set,
> > svm->pasid); if (svm->mm)
> >  					mmu_notifier_unregister(&svm->notifier,
> > svm->mm); list_del(&svm->list);
> > diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> > index 5f63af07acd5..f73b3dbfc37a 100644
> > --- a/drivers/iommu/ioasid.c
> > +++ b/drivers/iommu/ioasid.c
> > @@ -1,22 +1,58 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> >   * I/O Address Space ID allocator. There is one global IOASID
> > space, split into
> > - * subsets. Users create a subset with DECLARE_IOASID_SET, then
> > allocate and
> > - * free IOASIDs with ioasid_alloc and ioasid_free.
> > + * subsets. Users create a subset with ioasid_alloc_set, then
> > allocate/free IDs
> > + * with ioasid_alloc and ioasid_free.
> >   */
> > -#include <linux/ioasid.h>
> >  #include <linux/module.h>
> >  #include <linux/slab.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/xarray.h>
> > +#include <linux/ioasid.h>  
> 
> Spurious change (best keep the includes in alphabetical order)
> 
I changed order so that I don't have to include more headers in
ioasid.h, but it is better to keep the order and add headers to ioasid.h

> > +
> > +static DEFINE_XARRAY_ALLOC(ioasid_sets);  
> 
> I'd prefer keeping all static variables together
> 
yes, same here :) will move.

> > +enum ioasid_state {
> > +	IOASID_STATE_INACTIVE,
> > +	IOASID_STATE_ACTIVE,
> > +	IOASID_STATE_FREE_PENDING,
> > +};
> >  
> > +/**
> > + * struct ioasid_data - Meta data about ioasid
> > + *
> > + * @id:		Unique ID
> > + * @users	Number of active users
> > + * @state	Track state of the IOASID
> > + * @set		Meta data of the set this IOASID belongs to
> > + * @private	Private data associated with the IOASID
> > + * @rcu		For free after RCU grace period  
> 
> nit: it would be nicer to follow the struct order
> 
yes, will do.

> > + */
> >  struct ioasid_data {
> >  	ioasid_t id;
> >  	struct ioasid_set *set;
> > +	refcount_t users;
> > +	enum ioasid_state state;
> >  	void *private;
> >  	struct rcu_head rcu;
> >  };
> >  
> > +/* Default to PCIe standard 20 bit PASID */
> > +#define PCI_PASID_MAX 0x100000
> > +static ioasid_t ioasid_capacity = PCI_PASID_MAX;
> > +static ioasid_t ioasid_capacity_avail = PCI_PASID_MAX;
> > +
> > +void ioasid_install_capacity(ioasid_t total)
> > +{
> > +	ioasid_capacity = ioasid_capacity_avail = total;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> > +
> > +ioasid_t ioasid_get_capacity()
> > +{
> > +	return ioasid_capacity;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_get_capacity);
> > +
> >  /*
> >   * struct ioasid_allocator_data - Internal data structure to hold
> > information
> >   * about an allocator. There are two types of allocators:
> > @@ -306,11 +342,23 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, {
> >  	struct ioasid_data *data;
> >  	void *adata;
> > -	ioasid_t id;
> > +	ioasid_t id = INVALID_IOASID;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	/* Check if the IOASID set has been allocated and
> > initialized */
> > +	if (WARN_ON(xa_load(&ioasid_sets, set->sid) != set)) {
> > +		pr_warn("Invalid set\n");  
> 
> WARN_ON() is sufficient
> 
right, will do

> > +		goto done_unlock;
> > +	}
> > +
> > +	if (set->quota <= set->nr_ioasids) {
> > +		pr_err("IOASID set %d out of quota %d\n",
> > set->sid, set->quota);  
> 
> As this can be called directly by userspace via VFIO, I wonder if we
> should remove non-bug error messages like this one to avoid leaking
> internal IDs, or at least rate-limit them. We already have a few,
> perhaps we should deal with them before the VFIO_IOMMU_ALLOC_PASID
> patches land?
> 
Good point, will hide internal IDs and add _ratelimited for VFIO
possible call path.

> > +		goto done_unlock;
> > +	}
> >  
> >  	data = kzalloc(sizeof(*data), GFP_ATOMIC);
> >  	if (!data)
> > -		return INVALID_IOASID;
> > +		goto done_unlock;
> >  
> >  	data->set = set;
> >  	data->private = private;
> > @@ -319,7 +367,6 @@ ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max,
> >  	 * Custom allocator needs allocator data to perform
> > platform specific
> >  	 * operations.
> >  	 */
> > -	spin_lock(&ioasid_allocator_lock);
> >  	adata = active_allocator->flags &
> > IOASID_ALLOCATOR_CUSTOM ? active_allocator->ops->pdata : data; id =
> > active_allocator->ops->alloc(min, max, adata); if (id ==
> > INVALID_IOASID) { @@ -335,42 +382,339 @@ ioasid_t
> > ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
> > goto exit_free; }
> >  	data->id = id;
> > +	data->state = IOASID_STATE_ACTIVE;
> > +	refcount_set(&data->users, 1);
> > +
> > +	/* Store IOASID in the per set data */
> > +	if (xa_err(xa_store(&set->xa, id, data, GFP_ATOMIC))) {
> > +		pr_err("Failed to ioasid %d in set %d\n", id,
> > set->sid);  
> 
> "Failed to store"
will fix

> Don't we need to call active_allocator->ops->free()?
> 
yes, also erase if custom allocator is used. How about:
	active_allocator->ops->free(id, active_allocator->ops->pdata);
	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM)
		xa_erase(&active_allocator->xa, id);

> And I need to think about this more, but do you see any issue with
> revoking here the data that we published into the xarray above through
> alloc()?  We might need to free data in an RCU callback.
> 
I don't see we need to do kfree_rcu since there shouldn't be any
readers before the alloc function returns. Or I am missing something?
> > +		goto exit_free;
> > +	}
> > +	set->nr_ioasids++;
> > +	goto done_unlock;
> >  
> > -	spin_unlock(&ioasid_allocator_lock);
> > -	return id;
> >  exit_free:
> > -	spin_unlock(&ioasid_allocator_lock);
> >  	kfree(data);
> > -	return INVALID_IOASID;
> > +done_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +	return id;
> >  }
> >  EXPORT_SYMBOL_GPL(ioasid_alloc);
> >  
> > +static void ioasid_do_free(struct ioasid_data *data)
> > +{
> > +	struct ioasid_data *ioasid_data;
> > +	struct ioasid_set *sdata;
> > +
> > +	active_allocator->ops->free(data->id,
> > active_allocator->ops->pdata);
> > +	/* Custom allocator needs additional steps to free the xa
> > element */
> > +	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> > +		ioasid_data = xa_erase(&active_allocator->xa,
> > data->id);
> > +		kfree_rcu(ioasid_data, rcu);
> > +	}
> > +
> > +	sdata = xa_load(&ioasid_sets, data->set->sid);
> > +	if (!sdata) {
> > +		pr_err("No set %d for IOASID %d\n", data->set->sid,
> > +		       data->id);
> > +		return;  
> 
> I don't think we're allowed to fail at this point. If we need more
> sanity-check on the parameters, it should be before we start removing
> from the active_allocator above. Otherwise this should be a WARN
> 
Good point, I will move this earlier as a WARN.

> > +	}
> > +	xa_erase(&sdata->xa, data->id);
> > +	sdata->nr_ioasids--;  
> 
> Would be nicer to perform the cleanup in the order opposite from
> ioasid_alloc()
> 
Yes, will switch the order.

> > +}
> > +
> > +static void ioasid_free_locked(struct ioasid_set *set, ioasid_t
> > ioasid) +{
> > +	struct ioasid_data *data;
> > +
> > +	data = xa_load(&active_allocator->xa, ioasid);
> > +	if (!data) {
> > +		pr_err("Trying to free unknown IOASID %u\n",
> > ioasid);
> > +		return;
> > +	}
> > +
> > +	if (data->set != set) {
> > +		pr_warn("Cannot free IOASID %u due to set
> > ownership\n", ioasid);
> > +		return;
> > +	}
> > +	data->state = IOASID_STATE_FREE_PENDING;
> > +
> > +	if (!refcount_dec_and_test(&data->users))
> > +		return;
> > +
> > +	ioasid_do_free(data);
> > +}
> > +
> >  /**
> > - * ioasid_free - Free an IOASID
> > - * @ioasid: the ID to remove
> > + * ioasid_free - Drop reference on an IOASID. Free if refcount
> > drops to 0,
> > + *               including free from its set and system-wide list.
> > + * @set:	The ioasid_set to check permission with. If not
> > NULL, IOASID
> > + *		free will fail if the set does not match.
> > + * @ioasid:	The IOASID to remove
> >   */
> > -void ioasid_free(ioasid_t ioasid)
> > +void ioasid_free(struct ioasid_set *set, ioasid_t ioasid)
> >  {
> > -	struct ioasid_data *ioasid_data;
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_free_locked(set, ioasid);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_free);
> >  
> > +/**
> > + * ioasid_alloc_set - Allocate a new IOASID set for a given token
> > + *
> > + * @token:	Unique token of the IOASID set, cannot be NULL
> > + * @quota:	Quota allowed in this set. Only for new set
> > creation
> > + * @flags:	Special requirements  
> 
> There is no @flags, but @type is missing
> 
right, will fix.

> > + *
> > + * IOASID can be limited system-wide resource that requires quota
> > management.
> > + * If caller does not wish to enforce quota, use
> > IOASID_SET_NO_QUOTA flag.  
> 
> The flag isn't introduced in this patch. How about passing @quota ==
> 0 in this case?  For now I'm fine with leaving this as TODO and
> returning -EINVAL.
> 
I will remove the flag for now. We can add @quota == 0 case later.

> > + *
> > + * Token will be stored in the ioasid_set returned. A reference
> > will be taken
> > + * upon finding a matching set or newly created set.
> > + * IOASID allocation within the set and other per set operations
> > will use
> > + * the retured ioasid_set *.
> > + *
> > + */
> > +struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota,
> > int type) +{
> > +	struct ioasid_set *sdata;
> > +	unsigned long index;
> > +	ioasid_t id;
> > +
> > +	if (type >= IOASID_SET_TYPE_NR)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	/*
> > +	 * Need to check space available if we share system-wide
> > quota.
> > +	 * TODO: we may need to support quota free sets in the
> > future.
> > +	 */
> >  	spin_lock(&ioasid_allocator_lock);
> > -	ioasid_data = xa_load(&active_allocator->xa, ioasid);
> > -	if (!ioasid_data) {
> > -		pr_err("Trying to free unknown IOASID %u\n",
> > ioasid);
> > +	if (quota > ioasid_capacity_avail) {
> > +		pr_warn("Out of IOASID capacity! ask %d, avail
> > %d\n",
> > +			quota, ioasid_capacity_avail);
> > +		sdata = ERR_PTR(-ENOSPC);
> >  		goto exit_unlock;
> >  	}
> >  
> > -	active_allocator->ops->free(ioasid,
> > active_allocator->ops->pdata);
> > -	/* Custom allocator needs additional steps to free the xa
> > element */
> > -	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
> > -		ioasid_data = xa_erase(&active_allocator->xa,
> > ioasid);
> > -		kfree_rcu(ioasid_data, rcu);
> > +	/*
> > +	 * Token is only unique within its types but right now we
> > have only
> > +	 * mm type. If we have more token types, we have to match
> > type as well.
> > +	 */
> > +	switch (type) {
> > +	case IOASID_SET_TYPE_MM:
> > +		/* Search existing set tokens, reject duplicates */
> > +		xa_for_each(&ioasid_sets, index, sdata) {
> > +			if (sdata->token == token &&
> > +				sdata->type == IOASID_SET_TYPE_MM)
> > {  
> 
> Should be aligned at the "if ("
> 
> According to the function doc, shouldn't we take a reference to the
> set in this case, and return it?
> "A reference will be taken upon finding a matching set or newly
> created set."
> 
> However it might be better to separate the two functionalities into
> ioasid_alloc_set() and ioasid_find_set(). Because two modules can
> want to work on the same set for an mm, but they won't pass the same
> @quota, right?  So it'd make more sense for one of them (VFIO) to
> alloc the set and the other to reuse it.
I went back and forth on this but yes, it is better to keep them
separate. So far the only use case for find is
ioasid_find_mm_set()
Will take reference during set allocation.

> 
> > +				sdata = ERR_PTR(-EEXIST);
> > +				goto exit_unlock;
> > +			}
> > +		}
> > +		break;
> > +	case IOASID_SET_TYPE_NULL:
> > +		if (!token)
> > +			break;
> > +		fallthrough;
> > +	default:
> > +		pr_err("Invalid token and IOASID type\n");
> > +		sdata = ERR_PTR(-EINVAL);
> > +		goto exit_unlock;
> >  	}
> >  
> > +	/* REVISIT: may support set w/o quota, use system
> > available */
> > +	if (!quota) {  
> 
> Maybe move this next to the other quota check above
> 
yes, that is better. no need to be under the spinlock either.

> > +		sdata = ERR_PTR(-EINVAL);
> > +		goto exit_unlock;
> > +	}
> > +
> > +	sdata = kzalloc(sizeof(*sdata), GFP_ATOMIC);
> > +	if (!sdata) {
> > +		sdata = ERR_PTR(-ENOMEM);
> > +		goto exit_unlock;
> > +	}
> > +
> > +	if (xa_alloc(&ioasid_sets, &id, sdata,
> > +			XA_LIMIT(0, ioasid_capacity_avail -
> > quota),  
> 
> Why this limit?  sid could just be an arbitrary u32 (xa_limit_32b)
> 
True, but I was thinking the number of sets cannot be more than the
number of available IOASIDs. XA allocator should be able to find empty
slots within this range. Performance is better if the IDs are densely
populated.

> > +			GFP_ATOMIC)) {
> > +		kfree(sdata);
> > +		sdata = ERR_PTR(-ENOSPC);
> > +		goto exit_unlock;
> > +	}
> > +
> > +	sdata->token = token;
> > +	sdata->type = type;
> > +	sdata->quota = quota;
> > +	sdata->sid = id;
> > +	refcount_set(&sdata->ref, 1);
> > +
> > +	/*
> > +	 * Per set XA is used to store private IDs within the set,
> > get ready
> > +	 * for ioasid_set private ID and system-wide IOASID
> > allocation
> > +	 * results.
> > +	 */
> > +	xa_init_flags(&sdata->xa, XA_FLAGS_ALLOC);  
> 
> Since it's only used for storage, you could use xa_init()
> 
good point, will do.

> > +	ioasid_capacity_avail -= quota;
> > +
> >  exit_unlock:
> >  	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return sdata;
> >  }
> > -EXPORT_SYMBOL_GPL(ioasid_free);
> > +EXPORT_SYMBOL_GPL(ioasid_alloc_set);
> > +
> > +void ioasid_set_get_locked(struct ioasid_set *set)
> > +{
> > +	if (WARN_ON(xa_load(&ioasid_sets, set->sid) != set)) {
> > +		pr_warn("Invalid set data\n");  
> 
> WARN_ON() is sufficient
> 
yes

> > +		return;
> > +	}
> > +
> > +	refcount_inc(&set->ref);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_get_locked);  
> 
> Why is this function public, is it for an iterator?  Might want to
> add a lockdep_assert_held() annotation.
> 
You are right, no need to be public now.

Earlier, we had a design for users to acquire ioasid_set reference in
the notifier handler (under lock). Since KVM may not know when or if the
ioasid_set for its VM is created, we wanted KVM to listen to ioasid_set
allocation event then register notifier block.
In the current design we have a notifier pending list so users such
as KVM does not need to be aware of ioasid_set.

> > +
> > +void ioasid_set_get(struct ioasid_set *set)
> > +{
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_set_get_locked(set);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_get);
> > +
> > +void ioasid_set_put_locked(struct ioasid_set *set)
> > +{
> > +	struct ioasid_data *entry;
> > +	unsigned long index;
> > +
> > +	if (WARN_ON(xa_load(&ioasid_sets, set->sid) != set)) {
> > +		pr_warn("Invalid set data\n");  
> 
> WARN_ON() is sufficient
> 
got it

> > +		return;
> > +	}
> > +
> > +	if (!refcount_dec_and_test(&set->ref)) {
> > +		pr_debug("%s: IOASID set %d has %d users\n",
> > +			__func__, set->sid,
> > refcount_read(&set->ref));
> > +		return;
> > +	}
> > +
> > +	/* The set is already empty, we just destroy the set. */
> > +	if (xa_empty(&set->xa))
> > +		goto done_destroy;
> > +
> > +	/*
> > +	 * Free all PASIDs from system-wide IOASID pool, all
> > subscribers gets
> > +	 * notified and do cleanup of their own.
> > +	 * Note that some references of the IOASIDs within the set
> > can still
> > +	 * be held after the free call. This is OK in that the
> > IOASIDs will be
> > +	 * marked inactive, the only operations can be done is
> > ioasid_put.
> > +	 * No need to track IOASID set states since there is no
> > reclaim phase.
> > +	 */
> > +	xa_for_each(&set->xa, index, entry) {
> > +		ioasid_free_locked(set, index);
> > +		/* Free from per set private pool */
> > +		xa_erase(&set->xa, index);
> > +	}
> > +
> > +done_destroy:
> > +	/* Return the quota back to system pool */
> > +	ioasid_capacity_avail += set->quota;
> > +	kfree_rcu(set, rcu);
> > +
> > +	/*
> > +	 * Token got released right away after the ioasid_set is
> > freed.
> > +	 * If a new set is created immediately with the newly
> > released token,
> > +	 * it will not allocate the same IOASIDs unless they are
> > reclaimed.
> > +	 */
> > +	xa_erase(&ioasid_sets, set->sid);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_put_locked);  
> 
> Same comment as ioasid_set_get_locked
> 
same, will remove :)

> > +
> > +/**
> > + * ioasid_set_put - Drop a reference to the IOASID set. Free all
> > IOASIDs within
> > + *                  the set if there are no more users.
> > + *
> > + * @set:	The IOASID set ID to be freed
> > + *
> > + * If refcount drops to zero, all IOASIDs allocated within the set
> > will be
> > + * freed.
> > + */
> > +void ioasid_set_put(struct ioasid_set *set)
> > +{
> > +	spin_lock(&ioasid_allocator_lock);
> > +	ioasid_set_put_locked(set);
> > +	spin_unlock(&ioasid_allocator_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_put);
> > +
> > +/**
> > + * ioasid_adjust_set - Adjust the quota of an IOASID set
> > + * @set:	IOASID set to be assigned
> > + * @quota:	Quota allowed in this set
> > + *
> > + * Return 0 on success. If the new quota is smaller than the
> > number of
> > + * IOASIDs already allocated, -EINVAL will be returned. No change
> > will be
> > + * made to the existing quota.
> > + */
> > +int ioasid_adjust_set(struct ioasid_set *set, int quota)
> > +{
> > +	int ret = 0;
> > +
> > +	spin_lock(&ioasid_allocator_lock);
> > +	if (set->nr_ioasids > quota) {
> > +		pr_err("New quota %d is smaller than outstanding
> > IOASIDs %d\n",
> > +			quota, set->nr_ioasids);
> > +		ret = -EINVAL;
> > +		goto done_unlock;
> > +	}
> > +
> > +	if (quota >= ioasid_capacity_avail) {
> > +		ret = -ENOSPC;
> > +		goto done_unlock;
> > +	}
> > +
> > +	/* Return the delta back to system pool */
> > +	ioasid_capacity_avail += set->quota - quota;  
> 
> I think this is correct as long as the above check is fixed (as
> pointed out by Baolu). A check that quota >= 0 could be nice too.
> 
yes, will fix per Baolu.
Will add a check for quota > 0 but 0 is not supported yet.

> > +
> > +	/*
> > +	 * May have a policy to prevent giving all available
> > IOASIDs
> > +	 * to one set. But we don't enforce here, it should be in
> > the
> > +	 * upper layers.
> > +	 */
> > +	set->quota = quota;
> > +
> > +done_unlock:
> > +	spin_unlock(&ioasid_allocator_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_adjust_set);
> > +
> > +/**
> > + * ioasid_set_for_each_ioasid - Iterate over all the IOASIDs
> > within the set
> > + *
> > + * Caller must hold a reference of the set and handles its own
> > locking.
> > + */
> > +int ioasid_set_for_each_ioasid(struct ioasid_set *set,
> > +			       void (*fn)(ioasid_t id, void *data),
> > +			       void *data)
> > +{
> > +	struct ioasid_data *entry;
> > +	unsigned long index;
> > +	int ret = 0;
> > +
> > +	if (xa_empty(&set->xa)) {  
> 
> Who calls this function?
This is called by Yi's VFIO PASID code. Not sure when he will send out
but should be soon. The use case is when a guest terminates, VFIO can
call this function to free all PASIDs for this guest.

>  Empty xa may be a normal use-case if the
> caller just uses it for sweeping, so pr_warn() could be problematic.
> The returned value also isn't particularly accurate if concurrent
> ioasid_alloc/free are allowed, so I'd drop this.
> 
Right, xa could be empty if the guest never allocated PASIDS. Will drop
the check and make the function void.

> > +		pr_warn("No IOASIDs in the set %d\n", set->sid);
> > +		return -ENOENT;
> > +	}
> > +
> > +	xa_for_each(&set->xa, index, entry) {
> > +		fn(index, data);
> > +	}
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
> >  
> >  /**
> >   * ioasid_find - Find IOASID data
> > diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> > index 9c44947a68c8..412d025d440e 100644
> > --- a/include/linux/ioasid.h
> > +++ b/include/linux/ioasid.h
> > @@ -10,8 +10,35 @@ typedef unsigned int ioasid_t;
> >  typedef ioasid_t (*ioasid_alloc_fn_t)(ioasid_t min, ioasid_t max,
> > void *data); typedef void (*ioasid_free_fn_t)(ioasid_t ioasid, void
> > *data); 
> > +/* IOASID set types */
> > +enum ioasid_set_type {
> > +	IOASID_SET_TYPE_NULL = 1, /* Set token is NULL */
> > +	IOASID_SET_TYPE_MM,	  /* Set token is a mm_struct,
> > +				   * i.e. associated with a process
> > +				   */
> > +	IOASID_SET_TYPE_NR,
> > +};
> > +
> > +/**
> > + * struct ioasid_set - Meta data about ioasid_set
> > + * @type:	Token types and other features  
> 
> nit: doesn't follow struct order
> 
will fix.

> > + * @token:	Unique to identify an IOASID set
> > + * @xa:		XArray to store ioasid_set private IDs, can
> > be used for
> > + *		guest-host IOASID mapping, or just a private
> > IOASID namespace.
> > + * @quota:	Max number of IOASIDs can be allocated within
> > the set
> > + * @nr_ioasids	Number of IOASIDs currently allocated in the
> > set
> > + * @sid:	ID of the set
> > + * @ref:	Reference count of the users
> > + */
> >  struct ioasid_set {
> > -	int dummy;
> > +	void *token;
> > +	struct xarray xa;
> > +	int type;
> > +	int quota;
> > +	int nr_ioasids;
> > +	int sid;
> > +	refcount_t ref;
> > +	struct rcu_head rcu;
> >  };
> >  
> >  /**
> > @@ -29,31 +56,64 @@ struct ioasid_allocator_ops {
> >  	void *pdata;
> >  };
> >  
> > -#define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> > -
> >  #if IS_ENABLED(CONFIG_IOASID)
> > +void ioasid_install_capacity(ioasid_t total);
> > +ioasid_t ioasid_get_capacity(void);
> > +struct ioasid_set *ioasid_alloc_set(void *token, ioasid_t quota,
> > int type); +int ioasid_adjust_set(struct ioasid_set *set, int
> > quota); +void ioasid_set_get_locked(struct ioasid_set *set);
> > +void ioasid_set_put_locked(struct ioasid_set *set);
> > +void ioasid_set_put(struct ioasid_set *set);  
> 
> These three functions need a stub for !CONFIG_IOASID
> 
will do.

> > +
> >  ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
> > ioasid_t max, void *private);
> > -void ioasid_free(ioasid_t ioasid);
> > -void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
> > -		  bool (*getter)(void *));
> > +void ioasid_free(struct ioasid_set *set, ioasid_t ioasid);
> > +
> > +bool ioasid_is_active(ioasid_t ioasid);  
> 
> Not implemented by this series?
> 
should be removed. Had a use earlier but not anymore.

> > +
> > +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool
> > (*getter)(void *));  
> 
> Spurious change
> 
> > +int ioasid_attach_data(ioasid_t ioasid, void *data);
> >  int ioasid_register_allocator(struct ioasid_allocator_ops
> > *allocator); void ioasid_unregister_allocator(struct
> > ioasid_allocator_ops *allocator); -int ioasid_attach_data(ioasid_t
> > ioasid, void *data);  
> 
> Spurious change?
yes, will remove.

> > -
> > +void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);  
> 
> Not implemented here
> 
will remove

> > +int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
> > +			       void (*fn)(ioasid_t id, void *data),
> > +			       void *data);  
> 
> Needs a stub for !CONFIG_IOASID
> 
got it

> >  #else /* !CONFIG_IOASID */
> > +static inline void ioasid_install_capacity(ioasid_t total)
> > +{
> > +}
> > +
> > +static inline ioasid_t ioasid_get_capacity(void)
> > +{
> > +	return 0;
> > +}
> > +
> >  static inline ioasid_t ioasid_alloc(struct ioasid_set *set,
> > ioasid_t min, ioasid_t max, void *private)
> >  {
> >  	return INVALID_IOASID;
> >  }
> >  
> > -static inline void ioasid_free(ioasid_t ioasid)
> > +static inline void ioasid_free(struct ioasid_set *set, ioasid_t
> > ioasid) +{
> > +}
> > +
> > +static inline bool ioasid_is_active(ioasid_t ioasid)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline struct ioasid_set *ioasid_alloc_set(void *token,
> > ioasid_t quota, int type) +{
> > +	return ERR_PTR(-ENOTSUPP);
> > +}
> > +
> > +static inline void ioasid_set_put(struct ioasid_set *set)
> >  {
> >  }
> >  
> > -static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> > ioasid,
> > -				bool (*getter)(void *))
> > +static inline void *ioasid_find(struct ioasid_set *set, ioasid_t
> > ioasid, bool (*getter)(void *))  
> 
> Spurious change
> 
got it

> Thanks,
> Jean
> 
> >  {
> >  	return NULL;
> >  }
> > -- 
> > 2.7.4
> >   
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
