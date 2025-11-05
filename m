Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6EB734DB51
	for <iommu@lists.linux.dev>; Wed,  5 Nov 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762377265; cv=none; b=lDUQyX3hfYOs5Wwk48D45QQuOC+sNtsCsooIeBSAA1GS6s3mh56bIHSv1fnrndnJwACe/YGWR4HRIKS+xExuJgNLSeRpDPVlB69QH2W1dEqr9wuhzgVPli0HhaC5ficIe4ZGMKgVhTxRtce66SUzyGJ7Wfu5EHqbZrjcCh59A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762377265; c=relaxed/simple;
	bh=MQvsWeDQVn/3Ah+sMEwFHizhxAHJ0b7a7QFp7wzzuLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C27Idy64UamwtlfErjDUq43JwpWUIWTFAp6eM7O/SVHwR2j6pV6/yywfgcU7b5TgPjC78kH5Ic6SSOH9Nd4RLrk4cANIt/HyXezpHD4B7emnboHWcwgDF71qJt5rm1cqbNbzlXySTrYsrnpE++bzBTHOx5dJUtx6McmunFNS40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yQDvyGNK; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yQDvyGNK"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-27d67abd215so38165ad.0
        for <iommu@lists.linux.dev>; Wed, 05 Nov 2025 13:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762377263; x=1762982063; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1a4Yyw4cqtm7g2w2aJJeYA13ID9gFvTcA7MB5XSqJcE=;
        b=yQDvyGNKJBf0tBJ3Md9GYqJw11xeYWy8ikx72S+yoOAQlUjRz3lMq+awK88o35pvtE
         F/7WnBFbFFktFBmn8XQzH1Ts1ZljwoxWo0uHpssjY8KIMPMCJxxxXdtpSSm7pxrTz9xK
         5/a3k3UCC6WvRl8j6kzURLxYH7R2JdKIMlDKxk6EmtXbdU/jhisfI/fb39BgAygZ5Hpl
         pvTf28pLVK5VXjNj+hDMqWuuqmMfKRBz9GqKYagohMSXnn0z1+Z9b8u2i84EAU/zjf6I
         /Sj9UupzwDOzBwSJQ/MxfJDyPP80CdYQ8SX6eAD6LNdsX0TYFpfEa7Om8JCDwhm3TwiT
         9ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762377263; x=1762982063;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1a4Yyw4cqtm7g2w2aJJeYA13ID9gFvTcA7MB5XSqJcE=;
        b=Wa4ojqc+eUs2MsiyOQ6M4kqx5RI7MuyJ3Cnh0RV5xL1p5n+5A04+cGUqFw9sWw4/5U
         Wr/vgh3SVo/nWFBDVmVIZxLW4gP/OJ412FKvdbjwnyB/s53gH1wN1NdUgbwfQGhGAiPL
         ZTgrplKkcMbmDmjrSMv91nYxlGex65nNWTFGEkkNEOwpfNEEVJmkahg7+F2NQnk0nN8i
         7qLWebjJct0k0/3E/pp9xtqGKxEjYirnxb/a/npl/vgMjCKYCZkePEtcvYRNmYxhP42r
         5CRYCQIBHZyMEqOJc7OlILOy9SBqRgMbWfLk+fkd+epPuaomm/SKiFc/tgW3TWbwKWev
         4fxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsn2H9XOAYIl0Fz1oMhBJHdKyXEQZVI3BfSEXr3bAaux4qE0gYiicW0e+TkJzzKKQo2UcaVw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNp3a4d4k5kFRxIIleirxd5fkpE65LSBh8V2RpsN6n01FvtTy5
	2/o0RFuDn2DUVl08SuiVE+DEY1aiM7xTf3jJiTAv+SuM7mS++NmgqC2JRTLJEOiXxA==
X-Gm-Gg: ASbGncu9z4+ybR7B4VFkujGJn+EbddcmKI6FxbixuPsXE3DGBz0yYG+snUrbyqfhPv8
	SAJww3f0Ye4iLpj513egFOtcRqNJCse8XB4xo5oKEyTkkHuPnkgNpnoO8nAF88I9gdsHxTT+kg+
	AadySy4Qg+SE4L5Bb/LaMH72SmUTxeng9n1VvHJXbavSktIyM4Ty7Fcw0d+XHjmHCgscN34/fqu
	FIzqsuYisIwtPS0NvpFvoROy8geyIkTmzXvAdOZHEAG0T7+srZGEWyjROHev7cOcdFV3nVrUYby
	NuJEoUnTuesxrLJcdykk3G8ELrjG7e7JCFJgeVl9+WovihAFftsFtu0XGYvjL8qf11LVvMntMOP
	lIbS2PUTJh7XfEIPIJ3gNS6OagliRBiIHXI2qXqzr2ltOOfJQGjvx1JOrCPNoiMsuazYmlE894R
	eDVmClS8fWpqQISm42JMDrtn1QyEp+7NstgBxqnOeNYCN99LMT
