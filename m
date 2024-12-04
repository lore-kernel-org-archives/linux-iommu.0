Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAFB18595B
	for <iommu@lists.linux.dev>; Wed,  4 Dec 2024 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733307671; cv=none; b=ZQ1eD7u6HIYd0KRHBLgkBBAC+uGUlwoJqbZEQtXwAVbVlZEyAwJC8I5heVfNRpWVZ8zH51DkS6RUv83FfyhkwNlp7fLYxMZ2HiMV9Dqyh4ETgBAN9c65I9EWRvVwvhcj+3XeNWEcZIkmjicx3GIJvVQ5PZ6MIvZc2lwUdOdZXH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733307671; c=relaxed/simple;
	bh=8OglyKPuM+rLJ9GvllSkUBKAWUM5kMNHR+1UXlOULOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odmVGNxf5rVd92g/nMKQJj5jh+lkCMx8dVxOmq7lcq6heR201XMoEMnymYdlu4MG1+8dGEnNp5m4j6+gdvpm/bh85WgM6mjpiMCIxYoPu1JXOh+uX1IO61XlzJtzYb1SQdaeTLv7rOBYmA9wGlmu2iOxd1TYrbDODIwC/6IVywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pg80px7P; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pg80px7P"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4349338add3so38715e9.0
        for <iommu@lists.linux.dev>; Wed, 04 Dec 2024 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733307667; x=1733912467; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkYLTBgm995LkjvCxemjC6Jocdx1o/Bh1C0vkU2Fy7M=;
        b=Pg80px7PmLt6XvJ8jritHPuXVa+eLyUleNLEo7x2r2zQPXYUZMxESHJBFNuTLjPprN
         1cGQ6FM/0df0wn2/yUaphQ7PPeaEfvumPxoNCLtG2iWGL9PZ5bnyfWfM5Bci3iZKPckk
         WUsQPyhN42IBdXCjnnQyvRXm7rKWAapvUI33eQSxjsGEq4UAhndrk9awZuHEK6QkfK3B
         eDdQm3ZwC0uup9H1ukRKkNqhIsheYUyPcdEj0wJ+Ew1tDGW6/J1LunwEJCmP3F4RWdvF
         7OcUZy1QIVCJUKwcq1fTDdihhAkKJ7Cqg7ICG6kNgf/oCy+AFUuHJHxEAhRNUmryyw1r
         km5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733307667; x=1733912467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkYLTBgm995LkjvCxemjC6Jocdx1o/Bh1C0vkU2Fy7M=;
        b=RM31kS+7BDaV16LojH8JMc7TYRBD8hXwi7An4GAmrFrX+KmE4yjBPD+j6f7UVc0/J2
         7P3H4rNOCQYKrkjQ3k363nqzswfFIIazMDkmLLNduRg92Nr0825BqRcFLvqxEMcdP0lr
         bKUVKfKD1bNLeTo5ykD08NIZmA/itziKTEru9uYBqy5DX3VUMbMHkmolplL4gjxX6yTe
         f/bwzINP5XvK9VWoR+gyZgSkv3u9hyLM2EOMxyhN7kRQ/0h/9aBSf0vInykyguwGvyHC
         OkTxDmVLw9X5lTvFGjMCIi7ailELjzyg5Us+OJi/LGzpfcQFbHyL6Ew/naQbNuw7ci5R
         P3VA==
X-Gm-Message-State: AOJu0Yy21M4UCECiHEgcG8+n7zSJluDVcIGAMaQ48H2/OcSiAL72QIlh
	135rq+LzM5pUxA0JeVN+Ajn9dWIwzNa9GjSdVjBTyKSgjUoHASxJNXRMDZ98Xw==
X-Gm-Gg: ASbGncsaRk0Ey0yonb/ZJW3xbvcQa+7leXZXsjDKuhQQwXsnU+zw7QsBwwzv0wap3Vs
	vd7b9vmIa04vpQG2afrvt2YM7ckjgCgDmgLrtw4wDPsbc7yysgo+fTtHZ3Bfmtdq6XWZ7uhIHCS
	559GVdpaXUVec72Sw8tND8t0IK4jUlVNitPi7Ac18Tnf53gTSyKZ0+dy9SxDqLVlP8Du3wcW2dt
	v0PiYAE/kyWoB9061Kq7qczgPRdE/SVueNupKR/+Occ2MzyBaBTFk506Jo++L7bUjTOxDDXifTR
	ASLwroW8efo1
X-Google-Smtp-Source: AGHT+IE7T8d7TZw5PeKMBFpYLBTez7iD+72RMF2IGZ5bXAf6OdVX2raWOJrJNuhpXSW4NzSb1otqdQ==
X-Received: by 2002:a05:600c:5113:b0:431:43a1:4cac with SMTP id 5b1f17b1804b1-434d528f647mr784575e9.3.1733307666792;
        Wed, 04 Dec 2024 02:21:06 -0800 (PST)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d52cb6e1sm19021945e9.37.2024.12.04.02.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:21:06 -0800 (PST)
