From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v6 7/7] iommu/dma: Add bootup option "iommu.non_strict"
Date: Thu, 13 Sep 2018 17:42:24 +0100
Message-ID: <94fe2e15d36565e13218b007b9d5d9d08f190e5e.1536856828.git.robin.murphy@arm.com>
References: <cover.1536856828.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1536856828.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a bootup option to make the system manager can choose which mode to
be used. The default mode is strict.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: make it a generic iommu-dma feature]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../admin-guide/kernel-parameters.txt          | 13 +++++++++++++
 drivers/iommu/dma-iommu.c                      | 18 ++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..406b91759b62 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1749,6 +1749,19 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.non_strict=	[ARM64]
+			Format: { "0" | "1" }
+			0 - strict mode, default.
+			    Release IOVAs after the related TLBs are invalid
+			    completely.
+			1 - non-strict mode.
+			    Put off TLBs invalidation and release memory first.
+			    It's good for scatter-gather performance but lacks
+			    full isolation, an untrusted device can access the
+			    reused memory because the TLBs may still valid.
+			    Please take	full consideration before choosing this
+			    mode. Note that, VFIO will always use strict mode.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index d91849fe4ebe..04d4c5453acd 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -62,6 +62,24 @@ struct iommu_dma_cookie {
 
 static bool iommu_dma_non_strict __read_mostly;
 
+static int __init iommu_dma_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &iommu_dma_non_strict);
+	if (ret)
+		return ret;
+
+	if (iommu_dma_non_strict) {
+		pr_warn("WARNING: iommu non-strict mode is chosen.\n"
+			"It's good for scatter-gather performance but lacks full isolation\n");
+		add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
+	}
+
+	return 0;
+}
+early_param("iommu.non_strict", iommu_dma_setup);
+
 static inline size_t cookie_msi_granule(struct iommu_dma_cookie *cookie)
 {
 	if (cookie->type == IOMMU_DMA_IOVA_COOKIE)
-- 
2.19.0.dirty
