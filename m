Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE4A384242
	for <iommu@lists.linux.dev>; Mon,  4 May 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777933848; cv=none; b=CZ7RJ2TB8w5lK7gxZv4kTLuD7azw4kxlO/E5iSDROuWMq2d7IwqMepHm08zx3rb5ZsfaVUAxV9IFHrn8hwHTLwHotVdpNk2iNlKq7Mg3MwqX0pd+OSQwY0OcnblCLARxrNUyhJK0s7V+PRG7JfB8WiyBjXciWdLyVIqEBztra3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777933848; c=relaxed/simple;
	bh=iTEH4/bIbWgj0dD12axDwY4NOQLXpbgd7H+7YJE4I2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kENgeMgeOcVw6LwUda5ThsidxmnQDMbks8rx3echjwbBDNWffo6T9fbBLlqGWIB1WXjWO2s85+Z4lihgyHvQje8C5fu68ln/k2ciLYa/rvb1kyYRGcv86H1dgsz26cyckNvQeS5HF86g+3bavKMYIt1beU8hqdIo37Pg44C6PE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=iXRLAPk+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iXRLAPk+"
Received: from localhost (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id EAB8C20B7168;
	Mon,  4 May 2026 15:30:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EAB8C20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777933844;
	bh=aumVJhnnw7f6D11ANWDqLyHAWL7KmziYyYAmS/LdGso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iXRLAPk+ayDgPnV2llzXiRsb0G3ZB5Ac7XSL2J04ywqAH+e+9WuqXotJA9Rj+0o8E
	 FAwp8hrbPd/kgt4r5OtvHjpKwFUSKFOX0TqhbGK5WVBrSnNTZPLykZoX+Td+Aui7uW
	 wHX3yoZC8rltNzzd1TANOMif1mFlayBW1ESx8o6k=
Date: Mon, 4 May 2026 15:30:43 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Alex Williamson <alex@shazbot.org>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V4 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Message-ID: <20260504153043.000055cc@linux.microsoft.com>
In-Reply-To: <20260416133257.4d2e8818@shazbot.org>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-5-jacob.pan@linux.microsoft.com>
	<20260416133257.4d2e8818@shazbot.org>
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

Hi Alex,

On Thu, 16 Apr 2026 13:32:57 -0600
Alex Williamson <alex@shazbot.org> wrote:

> From: Alex Williamson <alex@shazbot.org>
> To: Jacob Pan <jacob.pan@linux.microsoft.com>
> Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
> <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg
> Roedel  <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David
> Matlack  <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
> Nicolin Chen  <nicolinc@nvidia.com>, "Tian, Kevin"
> <kevin.tian@intel.com>, Yi Liu  <yi.l.liu@intel.com>,
> skhawaja@google.com, pasha.tatashin@soleen.com, Will  Deacon
> <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
> alex@shazbot.org Subject: Re: [PATCH V4 04/10] iommufd: Add an ioctl
> IOMMU_IOAS_GET_PA to  query PA from IOVA Date: Thu, 16 Apr 2026
> 13:32:57 -0600 X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51;
> x86_64-pc-linux-gnu)
> 
> On Tue, 14 Apr 2026 14:14:06 -0700
> Jacob Pan <jacob.pan@linux.microsoft.com> wrote:
> 
> > To support no-IOMMU mode where userspace drivers perform unsafe DMA
> > using physical addresses, introduce a new API to retrieve the
> > physical address of a user-allocated DMA buffer that has been
> > mapped to an IOVA via IOAS. The mapping is backed by mock I/O page
> > tables maintained by generic IOMMUPT framework.
> > 
> > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> > v4:
> >    - Fix unaligned IOVA length (Sashiko)
> > v2:
> >    - Scan the contiguous physical-address span beyond the first
> > page and return its length. ---
> >  drivers/iommu/iommufd/io_pagetable.c    | 60
> > +++++++++++++++++++++++++ drivers/iommu/iommufd/ioas.c            |
> > 25 +++++++++++ drivers/iommu/iommufd/iommufd_private.h |  3 ++
> >  drivers/iommu/iommufd/main.c            |  3 ++
> >  include/uapi/linux/iommufd.h            | 25 +++++++++++
> >  5 files changed, 116 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/io_pagetable.c
> > b/drivers/iommu/iommufd/io_pagetable.c index
> > ee003bb2f647..04336a8e12f5 100644 ---
> > a/drivers/iommu/iommufd/io_pagetable.c +++
> > b/drivers/iommu/iommufd/io_pagetable.c @@ -849,6 +849,66 @@ int
> > iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
> > return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped); }
> >  
> > +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
> > u64 *paddr,
> > +		  u64 *length)
> > +{
> > +	struct iopt_area *area;
> > +	u64 tmp_length = 0;
> > +	u64 tmp_paddr = 0;
> > +	int rc = 0;
> > +
> > +	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
> > +		return -EOPNOTSUPP;
> > +
> > +	down_read(&iopt->iova_rwsem);
> > +	area = iopt_area_iter_first(iopt, iova, iova);
> > +	if (!area || !area->pages) {
> > +		rc = -ENOENT;
> > +		goto unlock_exit;
> > +	}
> > +
> > +	if (!area->storage_domain ||
> > +	    area->storage_domain->owner != &iommufd_noiommu_ops) {
> > +		rc = -EOPNOTSUPP;
> > +		goto unlock_exit;
> > +	}
> > +
> > +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> > +	if (!*paddr) {
> > +		rc = -EINVAL;
> > +		goto unlock_exit;
> > +	}
> > +
> > +	tmp_length = PAGE_SIZE - offset_in_page(iova);
> > +	tmp_paddr = *paddr;
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
> > iommu_iova_to_phys(area->storage_domain, next_iova); +
> > +		if (!next_paddr || next_paddr != tmp_paddr +
> > PAGE_SIZE)
> > +			break;
> > +
> > +		iova = next_iova;
> > +		tmp_paddr += PAGE_SIZE;
> > +		tmp_length += PAGE_SIZE;
> > +	}
> > +	*length = tmp_length;  
> 
> If next_iova exceeds iopt_area_last_iova(area) AND exists in
> storage_domain AND happens to be physically contiguous, tmp_length is
> advanced and the return length exceeds the mapping.  Otherwise this
> also always does an iommu_iova_to_phys() one iteration beyond the area
> last iova.  Thanks,
> 
you are right, let me add a check.
@@ -892,6 +892,9 @@ int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
                if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
                        break;
 
+               if (next_iova > iopt_area_last_iova(area))
+                       break;
+
                next_paddr = iommu_iova_to_phys(area->storage_domain,
                next_iova);

