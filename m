Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44038214406
	for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305639; cv=none; b=e33qeUocX0DOrnx/ZW302uH8MZCndxpVptIQkgMjwj0C7Bx0ftZ5whKCjeKusOuVFoX3unVNkw1RpmbTduaEyQZlCeXWj0GOr6Y4sGq0kxidY2TEe2CIghO9gT2UiFllXUqofYvrFGjljCjSLyFfP8Brq6k2cE64qGAHvXIy5Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305639; c=relaxed/simple;
	bh=UblSNSNMS2SOQAz7chOMf7T7raYYYerjDvTtLkicoW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9MX4Y5+LqMXAD2WnKMOKzYruXEZD2t+ZRI4PkuB5VqFpe4xU691UjOo9Zqwl0GQ3Id5PSmL/g2o4YMKn59HaKR2KkrWA/y23jpkGpMuD+RwwmvynRGvqlOGJ2sivttnzkrAdzr605x26KYxh48G5IziQ9ZcqEuS0DI9iydm5CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yzu2W2FC; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yzu2W2FC"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so262565e9.0
        for <iommu@lists.linux.dev>; Wed, 30 Oct 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730305635; x=1730910435; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=yzu2W2FCvWmZzNR6wJHmBWm3CURBDg93sUL5bi4IBYCMsnMDS/as3b63skPv27zLJG
         svAfTHY5XPWoT13vEorHbXXh9/nhQ7bFzJUN2sDzMbr2EddVTg1uiyJ3UnK3CwLvlSrx
         tcorJ3JSYuIbPBaAC9hNW89Q80e+Lhzerxz3d+HE/kmgmspQHffnAyrOuuDd5e/GW/Qo
         MFyBAXZVNQzF61ZfORR6AwbJXVNz7XsTWLM/6mJAVQ/Uc2cucG2twFD4r4RvocDV7DBg
         YIqKg7zLaIkJoPg9GO1fTvwM9W52ZFQMaH0WzxHM6DJspWBdn8bfPjyH/4wYOO28PiDD
         qwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730305635; x=1730910435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYoXZbQ0uAqOxJs4pfuNVgj8x5cCoQnCDnibucZBWDk=;
        b=o/0+FrBo+RKDUKkn7sCnWJzDkP/mzzlFhLfv6sKxaYRHLLkfn2XZoKAcoxWz5XF0zG
         d7GB36T9zo6fpm8JRQgOARYumG2iMaweO2FoLmL59OKoGxyEPgcTfHrjdYqE325O2yTr
         S6wWEtmxoXwUarK38vtkDCEEWUeLpmZs0xPdI16HGlZ+/lz2u/NOCw/VsW+K5SSjrkmz
         MISb1yWCuZ+zJBlN/T7kQFNw5sdoARgBaFu9GQR7MdYRKhkZoXCQUpbwpm8Bzr024RJn
         EGD5X1cg1rS0+wG7PUlQZsMbyjVCrUCmd98IcXQ8/seWroEK75+UTcc+BVOmLTpooUEf
         ZlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5wgRzghpMdtBYrhPiRoAuTjUm21650ExgiBHoFupywERoOzK7MgB/JFfD3LOXMFBExHbZjQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyqGrwB+/xjYvDshRDT/plOw6jWyTuiUBtw5Ek46bmmSl3T68EZ
	/eyzDvZFQDWSizpd9qR/OxDXbA2mmI7VC9Hg2Oiqq1pXsUcLagsE3G9N9UTtsA==
X-Gm-Gg: ASbGnct3+uyst2tAq0g829yAUWHA1xOSJQjOjW6thyhhY/MzDr+TFlPd73FHdLzG+NU
	qRiEMtGd5eCTqvKEY/S1e0UKpXgkHsZJKaXj5CBNPqQPuadH24n9ssXPM1PDFWmeBCPqjzHYq+N
	srzDj946T9EKvaOAQNVQYis+Q2Mbzu2KMMDCxk7Ch2BXoS3dfvNointFztElHnXDnNOv4NEKl8R
	NPyVd5XlzP/n3EjA2Xl6xPnqIDdvU0cVszxEKFWwwAxHGMSSWVaGHSWBwTHClP9OFXDGSsD/88u
	z0yYJ+pe5Q==
X-Google-Smtp-Source: AGHT+IEOBtDGTbd6gFd1Z2+Q52Kfzjw/j8SXp0CbEXKBAIwCsXgB74M2Jp4jqtd+Hp2Dw2dtDYw8jw==
X-Received: by 2002:a05:600c:1d83:b0:42c:acd7:b59b with SMTP id 5b1f17b1804b1-431b3cdeb16mr11198215e9.6.1730305635387;
        Wed, 30 Oct 2024 09:27:15 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9ca818sm25801655e9.40.2024.10.30.09.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 09:27:08 -0700 (PDT)
Date: Wed, 30 Oct 2024 16:26:59 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
	iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Eric Auger <eric.auger@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Moritz Fischer <mdf@kernel.org>,
	Michael Shavit <mshavit@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>, patches@lists.linux.dev,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v3 7/9] iommu/arm-smmu-v3: Expose the arm_smmu_attach
 interface
Message-ID: <ZyJeU9Kkos6RibsR@google.com>
References: <0-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
 <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7-v3-e2e16cd7467f+2a6a1-smmuv3_nesting_jgg@nvidia.com>

