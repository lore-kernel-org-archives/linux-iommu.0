Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3D632720D
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394562; cv=none; b=fXJ9+EWjlviYrXBR2/GrTV/LpDiMVQ1lxIryGfwoTgXA0a6jdJP4yROYVslbSRcs5moXMuHigDR4accF6k0v2fQNMo+MjHetvXkHM1lq/ZbFYyJoAGXoaZ/MrJVTsZb3TGBnM8NApmFn6tLcAIMtifmnNbG4bWQn/3fxL8H/DTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394562; c=relaxed/simple;
	bh=+ZZQJ3OhnE8xEpJ2zHeeU7+maq0rU0IOgdEzQL4Zgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqAVReXalWvdhH2a5khyloC2eW1kSEDvaWH2gvKs4qt8oKF5hb7KcLZ6zr79aGeFmF4eiLhlqFhaljA7O9C2Ucbaeoj60Afkgzpp6opO71K85Yr/G8CGWV+wMCBLpOqWigqX+4gQVVWFGsfAHfQh39M15ciV4KuuybTdg8/VjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wz4eDih1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wz4eDih1"
Received: from localhost (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8ABBF20B716C;
	Tue, 28 Apr 2026 09:42:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8ABBF20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777394560;
	bh=YJX3Ai2pY5QUCNPlc/L83dnSa7VXWkJLG2StHc/PDKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wz4eDih1diRoqK0NG/YOYG2sTlQumjgA4PsxxjZQZcO17/LcuScimULO7oCkWh4BG
	 uP7OrJw5ghov6iKl2pLP/9ug2J99WO4kJRH3m7Ojc6w35ffo83TlZES0r4UndHLXVi
	 JYl1DJlD4tYfWvtF3dq4gW2jiziRV8CdfGm1xdVY=
Date: Tue, 28 Apr 2026 09:42:38 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, <skhawaja@google.com>, <pasha.tatashin@soleen.com>,
 Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu
 driver for noiommu
Message-ID: <20260428094238.0000222b@linux.microsoft.com>
In-Reply-To: <b0bf1e99-d7d0-4e62-8a97-114e8e990b58@intel.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-2-jacob.pan@linux.microsoft.com>
	<b0bf1e99-d7d0-4e62-8a97-114e8e990b58@intel.com>
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

On Tue, 28 Apr 2026 15:45:08 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Hi Jacob,
> 
> On 4/15/26 05:14, Jacob Pan wrote:
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
> > 
> > ---
> > v4:
> >     - Make iommufd_noiommu_ops const
> > v3:
> >     - Add comment to explain the design difference over the
> >       legacy noiommu VFIO code.
> > 
> > fix const hwpt
> > ---
> >   drivers/iommu/iommufd/Makefile          |   1 +
> >   drivers/iommu/iommufd/hw_pagetable.c    |  11 ++-
> >   drivers/iommu/iommufd/hwpt_noiommu.c    | 102
> > ++++++++++++++++++++++++ drivers/iommu/iommufd/iommufd_private.h |
> >  2 + 4 files changed, 114 insertions(+), 2 deletions(-)
> >   create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> > 
> > diff --git a/drivers/iommu/iommufd/Makefile
> > b/drivers/iommu/iommufd/Makefile index 71d692c9a8f4..2b1a020b14a6
> > 100644 --- a/drivers/iommu/iommufd/Makefile
> > +++ b/drivers/iommu/iommufd/Makefile
> > @@ -10,6 +10,7 @@ iommufd-y := \
> >   	vfio_compat.o \
> >   	viommu.o
> >   
> > +iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o  
> 
> is it better to have a separate kconfig for it? Also, VFIO_NOIOMMU
> depends on VFIO_GROUP, this does not sound good. For one, cdev's
> noiommu support should not depend on groups. For two, this means the
> iommufd noiommu support is only for VFIO. It closes the gate for other
> userpsace drivers. Perhaps a IOMMUFD_NOIOMMU kconfig for it.
> 
> 
> VFIO_GROUP | VFIO_DEVICE_CDEV | IOMMUFD_NOIOMMU | VFIO_NOIOMMU
> allowed?
> -----------+------------------+-----------------+----------------------
> Y     |        Y         |        Y        | Y (both paths work) Y
>  |        Y         |        N        | N (cdev path lacks
> IOMMUFD_NOIOMMU) Y     |        N         |        Y        | Y
> (group path only, cdev irrelevant)
>       Y     |        N         |        N        | Y (group path
> only, cdev irrelevant)
>       N     |        Y         |        Y        | Y (cdev path only)
>       N     |        Y         |        N        | N (cdev path lacks 
> IOMMUFD_NOIOMMU)
>       N     |        N         |       any       | N (no VFIO
> interface at all)
> 
> Then VFIO_NOIOMMU Kconfig dependency is:
> 
>      depends on VFIO_GROUP || VFIO_DEVICE_CDEV
>      depends on !VFIO_DEVICE_CDEV || IOMMUFD_NOIOMMU
> 
yes, separating the two Kconfigs is cleaner. Alex also suggested
similar to this in another thread, just different names.
https://lore.kernel.org/linux-iommu/20260414211412.2729-1-jacob.pan@linux.microsoft.com/T/#m1a687fd4c9a9d24b6413d7a6d5cd09ba3f7ddb5e

- VFIO_GROUP_NOIOMMU
- VFIO_CDEV_NOIOMMU // IOMMUFD_NOIOMMU sounds more generic, and
  VFIO_DEVICE_CDEV already depends on IOMMUFD.

I am working on covering all the cases above and looks promising.
Thanks for the matrix, I will put this in the doc patch.

> >   iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
> >   
> >   obj-$(CONFIG_IOMMUFD) += iommufd.o
> > diff --git a/drivers/iommu/iommufd/hw_pagetable.c
> > b/drivers/iommu/iommufd/hw_pagetable.c index
> > fe789c2dc0c9..37316d77277d 100644 ---
> > a/drivers/iommu/iommufd/hw_pagetable.c +++
> > b/drivers/iommu/iommufd/hw_pagetable.c @@ -8,6 +8,13 @@
> >   #include "../iommu-priv.h"
> >   #include "iommufd_private.h"
> >   
> > +static const struct iommu_ops *get_iommu_ops(struct iommufd_device
> > *idev) +{
> > +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> > !idev->igroup->group)
> > +		return &iommufd_noiommu_ops;
> > +	return dev_iommu_ops(idev->dev);
> > +}
> > +
> >   static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable
> > *hwpt) {
> >   	if (hwpt->domain)
> > @@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_ioas *ioas, IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> >   				IOMMU_HWPT_FAULT_ID_VALID |
> >   				IOMMU_HWPT_ALLOC_PASID;
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >   	struct iommufd_hwpt_paging *hwpt_paging;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> > @@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx
> > *ictx, struct iommufd_device *idev, u32 flags,
> >   			  const struct iommu_user_data *user_data)
> >   {
> > -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> > +	const struct iommu_ops *ops = get_iommu_ops(idev);
> >   	struct iommufd_hwpt_nested *hwpt_nested;
> >   	struct iommufd_hw_pagetable *hwpt;
> >   	int rc;
> > diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c
> > b/drivers/iommu/iommufd/hwpt_noiommu.c new file mode 100644
> > index 000000000000..1c8cae02beec
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> > + */
> > +#include <linux/iommu.h>
> > +#include <linux/generic_pt/iommu.h>  
> 
> how about moving it to the first one? :)
will do.

