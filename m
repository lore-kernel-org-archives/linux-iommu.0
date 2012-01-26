From: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: IOMMU: Tegra20: Add iommu_ops for GART driver
Date: Thu, 26 Jan 2012 12:58:13 +0100
Message-ID: <20120126115813.GF6269@8bytes.org>
References: <20120123150048.GB6269@8bytes.org> <20120125.094020.983282777619146490.hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120125.094020.983282777619146490.hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, Jan 25, 2012 at 08:40:20AM +0100, Hiroshi Doyu wrote:
> From: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> Date: Wed, 16 Nov 2011 17:36:37 +0200
> Subject: [PATCH 1/2] ARM: IOMMU: Tegra20: Add iommu_ops for GART driver
> 
> Tegra 20 IOMMU H/W, GART (Graphics Address Relocation Table). This
> patch implements struct iommu_ops for GART for the upper IOMMU API.
> 
> This H/W module supports only single virtual address space(domain),
> and manages a single level 1-to-1 mapping H/W translation page table.

Thanks. Applied with a few minor changes and fixes. Please see below.

> +config TEGRA_IOMMU_GART
> +	bool "Tegra GART IOMMU Support"
> +	depends on ARCH_TEGRA_2x_SOC
> +	default y

I removed 'default y'. New drivers shouldn't be selected by default.

> +static int gart_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +			  phys_addr_t pa, size_t bytes, int prot)
> +{
> +	struct gart_device *gart = domain->priv;
> +	unsigned long flags;
> +	unsigned long pfn;
> +
> +	if (!gart_iova_range_valid(gart, iova, bytes))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&gart->pte_lock, flags);
> +	pfn = __phys_to_pfn(pa);
> +	if (!pfn_valid(pfn)) {
> +		dev_err(gart->dev, "Invalid page: %08x\n", pa);
> +		spin_unlock(&gart->pte_lock);

Changed this to spin_unlock_irqrestore().

> +		return -EINVAL;
> +	}
> +	gart_set_pte(gart, iova, GART_PTE(pfn));
> +	FLUSH_GART_REGS(gart);
> +	spin_unlock_irqrestore(&gart->pte_lock, flags);
> +	return 0;
> +}
> +
> +static size_t gart_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
> +			       size_t bytes)
> +{
> +	struct gart_device *gart = domain->priv;
> +	unsigned long flags;
> +
> +	if (!gart_iova_range_valid(gart, iova, bytes))
> +		return -EINVAL;

Return 0 here instead of -EINVAL. Size_t is unsigned and the unmap path
returns 0 on failure.
