Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EA76FA1
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 15:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679671712;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kh4apJjF008Ebwd6BpQPfSf9Xv4AqfjyXizFPG3+0WY=;
	b=YrjH2B6BYhFn1fpIj0NPeARfvNJE8d/udsyO7JvHbg9ZlpdEbtTBp1oGR7hWqYCGLahHs4
	9jjmZAw1biNuQrlSov3gNlg8EUfSkvgr+GbKFu1rp5KRJqFnz/9W1caeE0BzTnT6RLAopf
	DyyTDmQnyEtcuj2N2zOON8HA/7cQSx4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-1CN7c6E9PN-XhNHGOyXhcw-1; Fri, 24 Mar 2023 11:28:31 -0400
X-MC-Unique: 1CN7c6E9PN-XhNHGOyXhcw-1
Received: by mail-qv1-f72.google.com with SMTP id g6-20020ad45426000000b005a33510e95aso1171267qvt.16
        for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 08:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679671711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kh4apJjF008Ebwd6BpQPfSf9Xv4AqfjyXizFPG3+0WY=;
        b=MT+eNnnsqYPAeCmaHPNhGyhxU3K4nEB1daSaEMt2wGElC/33IB3v/oWFMR6kKIZie0
         oI/jTVUxXZFzVnb7novrkE+l2Zy08Ph8IGeAcLYf03R6mJv3wMwl0IziDq1KpbDo+Fx9
         FcIPMPNZn/b7SPqpNqeoV7iT1STykL1zeunti1XRbsmqEOFRB/5HAVJYafIYKUf0aONI
         ZB9QEyFtDBV5EdDi2YUfxvjId7zgaLsW+L6yH7f0yg+YHx/iWqhdp2fwCRr/KEZqrv74
         AdO0ijQMIJFhW00WQ3aDiBU00g8Tw+7UJWmGPx+e0nQ5b30HOHW3GOCMVSf7oNpRAGJW
         0/4w==
X-Gm-Message-State: AO0yUKVlZ+kgC0NHla5j6u6T5zlmaZEL9YMJo5GgELFX/8aizdntj+KX
	VsTDRySXwN9xgMH6w7/SOhanQrVnEpb9iuMv+shklt3JQzTjvhkPrsUnqv4eLgUpK94wsKGSW+F
	J9y5Az/qHZ0oA5o8=
X-Received: by 2002:ac8:5b87:0:b0:3b9:bc8c:c214 with SMTP id a7-20020ac85b87000000b003b9bc8cc214mr15962666qta.31.1679671710903;
        Fri, 24 Mar 2023 08:28:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set/aZhTIagXr86hQGcOM0/obUyvWdZrsHbQkbzWyxnPA96NfrvjCypZ6MbXRS7MTV48Tt/mrmg==
X-Received: by 2002:ac8:5b87:0:b0:3b9:bc8c:c214 with SMTP id a7-20020ac85b87000000b003b9bc8cc214mr15962640qta.31.1679671710626;
        Fri, 24 Mar 2023 08:28:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874? ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
        by smtp.gmail.com with ESMTPSA id 11-20020a37060b000000b0071d0f1d01easm8220902qkg.57.2023.03.24.08.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 08:28:30 -0700 (PDT)
Message-ID: <857004e1-6ab1-f825-7796-9c0b557e7cc8@redhat.com>
Date: Fri, 24 Mar 2023 16:28:26 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Reply-To: eric.auger@redhat.com
Subject: Re: [PATCH v1 11/14] iommu/arm-smmu-v3: Add
 arm_smmu_domain_alloc_user
To: Nicolin Chen <nicolinc@nvidia.com>, jgg@nvidia.com, robin.murphy@arm.com,
 will@kernel.org
Cc: kevin.tian@intel.com, baolu.lu@linux.intel.com, joro@8bytes.org,
 shameerali.kolothum.thodi@huawei.com, jean-philippe@linaro.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <cover.1678348754.git.nicolinc@nvidia.com>
 <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <7d26e897780bdc009b11bc0c0ddc7b755a769b24.1678348754.git.nicolinc@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Nicolin,

