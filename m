Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA861FDE0B
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740429370; cv=none; b=Yy8/MMPdllPl3yUn4IJb/pfQmrmdxteNP1LDOO+FTOem3Tb044b15hIqEuNb3cjavzE698LcekSwVZ9oakq70ZZ13R3L7IKNn/2a6BCICLpPMy6O9lmRGWtB8QA11be3d4Lz7bUiueJ0aMhS0KIZ6uN3gaz3YXclyB8eyLFUHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740429370; c=relaxed/simple;
	bh=YWwIwoWgUGkN4PS5fEaN8sQ1nwKBXMww2irPZZb2dRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J4LzJOWS5sfXfv0MJqp3XSbOhRtXRB7A4bjsaYCL5ECW19VAT7vHC+C0Zir38rP3pFXUoBYI4fAlHwCWQgDIQr9wTz34pQdTuz9ZS7K2yazO1x0/jBSKs8gUjEbF7ArStjTK/wJQC9TGmTSeGjv2h6YCNEH/HpAaw4yCm2zq9DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n1+fCHCX; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n1+fCHCX"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2212222d4cdso38085ad.0
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 12:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740429368; x=1741034168; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cKiypGlQlNh3QGjj5r76b5/2a735Mu54ttXf9R8rE4=;
        b=n1+fCHCXde4XYuEfqhizjVCsum6Iu3shKuj77L9BhPkXtErzb0SBk7ErbdUC3b54+3
         BzXh/Tn+PqmpkRwclSfFThQ3PCwBgnvrtngUM4fZwZU3xB3q5zH7RcEQ+DNS+T0HVHTr
         Yfgyni4t3bjgNTTkjVIs0QayNHDcxUBYZ8Otoae9Bz4j5dcGwMzPVM4W/wytVQFGR/0Q
         6ef3eV3A19ERlJuUoMRc9w5799gCjj02MYa2uqmac5QZijS7IwtuppBbL5LQdcaFSvqt
         hwVPE5PatK/7lEO2WdjCSuRgZnDcC8bMOBrRsnY+CLL/sCaBPnKhkCr0gyDgOi6lUMlE
         WVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740429368; x=1741034168;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cKiypGlQlNh3QGjj5r76b5/2a735Mu54ttXf9R8rE4=;
        b=mkSQvynzERbI6UaekEymqG8BLKsn5+jVBr1P1OSGsg2W+MuoWd6mRGeY6G5Jz3+TmW
         X93NQrBmI9eObqJs1DKle4zdk/mSK8TbsYFHL0Bl3n/IjvokqkwC/cbMe7C/XEsFfKub
         0urMJoptf3f5Aqj1VCPrEYCfQN5+dHcfcjhWg6PLrc5kuzxqt1vjq7FEJlSsSFam693P
         jQ2tSQyd1xEahvsiiUiAlOlmZVUU81nhQl/jpsTIE90YSu/AdTO6nipqPEW1Z5aPKSnl
         PJuUk/nPS6qUDM65hC1ahSOy6sJlcIgF1F7mM2yG8rfltIhnnv34tgCyt0W+zsLAJYKS
         Jitw==
X-Forwarded-Encrypted: i=1; AJvYcCVMs+YgQP7oShJ2y8Ea4GsoutnzGbL3jrA0u2Ajb+D+rGYj4aAukLB1OeYFMZlxBdfJl87/XQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yylx9Y2tSOAHOP2uxQlmBoFY6HF7TQexPg7+OHJoRF998F63hZr
	Pm98FPMSdL6DkNcH6gc9AKm+vkAJrqVbEBb/n60UkItRcZ2X6mKNLz9shqwVdg==
X-Gm-Gg: ASbGncu2uTPP8/9b9c9GcD+rWC3K2QJXsIvlaNFmjSO1L93FcQvhlNrc9L6QvJbllf1
	EAmkE/FCsr7dM24+gTE7DfJ6N9mRcNIRS86JnQd+CivIUPqd/CMWyGSyQxvSPj2/jcfECo6SJdG
	aoijQgLbwOdxCYh4sJTI5cFY+5Wfqb82OOWkuDTGOi8I+VbBfUgKa4aJY7B8888gJwIn8uRGzZx
	VhPXHEeDVuf932Yo36H1qogSoDMI+B1MuEXmvBONzHqL+lQh5d0pPwF4HXEvuvDFcACzkVpxd+h
	pfqpZXaaIOUkhFXch7uuui514WaQYXR9BTMr7c27nN90v3r5UX+cRLn0BeEjaLE=
X-Google-Smtp-Source: AGHT+IHaH843HTFlex9kiZqcHpRgOavmlHObIcSN9r1RcQ8QKdI50gtE2lb4j2DGqAQRh59wKV6n8g==
X-Received: by 2002:a17:902:ec90:b0:216:607d:c867 with SMTP id d9443c01a7336-22307aabb1cmr843455ad.29.1740429367405;
        Mon, 24 Feb 2025 12:36:07 -0800 (PST)
