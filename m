Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B77425CE6
	for <iommu@lists.linux.dev>; Tue, 31 Mar 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774978190; cv=none; b=DQO8LAvLDMBIscmJ9CzFV0yknY26SVPVVSMnoAoCM23fjgjXW2EO65XA4v6GVKdadDg9x1qW6Mm73xmE4LB0RpPUNSm4CQYuoXYm34ogGVZfS9RzhsR48KCzVnIoic6skPW837Ru8sacE84Y1wmktvxiMbYC/e2njsEDgq0SxGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774978190; c=relaxed/simple;
	bh=afVsWC6romX46kha/VBu12xNrAFtVlaO2v0vB2nouaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfmxKqGTU1eHiD3Udikh0FCzp3G31nNby8skhC+TBaZ+9hpCGnw80pqwKd4QQB1SfjLH26clOBkCRE97MNpYUupL86eVfg0M1+mYJKt8HKjSm9U9lx/Cfj5at2TuWn0DRH7QtH15x7bvWOVfHAlYDibbwd49b7VH04HMS8o3xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i19tkGE3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i19tkGE3"
Received: from localhost (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id E0F7E20B6F01;
	Tue, 31 Mar 2026 10:29:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E0F7E20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774978188;
	bh=Kvk3FSW5Gw7haGBEArO4UciHWuhKops6mpak1udWgH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i19tkGE3AK3BwMnpKt9RVyDWEEqULnNiM8h7ZIel1bWfoZhS+pi4XxfOe84OzFlR/
	 KtVavqZuEYtzTaIOE6QhoE6dB0GK2xq7h+SM8GsM3RnWLQ7lsqA1LeTzz3sSDN4t6M
	 nhhckzMzQgsFfntLbSC9LrPTRkWEQcezDCcYCS2Q=
Date: Tue, 31 Mar 2026 10:29:46 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe
 <jgg@ziepe.ca>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: Remove dead code for exclusion ranges in
 IVMD
Message-ID: <20260331102946.00004bcc@linux.microsoft.com>
In-Reply-To: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>
References: <20260331152550.479841-1-zhangyu1@linux.microsoft.com>
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

Hi Yu,

On Tue, 31 Mar 2026 23:25:50 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> Exclusion ranges in IVMD are treated as unity mappings with r&w
> permissions since commit 0bbe4ced53e3 ("iommu/amd: Fix the
> overwritten field in IVMD header"), using 1:1 mappings. And IOMMU
> Exclusion Base & Range Limit Registers (0x0020/0x0028) are actually
> no longer used.
> 
> As a result, several definitions and code paths became dead code:
> 
>  - exclusion_start/exclusion_length in struct amd_iommu are never
>    assigned,
>  - iommu_set_exclusion_range() always returns 0 now.
>  - MMIO_EXCL_ENABLE_MASK & MMIO_EXCL_ALLOW_MASK are only used by
>    the removed iommu_set_exclusion_range().
>  - DEV_ENTRY_EX is no longer set in any DTE.
>  - IOMMU_UNITY_MAP_FLAG_EXCL_RANGE is no longer set, thus the
>    IOMMU_RESV_RESERVED branch in amd_iommu_get_resv_regions() is
>    no longer reachable.
> 
> Just remove all of the dead code. No functional change.
> 
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h | 12 ------------
>  drivers/iommu/amd/init.c            | 23 -----------------------
>  drivers/iommu/amd/iommu.c           |  3 ---
>  3 files changed, 38 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu_types.h
> b/drivers/iommu/amd/amd_iommu_types.h index
> c685d3771436..a481d8cbd053 100644 ---
> a/drivers/iommu/amd/amd_iommu_types.h +++
> b/drivers/iommu/amd/amd_iommu_types.h @@ -50,10 +50,6 @@
>  #define MMIO_GET_BUS(x) (((x) & MMIO_RANGE_BUS_MASK) >>
> MMIO_RANGE_BUS_SHIFT) #define MMIO_MSI_NUM(x)	((x) & 0x1f)
>  
> -/* Flag masks for the AMD IOMMU exclusion range */
> -#define MMIO_EXCL_ENABLE_MASK 0x01ULL
> -#define MMIO_EXCL_ALLOW_MASK  0x02ULL
> -
>  /* Used offsets into the MMIO space */
>  #define MMIO_DEV_TABLE_OFFSET   0x0000
>  #define MMIO_CMD_BUF_OFFSET     0x0008
> @@ -231,7 +227,6 @@
>  #define DEV_ENTRY_IR            0x3d
>  #define DEV_ENTRY_IW            0x3e
>  #define DEV_ENTRY_NO_PAGE_FAULT	0x62
> -#define DEV_ENTRY_EX            0x67
>  #define DEV_ENTRY_SYSMGT1       0x68
>  #define DEV_ENTRY_SYSMGT2       0x69
>  #define DTE_DATA1_SYSMGT_MASK	GENMASK_ULL(41, 40)
> @@ -384,8 +379,6 @@
>  #define IOMMU_PROT_IR 0x01
>  #define IOMMU_PROT_IW 0x02
>  
> -#define IOMMU_UNITY_MAP_FLAG_EXCL_RANGE	(1 << 2)
> -
>  /* IOMMU capabilities */
>  #define IOMMU_CAP_IOTLB   24
>  #define IOMMU_CAP_NPCACHE 26
> @@ -680,11 +673,6 @@ struct amd_iommu {
>  	/* pci domain of this IOMMU */
>  	struct amd_iommu_pci_seg *pci_seg;
>  
> -	/* start of exclusion range of that IOMMU */
> -	u64 exclusion_start;
> -	/* length of exclusion range of that IOMMU */
> -	u64 exclusion_length;
> -
>  	/* command buffer virtual address */
>  	u8 *cmd_buf;
>  	u32 cmd_buf_head;
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index f3fd7f39efb4..a33bf3f5ed8a 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -352,28 +352,6 @@ static void iommu_write_l2(struct amd_iommu
> *iommu, u8 address, u32 val) *
>   ****************************************************************************/
>  
> -/*
> - * This function set the exclusion range in the IOMMU. DMA accesses
> to the
> - * exclusion range are passed through untranslated
> - */
> -static void iommu_set_exclusion_range(struct amd_iommu *iommu)
> -{
> -	u64 start = iommu->exclusion_start & PAGE_MASK;
> -	u64 limit = (start + iommu->exclusion_length - 1) &
> PAGE_MASK;
> -	u64 entry;
> -
> -	if (!iommu->exclusion_start)
> -		return;
> -
> -	entry = start | MMIO_EXCL_ENABLE_MASK;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_BASE_OFFSET,
> -			&entry, sizeof(entry));
> -
> -	entry = limit;
> -	memcpy_toio(iommu->mmio_base + MMIO_EXCL_LIMIT_OFFSET,
> -			&entry, sizeof(entry));
> -}
> -
>  static void iommu_set_cwwb_range(struct amd_iommu *iommu)
>  {
>  	u64 start = iommu_virt_to_phys((void *)iommu->cmd_sem);
> @@ -2891,7 +2869,6 @@ static void early_enable_iommu(struct amd_iommu
> *iommu) iommu_set_device_table(iommu);
>  	iommu_enable_command_buffer(iommu);
>  	iommu_enable_event_buffer(iommu);
> -	iommu_set_exclusion_range(iommu);
>  	iommu_enable_gt(iommu);
>  	iommu_enable_ga(iommu);
>  	iommu_enable_xt(iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 760d5f4623b5..4e7f5b993c65 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3076,9 +3076,6 @@ static void amd_iommu_get_resv_regions(struct
> device *dev, prot |= IOMMU_READ;
>  		if (entry->prot & IOMMU_PROT_IW)
>  			prot |= IOMMU_WRITE;
> -		if (entry->prot & IOMMU_UNITY_MAP_FLAG_EXCL_RANGE)
> -			/* Exclusion range */
> -			type = IOMMU_RESV_RESERVED;
>  
>  		region =
> iommu_alloc_resv_region(entry->address_start, length, prot, type,
Reviewed-by: Jacob Pan <jacob.pan@linux.microsoft.com>
