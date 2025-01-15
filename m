Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3A1EEA5A
	for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 09:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934271; cv=none; b=ZbH1pqxy7vBg/bVruJI5Q2Ai8D6qb9mO4cThw/Pa0sfMM76KVv/D6EKx/Eu08FEr431hUazSSvhEauRyCnccn/Zev2TYUD1CwQxt7OE3gAp4qgXG8KsS5L22SQFJ/ozO9yzcoufFPMFNqbhNLfCVNAFFkGoMLUl64fHkq0yABuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934271; c=relaxed/simple;
	bh=X4kPC7rGiV3ShVkLtdrJn0SMAMo5x5X5I/8TnJDxYcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BFsnWbkH7i5MwquglTt9yQsFCnN4K5LQfJ8+7dXw0Ea45bhNJeQDX7GLbduvPan89ZW42UHHsdOEedmp4cq+oQqyWCIrx+Bo8oLbWirXFfD1OwG9yszzO61os1AcZd/0qTTpDO5vsL7DOpJcOhEPYegf4Vfc1BnYNTON1V53a18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=bHO8LKGR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="bHO8LKGR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436202dd730so46056945e9.2
        for <iommu@lists.linux.dev>; Wed, 15 Jan 2025 01:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1736934267; x=1737539067; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=esAtTk/lpEE2twEw0jUtCey8Py/XgPIAB3dxsOhtpJc=;
        b=bHO8LKGR6ckt/+c8pTqRFG3rgabBHgHSk7OBoQVaqNH7eUO68M3Cuj118zE/6SJA7A
         xU25UlRgCaVXyhucXb6F0OW1k5wAlR9ecR0ayS+/1ufsnr4x802fJWT81kjR2fJBS07H
         vqa4walVSiRld2Vo2Gqrq+A0YzZASeu/0j6SMoEjjoo7O9D9r+aNFBttIWpBaf2yoq3z
         zxldMNCSHygD+uCuSBexKGthWuTmLvYM1Zi5F+m6WbnQ4r7azFzIhyoXGwHFBasxefUh
         q3SGkucNKGl9ZPLKtbNVy9e81J/igQlcnJju3ZqbyuBKobwi+zx/K5u1tsVcu+29pIpD
         QKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736934267; x=1737539067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esAtTk/lpEE2twEw0jUtCey8Py/XgPIAB3dxsOhtpJc=;
        b=nLx5z+34TGWNMI+9Mstrrl4GV/LcwQa4b0peBDq8kk7QXcTgWhC1TQwAEI4nOPJh0E
         LWEHQdyRkKPBOo9keRQiAfAhbthXo73xzsITqCZbWykAhJiy15ZrjYbvoemU7BhhFElk
         i0tkA7w+7TO+8TraaCmtpex6+7X6xH+NdTu06g6isS7wbLpf/uyUElZwg6WnrRNeh+1m
         dUMY+wEal9KGvuQEESM8pzi/b6d0EKjcBolIv1O7PlqUZLKip6iI4BT857C/nhbkDUFb
         vd8M4VplZLcUe4hOtBeevAT97/8CW7iKsYj+jVY6rWAri2DjdwE2JaCuGpUn1qQ87+Bf
         Ma2g==
X-Forwarded-Encrypted: i=1; AJvYcCXQO2XG4RY+rrZVSKKC8YNHAAzXYrwJDdaPh6OcxnsoNqQf/80SpwdFc3GF39l1jYOACERNEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyIzbC1Bv4bp7V0hn1pr99QITK6PpOAxZMD7qB11Og4B9SJ6hoL
	6p2ZkLveYOGswIn7TE5QuNdyJYjlj74j+bQWNbdf6V+qqbkbI4UVQ8CrZx2WlTw=
X-Gm-Gg: ASbGncucDbne+Ax75htE0MkMj/EzZ3/ChQmWSjJ8SpAMOBbMVscQ/oEqS/Do3VYM32X
	He3AzSlO4wxK0ywNLhT7Jh67KCBA10XpaWBAjPCJRA2pfq2wGEOU6NJEuEkWqU5UjU4HGrYWI8s
	AQ+YGbw7aC+3YqY2hbG4OJ8P80jd9v9Jh9TW8wipZrU0iZ1C0EphjrlplK4uI6zEWRKNJh4QuZ0
	dnVv7meYgtRHmsSEyGc2zEM2NnwwE3MDT6onFPQVr6sEEKMbx5nnky1JDoXHT5soDF6pCBsH1ai
	t8E6Jvb9mtLOdR2zM+A3+4FgscX9qq1TN505MHLaCw==
X-Google-Smtp-Source: AGHT+IGhbkSgvY+dW7yHkdG99m1xQ+qGuWMmxBZmDcAmT3S4qDuCQLsGs5KooVSA8ixJDjHmJigmgw==
X-Received: by 2002:a05:600c:3516:b0:436:5165:f206 with SMTP id 5b1f17b1804b1-436e27075eemr265829195e9.31.1736934267210;
        Wed, 15 Jan 2025 01:44:27 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753bee8sm16984215e9.34.2025.01.15.01.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 01:44:26 -0800 (PST)
