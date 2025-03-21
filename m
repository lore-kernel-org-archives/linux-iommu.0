Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD11EBFFC
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742541981; cv=none; b=Zak7rGWRWL5BHu5GTQNc6gxm28CbaUvv1QItjEsYnIhX+vIvzdOCG/gVtg4T4hxLNaovw8DKEv8pvaXozM1TH63RbgrQDgtnxTF5mwWusCiA5NrvUaX05kFMhtRtWIfbek1J6wz2bWvBprR7lRlJhXsWOBp2AEaeGdAy5zIraIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742541981; c=relaxed/simple;
	bh=qQR5QMpkbOpyRyZZA4E3XSQcHWw1mXUgRSxLKyZLlKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pN51XWmSjUw/tC9xt6sKeqPS2RhlWaRoFrGrGFByyFBHI+zBuJHWvbhSXFna6bogtm4wysX1t6H1AlPCR3246TbqQVKm75/jhMiNj64B+EyWB7ipbhPHWn9QVHvR4O3V28fVX19r7Hq4DVEIKuTMoCEk6N9eaTk/kL2NNrZmpV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tfovwX5m; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfovwX5m"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2242ac37caeso91815ad.1
        for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742541979; x=1743146779; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+xOiwNRjUV6+qgHBl1tvSN1VkQAdLwq2IMT8oCJn/Us=;
        b=tfovwX5mu1m5k1fh7sO3+tilMDlKyjJPi4dpZrKJhhQo+mGF9PuwD4LjSi35alc6Rs
         38ZhadVovzBhAOLjYtP8M88cZtdrmPA/NFj/DBMWQBosz9AwBh/P5HSgEFYoCYoP8SMB
         pPhRMKKP/y6luSS6EcjbcJgRcn0eyPtc6EZfsj4SXX3wOVbEdDlBml+P8ov1mY4VcNOx
         D2lmnwc8NqvfQWcZqXUFRY3+iYcf99qNjIbgWIoSrSA3DQzJ+LrZTCq9iA8mVUkKEm2V
         uYanZGGDzWf+YGtwVYI5tw5De+b2QeGJuK9lQgthW0zT3uzkX+/4zL//2nczY4o6vj/T
         /Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742541979; x=1743146779;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xOiwNRjUV6+qgHBl1tvSN1VkQAdLwq2IMT8oCJn/Us=;
        b=fsF/J0Zjq+RYq/Ij687i/CGicrZxLDYcrHkX1m/k8N137Z7UkgbdBYpNA6mcbnWWFb
         RA4BckKvn4xjAv+t4cTLJPZ8XP7DiAoc7qzsCLt2mRbuxokjWWCiiB1H1ysb1X9oBCLd
         1MtlEneL3h1hKmAUNHCK4UW6uw7f/8PqQE6cs2p/KFgg9qLx4EiYUuwA1Ay/+1jD5RqH
         OdLDPdsoOeHWIsEhdPr5A43Rs9oAYZyUFhuLzT+xkIvjf2Svx5Birl5zhReALKZS7iIA
         m8Elhv7dWXPn8Lqejvm2UWamXBBI9tzPA8FrxqWTpv68gfG6XMoR23IYEdOyKErALygE
         AsUg==
X-Forwarded-Encrypted: i=1; AJvYcCUsnDbUCakYqlXJ76/Xl/JL7KPoK4fH3xuUg/morwiqnULppOTdBrB4ihpGK/MgccY4U0kMjw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIobntVUlq7SG/boNuSlMzjY7t9ZLtF+HYgN4unss+5vP7gP6D
	vWT6iR16z5jNx7fE8eTpMYqp13U3WuOknsSQ1PS0bA75E0HrS76WcRJfFi6JYw==
X-Gm-Gg: ASbGncskpawnZe/Thg681gD+lITif8XFGbLyxaygMAjN3XQTsTZC+3sUPvxWK/5Rbpw
	gJWm8qU0FkYJcw1uC/PaSmRQ7PXU8pQlzNqYVajhq8br4Uh+gzsLKWr6CjET+eYdfRycUk0ZshA
	w5s7LjF/OjUzb8P5/fvUeada3ZjxyimPAGJ32h7bdG/BuMK0AcjxxAwuN+UFZtjaHXHxLiqnMAJ
	sE6EPNAIn1Q13E+FLSTaXpK2fZgzoL6DjBLITRZIkD6+wrDbdK8JjMGN8Ar7Nb6MhWtTel/OGiR
	gqKR2dUT2mTUTDOKFFyPAHL+5UvPKt/rUIAvdzR43HXweRn1nFX2gf6/N3HO6nFEad732R4losS
	2Adww7UIcBeWuCw==
