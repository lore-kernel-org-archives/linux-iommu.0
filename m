Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217A12EBFC
	for <iommu@lists.linux.dev>; Wed,  1 May 2024 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714575385; cv=none; b=Iqk5ZPtff9+joT5o4P2G7rz0UAmLkD4RWsliiMnN3q1l9KAbbtwkX42p/ojf/GeGqXHdLJVBuCgKpQiaVuUvJ3hd/RBzs2+S1T0untLKNPpX2kKNvch2z5ZPqrv/Ai+brZ7Z8RmtQSnwLJ0DRGtGEZaWXdrQ4FG2q8tUpqoycpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714575385; c=relaxed/simple;
	bh=D8dDhjJUKcoc6hx+nWiNh4JOa3uMyj4QJvA0UZJL02M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeZEkUvbx3eSNin6AstwBvXXxvhKmbCecHtNITI5fm6XNwMDdwz5cV9PkLItS0MefE0ryOJmYpRGoNDO7jaHcMmKjsHIzMp2rQeIfBUGwE8YddzmQU5N3cP8CvUDvOveo0GyMENsGwU+g14thu04jlQNuxfbqptfVvbSVszwbNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kGF6Y6oD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kGF6Y6oD"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-790605809cbso605509285a.3
        for <iommu@lists.linux.dev>; Wed, 01 May 2024 07:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1714575383; x=1715180183; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eJGnH6JMeRVIDCgE3fOFl84u0C8yQJQw2QrSPFhIV3E=;
        b=kGF6Y6oD3wAn7KziP2q7jFMMxL9HbTfiofsvq9RiRhLfwObSJlNtg9tbmO8LF6FqYI
         HkVHU0WEnVkZV97a1NF3xCJXPQHMzRKESgD3JS6ASEFtRJUFy9fy/dMekMNA5v4FzRZ/
         UaVh2gxKEOybPwGMKVcYcEh1WK4q8A6G0JX0n9KaPJ7r5bmiYxMIgkNG5psHnE2hrhyb
         9JpIYLCmJ6c6c1dzejyAvyqm+wtwpo2OiPD7KoOu60umjsAk1DuRSfrsDUDOUnLPWDwm
         fi3VHcqoKpLnZiWrDGhVl1s1hPoKpZRW3Z9wctQXYppRcRAqaDD4bxT6TI1x1amvJKdP
         B2vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714575383; x=1715180183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJGnH6JMeRVIDCgE3fOFl84u0C8yQJQw2QrSPFhIV3E=;
        b=E9BKE6qQuRE0FYelOK1ZSRNd1ievRGHE2ZJwkksfozb9fIn3/+qf9UYPvvSze/gr+E
         B9aqv+eDpNX7BWt06K+wrNmwdaZMQ3Xlyh+nwV3NthtT3p7iw9vJUaCHp9If3Lvs8aap
         m7INU71tmJmBTNiY97zQpNKLyQ6fyahpInRtF3QuL0pymhgdo7XQQ2n4lvptCahu/U1h
         wGwM3EIQP24+vYgvXnRcAdjyV9c4teSUJFB3exV1zdakzL6ruUie+Q9uAPkaIgO4I9k4
         XKnha2sglPMCgJkPPdfBcqZKxGOO2qx4+V4RKO422ukNnaLWWL2910b75Mwy4h0EDocy
         PPFA==
X-Forwarded-Encrypted: i=1; AJvYcCVFA7z0Qz7t/yhzfIJn9wlLKkL/3shljf0cNt+gEnWd6djKzOxF+3Ng+bcn6RBgcFRvkZrpCqU67GXmyM/e744yrOaiuJs=
X-Gm-Message-State: AOJu0Ywm9i/5AXXDP0RxVGMIyhbcapWrEmr45c4zCulyGsewloGL/hNB
	aJDxiqc7f4ehsDEoh8bSiejMvMrfV/jqsADBqLww58eCLnAAlBP32bfsA9697p0=
X-Google-Smtp-Source: AGHT+IG0qIFy2caBLvcDGBIvg4IVVCR5d+JtATohiEj0n9TMLtXKBV4S0Llv/scMqMPm8vuwzEv6aw==
X-Received: by 2002:a05:620a:1787:b0:78f:280:90f8 with SMTP id ay7-20020a05620a178700b0078f028090f8mr3155974qkb.78.1714575382931;
        Wed, 01 May 2024 07:56:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p2-20020a05620a22e200b00790ef37673fsm2901144qki.7.2024.05.01.07.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:56:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s2BNd-00Dc3Y-Hd;
	Wed, 01 May 2024 11:56:21 -0300
