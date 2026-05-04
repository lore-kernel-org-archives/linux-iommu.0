Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1B386552
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 23:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935832; cv=none; b=hd+gLBSwgX5S524iHBauLvhqa5Qb2IBbMHDxIG/x5g++Tx6tVO0+4NQOvEI0Ass938Icp61Pk9W0lBlxydUoRMovm/NTgtAxIyE6t2dRWhH4HQkvx5lj6whdyHx3UvfRwla4VqISZoZSFoYodR239lvion6W9o/Rc131DtRL/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935832; c=relaxed/simple;
	bh=m05fL9UYxJM1/b8PQpSMyHaC+mC4XQCC/Jtp4EHbzJE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HInGYKcFnx1Dwn1qanCMa5g4p64kN9FZhb6yhg79FzbICQQ8L9F+GvHnpTrPNTid4FAUv9+v5qboakucnVyRtsxQ6Mto55V6N1moE0wtOcOBwBWQ4U+G+2C6rb2gor+Tsm+KApz0x3Iy9FB2+3C4uVG9/WWnvEKERTn+e78kyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XjCFM2QA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XjCFM2QA"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9FAFC20B7168;
	Mon,  4 May 2026 16:03:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9FAFC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777935825;
	bh=nFfO7p8Yrvf0qmPgM+WArFN3fOa7eD8E93M4IoBnvDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XjCFM2QAkOYp3kltRnpnxKVdQSXLBVBAhIR5+MCp7hw0cuf8tG5zBAnNZ55cpW6Ys
	 jzPGB3oMyG58lZWHCND1b9dUcKoudYWue8sQMbgkjlHTczgzsZI0CA0DQiEgasOY2i
	 tvCYESv5rMg16gcX/votcdLldSx2RrP6BFhwYF7Q=
Date: Mon, 4 May 2026 16:03:45 -0700
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
 <baolu.lu@linux.intel.com>, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Message-ID: <20260504160345.00002589@linux.microsoft.com>
In-Reply-To: <BL1PR11MB52714A18A767F7C5C1985DF48C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-5-jacob.pan@linux.microsoft.com>
	<BL1PR11MB52714A18A767F7C5C1985DF48C232@BL1PR11MB5271.namprd11.prod.outlook.com>
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

On Thu, 16 Apr 2026 08:02:33 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Sent: Wednesday, April 15, 2026 5:14 AM
> > 
> > To support no-IOMMU mode where userspace drivers perform unsafe DMA
> > using physical addresses, introduce a new API to retrieve the
> > physical address of a user-allocated DMA buffer that has been
> > mapped to an IOVA via IOAS. The mapping is backed by mock I/O page
> > tables maintained
> > by generic IOMMUPT framework.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>  
> 
> Your s-o-b should be the last 
will do.

> 
> > +	/*
> > +	 * Scan the domain for the contiguous physical address
> > length so that
> > +	 * userspace search can be optimized for fewer ioctls.
> > +	 */
> > +	while (iova < iopt_area_last_iova(area)) {
> > +		unsigned long next_iova;
> > +		u64 next_paddr;
> > +
> > +		if (check_add_overflow(iova, PAGE_SIZE,
> > &next_iova))
> > +			break;
> > +
> > +		next_paddr =
> > iommu_iova_to_phys(area->storage_domain, next_iova);
> > +
> > +		if (!next_paddr || next_paddr != tmp_paddr +
> > PAGE_SIZE)
> > +			break;  
> 
> the 2nd condition should be WARN_ON? 
I don't think it should be a WARN_ON since PA non-contiguity is one of
the normal exit conditions.

> 
> > @@ -432,6 +432,7 @@ union ucmd_buffer {
> >  	struct iommu_veventq_alloc veventq;
> >  	struct iommu_vfio_ioas vfio_ioas;
> >  	struct iommu_viommu_alloc viommu;
> > +	struct iommu_ioas_get_pa get_pa;  
> 
> alphabetic order
> 
will do.

> >  #ifdef CONFIG_IOMMUFD_TEST
> >  	struct iommu_test_cmd test;
> >  #endif
> > @@ -484,6 +485,8 @@ static const struct iommufd_ioctl_op
> > iommufd_ioctl_ops[] = {
> >  		 struct iommu_ioas_map_file, iova),
> >  	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct
> > iommu_ioas_unmap,
> >  		 length),
> > +	IOCTL_OP(IOMMU_IOAS_GET_PA, iommufd_ioas_get_pa, struct
> > iommu_ioas_get_pa,
> > +		 out_phys),  
> 
> ditto
will do

> > 
> > +/**
> > + * struct iommu_ioas_get_pa - ioctl(IOMMU_IOAS_GET_PA)
> > + * @size: sizeof(struct iommu_ioas_get_pa)
> > + * @flags: Reserved, must be 0 for now
> > + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> > + * @__reserved: Must be 0
> > + * @iova: IOVA to query
> > + * @out_length: Number of bytes contiguous physical address
> > starting from phys
> > + * @out_phys: Output physical address the IOVA maps to
> > + *
> > + * Query the physical address backing an IOVA range. The entire
> > range must be
> > + * mapped already. For noiommu devices doing unsafe DMA only.
> > + */
> > +struct iommu_ioas_get_pa {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 ioas_id;
> > +	__u32 __reserved;
> > +	__aligned_u64 iova;
> > +	__aligned_u64 out_length;
> > +	__aligned_u64 out_phys;
> > +};
> > +#define IOMMU_IOAS_GET_PA _IO(IOMMUFD_TYPE,
> > IOMMUFD_CMD_IOAS_GET_PA)
> > +  
> 
> Based on its purpose let's make the restriction in the name, e.g.
> 
> IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA

yeah, make sense. will rename all the function names as well.
