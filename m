Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323D61DF987
	for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773701697; cv=none; b=DzKUoS+qM+fV1ncwFhJlbNVaTYEgcUsAHkvDSuKeARDdpdQV7KXGnG2tqjGLt6l3ZNO40B8COPqefW3Z91E6MUsMNj2ig2AthYTnGZmA64Df8r21nDTGx1BcqOGURkZQ2Om2tR0xAJ+oFeth54D3XjW9ZIVIaZjz4RHmEP8fzhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773701697; c=relaxed/simple;
	bh=nibhYwiPdt++G6J9J7ria/uZagWKJzcUfGV8vktD+b4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uyO6NnGJYxG1hftX49kwuoQ5ZT4GfjvA4qTr5TJqrh1Sz5V3WHZgL7MdQHOOxz6Q58BJT7nOiG8RoegENhoYPJvQYgmcQjXof85f9pwEnuwKqUv8OAxyv5muZl6aKiREkdcXFo6LqH7XksMyUqn6ArRHhBdphQ1OWb9Botifwhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNops5j2; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNops5j2"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b052562254so36435ad.0
        for <iommu@lists.linux.dev>; Mon, 16 Mar 2026 15:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773701695; x=1774306495; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aESMhDv9gp0zMf1EBnN9PJRbyf0p6BUGu73DNh1Qjzg=;
        b=oNops5j2ON2dOx0LSg0OlgZeXoQU2gwrIMfBrGJGZMfNR1BhQ/7dleSySEU8DeZZl0
         c26HmpiNecgqvgPCsODU5p9CPT8lVxsSRwKzfmVIVawBDLcBvz5lZqcxTelswySd4wXV
         ytXPDgRxez5rZqQ8V4n5A3YAQMA4SZFAHUJokdEviywg2DekQQoFM5cJrXH9VjBAGRiF
         i3lRAUNwo1HZ8qi27Wr7LXiEz16AheIAr1Lu9pPwa5ImKmpzoXnaqkoMloPrMp9E4SRm
         vDp5HVCBgv2xByQh8RwFUXgDPE3XdasQi43UTEao7d53u7Z4VeAnEK2BEP72GxSViL77
         jSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773701695; x=1774306495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aESMhDv9gp0zMf1EBnN9PJRbyf0p6BUGu73DNh1Qjzg=;
        b=Hjcmic3JKFutOn2sZvCxFv7jQdeyP6sg3Z5+uSrFjEG2ThIrHyBsB9wODqfKWqVHux
         YKOIoppGRvUN7plIMGFAiksecUxet1qNCFgZLT2ffUm17DsuwwFGMT3n+UjDINssyO+7
         zOjbuEcFZZiD9MLVjDvKne1pq9uRNw7Rg7g7hNd0Gk3avurIKWop6FL105JcQ9R3vStq
         ZXBCwaziodDmSGt8hn79k3hAz5yjn7COYCnLR8YSASxU3Hme8svnj6KpiB3k8shUB4Pb
         gg59/8mq/tfFrIkBpro0ywL3hfZi3UZ5X9InySf5aSwLG1NXXvqXs4CKTxJ+rVqd79dl
         peMA==
X-Forwarded-Encrypted: i=1; AJvYcCVybqFqWpGHsAolDFSiCw1KmN4h99aIZViDywVQmiY0QNg6hUIIPI6SWk1n+h9LiuuKVmzxNQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwC7s/cl9hy4EvdVdw/oCfNDR4ZbkbKBlWNPAuLkA3I8IQOpuh4
	nHA/vZ/4tbyPQxQqy2V95zMQJ2Olh0h71i93fAcLfSjxjoH1YUX/JNDVKnOQ5GHEInTXBNhABda
	CbydMRexP
X-Gm-Gg: ATEYQzw92JTp8MoTYOf8C5Yah4pk75z1sN824JAT6tfmhcp6OHKs1n9KSYhnN3XtBAb
	QcyTHOp8kF8u2VCqa+EC1IlqKf3u4znghvvByAH3hu2cciwy3GU//Dk4K3be1zuo+h1yk772JEt
	XTOpnGMQDiAz6VpNzvKtOdFaa0dghPuANVAMVq7EcXPJ8eQAs6GrOIGOpHtJ1O+t26tXdQWgA6t
	MFuGDisr49TwIfCO/cBWxqPOpnyciRq3Ypy9BTqQuPis01jt/dmSNsbTHEQ0p8TW4jvpV5TYZl+
	hdmAD301Zxkaz8IYd5n33HDCxB+XVjF0aNWoGPkknoNwpDjVP3FwK3b0NTPBtlv/932we29ijE8
	qXoT0nnaka5SodCEuAmOKl8JhzFiGjLK0lyy1D8tb83hb1bhnz/CzDVg4Gd0RCXzEeCjt9wFGe2
	MsIzOEG2QEu0i8VOykYDrf7NeGKpkh7T9ZUnt2tVbE2UY4RhOa3SepbYAFNQ==