Received: from google.com (169.224.198.35.bc.googleusercontent.com. [35.198.224.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a43cb81sm101015a91.38.2025.02.24.12.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 12:36:06 -0800 (PST)
Date: Mon, 24 Feb 2025 20:35:56 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, kevin.tian@intel.com, corbet@lwn.net, will@kernel.org,
	joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v7 12/14] iommu/arm-smmu-v3: Introduce struct
 arm_smmu_vmaster
Message-ID: <Z7zYLBLZGKim-5UL@google.com>
References: <cover.1740238876.git.nicolinc@nvidia.com>
 <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be799951a817557ac093ac3e18d02a631306aa35.1740238876.git.nicolinc@nvidia.com>

oN sAt, Feb 22, 2025 at 07:54:09AM -0800, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 5aa2e7af58b4..364d8469a480 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -85,6 +85,59 @@ static void arm_smmu_make_nested_domain_ste(
>  	}
>  }
>  
> +int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
> +				    struct iommu_domain *domain)
> +{
> +	struct arm_smmu_nested_domain *nested_domain;
> +	struct arm_smmu_vmaster *vmaster;
> +	unsigned long vsid;
> +	int ret;
> +
> +	iommu_group_mutex_assert(state->master->dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_NESTED)
> +		return 0;
> +	nested_domain = to_smmu_nested_domain(domain);
> +
> +	/* Skip invalid vSTE */
> +	if (!(nested_domain->ste[0] & cpu_to_le64(STRTAB_STE_0_V)))
> +		return 0;
> +
> +	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
> +					 state->master->dev, &vsid);
> +	if (ret)
> +		return ret;
> +
> +	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
> +	if (!vmaster)
> +		return -ENOMEM;
> +	vmaster->vsmmu = nested_domain->vsmmu;
> +	vmaster->vsid = vsid;
> +	state->vmaster = vmaster;
> +
> +	return 0;
> +}
> +
> +void arm_smmu_attach_commit_vmaster(struct arm_smmu_attach_state *state)
> +{
> +	struct arm_smmu_master *master = state->master;
> +
> +	mutex_lock(&master->smmu->streams_mutex);
> +	if (state->vmaster != master->vmaster) {
> +		kfree(master->vmaster);
> +		master->vmaster = state->vmaster;
> +	}

Does this condition suggest that we might end up calling
`arm_smmu_attach_prepare_vmaster()` multiple times before __actually__
commiting to a vmaster?

> +	mutex_unlock(&master->smmu->streams_mutex);
> +}
> +
> +void arm_smmu_master_clear_vmaster(struct arm_smmu_master *master)
> +{
> +	mutex_lock(&master->smmu->streams_mutex);
> +	kfree(master->vmaster);
> +	master->vmaster = NULL;
> +	mutex_unlock(&master->smmu->streams_mutex);
> +}
> +
>  static int arm_smmu_attach_dev_nested(struct iommu_domain *domain,
>  				      struct device *dev)
>  {
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..9e50bcee69d1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2803,6 +2803,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	struct arm_smmu_domain *smmu_domain =
>  		to_smmu_domain_devices(new_domain);
>  	unsigned long flags;
> +	int ret;
>  
>  	/*
>  	 * arm_smmu_share_asid() must not see two domains pointing to the same
> @@ -2832,9 +2833,15 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  	}
>  
>  	if (smmu_domain) {
> +		ret = arm_smmu_attach_prepare_vmaster(state, new_domain);

IMO, this adds a little confusion for folks not using iommufd.

I guess it'd be cleaner if we invoke this below within the:
`if (new_domain->type == IOMMU_DOMAIN_NESTED)` condition instead of
simply returning from the function if the new_domain->type isn't NESTED.

> +		if (ret)
> +			return ret;
> +
>  		master_domain = kzalloc(sizeof(*master_domain), GFP_KERNEL);
> -		if (!master_domain)
> +		if (!master_domain) {
> +			kfree(state->vmaster);
>  			return -ENOMEM;
> +		}
>  		master_domain->master = master;
>  		master_domain->ssid = state->ssid;
>  		if (new_domain->type == IOMMU_DOMAIN_NESTED)
> @@ -2861,6 +2868,7 @@ int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>  			spin_unlock_irqrestore(&smmu_domain->devices_lock,
>  					       flags);
>  			kfree(master_domain);
> +			kfree(state->vmaster);
>  			return -EINVAL;
>  		}
>  
> @@ -2893,6 +2901,8 @@ void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  
>  	lockdep_assert_held(&arm_smmu_asid_lock);
>  
> +	arm_smmu_attach_commit_vmaster(state);
> +
>  	if (state->ats_enabled && !master->ats_enabled) {
>  		arm_smmu_enable_ats(master);
>  	} else if (state->ats_enabled && master->ats_enabled) {
> @@ -3162,6 +3172,7 @@ static int arm_smmu_attach_dev_identity(struct iommu_domain *domain,
>  	struct arm_smmu_ste ste;
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  
> +	arm_smmu_master_clear_vmaster(master);
>  	arm_smmu_make_bypass_ste(master->smmu, &ste);
>  	arm_smmu_attach_dev_ste(domain, dev, &ste, STRTAB_STE_1_S1DSS_BYPASS);
>  	return 0;
> @@ -3180,7 +3191,9 @@ static int arm_smmu_attach_dev_blocked(struct iommu_domain *domain,
>  					struct device *dev)
>  {
>  	struct arm_smmu_ste ste;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
>  
> +	arm_smmu_master_clear_vmaster(master);
>  	arm_smmu_make_abort_ste(&ste);
>  	arm_smmu_attach_dev_ste(domain, dev, &ste,
>  				STRTAB_STE_1_S1DSS_TERMINATE);
> 

Thanks,
Praan
