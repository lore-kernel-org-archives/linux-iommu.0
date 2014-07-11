From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC/PATCH 2/7] iommu-api: Add map_range/unmap_range functions
Date: Fri, 11 Jul 2014 12:20:53 +0200
Message-ID: <20140711102053.GB1958@8bytes.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
 <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404147116-4598-3-git-send-email-ohaugan@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Olav Haugan <ohaugan@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, linux-arm-msm@vger.kernel.org, will.deacon@arm.com, thierry.reding@gmail.com, vgandhi@codeaurora.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jun 30, 2014 at 09:51:51AM -0700, Olav Haugan wrote:
> +int iommu_map_range(struct iommu_domain *domain, unsigned int iova,
> +		    struct scatterlist *sg, unsigned int len, int prot)
> +{
> +	if (unlikely(domain->ops->map_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->map_range(domain, iova, sg, len, prot);
> +}
> +EXPORT_SYMBOL_GPL(iommu_map_range);
> +
> +int iommu_unmap_range(struct iommu_domain *domain, unsigned int iova,
> +		      unsigned int len)
> +{
> +	if (unlikely(domain->ops->unmap_range == NULL))
> +		return -ENODEV;
> +
> +	BUG_ON(iova & (~PAGE_MASK));
> +
> +	return domain->ops->unmap_range(domain, iova, len);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unmap_range);

Before introducing these new API functions there should be a fall-back
for IOMMU drivers that do (not yet) implement the map_range and
unmap_range call-backs.

The last thing we want is this kind of functional partitioning between
different IOMMU drivers.


	Joerg
