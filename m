Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6978A83CB0
	for <iommu@lists.linux.dev>; Tue,  9 Apr 2024 10:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657994; cv=none; b=Hv3IB4ZVrAu186KlGdY7tCSsWFJ55oxCcDRGfzV1iw6at09DSpdrviZYqXw+tC1wuZbvzliK+jkx+CSImy3WsxUVYZ1TNZj40mWklYQewAw61Og7JBbYm2rZruYnw6UMzMM0JRDL6J31KZAHjS2xHog9D83JJNYQLpxGlAkQ8WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657994; c=relaxed/simple;
	bh=tcOP054x+9ZgaD9W4BOSWLo7ci79weNp6CEVlc2j5II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEviDyWSukjCsNnoPv0csVQeFXL9RFHvu+xQv/HWFkuLWjv0Nm0karJThrbFPoRzajhF5UwsOiPNGrzIjasjxUcHJ19+NX31dyyaH9AdGbJzdJSOm/fY4zU/cguOdAuIo7ey/sV8NXELdot3xvNL3wCXIxvJ1ani/HUhIgJF0hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YD2Nwwol; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YD2Nwwol"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4154d38ce9dso67365e9.0
        for <iommu@lists.linux.dev>; Tue, 09 Apr 2024 03:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712657991; x=1713262791; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J8juUJwLhUaK5YyOPk/qzvJU59mosWxulrYVn92pfJQ=;
        b=YD2NwwolTMSibwyTnsCYhD+9r3gM+VpP+n01ROnikDu6IYQRIr6/1vEksHYvtaEeox
         43gpGLEMHIaHQB617qFKqPj2nocSfOZ6HA80PHCNLE4X91mNpwkZ1LQt5l7ZJvOXRRDn
         KKKUA1S2OWWlQKK58lggMIEeGUSRHAhd5ufKVHfF8JRm8usuwzBxqNgRYQgMUm/8yIgx
         i9bBmVqW1Zzzi+fJuWaLBNOAoEMgTq6AvASZCEibDxej4QqNnmCC7EE8QyM7ivBSOezh
         loi4UleFYdrVeYgPmcUr9ogD7Mv4co59xcNB121Ftp9fZ10rKtlBxSxC7asx6oQIhhy3
         hXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712657991; x=1713262791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8juUJwLhUaK5YyOPk/qzvJU59mosWxulrYVn92pfJQ=;
        b=ug1Eaem42tNaYPzOW3lVp9oLfWKMtlnBOfUPsCew1HBHm3aRvv4LtQeoU6Bau2sEbX
         y9Aen9Qw2WFpFcLXfY35M3m0v1qDQRGe8cNcMq+Fu1YpNPMC0EV4zesEQ6GqctPfhd4Z
         3jjyPwchtkGtGB+GnaaCLrf8OqsJRm567GwCAIdGMFm6ij1JqpV4E9b/ph9OfhKpifva
         qKOcox7BzzDpL7bXP+kJ02mCNoaXxpetE7fEQHgYHslt54v/xFBz77kh74VvAiFpy7lh
         WIJQWKjvJxyrDNUkm5UyMaE7VIKLAzcaVsUYF+aL37VoNaOY9f2DEGkZx6+ZVhPL6XlG
         hGFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAAQj8BDbLVM0nWpSJ81VOtWM3IpBeyUXsDycdIeFWAjLceo814ecQ5JUo0EKAL7CO27mXOk4TdlUuoQ148fWUpAwMNhg=
X-Gm-Message-State: AOJu0YyhnNpvlzELwBqIOUekLF46vdejrWTN6vMYbWRgc9P++vktMjYi
	eqVaZmR7/Fjrok++sNy+0sobrxnwjNQiLBb2sqLMNXabPcWXp1YddzF4Iak+y0RkK9B2XlUbPvl
	4ew==
