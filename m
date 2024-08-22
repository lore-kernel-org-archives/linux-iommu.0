Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EF1CF8B
	for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724321395; cv=none; b=TYUwsgvYDDi3i5dxbW13tBn62BHm5Zh5IFR3X3CTpUdyTPlNx90OE9n1Asmdv1bHqN0GwF54mqhpwxmuq9hNJqan5ZcLl/8t2EJdp9wRUWPyynrm9TIUMfSEqjKhANppJgeAd3Sj+MYxZGJFv3iIt3psnrgANa8aPtJAKxbK+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724321395; c=relaxed/simple;
	bh=r1QYHjmR4HZHWC0VlQSNYkMnBNcvFJnMUOGbVWuoSGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrdgO6W7eIfkmrqhF33rAl+Qug2Jaw60EafPfW/GD1aavNdnbxqEZrcUTv5S+nZB32s38T5wA4ogM+Z0rYSgJCH+T3NDQPJOlAaYwW+ETjVBQHya2dIjDQzYiSLGJiePQYrQHl1g/TJ+tvOsQ2XzGJ/mxNGdqxoGR5OtFzc6V0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbKdPJ1/; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbKdPJ1/"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7cb3db0932cso489693a12.1
        for <iommu@lists.linux.dev>; Thu, 22 Aug 2024 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724321392; x=1724926192; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XZqLjo27hw9k6jUvMLYZfZhCyIhxvtHS0deNG6q9lTc=;
        b=bbKdPJ1/6LvpZnPZdIn5BCDYQRmab7xumAuVEUTplRtzOhW9+IPPvDu7SosgGOnCwA
         CLhSxzY8U1HLRdZHlywec52pQAouOuN7Oh3xY1wYpyhhY3JK2z6PBvBBNg6IvL3oBDD6
         +ugUk/GWcvB5D3JbSI4F69oZOkz7H4/wdkaSH+ZVH2wk4xAIfJHfj3fobBdzHPQMH3l7
         j1R4PR8zy64BEEi4MdJGfYQ5y4XMHfaxLufC10wpWqYF4w4WpqNfqVa+Qse1H1i50Iz7
         WQ0UarQUqLr950vc0QGop+RGG69jBUwAbUndI6zmjkXPgSccqmcn1qYBxMPZeX+w9um1
         Iy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724321392; x=1724926192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZqLjo27hw9k6jUvMLYZfZhCyIhxvtHS0deNG6q9lTc=;
        b=g9A70mLw6Y3V8dgJp8GalTkPfM8xAo1/+aNAPmDYvLFG+Uyr9PYN4haD1WNOYyjgQ3
         LhW4XD/8nsvCqUwdmfl8f1SywUvfC6WOJ7nJaJ0nsM6FSsRFgSxbV85LfbOrttg2btP5
         tHSN8ngIw/6wL3Aqe7NlZ9WKBY7B5HdqQEW32DpmOamG0RCjWjCw3T/wrVfYkSEwHk6/
         g9cORuWspoq60trM1q9bwQ3JZKcdz8GUiCdUh7nHbvjKwy9G9wtlO8tm9IU/3DEu0tBJ
         LXNt4XkG3g/37SUFoMJ0noNFecXG83ovUoF/hD0E3DEuNIhOtpnOsWvqe7f4aJ+rjRjz
         ww0Q==
X-Gm-Message-State: AOJu0YwzoTtvzOFIg++6fEQbR56LnJpSzMasGHM4X6HObhpZV8Wkyg9k
	o5G2K19JoDYBfD7LyIIFmvCJFlRTus/JSnycrHn5Z1YZBlqdh+55eoWvMweeew==
X-Google-Smtp-Source: AGHT+IGf4WQmlD8IFHreLphflcdyQnxA6Lnlu71sCq6HuU14t/85sgtjo5rIm66dbyMtVxIcbnctMQ==
X-Received: by 2002:a17:90a:9c13:b0:2d3:90e1:41c7 with SMTP id 98e67ed59e1d1-2d5ea4c780emr5699784a91.31.1724321391834;
        Thu, 22 Aug 2024 03:09:51 -0700 (PDT)
