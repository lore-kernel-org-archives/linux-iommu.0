Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF53B2FE4
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782722903; cv=none; b=GQpM3WTsX4b/05cmRx2joeTvxxLezBlK/1/wkWEeABIscSFNMyW1JXoBT3rUbCWOQVVIzW0V0bWr0eCXTx1fV18GU52aOMb8MlZ/Uxx9fcKYlljky3Bg3egCvI4abyv7fAN0ONqv/n2dlLfzM705muJJmQsjU8ZF3IIHAlR0JiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782722903; c=relaxed/simple;
	bh=qjBuJ33yZlfHL1S9SrLYPjB31Lz1hU3VJgkUNM2s+hU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOsS/YAYuY06aMiD/YpCszLeK9y3l3tDeDQ7roIMnzyM7bQc13G+AzXaa6v4wMJDlAJQUvAewpeWMia7abmeiYNfnH75nWiYQy0zKZOrdvZufK5+BG77ZgosG/xAuISbkksjk6xEH+QsOGMAMbGwXslr0qRAhqjGzpuT00YtFkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QjDOeCDR; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QjDOeCDR"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c81db32393so66255ad.0
        for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782722900; x=1783327700; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2CYHaiLd9ywNSZ9pftV2yPbkytXEfUK5AIl8p5DJYxA=;
        b=QjDOeCDRmR+VWptMHg6N7f42vsKLljuPtY01+yKN+tv47Oo9OxLq2xQgyqM25SmZnq
         6d5gQX92NG5K9higs4k9hc4mYu5/jTixT4fekjmmUf6YxJ2eIfiBy6CC0G1mKe2yAefy
         X08TtKVvj8czp5nAxggULig+izfMVBeDVzSVKBD2/VvvjWrqp9gIfMQZHamu8OprxXDj
         2hxlHJc42Jabn6kcrEqUpnNCCgDII6ASL2Oq8NY8wQqEBrshjRIZlAVb4/H3PQfFm8xk
         fjQu5zm5Ht54QICXE2il+DDBb/iDFIQBLH2uoudvYpPXN4MLiUtrY2PK21BvYLdKDBS8
         ECsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782722900; x=1783327700;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2CYHaiLd9ywNSZ9pftV2yPbkytXEfUK5AIl8p5DJYxA=;
        b=ay8fZ6azJeCZxIP/9vKN6CrtFdVCK+4S8t1wWqBqaSAyWAu1TAZ8jcJHFYGMstyFli
         i3fu0sbkkWdsUIMOI+6lhNH1/gBNtG8xGAmqxg2D/CgAAa9TA1sVGovRxjDuByVTNsNR
         MmxdKkS8+pM8q7/lFCCYPq/V8AA7lgPtnOrIUpBdMCIcnqw3epMAmvNhP++YlROsyR1d
         UHhPeMaKmRQNVH0ntU59yo7fup4sB6ionEYOsqjMmVt4GQW0aHltW10weRNfxZNJUy9S
         n9QTGbsAoKKnEL0gJ6X8XlhabKOAPbe99VVYNlEpa9L3fD/2rzHJeS0gPGh51pmbtekH
         pU/Q==
X-Forwarded-Encrypted: i=1; AHgh+Rox0Fe/7KSVFAv12fIOOqyLZNHTdog3ehwNV+WtKZTGa54JzsjifdaxDKn2yWaSmUXAFdp9Zg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzSTtDjDq62HT6jeUYz0l9JNMTWIbilny5rSuJdtxvKB9JfiD1h
	ANUvZt2pZwW8eAhXmaOlj/XkTufU8DyqUG3tpns7iTK04s8YcNxdniAZFo/4gpoyuA==
X-Gm-Gg: AfdE7clNrudPsLUZZ49JSz7Jpp8kiYfNBYZ07AnLr0pvZhXKchSG7jOAAXmtyV33C/E
	zYpmV5RGMukWnhea7OaLn1+Y5Oh1sAs4mR03NC7ryO3kaLvJfPbQgLr7IAQP/qPLd3FWiwCd6nx
	LHkMyG1rzIuAErxnrTOj6M7EsCn19mwPSagFy+6WNWt968f9f8PYdINlVY4qkT81eann4NU2sGU
	woqbT24GLeb2Z7TFTLVhoE2Aop7nq+F13GlpPu/Ftt7zaX31uhBSCbSj1hKxJHDYODtNBtLgU5a
	XiZ+59t24XGM96GMauHgkqs49HI3qFvu9hXnJ7ocwQvSFRNEcwfKNy4LKfgdz7EIhs4/QKJoPUp
	eWHMrBivwWUSYOJPxsVapT6FQGyePh526GL/9V2Re7dFD1d6TC62CC2zPOqf+4dVjh1ocpYosKo
	bGwahuFFpSABg9G2jMqNG8rY0k5UEpT7U7CSleqcOrPG6KjEI=
