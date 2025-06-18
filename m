Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC362EF9D7
	for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 14:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750258650; cv=none; b=tIMbvT4dr59F0bbE7fZmMQETpb7uy4F3mG5ezDzhfF9NGnn3S2HsoFDTAZxrvSIES0TISW4B2AJ/qCEXReMJe8/wGkxt9rgsH7Ohns+rok2GWJ8erHWVsbWWUY58Z2Wt3LFtTZqM7OeFXhiq1PDTTpsTM0dul2/w21CxF1PfA1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750258650; c=relaxed/simple;
	bh=OPezsAgE4NKsy9v1Mr0Ip+bSrXVKO25UcHNhgGBFSFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iepBTJIU6hwEYVqh9XmYDiVzYWJFzroOgGOmgxvIVcXuLoLe8CiWXK6L5gup4PQ5LBkW3/eolUp1RAr8ByPsVinlkjhwWkaHW5dK5OkSBe09frUguu3Jt54VR4aNbEW4WFyAUeOrvqFwzESkr586K77iWCvZBZSgJVZ8/aFV/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Gjuld4i4; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Gjuld4i4"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7d3e7641b76so71548085a.3
        for <iommu@lists.linux.dev>; Wed, 18 Jun 2025 07:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1750258648; x=1750863448; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nWuA5n/7XV52piKpzEtlj4+eRvGXTp7zsvMDV3q1c/g=;
        b=Gjuld4i4HVS/ZfUyAHXAJvSW7sSan3tlPwX0Dk0M6bnU2Xf1USvCK57APTHGJXgaN3
         5uZv7Yu2gsNOlKkJaBZHEbgLtuLA1yh2yNBwZS8cUPe9nq7r88L8cuQZRH7CFegd60ym
         hqSwIZ3z/AwpWgDkJQBzuXpcblCVQ/3WVPe1iIDZOmod2vMCb5X0ydYjLq4UvsQr+OTj
         lZLICWaGWUd/Cpw7RQtmiKbRacvhYzckBfPuKToI2Gygg/WxH/ao6xjdpOauPqQliDTx
         av5HmBIhmkweia+9lCHhEcPP50373Sfr4aMswRfdLM1YWMhm913xDvatEktxXt3y5ojZ
         kz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750258648; x=1750863448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWuA5n/7XV52piKpzEtlj4+eRvGXTp7zsvMDV3q1c/g=;
        b=KcgDvaZSuoAPo30jrgUjnCHmSgZMrZDGz5xKXDc1xpB80QVifhgxlPSv9QxC93voLH
         fL8FpQxSnl04izsK+4Nww1s/IAP+IvgS2DUl1MeF+0YmM0kR8rAnsxde3X5rhfK0GW/2
         yoxC+fWNIDNpVL4R2TAWPJvx8GpxokmKyeV7CV+4dJlG6Kyrwqcvlei0klquh5zrbCvg
         Se4S/0CNdYdp5BdMp6wnKtop81KDCgphSUFmZLClVtTOtKUu4s0y2OgebqHPq+vM4JXI
         8MaJe/AsycO6BLABW+sHmacf31fVBru440UTOmohqUWRGV1S8X1MRXzDai6Tt1IR+11D
         C6kg==
X-Forwarded-Encrypted: i=1; AJvYcCUkmBnX80Zj2Ig3uHIa5N6emloB8aXOwyseLMUtt8mGljmKHcDQYtuhAbJyPe4gRyIhUSerGQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwHcKJ/7UszE8798CT4Y8vzhdGgOAHgxOZvKSiq5UWmrer87KON
	ylnO8fWddr7cylK1vLKFiKk7jZ7WKaUqPNStlxAmKN7Chmm9D49mhZDlAspoPJRDGqc=
X-Gm-Gg: ASbGncv4yeS2CvRqJFRYxpLLjaHdPUKR8y3zrXOFChhDdN+nNx1ODUp0N+1AVL17Kwb
	DlM5v0oeQKIq4xeycXcoBbJ0TLoMPBiaGjl6W+uAscfMC9mUKBqjq+q1+dmK+Lro6azBEnuhQUW
	qd2eySoynyjM3k1vT3qW/gvERbbKWzuIim+dUC40AOcGzQV9zUIEyy43yjDptaoOAiZArKydOvR
	LlNsUIzlyu0iBjFl4U1m2cqoAOlPWsr0dTAtkqalWxkoZLFyJtwhtLxNd2oJOCKmTRDkEnWV9L5
	YavETjv7jpFT+Cc5twY8vPmTJsh8YgX3iMgM/tgxKdJp6ro07JQEd6hcaBICi30bHu20PmAhPv/
	GcsMfHJ4GwQnpfhzo3mSlWFEVFtRemZrOI6Q3uw==