Date: Wed, 1 May 2024 11:56:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tomasz Jeznach <tjeznach@rivosinc.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Anup Patel <apatel@ventanamicro.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Nick Kossifidis <mick@ics.forth.gr>,
	Sebastien Boeuf <seb@rivosinc.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	iommu@lists.linux.dev, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux@rivosinc.com
Subject: Re: [PATCH v3 7/7] iommu/riscv: Paging domain support
Message-ID: <20240501145621.GD1723318@ziepe.ca>
References: <cover.1714494653.git.tjeznach@rivosinc.com>
 <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b83f81c04d1f3885d860b1eec03761fe63a33183.1714494653.git.tjeznach@rivosinc.com>

On Tue, Apr 30, 2024 at 01:01:57PM -0700, Tomasz Jeznach wrote:

> +#define iommu_domain_to_riscv(iommu_domain) \
> +	container_of(iommu_domain, struct riscv_iommu_domain, domain)
> +
> +#define dev_to_domain(dev) \
> +	iommu_domain_to_riscv(dev_iommu_priv_get(dev))

Please use the priv properly and put a struct around it, you'll
certainly need this eventually to do the rest of the advanced
features.

> +static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain, struct device *dev)
> +{
> +	struct riscv_iommu_bond *bond, *found = NULL;
> +	unsigned long flags;
> +
> +	if (!domain)
> +		return;
> +
> +	spin_lock_irqsave(&domain->lock, flags);

This is never locked from an irq, you don't need to use the irqsave
variations.

> +	list_for_each_entry_rcu(bond, &domain->bonds, list) {
> +		if (bond->dev == dev) {
> +			list_del_rcu(&bond->list);
> +			found = bond;
> +		}
> +	}
> +	spin_unlock_irqrestore(&domain->lock, flags);
> +
> +	/* Release and wait for all read-rcu critical sections have completed. */
> +	kfree_rcu(found, rcu);
> +	synchronize_rcu();

Please no, synchronize_rcu() on a path like this is not so
reasonable.. Also you don't need kfree_rcu() if you write it like this.

This still looks better to do what I said before, put the iommu not
the dev in the bond struct.


> +static struct iommu_domain *riscv_iommu_alloc_paging_domain(struct device *dev)
> +{
> +	struct riscv_iommu_domain *domain;
> +	struct riscv_iommu_device *iommu;
> +
> +	iommu = dev ? dev_to_iommu(dev) : NULL;
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return ERR_PTR(-ENOMEM);
> +
> +	INIT_LIST_HEAD_RCU(&domain->bonds);
> +	spin_lock_init(&domain->lock);
> +	domain->numa_node = NUMA_NO_NODE;
> +
> +	/*
> +	 * Follow system address translation mode.
> +	 * RISC-V IOMMU ATP mode values match RISC-V CPU SATP mode values.
> +	 */
> +	domain->pgd_mode = satp_mode >> SATP_MODE_SHIFT;

This seems really strange, the iommu paging domains should be
unrelated to what the CPU is doing. There is no connection between
these two concepts.

Just pick a size that the iommu supports.

The number of radix levels is a tunable alot of iommus have that we
haven't really exposed to anything else yet.

> +	/*
> +	 * Note: RISC-V Privilege spec mandates that virtual addresses
> +	 * need to be sign-extended, so if (VA_BITS - 1) is set, all
> +	 * bits >= VA_BITS need to also be set or else we'll get a
> +	 * page fault. However the code that creates the mappings
> +	 * above us (e.g. iommu_dma_alloc_iova()) won't do that for us
> +	 * for now, so we'll end up with invalid virtual addresses
> +	 * to map. As a workaround until we get this sorted out
> +	 * limit the available virtual addresses to VA_BITS - 1.
> +	 */
> +	domain->domain.geometry.aperture_start = 0;
> +	domain->domain.geometry.aperture_end = DMA_BIT_MASK(VA_BITS - 1);
> +	domain->domain.geometry.force_aperture = true;

Yikes.. This is probably the best solution long term anyhow, unless
you need to use the last page in VFIO for some reason.
  
>  static int riscv_iommu_device_domain_type(struct device *dev)
>  {
> -	return IOMMU_DOMAIN_IDENTITY;
> +	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
> +
> +	if (iommu->ddt_mode == RISCV_IOMMU_DDTP_MODE_BARE)
> +		return IOMMU_DOMAIN_IDENTITY;
> +

Is there even a point of binding an iommu driver if the HW can't
support a DDT table? Just return -ENODEV from probe_device?

Logically a iommu block that can't decode the RID has no association
at all with a Linux struct device :)

Jason