Received: from thinkpad ([117.213.99.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613a58fdbsm1344875a91.29.2024.08.22.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 03:09:51 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:39:41 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	Stephen Boyd <swboyd@chromium.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Pranjal Shrivastava <praan@google.com>,
	Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Georgi Djakov <quic_c_gdjako@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	"moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu: Pretty-print context fault
 related regs
Message-ID: <20240822100941.3tfqpjskzq43slfw@thinkpad>
References: <20240701162025.375134-1-robdclark@gmail.com>
 <20240701162025.375134-4-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701162025.375134-4-robdclark@gmail.com>

On Mon, Jul 01, 2024 at 09:20:12AM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Parse out the bitfields for easier-to-read fault messages.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  | 52 +++++---------
>  drivers/iommu/arm/arm-smmu/arm-smmu.c         | 70 +++++++++++++++----
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         | 21 ++++++
>  3 files changed, 92 insertions(+), 51 deletions(-)
> 

[...]

> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 23cf91ac409b..79ec911ae151 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -405,32 +405,72 @@ static const struct iommu_flush_ops arm_smmu_s2_tlb_ops_v1 = {
>  	.tlb_add_page	= arm_smmu_tlb_add_page_s2_v1,
>  };
>  
> +
> +void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
> +				      struct arm_smmu_context_fault_info *cfi)
> +{
> +	cfi->iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> +	cfi->fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> +	cfi->fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> +	cfi->cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> +}
> +
> +void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
> +				       const struct arm_smmu_context_fault_info *cfi)
> +{
> +	dev_dbg(smmu->dev,
> +		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> +		cfi->fsr, cfi->iova, cfi->fsynr, cfi->cbfrsynra, idx);
> +

I just happen to hit an IOMMU fault in 6.11-rc4 and I did not see the 'Unhandled
context fault' log, but just the register dump in dmesg. Tracking that lead me
to this patch.

May I know the reasoning behind making the actual error message _dbg()? It is
intentional first place?

- Mani

> +	dev_err(smmu->dev, "FSR    = %08x [%s%sFormat=%u%s%s%s%s%s%s%s%s], SID=0x%x\n",
> +		cfi->fsr,
> +		(cfi->fsr & ARM_SMMU_CB_FSR_MULTI)  ? "MULTI " : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_SS)     ? "SS " : "",
> +		(u32)FIELD_GET(ARM_SMMU_CB_FSR_FORMAT, cfi->fsr),
> +		(cfi->fsr & ARM_SMMU_CB_FSR_UUT)    ? " UUT" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_ASF)    ? " ASF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_TLBLKF) ? " TLBLKF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_TLBMCF) ? " TLBMCF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_EF)     ? " EF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_PF)     ? " PF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_AFF)    ? " AFF" : "",
> +		(cfi->fsr & ARM_SMMU_CB_FSR_TF)     ? " TF" : "",
> +		cfi->cbfrsynra);
> +
> +	dev_err(smmu->dev, "FSYNR0 = %08x [S1CBNDX=%u%s%s%s%s%s%s PLVL=%u]\n",
> +		cfi->fsynr,
> +		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_S1CBNDX, cfi->fsynr),
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_AFR) ? " AFR" : "",
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_PTWF) ? " PTWF" : "",
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_NSATTR) ? " NSATTR" : "",
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_IND) ? " IND" : "",
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_PNU) ? " PNU" : "",
> +		(cfi->fsynr & ARM_SMMU_CB_FSYNR0_WNR) ? " WNR" : "",
> +		(u32)FIELD_GET(ARM_SMMU_CB_FSYNR0_PLVL, cfi->fsynr));
> +}
> +
>  static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
>  {
> -	u32 fsr, fsynr, cbfrsynra;
> -	unsigned long iova;
> +	struct arm_smmu_context_fault_info cfi;
>  	struct arm_smmu_domain *smmu_domain = dev;
>  	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	static DEFINE_RATELIMIT_STATE(rs, DEFAULT_RATELIMIT_INTERVAL,
> +				      DEFAULT_RATELIMIT_BURST);
>  	int idx = smmu_domain->cfg.cbndx;
>  	int ret;
>  
> -	fsr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSR);
> -	if (!(fsr & ARM_SMMU_CB_FSR_FAULT))
> -		return IRQ_NONE;
> +	arm_smmu_read_context_fault_info(smmu, idx, &cfi);
>  
> -	fsynr = arm_smmu_cb_read(smmu, idx, ARM_SMMU_CB_FSYNR0);
> -	iova = arm_smmu_cb_readq(smmu, idx, ARM_SMMU_CB_FAR);
> -	cbfrsynra = arm_smmu_gr1_read(smmu, ARM_SMMU_GR1_CBFRSYNRA(idx));
> +	if (!(cfi.fsr & ARM_SMMU_CB_FSR_FAULT))
> +		return IRQ_NONE;
>  
> -	ret = report_iommu_fault(&smmu_domain->domain, NULL, iova,
> -		fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
> +	ret = report_iommu_fault(&smmu_domain->domain, NULL, cfi.iova,
> +		cfi.fsynr & ARM_SMMU_CB_FSYNR0_WNR ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ);
>  
> -	if (ret == -ENOSYS)
> -		dev_err_ratelimited(smmu->dev,
> -		"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cbfrsynra=0x%x, cb=%d\n",
> -			    fsr, iova, fsynr, cbfrsynra, idx);
> +	if (ret == -ENOSYS && __ratelimit(&rs))
> +		arm_smmu_print_context_fault_info(smmu, idx, &cfi);
>  
> -	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, fsr);
> +	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_FSR, cfi.fsr);
>  	return IRQ_HANDLED;
>  }
>  
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index b04a00126a12..e2aeb511ae90 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -198,6 +198,7 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FSR			0x58
>  #define ARM_SMMU_CB_FSR_MULTI		BIT(31)
>  #define ARM_SMMU_CB_FSR_SS		BIT(30)
> +#define ARM_SMMU_CB_FSR_FORMAT		GENMASK(10, 9)
>  #define ARM_SMMU_CB_FSR_UUT		BIT(8)
>  #define ARM_SMMU_CB_FSR_ASF		BIT(7)
>  #define ARM_SMMU_CB_FSR_TLBLKF		BIT(6)
> @@ -223,7 +224,14 @@ enum arm_smmu_cbar_type {
>  #define ARM_SMMU_CB_FAR			0x60
>  
>  #define ARM_SMMU_CB_FSYNR0		0x68
> +#define ARM_SMMU_CB_FSYNR0_PLVL		GENMASK(1, 0)
>  #define ARM_SMMU_CB_FSYNR0_WNR		BIT(4)
> +#define ARM_SMMU_CB_FSYNR0_PNU		BIT(5)
> +#define ARM_SMMU_CB_FSYNR0_IND		BIT(6)
> +#define ARM_SMMU_CB_FSYNR0_NSATTR	BIT(8)
> +#define ARM_SMMU_CB_FSYNR0_PTWF		BIT(10)
> +#define ARM_SMMU_CB_FSYNR0_AFR		BIT(11)
> +#define ARM_SMMU_CB_FSYNR0_S1CBNDX	GENMASK(23, 16)
>  
>  #define ARM_SMMU_CB_FSYNR1		0x6c
>  
> @@ -533,4 +541,17 @@ struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
>  void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx);
>  int arm_mmu500_reset(struct arm_smmu_device *smmu);
>  
> +struct arm_smmu_context_fault_info {
> +	unsigned long iova;
> +	u32 fsr;
> +	u32 fsynr;
> +	u32 cbfrsynra;
> +};
> +
> +void arm_smmu_read_context_fault_info(struct arm_smmu_device *smmu, int idx,
> +				      struct arm_smmu_context_fault_info *cfi);
> +
> +void arm_smmu_print_context_fault_info(struct arm_smmu_device *smmu, int idx,
> +				       const struct arm_smmu_context_fault_info *cfi);
> +
>  #endif /* _ARM_SMMU_H */
> -- 
> 2.45.2
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
