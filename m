Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F6A14A0A3
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652262; cv=none; b=e0iTcy02kRi0JbYF271lJynVm0LMDOucLh/UT4dr/fUPBiNCQuWpxIm2cE2/qEqaiaWsQ0QpDN/2GFXp20Wdml/xVRTbUO5QFBtaLplHBITe5lORAxC5PQt1gkhblUuvMZwmeEiVGFssZA5f0m4WTTPwdfTBuSHiCPIm8P/EU3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652262; c=relaxed/simple;
	bh=So1bT6v/8IBUYr9O0B8Tc8G+IQCBnuKe6Hrn1SqQMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1t8U2HzmWQzAcek224s1EgoQ49mnNAKahrK2s43ojpRg/JuQIdz2HP9lkECjm7Q5yCUa1KIOf4cMhxWJzqK8zYRVP9hrVQ+l/ur6JtLabAj+4xeSXU4ycOX/pEBALWJ9xFi5Y2zLpg2vgVXIjEqis4N6zDsiftXIWjQOqBmeio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cpepKwy2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cpepKwy2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737652259;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f2lz1JhxCiAQPWfDUtfyCfkikpyW82hyEvi1Or2PPgU=;
	b=cpepKwy2V6edie8DNLBnttdVVeVFvdhYU5kjSt+a74XlfjBy+Kv9OiytLMaQqWf2GjFY+x
	+kDjesxhfmHBt1Vrrb86nzRIBxk3AnduLJwuFF50skG/+uYHAX4HiwWx/pEA9SFOPdGBBy
	9QV25NlGugb/8Rvzrx22QrjP+ofK0p8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-KrOsKl1yPOapDqktjG-40g-1; Thu, 23 Jan 2025 12:10:56 -0500
X-MC-Unique: KrOsKl1yPOapDqktjG-40g-1
X-Mimecast-MFC-AGG-ID: KrOsKl1yPOapDqktjG-40g
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38a2140a400so848000f8f.0
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 09:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652255; x=1738257055;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f2lz1JhxCiAQPWfDUtfyCfkikpyW82hyEvi1Or2PPgU=;
        b=p6oEeS8GRtBFEJ2LKEYWn3fMc8CYkF7UtJl6yUcvNCK4mEaezkfOYmiYG7EIBzsnyi
         K6Gq8PtHWvgVi6jzOKAHlBfWsoUHJIMoyIvscQqoheBC0Koe+7ak237Or8MFgHJimXks
         zzOqLUTioNRBLJAjDgc8iRR2rznSESL0AFZNBrGwSKCsRbnfZAQPqnrxXB8UGmq+B0A5
         3koC3B3GSW73gdVTNwxiIMO40V4ToS0SfnIfut8hLedBl/DOhrQD+t3pI6/8zIL+AwC8
         zW7c863+fOPTjtAF2GqvzvqYH0jSGf14vo00HwRUlIDVZGv/O32JPkcK1PqbYh8I8Fn0
         vRCA==
X-Forwarded-Encrypted: i=1; AJvYcCXR8ipxDLEe3Jw5eoqiV9o0CUBgeneQ6E2UA9NKUoFTP9Dc1/EvLPN5L4o5U66mSwg3KfQjAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwSh8sg2nxjOzjCn0bPPUoaNNFkSVt2bb2WhI8jwFSwdshhQEEa
	RF2Vr18NEKBn1mOpbPr7GImvDVaHocfD/+VsqjQNrS+H9fqRX3E9AgcWCrsg63Ddf8VgSz71deo
	R9JxfqqlfJX/TWZfpczY9YAQ+iOQakO0sATkizHNQ5nLvB9DWlUh7
