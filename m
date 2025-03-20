Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C282A1B422A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742509790; cv=none; b=Zp412c17Gh6Z0HVrbtxrNAQtnc3xsQiWPfAH/x9iaxk2gZsFKkX6UqWWtB8jGQaZiQBZMBamUR4/EY7rIg4vBowQZndcyPfMWeoRpOvWy+9tvujiVvh2CaLF+N5APA/qwc03odeqdJiNSjj2XDzxH6/PEm8Yhw6XeJti0xqCAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742509790; c=relaxed/simple;
	bh=wUiUEeov85hAcvm1/URwwkp5IfdNC66r7RfO9shG7TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXov7CynQNQdOH68Xepe3cXsakD3VogV+ldfJKfoqxX0kpqzAzh3h++/KEe+om9T+HX0lqywZlyzPNyjrsJgcmJBh/8stXI/Q0XGfqyclfhsKC4dW3wSuAlT7CBaEC+HrIATVyk9tMBU9szOomJEkyGMZlkwjizzHK7TTzLX6mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HcfTD3T; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HcfTD3T"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4393ee912e1so9605e9.1
        for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 15:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742509787; x=1743114587; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMMTDU4Cy71rRik58ytrkf8iIeWHToiaHgslSsn8E34=;
        b=1HcfTD3TDMDvIKoVR2zcUeUn9akOlOpYkBSopACAi9gmchz8fzscj2p7khR3WfuvIy
         IoFnZZZbwskbPpWSldGBK5/O2R97JWCn4sDb2CrDLnpqKOq7fhUTBGRPY1DA1kHUmOLC
         41JGGgu9N3ipWFVdhfzvDE6k3ru171rW4TmLwo1b9lr1qAbsEaAOHYSqNvHIb0Lqu+z0
         BTud6Igub4NExM7mZH6jFibLep2mm+pb/7UZicw6fgBW5TJkcZK0z7cx+la6a4SKIBMb
         jtnGYoaQFF3kLt9N7qbDMXW/e9ga+0h2ftCjpQ75EExCJijrycCMrkhkntqjEymeGLle
         ZMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742509787; x=1743114587;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMMTDU4Cy71rRik58ytrkf8iIeWHToiaHgslSsn8E34=;
        b=ee7p2vuu0XaFREXmCHr6Rt/SRVrTRcmhD8XZG09ji67H5jyMwbOTNyzpoINqSv55Y3
         ixfgTnyNEyjmDkYMpcj38msImHM2BtqByC2CIGWvnZHsH++ao1JcG80FZAqVjrSexCfG
         ntvv8UV3lifUNBoxHupOCc7FqJDkfJQyxdMBdrkAsCZuOg0cUMdyK1b6qTqUwTuT66Ol
         73MK1Wu/T9sycZkaaiEEBrM4/1kmZ+te+aoc3zNSTTECJD3IhRqHVXlbcPMwS3RqJvfW
         wsFxAU6+mnQrCjvlG4XykVCwYB9ZNkfBqHcb3OxteHynsSF5d1n31mj5XpSwrKrz8LI7
         eBcA==
X-Forwarded-Encrypted: i=1; AJvYcCWBSqEKb+J/EShvuzhwWZaPNlgPuj6O6Y6z3ZGB/0UFTuEMt4VFmIF/qBt26+9zMbofxVNHOA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxy0kp6cClHU2K/wJruWeOqV5bj4ClNTzdI323uOSxjnrygf6Bk
	pWntZwotwEh+rsJKwARX+BFwo5RdUESZ+u18KAhfGLguCJQMOr8xUMGDoA26Bg==
X-Gm-Gg: ASbGncu4lwwU3MmLyKvWZ8f/p/saySz2bbGvNrI/nQrHi7O7kFIwyFFDkCfV25i2EjL
	fFd0VNJuFQ4AKMaQjAoEIKOVX0Yxfd3xEg52j34nKVyU7p4MUQud6TcBpYmgGmTzMVxsnhIUNAn
	bKrMzhgC90N/x4OshLYGm7AW27soUdbUfMdOgw7L8MAMUBazJKLgnaLhjhu4OiJCqwXPQYVGMOM
	hOBXlE4i6uP2IfeI9uWIXd9zJwHpjZhmGICMrDTDDxDEdQ0fVcyFaYILhedVRZqCpV5qS95C/En
	8oeHKKMfAcmzIw+Imliz/t3QGDF5qi1++4ewYf4kggH2GFQ2aufYLJjjVD6Vg8eXDnQOWTSnUQr
	7+HHw
X-Google-Smtp-Source: AGHT+IHRQaLr8uFYaC8iXQFvBrg65Je5tV7TDN9/f77y3dS5ibVbcksh+ETNYIw6rLTN3unDiYkhDw==
X-Received: by 2002:a05:600c:4f12:b0:43b:bf3f:9664 with SMTP id 5b1f17b1804b1-43d515d38eemr121215e9.5.1742509786743;
        Thu, 20 Mar 2025 15:29:46 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fd28a46sm9552885e9.24.2025.03.20.15.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 15:29:46 -0700 (PDT)
Date: Thu, 20 Mar 2025 22:29:42 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <Z9yW1r1rkYbCPUIX@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-2-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250319004254.2547950-2-praan@google.com>

On Wed, Mar 19, 2025 at 12:42:50AM +0000, Pranjal Shrivastava wrote:
> Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> registering interrupt handlers and the other one for enabling interrupt
> generation in the hardware. This refactor helps in re-initialization of
> hardware interrupts as part of a subsequent patch that enables runtime
> power management for the arm-smmu-v3 driver.
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++++-----
>  1 file changed, 38 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 358072b4e293..80362d9f293b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3985,12 +3985,24 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
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
> @@ -3998,6 +4010,19 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> +	return 0;
> +}
> +
> +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> +{
> +	int ret, irq;
> +
> +	/* Disable IRQs first */
> +	ret = arm_smmu_disable_irqs(smmu);
> +
> +	if (ret)
> +		return ret;
> +
>  	irq = smmu->combined_irq;
>  	if (irq) {
>  		/*
> @@ -4014,15 +4039,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
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
> @@ -4171,6 +4187,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
>  		return ret;
>  	}
>  
> +	/* Enable interrupt generation on the SMMU */
> +	arm_smmu_enable_irqs(smmu);
> +
>  	if (is_kdump_kernel())
>  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>  
> @@ -4754,6 +4773,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
>  	/* Check for RMRs and install bypass STEs if any */
>  	arm_smmu_rmr_install_bypass_ste(smmu);
>  
> +	/* Setup interrupt handlers */
> +	ret = arm_smmu_setup_irqs(smmu);
> +	if (ret) {
> +		dev_err(smmu->dev, "failed to setup irqs\n");

Every path that can fail in this function has a print already, I’d say
remove the ones inside and keep this one, that also simplifies
arm_smmu_disable_irqs() to one line.

Otherwise, besides Nicolin’s comment, it looks good.

Thanks,
Mostafa

> +		return ret;
> +	}
> +
>  	/* Reset the device */
>  	ret = arm_smmu_device_reset(smmu);
>  	if (ret)
> -- 
> 2.49.0.rc1.451.g8f38331e32-goog
> 
