Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61734A7CA7
	for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790165013; cv=none; b=fGcfTUHRy9iHt+1eVmq+dxcDYutdb8vqVI2UksuXc88ITp2Y3lc+UgS4u/X1R18vzftJoCkiI4oqZc6+ZNu6D7WBdO0ejy7Nv8hnV7OskRIzRvO5Ow1+7/4ZJQSPKU6yXebc+5U4jW1mEYf3DwOtlO2ZT/33IqwMZjnWh43GdeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790165013; c=relaxed/simple;
	bh=H2NPzrrws0FqCnXLTgS7FTxVhyxjuGqZv7SYvPCD6qc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRv6fzpbZKtIBidXRhlIONksBkAEXnRJxtTV4+RLIpv0MIqLYkBor+MTUTBpVdrhYPayqRGEidK1Q7kr8YV7LBsia0uw+r5BNNNOFa6dc8B+pIaBa7ai02hP2ZZJZlTeqgIimVM5UbrP1oc0Hb1O35Li9F3cEuFSwthKqk1DlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M0bV8tDm; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M0bV8tDm"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49e6425f96eso40745e9.1
        for <iommu@lists.linux.dev>; Wed, 23 Sep 2026 05:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790165000; x=1790769800; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jivi9KM6L+A+vDAYK+1HL6GBVOU14mX2y+wEPboH2kM=;
        b=M0bV8tDmFc2rwYUjd2lQTyVEtKfGUYLAFldZvttF8n7w4++srW4/Tm8dtW5567aESZ
         t3IvQjjws1RCEPQwrbIekEcOULK5ltwsZ31fnaP/OwQgOSG8x5YgpCp79uJKto8ucR3S
         7xlcF6off0iV8Gdch6uAOlecunBeXmoynOaUcZbHAchu2n+pUndQI6n82TvmWrKTJ4g+
         IeA1rXDO3Opej01N4Pe034scgq7+PMoP/XKjOd71e+Cv1iBzfUkt4zZ1W92+gaj4Ba17
         LXu1droOkbbHn0JI9tB83wlYnebXbUim2Ern9QP9AOEAOA5h73UKpCuyZZ9EllMHlE4q
         dlXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790165000; x=1790769800;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jivi9KM6L+A+vDAYK+1HL6GBVOU14mX2y+wEPboH2kM=;
        b=ZkhwE2/v7oh6WYrgJrirtFT42t6D4umPnxgL4F91mR11rLlHHXhlRO0i/609Zrpby9
         tZGcKXn0JrlQw4auxVMQgrJ8Nob7O2UCXFDjB/HocbV1suauTriIs5NUoARx5rodp79U
         hSHvyun0HPmjRtdBowjkppJz/ULOqK3WS6Z1laFCMWRUgw1UZPhcBj73Z0b5sl1rHaVT
         v55fcxLUML0HLsAtGk9pgXHnMgoVs1CBEKeIAY1jFG9KzOq2Wtk4vcXiG7ehJLwcGkqF
         s31iI8VaLHz2Rwnaohe8DUt/Rlb0HhV9EIVZ54+9YVDgGFPUnbtHNBXap/ulj65IsMd4
         AIvQ==
X-Forwarded-Encrypted: i=1; AKwUvBwMPN7OmC6sFHsizHRx6/duvrgvIbWvwbDtuHsmTgtlv2M8FEdCSa6fM6+TREEdsFQmtu07Gg==@lists.linux.dev
X-Gm-Message-State: AFuF++ljsBv1FTWJE/KBxPetVHvoL7yhRynS5Kgo4FU51ZBkh1GwbFYf
	C+EGtDnUTjm5xJclMtd3SUx01YMC5pSnt7uoedZwp3PA6obLT7lD2jBQvcqHnYPxTQ==
X-Gm-Gg: AYBFou3S0gARgw5BgruQr0A+Zgwksswzq1cNZCkmzrmyu/ebWj0rbHkn2yBZ9l2IsUz
	1lAYfrg1CRdD4wL/KfrHnr3DBfDzSlVkyYtqeP6ihczDFTW4Laf/X9YOmmJ8vjCifbiEVyDjLEx
	UzeeSp0yQbJ+UAfTdfS8IRF+BbR+aPNPxgz7lZ7aqJpv5ZE2JZEuk6KbVsa6TqYOH/xOuzGswmr
	VzrsrBnqMm55tTyt31Yim6wU21NChEfZQMcXYoDuAx7otJVBMqtXVnIS/qO6rfA4dGfbkJhh/TE
	mqDlWqVwgCwaDlxSwhollAvYFGj9q527D5vfNkGmE2Zhjm3JTT/3MmcJS/NHOO7YupWrJrdwUBO
	W5cHA7movZ3Cy1YGQnY9Lp9jUACOOmwbtMnP2ONng0/KUarW1aMkchBVo20xp5NvcEPKDTg43IN
	lMWkEn4qLTtlGCyzkf0hFvA26rf4aLZMdlI1wpuJyMYmlkGF71tFZAmHVzrAm7yrXeaGb1tOwyN
	g6pC9YC/HJD4Gtcpo2zh/gStmqzZnZGyN1SqxZ+IU+b1YgQjxc=
