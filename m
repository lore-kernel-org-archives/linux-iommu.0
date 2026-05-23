Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60DB16132A
	for <iommu@lists.linux.dev>; Sat, 23 May 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779574158; cv=none; b=qhYfhSE9V7xiWtYTfgYfeX00tYDtnlMXg36zKXHQ8O4Hb+KZihIBs3et7s5lrxQSrjkpv0p+HEoDDmwt1CJxnBfPIQ6aeOC/DrKVqdLsr8ZOMY/dGh+Nl+gYjKx+8YtvpwnNOxhcbrpFocU/xUetLxpkr23ol+J3q1UqISMc4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779574158; c=relaxed/simple;
	bh=Wt9emsJ89jwC4+waPPLNBt5iuJdoHQJrSWr1Nv+sG4U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g94CG2s626JdyknQYFmQr46mml+Y/P5c+IYChDqYVUjIysO1DGVO//vzvDg+mACr1WADKBxpiRuc8y8S8wRFX8zYYHsYqULJO4qxmjmI8XEGWpLK5xB7518xa7INilLpX22s80JJ7m5uN5aX5wynn6iFvHI+yHBkjtCh+IfA2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KD7zcbYb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KD7zcbYb"
Received: from localhost (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD71720B7167;
	Sat, 23 May 2026 15:09:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD71720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779574146;
	bh=PNr4QOlLXlMdnMEJkIWjBa7O9cL11tyMLo5ED3sSrYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KD7zcbYbJUoglWG0/183yWH9S3TtdPVrHsRaubDSv+hKjBnp93CL5PRh1h21kgxl+
	 2QzFqrVlkr5M2MaEm4Zxqu0h4Xx9/HmnqgG8clJxkrKVDvhaMaWftTL2ljeFlGsNub
	 OpQH8s/lptVztqaSe83c8EFCBTJ9VSPy1e6HsZNY=
Date: Sat, 23 May 2026 15:09:12 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
 <alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
 <smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>, <skhawaja@google.com>,
 <pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v6 4/7] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
Message-ID: <20260523150912.00002e02@linux.microsoft.com>
In-Reply-To: <dec4651f-ad7b-4a9c-8c25-2b68f8a85088@intel.com>
References: <20260521221155.1375144-1-jacob.pan@linux.microsoft.com>
	<20260521221155.1375144-5-jacob.pan@linux.microsoft.com>
	<dec4651f-ad7b-4a9c-8c25-2b68f8a85088@intel.com>
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

On Fri, 22 May 2026 17:22:51 +0800
Yi Liu <yi.l.liu@intel.com> wrote:

