Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B43E3C79
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367987; cv=none; b=mWzUMhbJVmqxd6mQRreGR4Kij5WqZXCmowHsyBdyxQt3+8ozeyzauEbclKY/o3MQ2D0hSgB0352ADGwcCtvKtru7/IxY/yL1bYmXrlRoiYKI4tguupuCDp40x/SQAqXFbGYu6J8uhjAy/T6kBRR9gHA1bLQQanZAQHxjwii/Dco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367987; c=relaxed/simple;
	bh=X2zaWTOYmPQWRuROPAUax1tYzFzJ6T+XBKVGS/3T4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2yuqT16PaOksRIVGMrTPSqLbvf6rFgR/DX2URMsh+Zr2SKBZcOOwdau1Qh4RpZuT3Tg/rjPcf3MCvDXa5QjGoTO7INu6kpqOqO1tcSbXvHtjPJ077K+JDj5e7h2nB2hpeVZrt3Ew+8rLgpYDpqbAyupTJJ1qTZrJmEYQOGtINY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=lcXCf4yj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IyS9C9lN; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="lcXCf4yj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IyS9C9lN"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8AD191D001A6;
	Thu, 16 Apr 2026 15:33:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Apr 2026 15:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776367983;
	 x=1776454383; bh=twSM+BXFdro857pCdbVP3QgtmXnq39b1MpuSG8wFsxo=; b=
	lcXCf4yj/hudEJ/GwZ0KUv3EmEB6B7TnD9AIJP5Iaia0/LapCzLsYvaj4uXGrZwl
	Kj67skZpZyz1/g6QbynKJvOV4uRBDxSr+Xro/XGPRaJfPFZEYF6hw4T0Yi3vV1yb
	mItT8vx9tVy+uD7q1X6w+3J3bkz5Ko9Du7/cQHEFZ3B8j6sSkYBJN6xG9fCBYDMu
	t9FgeJhDv+wjbR11gxQpBm2i2nXZwURWXneb4hPnUAIw5+IPeDtuTjL/wQ1xabrX
	gKAbOlwD03jiqYaNhOvcy4KfRzdr81i2BnvjQIEPLAHKmmrQsXibk9bkvc/wV6ZU
	hYAE7Muzc+8wPMAzsImhAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776367983; x=
	1776454383; bh=twSM+BXFdro857pCdbVP3QgtmXnq39b1MpuSG8wFsxo=; b=I
	yS9C9lNeHZiG/pMYNEv+qneAiumF9qYq8Hdw/hsXVG9b7n9DGaDYR3pGTRP3jPGP
	FrLjUi1adjgrALlzanGZkvbjHbuCJtvldrJ/N1fPgFjM1bbrVL9zL6o6YsiPKJwD
	M6xElHATW2BsW30geIvFhMBKPcSifx+WeDKt3wfX2MyhM/K1aFuTY1YowqzjY9hr
	QULk/eQ6x4vy5VWAI/XJjM2f70sjqQQuj0AmzsC62oELjvLU/i2mFy5n2IQrqfVx
	Bgl9LzKfDgIfk3MoP4scuSQnCHQJ0//Ap+DE85rrsfKY9MGgy89a9KKilfeoYBPg
	ID/eadzhsNT2KOrbAgX6Q==
X-ME-Sender: <xms:bjnhaeO2J4L6pmM3FUmDLkxHENZbVKs9L_uqzBjBmXjMFLYeCeIALQ>
    <xme:bjnhabcOA2xWAKHIC8oZzORTZkoJuJ9I270y9Wd5CtUgXcUrbYKiEqaeCCPdD3DGT
    oxnfnf7ELFKsP1g7ovDUk99xTjYJ8MK23Nzrkq-DGFORmA4J8w1qg>
