Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767759480C
	for <iommu@lists.linux.dev>; Tue,  8 Sep 2026 17:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788887716; cv=none; b=eiHVidP4JLFM7iGu6vjdkILAHlox92xfZyEcx37LOKqvy/SGhmnK+gHMvDCB0jpW6gvh3PPMmnDfoeMmRt4oiMwiw0TS0/n3h/VUAAzzL0akMKdAJDeAKs3P4N0F9uTDsUXv8adeAO6hKuIipE2CM0K0f2s/NYEQ0ArPLBvh3tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788887716; c=relaxed/simple;
	bh=syMY1ltGd5Xuj1GDQCF9l5Yku76zHJv84jQ2lGHYAI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VymwgQuV9Abdbk5UOeuHh9NC8UgZkg7jxoeOGQowexee/zaQ0CNQlFVQLUa+uTa2h/w9khJ4lr+UZ7QVl9fytnIMCz0FPRI/blD4RjydyrYQWqWSkDuTSk3grJCqqPLe8erLDNufd1FTBMndkDgNiNdZRQIpnFfMYRDDxHSAwS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CFIGVnNa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CFIGVnNa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A4D11476;
	Tue,  8 Sep 2026 10:15:10 -0700 (PDT)
Received: from [10.2.212.23] (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8A553F528;
	Tue,  8 Sep 2026 10:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788887713; bh=syMY1ltGd5Xuj1GDQCF9l5Yku76zHJv84jQ2lGHYAI8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CFIGVnNajf5JzcWDPY1nL+uMOGK12HOM16PrEIplljyxlMu8Z4H7KVBN0kTA5AIV+
	 o8LHxuH/A84c9QwOsl0Cj1v2hR2TEqm2bthvkXHhJZ9RwCdsfLUxpz324/Yu9CW/+d
	 s+L+PtyQxJFuliBz8UR5GB1sCJ19Q+D/i1G9XwaU=
Message-ID: <52fc7110-2079-4090-8b32-2c913db0f298@arm.com>
Date: Tue, 8 Sep 2026 18:15:10 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/dma: Finalize deferred attachments when mapping MSI
 pages
To: Federico Parola <fparola@amazon.de>, "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: nh-open-source@amazon.com
References: <20260908160218.62322-1-fparola@amazon.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260908160218.62322-1-fparola@amazon.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2026 5:01 pm, Federico Parola wrote:
> When a device's attachment to its default domain is deferred, the IOMMU
> is still translating the device with the tables inherited from the
> previous kernel. Any mapping installed in that domain does not take
> effect until the deferred attachment is finalized.
> iommu_deferred_attach() covers the DMA mapping paths, but nothing covers
> iommu_dma_sw_msi(): programming an MSI installs the MSI page in
> group->domain and hands the resulting IOVA to the irqchip, so an MSI
> programmed before the first DMA map is written using an IOVA that the
> hardware does not yet translate.
> 
> This issue is currently not triggerable as the two IOMMU implementations
> supporting deferred attachments, Intel and AMD, do not rely on DMA
> translations for MSI transactions. However, the Arm implementation being
> introduced in [1] will be subject to it.
> 
> Finalize the deferred attachment from iommu_dma_sw_msi() too, right
> before the MSI page is mapped. iommu_dma_prepare_msi() already holds
> group->mutex across the call, so factor the locked part of
> iommu_deferred_attach() out into __iommu_deferred_attach() and call that
> instead of taking the mutex recursively. The static branch on
> iommu_deferred_attach_enabled can be omitted as MSI page allocation is
> not on a fast path.

So why not just invoke iommu_deferred_attach() from 
iommu_dma_prepare_msi() itself, before taking the mutex at all, and save 
all the other churn? The two operations might happen to serialise on the 
same lock for their own different reasons, but they still have no need 
to be atomic relative to each other. If it's not a fast path in general 
then there should equally be little reason to worry about also checking 
in the cases which might not dispatch to iommu_dma_sw_msi().

Thanks,
Robin.

> The behaviour of a rejected attach changes slightly: an attach refused
> because the device is being reset (-EBUSY) now fails MSI setup rather
> than only the first DMA map.
> 
> Link: https://lore.kernel.org/linux-iommu/cover.1788130528.git.nicolinc@nvidia.com/ [1]
> Signed-off-by: Federico Parola <fparola@amazon.de>
> ---
>   drivers/iommu/dma-iommu.c  |  7 +++++++
>   drivers/iommu/iommu-priv.h |  2 ++
>   drivers/iommu/iommu.c      | 25 ++++++++++++++++++-------
>   3 files changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 58c624513cd4..fa7de1b3d538 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -37,6 +37,7 @@
>   
>   #include "dma-iommu.h"
>   #include "iommu-pages.h"
> +#include "iommu-priv.h"
>   
>   struct iommu_dma_msi_page {
>   	struct list_head	list;
> @@ -2247,6 +2248,7 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
>   {
>   	struct device *dev = msi_desc_to_dev(desc);
>   	const struct iommu_dma_msi_page *msi_page;
> +	int ret;
>   
>   	if (!has_msi_cookie(domain)) {
>   		msi_desc_set_iommu_msi_iova(desc, 0, 0);
> @@ -2254,6 +2256,11 @@ int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
>   	}
>   
>   	iommu_group_mutex_assert(dev);
> +
> +	ret = __iommu_deferred_attach(dev, domain);
> +	if (ret)
> +		return ret;
> +
>   	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
>   	if (!msi_page)
>   		return -ENOMEM;
> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
> index aaffad5854fc..ba72f9a03b0b 100644
> --- a/drivers/iommu/iommu-priv.h
> +++ b/drivers/iommu/iommu-priv.h
> @@ -21,6 +21,8 @@ static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>   
>   void dev_iommu_free(struct device *dev);
>   
> +int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain);
> +
>   const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);
>   
>   static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cd1bca7ede9a..d7d70689c784 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2214,19 +2214,15 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_attach_device);
>   
> -int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> +/* Caller must hold dev->iommu_group->mutex */
> +int __iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   {
>   	struct group_device *gdev;
>   
> -	/*
> -	 * This is called on the dma mapping fast path so avoid locking. This is
> -	 * racy, but we have an expectation that the driver will setup its DMAs
> -	 * inside probe while being single threaded to avoid racing.
> -	 */
>   	if (!dev->iommu || !dev->iommu->attach_deferred)
>   		return 0;
>   
> -	guard(mutex)(&dev->iommu_group->mutex);
> +	lockdep_assert_held(&dev->iommu_group->mutex);
>   
>   	gdev = __dev_to_gdev(dev);
>   	if (WARN_ON(!gdev))
> @@ -2244,6 +2240,21 @@ int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
>   	return __iommu_attach_device(domain, dev, NULL);
>   }
>   
> +int iommu_deferred_attach(struct device *dev, struct iommu_domain *domain)
> +{
> +	/*
> +	 * This is called on the dma mapping fast path so avoid locking. This is
> +	 * racy, but we have an expectation that the driver will setup its DMAs
> +	 * inside probe while being single threaded to avoid racing.
> +	 */
> +	if (!dev->iommu || !dev->iommu->attach_deferred)
> +		return 0;
> +
> +	guard(mutex)(&dev->iommu_group->mutex);
> +
> +	return __iommu_deferred_attach(dev, domain);
> +}
> +
>   void iommu_detach_device(struct iommu_domain *domain, struct device *dev)
>   {
>   	/* Caller must be a probed driver on dev */

