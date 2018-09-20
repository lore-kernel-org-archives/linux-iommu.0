From: Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v8 3/7] iommu: Add "iommu.strict" command line option
Date: Thu, 20 Sep 2018 17:10:23 +0100
Message-ID: <799fad801970298385af3abc8ca82620ad62c000.1537458163.git.robin.murphy@arm.com>
References: <cover.1537458163.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537458163.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: joro@8bytes.org, will.deacon@arm.com, thunder.leizhen@huawei.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linuxarm@huawei.com, guohanjun@huawei.com, huawei.libin@huawei.com, john.garry@huawei.com
List-Id: iommu@lists.linux-foundation.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Add a generic command line option to enable lazy unmapping via IOVA
flush queues, which will initally be suuported by iommu-dma. This echoes
the semantics of "intel_iommu=strict" (albeit with the opposite default
value), but in the driver-agnostic fashion of "iommu.passthrough".

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[rm: move handling out of SMMUv3 driver, clean up documentation]
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

v8:
 - Rename "non-strict" to "strict" to better match existing options
 - Rewrite doc text/commit message
 - Downgrade boot-time message from warn/taint to info

 .../admin-guide/kernel-parameters.txt         | 12 ++++++++++
 drivers/iommu/iommu.c                         | 23 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..92ae12aeabf4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1749,6 +1749,18 @@
 		nobypass	[PPC/POWERNV]
 			Disable IOMMU bypass, using IOMMU for PCI devices.
 
+	iommu.strict=	[ARM64] Configure TLB invalidation behaviour
+			Format: { "0" | "1" }
+			0 - Lazy mode.
+			  Request that DMA unmap operations use deferred
+			  invalidation of hardware TLBs, for increased
+			  throughput at the cost of reduced device isolation.
+			  Will fall back to strict mode if not supported by
+			  the relevant IOMMU driver.
+			1 - Strict mode (default).
+			  DMA unmap operations invalidate IOMMU hardware TLBs
+			  synchronously.
+
 	iommu.passthrough=
 			[ARM64] Configure DMA to bypass the IOMMU by default.
 			Format: { "0" | "1" }
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 8c15c5980299..02b6603f0616 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -41,6 +41,7 @@ static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_IDENTITY;
 #else
 static unsigned int iommu_def_domain_type = IOMMU_DOMAIN_DMA;
 #endif
+static bool iommu_dma_strict __read_mostly = true;
 
 struct iommu_callback_data {
 	const struct iommu_ops *ops;
@@ -131,6 +132,21 @@ static int __init iommu_set_def_domain_type(char *str)
 }
 early_param("iommu.passthrough", iommu_set_def_domain_type);
 
+static int __init iommu_dma_setup(char *str)
+{
+	int ret;
+
+	ret = kstrtobool(str, &iommu_dma_strict);
+	if (ret)
+		return ret;
+
+	if (!iommu_dma_strict)
+		pr_info("Enabling deferred TLB invalidation for DMA; protection against malicious/malfunctioning devices may be reduced.\n");
+
+	return 0;
+}
+early_param("iommu.strict", iommu_dma_setup);
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1072,6 +1088,13 @@ struct iommu_group *iommu_group_get_for_dev(struct device *dev)
 		group->default_domain = dom;
 		if (!group->domain)
 			group->domain = dom;
+
+		if (dom && !iommu_dma_strict) {
+			int attr = 1;
+			iommu_domain_set_attr(dom,
+					      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
+					      &attr);
+		}
 	}
 
 	ret = iommu_group_add_device(group, dev);
-- 
2.19.0.dirty
