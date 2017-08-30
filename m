From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Wed, 30 Aug 2017 14:09:03 +0200
Message-ID: <20170830120902.kqtxh2ls4ob7xpwy@8bytes.org>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
 <1502317752-8792-2-git-send-email-joro@8bytes.org>
 <f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Hiroshi Doyu <hdoyu@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux-foundation.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
List-Id: iommu@lists.linux-foundation.org

Hi Jon,

On Wed, Aug 30, 2017 at 12:04:38PM +0100, Jon Hunter wrote:
> With next-20170829 I am seeing several Tegra boards crashing [0][1] on
> boot in tegra_smmu_probe() and the bisect is point to this commit. Looks
> like there maybe a sequence problem between calls to bus_set_iommu() and
> iommu_device_add_sysfs() which results in a NULL pointer dereference.

Thanks for the report. Can you please test whether the patch below
fixes the problem?

Thanks,

	Joerg

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2802e12e6a54..48ffbe95a663 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -949,10 +949,6 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 
 	tegra_smmu_ahb_enable();
 
-	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
-	if (err < 0)
-		return ERR_PTR(err);
-
 	err = iommu_device_sysfs_add(&smmu->iommu, dev, NULL, dev_name(dev));
 	if (err)
 		return ERR_PTR(err);
@@ -965,6 +961,10 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 	}
 
+	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
+	if (err < 0)
+		return ERR_PTR(err);
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
