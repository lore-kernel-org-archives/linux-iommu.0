Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30328221DA5
	for <iommu@lists.linux.dev>; Tue,  8 Jul 2025 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988880; cv=none; b=q9fkj/tGZwU7DDYiOIRFxe8LaA8WScwfYOu9zxpW6QaHXOFHQ9Um50muJGochQ5AVgIdMLgKZDFa8knCJ6KIwYvTDbifhmP/BIPI9ncvj2c78moUi3PNTor3IdFuqUTPZuxMuJOOAMOoYvqVRuNcBn7d1WtEHCkswdMgF1zr2rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988880; c=relaxed/simple;
	bh=XucScw/NbmPb5pcBHQQ74dUXMqcRmk/myhmxp/4Y1zY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZ7x3J9XIhE6orvUVbV12u1TgR5VaJGDr9O0BtyIQ11b/jjdpwKpCaEmBdy18/GbQSq2LgKl2m/xt9DxMcz84oFvto5l0+6frOx/r25Z9XudJT1v7AiHaK3vdmxrkz7ygPgSEoPS+p2q8EdUwyL3HXts9hor1xOGc0BYDM0agL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=36nEdpD1; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="36nEdpD1"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-453a1208973so60565e9.1
        for <iommu@lists.linux.dev>; Tue, 08 Jul 2025 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751988876; x=1752593676; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=feHSqsXychGeLEEpp3conKG2GpdmxfXI5T95CnozGV8=;
        b=36nEdpD1IWJTiAoSbyWrwVjLuXRJ5d1GHh1UsjgtKbHTodsrscV8CaIP4MkZ+lGTpp
         ofFAJp7LFWqX1pLbxe09pPiXreRXS6dlkgSl4PqgtWhLTzhY/LA55ZRS3xs4nqIWw3Iq
         TYyfnkFIZ5B0AyTXXK2p1mtEkxSoY7Q1B7QhrBtdrSEN0FRrOLVW7Z+sEyXtY9Pvy+uG
         1jYooDiwl/I2FzP4hiwStvl+m7uosCKVIsoLgBFA3PuJ3YlSm7Pbx7+4K9r3N6tWsrQH
         sWed2dGMT+SSG1ug+Yprjn4ASfTarpQHgoPMpN9ziQg2t4NcU6q0JAaC3cpqnUxWmjne
         HnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751988876; x=1752593676;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feHSqsXychGeLEEpp3conKG2GpdmxfXI5T95CnozGV8=;
        b=oSAOFnN1cf3eRzzsfNzUG2/H6M0wnk5urtoyV92Fg5UxjVZ8rIaFJNz7j/kE9DG4u5
         ngJepXLdr78AT5yZGAaS0yRvrff39zpQakuMQNnhTtI6BsQmkix0wiRI14ISzX23iF+2
         NaxaGLhPpXSciSqOkxQXDieLpERkTYsgl/5RrVp9H7+KdtLBh/5uVVKRJJP/y0codoIw
         j+4SCijdZsm02k319lu/OATlVQelP1IkQHCYHs7jNh7EcS9hIt9y4610jDS5iGjMofjL
         XxETeluPKHRJ9lsUcrE/p5tR9V1Yq16taX0XVjc9I9+hO8LX+oxm0Mtxwe/koxuMjvCC
         4oWw==
X-Forwarded-Encrypted: i=1; AJvYcCXKmo0W9IrRLa1K/LYymGwUwT/eVWlOt48jnR5gKuxrlYMF7/axgVqpvgZd24zg6bjaSFlzvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWHAoFYbGaQrzThkvzmTNYzOTQgMZLkcLKHj44zo72MFWHtAcy
	lqjKkm8yeR4iyIL4/Voahy5t6RQfWwef5YaMdXNpyhHov70qM4SJroVa1MIF6MxdQA==
X-Gm-Gg: ASbGnctt8hStMYj4s/mqxJ1iRYCpWmc56/TCZZD9F3y2yAHbnfbfP7JVmBxmXDEiH31
	DdqnI6nlWTFsrGGUrMRxScL0xHmmrTz4qlaePpKdce+zo7zzeOC3PxtiP2AAvnhSpzHao8qfCr3
	bhaouzhZ4ngRjChRXbD9TIxDEWAL+A0LGYYKcirFhRIcukPFYBUXHFmxs7mpRLaR61FI2N5K0Y0
	8vg2bcSwU506m8u3IA3xVgRpz5fGiiXE9krjSaFD7cCjsKtOPYuStvXAyEBj3AEelr6LxMfsRQA
	QscVuygIzGd721jaFLlAOFYuwIFuzrLwG0a/ON/h32/bi2+nL7JRzTERCFB3AQi6TeLLNK0ncDZ
	i4w5Bq6vdH7R3k8X8I9c/ow==
X-Google-Smtp-Source: AGHT+IGcbF9E7MwIJUCiW+cq9eupqN9Mpiah1DCww0TchXLfiklqhhZ6fgNOXfLxxB1UIZjWulU0Lw==
X-Received: by 2002:a05:600c:a592:b0:453:65e6:b4a6 with SMTP id 5b1f17b1804b1-454cff2a04dmr794555e9.6.1751988876085;
        Tue, 08 Jul 2025 08:34:36 -0700 (PDT)
