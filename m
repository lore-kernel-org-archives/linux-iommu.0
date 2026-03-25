Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B46330B2D
	for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473805; cv=none; b=ui3YwR1xEu+LGArIpXxx5Rjzxjif3Zn7niFVk3OZQ1ZDadJnDCiIx2OKGPVd2DEv4Edi/e+dO8aATUXRHFuuUtrHxB5l0GNUkhG1ebJvs4rv6TT3PZq0eMi71oyW/RVIL8iYxNeV9ASnMSL3E8Vg56FlURUrWLA0qax4Y761QFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473805; c=relaxed/simple;
	bh=xonbs3FxEAukhIqtIxD52TSJ8OC6RqHwbD83ZCiBA/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kit43w6vAYg86ezl063slk/Iw6Xis44Hni6LpXC9FkNbq8512MmdFHsXZQvKykBZyuC0RRFikcmiuHwKAXugWvu/9TTaVLMaGuyxzz2+ZmExYIGFLEBXo3InEBhZP146I+KFqxBaDd2Jw4bvKjs2LYbLKGphh5lRX2gvvmC4Wok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wgi6xhRs; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wgi6xhRs"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b0b260d309so11975ad.1
        for <iommu@lists.linux.dev>; Wed, 25 Mar 2026 14:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774473802; x=1775078602; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EVG0u1tNMBgT8gCqMtRqwY74fPi9b/gLjEZ2D+Du3es=;
        b=Wgi6xhRswAkVR/706oW1dl1Mhyte/eb0D/bew5SjYF7sDkBjjbCE0tivwGHSSxH5Kq
         iDMOhDrMMihZ8FX3iM0D+aTBL67Heg9iUuQc4VN/mh3O9AJaYbp5JaYRkqp1sYIdSbUW
         L39qzkW9sM9YP8NUQUA1GMzl5vlMJffzE6ZRfuKOk3PpUXRVuf1ibkg1ewHTmpDPyz6h
         rIxZNLlnGyWoaz3B9sn9tXi77HPzuc8BHD0FaYAYQDOe8vyJBhu7Dkhw0n8PW26kkHvR
         V/8bDJBRiO6YhEtw8JLw042UXH94rAK6Hc1k2PCVRAmbxKhrCg6cUVQatDYfQ8h1Ug+h
         jAkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774473802; x=1775078602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EVG0u1tNMBgT8gCqMtRqwY74fPi9b/gLjEZ2D+Du3es=;
        b=n92HF41bgInJPIgaN8rKBa1PMJGdpvHr33nJpcI7tdP1oK8IWOqVC/0wHrBQD5ReRP
         L6fmm6gflOcbo6FMvRa0bsMlgtPN/TN6mlXUjfxoXO7wCKJ1TdI1FWgfGeXFC4C0fe92
         DFPNQsuWFOV6J8dSkHDaCucB+CpzGF5Paw7ZpJV/A6P6yekg8H3dxlxNj/CRKYJMY9M9
         0GTF1thneFpmC1KVus+6YuFNOSQtfU3LUFWTa0G2GWGdQcxESBK9QrIQFGwVZ0ggLDc7
         /fhgzNhV3kaEOablvfQjDZpeOcnSlwI+jnHmA8x7Le0w5IG1T6ptwGjyd4UvDdqpC1Yz
         fALw==
X-Forwarded-Encrypted: i=1; AJvYcCUkS385p0nssPMqA91RtREDrENSOZCle6yBjoFYiZVMO7wpCuLu2bOx5MmwftrnhS32lJbBeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YztFcRcvSA5pVPTcjndbkVvmk+Iap509WWyatINc1lmpBmxsLBS
	nJo6QaoLGL9zW1HqVK3joz0HSPqwCjtgqs/2/daXjltpy7Ep87bqccbQqHlDNVlXpw==
X-Gm-Gg: ATEYQzyq8yovOoLh1+BMQSqNB3lvZsniM/JSN8XePTFauP6i8vxKMSB++CPqR2JDW+4
	vS2aDdJPlixnpFWPgkPz8r8EaJAH5P8tmhA5Ke3MC21Tzoh6sKn4XCAbsdEfv0XrG2SOUxjn0Qm
	hjoWkl/Ufm53+Aj/do/xVNeev8Xoy1/nFxWzYB5Dk1zl+YFOCpyuAnpO7RdqL8Ig7UJzLD+xLZX
	JyW2Ylx3NSBzeElBZ3eZVyideHTp3Q24srk1hc2+lqff3Nccbc4QG3njn3wvLbOpL3xB3yfCyGu
	to+5xDu3RDQjcvKF6xcid+tbO/z0qNkkQkbKpwh0rwklKAjt6bt5Ln3/DzMeXI9xNXq2A9Dm83C
	iP06j3Q9UaL/56yKe8iJRq3+KZrXqgM88h3VJnEKE0qSW1rdzI5ZPIlyL7xcEmUyGNUzrI3ZcCt
	+Dk3G4F6bUM3W+Fu2TabY/KupbxpclsYPhKRgT4XWLLNsqtjqG+p14wk0ksg==