X-Google-Smtp-Source: AGHT+IEQxud1V1Zbs0fuLsx1yc6EmCyxxeCAV4JhVRqNIvaKVbkdx6uI4b69x0IaG5bE+zD8pN4CYw==
X-Received: by 2002:a05:600c:3b8c:b0:415:4436:2a12 with SMTP id n12-20020a05600c3b8c00b0041544362a12mr107628wms.3.1712657990564;
        Tue, 09 Apr 2024 03:19:50 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com. [34.140.232.180])
        by smtp.gmail.com with ESMTPSA id dm14-20020a0560000bce00b003437a76565asm11065958wrb.25.2024.04.09.03.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 03:19:50 -0700 (PDT)
Date: Tue, 9 Apr 2024 10:19:46 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: will@kernel.org, joro@8bytes.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iommu/arm-smmu-v3: Retire disable_bypass parameter
Message-ID: <ZhUWQrnE3uow6wuY@google.com>
References: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea3ac4cd595a81b5511729601b2f7d4668178438.1712335927.git.robin.murphy@arm.com>

Hi Robin,

On Fri, Apr 05, 2024 at 05:52:07PM +0100, Robin Murphy wrote:
> The disable_bypass parameter has been mostly meaningless for a long time
> since the introduction of default domains. Its original intent is now
> fulfilled by the controls users have over the default domain type, and
> its remaining effect in the brief window between Stream Table
> initialisation and default domain creation hardly seems worth the
> complication. Furthermore, thanks to 2-level Stream Tables, disabling
> disable_bypass (there's another reason not to like it right there) has
> never guaranteed that any particular StreamID *will* bypass anyway - any
> device which might actually care about that wants RMRs - so there's not
> really much lost by taking away that option (which has already been
> non-default for nearing 6 years now).
> 
> As part of this, also remove the weird behaviour where we "successfully"
> probe and register a non-functional SMMU if the DT "#iommu-cells"
> property is wrong. I have no memory of what possessed me to think that
> was a good idea at the time, and by now I suspect it's likely to break
> things worse than simply failing probe would.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Mostafa Saleh <smostafa@google.com>

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 46 ++++++---------------
>  1 file changed, 13 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 41f93c3ab160..4eb74f0ad13b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -30,11 +30,6 @@
>  #include "arm-smmu-v3.h"
>  #include "../../dma-iommu.h"
>  
> -static bool disable_bypass = true;
> -module_param(disable_bypass, bool, 0444);
> -MODULE_PARM_DESC(disable_bypass,
> -	"Disable bypass streams such that incoming transactions from devices that are not attached to an iommu domain will report an abort back to the device and will not be allowed to pass through the SMMU.");
> -
>  static bool disable_msipolling;
>  module_param(disable_msipolling, bool, 0444);
>  MODULE_PARM_DESC(disable_msipolling,
> @@ -1567,17 +1562,13 @@ static void arm_smmu_make_s2_domain_ste(struct arm_smmu_ste *target,
>   * This can safely directly manipulate the STE memory without a sync sequence
>   * because the STE table has not been installed in the SMMU yet.
>   */
> -static void arm_smmu_init_initial_stes(struct arm_smmu_device *smmu,
> -				       struct arm_smmu_ste *strtab,
> +static void arm_smmu_init_initial_stes(struct arm_smmu_ste *strtab,
>  				       unsigned int nent)
>  {
>  	unsigned int i;
>  
>  	for (i = 0; i < nent; ++i) {
> -		if (disable_bypass)
> -			arm_smmu_make_abort_ste(strtab);
> -		else
> -			arm_smmu_make_bypass_ste(smmu, strtab);
> +		arm_smmu_make_abort_ste(strtab);
>  		strtab++;
>  	}
>  }
> @@ -1605,7 +1596,7 @@ static int arm_smmu_init_l2_strtab(struct arm_smmu_device *smmu, u32 sid)
>  		return -ENOMEM;
>  	}
>  
> -	arm_smmu_init_initial_stes(smmu, desc->l2ptr, 1 << STRTAB_SPLIT);
> +	arm_smmu_init_initial_stes(desc->l2ptr, 1 << STRTAB_SPLIT);
>  	arm_smmu_write_strtab_l1_desc(strtab, desc);
>  	return 0;
>  }
> @@ -2915,10 +2906,10 @@ static void arm_smmu_release_device(struct device *dev)
>  		iopf_queue_remove_device(master->smmu->evtq.iopf, dev);
>  
>  	/* Put the STE back to what arm_smmu_init_strtab() sets */
> -	if (disable_bypass && !dev->iommu->require_direct)
> -		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
> -	else
> +	if (dev->iommu->require_direct)
>  		arm_smmu_attach_dev_identity(&arm_smmu_identity_domain, dev);
> +	else
> +		arm_smmu_attach_dev_blocked(&arm_smmu_blocked_domain, dev);
>  
>  	arm_smmu_disable_pasid(master);
>  	arm_smmu_remove_master(master);
> @@ -3273,7 +3264,7 @@ static int arm_smmu_init_strtab_linear(struct arm_smmu_device *smmu)
>  	reg |= FIELD_PREP(STRTAB_BASE_CFG_LOG2SIZE, smmu->sid_bits);
>  	cfg->strtab_base_cfg = reg;
>  
> -	arm_smmu_init_initial_stes(smmu, strtab, cfg->num_l1_ents);
> +	arm_smmu_init_initial_stes(strtab, cfg->num_l1_ents);
>  	return 0;
>  }
>  
> @@ -3503,7 +3494,7 @@ static int arm_smmu_device_disable(struct arm_smmu_device *smmu)
>  	return ret;
>  }
>  
> -static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
> +static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  {
>  	int ret;
>  	u32 reg, enables;
> @@ -3513,7 +3504,6 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	reg = readl_relaxed(smmu->base + ARM_SMMU_CR0);
>  	if (reg & CR0_SMMUEN) {
>  		dev_warn(smmu->dev, "SMMU currently enabled! Resetting...\n");
> -		WARN_ON(is_kdump_kernel() && !disable_bypass);
>  		arm_smmu_update_gbpa(smmu, GBPA_ABORT, 0);
>  	}
>  
> @@ -3620,14 +3610,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
>  	if (is_kdump_kernel())
>  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>  
> -	/* Enable the SMMU interface, or ensure bypass */
> -	if (!bypass || disable_bypass) {
> -		enables |= CR0_SMMUEN;
> -	} else {
> -		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
> -		if (ret)
> -			return ret;
> -	}
> +	/* Enable the SMMU interface */
> +	enables |= CR0_SMMUEN;
>  	ret = arm_smmu_write_reg_sync(smmu, enables, ARM_SMMU_CR0,
>  				      ARM_SMMU_CR0ACK);
>  	if (ret) {
> @@ -4019,7 +4003,6 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	resource_size_t ioaddr;
>  	struct arm_smmu_device *smmu;
>  	struct device *dev = &pdev->dev;
> -	bool bypass;
>  
>  	smmu = devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
>  	if (!smmu)
> @@ -4030,12 +4013,9 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  		ret = arm_smmu_device_dt_probe(pdev, smmu);
>  	} else {
>  		ret = arm_smmu_device_acpi_probe(pdev, smmu);
> -		if (ret == -ENODEV)
> -			return ret;
>  	}
> -
> -	/* Set bypass mode according to firmware probing result */
> -	bypass = !!ret;
> +	if (ret)
> +		return ret;
>  
>  	/* Base address */
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -4099,7 +4079,7 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	arm_smmu_rmr_install_bypass_ste(smmu);
>  
>  	/* Reset the device */
> -	ret = arm_smmu_device_reset(smmu, bypass);
> +	ret = arm_smmu_device_reset(smmu);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.39.2.101.g768bb238c484.dirty
> 
Thanks,
Mostafa
