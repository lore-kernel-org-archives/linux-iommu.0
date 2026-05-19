Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6954A34D90C
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 21:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779227223; cv=none; b=hBWgml1SjG5xNr9mePqYTypgXNibVd/I0Zr5Vx/e52ARdcmZ2KXc7qIHq8NYnpiSWI1GG4odgZWMnZtV5myoTuBKD890MEXT3cdCkNhRU9K/WUe74GbKExUaxWYsoAvBtrvfBBPNvzdQQJWl3UzmozSB/bBTmyMbKKhm+cf7ick=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779227223; c=relaxed/simple;
	bh=DCkyr9NtsJLBWZq3wk2SnGnCCJ4TkeILf1lpkZ541iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVKJ6qtHiEs65YZVLhLi4Ch2RsfBdx84DTmhXjzOi3AwQxDuKJAiXNXUydn973EC6PNHSGFwLD/j0R2NZaxHmXWTtfrHi7rZZ4AfAfp64VELdFbBnp/PbsVQVAjvoF6R6xwFKdiwhAVJxvUD+spHCs3BYAu5r8U7epB7Ui3cDzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hdu7yhpk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hdu7yhpk"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so315ad.0
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 14:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779227222; x=1779832022; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vp86oBF8aR+1e7MjE7s3QB7cLLlWo1cvF/BkIKH08KA=;
        b=hdu7yhpke8dz2y/ylKCtW5P774Y2R5KP/DbWXPYGzqmNIaXTZbblLWlC38YT6e56x8
         WdQxnkcwzhPg6u0hVqKAIxpRPpow1HblZ7v93KTWwVJ/qDZrCnA+a/Cd3CJJ1vWXDgqE
         WuquH7+lCq/d6GaaIeyLJOSniy+tI39gPTAtvJnHe2F+mJD4uZ+xeWfLlF2s4Mq3bYT0
         L1WjOyjqDtEkX4//oPxX5syKaNkbX9GB8eHvr1Op5kGNJbYOasnFCP714CLm//gRgftB
         9TCl6jpjrKEwqnQr5lvWm8apRRZq2DU7GvEWzeOea+mX1UZ+oZEldlNb7sTa0VN2uGXp
         bUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779227222; x=1779832022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vp86oBF8aR+1e7MjE7s3QB7cLLlWo1cvF/BkIKH08KA=;
        b=Otb1Z3GHflniXJirMq6Pr/Vxz2XQELenq4/rVgAhis9jAoheAf2mu1yczMzb6FYBYu
         iof+1u3W/lcqjHE7MnzYENSpUtSz7+zjT7twNPPrMwKUxq+vQUFEbpGmmtPJFkoKPXM0
         yYzI1zPj8I8LLLXqi+SsGsUoCvloUv3K5KqFGi75inyoRAzTZ9RG1PKZ74Dev4ZwXJrT
         YdhwyVsIDtgvAy0LVrTQqrSyjlyuHIc+Qf5khPxWwsm1dqJQAqORvaaJdWGxFc4gzO72
         zdDcVyDDvhbE3zrMH0PaOK6Q4UokvJWDvXydcA7QDRQAxn9CdZ71T/oWoLb9DkZuxaeP
         hxqA==
X-Forwarded-Encrypted: i=1; AFNElJ/DiPyJtJpu9oMMd95uVGlOsbaeNCy9QM3AVVOcNZgvmrCl+LArDrrN7G2uGEHPHoJHcJ2fRg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx5BNrlhrTpikf5BccS1tTSGt6xNeMX8A/IGcpK5kj7qr/veTAW
	EsUAk9KA4SCoaAeB+HGKW4wgOn3CgEa2e2Hux/PoaWAA6+kZEoGu/IcO4z2j1fvheA==