Date: Wed, 4 Dec 2024 10:21:02 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Clark <robdclark@chromium.org>, Joerg Roedel <joro@8bytes.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 3/4] iommu/io-pgtable-arm: Add way to debug pgtable
 walk
Message-ID: <Z1AtDgLD0SDUxDHl@google.com>
References: <20241028213146.238941-1-robdclark@gmail.com>
 <20241028213146.238941-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213146.238941-4-robdclark@gmail.com>

Hi Rob,

On Mon, Oct 28, 2024 at 02:31:39PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add an io-pgtable method to walk the pgtable returning the raw PTEs that
> would be traversed for a given iova access.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/io-pgtable-arm.c | 25 +++++++++++++++++++++++++
>  include/linux/io-pgtable.h     | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 88b128c77893..6739e1fa54ec 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -762,6 +762,30 @@ static phys_addr_t arm_lpae_iova_to_phys(struct io_pgtable_ops *ops,
>  	return iopte_to_paddr(d.pte, data) | iova;
>  }
>  
> +static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
> +			      arm_lpae_iopte *ptep, size_t size)
> +{
> +	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
> +	data->ptes[data->level++] = *ptep;
> +	return 0;
> +}
> +
> +static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
> +				 void *wd)
> +{
> +	struct arm_lpae_io_pgtable *data = io_pgtable_ops_to_data(ops);
> +	struct io_pgtable_walk_data walk_data = {
> +		.data = wd,
> +		.visit = visit_pgtable_walk,
> +		.addr = iova,
> +		.end = iova + 1,
> +	};
> +
> +	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;

I think this is a bit fragile, as it only works because the walk spans
one address, otherwise it breaks, the visitor will keep incrementing
the level. IMO, this should be removed, and the visitor already knows
the level as it's passed as an argument, so something like this:

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 6739e1fa54ec..bc73f9edae8a 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -766,7 +766,8 @@ static int visit_pgtable_walk(struct io_pgtable_walk_data *walk_data, int lvl,
 			      arm_lpae_iopte *ptep, size_t size)
 {
 	struct arm_lpae_io_pgtable_walk_data *data = walk_data->data;
-	data->ptes[data->level++] = *ptep;
+	data->ptes[lvl] = *ptep;
+	data->level = lvl + 1;
 	return 0;
 }
 
@@ -781,8 +782,6 @@ static int arm_lpae_pgtable_walk(struct io_pgtable_ops *ops, unsigned long iova,
 		.end = iova + 1,
 	};
 
-	((struct arm_lpae_io_pgtable_walk_data *)wd)->level = 0;
-
 	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
 }
 
Thanks,
Mostafa
> +
> +	return __arm_lpae_iopte_walk(data, &walk_data, data->pgd, data->start_level);
> +}
> +
>  static int io_pgtable_visit(struct arm_lpae_io_pgtable *data,
>  			    struct io_pgtable_walk_data *walk_data,
>  			    arm_lpae_iopte *ptep, int lvl)
> @@ -937,6 +961,7 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg *cfg)
>  		.unmap_pages	= arm_lpae_unmap_pages,
>  		.iova_to_phys	= arm_lpae_iova_to_phys,
>  		.read_and_clear_dirty = arm_lpae_read_and_clear_dirty,
> +		.pgtable_walk	= arm_lpae_pgtable_walk,
>  	};
>  
>  	return data;
> diff --git a/include/linux/io-pgtable.h b/include/linux/io-pgtable.h
> index b1ecfc3cd5bc..d7bfbf351975 100644
> --- a/include/linux/io-pgtable.h
> +++ b/include/linux/io-pgtable.h
> @@ -178,12 +178,26 @@ struct io_pgtable_cfg {
>  	};
>  };
>  
> +/**
> + * struct arm_lpae_io_pgtable_walk_data - information from a pgtable walk
> + *
> + * @ptes:     The recorded PTE values from the walk
> + * @level:    The level of the last PTE
> + *
> + * @level also specifies the last valid index in @ptes
> + */
> +struct arm_lpae_io_pgtable_walk_data {
> +	u64 ptes[4];
> +	int level;
> +};
> +
>  /**
>   * struct io_pgtable_ops - Page table manipulation API for IOMMU drivers.
>   *
>   * @map_pages:    Map a physically contiguous range of pages of the same size.
>   * @unmap_pages:  Unmap a range of virtually contiguous pages of the same size.
>   * @iova_to_phys: Translate iova to physical address.
> + * @pgtable_walk: (optional) Perform a page table walk for a given iova.
>   *
>   * These functions map directly onto the iommu_ops member functions with
>   * the same names.
> @@ -197,6 +211,7 @@ struct io_pgtable_ops {
>  			      struct iommu_iotlb_gather *gather);
>  	phys_addr_t (*iova_to_phys)(struct io_pgtable_ops *ops,
>  				    unsigned long iova);
> +	int (*pgtable_walk)(struct io_pgtable_ops *ops, unsigned long iova, void *wd);
>  	int (*read_and_clear_dirty)(struct io_pgtable_ops *ops,
>  				    unsigned long iova, size_t size,
>  				    unsigned long flags,
> -- 
> 2.47.0
> 
