From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/7] iommu/dma-iommu: Split iommu_dma_map_msi_msg in two
 parts
Date: Tue, 23 Apr 2019 00:08:23 -0700
Message-ID: <20190423070823.GA12114@infradead.org>
References: <20190418172611.21561-1-julien.grall@arm.com>
 <20190418172611.21561-3-julien.grall@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190418172611.21561-3-julien.grall@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Julien Grall <julien.grall@arm.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, logang@deltatee.com, douliyangs@gmail.com, miquel.raynal@bootlin.com, marc.zyngier@arm.com, jason@lakedaemon.net, tglx@linutronix.de, joro@8bytes.org, robin.murphy@arm.com, bigeasy@linutronix.de, linux-rt-users@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 18, 2019 at 06:26:06PM +0100, Julien Grall wrote:
> +int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
>  {
> +	struct device *dev = msi_desc_to_dev(desc);
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  	struct iommu_dma_cookie *cookie;
>  	unsigned long flags;
>  
> +	if (!domain || !domain->iova_cookie) {
> +		desc->iommu_cookie = NULL;
> +		return 0;
> +	}
>  
>  	cookie = domain->iova_cookie;
>  
> @@ -908,10 +908,33 @@ void iommu_dma_map_msi_msg(int irq, struct msi_msg *msg)
>  	 * of an MSI from within an IPI handler.
>  	 */
>  	spin_lock_irqsave(&cookie->msi_lock, flags);
> +	desc->iommu_cookie = iommu_dma_get_msi_page(dev, msi_addr, domain);
>  	spin_unlock_irqrestore(&cookie->msi_lock, flags);
>  
> +	return (desc->iommu_cookie) ? 0 : -ENOMEM;

No need for the braces.  Also I personally find a:

	if (!desc->iommu_cookie)
		return -ENOMEM;
	return 0;

much more readable, but that might just be personal preference.
