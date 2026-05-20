Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F5361666
	for <iommu@lists.linux.dev>; Wed, 20 May 2026 16:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293738; cv=none; b=U4hWLmjlTfSDGrrLekMEo/BgCZAyf1Ks6bcQX8CoO0bMQFqcy5+G3t7S++TZOQL0IPJ2HO5mY6ArnCI7RfiqSi+LDB5Fmh7KTGPELx2CB06DWJZB3JtLBj7TMKvFAqd6IUxEEEcsJ8Zup9CKXUiUsF5Iis2VaSYWNlS9A44xSyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293738; c=relaxed/simple;
	bh=04qyCH0T+PgRBPa665VPNhRIa0xd5xAUpYOuLixKpVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8tS3NnTN/FGxrBahDn8Mn+7doxgMZ4UbZijLTGuPScGHbWHORlCGdDnPsYCdQjIKWl7JJ1padiNJTQSXLJuCub0Rnu6bi3Yz9aHnf8wd5iHgsnDSONeE1t76KuaXdjU94gtuh4UDjVtqQfuUQ24gU1f7+gOQ+l+61/N6WjB77Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fm9xfCC4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fm9xfCC4"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id AAEBE20B7167;
	Wed, 20 May 2026 09:15:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AAEBE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779293729;
	bh=QNWnUMlS1+5B6fYHdpvU4VZYGC7Lvzjbt4BDuNYIOFY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fm9xfCC4+EKe8JYEzx6RnqiyV9qXOjXhCMIXaJyxKe+w6z6sO1WABadm8eO5mcnqx
	 tj7eHli9vwsyY5SLI289WgHPWNCRdMhnIjH0heXxniAshWmUfTOF/TVu9Lys/c1K61
	 VSWuuxqod65zyzgIf7gAW8zELmjtiA2xtUu3Nxjo=
Date: Wed, 20 May 2026 09:15:33 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Saurabh Sengar <ssengar@linux.microsoft.com>,
 <skhawaja@google.com>, <pasha.tatashin@soleen.com>, Will Deacon
 <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 2/9] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <20260520091533.0000629e@linux.microsoft.com>
In-Reply-To: <7297d32e-5f36-4996-8b9d-20acc94140a0@intel.com>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
	<20260511184116.3687392-3-jacob.pan@linux.microsoft.com>
	<7297d32e-5f36-4996-8b9d-20acc94140a0@intel.com>
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

Hi Yi,

