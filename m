Return-Path: <SRS0=m4kH=AS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E71C433E2
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EFC9206DF
	for <iommu@archiver.kernel.org>; Tue,  7 Jul 2020 11:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFC9206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 051F08847B;
	Tue,  7 Jul 2020 11:36:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fEQSKZaBC0NV; Tue,  7 Jul 2020 11:36:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id CDD0085BA9;
	Tue,  7 Jul 2020 11:36:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A70B5C07FF;
	Tue,  7 Jul 2020 11:36:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5D10EC016F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:36:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 4CDD287A2E
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:36:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k6dQ3Ums45c4 for <iommu@lists.linux-foundation.org>;
 Tue,  7 Jul 2020 11:36:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 092BD87A0F
 for <iommu@lists.linux-foundation.org>; Tue,  7 Jul 2020 11:36:46 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 353A41FB;
 Tue,  7 Jul 2020 04:36:46 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 889143F71E;
 Tue,  7 Jul 2020 04:36:44 -0700 (PDT)
Subject: Re: [PATCH v2 4/6] drm/msm: Add support to create a local pagetable
To: Jordan Crouse <jcrouse@codeaurora.org>, linux-arm-msm@vger.kernel.org
References: <20200626200414.14382-1-jcrouse@codeaurora.org>
 <20200626200414.14382-5-jcrouse@codeaurora.org>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <3feed674-5eb9-ca2f-76a7-f888f431c409@arm.com>
Date: Tue, 7 Jul 2020 12:36:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200626200414.14382-5-jcrouse@codeaurora.org>
Content-Language: en-GB
Cc: David Airlie <airlied@linux.ie>, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 iommu@lists.linux-foundation.org, John Stultz <john.stultz@linaro.org>,
 Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On 2020-06-26 21:04, Jordan Crouse wrote:
> Add support to create a io-pgtable for use by targets that support
> per-instance pagetables.  In order to support per-instance pagetables the
> GPU SMMU device needs to have the qcom,adreno-smmu compatible string and
> split pagetables and auxiliary domains need to be supported and enabled.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
> 
>   drivers/gpu/drm/msm/msm_gpummu.c |   2 +-
>   drivers/gpu/drm/msm/msm_iommu.c  | 180 ++++++++++++++++++++++++++++++-
>   drivers/gpu/drm/msm/msm_mmu.h    |  16 ++-
>   3 files changed, 195 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_gpummu.c b/drivers/gpu/drm/msm/msm_gpummu.c
> index 310a31b05faa..aab121f4beb7 100644
> --- a/drivers/gpu/drm/msm/msm_gpummu.c
> +++ b/drivers/gpu/drm/msm/msm_gpummu.c
> @@ -102,7 +102,7 @@ struct msm_mmu *msm_gpummu_new(struct device *dev, struct msm_gpu *gpu)
>   	}
>   
>   	gpummu->gpu = gpu;
> -	msm_mmu_init(&gpummu->base, dev, &funcs);
> +	msm_mmu_init(&gpummu->base, dev, &funcs, MSM_MMU_GPUMMU);
>   
>   	return &gpummu->base;
>   }
> diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
> index 1b6635504069..f455c597f76d 100644
> --- a/drivers/gpu/drm/msm/msm_iommu.c
> +++ b/drivers/gpu/drm/msm/msm_iommu.c
> @@ -4,15 +4,192 @@
>    * Author: Rob Clark <robdclark@gmail.com>
>    */
>   
> +#include <linux/io-pgtable.h>
>   #include "msm_drv.h"
>   #include "msm_mmu.h"
>   
>   struct msm_iommu {
>   	struct msm_mmu base;
>   	struct iommu_domain *domain;
> +	struct iommu_domain *aux_domain;
>   };
> +
>   #define to_msm_iommu(x) container_of(x, struct msm_iommu, base)
>   
> +struct msm_iommu_pagetable {
> +	struct msm_mmu base;
> +	struct msm_mmu *parent;
> +	struct io_pgtable_ops *pgtbl_ops;
> +	phys_addr_t ttbr;
> +	u32 asid;
> +};
> +
> +static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
> +{
> +	return container_of(mmu, struct msm_iommu_pagetable, base);
> +}
> +
> +static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
> +		size_t size)
> +{
> +	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> +	size_t unmapped = 0;
> +
> +	/* Unmap the block one page at a time */
> +	while (size) {
> +		unmapped += ops->unmap(ops, iova, 4096, NULL);
> +		iova += 4096;
> +		size -= 4096;
> +	}
> +
> +	iommu_flush_tlb_all(to_msm_iommu(pagetable->parent)->domain);
> +
> +	return (unmapped == size) ? 0 : -EINVAL;
> +}

