From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Wed, 30 Aug 2017 12:04:38 +0100
Message-ID: <f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-2-git-send-email-joro@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502317752-8792-2-git-send-email-joro@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org


On 09/08/17 23:29, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Add a struct iommu_device to each tegra-smmu and register it
> with the iommu-core. Also link devices added to the driver
> to their respective hardware iommus.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/tegra-smmu.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
> index faa9c1e..2802e12 100644
> --- a/drivers/iommu/tegra-smmu.c
> +++ b/drivers/iommu/tegra-smmu.c
> @@ -36,6 +36,8 @@ struct tegra_smmu {
>  	struct list_head list;
>  
>  	struct dentry *debugfs;
> +
> +	struct iommu_device iommu;	/* IOMMU Core code handle */
>  };
>  
>  struct tegra_smmu_as {
> @@ -720,6 +722,9 @@ static int tegra_smmu_add_device(struct device *dev)
>  			 * first match.
>  			 */
>  			dev->archdata.iommu = smmu;
> +
> +			iommu_device_link(&smmu->iommu, dev);
> +
>  			break;
>  		}
>  
> @@ -737,6 +742,11 @@ static int tegra_smmu_add_device(struct device *dev)
>  
>  static void tegra_smmu_remove_device(struct device *dev)
>  {
> +	struct tegra_smmu *smmu = dev->archdata.iommu;
> +
> +	if (smmu)
> +		iommu_device_unlink(&smmu->iommu, dev);
> +
>  	dev->archdata.iommu = NULL;
>  	iommu_group_remove_device(dev);
>  }
> @@ -943,6 +953,18 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>  	if (err < 0)
>  		return ERR_PTR(err);
>  
> +	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, dev_name(dev));
> +	if (err)
> +		return ERR_PTR(err);
> +
> +	iommu_device_set_ops(&smmu->iommu, &tegra_smmu_ops);
> +
> +	err = iommu_device_register(&smmu->iommu);
> +	if (err) {
> +		iommu_device_sysfs_remove(&smmu->iommu);
> +		return ERR_PTR(err);
> +	}
> +
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_smmu_debugfs_init(smmu);
>  
> @@ -951,6 +973,9 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>  
>  void tegra_smmu_remove(struct tegra_smmu *smmu)
>  {
> +	iommu_device_unregister(&smmu->iommu);
> +	iommu_device_sysfs_remove(&smmu->iommu);
> +
>  	if (IS_ENABLED(CONFIG_DEBUG_FS))
>  		tegra_smmu_debugfs_exit(smmu);
>  }
> 

With next-20170829 I am seeing several Tegra boards crashing [0][1] on
boot in tegra_smmu_probe() and the bisect is point to this commit. Looks
like there maybe a sequence problem between calls to bus_set_iommu() and
iommu_device_add_sysfs() which results in a NULL pointer dereference.

You can see the full crash log here [1].

Cheers
Jon

[0] https://nvtb.github.io//linux-next/
[1]
https://nvtb.github.io//linux-next/test_next-20170829/20170829024534/boot/tegra124-jetson-tk1/tegra124-jetson-tk1/tegra_defconfig_log.txt
