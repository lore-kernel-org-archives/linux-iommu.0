From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH V3 7/8] arm/arm64: dma-mapping: Call iommu's remove_device
	callback during device detach
Date: Wed, 26 Oct 2016 16:16:21 +0100
Message-ID: <2873304f-8b2e-b519-b3e6-d2b452b1df60@arm.com>
References: <1475600632-21289-1-git-send-email-sricharan@codeaurora.org>
	<1475600632-21289-8-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1475600632-21289-8-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 04/10/16 18:03, Sricharan R wrote:
> dma_deconfigure calls arch_teardown_dma_ops in the device_detach path,
> which is called when the device gets detached from the driver.
> When the device was added, iommu's add_device callback was used to
> add the device in to its iommu_group and setup the device to be ready
> to use its iommu. Similarly, call remove_device callback to remove the
> device from the group and reset any other device's iommu configurations.
> 
> Signed-off-by: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> ---
>  arch/arm/mm/dma-mapping.c   | 8 ++++++++
>  arch/arm64/mm/dma-mapping.c | 7 +++++++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index b9191f0..cbe22de 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -2289,11 +2289,19 @@ static bool arm_setup_iommu_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  static void arm_teardown_iommu_dma_ops(struct device *dev)
>  {
>  	struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
> +	const struct iommu_ops *ops;
>  
>  	if (!mapping)
>  		return;
>  
>  	__arm_iommu_detach_device(dev);
> +
> +	if (dev->iommu_fwspec) {
> +		ops = dev->iommu_fwspec->ops;
> +		if (ops->remove_device)
> +			ops->remove_device(dev);
> +	}
> +

Yuck. It's a little unfortunate that we have to do this at all, but I
see why. Still, it should be done in common code, not duplicated across
arch code, not least for symmetry with where the matching add_device
happened (although I think of_dma_deconfigure() would suffice, I'm not
sure we really need to add an of_iommu_deconfigure() just for this).

It's also broken for IOMMU drivers which rely on the
of_iommu_configure() mechanism but have not yet been converted to use
iommu_fwspec (Exynos, MSM, etc.)

Robin.

>  	arm_iommu_release_mapping(mapping);
>  	set_dma_ops(dev, NULL);
>  }
> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index 610d8e5..faf4b92 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -938,6 +938,13 @@ static void __iommu_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
>  void arch_teardown_dma_ops(struct device *dev)
>  {
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
> +	const struct iommu_ops *ops;
> +
> +	if (dev->iommu_fwspec) {
> +		ops = dev->iommu_fwspec->ops;
> +		if (ops->remove_device)
> +			ops->remove_device(dev);
> +	}
>  
>  	if (WARN_ON(domain))
>  		iommu_detach_device(domain, dev);
> 