Date: Wed, 15 Jan 2025 10:44:25 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Zong Li <zong.li@sifive.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	tjeznach@rivosinc.com, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, luxu.kernel@bytedance.com, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/2] iommu/riscv: support HPM and interrupt handling
Message-ID: <20250115-9d8193b7c67eeee41d18a7dd@orel>
References: <20250115030306.29735-1-zong.li@sifive.com>
 <20250115030306.29735-3-zong.li@sifive.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115030306.29735-3-zong.li@sifive.com>

On Wed, Jan 15, 2025 at 11:03:06AM +0800, Zong Li wrote:
> Initialize the PMU and uninitialize it when driver is removed.
> Interrupt handling is also implemented, and the handler needs
> to be a primary handler instead of a threaded function because
> pt_regs is empty when threading the IRQ. However, pt_regs is
> required by perf_event_overflow.
> 
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Tested-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  drivers/iommu/riscv/iommu.c | 65 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
> index 8a05def774bd..20ae90471484 100644
> --- a/drivers/iommu/riscv/iommu.c
> +++ b/drivers/iommu/riscv/iommu.c
> @@ -552,6 +552,62 @@ static irqreturn_t riscv_iommu_fltq_process(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +/*
> + * IOMMU Hardware performance monitor
> + */
> +
> +/* HPM interrupt primary handler */
> +static irqreturn_t riscv_iommu_hpm_irq_handler(int irq, void *dev_id)
> +{
> +	struct riscv_iommu_device *iommu = (struct riscv_iommu_device *)dev_id;
> +
> +	/* Clear performance monitoring interrupt pending */
> +	riscv_iommu_writel(iommu, RISCV_IOMMU_REG_IPSR, RISCV_IOMMU_IPSR_PMIP);
> +
> +	/* Process pmu irq */
> +	riscv_iommu_pmu_handle_irq(&iommu->pmu);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/* HPM initialization */
> +static int riscv_iommu_hpm_enable(struct riscv_iommu_device *iommu)
> +{
> +	int rc;
> +
> +	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +		return 0;
> +
> +	/*
> +	 * pt_regs is empty when threading the IRQ, but pt_regs is necessary
> +	 * by perf_event_overflow. Use primary handler instead of thread
> +	 * function for PM IRQ.
> +	 *
> +	 * Set the IRQF_ONESHOT flag because this IRQ might be shared with
> +	 * other threaded IRQs by other queues.
> +	 */
> +	rc = devm_request_irq(iommu->dev,
> +			      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
> +			      riscv_iommu_hpm_irq_handler, IRQF_ONESHOT | IRQF_SHARED, NULL, iommu);
> +	if (rc)
> +		return rc;
> +
> +	return riscv_iommu_pmu_init(&iommu->pmu, iommu->reg, dev_name(iommu->dev));
> +}
> +
> +/* HPM uninitialization */
> +static void riscv_iommu_hpm_disable(struct riscv_iommu_device *iommu)
> +{
> +	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM))
> +		return;
> +
> +	devm_free_irq(iommu->dev,
> +		      iommu->irqs[riscv_iommu_queue_vec(iommu, RISCV_IOMMU_IPSR_PMIP)],
> +		      iommu);
> +
> +	riscv_iommu_pmu_uninit(&iommu->pmu);
> +}
> +
>  /* Lookup and initialize device context info structure. */
>  static struct riscv_iommu_dc *riscv_iommu_get_dc(struct riscv_iommu_device *iommu,
>  						 unsigned int devid)
> @@ -1596,6 +1652,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
>  	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>  	riscv_iommu_queue_disable(&iommu->cmdq);
>  	riscv_iommu_queue_disable(&iommu->fltq);
> +
> +	if (iommu->caps & RISCV_IOMMU_CAPABILITIES_HPM)
> +		riscv_iommu_pmu_uninit(&iommu->pmu);

This should be

   riscv_iommu_hpm_disable(iommu);

as the cover letter said it would be.

>  }
>  
>  int riscv_iommu_init(struct riscv_iommu_device *iommu)
> @@ -1635,6 +1694,10 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>  	if (rc)
>  		goto err_queue_disable;
>  
> +	rc = riscv_iommu_hpm_enable(iommu);
> +	if (rc)
> +		goto err_hpm_disable;

This should be

  goto err_iodir_off;

And the next goto (under sysfs add) should be

  goto err_hpm_disable;

> +
>  	rc = iommu_device_sysfs_add(&iommu->iommu, NULL, NULL, "riscv-iommu@%s",
>  				    dev_name(iommu->dev));
>  	if (rc) {
> @@ -1653,6 +1716,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
>  err_remove_sysfs:
>  	iommu_device_sysfs_remove(&iommu->iommu);
>  err_iodir_off:
> +	riscv_iommu_hpm_disable(iommu);
> +err_hpm_disable:
>  	riscv_iommu_iodir_set_mode(iommu, RISCV_IOMMU_DDTP_IOMMU_MODE_OFF);
>  err_queue_disable:
>  	riscv_iommu_queue_disable(&iommu->fltq);

This should be

 err_remove_sysfs:
   ...
 err_hpm_disable:
   ...
 err_iodir_off:
   ...
 err_queue_disable:
   ...


Thanks,
drew
