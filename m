From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/amd: Add proper error check in two functions
Date: Wed, 15 Jun 2016 13:17:09 +0200
Message-ID: <20160615111709.GC26566@8bytes.org>
References: <1462898401-2917-1-git-send-email-vincent.wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462898401-2917-1-git-send-email-vincent.wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan Zongshun <vincent.wan@amd.com>
Cc: iommu@lists.linux-foundation.org, vw@iommu.org, mcuos.com@gmail.com, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Tue, May 10, 2016 at 12:40:01PM -0400, Wan Zongshun wrote:
> From: Wan Zongshun <Vincent.Wan@amd.com>
> 
> This patch is to do the following:
> 
> 1. Add error check for caller of iommu_device_create.
> 
> 2. Add error check for caller of iommu_device_link and
> move 'iommu = amd_iommu_rlookup_table[dev_data->devid]' out of
> iommuv2 capability condition that make iommu_device_link also
> use the 'iommu' to make code more clear and no more than 80
> characters.
> 
> Signed-off-by: Wan Zongshun <Vincent.Wan@amd.com>
> ---
>  drivers/iommu/amd_iommu.c      | 12 ++++--------
>  drivers/iommu/amd_iommu_init.c |  2 ++
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 547cdd4..232a3b9 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -414,6 +414,7 @@ out:
>  static int iommu_init_device(struct device *dev)
>  {
>  	struct iommu_dev_data *dev_data;
> +	struct amd_iommu *iommu;
>  	int devid;
>  
>  	if (dev->archdata.iommu)
> @@ -427,19 +428,14 @@ static int iommu_init_device(struct device *dev)
>  	if (!dev_data)
>  		return -ENOMEM;
>  
> -	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
> -		struct amd_iommu *iommu;
> +	iommu = amd_iommu_rlookup_table[dev_data->devid];
>  
> -		iommu = amd_iommu_rlookup_table[dev_data->devid];
> +	if (dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev)))
>  		dev_data->iommu_v2 = iommu->is_iommu_v2;
> -	}
>  
>  	dev->archdata.iommu = dev_data;
>  
> -	iommu_device_link(amd_iommu_rlookup_table[dev_data->devid]->iommu_dev,
> -			  dev);
> -
> -	return 0;
> +	return iommu_device_link(iommu->iommu_dev, dev);

I don't like to fail the whole iommu_init_device() function here, since
iommu_device_link only creates sysfs entries. Please just check for an
error return code and print a message if one happened. The function
should return 0 then.


	Joerg
