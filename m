From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] ARM: IOMMU: Tegra30: Add iommu_ops for SMMU driver
Date: Mon, 23 Jan 2012 16:43:10 +0100
Message-ID: <20120123154310.GC6269@8bytes.org>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com> <1325747509-29665-3-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1325747509-29665-3-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

please see my comments inline. When you fix these issues I think the
driver is ready for merging.

On Thu, Jan 05, 2012 at 09:11:49AM +0200, Hiroshi DOYU wrote:
> +static int smmu_iommu_map(struct iommu_domain *domain, unsigned long iova,
> +			  phys_addr_t pa, size_t bytes, int prot)
> +{
> +	struct smmu_as *as = domain->priv;
> +	unsigned long pfn = __phys_to_pfn(pa);
> +	unsigned long flags;
> +
> +	dev_dbg(as->smmu->dev, "[%d] %08lx:%08x\n", as->asid, iova, pa);
> +
> +	if (!pfn_valid(pfn))
> +		return -ENOMEM;
> +
> +	spin_lock_irqsave(&as->lock, flags);
> +	__smmu_iommu_map_pfn(as, iova, pfn);
> +	spin_unlock_irqrestore(&as->lock, flags);
> +	return 0;

Why do you completly ignore the size parameter in this function (and
in the unmap part below)?
According to the page-sizes you export to the generic layer size can be
4k or 4M. You need to take care of that in this function.

> +static void smmu_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> +	struct smmu_as *as = domain->priv;
> +	struct smmu_device *smmu = as->smmu;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&as->lock, flags);
> +
> +	if (as->pdir_page) {
> +		spin_lock(&smmu->lock);
> +		smmu_write(smmu, SMMU_PTB_ASID_CUR(as->asid), SMMU_PTB_ASID);
> +		smmu_write(smmu, SMMU_PTB_DATA_RESET_VAL, SMMU_PTB_DATA);
> +		FLUSH_SMMU_REGS(smmu);
> +		spin_unlock(&smmu->lock);
> +
> +		free_pdir(as);
> +	}
> +
> +	if (!list_empty(&as->client)) {
> +		struct smmu_client *c;
> +
> +		list_for_each_entry(c, &as->client, list)
> +			dev_err(smmu->dev,
> +				"%s is still attached\n", dev_name(c->dev));

This is not an error. Just detach the devices when they are still
attached to the domain.

> +	}
> +
> +	spin_unlock_irqrestore(&as->lock, flags);
> +
> +	domain->priv = NULL;
> +	dev_dbg(smmu->dev, "smmu_as@%p\n", as);
> +}
> +
> +static int smmu_iommu_attach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct smmu_as *as = domain->priv;
> +	struct smmu_device *smmu = as->smmu;

Hmm, this looks like there is a 1-1 mapping between hardware SMMU
devices and domains. This is not consistent with IOMMU-API semantics
where a domain can contain devices behind different SMMUs. Please fix
that.


Thanks,

	Joerg
