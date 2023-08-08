Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BEA13FF3;
	Tue,  8 Aug 2023 16:23:03 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F0691515;
	Tue,  8 Aug 2023 09:23:45 -0700 (PDT)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D394F3F64C;
	Tue,  8 Aug 2023 09:23:00 -0700 (PDT)
Message-ID: <a94abd4d-fb0a-8f72-7dee-82144c90187b@arm.com>
Date: Tue, 8 Aug 2023 17:22:55 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 02/10] iommu: Add a lockdep assertion for remaining
 dev->iommu_group reads
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 David Woodhouse <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Orson Zhai <orsonzhai@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Oh, the things that happen if I take holiday... :)

On 31/07/2023 6:50 pm, Jason Gunthorpe wrote:
> The remaining reads are all in functions called under ops->device_group.
> 
> Broadly these functions are walking around the device tree (eg going up
> the PCI bus tree) and are trying to de-duplicate group allocations
> according to their logic.
> 
> Since these functions don't hold any particular per-device locks their
> reads to dev->iommu_group are being locked by the caller's
> iommu_probe_device_lock, and this explains why iommu_probe_device_lock
> needs to be a global lock.

This confuzzles me. iommu_probe_device_lock is a global (but 
tightly-scoped) lock because its sole purpose is as a point hack to 
serialise calls to iommu_probe_device(), which were never expected to be 
able to happen concurrently for the same device, but due to the 
long-standing "replay" hacks, currently can. It is not meant to have 
anything to do with groups, and expanding its scope is a really really 
terrible idea.

I finally now have some time to work on IOMMU gubbins again, so I'll be 
updating the bus ops removal series ASAP, then the next step after that 
is some bus_type callback surgery to pull the 
{of,acpi}_iommu_configure() parsing and ops->of_xlate calls to the 
proper point in the core iommu_probe_device() path, and all this mess 
finally goes away for good.

Thanks,
Robin.

> Rename iommu_probe_device_lock to dev_iommu_group_lock, make it local to
> the module and annotate all the device_group helpers with
> iommu_group_get_locked() that includes a lockdep to indicate that they are
> special.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/iommu/iommu.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 409090eaac543a..f1c8a333553e3b 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -44,6 +44,8 @@ static unsigned int iommu_def_domain_type __read_mostly;
>   static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
>   static u32 iommu_cmd_line __read_mostly;
>   
> +static DEFINE_MUTEX(dev_iommu_group_lock);
> +
>   struct iommu_group {
>   	struct kobject kobj;
>   	struct kobject *devices_kobj;
> @@ -438,7 +440,6 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
>   	struct iommu_group *group;
> -	static DEFINE_MUTEX(iommu_probe_device_lock);
>   	struct group_device *gdev;
>   	int ret;
>   
> @@ -451,7 +452,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	 * probably be able to use device_lock() here to minimise the scope,
>   	 * but for now enforcing a simple global ordering is fine.
>   	 */
> -	mutex_lock(&iommu_probe_device_lock);
> +	mutex_lock(&dev_iommu_group_lock);
>   
>   	/* Device is probed already if in a group */
>   	if (dev->iommu_group) {
> @@ -497,7 +498,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   			list_add_tail(&group->entry, group_list);
>   	}
>   	mutex_unlock(&group->mutex);
> -	mutex_unlock(&iommu_probe_device_lock);
> +	mutex_unlock(&dev_iommu_group_lock);
>   
>   	if (dev_is_pci(dev))
>   		iommu_dma_set_pci_32bit_workaround(dev);
> @@ -512,7 +513,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	mutex_unlock(&group->mutex);
>   	iommu_group_put(group);
>   out_unlock:
> -	mutex_unlock(&iommu_probe_device_lock);
> +	mutex_unlock(&dev_iommu_group_lock);
>   
>   	return ret;
>   }
> @@ -1219,6 +1220,12 @@ struct iommu_group *iommu_group_get(struct device *dev)
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_get);
>   
> +static struct iommu_group *iommu_group_get_locked(struct device *dev)
> +{
> +	lockdep_assert_held(&dev_iommu_group_lock);
> +	return iommu_group_get(dev);
> +}
> +
>   /**
>    * iommu_group_ref_get - Increment reference on a group
>    * @group: the group to use, must not be NULL
> @@ -1532,7 +1539,7 @@ static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>   	if (test_and_set_bit(pdev->devfn & 0xff, devfns))
>   		return NULL;
>   
> -	group = iommu_group_get(&pdev->dev);
> +	group = iommu_group_get_locked(&pdev->dev);
>   	if (group)
>   		return group;
>   
> @@ -1573,7 +1580,7 @@ static int get_pci_alias_or_group(struct pci_dev *pdev, u16 alias, void *opaque)
>   	struct group_for_pci_data *data = opaque;
>   
>   	data->pdev = pdev;
> -	data->group = iommu_group_get(&pdev->dev);
> +	data->group = iommu_group_get_locked(&pdev->dev);
>   
>   	return data->group != NULL;
>   }
> @@ -1629,7 +1636,7 @@ struct iommu_group *pci_device_group(struct device *dev)
>   
>   		pdev = bus->self;
>   
> -		group = iommu_group_get(&pdev->dev);
> +		group = iommu_group_get_locked(&pdev->dev);
>   		if (group)
>   			return group;
>   	}
> @@ -1662,7 +1669,7 @@ struct iommu_group *fsl_mc_device_group(struct device *dev)
>   	struct device *cont_dev = fsl_mc_cont_dev(dev);
>   	struct iommu_group *group;
>   
> -	group = iommu_group_get(cont_dev);
> +	group = iommu_group_get_locked(cont_dev);
>   	if (!group)
>   		group = iommu_group_alloc();
>   	return group;