X-Gm-Gg: ASbGncuTuu6+vsmk0tIvlzd7OQhhutQIqFB0Q/hZXcJkaUt2biHxiGzBHQqzHpq2bX1
	F2wm6tlPTHzCJ1iw2uAyuNruGe5vogTULmmtjcnsHdibsmHD4K/QW40sQGAEli0keboWmhFSUO0
	erv4kEQQEU7LBkIpERST6oMgByd3xJDQPMp8h4FPBIpVwyaA3fHPXny2B/mwv9wsvcxRaky+OmT
	KFV+2oY8qgKNViwagbGjFfNBAKkN23JMBG2LIuzXKjt1gyWJkO2ai5ekpYVUL2m7ukdcvKVEbLv
	O0XWxzghjoFMe+Cd2axK6Dr+z7KC2NTQeVAQGOFmvw==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr29480877f8f.41.1737652255083;
        Thu, 23 Jan 2025 09:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK/5MgTOgXIu9+Lg1LjrltVZkaY8JHUprLufh35bjJjxTwBW+dXwhnf8hS5iSt70eBgqDsvw==
X-Received: by 2002:a5d:6da4:0:b0:38b:e32a:10a6 with SMTP id ffacd0b85a97d-38bf57a9932mr29480826f8f.41.1737652254632;
        Thu, 23 Jan 2025 09:10:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31d9a39sm67975795e9.31.2025.01.23.09.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:10:53 -0800 (PST)
Message-ID: <1b48e138-3134-442a-9796-e3a33b106221@redhat.com>
Date: Thu, 23 Jan 2025 18:10:48 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 01/13] genirq/msi: Store the IOMMU IOVA directly in
 msi_desc instead of iommu_cookie
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
 robin.murphy@arm.com, jgg@nvidia.com, kevin.tian@intel.com,
 tglx@linutronix.de, maz@kernel.org, alex.williamson@redhat.com
Cc: joro@8bytes.org, shuah@kernel.org, reinette.chatre@intel.com,
 yebin10@huawei.com, apatel@ventanamicro.com,
 shivamurthy.shastri@linutronix.de, bhelgaas@google.com,
 anna-maria@linutronix.de, yury.norov@gmail.com, nipun.gupta@amd.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, patches@lists.linux.dev,
 jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
 shameerali.kolothum.thodi@huawei.com, smostafa@google.com, ddutile@redhat.com
References: <cover.1736550979.git.nicolinc@nvidia.com>
 <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <671b2128c193fc9ac9af0f4add96f85a785f513a.1736550979.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Qqhsc6NE8l30FCuriMCJxIdrNmQ2enb8bYlzRYZE7Dk_1737652255
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Hi Nicolin,

