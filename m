Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452DE346FAD
	for <iommu@lists.linux.dev>; Fri, 17 Apr 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776463190; cv=none; b=Ry5BGu3viUQ5h77qWmq2uO4IxE7NF9gFodC/q5mhrk+2vcv/nRCFuBiarL+Pzr54VIawjESQOy0rPQ4FNASBbxZTBGnZNfP53KWkOZoJFkaSQjXPPYLXihvXmd8jOrbCrmqA09/Tm03ZnDZlmb7BuQcGsP4QgFQf+G38N6S1eE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776463190; c=relaxed/simple;
	bh=meMnL75Iy88kX6Y9sVRawIMsE+vP6Zz8OoJc4QValjM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kRtJDmN0Tni9drC2XL8XCSNJz2rRizpuhtBXMtzsrRMOP79NV25fnRCirzO4FG3NBw00579bnIAWTDPYP3SPuSwV2mQPeoWRbQ4v751W3FGyE8SODdFN53BKF75GGNDxQ3Kc7hlyf3PJUQDW3sRD6wRqoEHFTJCSLHNeiFIY8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R7/7IIA/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R7/7IIA/"
Received: from localhost (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 05CC020B7128;
	Fri, 17 Apr 2026 14:59:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05CC020B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776463188;
	bh=Zpk1HyTi/fpV41CFrVEfHE7DhI/m4arBudTH53ivA3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7/7IIA/GlEdrfGAFyl9Bp7dcUCoQxyvM++/62bawtzYIqyIRpsdJktIUztZ3coCe
	 eKfvsGj8sI7mqVQXj7rI5rFOZOOPnyDHmMlrzkKhhj9welMstlZsgYQUMUdb3riSnb
	 gfJ45VvNM7oDtSnt3b2kj8VNGHa8Y9Qr1T2YNvnE=
Date: Fri, 17 Apr 2026 14:59:46 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jason Gunthorpe
 <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
 <baolu.lu@linux.intel.com>
Subject: Re: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu
 driver for noiommu
Message-ID: <20260417145946.00004418@linux.microsoft.com>
In-Reply-To: <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-2-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
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

Hi Kevin,

On Thu, 16 Apr 2026 07:25:57 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, April 15, 2026 5:14 AM
> > 
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> > + */  
> 
> the years are not latest...
will fix.

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
> 
> PT_FEAT_AMDV1_ENCRYPT_TABLES is useless here.
Technically yes but we need this flag to match forced features since we
are sharing with the real AMDv1. Otherwise, this will fail with
EOPNOTSUPP.
static int pt_init_common(struct pt_common *common)
{
...
	/* Requested features must match features compiled into this
format */
	if ((common->features & ~(unsigned int)PT_SUPPORTED_FEATURES) ||
	    (!IS_ENABLED(CONFIG_DEBUG_GENERIC_PT) &&
	     (common->features & PT_FORCE_ENABLED_FEATURES) !=
		     PT_FORCE_ENABLED_FEATURES))
		return -EOPNOTSUPP; 

where in iommu_amdv1.c:
#define PT_FORCE_ENABLED_FEATURES
\ (BIT(PT_FEAT_DYNAMIC_TOP) | BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) | \
	 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE))

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
> it's confusing between above "legacy VFIO no-IOMMU mode" and following
> "legacy VFIO group-container based noiommu mode".
> 
will make them consistent.

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
> > b/drivers/iommu/iommufd/iommufd_private.h
> > index 6ac1965199e9..2682b5baa6e9 100644
> > --- a/drivers/iommu/iommufd/iommufd_private.h
> > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > @@ -464,6 +464,8 @@ static inline void
> > iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
> >  	refcount_dec(&hwpt->obj.users);
> >  }
> > 
> > +extern const struct iommu_ops iommufd_noiommu_ops;
> > +
> >  struct iommufd_attach;
> > 
> >  struct iommufd_group {
> > --
> > 2.34.1  

