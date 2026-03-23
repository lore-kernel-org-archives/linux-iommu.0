Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5EC376BF1
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774300297; cv=none; b=Out8zIc0rGd/b98+85ljtuo8Ty4ufwbGDEzX7nyG8vIIiXOXEHcni6+LRzdrxnDOcdI1Or26IR5ww2rsMXPwImFRRqUf7Qx2jBPsjEsbSsD7VQ7yRPsofMPGNIy4umjCKfgRtKrW2PtIMJCrjJ5H0Fcb+SjHveWeQJ3CviAVeCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774300297; c=relaxed/simple;
	bh=YnNpFlkrN7K96yD05qSGkAKlSp3MQ/jXKnppuoyjqcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5XIwAlTzUlOrLRKwrvqFGxs7+HZ+Ax+SIZGQxzvC/p7xdGe89qi0O016jf+uE5sm2cY/KwXS5af3/WEDej8Mp3P7HIa6/95ct4moOa09fQEqPS0FdXhbgfQgf7Y99ToTd5NLqh6FXCB0TAFtrNActAtOU6xV3mOPakLlVEO0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qBiz37fR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qBiz37fR"
Received: from localhost (unknown [20.236.11.185])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5EE420B710C;
	Mon, 23 Mar 2026 14:11:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5EE420B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774300294;
	bh=E9X0w7l733ewFl2e6CgPiTWYsnoIK06lhnDve0EMFUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qBiz37fRcjQQPR3I4WKAzMqdBgFXqZX3PJrwuj9By67JX98DTMGuQ0Qo6bn/S4UkJ
	 orUW4nLijBdQz8w5mJsgJCPfOyjO2TaZVxGZpt7fa/xdG4uIfDGMQBn90kHPmtZ32e
	 juxTh/Few0P5t21Y3xZqqvlrzOz200bb51UwfchI=
Date: Mon, 23 Mar 2026 14:11:32 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu
 driver for noiommu
Message-ID: <20260323141132.00003dc7@linux.microsoft.com>
In-Reply-To: <ab-1VZshPREYYuI8@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
	<20260312155637.376854-2-jacob.pan@linux.microsoft.com>
	<ab-1VZshPREYYuI8@google.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mostafa,

On Sun, 22 Mar 2026 09:24:37 +0000
Mostafa Saleh <smostafa@google.com> wrote:

