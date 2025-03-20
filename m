Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8C93D994
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510221; cv=none; b=taQs2prL3zuT5XTmhhfS1GeLppgANmPRQbWHJWCrx7eVQkyLw1btwX8B3OpytC/HeXvCWdRFDu87pnKL1AxAW9urrPZEtPJ7AJqtZaWO6QUSrETedRe4NH6/IDpuNObllWI7mwUayHW1Dj5cxgku6q5mdJfT0CeQ1xR70zf6et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510221; c=relaxed/simple;
	bh=+7JGjjJYunBd8O+rmQa05V5z5EqTGQh5MU7sRlUAsdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGGubCYwvd1flIbN7IeL8fO5mUCMMmAYe7lQb1g/s16/UEzB8xoOZRGAmY22PZ/wjwdtA7YXdlppPhUpxxsxGPHs5uYqCAXJ/zEBVcKFPM7c2w+JwE/JxkwgQ6L7XZqWfP3d+HokOAa2fSuvPFpStgeWewPUcJ7WMcVrD6FvFvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YW0fwLjO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YW0fwLjO"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfe808908so22805e9.0
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742510217; x=1743115017; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHRJKgM93DpKJ6wfK7aIbLHWLTiJLN1HFDPIw1tKwwk=;
        b=YW0fwLjOw7/0eg1EPqe3MEdIUiWGUOJHKFnIEIfLrdBs2pyDL+VDkcXMpcfdMN9o4Y
         SrgAsG5vkLxjKG7VXyPzT3OIPqo2/FCzL88ZZ1sZHWKRrIGl4ZlNjNiB1CvVtiHPe3P/
         PuhNcYMr6qDS3hqmOfrOdUY/D7jdt99EUmadCrmjeCadklNPVLhqUMHDByHH5oBc4aML
         eW+FagvptNsqeHj4sgU9x+PlXSOpujfW+ZWYZHI41ffGfBbFE0xya2YxgVQv//yuAc6f
         mawSUlOiSGI2xADx4Bgtz0JM31uuUbk7BM49F/kRrYCeKHXkiMtZOmd4oXh8Q5WXfopk
         M6AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742510217; x=1743115017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHRJKgM93DpKJ6wfK7aIbLHWLTiJLN1HFDPIw1tKwwk=;
        b=HoPZDFqw8eBfp89XkMDspc414P9ZzNJwu5bNUgNKSWCCr9BgvoGpvgnelN2ntjvJ7x
         te1ITow2jjOrziJw4wC4KCTR6B7mvtJXrDqyyXd7OdsQxq9E9y5xxbP9w7nVE8KPKwSV
         3jXScgm13hadl6m0s87pTBFJmCwbTGTItlN9iS7jZ35wJP8jwKpTWnohGCJj8eJMbbDe
         6Mg4iCMqrrkHybABUll0yQw0Y0PeWVTqGNQlNlxGXvPYc9VWswSdp+ICbLsZe68ad0Pp
         u4I0a1QLY0Lv6ixniOgkqTASllxli3DGGQuXtKcElYCd250TAjNCM1wKk2DEL7B8oUGN
         wgIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUOVK7NjdldCTycFL6FgM7STBkaoGjr7z0Jvzz4Wh3y+c+RYx43jILQXCV5+kEMhrfmLzjyw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzkD4XNcAn+4H7b8MGcgmcJ0YAunqUnGvcIiblHvQGI/sHYUzg6
	f3HVbDjmw9zORajxlqFI5vIFh5rK7eqAGtNytBpzfw8kN5J0rfaqsJSKCblrJQ==
X-Gm-Gg: ASbGncuC5WK8XDItGJP0Ml95fvFpH35kw4J8b3hd7AjVO0nU9TXgj4Ji5bfI+D0dFey
	9JuHWZrAobLPv1+sb1GsBb7EoVgQB6aiXUQUyLb5E/HMRYHw3BTBiCSDLbhOgAiv+lcDn5m1Rc2
	HuJ9xMEpN/rv0N8d/sKLpqDx/nSp/ssWoA0wew7xtWn/FQwbTmSSenTVTis2N61qcrlvWN6pmaq
	v+YOHrmGLNpKrclskbSvYEA/oubF8N03GxIWI4g2L9eui+OX5zyjLl6InC83Qf8+U1bO9i4dt6y
	rEZLkTcrGkWlkHZSOwjMz8+Lq/K0Ad1+DlnZKuP0ek3JJoZYNzW5KNYFsbx21Qvu9db151d58wx
	DAyXs
