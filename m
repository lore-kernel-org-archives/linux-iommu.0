Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A2631F9A0
	for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774171487; cv=none; b=IrjzEThnHKDqDsAxWmZHLiP6uVSaTMF7FJh3b31EbZutFUP9BUilHL9xTDdQSpxep2arA26H6jP+mf7F1IRYsufPhMbBBxV55kOumOglyW2jwNEV4w4pwRFTqK0kKNuEAFgGJDF0AT15+a7csegj92xubnZk/mgx/TWtwIGOuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774171487; c=relaxed/simple;
	bh=n4C3ynhE7jxIrWpriieMpCCDCiYTKr9NecF5HXEHwPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYThl4wZVytkubxpb6ZkAApVUmbrj4dv32xRqjanFn5f6MWo5QKuJIoDF6sGHQJS/cufUZOswN6HRiCSFbULZytFyJYwmtD+Y4qIWILMNCIAtvfBPRgvQzMg6B8vrxk6csUG0aTFoP7UPaSMnTR6Q9OTTLqy7bDNDWSe+SrDVxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GqGM5itJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GqGM5itJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-485317b6bd0so67035e9.1
        for <iommu@lists.linux.dev>; Sun, 22 Mar 2026 02:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774171483; x=1774776283; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GplwjQbx6bBy+YNbaPGexypRaWChzbTAh68wSARB7Z8=;
        b=GqGM5itJR6ga2AikL1Ei03oLsZuI32BwGwn0rC6pM5J7CihdxkeQVE4FfbBNgpqg72
         kbvohssdzibWbyLgDOBzszxTTc1q+ngUXPRf4joaAqahJDbuG6E3Z0V2mU4Es7BoalGT
         MifJbM3kaSPMaQu/i2PxA5s8d1BtuAKEGzcrYNxLUEmGQo2mbzvLzr9Ml2+qAl2w3qpJ
         9CpJfyxg7rjY8ZZXNJ+mPqGk3mGVi8lCnGKiLWusDuWiUhHUCfw5I+pMv6vy9cy4m0ni
         9cZPqFOLktmJpsSQ026qBaPbfSOwWhDLi4HSlKVNCrDdzRkq1qoLaYVGJi39FfCHjd7j
         0ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774171483; x=1774776283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GplwjQbx6bBy+YNbaPGexypRaWChzbTAh68wSARB7Z8=;
        b=ZvntY8IcBuHICHoPFaCQmbolL2OmySY0a2zi+vqrUC/veHNDCVcI/d4PGe/XY5UAcj
         64CdnXAj8q/7jrPiJVoZDDmwMJFx/LN271cW228Tf4GYTlQwo8Fzf4oKH/4sY6F9BKP6
         m8vcElvT37h0wWroknfu7SVyJ5IqfwFW2x/1i0ybed/ZxdDu4B4RUr852ahrAjnsCosd
         OVvfGTxL1Ww9KxLVcy5l3OgxZ05CUf5F9xPKTq+tQH+FffC+MSjdtVi5hvNENjVi88lz
         9LrMDys6oJF3A3xRePGXwM69Jvez2TGC82t9Qx5AVwesuRwz8eT3E3jrJVTjPRnYiVBy
         49Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW0hAEJkLW8QJ9LUfy4+gwRVPhaDumfu0K9BW3e76RGqqZbdync45AsRTRqK+2zLAWgcWYxmA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yya5hQRYny7PcF6isyWRyy1iyWMwyt3oMfE4pOxntBVqCHbMNUK
	ohA/2OSAggF0vAOO+5mIZrA4S8elFYNzDXwIDX12pfNKD/ikhadslE2oE4s/tbaltg==