X-Received: by 2002:a17:902:e54d:b0:2a9:5bfa:54ef with SMTP id d9443c01a7336-2b063ee45a7mr1438565ad.10.1773701694173;
        Mon, 16 Mar 2026 15:54:54 -0700 (PDT)
Received: from google.com (60.89.247.35.bc.googleusercontent.com. [35.247.89.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725ca0asm17538461b3a.17.2026.03.16.15.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 15:54:53 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:54:50 -0700
From: Vipin Sharma <vipinsh@google.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Pranjal Shrivastava <praan@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 01/14] iommu: Implement IOMMU LU FLB callbacks
Message-ID: <20260316165018.GA1768676.vipinsh@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-2-skhawaja@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203220948.2176157-2-skhawaja@google.com>

On Tue, Feb 03, 2026 at 10:09:35PM +0000, Samiullah Khawaja wrote:
> +config IOMMU_LIVEUPDATE
> +	bool "IOMMU live update state preservation support"
> +	depends on LIVEUPDATE && IOMMUFD
> +	help
> +	  Enable support for preserving IOMMU state across a kexec live update.
> +
> +	  This allows devices managed by iommufd to maintain their DMA mappings
> +	  during kexec base kernel update.
> +
> +	  If unsure, say N.
> +

Do we need a separate config? Can't we just use CONFIG_LIVEUPDATE?

>  menuconfig IOMMU_SUPPORT
>  	bool "IOMMU Hardware Support"
>  	depends on MMU
> diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
> index 0275821f4ef9..b3715c5a6b97 100644
> --- a/drivers/iommu/Makefile
> +++ b/drivers/iommu/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_IOMMU_IO_PGTABLE_ARMV7S) += io-pgtable-arm-v7s.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE) += io-pgtable-arm.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_LPAE_KUNIT_TEST) += io-pgtable-arm-selftests.o
>  obj-$(CONFIG_IOMMU_IO_PGTABLE_DART) += io-pgtable-dart.o
> +obj-$(CONFIG_IOMMU_LIVEUPDATE) += liveupdate.o

It seems like there is a sorted order for CONFIG_IOMMU_* in the
Makefile, lets keep it same if possible.

> +static void iommu_liveupdate_free_objs(u64 next, bool incoming)
> +{
> +	struct iommu_objs_ser *objs;
> +
> +	while (next) {
> +		objs = __va(next);

There is also call to phys_to_virt() in other functions in this patch.
Should we use the same here to be consistent?

> +		next = objs->next_objs;
> +
> +		if (!incoming)
> +			kho_unpreserve_free(objs);
> +		else
> +			folio_put(virt_to_folio(objs));
> +	}
> +}

Instead of passing boolean, and calling with different arguments, I
think it will be simpler to just have two functions

- iommu_liveupdate_unpreserve()
- iommu_liveupdate_folio_put()

> +
> +static void iommu_liveupdate_flb_free(struct iommu_lu_flb_obj *obj)
> +{
> +	if (obj->iommu_domains)
> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, false);
> +
> +	if (obj->devices)
> +		iommu_liveupdate_free_objs(obj->ser->devices_phys, false);
> +
> +	if (obj->iommus)
> +		iommu_liveupdate_free_objs(obj->ser->iommus_phys, false);
> +
> +	kho_unpreserve_free(obj->ser);
> +	kfree(obj);
> +}
> +
> +static int iommu_liveupdate_flb_preserve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct iommu_lu_flb_ser *ser;
> +	void *mem;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_KERNEL);
> +	if (!obj)
> +		return -ENOMEM;
> +
> +	mutex_init(&obj->lock);
> +	mem = kho_alloc_preserve(sizeof(*ser));
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	ser = mem;
> +	obj->ser = ser;
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->iommu_domains = mem;
> +	ser->iommu_domains_phys = virt_to_phys(obj->iommu_domains);
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->devices = mem;
> +	ser->devices_phys = virt_to_phys(obj->devices);
> +
> +	mem = kho_alloc_preserve(PAGE_SIZE);
> +	if (IS_ERR(mem))
> +		goto err_free;
> +
> +	obj->iommus = mem;
> +	ser->iommus_phys = virt_to_phys(obj->iommus);
> +
> +	argp->obj = obj;
> +	argp->data = virt_to_phys(ser);
> +	return 0;
> +
> +err_free:
> +	iommu_liveupdate_flb_free(obj);