On Wed, Oct 09, 2024 at 01:23:13PM -0300, Jason Gunthorpe wrote:
> The arm-smmuv3-iommufd.c file will need to call these functions too.
> Remove statics and put them in the header file. Remove the kunit
> visibility protections from arm_smmu_make_abort_ste() and
> arm_smmu_make_s2_domain_ste().
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

Thanks,
Mostafa
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++-------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 27 +++++++++++++++++----
>  2 files changed, 27 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 80847fa386fcd2..b4b03206afbf48 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1549,7 +1549,6 @@ static void arm_smmu_write_ste(struct arm_smmu_master *master, u32 sid,
>  	}
>  }
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_abort_ste(struct arm_smmu_ste *target)
>  {
>  	memset(target, 0, sizeof(*target));
> @@ -1632,7 +1631,6 @@ void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  }
>  EXPORT_SYMBOL_IF_KUNIT(arm_smmu_make_cdtable_ste);
>  
> -VISIBLE_IF_KUNIT
>  void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>  				 struct arm_smmu_master *master,
>  				 struct arm_smmu_domain *smmu_domain,
> @@ -2505,8 +2503,8 @@ arm_smmu_get_step_for_sid(struct arm_smmu_device *smmu, u32 sid)
>  	}
>  }
>  
> -static void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> -					 const struct arm_smmu_ste *target)
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target)
>  {
>  	int i, j;
>  	struct arm_smmu_device *smmu = master->smmu;
> @@ -2671,16 +2669,6 @@ static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,
>  	spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);
>  }
>  
> -struct arm_smmu_attach_state {
> -	/* Inputs */
> -	struct iommu_domain *old_domain;
> -	struct arm_smmu_master *master;
> -	bool cd_needs_ats;
> -	ioasid_t ssid;
> -	/* Resulting state */
> -	bool ats_enabled;
> -};
> -
>  /*
>   * Start the sequence to attach a domain to a master. The sequence contains three
>   * steps:
> @@ -2701,8 +2689,8 @@ struct arm_smmu_attach_state {
>   * new_domain can be a non-paging domain. In this case ATS will not be enabled,
>   * and invalidations won't be tracked.
>   */
> -static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> -				   struct iommu_domain *new_domain)
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain)
>  {
>  	struct arm_smmu_master *master = state->master;
>  	struct arm_smmu_master_domain *master_domain;
> @@ -2784,7 +2772,7 @@ static int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
>   * completes synchronizing the PCI device's ATC and finishes manipulating the
>   * smmu_domain->devices list.
>   */
> -static void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state)
>  {
>  	struct arm_smmu_master *master = state->master;
>  
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index 66261fd5bfb2d2..c9e5290e995a64 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -830,21 +830,22 @@ struct arm_smmu_entry_writer_ops {
>  	void (*sync)(struct arm_smmu_entry_writer *writer);
>  };
>  
> +void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
> +void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> +				 struct arm_smmu_master *master,
> +				 struct arm_smmu_domain *smmu_domain,
> +				 bool ats_enabled);
> +
>  #if IS_ENABLED(CONFIG_KUNIT)
>  void arm_smmu_get_ste_used(const __le64 *ent, __le64 *used_bits);
>  void arm_smmu_write_entry(struct arm_smmu_entry_writer *writer, __le64 *cur,
>  			  const __le64 *target);
>  void arm_smmu_get_cd_used(const __le64 *ent, __le64 *used_bits);
> -void arm_smmu_make_abort_ste(struct arm_smmu_ste *target);
>  void arm_smmu_make_bypass_ste(struct arm_smmu_device *smmu,
>  			      struct arm_smmu_ste *target);
>  void arm_smmu_make_cdtable_ste(struct arm_smmu_ste *target,
>  			       struct arm_smmu_master *master, bool ats_enabled,
>  			       unsigned int s1dss);
> -void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
> -				 struct arm_smmu_master *master,
> -				 struct arm_smmu_domain *smmu_domain,
> -				 bool ats_enabled);
>  void arm_smmu_make_sva_cd(struct arm_smmu_cd *target,
>  			  struct arm_smmu_master *master, struct mm_struct *mm,
>  			  u16 asid);
> @@ -902,6 +903,22 @@ static inline bool arm_smmu_master_canwbs(struct arm_smmu_master *master)
>  	       IOMMU_FWSPEC_PCI_RC_CANWBS;
>  }
>  
> +struct arm_smmu_attach_state {
> +	/* Inputs */
> +	struct iommu_domain *old_domain;
> +	struct arm_smmu_master *master;
> +	bool cd_needs_ats;
> +	ioasid_t ssid;
> +	/* Resulting state */
> +	bool ats_enabled;
> +};
> +
> +int arm_smmu_attach_prepare(struct arm_smmu_attach_state *state,
> +			    struct iommu_domain *new_domain);
> +void arm_smmu_attach_commit(struct arm_smmu_attach_state *state);
> +void arm_smmu_install_ste_for_dev(struct arm_smmu_master *master,
> +				  const struct arm_smmu_ste *target);
> +
>  #ifdef CONFIG_ARM_SMMU_V3_SVA
>  bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
>  bool arm_smmu_master_sva_supported(struct arm_smmu_master *master);
> -- 
> 2.46.2
> 