X-Gm-Gg: ATEYQzy+Y3uXZoUYCkoJ/8YmtLavvkzNXP4fKAkOPLVdrVlYkDGHRmSe737I0dIbBFn
	ztXwlFpY7eIQ80hEfY3HOj6bXXf22O0SJOJdDSszJP/EZkzRUQkjXBpFcQUmuI3BAWuKYlrW3Sz
	u1XPX6ELfnqfETxtGcgrZom1qHQtYTkuXFEtgfvCPoxyZhLJOuUHa/4eYJ1RFSh1RykgloPy1ml
	c3wpuJgu8x7wN5Quc1Yt+977E+fFDZ9r6CGGztyAdwvIdTm1L+i3cLvW8afdKc26ircoiiRxh50
	ntTbqMT2TAcuOMn+BeNwxQ9r47sz1yTaPkc+9Dn3laAD8AKg23gwZEfRgnEspdVrZBeOP3NO32f
	iJ0/ycJOBnQnEVT8c7Die/LHo85QIeU2Aw7jEDkI+vP0+jeJq65aMlBYOj8NO3jzwXijKPR0aYJ
	EOg+ThEfa7ogFKo6a666cAVSa12O9fw0qZ05Apb10kTvYX1s39UBLRYFgZxR/Gf8GR8V0=
X-Received: by 2002:a05:600c:3f1b:b0:47e:dbb0:fbcd with SMTP id 5b1f17b1804b1-487034670bamr1436975e9.6.1774171482699;
        Sun, 22 Mar 2026 02:24:42 -0700 (PDT)
