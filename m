From: Rob Clark <robdclark@gmail.com>
Subject: [PATCH 4/4] iommu: qcom: initialize secure page table
Date: Mon, 26 Jun 2017 08:43:52 -0400
Message-ID: <20170626124352.21726-5-robdclark@gmail.com>
References: <20170626124352.21726-1-robdclark@gmail.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20170626124352.21726-1-robdclark@gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arm-msm@vger.kernel.org, Archit Taneja <architt@codeaurora.org>, Rob Herring <robh@kernel.org>, Will Deacon <will.deacon@arm.com>, Sricharan <sricharan@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, Rob Clark <robdclark@gmail.com>
List-Id: iommu@lists.linux-foundation.org

From: Stanimir Varbanov <stanimir.varbanov@linaro.org>

This basically gets the secure page table size, allocates memory for
secure pagetables and passes the physical address to the trusted zone.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
---
 drivers/iommu/qcom_iommu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 33e984e..438f38a 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -593,6 +593,51 @@ static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
 	clk_disable_unprepare(qcom_iommu->iface_clk);
 }
 
+static int qcom_iommu_sec_ptbl_init(struct device *dev)
+{
+	size_t psize = 0;
+	unsigned int spare = 0;
+	void *cpu_addr;
+	dma_addr_t paddr;
+	unsigned long attrs;
+	static bool allocated = false;
+	int ret;
+
+	if (allocated)
+		return 0;
+
+	ret = qcom_scm_iommu_secure_ptbl_size(spare, &psize);
+	if (ret) {
+		dev_err(dev, "failed to get iommu secure pgtable size (%d)\n",
+			ret);
+		return ret;
+	}
+
+	dev_info(dev, "iommu sec: pgtable size: %zu\n", psize);
+
+	attrs = DMA_ATTR_NO_KERNEL_MAPPING;
+
+	cpu_addr = dma_alloc_attrs(dev, psize, &paddr, GFP_KERNEL, attrs);
+	if (!cpu_addr) {
+		dev_err(dev, "failed to allocate %zu bytes for pgtable\n",
+			psize);
+		return -ENOMEM;
+	}
+
+	ret = qcom_scm_iommu_secure_ptbl_init(paddr, psize, spare);
+	if (ret) {
+		dev_err(dev, "failed to init iommu pgtable (%d)\n", ret);
+		goto free_mem;
+	}
+
+	allocated = true;
+	return 0;
+
+free_mem:
+	dma_free_attrs(dev, psize, cpu_addr, paddr, attrs);
+	return ret;
+}
+
 static int get_asid(const struct device_node *np)
 {
 	u32 reg;
@@ -689,6 +734,17 @@ static struct platform_driver qcom_iommu_ctx_driver = {
 	.remove = qcom_iommu_ctx_remove,
 };
 
+static bool qcom_iommu_has_secure_context(struct qcom_iommu_dev *qcom_iommu)
+{
+	struct device_node *child;
+
+	for_each_child_of_node(qcom_iommu->dev->of_node, child)
+		if (of_device_is_compatible(child, "qcom,msm-iommu-v1-sec"))
+			return true;
+
+	return false;
+}
+
 static int qcom_iommu_device_probe(struct platform_device *pdev)
 {
 	struct device_node *child;
@@ -733,6 +789,14 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (qcom_iommu_has_secure_context(qcom_iommu)) {
+		ret = qcom_iommu_sec_ptbl_init(dev);
+		if (ret) {
+			dev_err(dev, "cannot init secure pg table(%d)\n", ret);
+			return ret;
+		}
+	}
+
 	platform_set_drvdata(pdev, qcom_iommu);
 
 	pm_runtime_enable(dev);
-- 
2.9.4