X-ME-Received: <xmr:bjnhacHJNXV83zVVIJlCktYOd9Ww5E3z79O76Pvh7JuxQqnE6XMKTnma3DM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfgjfhfogggtgfesthejredtredtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepvdekfeejkedvudfhudfhteekudfgudeiteetvdeukedvheetvdekgfdugeev
    ueeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeduiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrphgrnheslhhinhhugidrmhhitghroh
    hsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehiohhmmhhusehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtohepjhhgghesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhho
    rhhoseeksgihthgvshdrohhrghdprhgtphhtthhopehsmhhoshhtrghfrgesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepughmrghtlhgrtghksehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtghomhdprhgtphhtthhopehnih
    gtohhlihhntgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:bjnhaeuYfGjbb5RtJcvaf0hK0lABk1SyPYsF20CwPnBi73V2SaS1Pg>
    <xmx:bjnhaep7EwHe3VhiKTm7gfV8fMBz-VPZnZKMygOxGrhAMN6CE6gPnA>
    <xmx:bjnhadl8kFrW2YXqsntBTg7XY6pVlHDckN0qVd8e6sLuuPUVLpvSOA>
    <xmx:bjnhaTgkaYQNehO7mXZpmyZHRiSTezOOfK1yi2W4VbebqB1tQWY7RA>
    <xmx:bznhactlE3FtQsGObRc8Ib6EI36ewU75DpcAbQyoGj0FqNzp-8UKFj9V>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 15:33:00 -0400 (EDT)
Date: Thu, 16 Apr 2026 13:32:57 -0600
From: Alex Williamson <alex@shazbot.org>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel
 <joro@8bytes.org>, Mostafa Saleh <smostafa@google.com>, David Matlack
 <dmatlack@google.com>, Robin Murphy <robin.murphy@arm.com>, Nicolin Chen
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu
 <yi.l.liu@intel.com>, skhawaja@google.com, pasha.tatashin@soleen.com, Will
 Deacon <will@kernel.org>, Baolu Lu <baolu.lu@linux.intel.com>,
 alex@shazbot.org
Subject: Re: [PATCH V4 04/10] iommufd: Add an ioctl IOMMU_IOAS_GET_PA to
 query PA from IOVA
Message-ID: <20260416133257.4d2e8818@shazbot.org>
In-Reply-To: <20260414211412.2729-5-jacob.pan@linux.microsoft.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
	<20260414211412.2729-5-jacob.pan@linux.microsoft.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Apr 2026 14:14:06 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> To support no-IOMMU mode where userspace drivers perform unsafe DMA
