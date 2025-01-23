Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F134D14A4E1
	for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737652258; cv=none; b=DOKUE5X0gSaoGeu6o/phqHZZfXImkUZZikgPPw8IQYcLs3wZDLoSA49lQMsIcQBLicHJ9/aYEdu+CX3uE0SxT4y+4l3gXn+r9uEXMgW9/QGRQbUoj0zTo7sN7fcAXrNS15RTbyW33VkAegTXMzTcf7wxwVdgZs54/voKuLqb2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737652258; c=relaxed/simple;
	bh=T8q34VTWnC53A/omtKXw33TuIrilLgKAMYPU65cm/Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qSa0r4ahnGI3VW0K8mGW3++r2xLiG6pbKHQjCI4o54uhN4g7WITwvTqQZJ6ljzTc4f/bGoM7emi8UMg0Z0IdaRttpZpUSd54GgIWagM+Ljc+Rb/4Yx9Y4tl56vKQGu3ub0IafBvfSdoGqn88gTHNPuK8qKE7E5knGLZrdViGzFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KYxrY/Pt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KYxrY/Pt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737652254;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jAh/e6F0HEaFnHy5OVzmfXhKo/WXlBkiKIGsXte00qk=;
	b=KYxrY/PtMZZwQOhse0FuEG9+7aLJpZGHrtBvZj8Y+aLzMuwBw6jKnltalzBJB4nFMpyIMx
	Reg+Oy5M46/Ey+7t6N+sQRNE1Lo+fbNSnJ02hJaP09Vh/wI+/6VEzCpPAsgL+d8bfJyIoT
	6Dl6KG1BcajS/rwiQ+S7uliqQHE8aiU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-IH5kc8e0Nzas08rlPkF8Lw-1; Thu, 23 Jan 2025 12:10:53 -0500
X-MC-Unique: IH5kc8e0Nzas08rlPkF8Lw-1
X-Mimecast-MFC-AGG-ID: IH5kc8e0Nzas08rlPkF8Lw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4361ac8b25fso6783385e9.2
        for <iommu@lists.linux.dev>; Thu, 23 Jan 2025 09:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737652252; x=1738257052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAh/e6F0HEaFnHy5OVzmfXhKo/WXlBkiKIGsXte00qk=;
        b=tQbnVW4T7O7FFGVez1h8K1+feIxLhYED+t+IHUmhD98WTjbp4ZDW3Oi669Tiy3uyl1
         4zlJ+RXRGfsvHTHOXfS9tUXpAELZyKBXMqyVggoQS2+nrqEdatteJIJVTEbS6bVuVu60
         PYLzL9Welk5TLbk0vXiHKWAd0EXIF0ZUeqXzvAQqnS51TBKnfvX59RquV0srA1tf2BGd
         t6sbE3OHI1dZavmmyrjVsi1TPlfd/vISjiS+Ujz9f5QC+dGEW5IzWzP5+jjAj+bK/6Ue
         ELefgCHyKOnyqAaJU4bNK5SNEDEqseA10HeOQo0NH3BOX1WVOlMmApIHycaLrH+rjFO7
         uKlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB5duie+j2YWDOXUKmgzguE6x70fScFK4DgbU8pYuCG7t4JN/wD4pE1vTU4RxM01GEDpsEZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YycyXZ0d9H9CBvdrbcCJ1PasWUCBlGooFqrhJcaC8r3tc5+kQJB
	e0RoRIdrzf/ja4mfUG4MaT8abaGPYT2cnZl/HXoeXErYQ90OdH7cNb2JxNscFAhlbsyMV2DmFj2
	mEKzHiZiHR1MnnMy2BsxfUZtxiNESgVHSYYGpMpWCfVjIzATgUgXg
X-Gm-Gg: ASbGnct/aZFk2l2zIIzeF3M9iBG9RLkMpayf6CsQm156t46l2mSu4EK/4b3vl9DK0ML
	QwL4pWTzrdjlGGT91Tj3u/zg1x3446fqye2uoebvvsy/+ZKodMsFswF/WgfBlBFNaZY71pxqCdJ
	RQ3HmfF705L4KQWbd1lFylgXCpXSyl+zXENW4DhJ4g4jDI8EFOR5nUnjZO97A+kBeoo1O6258k6
	VYTemG61i/sv63Ao89D0oCGISATYDx1BezdF94NOO1twjSOLQQikTsQa74YDtgRf6MZnhigf8va
	jT5dIaglagJHYvIMQLdTtAJXwm+nn8yGbFrncKolJw==
X-Received: by 2002:a05:600c:3d96:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-43891439dfdmr245029685e9.23.1737652251745;
        Thu, 23 Jan 2025 09:10:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkHdqQ1Du/TgX49VGOUPaX03Xnk0FckQu07hyXzCGV6GJ69vec6Iv7VJ8KrVMowrhApHUZ3w==