X-Received: by 2002:a17:902:f612:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2c9a24512fcmr3816645ad.12.1782722899601;
        Mon, 29 Jun 2026 01:48:19 -0700 (PDT)
Received: from google.com (10.129.124.34.bc.googleusercontent.com. [34.124.129.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-846de12ed24sm2482229b3a.8.2026.06.29.01.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:48:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 08:48:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org,
	kees@kernel.org, baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jamien@nvidia.com
Subject: Re: [PATCH rc v6 3/7] iommu/arm-smmu-v3: Do not enable EVTQ/PRIQ
 interrupts in kdump kernel
Message-ID: <akIxS7kuhuLRHAMg@google.com>
References: <cover.1779265413.git.nicolinc@nvidia.com>
 <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e643786d849d274c1d8dcfc03795f572aef812bd.1779265413.git.nicolinc@nvidia.com>

On Wed, May 20, 2026 at 10:03:20AM -0700, Nicolin Chen wrote:
> In kdump cases, the crashed kernel's CDs and page tables can be corrupted,
> which could trigger event spamming. Also, we cannot serve page requests.
> 
> Skip the IRQ setup for EVTQ/PRIQ in arm_smmu_setup_irqs().
> 
> Skip their IRQ handler registration in unique-IRQ and combined-IRQ cases.
> 
> Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
> Cc: stable@vger.kernel.org # v6.12+
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 58 ++++++++++++++-------
>  1 file changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2d7eb42449eaf..e00b28e36f9c4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2464,7 +2464,11 @@ static irqreturn_t arm_smmu_combined_irq_thread(int irq, void *dev)
>  
>  static irqreturn_t arm_smmu_combined_irq_handler(int irq, void *dev)
>  {
> -	arm_smmu_gerror_handler(irq, dev);
> +	irqreturn_t ret = arm_smmu_gerror_handler(irq, dev);
> +
> +	/* In kdump, EVTQ/PRIQ are disabled and there is no thread to wake */
> +	if (is_kdump_kernel())
> +		return ret;
>  	return IRQ_WAKE_THREAD;
>  }
>  
> @@ -4963,6 +4967,21 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  	arm_smmu_setup_msis(smmu);
>  
>  	/* Request interrupt lines */
> +	irq = smmu->gerr_irq;
> +	if (irq) {
> +		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> +				       0, "arm-smmu-v3-gerror", smmu);
> +		if (ret < 0)
> +			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> +	} else {
> +		dev_warn(smmu->dev,
> +			 "no gerr irq - errors will not be reported!\n");
> +	}
> +
> +	/* No EVTQ/PRIQ interrupts in kdump -- queues are disabled */
> +	if (is_kdump_kernel())
> +		return;
> +
>  	irq = smmu->evtq.q.irq;
>  	if (irq) {
>  		ret = devm_request_threaded_irq(smmu->dev, irq, NULL,
> @@ -4975,16 +4994,6 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  		dev_warn(smmu->dev, "no evtq irq - events will not be reported!\n");
>  	}
>  
> -	irq = smmu->gerr_irq;
> -	if (irq) {
> -		ret = devm_request_irq(smmu->dev, irq, arm_smmu_gerror_handler,
> -				       0, "arm-smmu-v3-gerror", smmu);
> -		if (ret < 0)
> -			dev_warn(smmu->dev, "failed to enable gerror irq\n");
> -	} else {
> -		dev_warn(smmu->dev, "no gerr irq - errors will not be reported!\n");
> -	}
> -
>  	if (smmu->features & ARM_SMMU_FEAT_PRI) {
>  		irq = smmu->priq.q.irq;
>  		if (irq) {
> @@ -5005,7 +5014,7 @@ static void arm_smmu_setup_unique_irqs(struct arm_smmu_device *smmu)
>  static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  {
>  	int ret, irq;
> -	u32 irqen_flags = IRQ_CTRL_EVTQ_IRQEN | IRQ_CTRL_GERROR_IRQEN;
> +	u32 irqen_flags = IRQ_CTRL_GERROR_IRQEN;
>  
>  	/* Disable IRQs first */
>  	ret = arm_smmu_write_reg_sync(smmu, 0, ARM_SMMU_IRQ_CTRL,
> @@ -5020,19 +5029,30 @@ static int arm_smmu_setup_irqs(struct arm_smmu_device *smmu)
>  		/*
>  		 * Cavium ThunderX2 implementation doesn't support unique irq
>  		 * lines. Use a single irq line for all the SMMUv3 interrupts.
> +		 *
> +		 * In kdump, EVTQ/PRIQ are disabled, so no threaded handling.
>  		 */
> -		ret = devm_request_threaded_irq(smmu->dev, irq,
> -					arm_smmu_combined_irq_handler,
> -					arm_smmu_combined_irq_thread,
> -					IRQF_ONESHOT,
> -					"arm-smmu-v3-combined-irq", smmu);
> +		if (is_kdump_kernel())
> +			ret = devm_request_irq(smmu->dev, irq,
> +					       arm_smmu_combined_irq_handler, 0,
> +					       "arm-smmu-v3-combined-irq",
> +					       smmu);

This `if` isn't needed, we can continue using devm_request_threaded_irq,
if you look at the doc for devm_request_threaded_irq [1] it says:

/**
 * devm_request_threaded_irq - allocate an interrupt line for a managed device with error logging
 * @dev:	Device to request interrupt for
 * @irq:	Interrupt line to allocate
 * @handler:	Function to be called when the interrupt occurs
 * @thread_fn:	Function to be called in a threaded interrupt context. NULL
 *		for devices which handle everything in @handler
 * @irqflags:	Interrupt type flags
 * @devname:	An ascii name for the claiming device, dev_name(dev) if NULL
 * @dev_id:	A cookie passed back to the handler function
[...]
*/

So, we can pass handler() here while leaving the thread_fn == NULL:

ret = devm_request_threaded_irq(smmu->dev, irq,
         arm_smmu_combined_irq_handler,
         is_kdump_kernel() ? NULL : arm_smmu_combined_irq_thread,
         IRQF_ONESHOT,
         "arm-smmu-v3-combined-irq", smmu);

(In fact that's exactly what devm_request_irq does under the hood [2])

Additionally, the arm_smmu_combined_irq_handler() returns 
IRQ_WAKE_THREAD unconditionally, which causes us to hit the warn_on[3] in
__handle_irq_event_percpu.

Hence, we'd need to refactor the arm_smmu_combined_irq_handler() to
return IRQ_HANDLED / _NONE if is_kdump_kernel().

> +		else
> +			ret = devm_request_threaded_irq(
> +				smmu->dev, irq, arm_smmu_combined_irq_handler,
> +				arm_smmu_combined_irq_thread, IRQF_ONESHOT,
> +				"arm-smmu-v3-combined-irq", smmu);
>  		if (ret < 0)
>  			dev_warn(smmu->dev, "failed to enable combined irq\n");
>  	} else
>  		arm_smmu_setup_unique_irqs(smmu);
>  
> -	if (smmu->features & ARM_SMMU_FEAT_PRI)
> -		irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	/* No EVTQ/PRIQ IRQ generation in kdump -- queues are disabled */
> +	if (!is_kdump_kernel()) {
> +		irqen_flags |= IRQ_CTRL_EVTQ_IRQEN;
> +		if (smmu->features & ARM_SMMU_FEAT_PRI)
> +			irqen_flags |= IRQ_CTRL_PRIQ_IRQEN;
> +	}
>  
>  	/* Enable interrupt generation on the SMMU */
>  	ret = arm_smmu_write_reg_sync(smmu, irqen_flags,
> -- 
> 2.43.0
> 

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/irq/devres.c#L75
[2] https://elixir.bootlin.com/linux/v7.1.1/source/include/linux/interrupt.h#L218
[3] https://elixir.bootlin.com/linux/v7.1.1/source/kernel/irq/handle.c#L225