Remember in patch #1 when you said "Then 'domain' can be used like any 
other iommu domain to map and unmap iova addresses in the pagetable."?

This appears to be very much not that :/

Robin.

> +
> +static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
> +		struct sg_table *sgt, size_t len, int prot)
> +{
> +	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
> +	struct scatterlist *sg;
> +	size_t mapped = 0;
> +	u64 addr = iova;
> +	unsigned int i;
> +
> +	for_each_sg(sgt->sgl, sg, sgt->nents, i) {
> +		size_t size = sg->length;
> +		phys_addr_t phys = sg_phys(sg);
> +
> +		/* Map the block one page at a time */
> +		while (size) {
> +			if (ops->map(ops, addr, phys, 4096, prot)) {
> +				msm_iommu_pagetable_unmap(mmu, iova, mapped);
> +				return -EINVAL;
> +			}
> +
> +			phys += 4096;
> +			addr += 4096;
> +			size -= 4096;
> +			mapped += 4096;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
> +{
> +	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
> +
> +	free_io_pgtable_ops(pagetable->pgtbl_ops);
> +	kfree(pagetable);
> +}
> +
> +/*
> + * Given a parent device, create and return an aux domain. This will enable the
> + * TTBR0 region
> + */
> +static struct iommu_domain *msm_iommu_get_aux_domain(struct msm_mmu *parent)
> +{
> +	struct msm_iommu *iommu = to_msm_iommu(parent);
> +	struct iommu_domain *domain;
> +	int ret;
> +
> +	if (iommu->aux_domain)
> +		return iommu->aux_domain;
> +
> +	if (!iommu_dev_has_feature(parent->dev, IOMMU_DEV_FEAT_AUX))
> +		return ERR_PTR(-ENODEV);
> +
> +	domain = iommu_domain_alloc(&platform_bus_type);
> +	if (!domain)
> +		return ERR_PTR(-ENODEV);
> +
> +	ret = iommu_aux_attach_device(domain, parent->dev);
> +	if (ret) {
> +		iommu_domain_free(domain);
> +		return ERR_PTR(ret);
> +	}
> +
> +	iommu->aux_domain = domain;
> +	return domain;
> +}
> +
> +int msm_iommu_pagetable_params(struct msm_mmu *mmu,
> +		phys_addr_t *ttbr, int *asid)
> +{
> +	struct msm_iommu_pagetable *pagetable;
> +
> +	if (mmu->type != MSM_MMU_IOMMU_PAGETABLE)
> +		return -EINVAL;
> +
> +	pagetable = to_pagetable(mmu);
> +
> +	if (ttbr)
> +		*ttbr = pagetable->ttbr;
> +
> +	if (asid)
> +		*asid = pagetable->asid;
> +
> +	return 0;
> +}
> +
> +static const struct msm_mmu_funcs pagetable_funcs = {
> +		.map = msm_iommu_pagetable_map,
> +		.unmap = msm_iommu_pagetable_unmap,
> +		.destroy = msm_iommu_pagetable_destroy,
> +};
> +
> +struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
> +{
> +	static int next_asid = 16;
> +	struct msm_iommu_pagetable *pagetable;
> +	struct iommu_domain *aux_domain;
> +	struct io_pgtable_cfg cfg;
> +	int ret;
> +
> +	/* Make sure that the parent has a aux domain attached */
> +	aux_domain = msm_iommu_get_aux_domain(parent);
> +	if (IS_ERR(aux_domain))
> +		return ERR_CAST(aux_domain);
> +
> +	/* Get the pagetable configuration from the aux domain */
> +	ret = iommu_domain_get_attr(aux_domain, DOMAIN_ATTR_PGTABLE_CFG, &cfg);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pagetable = kzalloc(sizeof(*pagetable), GFP_KERNEL);
> +	if (!pagetable)
> +		return ERR_PTR(-ENOMEM);
> +
> +	msm_mmu_init(&pagetable->base, parent->dev, &pagetable_funcs,
> +		MSM_MMU_IOMMU_PAGETABLE);
> +
> +	cfg.tlb = NULL;
> +
> +	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
> +		&cfg, aux_domain);
> +
> +	if (!pagetable->pgtbl_ops) {
> +		kfree(pagetable);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +
> +	/* Needed later for TLB flush */
> +	pagetable->parent = parent;
> +	pagetable->ttbr = cfg.arm_lpae_s1_cfg.ttbr;
> +
> +	pagetable->asid = next_asid;
> +	next_asid = (next_asid + 1)  % 255;
> +	if (next_asid < 16)
> +		next_asid = 16;
> +
> +	return &pagetable->base;
> +}
> +
>   static int msm_fault_handler(struct iommu_domain *domain, struct device *dev,
>   		unsigned long iova, int flags, void *arg)
>   {
> @@ -40,6 +217,7 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
>   	if (iova & BIT_ULL(48))
>   		iova |= GENMASK_ULL(63, 49);
>   
> +
>   	ret = iommu_map_sg(iommu->domain, iova, sgt->sgl, sgt->nents, prot);
>   	WARN_ON(!ret);
>   
> @@ -85,7 +263,7 @@ struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain)
>   		return ERR_PTR(-ENOMEM);
>   
>   	iommu->domain = domain;
> -	msm_mmu_init(&iommu->base, dev, &funcs);
> +	msm_mmu_init(&iommu->base, dev, &funcs, MSM_MMU_IOMMU);
>   	iommu_set_fault_handler(domain, msm_fault_handler, iommu);
>   
>   	ret = iommu_attach_device(iommu->domain, dev);
> diff --git a/drivers/gpu/drm/msm/msm_mmu.h b/drivers/gpu/drm/msm/msm_mmu.h
> index 3a534ee59bf6..61ade89d9e48 100644
> --- a/drivers/gpu/drm/msm/msm_mmu.h
> +++ b/drivers/gpu/drm/msm/msm_mmu.h
> @@ -17,18 +17,26 @@ struct msm_mmu_funcs {
>   	void (*destroy)(struct msm_mmu *mmu);
>   };
>   
> +enum msm_mmu_type {
> +	MSM_MMU_GPUMMU,
> +	MSM_MMU_IOMMU,
> +	MSM_MMU_IOMMU_PAGETABLE,
> +};
> +
>   struct msm_mmu {
>   	const struct msm_mmu_funcs *funcs;
>   	struct device *dev;
>   	int (*handler)(void *arg, unsigned long iova, int flags);
>   	void *arg;
> +	enum msm_mmu_type type;
>   };
>   
>   static inline void msm_mmu_init(struct msm_mmu *mmu, struct device *dev,
> -		const struct msm_mmu_funcs *funcs)
> +		const struct msm_mmu_funcs *funcs, enum msm_mmu_type type)
>   {
>   	mmu->dev = dev;
>   	mmu->funcs = funcs;
> +	mmu->type = type;
>   }
>   
>   struct msm_mmu *msm_iommu_new(struct device *dev, struct iommu_domain *domain);
> @@ -41,7 +49,13 @@ static inline void msm_mmu_set_fault_handler(struct msm_mmu *mmu, void *arg,
>   	mmu->handler = handler;
>   }
>   
> +struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent);
> +
>   void msm_gpummu_params(struct msm_mmu *mmu, dma_addr_t *pt_base,
>   		dma_addr_t *tran_error);
>   
> +
> +int msm_iommu_pagetable_params(struct msm_mmu *mmu, phys_addr_t *ttbr,
> +		int *asid);
> +
>   #endif /* __MSM_MMU_H__ */
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
