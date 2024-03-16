Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584961C280
	for <iommu@lists.linux.dev>; Sat, 16 Mar 2024 18:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710612948; cv=none; b=Q3nuIT7IYGRHIUioMF51QHwx+EZYkWs3GBRq+faJkxozfiaCjVAs0Lk2hf/eeEy4vc27djhUZNH6uUk0BmkvCV8z4fm46loj+yjITC1dKvlZtjh37kBuCjD3bF69Z9KQ98IPCZzofkRd0u6rPlJPWI7BrewHVvRSy3z4eSchwng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710612948; c=relaxed/simple;
	bh=ev1HtT5dgYPbzyvqfFCfe3PhfTYNlQSkRFxKxDOZuIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oBKMr4mSWbfgWJZvrLUxTVu45PxdVCKMojeFxafv40p3sAePkdTHGM0DQIDT+gOxDfLmHjZEFUxD6vsj+iYtQzeSAOOxw/bRwyFkQv38f+oev8MI9nVlDTueP8/H7B+Lu+ra0Alle7NP0Yd8wqzmj5wkOOHtE23v3ZFX0QlwLX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eVWZKI0f; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--moritzf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eVWZKI0f"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-610b7e95152so4800537b3.0
        for <iommu@lists.linux.dev>; Sat, 16 Mar 2024 11:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710612945; x=1711217745; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aXFSQ++Ub55Rlf8aCL3bodnfyEF61EjD4/9Gb9NGlM=;
        b=eVWZKI0fxu4MDNUrpE8UTsNpz6AvH+o5cQEl+RQkFoB3k6lKqWMZquP7fJcY2RXsHi
         50TG+pIczlkibRx5xiOmbCSwNbGu5Ww3DtDAoIS/Wc0jjPeZ9uR9VDYqUG758IKZYXAP
         QT/h8mZzotQFYmFCFfsXIpgXhWDvTg8nkQOuxcZSv9++PPXOiJMCy7f9LFaPePtzd2yV
         6DfoWoywenzkN3yXqEj1ihzGBs5WgTbYkVxT9JXFbInc9wkTUF12PbUS9bn5KqS8tGIw
         eYHhWJzEN9hD5FimuqnzIlLvU8aBBKIZnu493KQRsP0Wzv+NsiBv48xgHh0ALC4SkKT0
         lJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710612945; x=1711217745;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5aXFSQ++Ub55Rlf8aCL3bodnfyEF61EjD4/9Gb9NGlM=;
        b=rtHPorDRDzs41K1HfCq4zLL0HgcU2GP6iKGPtbeoMAyrdNv7yWtNtCnc781PbbPHKA
         1BSLgZyR9BalaKi985wOzXpGuVpOBz0FkKdh+rZtsht/toGBVUowKFvYPe8ZuCrZkzAa
         ykzFrAhdlHOfpRa9H2coL2XCgeXpm+oCLnmGis5IxVVWoXd9eGBBIL6wDR8m2kPJr+7w
         ZSN+87ViewzoJcc86Kk4AMwreCPuIJ1i84qKaKdhMfsGDIoi69bymjhnGCsyMcG6GKWz
         9tLwz0hDLU3twDw8XaMFraSBoqatxt9FtEYGJavNN9Tjho573C9dQjVHkw4hKrTbv83+
         ZAGw==
X-Gm-Message-State: AOJu0Yw7pmxR6HBmGR1mPvYnSd8zRKTB7YH1yijXELR+pSVIEx70dhoA
	BZl+DQEWkHZ5X/1TXJ7ZsjvuCHk+jdGRe1IZqa2ZGoJV6RLHSHWKYUrRUXKoE6pg6cTz5Is7jVC
	0KjrxPg==
X-Google-Smtp-Source: AGHT+IH+Rvxyk7aSx1/W7pYZK7zqyyCzMwEBBdvr7Mv+uONRopm//oUHb3l5Sm+tykzNniQuZnRvBeLp/Tvp
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a05:690c:a15:b0:60c:ca8a:4c10 with SMTP id
 cg21-20020a05690c0a1500b0060cca8a4c10mr2046847ywb.2.1710612945476; Sat, 16
 Mar 2024 11:15:45 -0700 (PDT)