Received: from google.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b47285c6c9sm13139456f8f.89.2025.07.08.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 08:34:35 -0700 (PDT)
Date: Tue, 8 Jul 2025 15:34:32 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>, iommu@lists.linux.dev
Subject: Re: [RFC PATCH v3 4/8] iommu/arm-smmu-v3: Cache and restore MSI
 config
Message-ID: <aG06iNeVAkEoZ8Ou@google.com>
References: <20250616203149.2649118-1-praan@google.com>
 <20250616203149.2649118-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616203149.2649118-5-praan@google.com>

On Mon, Jun 16, 2025 at 08:31:45PM +0000, Pranjal Shrivastava wrote:
> The SMMU's MSI configuration registers (*_IRQ_CFGn) containing target
> address, data and memory attributes lose their state when the SMMU is
> powered down. We'll need to cache and restore their contents to ensure
> that MSIs work after the system resumes.
> 
> To address this, cache the original `msi_msg` within the `msi_desc`
> when the configuration is first written by `arm_smmu_write_msi_msg`.
> This primarily includes the target address and data since the memory
> attributes are fixed.
> 
> Introduce a new helper `arm_smmu_resume_msis` which will later be called
> during the driver's resume callback. The helper would retrieve the
> cached MSI message for each relevant interrupt (evtq, gerr, priq) via
> get_cached_msi_msg & re-config the registers via arm_smmu_write_msi_msg
> 
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 45 +++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 9ce00c959034..4699d3294d3e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3962,6 +3962,9 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	struct arm_smmu_device *smmu = dev_get_drvdata(dev);
>  	phys_addr_t *cfg = arm_smmu_msi_cfg[desc->msi_index];
>  
> +	/* Cache the msi_msg for resume */
> +	desc->msg = *msg;

All callers to arm_smmu_write_msi_msg() get the msg from
get_cached_msi_msg() which already returns msi_desc::msg of this irq,
so that seems redundant.


> +
>  	doorbell = (((u64)msg->address_hi) << 32) | msg->address_lo;
>  	doorbell &= MSI_CFG0_ADDR_MASK;
>  
> @@ -3970,6 +3973,48 @@ static void arm_smmu_write_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
>  	writel_relaxed(ARM_SMMU_MEMATTR_DEVICE_nGnRE, smmu->base + cfg[2]);
>  }
>  
> +static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
> +{
> +	unsigned int irq;
> +	struct msi_desc *desc;
> +	struct msi_msg msg;
> +
> +	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
> +		return;
> +
> +	if (!smmu->dev->msi.domain)
> +		return;
Is there a reason that is needed?

I’d expect irq_get_msi_desc() to return NULL if MSI is not used.
Otherwise, I think dev_get_msi_domain() would be more suitable to check?

> +
> +	irq = smmu->evtq.q.irq;
> +	desc = irq ? irq_get_msi_desc(irq) : NULL;
> +	if (desc) {
> +		get_cached_msi_msg(irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	} else {
> +		dev_err(smmu->dev, "Failed to resume evtq msi");
> +	}
> +
> +	irq = smmu->gerr_irq;
> +	desc = irq ? irq_get_msi_desc(irq) : NULL;
> +	if (desc) {
> +		get_cached_msi_msg(irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	} else {
> +		dev_err(smmu->dev, "Failed to resume gerror msi");
> +	}
> +
> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
> +		irq = smmu->priq.q.irq;
> +		desc = irq ? irq_get_msi_desc(irq) : NULL;
> +		if (desc) {
> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
> +			arm_smmu_write_msi_msg(desc, &msg);
> +		} else {
> +			dev_err(smmu->dev, "Failed to resume priq msi");
> +		}
> +	}
> +}
> +

This pattern seems to repeat, maybe it’s better in a macro

Something as:
#define smmu_resume_msi(smmu, _irq)  {	\
	unsigned int irq;	\
	struct msi_desc *desc; \
	struct msi_msg msg; \
	irq = smmu->_irq; \
	desc = irq ? irq_get_msi_desc(irq) : NULL; \
	if (desc) { \
		get_cached_msi_msg(irq, &msg); \
		arm_smmu_write_msi_msg(desc, &msg); \
	} else {	\
		dev_err(smmu->dev, "Failed to resume %s\n", #_irq);	\
	} \
}

static void arm_smmu_resume_msis(struct arm_smmu_device *smmu)
{
	if (!(smmu->features & ARM_SMMU_FEAT_MSI))
		return;

	if (!smmu->dev->msi.domain)
		return;

	smmu_resume_msi(smmu, evtq.q.irq);
	smmu_resume_msi(smmu, gerr_irq);
	if (smmu->features & ARM_SMMU_FEAT_PRI)
		smmu_resume_msi(smmu, priq.q.irq);
}


Thanks,
Mostafa

>  static void arm_smmu_setup_msis(struct arm_smmu_device *smmu)
>  {
>  	int ret, nvec = ARM_SMMU_MAX_MSIS;
> -- 
> 2.50.0.rc2.692.g299adb8693-goog
> 
