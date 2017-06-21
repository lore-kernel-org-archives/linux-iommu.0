From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [RESEND PATCH 4/4] iommu: qcom: initialize secure page table
Date: Wed, 21 Jun 2017 08:04:06 -0400
Message-ID: <20170621120406.2053-5-robdclark@gmail.com>
References: <20170621120406.2053-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170621120406.2053-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

This basically gets the secure page table size, allocates memory for
secure pagetables and passes the physical address to the trusted zone.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/iommu/qcom_iommu.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
index 860cad1..48b62aa 100644
--- a/drivers/iommu/qcom_iommu.c
+++ b/drivers/iommu/qcom_iommu.c
@@ -604,6 +604,51 @@ static void qcom_iommu_disable_clocks(struct qcom_iommu_dev *qcom_iommu)
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
@@ -700,6 +745,17 @@ static struct platform_driver qcom_iommu_ctx_driver = {
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
@@ -744,6 +800,14 @@ static int qcom_iommu_device_probe(struct platform_device *pdev)
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
