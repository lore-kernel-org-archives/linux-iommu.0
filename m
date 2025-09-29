Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8917225A35F
	for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759175868; cv=none; b=lIq5vEerdBuNbgBgr9YT1g7/Uq11IV2YEvTUyuxO0HQt+uDnLqeQutGCKVYKQPB6QJ/oIBHF3OI05z5gvfohprCoCiJpnf3A967u50wfjdqnT5+32OwNsqXxXDr3+isRt0CtGyBDXJcHWKs/KSCk+FLe3/FiUwZBAB8IdWuhCvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759175868; c=relaxed/simple;
	bh=gTsSNd2/zLIn2jp0BAXYJxZ3J/uFuF5NygJQfxzhs14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZ/tVJoCC18rJa6lVAtnrKoekSi5xqsrblxSiMvrNQ/BAIM4EsR1rJ11OFFEV2ZWc4Qgjk41rHEREilDaDcIIPUNvhyy56va86wn0qgxjulzOWxkeXgeLORaRzzoUw9khhGIVY2esqmO8E4c1IXInvmQLycn8mTufNxxAi1mCck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n88YjdNX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n88YjdNX"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2731ff54949so5745ad.1
        for <iommu@lists.linux.dev>; Mon, 29 Sep 2025 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759175866; x=1759780666; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YOiOEwdEVIIe+BX2t9YU9UyrOKLzJd+0CHTB2Eboyys=;
        b=n88YjdNXUW4qqWqdFmnDKY5FTxbhFbYlKecayAiWxa2hY7E4cyOL2lvySjrerXr6Iu
         514AwKwvaqRkker+Ravs3+TiJumQgsTi/jzDYBU6GfJGNWcKnrVtbwSyHHIgRzMkozNI
         iZr9IJL/+TsNXW9YpBxMS9o2D8CwLAYymcKUt/ob1N17ao2GcdaxVxRjUDe88XCNyYH0
         dKI5pcxjOzcqEfd8sY2wmkVCseZ2j6DlPx63Vo5a9qdQ/Ea4VpJQidMDbxvK3VewgACc
         4oGFZv9Rz4I0ZnqF+v6BX6qad8+0AgNV4GmfUE6pjdn8AlduitcQbbwTP+IO9jkoZ92T
         5kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759175866; x=1759780666;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOiOEwdEVIIe+BX2t9YU9UyrOKLzJd+0CHTB2Eboyys=;
        b=ioGPyvVJUtYFBX8R8wSjqWX1h7DxYwwIKMNylNs1W8QSevSm+lMnGAl8Zd3SftnOWT
         ar+j3XZudMdfZaW8y4rU2nAdJn9JiUufflCpf32NFinrVW/OJNNfg9eGjkuFwmcdnNCc
         CFLmaMvlOTkqpKt6xeND6WTDQc62B8feL8vqYZ6GNMj8ioFhOjycqucK9Zk5jcex7jUb
         es4V/E2MqgoubZoOIEiuYZ0eAK2absw4QlrWkaA7K3A7Ih67kh4LcnbsPD2G/Qwmm2D0
         eP+A4SAIwh6fd3mUpHzhlh+rBl2gbzMWbhik49yzMTamOb/FOIUcWnUhzHmsxiydXrn9
         IZOA==
X-Gm-Message-State: AOJu0YynxtYbamQHtRPTFIiUYVYvndepgoyOrAs1W5UQjR//NPhtRNlg
	XQ9CvJHElercrHUJPzVYC+RS7PfMDMre4+nak4eoz2pigItZbyNREcksGD53movDPA==
X-Gm-Gg: ASbGncvk3eKWAiQTR8A9qE9m9m1ejo/YeT0SKy8+2cXua/DbZZkU5NBmSzAz1AiA741
	z+j3oqNUTx6VaNE45Pl7Qqwhx7lpq/huki/gWH6w0QP8fO4acqGoCWbksp0rIw7Q/2x5ffQYxie
	HcwZ45I9sJdLLWLGoCgIbsauHbC4c7zzJrTgyEAwsxoSz4ZDYjXtlU7qA9QVI9fyEz7tH128jYF
	FwWQ9Xw3d1kVrm8qoLWsnXFJYmUV2fdsGh6sol14VSFPefsIjh3/1IpGXH5VKMFIcFIZgswTbcj
	O+kCJbtmKFt/PQrWxuzXEBsa6X+HLVrslIrlPrPh3QsKYma63v5t1QiGuxhdOztChwNDWT86zhK
	sx+E3sN4NtgfYqv8QHZXIhGvN0oxL1eQFqtMWwLRQc8BNkQqHhPZY4XacKc3xpAGQl8NfMZtgCg
	==
