Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C71DC433EF
	for <iommu@archiver.kernel.org>; Thu, 19 May 2022 16:37:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D037F41D27;
	Thu, 19 May 2022 16:37:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VPHM8LpSpX5D; Thu, 19 May 2022 16:37:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2D22A41D24;
	Thu, 19 May 2022 16:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01BEAC0039;
	Thu, 19 May 2022 16:37:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB4B0C002D
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:37:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9F9783FA1
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:37:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lt1Z3SvU59Ny for <iommu@lists.linux-foundation.org>;
 Thu, 19 May 2022 16:37:55 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ED43083FA0
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 16:37:54 +0000 (UTC)
Received: by mail-wr1-x42e.google.com with SMTP id e28so7392668wra.10
 for <iommu@lists.linux-foundation.org>; Thu, 19 May 2022 09:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=FEdVgqo8LuBqkPaQiJ7UaThEjH5OciLn+zJb0Z2rPec=;
 b=wVQQ3DB3c+BD0bcw7D2QBZ66EAV+RtMMhfgoSV1qYu6ejuYsQieJ+t3XSlnQCOGSBQ
 SFDG/MzLIRsjLzCM7RTz3UK8zaOuKBErWKF8jj6WitlEEWOZ0ZpGs+7Cv/57InvZnVzZ
 6Wy7jAdJ6tRPjCSmt9Km41gF5rpn1qXGNcZTfIStx3vgn69FawRavUSmIHZT3YAjT//p
 1KjN5IhkNkj/gP/Kkc7FmvDQSFF5ic/mW7CaKwt8VszpmC8FWBccVNRMH+ZKv9Sbs3WD
 va1C0kITnyDKBLo6uGNFcc1JVQnuzpbwYp2Ee8/SvCrxRHuMdghTG3p80AUqNzH55zFl
 AtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FEdVgqo8LuBqkPaQiJ7UaThEjH5OciLn+zJb0Z2rPec=;
 b=cB2fsJLJgenuQdFJE9G1SLmsRcyCxEOuGGYMlyazBXGUxRIv/QjbeVmIkGA3B8BfnL
 +7yx/8b6AM4lkJD60Cr3fZqtYeMuiP9cYmsrmeSHYvofRoYyFlDZ8M1pOBE/GJ6J1QKc
 6I6X/ae77sg/VO0uQoxieATaVWUTBFDVY38B74fGr0PoawRwMWs3/a379vTpO31+UC7t
 SxnNlZQ+ZtVmUrXIF+v8o7+ZVeX5sDwyc5LYPWYNgQOzlX3yW1Wnz7pLMYLBEtdPbzW2
 Z/92hgGvEkl5ouc9jZNpkPP3P/zprBqsP0++vO454ALFmy4whHpKyiHqlcc2Py1uI5Vy
 2kpQ==
X-Gm-Message-State: AOAM533S7qkVQcB0c2aui4aRHM5UEfDWqblgv4i/a1v4ZH16O9S12l5P
 h0yx+6NlP8xSOPMOSXSBvhb16Q==
X-Google-Smtp-Source: ABdhPJzFnceQn5e5Wzw4TmInSFRcAyP5hGwf5JsgXFD4NtjmPGuIub/SlWG/T9DFeKcXM7WqMukowg==
X-Received: by 2002:a5d:4f0c:0:b0:20e:5906:713d with SMTP id
 c12-20020a5d4f0c000000b0020e5906713dmr4717226wru.634.1652978273198; 
 Thu, 19 May 2022 09:37:53 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 bg30-20020a05600c3c9e00b003942a244f39sm38873wmb.18.2022.05.19.09.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 May 2022 09:37:52 -0700 (PDT)
Date: Thu, 19 May 2022 17:37:28 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 05/10] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YoZySINkH/MTudFA@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-6-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220519072047.2996983-6-baolu.lu@linux.intel.com>
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

On Thu, May 19, 2022 at 03:20:42PM +0800, Lu Baolu wrote:
> Add support for domain ops callbacks for an SVA domain.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

(I'll try to take some time next cycle to clean up the driver following
this change)

> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  4 ++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 46 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  6 +++
>  3 files changed, 56 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> index d2ba86470c42..ec77f6a51ff9 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
> @@ -758,6 +758,10 @@ struct iommu_sva *arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm);
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
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index f155d406c5d5..6969974ca89e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -549,3 +549,49 @@ void arm_smmu_sva_notifier_synchronize(void)
>  	 */
>  	mmu_notifier_synchronize();
>  }
> +
> +int arm_smmu_sva_attach_dev_pasid(struct iommu_domain *domain,
> +				  struct device *dev, ioasid_t id)
> +{
> +	int ret = 0;
> +	struct mm_struct *mm;
> +	struct iommu_sva *handle;
> +
> +	if (domain->type != IOMMU_DOMAIN_SVA)
> +		return -EINVAL;
> +
> +	mm = domain_to_mm(domain);
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
> +void arm_smmu_sva_detach_dev_pasid(struct iommu_domain *domain,
> +				   struct device *dev, ioasid_t id)
> +{
> +	struct arm_smmu_bond *bond = NULL, *t;
> +	struct mm_struct *mm = domain_to_mm(domain);
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
> index 6e2cd082c670..4ad3ca70cf89 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2858,6 +2858,12 @@ static struct iommu_ops arm_smmu_ops = {
>  	.page_response		= arm_smmu_page_response,
>  	.pgsize_bitmap		= -1UL, /* Restricted during device attach */
>  	.owner			= THIS_MODULE,
> +#ifdef CONFIG_ARM_SMMU_V3_SVA
> +	.sva_domain_ops = &(const struct iommu_domain_ops) {
> +		.set_dev_pasid		= arm_smmu_sva_attach_dev_pasid,
> +		.block_dev_pasid	= arm_smmu_sva_detach_dev_pasid,
> +	},
> +#endif
>  	.default_domain_ops = &(const struct iommu_domain_ops) {
>  		.attach_dev		= arm_smmu_attach_dev,
>  		.map_pages		= arm_smmu_map_pages,
> -- 
> 2.25.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
