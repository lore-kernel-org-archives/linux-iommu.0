Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565F817C9B2
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 12:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723725747; cv=none; b=ATGWTdCXdzU/jdkul2lELfu3x0fYpJ8mDAljsL64knQfVqhftgVSCz6gANxRJinASxXh5L5cp0UTG5FXJgW87UNYNyFTMZasaf52hTyY10VDGQbnckoEEC3s4iRGvGOqIxFegL826+KNs15gSgM9sxeIcpgpxdyVdHou4CPAfTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723725747; c=relaxed/simple;
	bh=31N9UXyEkjLSwIVWOXj13Ub/xTeS0F0hYlENSCxRWyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFwQd/4GMWHxaQJM8YkJAQ3f+OkKpFCDfHb/i2ov4xkRd9/vCx7h6YC6t6mnd1nciePKfanK8N1IvKccEtKDlp8ij+I4JOEb/9WaweVS08NQfJXRJ6xuASMocAsVVfE/LgQeyqSJlXpg1ll5Q3Xw28C0Ut8b+z2BwBFP+DthLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p6Lbx+3g; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p6Lbx+3g"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201e4cf371eso105985ad.0
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 05:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723725744; x=1724330544; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mcPJ07U+tPFL5ylD5GIwA0Csw2uP4Ta2Af4EYD33Fq0=;
        b=p6Lbx+3g20C8REVdQRO8B924QWMRzjBjtQ/GRQUavHI2BCuhJrY1FvFx63CP6ws9GV
         M0JhODP+RYc1rpVHnj968QnOvx9KjzUrxXluy3//ejL9yJJSyjy86tpj6EFZeRtC8i4j
         kyoW5RFGXCzhaXhkBu0bIsMZuar9SHROdjUMIZJOvfLFFnTzwBCUDJeyjpjJB/T2PMvI
         8yKWrJzxgogwEsF03WZfxMOqSyjV67NYZwKjOMgwD7Ou6ynfmBnjtzi+lyX3eOBPblkW
         H58toe5BMCDaK+vXrUhAA9KioRx+na5MwzTyDdwwK01tmEXL/wSUuk4LSywLvfjboL/P
         CksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723725744; x=1724330544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcPJ07U+tPFL5ylD5GIwA0Csw2uP4Ta2Af4EYD33Fq0=;
        b=IGyEafNQwEoaW5J5Q3BV0s1e2PwxqC6SMJbXCWkJpamkqkzIEEtRgoIuZifeDxoLQn
         VerydwupVXRcK2RQ55f9ouVLwXaodgRLcKpSEEheybf42+LRPS/6TbuaZ72Pp21QVQJW
         FVdPALHf3xpQfvzJpSX75EWq+PGfYbUHqjA6obdz0USpvQwgT2b3hUWrINM55gfoRO8C
         t3s/eu7A2LRTjobZ05P39FHzd4lT9xCAh8oN5em3eRZBk6n8EswNjZA4gc2J+5CYm7oS
         dbWQrQkAPWC0t5COAH7psSXTYRHd/hxCQ/Ol0Wf+a9C0j2fyKRuuwIqdwSQTJOjTnbkV
         pvug==
X-Forwarded-Encrypted: i=1; AJvYcCVh9zVRIejcd5+jDQjV/6nMd5JAYRTKLMKzuY6HyGBTaJXhjudIri+XcIhmUkaLtaHgfoA5g+zGw5UHK8Ygp+QABgXabeA=
X-Gm-Message-State: AOJu0YztRD7CjoID8zB+SajpBYy2Yq33FQ86Ugu9p9X5mmvm+Urrm9IP
	TR4ZOi8ZaSRysO1HwhDbs04LzUn1TvtGRR4ihKBenPoVXJnFw0adRnNLGYxAJg==
X-Google-Smtp-Source: AGHT+IEBPC2KUlLvEJwP9qq7yKENUaRDa6fs0ZSCuXmjQ/xxeac7seC6ef5RzG3yHL5Jw5zcB+i9hQ==
X-Received: by 2002:a17:902:ec92:b0:202:156:c48b with SMTP id d9443c01a7336-2020156c6cemr31165ad.7.1723725744046;
        Thu, 15 Aug 2024 05:42:24 -0700 (PDT)