X-Google-Smtp-Source: AGHT+IEqAm8w07CYn9jssi0u9N9oTKmQEBd4zXaVvYiKXP4kVC2Pg2ZszP/NIklhkByTPLh6hrPUVw==
X-Received: by 2002:a05:620a:2720:b0:7d3:8fd2:c0cd with SMTP id af79cd13be357-7d3c6d0c5e6mr2844239185a.56.1750258645240;
        Wed, 18 Jun 2025 07:57:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edf51fsm771719285a.93.2025.06.18.07.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:57:24 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uRuE7-00000006osS-460H;
	Wed, 18 Jun 2025 11:57:23 -0300
Date: Wed, 18 Jun 2025 11:57:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
	nicolas.dufresne@collabora.com, iommu@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 3/5] iommu: Add verisilicon IOMMU driver
Message-ID: <20250618145723.GR1376515@ziepe.ca>
References: <20250618140923.97693-1-benjamin.gaignard@collabora.com>
 <20250618140923.97693-4-benjamin.gaignard@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618140923.97693-4-benjamin.gaignard@collabora.com>

On Wed, Jun 18, 2025 at 04:09:12PM +0200, Benjamin Gaignard wrote:
> +config VSI_IOMMU
> +	bool "Verisilicon IOMMU Support"
> +	depends on ARM64
> +	select IOMMU_API
> +	select ARM_DMA_USE_IOMMU

ARM_DMA_USE_IOMMU is only used by ARM32, you don't need it if you
depends on ARM64

> +static void vsi_iommu_release_device(struct device *dev)
> +{
> +	struct vsi_iommu *iommu = dev_iommu_priv_get(dev);
> +
> +	device_link_remove(dev, iommu->dev);
> +}

This does not seem right, release is supposed to reprogram the HW to
stop walking any page table.

You should implement a static blocked (or identity?) domain that idles
the hardware and use that as the blocked and release_domain in the
ops.

The logic around vsi_iommu_detach_device() and
vsi_iommu_attach_device() is also not quite right. The attach can
happen while iommu->domain is already set and doesn't deal with
removing the iommu from the old domain's list.

I would probably change vsi_iommu_enable() into vsi_iommu_set_paging()
and then presumably vsi_iommu_disable() is vsi_iommu_set_blocking() ?

vsi_iommu_detach_device() should be deleted and integrated into the
blocked domain and attach error unwind.

> +static int vsi_iommu_of_xlate(struct device *dev,
> +			      const struct of_phandle_args *args)
> +{
> +	struct platform_device *iommu_dev;
> +
> +	if (!dev_iommu_priv_get(dev)) {
> +		iommu_dev = of_find_device_by_node(args->np);
> +		if (WARN_ON(!iommu_dev))
> +			return -EINVAL;
> +
> +		dev_iommu_priv_set(dev, platform_get_drvdata(iommu_dev));
> +	}

The driver should ideally not be calling dev_iommu_priv_set/get here,
and this leads the reference doesn't it? Do what ARM did to locate
the iommu_dev.

I would also add a comment here:

> +static int vsi_iommu_map(struct iommu_domain *domain, unsigned long _iova,
> +                        phys_addr_t paddr, size_t size, size_t count,
> +                        int prot, gfp_t gfp, size_t *mapped)
> +{
> +       struct vsi_iommu_domain *vsi_domain = to_vsi_domain(domain);
> +       unsigned long flags;
> +       dma_addr_t pte_dma, iova = (dma_addr_t)_iova;
> +       u32 *page_table, *pte_addr;
> +       u32 dte, pte_index;
> +       int ret;

/*
 * IOMMU drivers are not supposed to lock the page table, however this
 * driver does not safely handle the cache flushing or table
 * installation across concurrent threads so locking is used as a simple
 * solution.
 */

> +       spin_lock_irqsave(&vsi_domain->dt_lock, flags);

Jason
