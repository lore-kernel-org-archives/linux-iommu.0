Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C54266B0
	for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383307; cv=none; b=aA4fcPxG+fuDAGIHovkyR96l9j9UcLUwCYJUqhDO2CYZrP9ChbXAa0FSQgDk/JDY36ImSbj9pb7toNFNQkkOnsqLL3y8zQNlwvy9XvbRtvVla1ZNvbHHju1c6pKoO7cIHjl3Yir3zx+d9zvcOVIlzKAEdTeLILyqDaOXvJRq/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383307; c=relaxed/simple;
	bh=7CVl5H1qQOxXhKG1WU+PIkycGiH7wufAZU+PlQ2NAB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QLDsuJfJ/xuXMEi6Y6nWwzsuG2Go7lhItJoPgnayQXl/FwfxpDXE7Ia1Vv44zOqLgAuxRxoV1ReD7yyQTbcwz+SuHjyJQ8EBL9/djostNFXvMLhV9j0osdojzLaMz8NfM2xJLyXmZKea+kFulosLCEKvLrOFjPpaZLhR2DtT/8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=LpVJ/boc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LpVJ/boc"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506aa68065eso83133831cf.1
        for <iommu@lists.linux.dev>; Tue, 28 Apr 2026 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777383304; x=1777988104; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j/TU/HoOrpr0P9zaYPr2HqTTv+c29GatSHy85DT1kBg=;
        b=LpVJ/boc4g57DWX+orRq1k/NjkznA4GQLSwLE3vUDRNjiLdlkS6dhs3eo4z4r+FAMg
         bru5XQkOqopU9Hv5amKc8da+bADADijgPsMNMIGCT6TRO4U5vkbZxV8DJ8qHvzfiLDHS
         jGostW64178PeiVRIWC9e7vB5ajfZy00BiOntd7iGAlvTA/hJeZeI3ppdMz6DHhRCOr8
         NtrSYHdTwTF67vZYgnDUTbQekGxYsI1S4dSutQV9NwIWQf/w7c2lJJ6XyBbtNPK4vahw
         kRfI9y1c/I6fIDI2UBy0CSKFqiBpWIxobu/OKA19T1FrhC3kHG4E6PKxJdDJK2Axthq5
         lVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777383304; x=1777988104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j/TU/HoOrpr0P9zaYPr2HqTTv+c29GatSHy85DT1kBg=;
        b=HZ446reiQYP/UO8/lTZi2ZBHg17ZoaXm7erGcgSmn9OczbkbtKQO7B4/vVQMtapxR/
         SOHASQobSq3SPdasVKcTqjQoogOgqnemTeZ9nFTRlWJaGe3+oBjUF3p3/liiJPtlKPZL
         gj7VxlB/ehK8yXJCG6r1XUM946VvToazaK6ie5xdb1lUkEhz6w4Kd0jfqU6HA2Wlwvt5
         JYQ6IGDd3cBiXraQybq/Arlbe9fYEfr+/YNxRAlqc7dngfHCwJeUXGFu7W0B1qzz/NWM
         2K3jaJIhr2QJ+5g3urMz8GwuhPAUsnj2kycvzoM0FZ7blVSEHEza0UOyB/ZfTlS3rtYs
         nIFw==
X-Forwarded-Encrypted: i=1; AFNElJ8RFPN6rLPv07kI11HWcQLfm4hmkn/dRMqK9a0YHE+ohFNJyquZFd4Xy7eE8+/L9ViKAbSJAg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyucrzsjjKjSIcDu2vIeUaGD5xYpR8KWOiiC5BGvpamb/e/2tWl
	eI70QuOdsE+R15uUXCmyK6eApR08D3KwT5pBx7klCaNmfYCsg12acox/E2rJJStYEsQ=
X-Gm-Gg: AeBDietkU9RWKV+lz0Me9yNK/N8MueyJhDudFmhoRwCG6irZbIngt37506R1jYTaKr3
	FwlhOiaRmKMMgYEBMudChBdo5ZDfP2Tlgpi4YMsPYwZvtCCgiDLI3oNHioZmHXLTreWVm/7rypk
	051Hw+IWVaCnmOvrT/zfdeM46WO+hQ7pP6GXR8YUCxzd1NfWshi7tnDxd4Cok8LSOjxaPWlt8s4
	h5CFtdUoY3T1bqKu+Fkqmc0Vc2+BVx3jjuuQovSpfGPrIgK5CH1gG1jr9rr198fHHpIMjWy6WhA
	UKrs/TqJV0dY3E3LGEC2/QXUvTjpEwDStN95U0AHiphhpMh12m9AP7XuiAcLa3cKbJJOuKCc86R
	jySz2lksjMeoD4k39wJcmahx/X/M9awHg/I46DJkX8cGo/zVrR24u5pk+MIh0nnh/mFSxgYosMa
	iz/eZQYuKdOoQW81tpUmL5j7ir9AC57Su2Nv2sPNrG6Sfjpnun7OxULzh6QPzekFQshm9sbDNLE
	dqfi06pKIKA7HYg