On 3/9/23 11:53, Nicolin Chen wrote:
> The arm_smmu_domain_alloc_user callback function is used for userspace to
> allocate iommu_domains, such as standalone stage-1 domain, nested stage-1
> domain, and nested stage-2 domain. The input user_data is in the type of
> struct iommu_hwpt_arm_smmuv3 that contains the configurations of a nested
> stage-1 or a nested stage-2 iommu_domain. A NULL user_data will just opt
> in a standalone stage-1 domain allocation.
>
> Add a constitutive function __arm_smmu_domain_alloc to support that.
>
> Since ops->domain_alloc_user has a valid dev pointer, the master pointer
> is available when calling __arm_smmu_domain_alloc() in this case, meaning
> that arm_smmu_domain_finalise() can be done at the allocation stage. This
> allows IOMMUFD to initialize the hw_pagetable for the domain.
>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 95 ++++++++++++++-------
>  1 file changed, 65 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 2d29f7320570..5ff74edfbd68 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2053,36 +2053,6 @@ static void *arm_smmu_hw_info(struct device *dev, u32 *length)
>  	return info;
>  }
>  
> -static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> -{
> -	struct arm_smmu_domain *smmu_domain;
> -
> -	if (type == IOMMU_DOMAIN_SVA)
> -		return arm_smmu_sva_domain_alloc();
> -
> -	if (type != IOMMU_DOMAIN_UNMANAGED &&
> -	    type != IOMMU_DOMAIN_DMA &&
> -	    type != IOMMU_DOMAIN_DMA_FQ &&
> -	    type != IOMMU_DOMAIN_IDENTITY)
> -		return NULL;
> -
> -	/*
> -	 * Allocate the domain and initialise some of its data structures.
> -	 * We can't really do anything meaningful until we've added a
> -	 * master.
> -	 */
> -	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> -	if (!smmu_domain)
> -		return NULL;
> -
> -	mutex_init(&smmu_domain->init_mutex);
> -	INIT_LIST_HEAD(&smmu_domain->devices);
> -	spin_lock_init(&smmu_domain->devices_lock);
> -	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> -
> -	return &smmu_domain->domain;
> -}
> -
>  static struct iommu_domain *arm_smmu_get_unmanaged_domain(struct device *dev)
>  {
>  	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> @@ -2893,10 +2863,75 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
>  	arm_smmu_sva_remove_dev_pasid(domain, dev, pasid);
>  }
>  
> +static struct iommu_domain *
> +__arm_smmu_domain_alloc(unsigned type,
> +			struct arm_smmu_domain *s2,
> +			struct arm_smmu_master *master,
> +			const struct iommu_hwpt_arm_smmuv3 *user_cfg)
> +{
> +	struct arm_smmu_domain *smmu_domain;
> +	struct iommu_domain *domain;
> +	int ret = 0;
> +
> +	if (type == IOMMU_DOMAIN_SVA)
> +		return arm_smmu_sva_domain_alloc();
> +
> +	if (type != IOMMU_DOMAIN_UNMANAGED &&
> +	    type != IOMMU_DOMAIN_DMA &&
> +	    type != IOMMU_DOMAIN_DMA_FQ &&
> +	    type != IOMMU_DOMAIN_IDENTITY)
> +		return NULL;
> +
> +	/*
> +	 * Allocate the domain and initialise some of its data structures.
> +	 * We can't really finalise the domain unless a master is given.
> +	 */
> +	smmu_domain = kzalloc(sizeof(*smmu_domain), GFP_KERNEL);
> +	if (!smmu_domain)
> +		return NULL;
> +	domain = &smmu_domain->domain;
> +
> +	domain->type = type;
> +	domain->ops = arm_smmu_ops.default_domain_ops;
Compared to the original code, that's something new. Please can you
explain why this is added in this patch?
> +
> +	mutex_init(&smmu_domain->init_mutex);
> +	INIT_LIST_HEAD(&smmu_domain->devices);
> +	spin_lock_init(&smmu_domain->devices_lock);
> +	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> +
> +	if (master) {
> +		smmu_domain->smmu = master->smmu;
> +		ret = arm_smmu_domain_finalise(domain, master, user_cfg);
> +		if (ret) {
> +			kfree(smmu_domain);
> +			return NULL;
> +		}
> +	}
> +
> +	return domain;
> +}
> +
> +static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
> +{
> +	return __arm_smmu_domain_alloc(type, NULL, NULL, NULL);
> +}
> +
> +static struct iommu_domain *
> +arm_smmu_domain_alloc_user(struct device *dev, struct iommu_domain *parent,
> +			   const void *user_data)
> +{
> +	const struct iommu_hwpt_arm_smmuv3 *user_cfg = user_data;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	unsigned type = IOMMU_DOMAIN_UNMANAGED;
is there any guarantee that master is non null? Don't we want to check?
> +
> +	return __arm_smmu_domain_alloc(type, NULL, master, user_cfg);
> +}
> +
>  static struct iommu_ops arm_smmu_ops = {
>  	.capable		= arm_smmu_capable,
>  	.hw_info		= arm_smmu_hw_info,
>  	.domain_alloc		= arm_smmu_domain_alloc,
> +	.domain_alloc_user	= arm_smmu_domain_alloc_user,
>  	.get_unmanaged_domain	= arm_smmu_get_unmanaged_domain,
>  	.probe_device		= arm_smmu_probe_device,
>  	.release_device		= arm_smmu_release_device,
Thanks

Eric

