Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751763ABD91
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321406; cv=none; b=YbLu7qeppP+gsuRH6+48Bi9nzjcZ531Fm9DOZxzgmszbSAVWO6WEbTcwDV8415x3fJnC8rH8bixKRRww08t8bSdFkeypY4+MVxMSXOzFYswdm492Mve2zbT3542VUwumPzwKVApUkaAbnu4quj10n+Spr93jDeKLmC6TTdRC1D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321406; c=relaxed/simple;
	bh=6MVl9gF6JoewXnXcEZQ4a8O7c6chwzYhLEtrcH4ruBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWbk6mukG+nlX94iiAv/aUGhfcqt5HxdXBnrLzRIkM+OkvyD1/oqFdwzh5ARqFpGoZ2d24eLWKXdSHNbJ6Pe5pPHZKC7DZER0NkL/g4Q5hRHMBb7kpogAU5MukG/PwIncmDNjqGrrEfQgpFgom77aqcpfRR2tNRR/fRBSjpZbZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=c9VmO2EP; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="c9VmO2EP"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ce9e56f68cso9784426d6.2
        for <iommu@lists.linux.dev>; Mon, 01 Jun 2026 06:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780321404; x=1780926204; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
        b=c9VmO2EPxo5wAp1bsdotFe/c0gJupubvIkXnKRVby3m0SSZRIsAbbBJq3Gp/ePJQz1
         fk8rYN5/BFugezVGtKeGf1PwXR5n+8zcvpfPgpyc32yZkIwFyzgN+7O0E2Pf0OMzQGCR
         Nq2bwzfyNNXt1MbFNBT9bz9Ih+v028AyuWrZHe7xae6RDTI8HEZeG0GOKanbeqBJab9S
         Ql9t/T0ovRR1JigUPieSxpqdG15VC7fKUckq2FXlpetj3cpTGOymHYpBZiM4GqTyBsG/
         IfH9sy3hAAge9qpkApq1sNAGYo5mkddosNxVZG901+K3h6gIiMZG6uf1WvfRFCNaBpwX
         yafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321404; x=1780926204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UW5JYVSwrnBAFt5psB8n67PnIhkPqJ98B0eIWZFk1Os=;
        b=lO63idsNkyeTtm0/+SjxgkwMhaw5Dun3WOBDoEP+Orf2LE61TP02CuMVkqEvIq3ZAN
         Y6tQ6xsdERauVyom0UuEJ24GkYdwa+rLJO3CkAAzxBwHMHr1jy6buYkjzoqjl/s64pgV
         vJW3eE7QYqe+UPFtfYj1WxvxKO36FV4Or3ajlzjbjl3vsL4SGf1XCmmm9LTfvfRrfZEN
         CccAEH/N4md8ft2MFSwZZPMGt06VxxcyuMqpqJKvgI2997D19TNOWpWzIKaWt5i036dH
         Q1WRHyk4PQA5LOT0hpfjTFOAqp2N5p6ZDeXsgpcyt/DVahtpxwz3NqyErHNkTpwQUMJX
         hKNA==
X-Forwarded-Encrypted: i=1; AFNElJ+82J3kfqal8D7K9gxoBBVkZ4HNWM8CK/YeVnX0BmyP/3EPJBZ/UbbfDfumu2r5qB4Bp6fpLg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFq87BoPOXwqBiq4lyQvslQajKBwnDmAX7+o8SF9LEj58/AioJ
	9FCY/dYPHAr05Ggt7zWwtRHsOc1c/X8Kb0mE223UABRbPf3XqCBkP1bP14ryI5ec7CQ=
X-Gm-Gg: Acq92OEbOWgw0TnctE7dTp1mLAEnQvM9xdJ6yE4aO6sK1GAGHOuvnSN3gFf9dg9Ct9L
	x1NUMD10I663yzN+MPT9kgBq11sPOFmBwgjDY2aGPjn4CowG21cp9+/ii1idA6qlNpnprUMNfii
	ZaQanenOMInjwR/ryG4JUul6KagBi9evm5AX8z/WQOSGAQgTCLtQlkVuiEzUBBZR8L3uVammGDX
	45s+DY7C7lkp5OcAg8JeTfWXLd4m8mPnbh4/utePoAZd/C9E0/4A4eKL4o8jdXFZQMKEGJDaF5o
	J52muVKn9ksEUjJuJU+pfWRutF1tTxvr08aGaBN/ub6eyK053K6v3+hj/QnqlYlvhun5GuT6qmH
	rvRsJQzJuEeEUbx9Re4+kQAvhiAAjFpNm+wj5qtE0vaDYH952P1z4Z8Wi/mbo0y5R7+XDSUJuYk
	PX+le9p6dVGw39rKMsM6EKP0PFEeOfLLaBGWUf1jatuSkIkWL4LCjPuJdeKJPkhK/fs7k4mcUKn
	XlRAplImsV1rcUK3V+3xfaJnqY=