Received: from google.com (54.95.38.34.bc.googleusercontent.com. [34.38.95.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm20799976f8f.18.2026.03.22.02.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 02:24:41 -0700 (PDT)
Date: Sun, 22 Mar 2026 09:24:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>,
	David Matlack <dmatlack@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
	skhawaja@google.com, pasha.tatashin@soleen.com,
	Will Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V2 01/11] iommufd: Support a HWPT without an iommu driver
 for noiommu
Message-ID: <ab-1VZshPREYYuI8@google.com>
References: <20260312155637.376854-1-jacob.pan@linux.microsoft.com>
 <20260312155637.376854-2-jacob.pan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312155637.376854-2-jacob.pan@linux.microsoft.com>

On Thu, Mar 12, 2026 at 08:56:27AM -0700, Jacob Pan wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
> 
> Create just a little part of a real iommu driver, enough to
> slot in under the dev_iommu_ops() and allow iommufd to call
> domain_alloc_paging_flags() and fail everything else.
> 
> This allows explicitly creating a HWPT under an IOAS.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
>  drivers/iommu/iommufd/Makefile          |  1 +
>  drivers/iommu/iommufd/hw_pagetable.c    | 11 ++-
>  drivers/iommu/iommufd/hwpt_noiommu.c    | 91 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  2 +
>  4 files changed, 103 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/iommu/iommufd/hwpt_noiommu.c
> 
> diff --git a/drivers/iommu/iommufd/Makefile b/drivers/iommu/iommufd/Makefile
> index 71d692c9a8f4..2b1a020b14a6 100644
> --- a/drivers/iommu/iommufd/Makefile
> +++ b/drivers/iommu/iommufd/Makefile
> @@ -10,6 +10,7 @@ iommufd-y := \
>  	vfio_compat.o \
>  	viommu.o
>  
> +iommufd-$(CONFIG_VFIO_NOIOMMU) += hwpt_noiommu.o
>  iommufd-$(CONFIG_IOMMUFD_TEST) += selftest.o
>  
>  obj-$(CONFIG_IOMMUFD) += iommufd.o
> diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
> index fe789c2dc0c9..37316d77277d 100644
> --- a/drivers/iommu/iommufd/hw_pagetable.c
> +++ b/drivers/iommu/iommufd/hw_pagetable.c
> @@ -8,6 +8,13 @@
>  #include "../iommu-priv.h"
>  #include "iommufd_private.h"
>  
> +static const struct iommu_ops *get_iommu_ops(struct iommufd_device *idev)
> +{
> +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU) && !idev->igroup->group)
> +		return &iommufd_noiommu_ops;
> +	return dev_iommu_ops(idev->dev);
> +}
> +
>  static void __iommufd_hwpt_destroy(struct iommufd_hw_pagetable *hwpt)
>  {
>  	if (hwpt->domain)
> @@ -114,7 +121,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
>  				IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>  				IOMMU_HWPT_FAULT_ID_VALID |
>  				IOMMU_HWPT_ALLOC_PASID;
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>  	struct iommufd_hwpt_paging *hwpt_paging;
>  	struct iommufd_hw_pagetable *hwpt;
>  	int rc;
> @@ -229,7 +236,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
>  			  struct iommufd_device *idev, u32 flags,
>  			  const struct iommu_user_data *user_data)
>  {
> -	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	const struct iommu_ops *ops = get_iommu_ops(idev);
>  	struct iommufd_hwpt_nested *hwpt_nested;
>  	struct iommufd_hw_pagetable *hwpt;
>  	int rc;
> diff --git a/drivers/iommu/iommufd/hwpt_noiommu.c b/drivers/iommu/iommufd/hwpt_noiommu.c
> new file mode 100644
> index 000000000000..0aa99f581ca3
> --- /dev/null
> +++ b/drivers/iommu/iommufd/hwpt_noiommu.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */
> +#include <linux/iommu.h>
> +#include <linux/generic_pt/iommu.h>
> +#include "iommufd_private.h"
> +
> +static const struct iommu_domain_ops noiommu_amdv1_ops;
> +
> +struct noiommu_domain {
> +	union {
> +		struct iommu_domain domain;
> +		struct pt_iommu_amdv1 amdv1;
> +	};
> +	spinlock_t lock;
> +};
> +PT_IOMMU_CHECK_DOMAIN(struct noiommu_domain, amdv1.iommu, domain);
> +
> +static void noiommu_change_top(struct pt_iommu *iommu_table,
> +			       phys_addr_t top_paddr, unsigned int top_level)
> +{
> +}
> +
> +static spinlock_t *noiommu_get_top_lock(struct pt_iommu *iommupt)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommupt, struct noiommu_domain, amdv1.iommu);
> +
> +	return &domain->lock;
> +}
> +
> +static const struct pt_iommu_driver_ops noiommu_driver_ops = {
> +	.get_top_lock = noiommu_get_top_lock,
> +	.change_top = noiommu_change_top,
> +};
> +
> +static struct iommu_domain *
> +noiommu_alloc_paging_flags(struct device *dev, u32 flags,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct pt_iommu_amdv1_cfg cfg = {};
> +	struct noiommu_domain *dom;
> +	int rc;
> +
> +	if (flags || user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cfg.common.hw_max_vasz_lg2 = 64;
> +	cfg.common.hw_max_oasz_lg2 = 52;
> +	cfg.starting_level = 2;
> +	cfg.common.features =
> +		(BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));
> +
> +	dom = kzalloc(sizeof(*dom), GFP_KERNEL);
> +	if (!dom)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock_init(&dom->lock);
> +	dom->amdv1.iommu.nid = NUMA_NO_NODE;
> +	dom->amdv1.iommu.driver_ops = &noiommu_driver_ops;
> +	dom->domain.ops = &noiommu_amdv1_ops;
> +
> +	/* Use mock page table which is based on AMDV1 */
> +	rc = pt_iommu_amdv1_init(&dom->amdv1, &cfg, GFP_KERNEL);
> +	if (rc) {
> +		kfree(dom);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return &dom->domain;
> +}
> +
> +static void noiommu_domain_free(struct iommu_domain *iommu_domain)
> +{
> +	struct noiommu_domain *domain =
> +		container_of(iommu_domain, struct noiommu_domain, domain);
> +
> +	pt_iommu_deinit(&domain->amdv1.iommu);
> +	kfree(domain);
> +}
> +
> +static const struct iommu_domain_ops noiommu_amdv1_ops = {
> +	IOMMU_PT_DOMAIN_OPS(amdv1),

I see the appeal of re-using an existing page table implementation to
keep track of iovas which -as far as I understand- are used as tokens
for DMA pinned pages later, but maybe at least add some paragraph about
that, as it is not immediately clear and that's a different design
from the legacy noiommu VFIO code.

Thanks,
Mostafa

> +	.free = noiommu_domain_free,
> +};
> +
> +struct iommu_ops iommufd_noiommu_ops = {
> +	.domain_alloc_paging_flags = noiommu_alloc_paging_flags,
> +};
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..9c18c5eb1899 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
>  	refcount_dec(&hwpt->obj.users);
>  }
>  
> +extern struct iommu_ops iommufd_noiommu_ops;
> +
>  struct iommufd_attach;
>  
>  struct iommufd_group {
> -- 
> 2.34.1
> 