X-Received: by 2002:a05:622a:311:b0:50f:bd79:2643 with SMTP id d75a77b69052e-5100e1b5b9cmr36699661cf.34.1777383304257;
        Tue, 28 Apr 2026 06:35:04 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5100da647d9sm18237481cf.9.2026.04.28.06.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 06:35:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wHiab-0000000AiFH-3nWV;
	Tue, 28 Apr 2026 10:35:01 -0300
Date: Tue, 28 Apr 2026 10:35:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: fangyu.yu@linux.alibaba.com
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	tjeznach@rivosinc.com, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, vasant.hegde@amd.com, anup@brainfault.org,
	atish.patra@linux.dev, skhawaja@google.com, guoren@kernel.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/11] iommu/riscv: Add domain_alloc_paging_flags for
 second-stage domain
Message-ID: <20260428133501.GE849557@ziepe.ca>
References: <20260428131359.34872-1-fangyu.yu@linux.alibaba.com>
 <20260428131359.34872-7-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428131359.34872-7-fangyu.yu@linux.alibaba.com>

On Tue, Apr 28, 2026 at 09:13:54PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Replace .domain_alloc_paging with .domain_alloc_paging_flags so callers
> can pass allocation flags to select the appropriate page-table type.
> 
> When IOMMU_HWPT_ALLOC_NEST_PARENT or IOMMU_HWPT_ALLOC_DIRTY_TRACKING is
> set in @flags, allocate a second-stage (iohgatp) domain.
> 
> When @flags is 0 the behaviour is identical to the previous
> domain_alloc_paging: first-stage (iosatp) domain.
> 
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/riscv/iommu.c | 66 ++++++++++++++++++++++++++++---------
>  1 file changed, 51 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 5dadf6d09139..0c13430ecc7f 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -1255,23 +1255,50 @@ static const struct iommu_domain_ops riscv_iommu_paging_domain_ops = {
>  	.flush_iotlb_all = riscv_iommu_iotlb_flush_all,
>  };
>  
> -static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> +static struct iommu_domain *riscv_iommu_domain_alloc_paging_flags(
> +		struct device *dev, u32 flags,
> +		const struct iommu_user_data *user_data)
>  {
> +	const bool second_stage = flags &
> +		(IOMMU_HWPT_ALLOC_NEST_PARENT | IOMMU_HWPT_ALLOC_DIRTY_TRACKING);

This isn't the right logic, you should follow the switch/case design
from other drivers.

>  	struct pt_iommu_riscv_64_cfg cfg = {};
>  	struct riscv_iommu_domain *domain;
>  	struct riscv_iommu_device *iommu;
>  	int ret;
>  
> +	if (user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
>  	iommu = dev_to_iommu(dev);
> -	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57) {
> -		cfg.common.hw_max_vasz_lg2 = 57;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48) {
> -		cfg.common.hw_max_vasz_lg2 = 48;
> -	} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39) {
> -		cfg.common.hw_max_vasz_lg2 = 39;
> +
> +	if (second_stage) {
> +		/*
> +		 * Second-stage (iohgatp) page table for KVM VFIO device
> +		 * pass-through and dirty tracking. The GPA space is 2 bits
> +		 * wider than the corresponding first-stage VA space (x4 root
> +		 * page table), so hw_max_vasz_lg2 values are 41/50/59.
> +		 */
> +		if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV57X4) {
> +			cfg.common.hw_max_vasz_lg2 = 59;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV48X4) {
> +			cfg.common.hw_max_vasz_lg2 = 50;
> +		} else if (iommu->caps & RISCV_IOMMU_CAPABILITIES_SV39X4) {
> +			cfg.common.hw_max_vasz_lg2 = 41;
> +		} else {
> +			dev_err(dev, "cannot find supported second-stage page table mode\n");
> +			return ERR_PTR(-ENODEV);

Do not make log messages for failing system calls.

Jason
