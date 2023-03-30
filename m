Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26386FCD
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 15:09:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 989CF2F4;
	Thu, 30 Mar 2023 08:09:54 -0700 (PDT)
Received: from [10.57.54.254] (unknown [10.57.54.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 988113F6C4;
	Thu, 30 Mar 2023 08:09:08 -0700 (PDT)
Message-ID: <3356d18f-d1ce-4995-2b95-16938df1b7d6@arm.com>
Date: Thu, 30 Mar 2023 16:09:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3] iommu/rockchip: Add missing set_platform_dma_ops
 callback
Content-Language: en-GB
To: Steven Price <steven.price@arm.com>, Heiko Stuebner <heiko@sntech.de>,
 Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, John Keeping <john@metanate.com>,
 Jason Gunthorpe <jgg@nvidia.com>
References: <20230330144604.2431436-1-steven.price@arm.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230330144604.2431436-1-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-03-30 15:46, Steven Price wrote:
> Similar to exynos, we need a set_platform_dma_ops() callback for proper
> operation on ARM 32 bit after recent changes in the IOMMU framework
> (detach ops removal). But also the use of a NULL domain is confusing.
> 
> Rework the code to have a singleton rk_identity_domain which is assigned
> to domain when using an identity mapping rather than "detaching". This
> makes the code easier to reason about.

Really this is adding complete support for IOMMU_DOMAIN_IDENTITY in 
general, which will also be visible on arm64. The part then using it to 
bodge a pseudo-default-domain for Arm seems more incidental ;)

> Signed-off-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> Changes since v2[1]:
> 
>   * Fixed suspend/resume handlers to check against rk_identity_domain
>     rather than NULL (thanks John).
> 
> [1] https://lore.kernel.org/r/20230324111127.221640-1-steven.price%40arm.com
> 
>   drivers/iommu/rockchip-iommu.c | 56 +++++++++++++++++++++++++---------
>   1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index f30db22ea5d7..4f97af471671 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -124,6 +124,7 @@ struct rk_iommudata {
>   
>   static struct device *dma_dev;
>   static const struct rk_iommu_ops *rk_ops;
> +static struct iommu_domain rk_identity_domain;
>   
>   static inline void rk_table_flush(struct rk_iommu_domain *dom, dma_addr_t dma,
>   				  unsigned int count)
> @@ -646,7 +647,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>   			 * Ignore the return code, though, since we always zap cache
>   			 * and clear the page fault anyway.
>   			 */
> -			if (iommu->domain)
> +			if (iommu->domain != &rk_identity_domain)
>   				report_iommu_fault(iommu->domain, iommu->dev, iova,
>   						   flags);
>   			else
> @@ -980,26 +981,27 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
>   	return ret;
>   }
>   
> -static void rk_iommu_detach_device(struct iommu_domain *domain,
> -				   struct device *dev)
> +static int rk_iommu_identity_attach(struct iommu_domain *identity_domain,
> +				    struct device *dev)
>   {
>   	struct rk_iommu *iommu;
> -	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
> +	struct rk_iommu_domain *rk_domain;
>   	unsigned long flags;
>   	int ret;
>   
>   	/* Allow 'virtual devices' (eg drm) to detach from domain */
>   	iommu = rk_iommu_from_dev(dev);
>   	if (!iommu)
> -		return;
> +		return -ENODEV;
> +
> +	rk_domain = to_rk_domain(iommu->domain);
>   
>   	dev_dbg(dev, "Detaching from iommu domain\n");
>   
> -	/* iommu already detached */
> -	if (iommu->domain != domain)
> -		return;
> +	if (iommu->domain == identity_domain)
> +		return 0;
>   
> -	iommu->domain = NULL;
> +	iommu->domain = identity_domain;
>   
>   	spin_lock_irqsave(&rk_domain->iommus_lock, flags);
>   	list_del_init(&iommu->node);
> @@ -1011,7 +1013,25 @@ static void rk_iommu_detach_device(struct iommu_domain *domain,
>   		rk_iommu_disable(iommu);
>   		pm_runtime_put(iommu->dev);
>   	}
> +
> +	return 0;
> +}
> +
> +static struct iommu_domain_ops rk_identity_ops = {
> +	.attach_dev = rk_iommu_identity_attach,

Since it's going to behave like a regular identity domain and be treated 
as one, it needs to support .free as well.

Thanks,
Robin.

> +};
> +
> +static struct iommu_domain rk_identity_domain = {
> +	.type = IOMMU_DOMAIN_IDENTITY,
> +	.ops = &rk_identity_ops,
> +};
> +
> +#ifdef CONFIG_ARM
> +static void rk_iommu_set_platform_dma(struct device *dev)
> +{
> +	WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
>   }
> +#endif
>   
>   static int rk_iommu_attach_device(struct iommu_domain *domain,
>   		struct device *dev)
> @@ -1035,8 +1055,9 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   	if (iommu->domain == domain)
>   		return 0;
>   
> -	if (iommu->domain)
> -		rk_iommu_detach_device(iommu->domain, dev);
> +	ret = rk_iommu_identity_attach(&rk_identity_domain, dev);
> +	if (ret)
> +		return ret;
>   
>   	iommu->domain = domain;
>   
> @@ -1050,7 +1071,7 @@ static int rk_iommu_attach_device(struct iommu_domain *domain,
>   
>   	ret = rk_iommu_enable(iommu);
>   	if (ret)
> -		rk_iommu_detach_device(iommu->domain, dev);
> +		WARN_ON(rk_iommu_identity_attach(&rk_identity_domain, dev));
>   
>   	pm_runtime_put(iommu->dev);
>   
> @@ -1061,6 +1082,9 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>   {
>   	struct rk_iommu_domain *rk_domain;
>   
> +	if (type == IOMMU_DOMAIN_IDENTITY)
> +		return &rk_identity_domain;
> +
>   	if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
>   		return NULL;
>   
> @@ -1176,6 +1200,7 @@ static int rk_iommu_of_xlate(struct device *dev,
>   	iommu_dev = of_find_device_by_node(args->np);
>   
>   	data->iommu = platform_get_drvdata(iommu_dev);
> +	data->iommu->domain = &rk_identity_domain;
>   	dev_iommu_priv_set(dev, data);
>   
>   	platform_device_put(iommu_dev);
> @@ -1188,6 +1213,9 @@ static const struct iommu_ops rk_iommu_ops = {
>   	.probe_device = rk_iommu_probe_device,
>   	.release_device = rk_iommu_release_device,
>   	.device_group = rk_iommu_device_group,
> +#ifdef CONFIG_ARM
> +	.set_platform_dma_ops = rk_iommu_set_platform_dma,
> +#endif
>   	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
>   	.of_xlate = rk_iommu_of_xlate,
>   	.default_domain_ops = &(const struct iommu_domain_ops) {
> @@ -1343,7 +1371,7 @@ static int __maybe_unused rk_iommu_suspend(struct device *dev)
>   {
>   	struct rk_iommu *iommu = dev_get_drvdata(dev);
>   
> -	if (!iommu->domain)
> +	if (iommu->domain == &rk_identity_domain)
>   		return 0;
>   
>   	rk_iommu_disable(iommu);
> @@ -1354,7 +1382,7 @@ static int __maybe_unused rk_iommu_resume(struct device *dev)
>   {
>   	struct rk_iommu *iommu = dev_get_drvdata(dev);
>   
> -	if (!iommu->domain)
> +	if (iommu->domain == &rk_identity_domain)
>   		return 0;
>   
>   	return rk_iommu_enable(iommu);
