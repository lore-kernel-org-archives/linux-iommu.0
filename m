Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE7E327C09
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582573; cv=none; b=OyuV3UvUMHqpBNkekRIYqdwaDYcOfgILsX6q8UlqtYvbtJ6P2QXyBuMq9rDwEoeQ1JMsgRhk6NyJfOGroPcU8E6jUg0FJkctTTqMrY0ZE3omQsysecv0gC48GeagwPxc9+dV4jcZyBK3u+0wlGZo12Ye46FgEwHq67EC1sT0m9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582573; c=relaxed/simple;
	bh=aJF1d+m4cWAoRzuU8BG1p4iKKK04toIulzONa4qjt28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+GPpTqDotnKsqj21ZzP02Tc2LpC4MnBd95hFt0Vc8J/VR9PRKxzYiOaj5F0C+kBgT2fd8rl4zkm0S3Vv5UNTB4udKDilJUsvT92QHI+wHIdmxREAHsVCf27mKMOSN6K5RzL6atksB0EVnxlTqu5MggV1ZPMd3OGjXcZyG8+9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YFa9irJd; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YFa9irJd"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-91563abd6a9so34119285a.3
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780582572; x=1781187372; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
        b=YFa9irJdrp+OY4vNUfUNO6mrbp57wZAWFpza0HnkU6fcHGqcJ95GA+N0zdNFBm1ld5
         QdaQTmLQxeOBz9ciYa8g2lrhjbqyk7mbxeUdo8357Kc3KG5R1ECrEMNaUqglm4jlXPua
         7LYJawSOaraQSraEi1/qQKR/VFe2FwovA0t5aVLl4tImY6z7y5CunXBjgx0rl/WROzCP
         6rhZrU0Tw+IcPIJ8v328MEMxh7lsj5ppRGiTPFguJtjkTlOrkg0HqyRaFCQzy/SKFoAT
         g6v6hYOyX7juqTUPcqB9n+9bkA0U6ZmL9GCBfE5BnuwhHVVyuxhV1FYhppnGcmer6fn1
         O5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582572; x=1781187372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IjXyN1rYbvjp4a1JYQoZrj8n0hmsK/P4C6YKjbOfWXA=;
        b=ocRUCxPz3yQQj1cdDsOtnUwhE6y5N6PHxz3zTl8n8+Rw7esLYepH/5JYKIBCDOKNhq
         4k6T0UhyFX4dnZeX2xTc9JCvvjXPiihQWNBsn7I/LcgQF+XOYe73/yVUzGZN9ypEmIAR
         jA6gVKsu/bdbbXZ9pLgbJYvFyUTfZhQQej1zeTb4Ep8T/o/cJwDLvcmzUnb4TKIcaIdL
         9/i9gK/Cae8FfUztQlFyXgR3J+yQnxt6vV6/pO56K1RiTVlNeVMmBxSkfC6sBwHRZ68h
         7pS6jjOh6CKimlWWzyCaU3uJCfyChNd2smQqQxFJw8EMoB+bMKTmyHQByJEShHp6DRwO
         JQhg==
X-Forwarded-Encrypted: i=1; AFNElJ/+pbjubt5ztUKU4/NQ7ERSyfrQcoI4Je1Uyeni86hX9zvfnF+uerA/eptByPZp7LBCEl9w2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnQ6RWNUueu7A5t+qrR4LnNi+58JRFQaNGfryR4RaU8/Il9mwT
	HvzaNrGLnIclMaFwbHtVX1wVWoROLgNvNAkgBGONpRlQgTqpYw5cf1bU8oTtsXSofHA=
