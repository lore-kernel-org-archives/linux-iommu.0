Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54C137F8C1
	for <iommu@lists.linux.dev>; Wed, 13 May 2026 07:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658847; cv=none; b=gT2hA/VxRAA6lhjJGhlaXDGOw3HuNKdXLMaaLFWCoGcCc8CDjDFvdJYLxdq93OuXQuEd2SFgPgrTI75OLxA/tQAewWGAuvMUrLusxY3NJ7Bm6h61qs7uatKXNTNuViGw1AyLptykrrr4ezUbwF6qwv+EapBo7qlba6TcRtzLUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658847; c=relaxed/simple;
	bh=9rM+43NVm+SjRISRQaK06FWhejl8N9yw+rVFlEHU46M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK3UQeXvbAaSqLkcCVtwXKR40BaCD4ii+2X0yr6TjYdIAk+oOUxPxfKQWLYhWZTQQtu+nDtDC2290uO0lOPZlcF5WgRS32kFavt/zk92NBNSmYrnZBCdPavDKyZ84bqzSbbBw5mF3pW2BYAwDADAHURqT4ocFeJ7S9jRj+9NslQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fcvkz13A; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fcvkz13A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778658846; x=1810194846;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9rM+43NVm+SjRISRQaK06FWhejl8N9yw+rVFlEHU46M=;
  b=fcvkz13AyfBpQKIErzDT9zrcSLco7W3xHO0NUCdOvLoQeEVJxdI2SKlu
   uq8Z/7BcpBL4/ErhzQ6qB5W51ry1n0Xk1yJ0YWcUJZyvjS0BajL8RIkns
   tB6MfjXP96byFPY3zXkT64KK+9b/ALLN17vH11omH9dsXjVj8QwoMysk0
   2vpnKh0P4Yb8A0QG8FBwvC4QYuSuXDHnEdemvoDizE6C/LB3/86IVqw8N
   kOQCxqcoj/Zy8lZTNZZeEe21eVKkf/sco+mqStXSjO3qTekIR1YnqoYXT
   hpDm7nPXvqrJxm002T+4yoL6pbo/mOIrkUh8SdiI2E3Cx+iegWb0kuYON
   A==;
X-CSE-ConnectionGUID: kFLBW2BBTceFmhUzmHyuWg==
X-CSE-MsgGUID: 4rduCHSXQ+Cx6wVD2/GeqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="102245749"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="102245749"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:54:06 -0700
X-CSE-ConnectionGUID: wL2R57t6SBaE746xPD97yQ==
X-CSE-MsgGUID: AE+tiQUcQb27cja8vLZmBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="276123044"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 00:54:01 -0700
Message-ID: <a8db8d35-e7de-4e74-886b-d978e1ecff06@linux.intel.com>
Date: Wed, 13 May 2026 15:53:43 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] iommufd: Add an ioctl to query PA from IOVA for
 noiommu mode
To: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
 Joerg Roedel <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>,
 David Matlack <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>,
 Nicolin Chen <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Yi Liu <yi.l.liu@intel.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, skhawaja@google.com,
 pasha.tatashin@soleen.com, Will Deacon <will@kernel.org>
References: <20260511184116.3687392-1-jacob.pan@linux.microsoft.com>
 <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20260511184116.3687392-6-jacob.pan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/12/26 02:41, Jacob Pan wrote:
> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOAS. The mapping is backed by SW-only I/O page tables
> maintained by the generic IOMMUPT framework.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v5:
>     - Add header stubs for iopt_get_phys() and
>       iommufd_ioas_noiommu_get_pa() to avoid ifdef at call sites (Kevin)
> v4:
>     - Fix ioctl return type (Yi Liu)
> v2:
>     - New patch
> ---
>   drivers/iommu/iommufd/io_pagetable.c    | 62 +++++++++++++++++++++++++
>   drivers/iommu/iommufd/ioas.c            | 30 ++++++++++++
>   drivers/iommu/iommufd/iommufd_private.h | 18 +++++++
>   drivers/iommu/iommufd/main.c            |  3 ++
>   include/uapi/linux/iommufd.h            | 25 ++++++++++
>   5 files changed, 138 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index 24d4917105d9..1ee7c8e6408c 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -859,6 +859,68 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length)
> +{
> +	struct iopt_area *area;
> +	u64 tmp_length = 0;
> +	u64 tmp_paddr = 0;
> +	int rc = 0;
> +
> +	down_read(&iopt->iova_rwsem);
> +	area = iopt_area_iter_first(iopt, iova, iova);
> +	if (!area || !area->pages) {
> +		rc = -ENOENT;
> +		goto unlock_exit;
> +	}
> +
> +	if (!area->storage_domain ||
> +	    area->storage_domain->owner != &iommufd_noiommu_ops) {
> +		rc = -EOPNOTSUPP;
> +		goto unlock_exit;
> +	}
> +
> +	*paddr = iommu_iova_to_phys(area->storage_domain, iova);
> +	if (!*paddr) {
> +		rc = -EINVAL;
> +		goto unlock_exit;
> +	}
> +
> +	tmp_length = PAGE_SIZE - offset_in_page(iova);
> +	tmp_paddr = *paddr;
> +	/*
> +	 * Scan the domain for the contiguous physical address length so that
> +	 * userspace search can be optimized for fewer ioctls.
> +	 */
> +	while (iova < iopt_area_last_iova(area)) {
> +		unsigned long next_iova;
> +		u64 next_paddr;
> +
> +		if (check_add_overflow(iova, PAGE_SIZE, &next_iova))
> +			break;
> +
> +		if (next_iova > iopt_area_last_iova(area))
> +			break;
> +
> +		next_paddr = iommu_iova_to_phys(area->storage_domain, next_iova);
> +
> +		if (!next_paddr || next_paddr != tmp_paddr + PAGE_SIZE)
> +			break;
> +
> +		iova = next_iova;
> +		tmp_paddr += PAGE_SIZE;
> +		tmp_length += PAGE_SIZE;
> +	}
> +	*length = tmp_length;
> +
> +unlock_exit:
> +	up_read(&iopt->iova_rwsem);
> +
> +	return rc;
> +}
> +#endif
> +
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>   {
>   	/* If the IOVAs are empty then unmap all succeeds */
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..666440e32c9e 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -375,6 +375,36 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>   	return rc;
>   }
>   
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_noiommu_get_pa *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	int rc;
> +
> +	if (!capable(CAP_SYS_RAWIO))
> +		return -EPERM;
> +
> +	if (cmd->flags || cmd->__reserved)
> +		return -EOPNOTSUPP;
> +
> +	ioas = iommufd_get_ioas(ucmd->ictx, cmd->ioas_id);
> +	if (IS_ERR(ioas))
> +		return PTR_ERR(ioas);
> +
> +	rc = iopt_get_phys(&ioas->iopt, cmd->iova, &cmd->out_phys,
> +			   &cmd->out_length);
> +	if (rc)
> +		goto out_put;
> +
> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> +out_put:
> +	iommufd_put_object(ucmd->ictx, &ioas->obj);
> +
> +	return rc;
> +}
> +#endif
> +
>   static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
>   					   struct xarray *ioas_list)
>   {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2682b5baa6e9..13f1506d8066 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -118,6 +118,16 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
>   int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>   		    unsigned long length, unsigned long *unmapped);
>   int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length);
> +#else
> +static inline int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova,
> +				u64 *paddr, u64 *length)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   
>   int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>   				   struct iommu_domain *domain,
> @@ -346,6 +356,14 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
>   int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
> +#ifdef CONFIG_IOMMUFD_NOIOMMU
> +int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd);
> +#else
> +static inline int iommufd_ioas_noiommu_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif
>   int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>   int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>   			       struct iommufd_ctx *ictx);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..3b4192d70570 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -424,6 +424,7 @@ union ucmd_buffer {
>   	struct iommu_ioas_alloc alloc;
>   	struct iommu_ioas_allow_iovas allow_iovas;
>   	struct iommu_ioas_copy ioas_copy;
> +	struct iommu_ioas_noiommu_get_pa noiommu_get_pa;
>   	struct iommu_ioas_iova_ranges iova_ranges;
>   	struct iommu_ioas_map map;
>   	struct iommu_ioas_unmap unmap;
> @@ -482,6 +483,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>   	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct iommu_ioas_map, iova),
>   	IOCTL_OP(IOMMU_IOAS_MAP_FILE, iommufd_ioas_map_file,
>   		 struct iommu_ioas_map_file, iova),
> +	IOCTL_OP(IOMMU_IOAS_NOIOMMU_GET_PA, iommufd_ioas_noiommu_get_pa, struct iommu_ioas_noiommu_get_pa,
> +		 out_phys),
>   	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
>   		 length),
>   	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index e998dfbd6960..7df366d161f1 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>   	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>   	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>   	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA = 0x95,
>   };
>   
>   /**
> @@ -219,6 +220,30 @@ struct iommu_ioas_map {
>   };
>   #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
>   
> +/**
> + * struct iommu_ioas_noiommu_get_pa - ioctl(IOMMU_IOAS_NOIOMMU_GET_PA)
> + * @size: sizeof(struct iommu_ioas_noiommu_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @out_length: Number of bytes contiguous physical address starting from phys

Nit: Instead of making this behavior mandatory, would it be valuable to
allocate a bit in @flags to toggle this behavior? For extremely large
mappings (e.g., several GBs of contiguous hugepages), the loop to
determine the contiguous physical addresses might take a long time. A
very long scan could theoretically delay userspace DMA setup.

> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range must be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */
> +struct iommu_ioas_noiommu_get_pa {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 iova;
> +	__aligned_u64 out_length;
> +	__aligned_u64 out_phys;
> +};
> +#define IOMMU_IOAS_NOIOMMU_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_NOIOMMU_GET_PA)
> +
>   /**
>    * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>    * @size: sizeof(struct iommu_ioas_map_file)

Otherwise, this looks good to me,

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
