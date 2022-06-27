Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C324F2C9E
	for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 11:50:46 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id x1-20020a17090abc8100b001ec7f8a51f5so12230148pjr.0
        for <iommu@lists.linux.dev>; Mon, 27 Jun 2022 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=invPJVG0Zi9GIegGywieHIr+1+qNTfD0fpIiT0T0TJY=;
        b=EnQ3BVtZdiJHxixZGRx2668myA1Mxh8MQs/zNoCQ9HcSR0j586iRu9SNsO6dJuuocF
         b4MKKdbdIw+yBIwbyAwg176XD8gJFtxveF9Rm00HQfiLKsgiOXS37V3Us6+8lQjwGeum
         f3m2Oo7paOMHSCndKg4SuWDMCpUbBrRrmbKiufTTx/VnibR87u8TyaplirRr+te9UToF
         GqBJ9tvGAaBGjZ0UlfetFtk1z+jzKoVZNy0IQapVewRWXKIZM7oFnapDSO69G8yZZZ62
         rb+1l5Mw71Y2L5ym26wIN+9C1llMWTr7arYiT04keOcpqlf0PNkvWD7JsRG473916yl0
         fFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=invPJVG0Zi9GIegGywieHIr+1+qNTfD0fpIiT0T0TJY=;
        b=nEIiOqSgSx0iKr+wZtlB2kLeEx2sKsSH3YgeA8PKhk2PJ1P2irJSO26fxYzn67UTZ5
         Pz3ClrMylon6VHqzHDIAulcedxe/FBYgVX9D+xv/KHhuSzLK7tIyhwSjmCNxZgLdGBp9
         db4amzesGEzc2ZvP/84lnN/gfIgCduVShFsjnxGvmiLCwM+qJMzvNNtgDCf+lIyTJVwF
         fDzsf9+Z3Q06l11Rt6tLdgzRx7/cZBIjtwDZbqrukYEutXTSHp2HDwbYN7UerCA+j5TI
         a4YaC5wPDS6rzvgI2E1RCT5axAx9So7+QebzeIotKWYka61aHizZktTq97T0DR9gR3m4
         Ra2w==
X-Gm-Message-State: AJIora8Yh+z+uPkIzblHVyPYtPtfrjnI42bA8u91EvU/ZnRS107YvpF2
	lFqrPXo2l7JXZtoVsU6e2fHQYQ==
X-Google-Smtp-Source: AGRyM1sGN8A+qrpRYCQMMBpa5Cz99TnCu+ClMzfaatzPThPzWDm1zzPuJ/tGmm4dBwFwR7mB9apK5A==
X-Received: by 2002:a17:90b:c82:b0:1ec:b80a:676 with SMTP id o2-20020a17090b0c8200b001ecb80a0676mr20757435pjz.45.1656330646160;
        Mon, 27 Jun 2022 04:50:46 -0700 (PDT)
Received: from [10.51.0.6] ([199.101.192.62])
        by smtp.gmail.com with ESMTPSA id d85-20020a621d58000000b0052549cc3416sm7312546pfd.175.2022.06.27.04.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 04:50:45 -0700 (PDT)
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Jacob jun Pan <jacob.jun.pan@intel.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Date: Mon, 27 Jun 2022 19:50:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20220621144353.17547-7-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Message-ID: <20220627115038.Vv_q-3PjMbWZ55r7dk0eVN_hbCiH6MyIiy4yFSRU338@z>



On 2022/6/21 下午10:43, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Have tested the series on aarch64.

Thanks

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  6 ++
>   .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 69 +++++++++++++++++++
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 +
>   3 files changed, 78 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d2ba86470c42..96399dd3a67a 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -758,6 +758,7 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
>   void arm_smmu_sva_unbind(struct iommu_sva *handle);
>   u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>   void arm_smmu_sva_notifier_synchronize(void);
> +struct iommu_domain *arm_smmu_sva_domain_alloc(void);
>   #else /* CONFIG_ARM_SMMU_V3_SVA */
>   static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>   {
> @@ -803,5 +804,10 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>   }
>   
>   static inline void arm_smmu_sva_notifier_synchronize(void) {}
> +
> +static inline struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_ARM_SMMU_V3_SVA */
>   #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index f155d406c5d5..fc4555dac5b4 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -549,3 +549,72 @@ void arm_smmu_sva_notifier_synchronize(void)
>   	 */
>   	mmu_notifier_synchronize();
>   }
> +
> +static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
> +				      struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct mm_struct *mm;
> +	struct iommu_sva *handle;
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA)
> +		return -EINVAL;
> +
> +	mm = domain->mm;
> +	if (WARN_ON(!mm))
> +		return -ENODEV;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __arm_smmu_sva_bind(dev, mm);
> +	if (IS_ERR(handle))
> +		ret = PTR_ERR(handle);
> +	mutex_unlock(&sva_lock);
> +
> +	return ret;
> +}
> +
> +static void arm_smmu_sva_block_dev_pasid(struct iommu_domain *domain,
> +					 struct device *dev, ioasid_t id)
> +{
> +	struct mm_struct *mm = domain->mm;
> +	struct arm_smmu_bond *bond = NULL, *t;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +
> +	mutex_lock(&sva_lock);
> +	list_for_each_entry(t, &master->bonds, list) {
> +		if (t->mm == mm) {
> +			bond = t;
> +			break;
> +		}
> +	}
> +
> +	if (!WARN_ON(!bond) && refcount_dec_and_test(&bond->refs)) {
> +		list_del(&bond->list);
> +		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> +
> +static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> +{
> +	kfree(domain);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,
> +	.block_dev_pasid	= arm_smmu_sva_block_dev_pasid,
> +	.free			= arm_smmu_sva_domain_free,
> +};
> +
> +struct iommu_domain *arm_smmu_sva_domain_alloc(void)
> +{
> +	struct iommu_domain *domain;
> +
> +	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +	if (!domain)
> +		return NULL;
> +	domain->ops = &arm_smmu_sva_domain_ops;
> +
> +	return domain;
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index ae8ec8df47c1..a30b252e2f95 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1999,6 +1999,9 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>   {
>   	struct arm_smmu_domain *smmu_domain;
>   
> +	if (type == IOMMU_DOMAIN_SVA)
> +		return arm_smmu_sva_domain_alloc();
> +
>   	if (type != IOMMU_DOMAIN_UNMANAGED &&
>   	    type != IOMMU_DOMAIN_DMA &&
>   	    type != IOMMU_DOMAIN_DMA_FQ &&