X-Gm-Gg: Acq92OH0Lw6CzoUwhNZ0r28D0MeIJkjLbJlMi0lnA3UeBouGqolmfT8hUNoz0e2b8KK
	/BiJl5uyF3/IpHir8Ypr8QVMtA1fIMLDUraSPlgpxYRpTvGECCnPssYx+RPH/KZm25QzgFUeGha
	JcWmrpx59QsYo+EjWezukyF9dQu0vgTJXtbK+gfmrXOlHJehqXBKGo6+nLWGDlCDkBYndFgoU6a
	TX9pjW2umMuiPHeXC7egtdxwM1Tf1ZiDrah1xQAaHB9KsSwZhYEoqS4BCb5DkAb8OgsDE1/9KYx
	58utVPGNIwQyB+eXm4UDROf5qfpKfpoN1HVnB23V3luDpVd2630z3gUxghZsJp0fM8B8jNBT0IL
	PPMc91FlpVlcSGhcMQBf3JHCjJqY5mCkCxHgOwR01fNvkNpq+r6PuRyfWSyDncfY3EH1sJ2qAqm
	xyfSKzbYZuZZtjNKTrvk4R8h5pc5FTlqpv/iv33AZ+uRML3C147fg8eWyjy2KmF0XPnpNBSxDcO
	6EAcgPR9ryjVuCp
X-Received: by 2002:a05:620a:7081:b0:915:7b23:4afd with SMTP id af79cd13be357-9158a7292d8mr1364770885a.16.1780582571570;
        Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a3b637esm580303885a.32.2026.06.04.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 07:16:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wV8ri-00000008HMt-1ns6;
	Thu, 04 Jun 2026 11:16:10 -0300
Date: Thu, 4 Jun 2026 11:16:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Guanghui Feng <guanghuifeng@linux.alibaba.com>
Cc: adrian.larumbe@collabora.com, airlied@gmail.com, alex@shazbot.org,
	alikernel-developer@linux.alibaba.com, baolu.lu@linux.intel.com,
	boris.brezillon@collabora.com, dri-devel@lists.freedesktop.org,
	dwmw2@infradead.org, iommu@lists.linux.dev, joro@8bytes.org,
	kevin.tian@intel.com, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, oliver.yang@linux.alibaba.com, robh@kernel.org,
	robin.murphy@arm.com, shiyu.zsq@linux.alibaba.com,
	steven.price@arm.com, suravee.suthikulpanit@amd.com,
	tzimmermann@suse.de, wei.guo.simon@linux.alibaba.com,
	will@kernel.org, xlpang@linux.alibaba.com
Subject: Re: [PATCH v3 01/32] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260604141610.GX2487554@ziepe.ca>
References: <20260602104637.1219810-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-1-guanghuifeng@linux.alibaba.com>
 <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603151804.1963871-2-guanghuifeng@linux.alibaba.com>

On Wed, Jun 03, 2026 at 11:17:33PM +0800, Guanghui Feng wrote:
> +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> +				       dma_addr_t iova,
> +				       size_t *mapped_length)
>  {

This should take in an ending point so the accumulation knows when to
stop, otherwise it is too hard to use.

> -	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> +	phys_addr_t phys;
> +
> +	if (domain->type == IOMMU_DOMAIN_IDENTITY) {
> +		if (mapped_length)
> +			*mapped_length = PAGE_SIZE;
>  		return iova;
> +	}
>  
> -	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> -		return 0;
> +	if (mapped_length)
> +		*mapped_length = 0;
> +
> +	if (domain->ops->iova_to_phys_length)
> +		return domain->ops->iova_to_phys_length(domain, iova, mapped_length);
> +
> +	/* Fallback to legacy iova_to_phys without length info */
> +	if (!domain->ops->iova_to_phys)
> +		return PHYS_ADDR_MAX;
> +
> +	phys = domain->ops->iova_to_phys(domain, iova);
> +	if (!phys)
> +		return PHYS_ADDR_MAX;

And to properly clean up the callers all the non-iommupt paths should
manually do accumulation here as well.

Basically if you call this function you get a maximal contiguous
physical range as efficiently as possible.

Jason