X-Received: by 2002:a05:6214:2e41:b0:8cb:fd76:e904 with SMTP id 6a1803df08f44-8ccefd62159mr193200966d6.17.1780321404292;
        Mon, 01 Jun 2026 06:43:24 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea042373sm94107096d6.9.2026.06.01.06.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:43:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wU2vK-00000001iEk-2KA6;
	Mon, 01 Jun 2026 10:43:22 -0300
Date: Mon, 1 Jun 2026 10:43:22 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: boris.brezillon@collabora.com, robh@kernel.org, steven.price@arm.com,
	adrian.larumbe@collabora.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	liviu.dudau@arm.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, alex@shazbot.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kevin.tian@intel.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	dwmw2@infradead.org, xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com, shiyu.zsq@linux.alibaba.com,
	wei.guo.simon@linux.alibaba.com,
	alikernel-developer <alikernel-developer@linux.alibaba.com>
Subject: Re: [PATCH 1/9] iommu: introduce iova_to_phys_length in
 iommu_domain_ops
Message-ID: <20260601134322.GY2487554@ziepe.ca>
References: <20260529115116.GR2487554@ziepe.ca>
 <20260531093637.3893199-1-guanghuifeng@linux.alibaba.com>
 <20260531093637.3893199-2-guanghuifeng@linux.alibaba.com>
 <20260531235148.GV2487554@ziepe.ca>
 <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0875d9f-4aed-4164-861c-6fbbdfe04080@linux.alibaba.com>

On Mon, Jun 01, 2026 at 04:41:48PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > +/**
> > > + * iommu_iova_to_phys_length - Translate IOVA and return mapping page size
> > > + * @domain: IOMMU domain to query
> > > + * @iova: IO virtual address to translate
> > > + * @mapped_length: Output parameter for the PTE page size (e.g. 4KB/2MB/1GB)
> > > + *
> > > + * Like iommu_iova_to_phys() but additionally returns the page size of the
> > > + * PTE mapping at @iova through @mapped_length.
> > > + *
> > > + * Return: The physical address for the given IOVA, or 0 if no translation.
> > > + */
> > When introducing the new function I would like to fix this 0 error as
> > well, it should return PHYS_MAX for error
> 
> Implementations such as arm_smmu_iova_to_phys/DOMAIN_NS(iova_to_phys)
> all use a return value of 0 as an invalid state, so 0 is used as the
> representation of an invalid state to maintain compatibility.

I know, but this bad choice has already caused bugs so if we are
changing everything I would prefer we fix it.

> > > +phys_addr_t iommu_iova_to_phys_length(struct iommu_domain *domain,
> > > +				       dma_addr_t iova,
> > > +				       size_t *mapped_length)
> > >   {
> > > +	if (mapped_length)
> > > +		*mapped_length = 0;
> > > +
> > >   	if (domain->type == IOMMU_DOMAIN_IDENTITY)
> > >   		return iova;
> > >   	if (domain->type == IOMMU_DOMAIN_BLOCKED)
> > >   		return 0;
> > Any domain that doesn't have an op should fail, blocked is one example
> 
> In accordance with the implementation of iommu_iova_to_phys, it returns a
> phy value of 0 in invalid states.

Detect the invalid states by looking at ops not domain->type

> > I suggest you approach the patch plan a little differently, the first
> > patches should implement the new function and an iommput
> > implementation
> > 
> > Arrange things so the normal iova_to_phys calls the new function if it
> > is available and discards the length.
> > 
> > Then convert callers that can take advantage of it. Have the fallback
> > path also compute the length by iterating internally.
> > 
> > Finally one patch per driver implementing the new op, this could even
> > be a second series.
> > 
> > Don't remove iova_to_phys(), it is fine for things that don't need the
> > length.
> 
> Does this mean retaining the iommu_iova_to_phys implementation but
> implementing it through domain->ops->iova_to_phys_length (mapped_length is
> NULL)?

Yes

Jason