Received: from google.com (202.141.197.35.bc.googleusercontent.com. [35.197.141.202])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6b6356c84sm1044642a12.74.2024.08.15.05.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:42:23 -0700 (PDT)
Date: Thu, 15 Aug 2024 12:42:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Joerg Roedel <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	y@google.com
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Kunkun Jiang <jiangkunkun@huawei.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH] iommu: Handle iommu faults for a bad iopf setup
Message-ID: <Zr33pnFDbuJntl9H@google.com>
References: <20240815123223.7116-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815123223.7116-1-praan@google.com>

On Thu, Aug 15, 2024 at 12:32:23PM +0000, Pranjal Shrivastava wrote:
> The iommu_report_device_fault function was updated to return void while
> assuming that drivers only need to call iommu_report_device_fault() for
> reporting an iopf. This implementation causes following problems:
> 
> 1. The drivers rely on the core code to call it's page_reponse,
>    however, when a fault is received and no fault capable domain is
>    attached / iopf_param is NULL, the ops->page_response is NOT called
>    causing the device to stall in case the fault type was PAGE_REQ.
> 
> 2. The arm_smmu_v3 driver relies on the returned value to log errors
>    returning void from iommu_report_device_fault causes these events to
>    be missed while logging.
> 
> Modify the iommu_report_device_fault function to return -EINVAL for
> cases where no fault capable domain is attached or iopf_param was NULL
> and calls back to the driver (ops->page_response) in case the fault type
> was IOMMU_FAULT_PAGE_REQ. The returned value can be used by the drivers
> to log the fault/event as needed.
> 
> Reported-by: Kunkun Jiang <jiangkunkun@huawei.com>
> Closes: https://lore.kernel.org/all/6147caf0-b9a0-30ca-795e-a1aa502a5c51@huawei.com/
> Fixes: 3dfa64aecbaf ("iommu: Make iommu_report_device_fault() return void")
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   2 +-
>  drivers/iommu/io-pgfault.c                  | 116 ++++++++++++++------
>  include/linux/iommu.h                       |   5 +-
>  3 files changed, 84 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9bc50bded5af..8a6cd0adfcf2 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1777,7 +1777,7 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  		goto out_unlock;
>  	}
>  
> -	iommu_report_device_fault(master->dev, &fault_evt);
> +	ret = iommu_report_device_fault(master->dev, &fault_evt);
>  out_unlock:
>  	mutex_unlock(&smmu->streams_mutex);
>  	return ret;
> diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
> index 81e9cc6e3164..5a35da8fa78f 100644
> --- a/drivers/iommu/io-pgfault.c
> +++ b/drivers/iommu/io-pgfault.c
> @@ -115,6 +115,59 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>  	return group;
>  }
>  
> +static struct iommu_attach_handle *find_fault_handler(struct device *dev,
> +						     struct iopf_fault *evt)
> +{
> +	struct iommu_fault *fault = &evt->fault;
> +	struct iommu_attach_handle *attach_handle;
> +
> +	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> +		attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +				fault->prm.pasid, 0);
> +		if (IS_ERR(attach_handle)) {
> +			const struct iommu_ops *ops = dev_iommu_ops(dev);
> +
> +			if (!ops->user_pasid_table)
> +				return NULL;
> +			/*
> +			 * The iommu driver for this device supports user-
> +			 * managed PASID table. Therefore page faults for
> +			 * any PASID should go through the NESTING domain
> +			 * attached to the device RID.
> +			 */
> +			attach_handle = iommu_attach_handle_get(
> +					dev->iommu_group, IOMMU_NO_PASID,
> +					IOMMU_DOMAIN_NESTED);
> +			if (IS_ERR(attach_handle))
> +				return NULL;
> +		}
> +	} else {
> +		attach_handle = iommu_attach_handle_get(dev->iommu_group,
> +				IOMMU_NO_PASID, 0);
> +
> +		if (IS_ERR(attach_handle))
> +			return NULL;
> +	}
> +
> +	if (!attach_handle->domain->iopf_handler)
> +		return NULL;
> +
> +	return attach_handle;
> +}
> +
> +static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
> +	struct iommu_fault *fault = &evt->fault;
> +	struct iommu_page_response resp = {
> +		.pasid = fault->prm.pasid,
> +		.grpid = fault->prm.grpid,
> +		.code = IOMMU_PAGE_RESP_INVALID
> +	};
> +
> +	ops->page_response(dev, evt, &resp);
> +}
> +
>  /**
>   * iommu_report_device_fault() - Report fault event to device driver
>   * @dev: the device
> @@ -155,16 +208,30 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
>   * hardware has been set to block the page faults) and the pending page faults
>   * have been flushed.
>   */
> -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
> +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  {
> +	struct iommu_attach_handle *attach_handle;
>  	struct iommu_fault *fault = &evt->fault;
>  	struct iommu_fault_param *iopf_param;
>  	struct iopf_group abort_group = {};
>  	struct iopf_group *group;
> +	int ret = 0;
> +
> +	attach_handle = find_fault_handler(dev, evt);
> +	if (!attach_handle) {
> +		ret = -EINVAL;
> +		goto err_bad_iopf;
> +	}
>  
> +	/*
> +	 * Something has gone wrong if a fault capable domain is attached but no
> +	 * iopf_param is setup
> +	 */
>  	iopf_param = iopf_get_dev_fault_param(dev);
> -	if (WARN_ON(!iopf_param))
> -		return;
> +	if (WARN_ON(!iopf_param)) {
> +		ret = -EINVAL;
> +		goto err_bad_iopf;
> +	}
>  
>  	if (!(fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE)) {
>  		report_partial_fault(iopf_param, fault);

Apologies, I sent out an older version that missed returning a value.
Please ignore this email, I'll resend the updated version.

> @@ -185,38 +252,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group == &abort_group)
>  		goto err_abort;
>  
> -	if (fault->prm.flags & IOMMU_FAULT_PAGE_REQUEST_PASID_VALID) {
> -		group->attach_handle = iommu_attach_handle_get(dev->iommu_group,
> -							       fault->prm.pasid,
> -							       0);
> -		if (IS_ERR(group->attach_handle)) {
> -			const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -			if (!ops->user_pasid_table)
> -				goto err_abort;
> -
> -			/*
> -			 * The iommu driver for this device supports user-
> -			 * managed PASID table. Therefore page faults for
> -			 * any PASID should go through the NESTING domain
> -			 * attached to the device RID.
> -			 */
> -			group->attach_handle =
> -				iommu_attach_handle_get(dev->iommu_group,
> -							IOMMU_NO_PASID,
> -							IOMMU_DOMAIN_NESTED);
> -			if (IS_ERR(group->attach_handle))
> -				goto err_abort;
> -		}
> -	} else {
> -		group->attach_handle =
> -			iommu_attach_handle_get(dev->iommu_group, IOMMU_NO_PASID, 0);
> -		if (IS_ERR(group->attach_handle))
> -			goto err_abort;
> -	}
> -
> -	if (!group->attach_handle->domain->iopf_handler)
> -		goto err_abort;
> +	group->attach_handle = attach_handle;
>  
>  	/*
>  	 * On success iopf_handler must call iopf_group_response() and
> @@ -225,7 +261,7 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  	if (group->attach_handle->domain->iopf_handler(group))
>  		goto err_abort;
>  
> -	return;
> +	return 0;
>  
>  err_abort:
>  	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
> @@ -235,6 +271,14 @@ void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  		__iopf_free_group(group);
>  	else
>  		iopf_free_group(group);
> +
> +	return 0;
> +
> +err_bad_iopf:
> +	if (fault->type == IOMMU_FAULT_PAGE_REQ)
> +		iopf_error_response(dev, evt);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_report_device_fault);
>  
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 04cbdae0052e..bd722f473635 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1563,7 +1563,7 @@ struct iopf_queue *iopf_queue_alloc(const char *name);
>  void iopf_queue_free(struct iopf_queue *queue);
>  int iopf_queue_discard_partial(struct iopf_queue *queue);
>  void iopf_free_group(struct iopf_group *group);
> -void iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
> +int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
>  void iopf_group_response(struct iopf_group *group,
>  			 enum iommu_page_response_code status);
>  #else
> @@ -1601,9 +1601,10 @@ static inline void iopf_free_group(struct iopf_group *group)
>  {
>  }
>  
> -static inline void
> +static inline int
>  iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
>  {
> +	return -ENODEV;
>  }
>  
>  static inline void iopf_group_response(struct iopf_group *group,
> -- 
> 2.46.0.184.g6999bdac58-goog
> 
Thanks,
Pranjal
