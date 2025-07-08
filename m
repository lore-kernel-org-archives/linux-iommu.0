Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102702E0405
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751987757; cv=none; b=g7Zb2AGbhbPNQM9YOlFV+oDoe5ehT6PbdYitOpy/S/SpJPdDZmf3hrO7tfPy9L5h1L11xT3op2xN3yJo7udtIvx35zK4xdjPRDxxg2qfaXN3QmTqV57vKjDP1sw6mXgdRTRtbmUSTeeD3AVx3Ul2Kcdjh713qPmn3cDTRuEXfLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751987757; c=relaxed/simple;
	bh=otPvE4Uiq9QN12jJX5XYSaYy+H9tLypTGziYE3Mn944=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKoppaxdlnidvcDr3/G6cIaHiLXK4ZfqFIiEHN4mRp/dHkDnX+Jv8mzHTOGqOo6Z6qRgFN0p85ndGhdbk8fLDonrfV82dW4k0tRCmfuqAgwFDLxIoBqCkupkWmdbPad8cGrthyTHMSuEfChBwcK1MgCDQsKG47+5D1wjte9VXzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FQ8P2WKk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FQ8P2WKk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so92045e9.0
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 08:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751987754; x=1752592554; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d6uw4HXcjX4wLPWO/FIsceoxR6uobUgA7IaC9/31lDs=;
        b=FQ8P2WKkpbflbMMKjWQbqFoBKpo8SONRL63lKHd+VuT3KLtwJhKzyibwwp1Gg8GlpC
         yJv0yWqFLQMkMIYkoT86QKwOGQC9VWCSenpdQdx3f/v1vGtHoLowaV8cdhAzNf9KBFlu
         zQs6EGxari0NzJIYoW9yfjbMHFjTfw6N8ehSwLDdIIfPdY/bCqdryIfSKkxFa9Hg+/hE
         ahE2MSVc55E7e9H3uZ5yeN0oN8OXUGHLsX+bj4HjbOhy7PaA2iwjoUb6sR9tl3tuBebv
         jY+4BK2HaTPgn6SlJ4tHLq4TTEwAfSm+za+VtX/OyOxjnan6wpdUCPXvKIIfrlv/Ltaz
         MOIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751987754; x=1752592554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d6uw4HXcjX4wLPWO/FIsceoxR6uobUgA7IaC9/31lDs=;
        b=V5FP89dUfPjXtsJBDHtFN9O3aa391TmBapExLMXb5/JB19zjBXkxwCoxOhk2LLnMEI
         62uRVLidRgd5CcZTr4Mbc8MPtO7/tjlnvKvlWgfHCASx7hvh4D+Yf98ItWPQlCCnY6Ae
         EX4kkEG9Va/izv6be4ixBE36b9LJRFCg+kh4z9o6VdiV4NUHHIQkL0G+eu3alDPGVgui
         raRoFVxTF0Ui9ekqwgZeO2M0UZQ1fEP0SO22H1rM8M4QNyzvsRsHfe3UvMUET/h3/Qxh
         qZQklaIO23zi++Vq5NRV1eDNhEVJ7MJQcOwTcZMB7OtDLyOgKnJD0F1EzhI5aVIvDAfI
         xebQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1zDm1qLJUcvJXK9+lEImdmTLvO3z1ziPy0cvRcJ4wWzL8aKoryTmdbczdgZycoaGo6sbXew==@lists.linux.dev
X-Gm-Message-State: AOJu0YxhxY4U3GsSy4mKZWGLIi/woPhyC6n/qspwUk0j1hEbyLxxN/nJ
	8zWxXWAnpy+xx0E/UZJsgYa+tx5WoangydiOtt/9+tOUMZ4KdWn1MPGmiEw+AaSzBQ==
X-Gm-Gg: ASbGncvbOw6HU18zcqbhYlWkZRj7XP9CUAe9WZcA+jJNk2AS2GlTPBsdMwT1YPCsbgo
	16q6PrZDObr9odMo4FIxVWwus/2K1sqV1pbVpHXIpmCbLsgVOJnMltTKA87L8wKEc1hHQ98hhM8
	RrRwtJY1inxJR6prUrfK34vPykhR4K+RZOB8aDfRmewCbD3QHjN1VTZmrZfFDovHs0INwBK1y9B
	a5JkJzSa6pzeoq/XIj7OUdgSIw3Ysx6WPNAiWMZ4zQkixV3NrYirCKjqvVXlnsvrvQx2eeyxi0B
	gNhhnlyGJxWTzN1NYlltIOjw3VKuT0mQI8MslDJuFyu4Y+ibCdlgNWSrI1ADhD21Kmo7ttk/bZp
	9UZyAGKYBBASFLEavXAClETk/
