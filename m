Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971E0C433F5
	for <iommu@archiver.kernel.org>; Mon, 21 Mar 2022 11:31:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 430FF60E9A;
	Mon, 21 Mar 2022 11:31:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPJSURoSMCIe; Mon, 21 Mar 2022 11:31:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D6AEE60BBF;
	Mon, 21 Mar 2022 11:31:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A9323C001A;
	Mon, 21 Mar 2022 11:31:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E550AC000B
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:31:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D2A1F4017A
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:31:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aUE1kVGa3YbT for <iommu@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 11:31:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 720FD40535
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 11:31:46 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id j15so15090051eje.9
 for <iommu@lists.linux-foundation.org>; Mon, 21 Mar 2022 04:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=PQzatZvQ0rnATnfydXXlZrcHERA9v9fqeol3oNRKe0s=;
 b=o6jTaq+guIeRJ1bVk1VLAfnnqbZ52yA+6P9AnEGOtOEqKkkiqb/sch6b14kyOhlCF9
 9CCR1EeOrSziOpa4PX8fDCbsloh+uaPQ2wfOmIfP59VnqWPaM7O8MfZDIhXN8IOn07c9
 8/bwgRBom5WtQhd/qXWBBdib7N0qe7VW9Qb68Xd0Fev9UxWOu7CmqU9f5vbcePQjKOCD
 nRkCw0AWy2n7DDLgMwgv/kSA6Yf97rrtN7oScgWQhCOSVZ8DFJ+k2AxSj57osJk04nu1
 d+uKFhRjycjKHvOKgIVkC/dMpWFvQVHeqyyzBsuySWhPvil1dVzcd8+VY8NS+vrRAw+e
 l9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=PQzatZvQ0rnATnfydXXlZrcHERA9v9fqeol3oNRKe0s=;
 b=pfm3qEQI6no1Xvv5YQqU41Adpk8oTNPovQ94LMd3OnZAVjEentWC69gbYexSxVXvid
 YmUNfZPIa0igT8XdSMVnGzbQp0/w1ZYe4J3r1yLUNAKxahTdY6jiUSRsRArlXV7zPsu1
 AKEtjFrV/iNtKQ2X+tcemDt1ifApk6WfsS1XXpXtHJlWWrC1OXQzQs/oUqEjTLbQ7SVP
 HgLuv9UzPP3w4t4eSL+aTh8vhm59mU3BayXOVwS6UopOZDdMXupMVgvaDU8wa5AgHkvi
 9Qwm31ryQRoI8lfu1gZplWZFTpsVC7BafdI08IZUFQ9MHGHsUKMyu1M5U+xEEddFjh+q
 uFrg==
X-Gm-Message-State: AOAM532j3BoEm7RHaMq+9oDL18gi0Mndc4UCnLGA8re3atxyyoN1Ri8+
 tR/AD6/3a0j0NGG2775Od72Wlw==
X-Google-Smtp-Source: ABdhPJyL9LR1se3eQeUHysrOzRuRAJK4jfY+6A8O1BnJb+gkVSsQ0NGrsR6W/95ufMiuyrJxX0jmKw==
X-Received: by 2002:a17:907:b590:b0:6c1:c061:d945 with SMTP id
 qx16-20020a170907b59000b006c1c061d945mr20083570ejc.768.1647862304429; 
 Mon, 21 Mar 2022 04:31:44 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 z6-20020a056402274600b004194fc1b7casm101822edd.48.2022.03.21.04.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:31:44 -0700 (PDT)
Date: Mon, 21 Mar 2022 11:31:19 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 05/11] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YjhiByacn+WACHCU@myrica>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220320064030.2936936-6-baolu.lu@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 iommu@lists.linux-foundation.org, Jacob jun Pan <jacob.jun.pan@intel.com>,
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

On Sun, Mar 20, 2022 at 02:40:24PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 ++++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 45 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 13 +++++-
>  3 files changed, 71 insertions(+), 1 deletion(-)
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
> index 22ddd05bbdcd..1e114b9dc17f 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -534,3 +534,48 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct iommu_sva *handle;
> +	struct mm_struct *mm = domain->sva_cookie;
> +	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
> +
> +	if (smmu_domain->stage != ARM_SMMU_DOMAIN_S1 ||

This check is for the parent domain, iommu_get_domain_for_dev(dev)

> +	    domain->type != IOMMU_DOMAIN_SVA || !mm)
> +		return -EINVAL;
> +
> +	mutex_lock(&sva_lock);
> +	handle = __arm_smmu_sva_bind(dev, mm);
> +	if (IS_ERR_OR_NULL(handle))
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
> +	struct mm_struct *mm = domain->sva_cookie;
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
> +		iommu_sva_free_pasid(bond->mm);

Can be dropped since iommu.c does PASID allocation (also the one in
__arm_smmu_sva_bind() as a cleanup patch)

> +		kfree(bond);
> +	}
> +	mutex_unlock(&sva_lock);
> +}
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 8e262210b5ad..2e9d3cd30510 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -88,6 +88,8 @@ static struct arm_smmu_option_prop arm_smmu_options[] = {
>  	{ 0, NULL},
>  };
>  
> +static void arm_smmu_domain_free(struct iommu_domain *domain);
> +
>  static void parse_driver_options(struct arm_smmu_device *smmu)
>  {
>  	int i = 0;
> @@ -1995,6 +1997,12 @@ static bool arm_smmu_capable(enum iommu_cap cap)
>  	}
>  }
>  
> +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> +	.attach_dev_pasid	= arm_smmu_sva_attach_dev_pasid,
> +	.detach_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	.free			= arm_smmu_domain_free,
> +};
> +
>  static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  {
>  	struct arm_smmu_domain *smmu_domain;
> @@ -2002,7 +2010,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	if (type != IOMMU_DOMAIN_UNMANAGED &&
>  	    type != IOMMU_DOMAIN_DMA &&
>  	    type != IOMMU_DOMAIN_DMA_FQ &&
> -	    type != IOMMU_DOMAIN_IDENTITY)
> +	    type != IOMMU_DOMAIN_IDENTITY &&
> +	    type != IOMMU_DOMAIN_SVA)
>  		return NULL;

We don't need to allocate an arm_smmu_domain, it likely won't have
anything in common with the SVA domain and it would be much clearer within
the SMMU driver if we use different structs for parent and child domains.
For now we could just return a naked struct iommu_domain. Sanity checks in
arm_smmu_attach_dev() would be good too, a SVA domain can't be attached as
a parent domain.

I this this works otherwise, but will need to test the series to see what
more is needed, when I find some time.

Thanks,
Jean

>  
>  	/*
> @@ -2018,6 +2027,8 @@ static struct iommu_domain *arm_smmu_domain_alloc(unsigned type)
>  	INIT_LIST_HEAD(&smmu_domain->devices);
>  	spin_lock_init(&smmu_domain->devices_lock);
>  	INIT_LIST_HEAD(&smmu_domain->mmu_notifiers);
> +	if (type == IOMMU_DOMAIN_SVA)
> +		smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
>  
>  	return &smmu_domain->domain;
>  }
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
