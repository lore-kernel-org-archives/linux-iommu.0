From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2] iommu/of: Remove PCI host bridge node check
Date: Thu, 21 Sep 2017 12:08:00 +0100
Message-ID: <b723611a-d5d5-e4e6-9ca4-eb294763a083@arm.com>
References: <7ff4e56719d2e90426d9338eab00396bb2b61995.1505988973.git.robin.murphy@arm.com>
 <56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56a797382ffc65243169205c36d9f9fb1173dddd.1505989095.git.robin.murphy@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Robin Murphy <robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On 21/09/17 11:20, Robin Murphy wrote:
> of_pci_iommu_init() tries to be clever and stop its alias walk at the
> device represented by master_np, in case of weird PCI topologies where
> the bridge to the IOMMU and the rest of the system is not at the root.
> It turns out this is a bit short-sighted, since there are plenty of
> other callers of pci_for_each_dma_alias() which would also need the same
> behaviour in that situation, and the only platform so far with such a
> topology (Cavium ThunderX2) already solves it more generally via a PCI
> quirk. As this check is effectively redundant, and returning a boolean
> value as an int is a bit broken anyway, let's just get rid of it.
> 
> Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

This fixes the 4.14-rc1 issue I had with PCI probing on the FastModel

Tested-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>

> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> 
> Ugh, I'm really failing to spot the obvious today...
> 
>  drivers/iommu/of_iommu.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index e60e3dba85a0..50947ebb6d17 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -157,10 +157,7 @@ static int of_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
>  
>  	err = of_iommu_xlate(info->dev, &iommu_spec);
>  	of_node_put(iommu_spec.np);
> -	if (err)
> -		return err;
> -
> -	return info->np == pdev->bus->dev.of_node;
> +	return err;
>  }
>  
>  const struct iommu_ops *of_iommu_configure(struct device *dev,
> 