X-Received: by 2002:a05:600c:35c3:b0:49d:24e2:5454 with SMTP id 5b1f17b1804b1-49fe0c4a230mr920275e9.13.1790164999501;
        Wed, 23 Sep 2026 05:03:19 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1ccb90sm73291145e9.6.2026.09.23.05.03.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 05:03:16 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:03:12 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kvmarm@lists.linux.dev, iommu@lists.linux.dev,
	catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
	oliver.upton@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, joro@8bytes.org, jgg@ziepe.ca,
	mark.rutland@arm.com, qperret@google.com, tabba@google.com,
	vdonnefort@google.com, sebastianene@google.com, keirf@google.com
Subject: Re: [PATCH v8 12/25] iommu/arm-smmu-v3-kvm: Probe SMMU HW
Message-ID: <arPAAK_O0d68dorh@google.com>
References: <20260922131259.2975334-1-smostafa@google.com>
 <20260922131259.2975334-13-smostafa@google.com>
 <arMu0An215TY3tM9@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arMu0An215TY3tM9@nvidia.com>

On Tue, Sep 22, 2026 at 06:43:44PM -0700, Nicolin Chen wrote:
> On Tue, Sep 22, 2026 at 01:12:45PM +0000, Mostafa Saleh wrote:
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3-hyp.h
> > @@ -11,6 +11,9 @@
> >   *
> >   * Other members are filled and used at runtime by the SMMU driver.
> >   * @base		Virtual address of SMMU registers
> > + * @oas			PA size
> > + * @pgsize_bitmap	Supported page sizes
> > + * @sid_bits		Max number of SID bits supported
> >   */
> 
> Some of them belongs to one of the prior patches.
> 
> And, if we are going to list them all, could we do in kdoc style?

I will fix it.

> 
> > +++ b/drivers/iommu/arm/arm-smmu-v3/pkvm/arm-smmu-v3.c
> > @@ -29,6 +29,47 @@ static void smmu_deinit_device(struct hyp_arm_smmu_v3_device *smmu)
> >  	smmu->base = NULL;
> >  }
> >  
> > +/*
> > + * Mini-probe and validation for the hypervisor.
> > + */
> > +static int smmu_probe(struct hyp_arm_smmu_v3_device *smmu)
> > +{
> > +	u32 reg;
> > +
> > +	if (!(smmu->features & ARM_SMMU_FEAT_COHERENCY))
> > +		return -EINVAL;
> 
> Does this need to check IDR0.COHACC? If not, an inline note that
> explains why?
> 

This is similar to the kernel driver logic, where FW will override
coherency and in case of mismatch the driver will just WARN and trust
the FW.
pKVM can't print a warning as WARN is fatal in EL2. So it just picks
what the FW says. I am not sure what systems rely on this, but I can
add more strict checks and fail probe in case of mismatch with pKVM.

> > +
> > +	reg = arm_smmu_idr0_probe(smmu);
> > +
> > +	if (!(FIELD_GET(IDR0_TTF, reg) & IDR0_TTF_AARCH64))
> > +		return -ENXIO;
> > +
> > +	if (!(smmu->features & (ARM_SMMU_FEAT_TT_LE | ARM_SMMU_FEAT_TT_BE)))
> > +		return -ENXIO;
> > +
> > +	reg = readl_relaxed(smmu->base + ARM_SMMU_IDR1);
> > +	if (reg & (IDR1_TABLES_PRESET | IDR1_QUEUES_PRESET | IDR1_REL))
> > +		return -EINVAL;
> > +
> > +	smmu->sid_bits = FIELD_GET(IDR1_SIDSIZE, reg);
> > +	/* Follows the kernel logic */
> > +	if (smmu->sid_bits <= STRTAB_SPLIT)
> > +		smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> 
> The IDR1 reg guard and sid_bits can be shared with the main driver.
> 
> Maybe add an arm_smmu_device_idr1_probe()?
> 

I thought about that, but this will be only used for sid_bits, the
hypervisor struct doesn't have ssid_bits as it doesn't use it, it
only shadows the STE and not the CD as the CD is translated by stage-2.

Other fields also not used by the hypervisor (PRIQS, EVTQS...)

As sashiko pointed, I will need to add ARM_SMMU_FEAT_ATTR_TYPES_OVR
check in the hypervisor, so maybe arm_smmu_device_idr1_probe() can be added
to partially probe the register and return the value so it can be probed the
main driver.

> > +
> > +	arm_smmu_idr3_probe(smmu);
> > +
> > +	arm_smmu_idr5_probe(smmu);
> > +	if (!smmu->oas)
> > +		smmu->oas = 48;
> 
> The truncation can be shared with the main driver too?

The main driver will print an error, if arm_smmu_idr5_probe() fix it
silently we will lose that.

> 
> > @@ -43,8 +84,14 @@ static int smmu_init_device(struct hyp_arm_smmu_v3_device *smmu)
> >  		return ret;
> >  
> >  	smmu->base = (void __iomem *)haddr;
> > +	ret = smmu_probe(smmu);
> > +	if (ret)
> > +		goto out_ret;
> >  
> >  	return 0;
> > +out_ret:
> > +	smmu_deinit_device(smmu);
> 
> Nit: out_deinit

Sure.

Thanks,
Mostafa

> 
> Nicolin