Date: Sat, 16 Mar 2024 18:15:44 +0000
In-Reply-To: <6-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <0-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com> <6-v5-9a37e0c884ce+31e3-smmuv3_newapi_p2_jgg@nvidia.com>
Message-ID: <e2tgk4mlnq6ef5sb5ngh35o73iy4xmxzfcy43ouewj4cfzkhhp@cq2drrbkzcxl>
Subject: Re: [PATCH v5 06/27] iommu/arm-smmu-v3: Consolidate clearing a CD
 table entry
From: Moritz Fischer <moritzf@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>, 
	linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>, 
	Will Deacon <will@kernel.org>, Eric Auger <eric.auger@redhat.com>, 
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Moritz Fischer <mdf@kernel.org>, 
	Michael Shavit <mshavit@google.com>, Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev, 
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Mon, Mar 04, 2024 at 07:43:54PM -0400, Jason Gunthorpe wrote:
> A cleared entry is all 0's. Make arm_smmu_clear_cd() do this sequence.

> If we are clearing an entry and for some reason it is not already
> allocated in the CD table then something has gone wrong.

> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  2 +-
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++++++++++-----
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  2 ++
>   3 files changed, 18 insertions(+), 6 deletions(-)

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c  
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 347c2fdd865c1a..bb9bb6fd7914ce 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -558,7 +558,7 @@ void arm_smmu_sva_remove_dev_pasid(struct  
> iommu_domain *domain,

>   	mutex_lock(&sva_lock);

> -	arm_smmu_write_ctx_desc(master, id, NULL);
> +	arm_smmu_clear_cd(master, id);

>   	list_for_each_entry(t, &master->bonds, list) {
>   		if (t->mm == mm) {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c  
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 237fd6d92c880b..3fb4a1523d1d3f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1303,6 +1303,19 @@ static void arm_smmu_write_cd_entry(struct  
> arm_smmu_master *master, int ssid,
>   	arm_smmu_write_entry(&cd_writer.writer, cdptr->data, target->data);
>   }

> +void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid)
> +{
> +	struct arm_smmu_cd target = {};
> +	struct arm_smmu_cd *cdptr;
> +
> +	if (!master->cd_table.cdtab)
> +		return;
> +	cdptr = arm_smmu_get_cd_ptr(master, ssid);
> +	if (WARN_ON(!cdptr))
> +		return;
> +	arm_smmu_write_cd_entry(master, ssid, cdptr, &target);
> +}
> +
>   int arm_smmu_write_ctx_desc(struct arm_smmu_master *master, int ssid,
>   			    struct arm_smmu_ctx_desc *cd)
>   {
> @@ -2702,9 +2715,7 @@ static int arm_smmu_attach_dev(struct iommu_domain  
> *domain, struct device *dev)
>   	case ARM_SMMU_DOMAIN_S2:
>   		arm_smmu_make_s2_domain_ste(&target, master, smmu_domain);
>   		arm_smmu_install_ste_for_dev(master, &target);
> -		if (master->cd_table.cdtab)
> -			arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID,
> -						      NULL);
> +		arm_smmu_clear_cd(master, IOMMU_NO_PASID);
>   		break;
>   	}

> @@ -2752,8 +2763,7 @@ static int arm_smmu_attach_dev_ste(struct device  
> *dev,
>   	 * arm_smmu_domain->devices to avoid races updating the same context
>   	 * descriptor from arm_smmu_share_asid().
>   	 */
> -	if (master->cd_table.cdtab)
> -		arm_smmu_write_ctx_desc(master, IOMMU_NO_PASID, NULL);
> +	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
>   	return 0;
>   }

> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h  
> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 7078ed569fd4d3..87a7b57f566fbc 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -749,6 +749,8 @@ extern struct xarray arm_smmu_asid_xa;
>   extern struct mutex arm_smmu_asid_lock;
>   extern struct arm_smmu_ctx_desc quiet_cd;

> +void arm_smmu_clear_cd(struct arm_smmu_master *master, ioasid_t ssid);
> +
>   int arm_smmu_write_ctx_desc(struct arm_smmu_master *smmu_master, int  
> ssid,
>   			    struct arm_smmu_ctx_desc *cd);
>   void arm_smmu_tlb_inv_asid(struct arm_smmu_device *smmu, u16 asid);
> --
> 2.43.2


Reviewed-by: Moritz Fischer <moritzf@google.com>