> using physical addresses, introduce a new API to retrieve the
> physical address of a user-allocated DMA buffer that has been mapped to
> an IOVA via IOAS. The mapping is backed by mock I/O page tables maintained
> by generic IOMMUPT framework.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> v4:
>    - Fix unaligned IOVA length (Sashiko)
> v2:
>    - Scan the contiguous physical-address span beyond the first page and return its length.
> ---
>  drivers/iommu/iommufd/io_pagetable.c    | 60 +++++++++++++++++++++++++
>  drivers/iommu/iommufd/ioas.c            | 25 +++++++++++
>  drivers/iommu/iommufd/iommufd_private.h |  3 ++
>  drivers/iommu/iommufd/main.c            |  3 ++
>  include/uapi/linux/iommufd.h            | 25 +++++++++++
>  5 files changed, 116 insertions(+)
> 
> diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> index ee003bb2f647..04336a8e12f5 100644
> --- a/drivers/iommu/iommufd/io_pagetable.c
> +++ b/drivers/iommu/iommufd/io_pagetable.c
> @@ -849,6 +849,66 @@ int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>  	return iopt_unmap_iova_range(iopt, iova, iova_last, unmapped);
>  }
>  
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length)
> +{
> +	struct iopt_area *area;
> +	u64 tmp_length = 0;
> +	u64 tmp_paddr = 0;
> +	int rc = 0;
> +
> +	if (!IS_ENABLED(CONFIG_VFIO_NOIOMMU))
> +		return -EOPNOTSUPP;
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

If next_iova exceeds iopt_area_last_iova(area) AND exists in
storage_domain AND happens to be physically contiguous, tmp_length is
advanced and the return length exceeds the mapping.  Otherwise this
also always does an iommu_iova_to_phys() one iteration beyond the area
last iova.  Thanks,

Alex

> +
> +unlock_exit:
> +	up_read(&iopt->iova_rwsem);
> +
> +	return rc;
> +}
> +
>  int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped)
>  {
>  	/* If the IOVAs are empty then unmap all succeeds */
> diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
> index fed06c2b728e..93cebb4c23bd 100644
> --- a/drivers/iommu/iommufd/ioas.c
> +++ b/drivers/iommu/iommufd/ioas.c
> @@ -375,6 +375,31 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
>  	return rc;
>  }
>  
> +int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_ioas_get_pa *cmd = ucmd->cmd;
> +	struct iommufd_ioas *ioas;
> +	int rc;
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
> +
>  static void iommufd_release_all_iova_rwsem(struct iommufd_ctx *ictx,
>  					   struct xarray *ioas_list)
>  {
> diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> index 2682b5baa6e9..0e772882aee9 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -118,6 +118,8 @@ int iopt_map_pages(struct io_pagetable *iopt, struct list_head *pages_list,
>  int iopt_unmap_iova(struct io_pagetable *iopt, unsigned long iova,
>  		    unsigned long length, unsigned long *unmapped);
>  int iopt_unmap_all(struct io_pagetable *iopt, unsigned long *unmapped);
> +int iopt_get_phys(struct io_pagetable *iopt, unsigned long iova, u64 *paddr,
> +		  u64 *length);
>  
>  int iopt_read_and_clear_dirty_data(struct io_pagetable *iopt,
>  				   struct iommu_domain *domain,
> @@ -346,6 +348,7 @@ int iommufd_ioas_map_file(struct iommufd_ucmd *ucmd);
>  int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd);
>  int iommufd_ioas_copy(struct iommufd_ucmd *ucmd);
>  int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd);
> +int iommufd_ioas_get_pa(struct iommufd_ucmd *ucmd);
>  int iommufd_ioas_option(struct iommufd_ucmd *ucmd);
>  int iommufd_option_rlimit_mode(struct iommu_option *cmd,
>  			       struct iommufd_ctx *ictx);
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 8c6d43601afb..ebae01ed947d 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -432,6 +432,7 @@ union ucmd_buffer {
>  	struct iommu_veventq_alloc veventq;
>  	struct iommu_vfio_ioas vfio_ioas;
>  	struct iommu_viommu_alloc viommu;
> +	struct iommu_ioas_get_pa get_pa;
>  #ifdef CONFIG_IOMMUFD_TEST
>  	struct iommu_test_cmd test;
>  #endif
> @@ -484,6 +485,8 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  		 struct iommu_ioas_map_file, iova),
>  	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct iommu_ioas_unmap,
>  		 length),
> +	IOCTL_OP(IOMMU_IOAS_GET_PA, iommufd_ioas_get_pa, struct iommu_ioas_get_pa,
> +		 out_phys),
>  	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option, val64),
>  	IOCTL_OP(IOMMU_VDEVICE_ALLOC, iommufd_vdevice_alloc_ioctl,
>  		 struct iommu_vdevice_alloc, virt_id),
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 1dafbc552d37..9afe0a1b11a0 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -57,6 +57,7 @@ enum {
>  	IOMMUFD_CMD_IOAS_CHANGE_PROCESS = 0x92,
>  	IOMMUFD_CMD_VEVENTQ_ALLOC = 0x93,
>  	IOMMUFD_CMD_HW_QUEUE_ALLOC = 0x94,
> +	IOMMUFD_CMD_IOAS_GET_PA = 0x95,
>  };
>  
>  /**
> @@ -219,6 +220,30 @@ struct iommu_ioas_map {
>  };
>  #define IOMMU_IOAS_MAP _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_MAP)
>  
> +/**
> + * struct iommu_ioas_get_pa - ioctl(IOMMU_IOAS_GET_PA)
> + * @size: sizeof(struct iommu_ioas_get_pa)
> + * @flags: Reserved, must be 0 for now
> + * @ioas_id: IOAS ID to query IOVA to PA mapping from
> + * @__reserved: Must be 0
> + * @iova: IOVA to query
> + * @out_length: Number of bytes contiguous physical address starting from phys
> + * @out_phys: Output physical address the IOVA maps to
> + *
> + * Query the physical address backing an IOVA range. The entire range must be
> + * mapped already. For noiommu devices doing unsafe DMA only.
> + */
> +struct iommu_ioas_get_pa {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 ioas_id;
> +	__u32 __reserved;
> +	__aligned_u64 iova;
> +	__aligned_u64 out_length;
> +	__aligned_u64 out_phys;
> +};
> +#define IOMMU_IOAS_GET_PA _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_GET_PA)
> +
>  /**
>   * struct iommu_ioas_map_file - ioctl(IOMMU_IOAS_MAP_FILE)
>   * @size: sizeof(struct iommu_ioas_map_file)