> On 5/22/26 06:11, Jacob Pan wrote:
> > To support no-IOMMU mode where userspace drivers perform unsafe DMA
> > using physical addresses, introduce a new API to retrieve the
> > physical address of a user-allocated DMA buffer that has been
> > mapped to an IOVA via IOAS. The mapping is backed by SW-only I/O
> > page tables  
> 
> nit: /via IOAS/via IOMMU_IOAS_MAP/
> 
> > maintained by the generic IOMMUPT framework.
> > 
> > Reviewed-by: Lu Baolu<baolu.lu@linux.intel.com>
> > Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> > Co-developed-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> > Signed-off-by: Jacob Pan<jacob.pan@linux.microsoft.com>
> > ---
> > v6:
> >     - Limit search length (Baolu, Jason)
> > v5:
> >     - Fix next_iova exceeds iopt_area_last_iova (Alex)
> >     - Rename IOCTL more specific to NOIOMMU, i.e.
> > 	 IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA (Kevin)
> >     - Add header stubs for iopt_get_phys()
> > v4:
> >     - Fix ioctl return type (Yi Liu)
> > ---
> >   drivers/iommu/iommufd/io_pagetable.c    | 72
> > +++++++++++++++++++++++++ drivers/iommu/iommufd/ioas.c            |
> > 30 +++++++++++ drivers/iommu/iommufd/iommufd_private.h | 18 +++++++
> >   drivers/iommu/iommufd/main.c            |  3 ++
> >   include/uapi/linux/iommufd.h            | 27 ++++++++++
> >   5 files changed, 150 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/io_pagetable.c
> > b/drivers/iommu/iommufd/io_pagetable.c index
> > 24d4917105d9..4369447e2125 100644 ---
> > a/drivers/iommu/iommufd/io_pagetable.c +++
> > b/drivers/iommu/iommufd/io_pagetable.c @@ -859,6 +859,78 @@ int
> > iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
> > return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped); }
> >   
> > +#ifdef CONFIG_IOMMUFD_NOIOMMU
> > +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
> > u64 *paddr,
> > +		  u64 *length)
> > +{
> > +	struct iopt_area *area;
> > +	u64 max_length = *length;
> > +	u64 tmp_length = 0;
> > +	u64 tmp_paddr = 0;
> > +	int rc = 0;
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
> > +	 * userspace search can be optimized for fewer ioctls. A
> > max_length of
> > +	 * 0 means no limit.
> > +	 */
> > +	while (iova < iopt_area_last_iova(area)) {
> > +		unsigned long next_iova;
> > +		u64 next_paddr;
> > +
> > +		if (max_length && tmp_length >= max_length) {
> > +			tmp_length = max_length;  
> 
> nit: is this value setting duplicated with the one outside this loop?
yes, you are right. will delete.

         if (max_length && tmp_length >= max_length)
                 break;
Thanks!

Jacob

> > +			break;
> > +		}
> > +
> > +		if (check_add_overflow(iova, PAGE_SIZE,
> > &next_iova))
> > +			break;
> > +
> > +		if (next_iova > iopt_area_last_iova(area))
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
> > +
> > +	if (max_length && tmp_length > max_length)
> > +		tmp_length = max_length;
> > +	*length = tmp_length;
> > +
> > +unlock_exit:
> > +	up_read(&iopt->iova_rwsem);
> > +
> > +	return rc;
> > +}
> > +#endif
> > +
> >   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long
> > *unmapped) {
> >   	/* If the IOVAs are empty then unmap all succeeds */
> > diff --git a/drivers/iommu/iommufd/ioas.c
> > b/drivers/iommu/iommufd/ioas.c index fed06c2b728e..82bbc0c2357e
> > 100644 --- a/drivers/iommu/iommufd/ioas.c
> > +++ b/drivers/iommu/iommufd/ioas.c
> > @@ -375,6 +375,36 @@ int iommufd_ioas_unmap(struct iommufd_ucmd
> > *ucmd) return rc;
> >   }
> >   
> > +#ifdef CONFIG_IOMMUFD_NOIOMMU
> > +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_noiommu_get_pa *cmd = ucmd->cmd;
> > +	struct iommufd_ioas *ioas;
> > +	int rc;
> > +
> > +	if (!capable(CAP_SYS_RAWIO))
> > +		return -EPERM;
> > +
> > +	if (cmd->flags || cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +
> > +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +
> > +	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->out_phys,
> > +			   &cmd->length);
> > +	if (rc)
> > +		goto out_put;
> > +
> > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +out_put:
> > +	iommufd_put_object(ucmd->ictx, &ioas->obj);
> > +
> > +	return rc;
> > +}
> > +#endif
> > +
> >   static void iommufd_release_all_iova_rwsem(struct iommufd_ctx
> > *ictx, struct xarray *ioas_list)
> >   {
> > diff --git a/drivers/iommu/iommufd/iommufd_private.h
> > b/drivers/iommu/iommufd/iommufd_private.h index
> > 2682b5baa6e9..13f1506d8066 100644 ---
> > a/drivers/iommu/iommufd/iommufd_private.h +++
> > b/drivers/iommu/iommufd/iommufd_private.h @@ -118,6 +118,16 @@ int
> > iopt_map_pages(struct io_pagetable *iopt, struct list_head
> > *pages_list, int iopt_unmap_iova(struct io_pagetable *iopt,
> > unsigned long iova, unsigned long length, unsigned long *unmapped);
> > int iopt_unmap_all(struct io_pagetable *iopt, unsigned long
> > *unmapped); +#ifdef CONFIG_IOMMUFD_NOIOMMU +int
> > iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64
> > *paddr,
> > +		  u64 *length);
> > +#else
> > +static inline int iopt_get_phys(struct io_pagetable *iopt,
> > unsigned long iova,
> > +				u64 *paddr, u64 *length)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif
> >   
> >   int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
> >   				   struct iommu_domain *domain,
> > @@ -346,6 +356,14 @@ int iommufd_ioas_map_file(struct iommufd_ucmd
> > *ucmd); int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
> >   int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
> >   int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
> > +#ifdef CONFIG_IOMMUFD_NOIOMMU
> > +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd);
> > +#else
> > +static inline int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd
> > *ucmd) +{
> > +	return -EOPNOTSUPP;
> > +}
> > +#endif
> >   int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
> >   int iommufd_option_rlimit_mode(struct iommu_option *cmd,
> >   			       struct iommufd_ctx *ictx);
> > diff --git a/drivers/iommu/iommufd/main.c
> > b/drivers/iommu/iommufd/main.c index 8c6d43601afb..3b4192d70570
> > 100644 --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -424,6 +424,7 @@ union ucmd_buffer {
> >   	struct iommu_ioas_alloc alloc;
> >   	struct iommu_ioas_allow_iovas allow_iovas;
> >   	struct iommu_ioas_copy ioas_copy;
> > +	struct iommu_ioas_noiommu_get_pa noiommu_get_pa;
> >   	struct iommu_ioas_iova_ranges iova_ranges;
> >   	struct iommu_ioas_map map;
> >   	struct iommu_ioas_unmap unmap;
> > @@ -482,6 +483,8 @@ static const struct iommufd_ioctl_op
> > iommufd_ioctl_ops[] = { IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map,
> > struct iommu_ioas_map, iova), IOCTL_OP(IOMMU_IOAS_MAP_FILE,
> > iommufd_ioas_map_file, struct iommu_ioas_map_file, iova),
> > +	IOCTL_OP(IOMMU_IOAS_NOIOMMU_GET_PA,
> > iommufd_ioas_noiommu_get_pa, struct iommu_ioas_noiommu_get_pa,
> > +		 out_phys),
> >   	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct
> > iommu_ioas_unmap, length),
> >   	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct
> > iommu_option, val64), diff --git a/include/uapi/linux/iommufd.h
> > b/include/uapi/linux/iommufd.h index e998dfbd6960..26b4998439e8
> > 100644 --- a/include/uapi/linux/iommufd.h
> > +++ b/include/uapi/linux/iommufd.h
> > @@ -57,6 +57,7 @@ enum {
> >   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
> >   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
> >   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> > +	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
> >   };
> >   
> >   /**
> > @@ -219,6 +220,32 @@ struct iommu_ioas_map {
> >   };
> >   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
> >   
> > +/**
> > + * struct iommu_ioas_noiommu_get_pa -
> > ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> > + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> > + * @flags: Reserved, must be 0 for now
> > + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> > + * @__reserved: Must be 0
> > + * @iova: IOVA to query
> > + * @length: On input, maximum number of bytes to scan for
> > contiguity (0 means
> > + *          no limit). On output, actual number of contiguous
> > bytes starting
> > + *          from out_phys.
> > + * @out_phys: Output physical address the IOVA maps to
> > + *
> > + * Query the physical address backing an IOVA range. The entire
> > range must be
> > + * mapped already. For noiommu devices doing unsafe DMA only.
> > + */
> > +struct iommu_ioas_noiommu_get_pa {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 ioas_id;
> > +	__u32 __reserved;
> > +	__aligned_u64 iova;
> > +	__aligned_u64 length;
> > +	__aligned_u64 out_phys;
> > +};
> > +#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE,
> > IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA) +
> >   /**
> >    * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
> >    * @size: sizeof(struct iommu_ioas_map_file)  