X-Google-Smtp-Source: AGHT+IEjDGoZmrldbv7SPVjLhr3SZgCNlarh0wolwrSJyei3cszu/cOTCEfU/+z0RqKLNPptL6s6Fw==
X-Received: by 2002:a05:600c:a207:b0:453:6133:2e96 with SMTP id 5b1f17b1804b1-454cff332d1mr596565e9.0.1751987753645;
        Tue, 08 Jul 2025 08:15:53 -0700 (PDT)
Received: from google.com (232.38.195.35.bc.googleusercontent.com. [35.195.38.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5dfac598esm1712951f8f.101.2025.07.08.08.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:15:53 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:15:49 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 1/8] iommu/arm-smmu-v3: Refactor
 arm_smmu_setup_irqs
Message-ID: <aG02Jerz52qlAVG-@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616203149.2649118-2-praan@google.com>

On Mon, Jun 16, 2025 at 08:31:42PM +0000, Pranjal Shrivastava wrote:
> Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> registering interrupt handlers and the other one for enabling interrupt
> generation in the hardware. This refactor helps in re-initialization of
> hardware interrupts as part of a subsequent patch that enables runtime
> power management for the arm-smmu-v3 driver.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 53 ++++++++++++++-------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f50c26596416..f19a77708d2c 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4009,12 +4009,24 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  	}
>  }
>  
> -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +static void arm_smmu_enable_irqs(struct arm_smmu_device *smmu)
>  {
> -	int ret, irq;
> +	int ret;
>  	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
>  
> -	/* Disable IRQs first */
> +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> +		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +
> +	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> +				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
> +	if (ret)
> +		dev_warn(smmu->dev, "failed to enable irqs\n");
> +}
> +
> +static int arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret;
> +
>  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
>  				      ARM_SMMU_IRQ_CTRLACK);
>  	if (ret) {
> @@ -4022,6 +4034,18 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> +	return 0;
> +}

nit: it feels like making the function just as:

static int arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
{
	return arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
				      ARM_SMMU_IRQ_CTRLACK);
}

And print from the caller is less code and cleaner, but no strong opinion.

Reviewed-by: Mostafa Saleh <smostafa@google.com>

> +
> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_disable_irqs(smmu);
> +	if (ret)
> +		return ret;
> +
>  	irq = smmu->combined_irq;
>  	if (irq) {
>  		/*
> @@ -4038,15 +4062,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  	} else
>  		arm_smmu_setup_unique_irqs(smmu);
>  
> -	if (smmu->features & ARM_SMMU_FEAT_PRI)
> -		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> -
> -	/* Enable interrupt generation on the SMMU */
> -	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> -				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
> -	if (ret)
> -		dev_warn(smmu->dev, "failed to enable irqs\n");
> -
>  	return 0;
>  }
>  
> @@ -4189,11 +4204,8 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		}
>  	}
>  
> -	ret = arm_smmu_setup_irqs(smmu);
> -	if (ret) {
> -		dev_err(smmu->dev, "failed to setup irqs\n");
> -		return ret;
> -	}
> +	/* Enable interrupt generation on the SMMU */
> +	arm_smmu_enable_irqs(smmu);
>  
>  	if (is_kdump_kernel())
>  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> @@ -4778,6 +4790,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Check for RMRs and install bypass STEs if any */
>  	arm_smmu_rmr_install_bypass_ste(smmu);
>  
> +	/* Setup interrupt handlers */
> +	ret = arm_smmu_setup_irqs(smmu);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to setup irqs\n");
> +		goto err_free_iopf;
> +	}
> +
>  	/* Reset the device */
>  	ret = arm_smmu_device_reset(smmu);
>  	if (ret)
> -- 
> 2.50.0.rc2.692.g299adb8693-goog
> 
