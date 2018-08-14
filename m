From: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH 3/5] firmware/qcom_scm: Add scm call to handle smmu errata
Date: Tue, 14 Aug 2018 16:25:26 +0530
Message-ID: <20180814105528.20592-4-vivek.gautam@codeaurora.org>
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

Qcom's smmu-500 needs to toggle wait-for-safe sequence to
handle TLB invalidation sync's.
Few firmwares allow doing that through SCM interface.
Add API to toggle wait for safe from firmware through a
SCM call.

Signed-off-by: Vivek Gautam <vivek.gautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 drivers/firmware/qcom_scm-32.c |  5 +++++
 drivers/firmware/qcom_scm-64.c | 13 +++++++++++++
 drivers/firmware/qcom_scm.c    |  6 ++++++
 drivers/firmware/qcom_scm.h    |  5 +++++
 include/linux/qcom_scm.h       |  2 ++
 5 files changed, 31 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 7293e5efad69..2d301ad053f8 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -639,3 +639,8 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
 {
 	return -ENODEV;
 }
+
+int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool enable)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 6bf55403f6e3..f13bcabc5d78 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -590,3 +590,16 @@ int __qcom_scm_io_writel_atomic(struct device *dev, phys_addr_t addr,
 	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_IO, QCOM_SCM_IO_WRITE,
 				    &desc, &res);
 }
+
+int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev, bool en)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+
+	desc.args[0] = QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL;
+	desc.args[1] = en;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	return qcom_scm_call_atomic(dev, QCOM_SCM_SVC_SMMU_PROGRAM,
+				    QCOM_SCM_CONFIG_ERRATA1, &desc, &res);
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 36da0000b37f..5f15cc2e9f69 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -353,6 +353,12 @@ int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
 }
 EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
 
+int qcom_scm_qsmmu500_wait_safe_toggle(bool en)
+{
+	return __qcom_scm_qsmmu500_wait_safe_toggle(__scm->dev, en);
+}
+EXPORT_SYMBOL(qcom_scm_qsmmu500_wait_safe_toggle);
+
 int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val)
 {
 	return __qcom_scm_io_readl(__scm->dev, addr, val);
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index bb176107f51e..89a822c23e33 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -103,10 +103,15 @@ extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 				      u32 spare);
 #define QCOM_SCM_IOMMU_SECURE_PTBL_SIZE	3
 #define QCOM_SCM_IOMMU_SECURE_PTBL_INIT	4
+#define QCOM_SCM_SVC_SMMU_PROGRAM	0x15
+#define QCOM_SCM_CONFIG_ERRATA1		0x3
+#define QCOM_SCM_CONFIG_ERRATA1_CLIENT_ALL	0x2
 extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
 					     size_t *size);
 extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
 					     u32 size, u32 spare);
+extern int __qcom_scm_qsmmu500_wait_safe_toggle(struct device *dev,
+						bool enable);
 #define QCOM_MEM_PROT_ASSIGN_ID	0x16
 extern int  __qcom_scm_assign_mem(struct device *dev,
 				  phys_addr_t mem_region, size_t mem_sz,
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 6a5d0c98b328..46e6b1692998 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -62,6 +62,7 @@ extern int qcom_scm_set_remote_state(u32 state, u32 id);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
 extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
+extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
 extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
 extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
 extern int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val);
@@ -100,6 +101,7 @@ qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
 static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
 static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
+static inline int qcom_scm_qsmmu500_wait_safe_toggle(bool en) { return -ENODEV; }
 static inline int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
 static inline int qcom_scm_io_writel(phys_addr_t addr, unsigned int val) { return -ENODEV; }
 static inline int qcom_scm_io_readl_atomic(phys_addr_t addr, unsigned int *val) { return -ENODEV; }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
