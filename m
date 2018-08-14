From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 2/5] firmware/qcom_scm: Add atomic version of io read/write
	APIs
Date: Tue, 14 Aug 2018 16:25:25 +0530
Message-ID: <20180814105528.20592-3-vivek.gautam@codeaurora.org>
References: <20180814105528.20592-1-vivek.gautam@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180814105528.20592-1-vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Add atomic versions of qcom_scm_io_readl/writel to enable
reading/writing secure registers from atomic context.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/firmware/qcom_scm-32.c | 12 ++++++++++++
 drivers/firmware/qcom_scm-64.c | 32 ++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.c    | 12 ++++++++++++
 drivers/firmware/qcom_scm.h    |  4 ++++
 include/linux/qcom_scm.h       |  4 ++++
 5 files changed, 64 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 4e24e591ae74..7293e5efad69 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -627,3 +627,15 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	return qcom_scm_call_atomic2(QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 				     addr, val);
 }
+
+int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+			       unsigned int *val)
+{
+	return -ENODEV;
+}
+
+int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				unsigned int val)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 3a8c867cdf51..6bf55403f6e3 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -558,3 +558,35 @@ int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val)
 	return qcom_scm_call(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 			     &desc, &res);
 }
+
+int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+			       unsigned int *val)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	desc.args[0] = addr;
+	desc.arginfo = QCOM_SCM_ARGS(1);
+
+	ret = qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_READ,
+				   &desc, &res);
+	if (ret >= 0)
+		*val = res.a1;
+
+	return ret < 0 ? ret : 0;
+}
+
+int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				unsigned int val)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+
+	desc.args[0] = addr;
+	desc.args[1] = val;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
+				    &desc, &res);
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index e778af766fae..36da0000b37f 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -365,6 +365,18 @@ int qcom_scm_io_writel(phys_addr_t addr, unsigned int val)
 }
 EXPORT_SYMBOL(qcom_scm_io_writel);
 
+int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val)
+{
+	return __qcom_scm_io_readl_atomic(__scm->dev, addr, val);
+}
+EXPORT_SYMBOL(qcom_scm_io_readl_atomic);
+
+int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val)
+{
+	return __qcom_scm_io_writel_atomic(__scm->dev, addr, val);
+}
+EXPORT_SYMBOL(qcom_scm_io_writel_atomic);
+
 static void qcom_scm_set_download_mode(bool enable)
 {
 	bool avail;
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index dcd7f7917fc7..bb176107f51e 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -37,6 +37,10 @@ extern void __qcom_scm_cpu_power_down(u32 flags);
 #define QCOM_SCM_IO_WRITE		0x2
 extern int __qcom_scm_io_readl(struct device *dev, phys_addr_t addr, unsigned int *val);
 extern int __qcom_scm_io_writel(struct device *dev, phys_addr_t addr, unsigned int val);
+extern int __qcom_scm_io_readl_atomic(struct device *dev, phys_addr_t addr,
+				      unsigned int *val);
+extern int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
+				       unsigned int val);
 
 #define QCOM_SCM_SVC_INFO		0x6
 #define QCOM_IS_CALL_AVAIL_CMD		0x1
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 5d65521260b3..6a5d0c98b328 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -64,6 +64,8 @@ extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
+extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
+extern int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val);
 #else
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
@@ -100,5 +102,7 @@ static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { ret
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
 static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
+static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
+static inline int qcom_scm_io_writel_atomic(phys_addr_t addr, unsigned int val) { return -ENODEV; }
 #endif
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