Generally, I have seen in the function goto will call corresponding
error tags, and free corresponding allocations and all the one which
happend before. It is easier to read code that way. I know you are
combining the free call from iommu_liveupdate_flb_unpreserve() also.
IMHO, code readability will be better this way.

> +	return PTR_ERR(mem);
> +}
> +
> +static void iommu_liveupdate_flb_unpreserve(struct liveupdate_flb_op_args *argp)
> +{
> +	iommu_liveupdate_flb_free(argp->obj);
> +}
> +
> +static void iommu_liveupdate_flb_finish(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj = argp->obj;
> +
> +	if (obj->iommu_domains)
> +		iommu_liveupdate_free_objs(obj->ser->iommu_domains_phys, true);

Can there be the case where obj->iommu_domains is NULL but
obj->ser->iommu_domains_phys is not? If that is not possible, I will
just simplify the patch and unconditionally call
iommu_liveupdate_free_objs()?

> +
> +static int iommu_liveupdate_flb_retrieve(struct liveupdate_flb_op_args *argp)
> +{
> +	struct iommu_lu_flb_obj *obj;
> +	struct iommu_lu_flb_ser *ser;
> +
> +	obj = kzalloc(sizeof(*obj), GFP_ATOMIC);
> +	if (!obj)
> +		return -ENOMEM;

Is kzalloc() failure here recoverable whereas iommu_liveupdate_restore_objs()
below is not? If it is not recoverable should there be a BUG_ON here?

> +
> +	mutex_init(&obj->lock);
> +	BUG_ON(!kho_restore_folio(argp->data));
> +	ser = phys_to_virt(argp->data);
> +	obj->ser = ser;
> +
> +	iommu_liveupdate_restore_objs(ser->iommu_domains_phys);
> +	obj->iommu_domains = phys_to_virt(ser->iommu_domains_phys);

Can iommu_liveupdate_restore_obj() just return virtual address and we
can simplify code to:

	obj->iommu_domains = iommu_liveupdate_restore_objs(ser->iommu_domains_phys);

> +
> +	iommu_liveupdate_restore_objs(ser->devices_phys);
> +	obj->devices = phys_to_virt(ser->devices_phys);
> +
> +	iommu_liveupdate_restore_objs(ser->iommus_phys);
> +	obj->iommus = phys_to_virt(ser->iommus_phys);
> +
> +	argp->obj = obj;
> +
> +	return 0;
> +}
> +
> diff --git a/include/linux/iommu-lu.h b/include/linux/iommu-lu.h

I will recommend to use full name and not short "lu". iommu-liveupdate.h
seems more readable and not too long.

> +#define MAX_IOMMU_SERS ((PAGE_SIZE - sizeof(struct iommus_ser)) / sizeof(struct iommu_ser))
> +#define MAX_IOMMU_DOMAIN_SERS \
> +		((PAGE_SIZE - sizeof(struct iommu_domains_ser)) / sizeof(struct iommu_domain_ser))
> +#define MAX_DEVICE_SERS ((PAGE_SIZE - sizeof(struct devices_ser)) / sizeof(struct device_ser))

This is per page limit, not whole serialization limit. May be we can
name something like:

- MAX_IOMMU_SERS_PER_PAGE, or
- MAX_IOMMU_SERS_PAGE_CAPACITY

> +
> +struct iommu_lu_flb_obj {
> +	struct mutex lock;
> +	struct iommu_lu_flb_ser *ser;
> +
> +	struct iommu_domains_ser *iommu_domains;
> +	struct iommus_ser *iommus;
> +	struct devices_ser *devices;
> +} __packed;
> +

I think naming scheme used here is little hard to absorb when we have so
many individual structs in this header file. Specifically, struct names like:

- iommu_domains_ser vs iommu_domain_ser
- iommus_ser vs iommu_ser
- devices_ser vs device_ser
- iommu_objs_ser vs iommu_obj_ser

First three are showing container and its elements relation, however,
last one doesn't have that relation but naming is same there.

I will recommend to change the naming scheme of containers to something like:

	struct iommu_domain_ser_[hdr|header|table|arr] {};
	struct iommu_ser_hdr {}
	struct device_ser_hdr {}

Individual element of container can be same.

For objs, something like: 
	iommu_objs_ser -> iommu_hdr_meta