X-Google-Smtp-Source: AGHT+IFP1YxRkoxKG9m5uY31RvKem02MIvxx/qMo4X6r12qFFAqsYxQUQt6ctZOzHEsowBEgNB2RGA==
X-Received: by 2002:a17:902:e74b:b0:290:8ecf:e9f9 with SMTP id d9443c01a7336-2965b17e891mr190525ad.7.1762377262520;
        Wed, 05 Nov 2025 13:14:22 -0800 (PST)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341d121cf9fsm21677a91.10.2025.11.05.13.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 13:14:21 -0800 (PST)
Date: Wed, 5 Nov 2025 21:14:15 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: jgg@nvidia.com, will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	skolothumtho@nvidia.com
Subject: Re: [PATCH v2] iommu/arm-smmu-v3-iommufd: Allow attaching nested
 domain for GBPA cases
Message-ID: <aQu-Jy27_PzxqVvt@google.com>
References: <20251103172755.2026145-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103172755.2026145-1-nicolinc@nvidia.com>

On Mon, Nov 03, 2025 at 09:27:55AM -0800, Nicolin Chen wrote:
> A vDEVICE has been a hard requirement for attaching a nested domain to the
> device. This makes sense when installing a guest STE, since a vSID must be
> present and given to the kernel during the vDEVICE allocation.
> 
> But, when CR0.SMMUEN is disabled, VM doesn't really need a vSID to program
> the vSMMU behavior as GBPA will take effect, in which case the vSTE in the
> nested domain could have carried the bypass or abort configuration in GBPA
> register. Thus, having such a hard requirement doesn't work well for GBPA.
> 
> Skip vmaster allocation in arm_smmu_attach_prepare_vmaster() for an abort
> or bypass vSTE. Note that device on this attachment won't report vevents.
> 
> Update the uAPI doc accordingly.
> 
> Tested-by: Shameer Kolothum <skolothumtho@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> 
> Changelog
> v2
>  * Add Tested-by from Shameer
>  * Skip vmaster allocation instead of bypassing vsid=0
>  * Revise the uAPI doc to note a corner case when CR0.SMMUEN=1
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 13 ++++++++++++-
>  include/uapi/linux/iommufd.h                        |  9 +++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> index 8cd8929bbfdf8..e5fbbdbdea242 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
> @@ -99,6 +99,8 @@ static void arm_smmu_make_nested_domain_ste(
>  int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  				    struct arm_smmu_nested_domain *nested_domain)
>  {
> +	unsigned int cfg =
> +		FIELD_GET(STRTAB_STE_0_CFG, le64_to_cpu(nested_domain->ste[0]));
>  	struct arm_smmu_vmaster *vmaster;
>  	unsigned long vsid;
>  	int ret;
> @@ -107,8 +109,17 @@ int arm_smmu_attach_prepare_vmaster(struct arm_smmu_attach_state *state,
>  
>  	ret = iommufd_viommu_get_vdev_id(&nested_domain->vsmmu->core,
>  					 state->master->dev, &vsid);
> -	if (ret)
> +	/*
> +	 * Attaching to a translate nested domain must allocate a vDEVICE prior,
> +	 * as CD/ATS invalidations and vevents require a vSID to work properly.
> +	 * A abort/bypass domain is allowed to attach w/o vmaster for GBPA case.
> +	 */
> +	if (ret) {
> +		if (cfg == STRTAB_STE_0_CFG_ABORT ||
> +		    cfg == STRTAB_STE_0_CFG_BYPASS)
> +			return 0;
>  		return ret;
> +	}
>

Skipping the vmaster allocation entirely for the GBPA-only case (when no
vdevice is found) is much cleaner. Thanks!

>  	vmaster = kzalloc(sizeof(*vmaster), GFP_KERNEL);
>  	if (!vmaster)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c218c89e0e2eb..225671603ade6 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -450,6 +450,15 @@ struct iommu_hwpt_vtd_s1 {
>   * nested domain will translate the same as the nesting parent. The S1 will
>   * install a Context Descriptor Table pointing at userspace memory translated
>   * by the nesting parent.
> + *
> + * It's suggested to allocate a vDEVICE object carrying vSID and then re-attach
> + * the nested domain, as soon as the vSID is available in the VMM level:
> + * - when Cfg=translate, a vDEVICE must be allocated prior to attaching to the
> + *   allocated nested domain, as CD/ATS invalidations and vevents need a vSID.
> + * - when Cfg=bypass/abort, a vDEVICE is not enforced during the nested domain
> + *   attachment, to support a GBPA case where VM sets CR0.SMMUEN=0. However, if
> + *   VM sets CR0.SMMUEN=1 while missing a vDEVICE object, kernel would fail to
> + *   report events to the VM. E.g. F_TRANSLATION when guest STE.Cfg=abort.
>   */

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
