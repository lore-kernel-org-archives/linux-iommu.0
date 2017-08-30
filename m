From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] iommu/tegra: Add support for struct iommu_device
Date: Wed, 30 Aug 2017 17:30:34 +0200
Message-ID: <20170830153034.GK19533@8bytes.org>
References: <1502317752-8792-1-git-send-email-joro@8bytes.org>
	<1502317752-8792-2-git-send-email-joro@8bytes.org>
	<f857ad53-66ca-0aa9-947a-f517443d114d@nvidia.com>
	<20170830120902.kqtxh2ls4ob7xpwy@8bytes.org>
	<c6ee1ce0-7193-be63-c84d-73795c727d26@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c6ee1ce0-7193-be63-c84d-73795c727d26-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hiroshi Doyu <hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jon,

On Wed, Aug 30, 2017 at 03:22:05PM +0100, Jon Hunter wrote:
> Yes I can confirm that this fixes the crash. I assume that you will fix
> the error path for bus_set_iommu() above as I believe now it needs to
> call iommu_device_sysfs_remove().

Thanks for testing the patch. I updated the error-path and put the
commit below into the iommu-tree:

>From 96302d89a03524e04d46ec82c6730881bb755923 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 30 Aug 2017 15:06:43 +0200
Subject: [PATCH] arm/tegra: Call bus_set_iommu() after iommu_device_register()

The bus_set_iommu() function will call the add_device()
call-back which needs the iommu to be registered.

Reported-by: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Fixes: 0b480e447006 ('iommu/tegra: Add support for struct iommu_device')
Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
---
 drivers/iommu/tegra-smmu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 2802e12e6a54..3b6449e2cbf1 100644
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
@@ -965,6 +961,13 @@ struct tegra_smmu *tegra_smmu_probe(struct device *dev,
 		return ERR_PTR(err);
 	}
 
+	err = bus_set_iommu(&platform_bus_type, &tegra_smmu_ops);
+	if (err < 0) {
+		iommu_device_unregister(&smmu->iommu);
+		iommu_device_sysfs_remove(&smmu->iommu);
+		return ERR_PTR(err);
+	}
+
 	if (IS_ENABLED(CONFIG_DEBUG_FS))
 		tegra_smmu_debugfs_init(smmu);
 
-- 
2.13.5