X-Google-Smtp-Source: AGHT+IH2Ozxfs3dj/O62Z20ezSMQb8Fhh8dEr1Y/HBTFGTJxcjbFMRTB7QEvTSUxr4BxaJCi/+lPPQ==
X-Received: by 2002:a17:902:d58d:b0:200:97b5:dc2b with SMTP id d9443c01a7336-227844c1aaamr1729155ad.15.1742541979343;
        Fri, 21 Mar 2025 00:26:19 -0700 (PDT)
Received: from google.com (188.152.87.34.bc.googleusercontent.com. [34.87.152.188])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301bf58c243sm5255999a91.16.2025.03.21.00.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:26:18 -0700 (PDT)
Date: Fri, 21 Mar 2025 07:26:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Mostafa Saleh <smostafa@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH 1/5] iommu/arm-smmu-v3: Refactor arm_smmu_setup_irqs
Message-ID: <Z90Uk6UiBij2nXKH@google.com>
References: <20250319004254.2547950-1-praan@google.com>
 <20250319004254.2547950-2-praan@google.com>
 <Z9yW1r1rkYbCPUIX@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z9yW1r1rkYbCPUIX@google.com>

On Thu, Mar 20, 2025 at 10:29:42PM +0000, Mostafa Saleh wrote:
> On Wed, Mar 19, 2025 at 12:42:50AM +0000, Pranjal Shrivastava wrote:
> > Refactor arm_smmu_setup_irqs by splitting it into two parts, one for
> > registering interrupt handlers and the other one for enabling interrupt
> > generation in the hardware. This refactor helps in re-initialization of
> > hardware interrupts as part of a subsequent patch that enables runtime
> > power management for the arm-smmu-v3 driver.
> > 
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> > ---
> >  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 50 ++++++++++++++++-----
> >  1 file changed, 38 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > index 358072b4e293..80362d9f293b 100644
> > --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> > @@ -3985,12 +3985,24 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
> >  	}
> >  }
> >  
> > -static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > +static void arm_smmu_enable_irqs(struct arm_smmu_device *smmu)
> >  {
> > -	int ret, irq;
> > +	int ret;
> >  	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> >  
> > -	/* Disable IRQs first */
> > +	if (smmu->features & ARM_SMMU_FEAT_PRI)
> > +		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> > +
> > +	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> > +				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
> > +	if (ret)
> > +		dev_warn(smmu->dev, "failed to enable irqs\n");
> > +}
> > +
> > +static int arm_smmu_disable_irqs(struct arm_smmu_device *smmu)
> > +{
> > +	int ret;
> > +
> >  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> >  				      ARM_SMMU_IRQ_CTRLACK);
> >  	if (ret) {
> > @@ -3998,6 +4010,19 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> >  		return ret;
> >  	}
> >  
> > +	return 0;
> > +}
> > +
> > +static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> > +{
> > +	int ret, irq;
> > +
> > +	/* Disable IRQs first */
> > +	ret = arm_smmu_disable_irqs(smmu);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> >  	irq = smmu->combined_irq;
> >  	if (irq) {
> >  		/*
> > @@ -4014,15 +4039,6 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
> >  	} else
> >  		arm_smmu_setup_unique_irqs(smmu);
> >  
> > -	if (smmu->features & ARM_SMMU_FEAT_PRI)
> > -		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> > -
> > -	/* Enable interrupt generation on the SMMU */
> > -	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> > -				      ARM_SMMU_IRQ_CTRL, ARM_SMMU_IRQ_CTRLACK);
> > -	if (ret)
> > -		dev_warn(smmu->dev, "failed to enable irqs\n");
> > -
> >  	return 0;
> >  }
> >  
> > @@ -4171,6 +4187,9 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu)
> >  		return ret;
> >  	}
> >  
> > +	/* Enable interrupt generation on the SMMU */
> > +	arm_smmu_enable_irqs(smmu);
> > +
> >  	if (is_kdump_kernel())
> >  		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
> >  
> > @@ -4754,6 +4773,13 @@ static int arm_smmu_device_probe(struct platform_device *pdev)
> >  	/* Check for RMRs and install bypass STEs if any */
> >  	arm_smmu_rmr_install_bypass_ste(smmu);
> >  
> > +	/* Setup interrupt handlers */
> > +	ret = arm_smmu_setup_irqs(smmu);
> > +	if (ret) {
> > +		dev_err(smmu->dev, "failed to setup irqs\n");
> 
> Every path that can fail in this function has a print already, I’d say
> remove the ones inside and keep this one, that also simplifies
> arm_smmu_disable_irqs() to one line.

I guess as per Nicolin's comment, this call would go away and only be
called during probe. But yes the enable_irqs() will be here. I guess I
could move the print statement out of enable irqs and put it here?

The arm_smmu_disable_irqs will be called from the setup_irqs mainly,
during probe, so I think we could leave it's print as is..

> 
> Otherwise, besides Nicolin’s comment, it looks good.
> 
> Thanks,
> Mostafa

Thanks,
Praan