X-Received: by 2002:a17:902:c947:b0:2b0:5193:1212 with SMTP id d9443c01a7336-2b0bf755ef9mr236845ad.4.1774473801622;
        Wed, 25 Mar 2026 14:23:21 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76f1ccsm8429245ad.12.2026.03.25.14.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 14:23:21 -0700 (PDT)
Date: Wed, 25 Mar 2026 21:23:13 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 12/14] iommufd: Add APIs to preserve/unpreserve a vfio
 cdev
Message-ID: <acRSQQt_V29S1Ufh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-13-skhawaja@google.com>
 <acREeKQJlSrd2kZS@google.com>
 <acRG3Vi3OGNsVgNR@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acRG3Vi3OGNsVgNR@google.com>

On Wed, Mar 25, 2026 at 08:41:46PM +0000, Samiullah Khawaja wrote:
> On Wed, Mar 25, 2026 at 08:24:24PM +0000, Pranjal Shrivastava wrote:
> > On Tue, Feb 03, 2026 at 10:09:46PM +0000, Samiullah Khawaja wrote:
> > > Add APIs that can be used to preserve and unpreserve a vfio cdev. Use
> > > the APIs exported by the IOMMU core to preserve/unpreserve device. Pass
> > > the LUO preservation token of the attached iommufd into IOMMU preserve
> > > device API. This establishes the ownership of the device with the
> > > preserved iommufd.
> > > 
> > > Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> > > ---
> > >  drivers/iommu/iommufd/device.c | 69 ++++++++++++++++++++++++++++++++++
> > >  include/linux/iommufd.h        | 23 ++++++++++++
> > >  2 files changed, 92 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
> > > index 4c842368289f..30cb5218093b 100644
> > > --- a/drivers/iommu/iommufd/device.c
> > > +++ b/drivers/iommu/iommufd/device.c
> > > @@ -2,6 +2,7 @@
> > >  /* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> > >   */
> > >  #include <linux/iommu.h>
> > > +#include <linux/iommu-lu.h>
> > >  #include <linux/iommufd.h>
> > >  #include <linux/pci-ats.h>
> > >  #include <linux/slab.h>
> > > @@ -1661,3 +1662,71 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > >  	iommufd_put_object(ucmd->ictx, &idev->obj);
> > >  	return rc;
> > >  }
> > > +
> > > +#ifdef CONFIG_IOMMU_LIVEUPDATE
> > > +int iommufd_device_preserve(struct liveupdate_session *s,
> > > +			    struct iommufd_device *idev,
> > > +			    u64 *tokenp)
> > > +{
> > > +	struct iommufd_group *igroup = idev->igroup;
> > > +	struct iommufd_hwpt_paging *hwpt_paging;
> > > +	struct iommufd_hw_pagetable *hwpt;
> > > +	struct iommufd_attach *attach;
> > > +	int ret;
> > > +
> > > +	mutex_lock(&igroup->lock);
> > > +	attach = xa_load(&igroup->pasid_attach, IOMMU_NO_PASID);
> > 
> > By explicitly looking up IOMMU_NO_PASID, we skip any PASID attachments
> > the device might have. Since PASID live update is NOT supported in this
> > series, should we check if the pasid_attach xarray contains anything
> > other than IOMMU_NO_PASID and return -EOPNOTSUPP?
> > 
> > Otherwise, we silently fail to preserve those domains without informing
> > the VMM?
> 
> VMM should be able to preserve the NO_PASID domains even if it has PASID
> attachments. This is the intended behaviour, I will document it in the
> uAPI docs.

I think I'm miscommunicating here. My concern isn't about whether the
kernel can mechanically preserve the NO_PASID domain when PASID 
attachments exist. I agree that part works fine.

My concern is purely about silent state loss. If a VMM asks the kernel
to preserve a device, it expects the entire IOMMU state for that device
to be safely handed over. If the kernel silently skips the PASID
attachments and returns success (0), the VMM on the new kernel will wake
up assuming those PASIDs are still perfectly intact. When the guest 
attempts a PASID-tagged DMA, it will unexpectedly fault.

So the question is: how strictly should the kernel protect userspace
from this footgun? A few options that I can see:

1. Rely on uAPI docs
2. Fail the preserve ioctl (-EOPNOTSUPP) if active PASID attachments
   are detected.
3. Add an opt-in flag: We could add a flag to the ioctl 
   (IOMMU_LU_FLAG_IGNORE_PASID) so userspace has to explicitly
   acknowledge the state drop?

Options 2 or 3 are especially important when we consider backwards 
compatibility. If this series is merged in 7.2  with the "silent drop"
behavior now, when full PASID live update support is eventually added
in a future kernel, userspace will have no robust way to know if it's
running on a kernel that preserves PASIDs or silently drops them. By 
returning an error or requiring a flag now, we reserve the right to 
cleanly implement the feature later without breaking the UAPI contract.

This is an open question from me, I'm okay with any of the 3 options
I'd like to know what the maintainers think about this as well.

[ ---- >8 ----- ]

Thanks,
Praan
