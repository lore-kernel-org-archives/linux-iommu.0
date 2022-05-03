Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26090C433F5
	for <iommu@archiver.kernel.org>; Tue,  3 May 2022 18:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF98D825CA;
	Tue,  3 May 2022 18:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uqnZp5IZhq08; Tue,  3 May 2022 18:12:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8A80C81490;
	Tue,  3 May 2022 18:12:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B7AAC0032;
	Tue,  3 May 2022 18:12:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 29B5EC002D
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:12:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EF528149C
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:12:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pkTWmo39UjZI for <iommu@lists.linux-foundation.org>;
 Tue,  3 May 2022 18:12:51 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 433B581490
 for <iommu@lists.linux-foundation.org>; Tue,  3 May 2022 18:12:51 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id t6so24470615wra.4
 for <iommu@lists.linux-foundation.org>; Tue, 03 May 2022 11:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sYczTiism3AvB5i2HPPMCukvA88W4uV6GroVBqCVwd8=;
 b=l1P52yFfIlCoJeVp9x7e3toeQStCoXmBw8qmitK1qkEHjDq/GideoOhtsl7XjHWqox
 p/LXp78fFQ5ap6IfIz0F8+1StxUF1fGrGZpwFKLVhK2W+KtD3JO7vOw+t19qtxpN2JYr
 CY17h1JvKUie53gJ4URsGi3S5SNVchx0ncmR5aROBk/F1FZuaIXmGlhoMV6jyaRFJajy
 LPUMDsknIqrd1Fh7ZZY16nTQGF+Zk40EwyZoZU0iwYNTqkDePBL2OgmFA+A6RCwe+M7w
 gnzSjS285qeixa7sJPezOz8QEwSRdasVdV4DY50bpkdVfs7cxuJN0HR1iMoFIMa+a/LC
 B9mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sYczTiism3AvB5i2HPPMCukvA88W4uV6GroVBqCVwd8=;
 b=JEDkp3G6S8vRo7hE7gDAC1vYy0c5p5q/OOXcR4qbp4n+DZgvj38w1qaq1rBvFXiqjk
 g3YmeUKDzT6UvIZg+3rZo/sx/JKfZ0F+HTx5jFSo8Vqkv2wSdiDKc+TnR/a2vs+Bo/AX
 Buo+ySwuWangnrMIM1/qJ6yMY7kS/pck/ahJ7bSXP3DxXuWWHPeu7dAOv/pg5FTI4TaI
 o81pDAT+7REidqrjlUyJ+jN3A7QXgcrggatzpgmxvmsrbJoyYs5XqKu00LQYg5YRZlOE
 2TAAEaxSLhcRo1zGRqvcKbWnVgkabOGQtwTkKupQtkBa4yrrK8mANOykkZLM92KLn0m6
 yxvw==
X-Gm-Message-State: AOAM5333BSzklEYm4BmS/SOeBiGPENtowYNznVa9l7pmE2VjYCOr6Pdw
 MyL6ipTxaAfXCmApJ9fcQeYcNA==
X-Google-Smtp-Source: ABdhPJzZrRo9lI/2sW0emG53DTRhp5HvrUFRkNLyUitvmuN4N7njcGivXM25nQUesOJYzJbyXRxOnQ==
X-Received: by 2002:a05:6000:1a87:b0:20c:687f:6d10 with SMTP id
 f7-20020a0560001a8700b0020c687f6d10mr6421133wry.574.1651601569296; 
 Tue, 03 May 2022 11:12:49 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 i128-20020a1c3b86000000b003942a244ebfsm2217051wma.4.2022.05.03.11.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 May 2022 11:12:48 -0700 (PDT)
Date: Tue, 3 May 2022 19:12:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v5 07/12] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YnFwiLkvYtLn43Qv@myrica>
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-8-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220502014842.991097-8-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, May 02, 2022 at 09:48:37AM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 42 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 21 ++++++++++
>  3 files changed, 77 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index cd48590ada30..7631c00fdcbd 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -759,6 +759,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm,
>  void arm_smmu_sva_unbind(struct iommu_sva *handle);
>  u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle);
>  void arm_smmu_sva_notifier_synchronize(void);
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id);
> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t id);
>  #else /* CONFIG_ARM_SMMU_V3_SVA */
>  static inline bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>  {
> @@ -804,5 +808,15 @@ static inline u32 arm_smmu_sva_get_pasid(struct iommu_sva *handle)
>  }
>  
>  static inline void arm_smmu_sva_notifier_synchronize(void) {}
> +
> +static inline int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +						struct device *dev, ioasid_t id)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +						 struct device *dev,
> +						 ioasid_t id) {}
>  #endif /* CONFIG_ARM_SMMU_V3_SVA */
>  #endif /* _ARM_SMMU_V3_H */
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index c623dae1e115..3b843cd3ed67 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -541,3 +541,45 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct iommu_sva *handle;
> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA || !mm)

We wouldn't get that far with a non-SVA domain since iommu_sva_domain_mm()
would dereference a NULL pointer. Could you move it after the domain->type
check, and maybe add a WARN_ON()?  It could help catch issues in future
API changes.

> +		return -EINVAL;
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
> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t id)
> +{
> +	struct arm_smmu_bond *bond = NULL, *t;
> +	struct mm_struct *mm = iommu_sva_domain_mm(domain);
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
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index afc63fce6107..bd80de0bad98 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1995,10 +1995,31 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	}
>  }
>  
> +static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
> +{
> +	kfree(domain);
> +}
> +
> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	.free			= arm_smmu_sva_domain_free,
> +};
> +
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
>  
> +	if (type == IOMMU_DOMAIN_SVA) {
> +		struct iommu_domain *domain;
> +
> +		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> +		if (domain)
> +			domain->ops = &arm_smmu_sva_domain_ops;
> +
> +		return domain;
> +	}
> +

I'd prefer moving all of this to arm-smmu-v3-sva.c and just call
arm_smmu_sva_domain_alloc() here

Otherwise the patch looks fine. I'll rework the driver when I find some
time, because we can now remove arm_smmu_bond and move smmu_mn to the SVA
domain, maybe also remove sva_lock but I haven't thought it through.

Thanks,
Jean

>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