On 1/11/25 4:32 AM, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
>
> All the iommu cases simply want to override the MSI page's address with
those which translate MSIs
> the IOVA that was mapped through the iommu. This doesn't need a cookie
> pointer, we just need to store the IOVA and its page size in the msi_desc.
>
> Instead provide msi_desc_set_iommu_msi_iova() which allows the IOMMU side
> to specify the IOVA that the MSI page is placed during
> iommu_dma_prepare(). This is stored in the msi_desc and then
iommu_dma_prepare_msi()
> iommu_dma_compose_msi_msg() is a simple inline that sets address_hi/lo.
>
> The next patch will correct the naming.
>
> This is done because we cannot correctly lock access to group->domain in
> the atomic context that iommu_dma_compose_msi_msg() is called under. Today
> the locking miss is tolerable because dma_iommu.c operates under an
> assumption that the domain does not change while a driver is probed.
>
> However iommufd now permits the domain to change while the driver is
> probed and VFIO userspace can create races with IRQ changes calling
> iommu_dma_prepare/compose_msi_msg() and changing/freeing the iommu_domain.
and is it safe in iommu_dma_prepare_msi()?
>
> Removing the pointer, and critically, the call to
> iommu_get_domain_for_dev() during compose resolves this race.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h     |  6 ------
>  include/linux/msi.h       | 45 +++++++++++++++++++++++----------------
>  drivers/iommu/dma-iommu.c | 30 +++++---------------------
>  3 files changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 318d27841130..3a4215966c1b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1513,7 +1513,6 @@ static inline void iommu_debugfs_setup(void) {}
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
>  
>  int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> -void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg);
>  
>  #else /* CONFIG_IOMMU_DMA */
>  
> @@ -1529,11 +1528,6 @@ static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_a
>  {
>  	return 0;
>  }
> -
> -static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> -{
> -}
> -
>  #endif	/* CONFIG_IOMMU_DMA */
>  
>  /*
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index b10093c4d00e..d442b4a69d56 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -184,7 +184,8 @@ struct msi_desc {
>  	struct msi_msg			msg;
>  	struct irq_affinity_desc	*affinity;
>  #ifdef CONFIG_IRQ_MSI_IOMMU
> -	const void			*iommu_cookie;
you may add kernel doc comments above
> +	u64				iommu_msi_iova : 58;
> +	u64				iommu_msi_page_shift : 6;
>  #endif
>  #ifdef CONFIG_SYSFS
>  	struct device_attribute		*sysfs_attrs;
> @@ -285,28 +286,36 @@ struct msi_desc *msi_next_desc(struct device *dev, unsigned int domid,
>  
>  #define msi_desc_to_dev(desc)		((desc)->dev)
>  
> -#ifdef CONFIG_IRQ_MSI_IOMMU
> -static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> -{
> -	return desc->iommu_cookie;
> -}
> -
> -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> -					     const void *iommu_cookie)
> +static inline void msi_desc_set_iommu_msi_iova(struct msi_desc *desc,
> +					       u64 msi_iova,
> +					       unsigned int page_shift)
>  {
> -	desc->iommu_cookie = iommu_cookie;
> -}
> -#else
> -static inline const void *msi_desc_get_iommu_cookie(struct msi_desc *desc)
> -{
> -	return NULL;
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	desc->iommu_msi_iova = msi_iova >> page_shift;
> +	desc->iommu_msi_page_shift = page_shift;
> +#endif
>  }
>  
> -static inline void msi_desc_set_iommu_cookie(struct msi_desc *desc,
> -					     const void *iommu_cookie)
> +/**
> + * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> + * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> + * @msg: MSI message containing target physical address
> + */
> +static inline void iommu_dma_compose_msi_msg(struct msi_desc *desc,
> +					     struct msi_msg *msg)
>  {
> -}
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +	if (desc->iommu_msi_page_shift) {
> +		u64 msi_iova = desc->iommu_msi_iova
> +			       << desc->iommu_msi_page_shift;
> +
> +		msg->address_hi = upper_32_bits(msi_iova);
> +		msg->address_lo = lower_32_bits(msi_iova) |
> +				  (msg->address_lo &
> +				   ((1 << desc->iommu_msi_page_shift) - 1));
> +	}
>  #endif
> +}
>  
>  int msi_domain_insert_msi_desc(struct device *dev, unsigned int domid,
>  			       struct msi_desc *init_desc);
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 2a9fa0c8cc00..bf91e014d179 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1815,7 +1815,7 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
>  
>  	if (!domain || !domain->iova_cookie) {
> -		desc->iommu_cookie = NULL;
> +		msi_desc_set_iommu_msi_iova(desc, 0, 0);
>  		return 0;
>  	}
>  
> @@ -1827,33 +1827,13 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  	mutex_lock(&msi_prepare_lock);
>  	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	mutex_unlock(&msi_prepare_lock);
> -
> -	msi_desc_set_iommu_cookie(desc, msi_page);
> -
>  	if (!msi_page)
>  		return -ENOMEM;
> -	return 0;
> -}
>  
> -/**
> - * iommu_dma_compose_msi_msg() - Apply translation to an MSI message
> - * @desc: MSI descriptor prepared by iommu_dma_prepare_msi()
> - * @msg: MSI message containing target physical address
> - */
> -void iommu_dma_compose_msi_msg(struct msi_desc *desc, struct msi_msg *msg)
> -{
> -	struct device *dev = msi_desc_to_dev(desc);
> -	const struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	const struct iommu_dma_msi_page *msi_page;
> -
> -	msi_page = msi_desc_get_iommu_cookie(desc);
> -
> -	if (!domain || !domain->iova_cookie || WARN_ON(!msi_page))
> -		return;
> -
> -	msg->address_hi = upper_32_bits(msi_page->iova);
> -	msg->address_lo &= cookie_msi_granule(domain->iova_cookie) - 1;
> -	msg->address_lo += lower_32_bits(msi_page->iova);
> +	msi_desc_set_iommu_msi_iova(
> +		desc, msi_page->iova,
> +		ilog2(cookie_msi_granule(domain->iova_cookie)));
> +	return 0;
>  }
>  
>  static int iommu_dma_init(void)