X-Google-Smtp-Source: AGHT+IE3kbV3lnUAbeVo87YFkQpxhK8UcbVtkpKbpU+wAfqg1zn+LgU/CyfWAyi+v2zOnuBVGxcXPg==
X-Received: by 2002:a17:903:2348:b0:25b:ce96:7109 with SMTP id d9443c01a7336-28e640e487emr221805ad.3.1759175865356;
        Mon, 29 Sep 2025 12:57:45 -0700 (PDT)
Received: from google.com (21.168.124.34.bc.googleusercontent.com. [34.124.168.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69be6cdsm138179795ad.125.2025.09.29.12.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 12:57:44 -0700 (PDT)
Date: Mon, 29 Sep 2025 19:57:39 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Daniel Mentz <danielmentz@google.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, Mostafa Saleh <smostafa@google.com>,
	Liviu Dudau <liviu.dudau@arm.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>
Subject: Re: [PATCH 1/2] iommu/io-pgtable-arm: Implement .iotlb_sync_map
 callback
Message-ID: <aNrks8eXTfHyVhKl@google.com>
References: <20250927223953.936562-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250927223953.936562-1-danielmentz@google.com>

On Sat, Sep 27, 2025 at 10:39:52PM +0000, Daniel Mentz wrote:
> On systems with a non-coherent SMMU, the CPU must perform cache
> maintenance operations (CMOs) after updating page table entries (PTEs).
> This ensures that the SMMU reads the latest version of the descriptors
> and not stale data from memory.
> 
> This requirement can lead to significant performance overhead,
> especially when mapping long scatter-gather lists where each sg entry
> maps into an iommu_map() call that only covers 4KB of address space.
> 
> In such scenarios, each small mapping operation modifies a single 8-byte
> PTE but triggers a cache clean for the entire cache line (e.g., 64
> bytes). This results in the same cache line being cleaned repeatedly,
> once for each PTE it contains.
> 
> A more efficient implementation performs the cache clean operation only
> after updating all descriptors that are co-located in the same cache
> line. This patch introduces a mechanism to defer and batch the cache
> maintenance:
> 
> A new boolean flag, defer_sync_pte, is added to struct io_pgtable_cfg.
> When this flag is set, the arm-lpae backend will skip the cache sync
> operation for leaf entries within its .map_pages implementation.
> 
> A new callback, .iotlb_sync_map, is added to struct io_pgtable_ops.
> After performing a series of mapping operations, the caller is
> responsible for invoking this callback for the entire IOVA range. This
> function then walks the page tables for the specified range and performs
> the necessary cache clean operations for all the modified PTEs.
> 
> This allows for a single, efficient cache maintenance operation to cover
> multiple PTE updates, significantly reducing overhead for workloads that
> perform many small, contiguous mappings.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/io-pgtable-arm.c | 66 +++++++++++++++++++++++++++++++++-
>  include/linux/io-pgtable.h     |  7 ++++
>  2 files changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 7e8e2216c294..a970eefb07fb 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -353,7 +353,7 @@ static void __arm_lpae_init_pte(struct arm_lpae_io_pgtable *data,
>  	for (i = 0; i < num_entries; i++)
>  		ptep[i] = pte | paddr_to_iopte(paddr + i * sz, data);
>  
> -	if (!cfg->coherent_walk)
> +	if (!cfg->coherent_walk && !cfg->defer_sync_pte)
>  		__arm_lpae_sync_pte(ptep, num_entries, cfg);
>  }
>  
> @@ -582,6 +582,69 @@ static int arm_lpae_map_pages(struct io_pgtable_ops *ops, unsigned long iova,
>  	return ret;
>  }
>  
> +static int __arm_lpae_iotlb_sync_map(struct arm_lpae_io_pgtable *data, unsigned long iova,
> +			      size_t size, int lvl, arm_lpae_iopte *ptep)
> +{
> +	struct io_pgtable *iop = &data->iop;
> +	size_t block_size = ARM_LPAE_BLOCK_SIZE(lvl, data);
> +	int ret = 0, num_entries, max_entries;
> +	unsigned long iova_offset, sync_idx_start, sync_idx_end;
> +	int i, shift, synced_entries = 0;
> +
> +	shift = (ARM_LPAE_LVL_SHIFT(lvl - 1, data) + ARM_LPAE_PGD_IDX(lvl - 1, data));
> +	iova_offset = iova & ((1ULL << shift) - 1);
> +	sync_idx_start = ARM_LPAE_LVL_IDX(iova, lvl, data);
> +	sync_idx_end = (iova_offset + size + block_size - ARM_LPAE_GRANULE(data)) >>
> +		ARM_LPAE_LVL_SHIFT(lvl, data);
> +	max_entries = arm_lpae_max_entries(sync_idx_start, data);
> +	num_entries = min_t(unsigned long, sync_idx_end - sync_idx_start, max_entries);
> +	ptep += sync_idx_start;
> +
> +	if (lvl < (ARM_LPAE_MAX_LEVELS - 1)) {
> +		for (i = 0; i < num_entries; i++) {
> +			arm_lpae_iopte pte = READ_ONCE(ptep[i]);
> +			unsigned long synced;
> +
> +			WARN_ON(!pte);
> +
> +			if (iopte_type(pte) == ARM_LPAE_PTE_TYPE_TABLE) {
> +				int n = i - synced_entries;
> +
> +				if (n) {
> +					__arm_lpae_sync_pte(&ptep[synced_entries], n, &iop->cfg);
> +					synced_entries += n;
> +				}
> +				ret = __arm_lpae_iotlb_sync_map(data, iova, size, lvl + 1,
> +								iopte_deref(pte, data));

I think we must check the returned value here and break the loop on
error. Otherwise, we might burry a failure by continuing the loop.
We should add something like:

if (ret)
	break;

> +				synced_entries++;
> +			}
> +			synced = block_size - (iova & (block_size - 1));
> +			size -= synced;
> +			iova += synced;
> +		}
> +	}
> +
> +	if (synced_entries != num_entries)
> +		__arm_lpae_sync_pte(&ptep[synced_entries], num_entries - synced_entries, &iop->cfg);
> +
> +	return ret;
> +}
> +
> +static int arm_lpae_iotlb_sync_map(struct io_pgtable_ops *ops, unsigned long iova,
> +			    size_t size)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_cfg *cfg = &data->iop.cfg;
> +	arm_lpae_iopte *ptep = data->pgd;
> +	int lvl = data->start_level;
> +	long iaext = (s64)iova >> cfg->ias;
> +
> +	WARN_ON(!size);
> +	WARN_ON(iaext);
> +
> +	return __arm_lpae_iotlb_sync_map(data, iova, size, lvl, ptep);
> +}
> +
>  static void __arm_lpae_free_pgtable(struct arm_lpae_io_pgtable *data, int lvl,
>  				    arm_lpae_iopte *ptep)
>  {
> @@ -949,6 +1012,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  	data->iop.ops = (struct io_pgtable_ops) {
>  		.map_pages	= arm_lpae_map_pages,
>  		.unmap_pages	= arm_lpae_unmap_pages,
> +		.iotlb_sync_map	= cfg->coherent_walk ? NULL : arm_lpae_iotlb_sync_map,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
>  		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
>  		.pgtable_walk	= arm_lpae_pgtable_walk,
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index 138fbd89b1e6..c4927dbc0f61 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -57,6 +57,9 @@ struct iommu_flush_ops {
>   * @oas:           Output address (paddr) size, in bits.
>   * @coherent_walk  A flag to indicate whether or not page table walks made
>   *                 by the IOMMU are coherent with the CPU caches.
> + * @defer_sync_pte A flag to indicate whether pte sync operations for leaf
> + *                 entries shall be skipped during calls to .map_pages. A
> + *                 subsequent call to .iotlb_sync_map is required.
>   * @tlb:           TLB management callbacks for this set of tables.
>   * @iommu_dev:     The device representing the DMA configuration for the
>   *                 page table walker.
> @@ -110,6 +113,7 @@ struct io_pgtable_cfg {
>  	unsigned int			ias;
>  	unsigned int			oas;
>  	bool				coherent_walk;
> +	bool				defer_sync_pte;
>  	const struct iommu_flush_ops	*tlb;
>  	struct device			*iommu_dev;
>  
> @@ -204,6 +208,7 @@ struct arm_lpae_io_pgtable_walk_data {
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
>   * @pgtable_walk: (optional) Perform a page table walk for a given iova.
> + * @iotlb_sync_map: Sync ptes (Required for non-coherent page table walks)
>   *
>   * These functions map directly onto the iommu_ops member functions with
>   * the same names.
> @@ -222,6 +227,8 @@ struct io_pgtable_ops {
>  				    unsigned long iova, size_t size,
>  				    unsigned long flags,
>  				    struct iommu_dirty_bitmap *dirty);
> +	int (*iotlb_sync_map)(struct io_pgtable_ops *ops, unsigned long iova,
> +			      size_t size);
>  };
>  
>  /**
> -- 
> 2.51.0.570.gb178f27e6d-goog
> 

Thanks,
Praan