X-Google-Smtp-Source: AGHT+IEFhcaYfXX3W1GoUJ1xgSbOa3oailNnhIAId9LAXviwhjaV8XMnYk2ZdRSsWBeuI13pPXmSdA==
X-Received: by 2002:a05:600c:4182:b0:439:8f59:2c56 with SMTP id 5b1f17b1804b1-43d5085fa4emr414145e9.2.1742510216430;
        Thu, 20 Mar 2025 15:36:56 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f43ecbsm60165645e9.10.2025.03.20.15.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:36:54 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:36:50 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 5/5] iommu/arm-smmu-v3: Invoke pm_runtime before hw
 access
Message-ID: <Z9yYgsCngzWRUvis@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-6-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319004254.2547950-6-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:54AM +0000, Pranjal Shrivastava wrote:
> Invoke the pm_runtime helpers at all places before accessing the hw.
> The idea is to invoke runtime_pm helpers at common points which are
> used by exposed ops or interrupt handlers. For cases without such a
> common point, simply wrap the exposed op/handler with rpm_get/put calls.
> 

Wouldn’t it be better to call this before/after map/unmap? Instead
of having it in low level invalidation functions, that would save
calling it a bunch of times. (although it’s not common to hit a tlb
invalidation on map)
This is also similar to the SMMUv2 driver.

Thanks,
Mostafa

> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  .../arm/arm-smmu-v3/arm-smmu-v3-iommufd.c     |  22 +++-
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  24 ++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 107 ++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |   3 +
>  4 files changed, 145 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 5aa2e7af58b4..1d423fc2cf18 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -13,10 +13,17 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
>  	struct iommu_hw_info_arm_smmuv3 *info;
>  	u32 __iomem *base_idr;
>  	unsigned int i;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(master->smmu);
> +	if (ret < 0)
> +		return ERR_PTR(-EIO);
>  
>  	info = kzalloc(sizeof(*info), GFP_KERNEL);
> -	if (!info)
> +	if (!info) {
> +		arm_smmu_rpm_put(master->smmu);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	base_idr = master->smmu->base + ARM_SMMU_IDR0;
>  	for (i = 0; i <= 5; i++)
> @@ -27,6 +34,7 @@ void *arm_smmu_hw_info(struct device *dev, u32 *length, u32 *type)
>  	*length = sizeof(*info);
>  	*type = IOMMU_HW_INFO_TYPE_ARM_SMMUV3;
>  
> +	arm_smmu_rpm_put(master->smmu);
>  	return info;
>  }
>  
> @@ -96,6 +104,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  		.old_domain = iommu_get_domain_for_dev(dev),
>  		.ssid = IOMMU_NO_PASID,
>  	};
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_ste ste;
>  	int ret;
>  
> @@ -104,6 +113,10 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  	if (arm_smmu_ssids_in_use(&master->cd_table))
>  		return -EBUSY;
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
>  	mutex_lock(&arm_smmu_asid_lock);
>  	/*
>  	 * The VM has to control the actual ATS state at the PCI device because
> @@ -117,6 +130,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  	ret = arm_smmu_attach_prepare(&state, domain);
>  	if (ret) {
>  		mutex_unlock(&arm_smmu_asid_lock);
> +		arm_smmu_rpm_put(smmu);
>  		return ret;
>  	}
>  
> @@ -125,6 +139,7 @@ static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  	arm_smmu_install_ste_for_dev(master, &ste);
>  	arm_smmu_attach_commit(&state);
>  	mutex_unlock(&arm_smmu_asid_lock);
> +	arm_smmu_rpm_put(smmu);
>  	return 0;
>  }
>  
> @@ -301,6 +316,10 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  	cur = cmds;
>  	end = cmds + array->entry_num;
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
>  	static_assert(sizeof(*cmds) == 2 * sizeof(u64));
>  	ret = iommu_copy_struct_from_full_user_array(
>  		cmds, sizeof(*cmds), array,
> @@ -329,6 +348,7 @@ static int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
>  		last = cur;
>  	}
>  out:
> +	arm_smmu_rpm_put(smmu);
>  	array->entry_num = cur - cmds;
>  	kfree(cmds);
>  	return ret;
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 9ba596430e7c..8f6d2533c493 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -140,6 +140,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  {
>  	struct arm_smmu_domain *smmu_domain =
>  		container_of(mn, struct arm_smmu_domain, mmu_notifier);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	size_t size;
>  
>  	/*
> @@ -156,6 +157,10 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  			size = 0;
>  	}
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>  	if (!size)
>  		arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
>  	else
> @@ -163,6 +168,7 @@ static void arm_smmu_mm_arch_invalidate_secondary_tlbs(struct mmu_notifier *mn,
>  					    PAGE_SIZE, false, smmu_domain);
>  
>  	arm_smmu_atc_inv_domain(smmu_domain, start, size);
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> @@ -170,8 +176,13 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  	struct arm_smmu_domain *smmu_domain =
>  		container_of(mn, struct arm_smmu_domain, mmu_notifier);
>  	struct arm_smmu_master_domain *master_domain;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	unsigned long flags;
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>  	/*
>  	 * DMA may still be running. Keep the cd valid to avoid C_BAD_CD events,
>  	 * but disable translation.
> @@ -195,6 +206,7 @@ static void arm_smmu_mm_release(struct mmu_notifier *mn, struct mm_struct *mm)
>  
>  	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  static void arm_smmu_mmu_notifier_free(struct mmu_notifier *mn)
> @@ -371,12 +383,24 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>  static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		/*
> +		 * Even if the rpm_get fails, the TLBs were invalidated
> +		 * with suspend, continue with the free operation.
> +		 */
> +		goto free_asid;
>  
>  	/*
>  	 * Ensure the ASID is empty in the iommu cache before allowing reuse.
>  	 */
>  	arm_smmu_tlb_inv_asid(smmu_domain->smmu, smmu_domain->cd.asid);
> +	arm_smmu_rpm_put(smmu);
>  
> +free_asid:
>  	/*
>  	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
>  	 * still be called/running at this point. We allow the ASID to be
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 602784e84e84..f8d74ccaed6a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -109,7 +109,7 @@ static const char * const event_class_str[] = {
>  
>  static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
>  
> -static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
> +int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> @@ -124,7 +124,7 @@ static int arm_smmu_rpm_get(struct arm_smmu_device *smmu)
>  	return 0;
>  }
>  
> -static void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
> +void arm_smmu_rpm_put(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  
> @@ -1037,7 +1037,9 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  {
>  	struct arm_smmu_cmdq_ent cmd = {0};
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
>  	int sid = master->streams[0].id;
> +	int ret;
>  
>  	if (WARN_ON(!master->stall_enabled))
>  		return;
> @@ -1057,6 +1059,10 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  		break;
>  	}
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>  	arm_smmu_cmdq_issue_cmd(master->smmu, &cmd);
>  	/*
>  	 * Don't send a SYNC, it doesn't do anything for RESUME or PRI_RESP.
> @@ -1064,6 +1070,7 @@ static void arm_smmu_page_response(struct device *dev, struct iopf_fault *unused
>  	 * terminated... at some point in the future. PRI_RESP is fire and
>  	 * forget.
>  	 */
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  /* Context descriptor manipulation functions */
> @@ -1984,6 +1991,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
>  
>  static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  {
> +	int ret;
>  	u64 evt[EVTQ_ENT_DWORDS];
>  	struct arm_smmu_event event = {0};
>  	struct arm_smmu_device *smmu = dev;
> @@ -1992,6 +2000,10 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
>  				      DEFAULT_RATELIMIT_BURST);
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return IRQ_NONE;
> +
>  	do {
>  		while (!queue_remove_raw(q, evt)) {
>  			arm_smmu_decode_event(smmu, evt, &event);
> @@ -2012,6 +2024,7 @@ static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
>  
>  	/* Sync our overflow flag, as we believe we're up to speed */
>  	queue_sync_cons_ovf(q);
> +	arm_smmu_rpm_put(smmu);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -2059,6 +2072,11 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  	struct arm_smmu_queue *q = &smmu->priq.q;
>  	struct arm_smmu_ll_queue *llq = &q->llq;
>  	u64 evt[PRIQ_ENT_DWORDS];
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return IRQ_NONE;
>  
>  	do {
>  		while (!queue_remove_raw(q, evt))
> @@ -2070,6 +2088,7 @@ static irqreturn_t arm_smmu_priq_thread(int irq, void *dev)
>  
>  	/* Sync our overflow flag, as we believe we're up to speed */
>  	queue_sync_cons_ovf(q);
> +	arm_smmu_rpm_put(smmu);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -2079,13 +2098,24 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  {
>  	u32 gerror, gerrorn, active;
>  	struct arm_smmu_device *smmu = dev;
> +	int ret;
> +
> +	if (pm_runtime_enabled(smmu->dev)) {
> +		ret = pm_runtime_get_if_active(smmu->dev);
> +		if (ret == 0) {
> +			dev_err(smmu->dev, "Ignoring gerror interrupt because device isn't rpm active\n");
> +			return IRQ_NONE;
> +		}
> +	}
>  
>  	gerror = readl_relaxed(smmu->base + ARM_SMMU_GERROR);
>  	gerrorn = readl_relaxed(smmu->base + ARM_SMMU_GERRORN);
>  
>  	active = gerror ^ gerrorn;
> -	if (!(active & GERROR_ERR_MASK))
> +	if (!(active & GERROR_ERR_MASK)) {
> +		arm_smmu_rpm_put(smmu);
>  		return IRQ_NONE; /* No errors pending */
> +	}
>  
>  	dev_warn(smmu->dev,
>  		 "unexpected global error reported (0x%08x), this could be serious\n",
> @@ -2118,6 +2148,7 @@ static irqreturn_t arm_smmu_gerror_handler(int irq, void *dev)
>  		arm_smmu_cmdq_skip_err(smmu);
>  
>  	writel(gerror, smmu->base + ARM_SMMU_GERRORN);
> +	arm_smmu_rpm_put(smmu);
>  	return IRQ_HANDLED;
>  }
>  
> @@ -2291,6 +2322,11 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  	struct arm_smmu_domain *smmu_domain = cookie;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cmdq_ent cmd;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
>  
>  	/*
>  	 * NOTE: when io-pgtable is in non-strict mode, we may get here with
> @@ -2307,6 +2343,7 @@ static void arm_smmu_tlb_inv_context(void *cookie)
>  		arm_smmu_cmdq_issue_cmd_with_sync(smmu, &cmd);
>  	}
>  	arm_smmu_atc_inv_domain(smmu_domain, 0, 0);
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  static void __arm_smmu_tlb_inv_range(struct arm_smmu_cmdq_ent *cmd,
> @@ -2384,6 +2421,8 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  					  size_t granule, bool leaf,
>  					  struct arm_smmu_domain *smmu_domain)
>  {
> +	int ret;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
>  	struct arm_smmu_cmdq_ent cmd = {
>  		.tlbi = {
>  			.leaf	= leaf,
> @@ -2398,6 +2437,11 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  		cmd.opcode	= CMDQ_OP_TLBI_S2_IPA;
>  		cmd.tlbi.vmid	= smmu_domain->s2_cfg.vmid;
>  	}
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
> +
>  	__arm_smmu_tlb_inv_range(&cmd, iova, size, granule, smmu_domain);
>  
>  	if (smmu_domain->nest_parent) {
> @@ -2414,6 +2458,7 @@ static void arm_smmu_tlb_inv_range_domain(unsigned long iova, size_t size,
>  	 * zapped an entire table.
>  	 */
>  	arm_smmu_atc_inv_domain(smmu_domain, iova, size);
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  void arm_smmu_tlb_inv_range_asid(unsigned long iova, size_t size, int asid,
> @@ -2985,6 +3030,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (smmu_domain->smmu != smmu)
>  		return ret;
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (smmu_domain->stage == ARM_SMMU_DOMAIN_S1) {
>  		cdptr = arm_smmu_alloc_cd_ptr(master, IOMMU_NO_PASID);
>  		if (!cdptr)
> @@ -3028,6 +3077,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  
>  	arm_smmu_attach_commit(&state);
>  	mutex_unlock(&arm_smmu_asid_lock);
> +	arm_smmu_rpm_put(smmu);
>  	return 0;
>  }
>  
> @@ -3090,6 +3140,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  		.ssid = pasid,
>  		.old_domain = old,
>  	};
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_cd *cdptr;
>  	int ret;
>  
> @@ -3103,9 +3154,15 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
>  		return -EINVAL;
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
> +
>  	cdptr = arm_smmu_alloc_cd_ptr(master, pasid);
> -	if (!cdptr)
> +	if (!cdptr) {
> +		arm_smmu_rpm_put(smmu);
>  		return -ENOMEM;
> +	}
>  
>  	mutex_lock(&arm_smmu_asid_lock);
>  	ret = arm_smmu_attach_prepare(&state, &smmu_domain->domain);
> @@ -3127,6 +3184,7 @@ int arm_smmu_set_pasid(struct arm_smmu_master *master,
>  
>  out_unlock:
>  	mutex_unlock(&arm_smmu_asid_lock);
> +	arm_smmu_rpm_put(smmu);
>  	return ret;
>  }
>  
> @@ -3136,6 +3194,12 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  {
>  	struct arm_smmu_domain *smmu_domain = to_smmu_domain(old_domain);
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
>  
>  	mutex_lock(&arm_smmu_asid_lock);
>  	arm_smmu_clear_cd(master, pasid);
> @@ -3156,21 +3220,28 @@ static int arm_smmu_blocking_set_dev_pasid(struct iommu_domain *new_domain,
>  		    sid_domain->type == IOMMU_DOMAIN_BLOCKED)
>  			sid_domain->ops->attach_dev(sid_domain, dev);
>  	}
> +
> +	arm_smmu_rpm_put(smmu);
>  	return 0;
>  }
>  
> -static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
> +static int arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  				    struct device *dev,
>  				    struct arm_smmu_ste *ste,
>  				    unsigned int s1dss)
>  {
> +	int ret;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
>  	struct arm_smmu_attach_state state = {
>  		.master = master,
>  		.old_domain = iommu_get_domain_for_dev(dev),
>  		.ssid = IOMMU_NO_PASID,
>  	};
>  
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return ret;
>  	/*
>  	 * Do not allow any ASID to be changed while are working on the STE,
>  	 * otherwise we could miss invalidations.
> @@ -3205,6 +3276,8 @@ static void arm_smmu_attach_dev_ste(struct iommu_domain *domain,
>  	 * descriptor from arm_smmu_share_asid().
>  	 */
>  	arm_smmu_clear_cd(master, IOMMU_NO_PASID);
> +	arm_smmu_rpm_put(smmu);
> +	return 0;
>  }
>  
>  static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
> @@ -3214,8 +3287,8 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  
>  	arm_smmu_make_bypass_ste(master->smmu, &ste);
> -	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
> -	return 0;
> +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> +				       STRTAB_STE_1_S1DSS_BYPASS);
>  }
>  
>  static const struct iommu_domain_ops arm_smmu_identity_ops = {
> @@ -3233,9 +3306,8 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
>  	struct arm_smmu_ste ste;
>  
>  	arm_smmu_make_abort_ste(&ste);
> -	arm_smmu_attach_dev_ste(domain, dev, &ste,
> -				STRTAB_STE_1_S1DSS_TERMINATE);
> -	return 0;
> +	return arm_smmu_attach_dev_ste(domain, dev, &ste,
> +				       STRTAB_STE_1_S1DSS_TERMINATE);
>  }
>  
>  static const struct iommu_domain_ops arm_smmu_blocked_ops = {
> @@ -4874,10 +4946,19 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  static void arm_smmu_device_remove(struct platform_device *pdev)
>  {
>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> +	int ret;
>  
>  	iommu_device_unregister(&smmu->iommu);
>  	iommu_device_sysfs_remove(&smmu->iommu);
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret <  0)
> +		goto free_iopf;
> +
>  	arm_smmu_device_disable(smmu);
> +	arm_smmu_rpm_put(smmu);
> +
> +free_iopf:
>  	iopf_queue_free(smmu->evtq.iopf);
>  	ida_destroy(&smmu->vmid_map);
>  }
> @@ -4885,8 +4966,14 @@ static void arm_smmu_device_remove(struct platform_device *pdev)
>  static void arm_smmu_device_shutdown(struct platform_device *pdev)
>  {
>  	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
> +	int ret;
> +
> +	ret = arm_smmu_rpm_get(smmu);
> +	if (ret < 0)
> +		return;
>  
>  	arm_smmu_device_disable(smmu);
> +	arm_smmu_rpm_put(smmu);
>  }
>  
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 6bac83a511e2..b7c2e28e903b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -987,6 +987,9 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>  				struct arm_smmu_cmdq *cmdq, u64 *cmds, int n,
>  				bool sync);
>  
> +int arm_smmu_rpm_get(struct arm_smmu_device *smmu);
> +void arm_smmu_rpm_put(struct arm_smmu_device *smmu);
> +
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