X-Gm-Gg: Acq92OFsSCwlw+xEBY6Zi3hBJB7UAFn7UedJmCNV17eWCmO1eIoWAwPV5a7hy24vGT+
	JFOwy4daYZOyGCbRZNeyJEjyMtFH33LgFYRw3XZzngDpcaGIYsUHiJeaE2CBHRbZtqq2xqdRNdl
	NN8m+BV2g/AyVRUFl864JMw4Mt1ZXvZZR3jARO21+B1yUxwadkSvCrnyHaRLFwdiZMQY3+0q0H5
	1lPVfYJmFdEWglaAxvC62++Nx/jhxJPdDg0VBFYV+h8hILX9kooMTYXyAjh/wf/d6lYQpRffteM
	uEP+s+z8G47ggfvHKqV3YAjTtTXQN9vF7tdGc4u6FS/X6VvnGcCqCHXk97BSZr11CQZYAe8rAKx
	6aV/E0yQcc7kq3hnJq4Ow2Y5YoD7vkvRbJWHuPYrR+sCk8qII8MY4+bBVlX9pCKFKECKoGxRd0Z
	Kjk89fx4vGWyZvDgnklKqJVwgQnzD9CRJ3CiM9LbtBXqg7Qom5o3QZzp9RuWrPa4AR9qb4
X-Received: by 2002:a17:903:1b27:b0:2b4:641a:6b7c with SMTP id d9443c01a7336-2bdb32c45fcmr8185175ad.13.1779227221053;
        Tue, 19 May 2026 14:47:01 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369512424a6sm19959016a91.1.2026.05.19.14.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 14:47:00 -0700 (PDT)
Date: Tue, 19 May 2026 21:46:52 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>,
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH v2 09/16] iommu/vt-d: Restore IOMMU state and reclaimed
 domain ids
Message-ID: <agzaTPROvwVO-3lO@google.com>
References: <20260427175633.1978233-1-skhawaja@google.com>
 <20260427175633.1978233-10-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427175633.1978233-10-skhawaja@google.com>