> 
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
> 
> "mock" may mislead reader that this is test code... may just explain
> why choose AMDV1 page table.
I will quote Jason's comment "because it has the best multi-page size
options of all the formats.". I also want to stress that this page
table is not used by HW for DMA translation, maybe "SW only".

Let me delete this comment and explain this later in the domain ops
comment.

> 
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
> > + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar
> > to the
> > + * iommufd selftest mock page table.
> > + * Unlike legacy VFIO no-IOMMU mode, where no container level APIs
> > are
> > + * supported, this allows IOAS and hwpt objects to exist without
> > hardware
> > + * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not
> > for
> > + * hardware translation in DMA.  
> 
> Not sure if the above comment is helpful. To me, IOAS/hwpt operation
> support is the natural advantage of using cdev. What helps here is
> explaining why the specific ops are defined for noiommu_amdv1_ops. If
> you'd keep it, may go in the commit message. :)
Agreed, I kind of mixing two things here. I will move the high-level
"why noiommu needs a page table" explanation to the commit message.
Only keep the domain op explanation:
 /*
  * Domain ops for iommufd no-IOMMU mode. Uses AMDV1 format as a
  * SW-only IOPT because it has the best multi-page size options
  * of all the formats. IOVAs serve only for IOVA-to-PA lookups,
  * not for hardware DMA translation.
  */

> 
> Regards,
> Yi Liu
> 
> > + *
> > + * This is only used with iommufd and cdev-based interfaces and
> > does not
> > + * apply to legacy VFIO group-container based noiommu mode.
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