> On Thu, Mar 12, 2026 at 08:56:27AM -0700, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Create just a little part of a real iommu driver, enough to
> > slot in under the dev_iommu_ops() and allow iommufd to call
> > domain_alloc_paging_flags() and fail everything else.
> > 
> > This allows explicitly creating a HWPT under an IOAS.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> >  drivers/iommu/iommufd/Makefile          |  1 +
> >  drivers/iommu/iommufd/hw_pagetable.c    | 11 ++-
> >  drivers/iommu/iommufd/hwpt_noiommu.c    | 91
> > +++++++++++++++++++++++++ drivers/iommu/iommufd/iommufd_private.h |
> >  2 + 4 files changed, 103 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> > 
> > diff --git a/drivers/iommu/iommufd/Makefile
> > b/drivers/iommu/iommufd/Makefile index 71d692c9a8f4..2b1a020b14a6
> > 100644 --- a/drivers/iommu/iommufd/Makefile
> > +++ b/drivers/iommu/iommufd/Makefile
> > @@ -10,6 +10,7 @@ iommufd-y := \
> >  	vfio_compat.o \
> >  	viommu.o
> >  
> > +iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o
> >  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
> >  
> >  obj-$(CONFIG_IOMMUFD) += iommufd.o
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c index
> > fe789c2dc0c9..37316d77277d 100644 ---
> > a/drivers/iommu/iommufd/hw_pagetable.c +++
> > b/drivers/iommu/iommufd/hw_pagetable.c @@ -8,6 +8,13 @@
> >  #include "../iommu-priv.h"
> >  #include "iommufd_private.h"
> >  
> > +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> > *idev) +{
> > +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> > !idev->igroup->group)
> > +		return &iommufd_noiommu_ops;
> > +	return dev_iommu_ops(idev->dev);
> > +}
> > +
> >  static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable
> > *hwpt) {
> >  	if (hwpt->domain)
> > @@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas, IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> >  				IOMMU_HWPT_FAULT_ID_VALID |
> >  				IOMMU_HWPT_ALLOC_PASID;
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >  	struct iommufd_hwpt_paging *hwpt_paging;
> >  	struct iommufd_hw_pagetable *hwpt;
> >  	int rc;
> > @@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_device *idev, u32 flags,
> >  			  const struct iommu_user_data *user_data)
> >  {
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >  	struct iommufd_hwpt_nested *hwpt_nested;
> >  	struct iommufd_hw_pagetable *hwpt;
> >  	int rc;
> > diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c
> > b/drivers/iommu/iommufd/hwpt_noiommu.c new file mode 100644
> > index 000000000000..0aa99f581ca3
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> > + */
> > +#include <linux/iommu.h>
> > +#include <linux/generic_pt/iommu.h>
> > +#include "iommufd_private.h"
> > +
> > +static const struct iommu_domain_ops noiommu_amdv1_ops;
> > +
> > +struct noiommu_domain {
> > +	union {
> > +		struct iommu_domain domain;
> > +		struct pt_iommu_amdv1 amdv1;
> > +	};
> > +	spinlock_t lock;
> > +};
> > +PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
> > +
> > +static void noiommu_change_top(struct pt_iommu *iommu_table,
> > +			       phys_addr_t top_paddr, unsigned int
> > top_level) +{
> > +}
> > +
> > +static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
> > +{
> > +	struct noiommu_domain *domain =
> > +		container_of(iommupt, struct noiommu_domain,
> > amdv1.iommu); +
> > +	return &domain->lock;
> > +}
> > +
> > +static const struct pt_iommu_driver_ops noiommu_driver_ops = {
> > +	.get_top_lock = noiommu_get_top_lock,
> > +	.change_top = noiommu_change_top,
> > +};
> > +
> > +static struct iommu_domain *
> > +noiommu_alloc_paging_flags(struct device *dev, u32 flags,
> > +			   const struct iommu_user_data *user_data)
> > +{
> > +	struct pt_iommu_amdv1_cfg cfg = {};
> > +	struct noiommu_domain *dom;
> > +	int rc;
> > +
> > +	if (flags || user_data)
> > +		return ERR_PTR(-EOPNOTSUPP);
> > +
> > +	cfg.common.hw_max_vasz_lg2 = 64;
> > +	cfg.common.hw_max_oasz_lg2 = 52;
> > +	cfg.starting_level = 2;
> > +	cfg.common.features =
> > +		(BIT(PT_FEAT_DYNAMIC_TOP) |
> > BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> > +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
> > +
> > +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> > +	if (!dom)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	spin_lock_init(&dom->lock);
> > +	dom->amdv1.iommu.nid = NUMA_NO_NODE;
> > +	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
> > +	dom->domain.ops = &noiommu_amdv1_ops;
> > +
> > +	/* Use mock page table which is based on AMDV1 */
> > +	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
> > +	if (rc) {
> > +		kfree(dom);
> > +		return ERR_PTR(rc);
> > +	}
> > +
> > +	return &dom->domain;
> > +}
> > +
> > +static void noiommu_domain_free(struct iommu_domain *iommu_domain)
> > +{
> > +	struct noiommu_domain *domain =
> > +		container_of(iommu_domain, struct noiommu_domain,
> > domain); +
> > +	pt_iommu_deinit(&domain->amdv1.iommu);
> > +	kfree(domain);
> > +}
> > +
> > +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> > +	IOMMU_PT_DOMAIN_OPS(amdv1),  
> 
> I see the appeal of re-using an existing page table implementation to
> keep track of iovas which -as far as I understand- are used as tokens
> for DMA pinned pages later, but maybe at least add some paragraph
> about that, as it is not immediately clear and that's a different
> design from the legacy noiommu VFIO code.
> 
Indeed it is a little confusing where we use the same VFIO noiommu
knobs but with extended set of features. The legacy VFIO noiommu mode
does not support container/IOAS level APIs thus no need for domain ops.

I also tried to explain the new design in the doc patch[11/11] with
summaries of API limitations between legacy VFIO noiommu mode and this
new mode under iommufd.
+-------------------+---------------------+---------------------+
| Feature           | VFIO group          | VFIO device cdev   |
+===================+=====================+=====================+
| VFIO device UAPI  | Yes                 | Yes                |
+-------------------+---------------------+---------------------+
| VFIO container    | No                  | No                 |
+-------------------+---------------------+---------------------+
| IOMMUFD IOAS      | No                  | Yes*               |
+-------------------+---------------------+---------------------+

How about adding the following comments:

@@ -81,6 +81,17 @@ static void noiommu_domain_free(struct iommu_domain *iommu_domain)
        kfree(domain);
 }
 
+/*
+ * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to the
+ * iommufd selftest mock page table.
+ * Unlike legacy VFIO no-IOMMU mode, where no container level APIs are
+ * supported, this allows IOAS and hwpt objects to exist without hardware
+ * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not for
+ * hardware translation in DMA.
+ *
+ * This is only used with iommufd and cdev-based interfaces and does not
+ * apply to legacy VFIO group-container based noiommu mode.
+ */
 static const struct iommu_domain_ops noiommu_amdv1_ops = {
        IOMMU_PT_DOMAIN_OPS(amdv1),