On Wed, 20 May 2026 15:19:13 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/12/26 02:41, Jacob Pan wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > 
> > Create just a little part of a real iommu driver, enough to
> > slot in under the dev_iommu_ops() and allow iommufd to call
> > domain_alloc_paging_flags() and fail everything else.
> > 
> > This allows explicitly creating a HWPT under an IOAS.
> > 
> > A new Kconfig option IOMMUFD_NOIOMMU is introduced to differentiate
> > from the VFIO group/container based noiommu mode.
> > 
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > ---
> > v5:
> >     - Use the new IOMMUFD_NOIOMMU Kconfig instead of VFIO_NOIOMMU
> >     - Use consistent wording referring to VFIO noiommu mode (Kevin)
> >     - Copyright date fix (Kevin)
> > v4:
> >     - Make iommufd_noiommu_ops const
> > v3:
> >     - Add comment to explain the design difference over the
> >       legacy noiommu VFIO code.
> > ---
> >   drivers/iommu/iommufd/Kconfig           |  13 +++
> >   drivers/iommu/iommufd/Makefile          |   1 +
> >   drivers/iommu/iommufd/hw_pagetable.c    |  15 +++-
> >   drivers/iommu/iommufd/hwpt_noiommu.c    | 102
> > ++++++++++++++++++++++++ drivers/iommu/iommufd/iommufd_private.h |
> >  2 + 5 files changed, 131 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> > 
> > diff --git a/drivers/iommu/iommufd/Kconfig
> > b/drivers/iommu/iommufd/Kconfig index 455bac0351f2..74d6ea5b5b3b
> > 100644 --- a/drivers/iommu/iommufd/Kconfig
> > +++ b/drivers/iommu/iommufd/Kconfig
> > @@ -16,6 +16,19 @@ config IOMMUFD
> >   	  If you don't know what to do here, say N.
> >   
> >   if IOMMUFD
> > +config IOMMUFD_NOIOMMU
> > +	bool
> > +	depends on !GENERIC_ATOMIC64 # IOMMU_PT_AMDV1 requires
> > cmpxchg64
> > +	select GENERIC_PT
> > +	select IOMMU_PT
> > +	select IOMMU_PT_AMDV1
> > +	help
> > +	  Provides a SW-only IO page table for devices without
> > hardware
> > +	  IOMMU backing. This uses the AMDV1 page table format for
> > +	  IOVA-to-PA lookups only, not for hardware DMA
> > translation. +
> > +	  Selected by VFIO_CDEV_NOIOMMU. Not intended to be
> > enabled directly. +
> >   config IOMMUFD_VFIO_CONTAINER
> >   	bool "IOMMUFD provides the VFIO container /dev/vfio/vfio"
> >   	depends on VFIO_GROUP && !VFIO_CONTAINER
> > diff --git a/drivers/iommu/iommufd/Makefile
> > b/drivers/iommu/iommufd/Makefile index 71d692c9a8f4..67207914bb6e
> > 100644 --- a/drivers/iommu/iommufd/Makefile
> > +++ b/drivers/iommu/iommufd/Makefile
> > @@ -10,6 +10,7 @@ iommufd-y := \
> >   	vfio_compat.o \
> >   	viommu.o
> >   
> > +iommufd-$(CONFIG_IOMMUFD_NOIOMMU) += hwpt_noiommu.o
> >   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
> >   
> >   obj-$(CONFIG_IOMMUFD) += iommufd.o
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c index
> > fe789c2dc0c9..0ae14cd3fc72 100644 ---
> > a/drivers/iommu/iommufd/hw_pagetable.c +++
> > b/drivers/iommu/iommufd/hw_pagetable.c @@ -8,6 +8,15 @@
> >   #include "../iommu-priv.h"
> >   #include "iommufd_private.h"
> >   
> > +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> > *idev) +{
> > +	if (IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU) &&
> > !idev->igroup->group)
> > +		return &iommufd_noiommu_ops;
> > +	if (WARN_ON_ONCE(!idev->dev->iommu))
> > +		return NULL;
> > +	return dev_iommu_ops(idev->dev);
> > +}
> > +
> >   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable
> > *hwpt) {
> >   	if (hwpt->domain)
> > @@ -114,11 +123,13 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas, IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> >   				IOMMU_HWPT_FAULT_ID_VALID |
> >   				IOMMU_HWPT_ALLOC_PASID;
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >   	struct iommufd_hwpt_paging *hwpt_paging;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> >   
> > +	if (!ops)
> > +		return ERR_PTR(-ENODEV);
> >   	lockdep_assert_held(&ioas->mutex);
> >   
> >   	if ((flags || user_data) &&
> > !ops->domain_alloc_paging_flags) @@ -229,7 +240,7 @@
> > iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx, struct
> > iommufd_device *idev, u32 flags, const struct iommu_user_data
> > *user_data) {
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >   	struct iommufd_hwpt_nested *hwpt_nested;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> > diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c
> > b/drivers/iommu/iommufd/hwpt_noiommu.c new file mode 100644
> > index 000000000000..b1efc4bca880
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
> > + */
> > +#include <linux/iommu.h>
> > +#include <linux/generic_pt/iommu.h>
> > +#include "iommufd_private.h"  
> 
> you missed the comments in the below link except for the kconfig
> comment. :(
> 
indeed, sorry about that. will make the following change in v6:

+++ b/drivers/iommu/iommufd/hwpt_noiommu.c
@@ -2,8 +2,8 @@
 /*
  * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES
  */
-#include <linux/iommu.h>
 #include <linux/generic_pt/iommu.h>
+#include <linux/iommu.h>
 #include "iommufd_private.h"

 static const struct iommu_domain_ops noiommu_amdv1_ops;
@@ -62,7 +62,7 @@ noiommu_alloc_paging_flags(struct device *dev, u32 flags,
        dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
        dom->domain.ops = &noiommu_amdv1_ops;

-       /* Use mock page table which is based on AMDV1 */
+       /* Use SW-only page table which is based on AMDV1 */
        rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
        if (rc) {
                kfree(dom);
@@ -82,15 +82,10 @@ static void noiommu_domain_free(struct iommu_domain *iommu_domain)
 }

 /*
- * AMDV1 is used as a SW-only page table for no-IOMMU mode, similar to the
- * iommufd selftest mock page table.
- * Unlike the VFIO group-container based no-IOMMU mode, where no container
- * level APIs are supported, this allows IOAS and hwpt objects to exist
- * without hardware IOMMU support. IOVAs are used only for IOVA-to-PA
- * lookups not for hardware translation in DMA.
- *
- * This is only used with iommufd and cdev-based interfaces and does not
- * apply to the VFIO group-container based noiommu mode.
+ * Domain ops for iommufd no-IOMMU mode. Uses AMDV1 format as a
+ * SW-only IOPT because it has the best multi-page size options
+ * of all the formats. IOVAs serve only for IOVA-to-PA lookups,
+ * not for hardware DMA translation.
  */
> https://lore.kernel.org/linux-iommu/b0bf1e99-d7d0-4e62-8a97-114e8e990b58@intel.com/#t
> 
> 
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
> > +/*
> > + * AMDV1 is used as a SW-only page table for no-IOMMU mode,
> > similar to the
> > + * iommufd selftest mock page table.
> > + * Unlike the VFIO group-container based no-IOMMU mode, where no
> > container
> > + * level APIs are supported, this allows IOAS and hwpt objects to
> > exist
> > + * without hardware IOMMU support. IOVAs are used only for
> > IOVA-to-PA
> > + * lookups not for hardware translation in DMA.
> > + *
> > + * This is only used with iommufd and cdev-based interfaces and
> > does not
> > + * apply to the VFIO group-container based noiommu mode.
> > + */
> > +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> > +	IOMMU_PT_DOMAIN_OPS(amdv1),
> > +	.free = noiommu_domain_free,
> > +};
> > +
> > +const struct iommu_ops iommufd_noiommu_ops = {
> > +	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
> > +};
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h
> > b/drivers/iommu/iommufd/iommufd_private.h index
> > 6ac1965199e9..2682b5baa6e9 100644 ---
> > a/drivers/iommu/iommufd/iommufd_private.h +++
> > b/drivers/iommu/iommufd/iommufd_private.h @@ -464,6 +464,8 @@
> > static inline void iommufd_hw_pagetable_put(struct iommufd_ctx
> > *ictx, refcount_dec(&hwpt->obj.users); }
> >   
> > +extern const struct iommu_ops iommufd_noiommu_ops;
> > +
> >   struct iommufd_attach;
> >   
> >   struct iommufd_group {  

