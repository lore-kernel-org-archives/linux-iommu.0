From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ARM: IOMMU: Tegra20: Add iommu_ops for GART driver
Date: Mon, 23 Jan 2012 16:00:48 +0100
Message-ID: <20120123150048.GB6269@8bytes.org>
References: <1325747509-29665-1-git-send-email-hdoyu@nvidia.com> <1325747509-29665-2-git-send-email-hdoyu@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1325747509-29665-2-git-send-email-hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hiroshi DOYU <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-mm-sig-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

first, some questions about the GART on your platform.

1) How many GARTs are usually implemented? One GART per device or is
   there a single GART covering all devices, or a mix of both?
2) Are devices allowed to DMA outside of the remappable range or will
   this fail?

Besides that I think IOMMU-API is not yet fully ready for GART-like
drivers like this one. But I will merge it anyway to get things moving.
But please answer or fix my objections first.

On Thu, Jan 05, 2012 at 09:11:48AM +0200, Hiroshi DOYU wrote:
> +static void gart_iommu_domain_destroy(struct iommu_domain *domain)
> +{
> +	struct gart_device *gart = domain->priv;
> +
> +	spin_lock(&gart->client_lock);
> +	if (!list_empty(&gart->client)) {
> +		struct gart_client *c;
> +
> +		list_for_each_entry(c, &gart->client, list)
> +			dev_err(gart->dev,
> +				"%s is still attached\n", dev_name(c->dev));
> +	}
> +	spin_unlock(&gart->client_lock);

gart needs a NULL check. When you create a domain and immediatly destroy
it without ever attaching a device this code will dereference a NULL
pointer.
As a general improvement I suggest that you introduce a gart_domain
structure and store it in domain->priv (assigned in domain_init) instead
of using the hardware descriptor.

> +static int gart_iommu_attach_dev(struct iommu_domain *domain,
> +				 struct device *dev)
> +{
> +	struct gart_device *gart;
> +	struct gart_client *client, *c;
> +	int err = 0;
> +
> +	gart = dev_get_drvdata(dev->parent);
> +	if (!gart)
> +		return -EINVAL;
> +	domain->priv = gart;

What happens when devices behind different GARTs are assigned to the
same domain? domain->priv can only hold a pointer to one hardware GART.
This can be solved by a 'struct gart_domain' holding a linked list to
all gart_devices in this domain.


	Joerg