On Mon, Apr 27, 2026 at 05:56:26PM +0000, Samiullah Khawaja wrote:
> During boot fetch the preserved state of IOMMU unit and if found then
> restore the state.
> 
> - Reuse the root_table that was preserved in the previous kernel.
> - Reclaim the domain ids of the preserved domains for each preserved
>   devices so these are not acquired by another domain.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> ---
>  drivers/iommu/intel/iommu.c      | 55 ++++++++++++++++++++++--------
>  drivers/iommu/intel/iommu.h      |  7 ++++
>  drivers/iommu/intel/liveupdate.c | 57 ++++++++++++++++++++++++++++++++
>  3 files changed, 105 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 68fecd4e57fa..4118a0861f38 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -670,10 +670,17 @@ void dmar_fault_dump_ptes(struct intel_iommu *iommu, u16 source_id,
>  #endif
>  
>  /* iommu handling */
> -static int iommu_alloc_root_entry(struct intel_iommu *iommu)
> +static int iommu_alloc_root_entry(struct intel_iommu *iommu,
> +				  struct iommu_hw_ser *iommu_ser)
>  {
>  	struct root_entry *root;
>  
> +	if (iommu_ser) {
> +		intel_iommu_liveupdate_restore_root_table(iommu, iommu_ser);
> +		__iommu_flush_cache(iommu, iommu->root_entry, ROOT_SIZE);
> +		return 0;
> +	}
> +

Minor nit: I still believe this condition block can be moved into the 
caller? Since the called fetches iommu_ser, it can call this as a stand
alone helper and bypass calling iommu_alloc_root_entry if (iommu_ser).

>  	root = iommu_alloc_pages_node_sz(iommu->node, GFP_ATOMIC, SZ_4K);
>  	if (!root) {
>  		pr_err("Allocating root entry for %s failed\n",
> @@ -992,15 +999,16 @@ static void disable_dmar_iommu(struct intel_iommu *iommu)
>  		iommu_disable_translation(iommu);
>  }
>  
> -static void free_dmar_iommu(struct intel_iommu *iommu)
> +static void free_dmar_iommu(struct intel_iommu *iommu, struct iommu_hw_ser *iommu_ser)
>  {
>  	if (iommu->copied_tables) {
>  		bitmap_free(iommu->copied_tables);
>  		iommu->copied_tables = NULL;
>  	}
>  
> -	/* free context mapping */
> -	free_context_table(iommu);
> +	/* free context mapping if there is no serialized state. */
> +	if (!iommu_ser)
> +		free_context_table(iommu);
>  
>  	if (ecap_prs(iommu->ecap))
>  		intel_iommu_finish_prq(iommu);
> @@ -1611,6 +1619,7 @@ static int copy_translation_tables(struct intel_iommu *iommu)
>  
>  static int __init init_dmars(void)
>  {
> +	struct iommu_hw_ser *iommu_ser = NULL;
>  	struct dmar_drhd_unit *drhd;
>  	struct intel_iommu *iommu;
>  	int ret;
> @@ -1633,8 +1642,12 @@ static int __init init_dmars(void)
>  						   intel_pasid_max_id);
>  		}
>  
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
>  		intel_iommu_init_qi(iommu);
> -		init_translation_status(iommu);
> +
> +		if (!iommu_ser)
> +			init_translation_status(iommu);
>  
>  		if (translation_pre_enabled(iommu) && !is_kdump_kernel()) {
>  			iommu_disable_translation(iommu);
> @@ -1648,7 +1661,7 @@ static int __init init_dmars(void)
>  		 * we could share the same root & context tables
>  		 * among all IOMMU's. Need to Split it later.
>  		 */
> -		ret = iommu_alloc_root_entry(iommu);
> +		ret = iommu_alloc_root_entry(iommu, iommu_ser);
>  		if (ret)
>  			goto free_iommu;
>  
> @@ -1732,8 +1745,12 @@ static int __init init_dmars(void)
>  
>  free_iommu:
>  	for_each_active_iommu(iommu, drhd) {
> -		disable_dmar_iommu(iommu);
> -		free_dmar_iommu(iommu);
> +		iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);
> +
> +		if (!iommu_ser)
> +			disable_dmar_iommu(iommu);
> +
> +		free_dmar_iommu(iommu, iommu_ser);
>  	}
>  

I'm wondering what happens if init_dmars fails for a preserved iommu?
Since we have non NULL iommu_ser, we'll skip disable_dmar_iommu and skip
free_context_table() inside free_dmar_iommu() as well. I'm concerned we
might leak some resources in this case. If the failure happens after we
set restored = 1, even a rmmod -> modprobe cycle won't help fix the leak

>  	return ret;
> @@ -2107,15 +2124,19 @@ int dmar_parse_one_satc(struct acpi_dmar_header *hdr, void *arg)
>  static int intel_iommu_add(struct dmar_drhd_unit *dmaru)
>  {
>  	struct intel_iommu *iommu = dmaru->iommu;
> +	struct iommu_hw_ser *iommu_ser = NULL;
>  	int ret;
>  
> +	/* Use IOMMU HW unit MMIO base to identify the preserved state. */
> +	iommu_ser = iommu_get_preserved_data(iommu->reg_phys, IOMMU_INTEL);

Thanks for adding that comment! Really clever btw :)

> +
>  	/*
>  	 * Disable translation if already enabled prior to OS handover.
>  	 */
> -	if (iommu->gcmd & DMA_GCMD_TE)
> +	if (!iommu_ser && iommu->gcmd & DMA_GCMD_TE)
>  		iommu_disable_translation(iommu);
>  
> -	ret = iommu_alloc_root_entry(iommu);
> +	ret = iommu_alloc_root_entry(iommu, iommu_ser);
>  	if (ret)
>  		goto out;
>

[snip]

> +
> +static int _restore_used_domain_ids(struct iommu_device_ser *ser, void *arg)
> +{
> +	int id = ser->domain_iommu_ser.attachment_id;
> +	struct iommu_hw_ser *iommu_hw_ser;
> +	struct intel_iommu *iommu = arg;
> +
> +	iommu_hw_ser = phys_to_virt(ser->domain_iommu_ser.iommu_phys);

We should check for iommu_phys being NULL here.. I know corruptions can
be funnier but a WARN_ON(!iommu_phys) could help catch NULL corruptions

> +	if (iommu_hw_ser->type != IOMMU_INTEL)
> +		return 0;
> +
> +	/* Only allocate domain ID from associated IOMMU HW unit */
> +	if (iommu_hw_ser->intel.phys_addr != iommu->reg_phys)
> +		return 0;
> +
> +	/*
> +	 * This can fail as multiple preserved devices can share the same domain
> +	 * ID. Since this is done during DMAR init so these failures can be
> +	 * ignored.
> +	 */
> +	ida_alloc_range(&iommu->domain_ida, id, id, GFP_ATOMIC);
> +	return 0;
> +}
> +

Thanks,
Praan