X-Received: by 2002:a05:600c:3d96:b0:434:9dfe:20e6 with SMTP id 5b1f17b1804b1-43891439dfdmr245029225e9.23.1737652251235;
        Thu, 23 Jan 2025 09:10:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438b31d9a39sm67975795e9.31.2025.01.23.09.10.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 09:10:50 -0800 (PST)
Message-ID: <787fd89b-fbc0-4fd5-a1af-63dfddf13435@redhat.com>
Date: Thu, 23 Jan 2025 18:10:47 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH RFCv2 03/13] iommu: Make iommu_dma_prepare_msi() into a
 generic operation
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
 <9914f9e6b32d49f74ace2200fd50583def9f15f6.1736550979.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <9914f9e6b32d49f74ace2200fd50583def9f15f6.1736550979.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: S-1bDRy7caNdT-vyqDLGMaLEdTlN9r7BBnyOgKXq6jM_1737652252
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,


On 1/11/25 4:32 AM, Nicolin Chen wrote:
> From: Jason Gunthorpe <jgg@nvidia.com>
>
> SW_MSI supports IOMMU to translate an MSI message before the MSI message
> is delivered to the interrupt controller. On such systems the iommu_domain
> must have a translation for the MSI message for interrupts to work.
>
> The IRQ subsystem will call into IOMMU to request that a physical page be
> setup to receive MSI message, and the IOMMU then sets an IOVA that maps to
> that physical page. Ultimately the IOVA is programmed into the device via
> the msi_msg.
>
> Generalize this to allow the iommu_domain owner to provide its own
> implementation of this mapping. Add a function pointer to struct
> iommu_domain to allow the domain owner to provide an implementation.
>
> Have dma-iommu supply its implementation for IOMMU_DOMAIN_DMA types during
> the iommu_get_dma_cookie() path. For IOMMU_DOMAIN_UNMANAGED types used by
> VFIO (and iommufd for now), have the same iommu_dma_sw_msi set as well in
> the iommu_get_msi_cookie() path.
>
> Hold the group mutex while in iommu_dma_prepare_msi() to ensure the domain
> doesn't change or become freed while running. Races with IRQ operations
> from VFIO and domain changes from iommufd are possible here.
this was my question in previous comments
>
> Rreplace the msi_prepare_lock with a lockdep assertion for the group mutex
Replace
> as documentation. For the dma_iommu.c each iommu_domain unique to a
is?
> group.
>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> [nicolinc: move iommu_domain_set_sw_msi() from iommu_dma_init_domain() to
>  iommu_dma_init_domain(); add in iommu_put_dma_cookie() an sw_msi test]
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  include/linux/iommu.h     | 44 ++++++++++++++++++++++++++-------------
>  drivers/iommu/dma-iommu.c | 33 +++++++++++++----------------
>  drivers/iommu/iommu.c     | 29 ++++++++++++++++++++++++++
>  3 files changed, 73 insertions(+), 33 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3a4215966c1b..423fdfa6b3bb 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,8 @@ struct iommu_dma_cookie;
>  struct iommu_fault_param;
>  struct iommufd_ctx;
>  struct iommufd_viommu;
> +struct msi_desc;
> +struct msi_msg;
>  
>  #define IOMMU_FAULT_PERM_READ	(1 << 0) /* read */
>  #define IOMMU_FAULT_PERM_WRITE	(1 << 1) /* write */
> @@ -216,6 +218,12 @@ struct iommu_domain {
>  	struct iommu_domain_geometry geometry;
>  	struct iommu_dma_cookie *iova_cookie;
>  	int (*iopf_handler)(struct iopf_group *group);
> +
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> +		      phys_addr_t msi_addr);
> +#endif
> +
>  	void *fault_data;
>  	union {
>  		struct {
> @@ -234,6 +242,16 @@ struct iommu_domain {
>  	};
>  };
>  
> +static inline void iommu_domain_set_sw_msi(
> +	struct iommu_domain *domain,
> +	int (*sw_msi)(struct iommu_domain *domain, struct msi_desc *desc,
> +		      phys_addr_t msi_addr))
> +{
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +	domain->sw_msi = sw_msi;
> +#endif
> +}
> +
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
>  {
>  	return domain->type & __IOMMU_DOMAIN_DMA_API;
> @@ -1475,6 +1493,18 @@ static inline ioasid_t iommu_alloc_global_pasid(struct device *dev)
>  static inline void iommu_free_global_pasid(ioasid_t pasid) {}
>  #endif /* CONFIG_IOMMU_API */
>  
> +#ifdef CONFIG_IRQ_MSI_IOMMU
> +#ifdef CONFIG_IOMMU_API
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> +#else
> +static inline int iommu_dma_prepare_msi(struct msi_desc *desc,
> +					phys_addr_t msi_addr)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_IOMMU_API */
> +#endif /* CONFIG_IRQ_MSI_IOMMU */
> +
>  #if IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_IOMMU_API)
>  void iommu_group_mutex_assert(struct device *dev);
>  #else
> @@ -1508,26 +1538,12 @@ static inline void iommu_debugfs_setup(void) {}
>  #endif
>  
>  #ifdef CONFIG_IOMMU_DMA
> -#include <linux/msi.h>
> -
>  int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base);
> -
> -int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr);
> -
>  #else /* CONFIG_IOMMU_DMA */
> -
> -struct msi_desc;
> -struct msi_msg;
> -
>  static inline int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>  {
>  	return -ENODEV;
>  }
> -
> -static inline int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> -{
> -	return 0;
> -}
>  #endif	/* CONFIG_IOMMU_DMA */
>  
>  /*
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index bf91e014d179..3b58244e6344 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -24,6 +24,7 @@
>  #include <linux/memremap.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
> +#include <linux/msi.h>
>  #include <linux/of_iommu.h>
>  #include <linux/pci.h>
>  #include <linux/scatterlist.h>
> @@ -102,6 +103,9 @@ static int __init iommu_dma_forcedac_setup(char *str)
>  }
>  early_param("iommu.forcedac", iommu_dma_forcedac_setup);
>  
> +static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +			    phys_addr_t msi_addr);
> +
>  /* Number of entries per flush queue */
>  #define IOVA_DEFAULT_FQ_SIZE	256
>  #define IOVA_SINGLE_FQ_SIZE	32768
> @@ -398,6 +402,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  		return -ENOMEM;
>  
>  	mutex_init(&domain->iova_cookie->mutex);
> +	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>  	return 0;
>  }
>  
> @@ -429,6 +434,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
>  
>  	cookie->msi_iova = base;
>  	domain->iova_cookie = cookie;
> +	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
>  	return 0;
>  }
>  EXPORT_SYMBOL(iommu_get_msi_cookie);
> @@ -443,6 +449,9 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
>  	struct iommu_dma_cookie *cookie = domain->iova_cookie;
>  	struct iommu_dma_msi_page *msi, *tmp;
>  
> +	if (domain->sw_msi != iommu_dma_sw_msi)
> +		return;
> +
I don't get the above check. The comment says this is also called for a
cookie prepared with iommu_get_dma_cookie(). Don't you need to do some
cleanup for this latter?
>  	if (!cookie)
>  		return;
>  
> @@ -1800,33 +1809,19 @@ static struct iommu_dma_msi_page *iommu_dma_get_msi_page(struct device *dev,
>  	return NULL;
>  }
>  
> -/**
> - * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
> - * @desc: MSI descriptor, will store the MSI page
> - * @msi_addr: MSI target address to be mapped
> - *
> - * Return: 0 on success or negative error code if the mapping failed.
> - */
> -int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> +static int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
> +			    phys_addr_t msi_addr)
>  {
>  	struct device *dev = msi_desc_to_dev(desc);
> -	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> -	struct iommu_dma_msi_page *msi_page;
> -	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
> +	const struct iommu_dma_msi_page *msi_page;
>  
> -	if (!domain || !domain->iova_cookie) {
> +	if (!domain->iova_cookie) {
>  		msi_desc_set_iommu_msi_iova(desc, 0, 0);
>  		return 0;
>  	}
>  
> -	/*
> -	 * In fact the whole prepare operation should already be serialised by
> -	 * irq_domain_mutex further up the callchain, but that's pretty subtle
> -	 * on its own, so consider this locking as failsafe documentation...
> -	 */
> -	mutex_lock(&msi_prepare_lock);
> +	iommu_group_mutex_assert(dev);
>  	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
> -	mutex_unlock(&msi_prepare_lock);
>  	if (!msi_page)
>  		return -ENOMEM;
>  
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 599030e1e890..fbbbcdba8a4f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3587,3 +3587,32 @@ int iommu_replace_group_handle(struct iommu_group *group,
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(iommu_replace_group_handle, "IOMMUFD_INTERNAL");
> +
> +#if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
> +/**
> + * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
> + * @desc: MSI descriptor, will store the MSI page
> + * @msi_addr: MSI target address to be mapped
> + *
> + * The implementation of sw_msi() should take msi_addr and map it to
> + * an IOVA in the domain and call msi_desc_set_iommu_msi_iova() with the
> + * mapping information.
> + *
> + * Return: 0 on success or negative error code if the mapping failed.
> + */
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
> +{
> +	struct device *dev = msi_desc_to_dev(desc);
> +	struct iommu_group *group = dev->iommu_group;
> +	int ret = 0;
> +
> +	if (!group)
> +		return 0;
> +
> +	mutex_lock(&group->mutex);
> +	if (group->domain && group->domain->sw_msi)
> +		ret = group->domain->sw_msi(group->domain, desc, msi_addr);
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +#endif /* CONFIG_IRQ_MSI_IOMMU */
Thanks

Eric

