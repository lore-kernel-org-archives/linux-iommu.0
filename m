From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/9] firmware: qcom_scm: add two scm calls for iommu secure
	page table
Date: Tue, 14 Mar 2017 11:18:04 -0400
Message-ID: <20170314151811.17234-3-robdclark@gmail.com>
References: <20170314151811.17234-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170314151811.17234-1-robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Those two new SCM calls are needed from qcom-iommu driver in order
to initialize secure iommu page table.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/firmware/qcom_scm-32.c | 12 ++++++++++++
 drivers/firmware/qcom_scm-64.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 drivers/firmware/qcom_scm.c    | 12 ++++++++++++
 drivers/firmware/qcom_scm.h    |  6 ++++++
 include/linux/qcom_scm.h       |  4 ++++
 5 files changed, 76 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 722e65a..93e3b96 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -584,3 +584,15 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 {
 	return -ENODEV;
 }
+
+int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
+				      size_t *size)
+{
+	return -ENODEV;
+}
+
+int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
+				      u32 spare)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index 550e3a3..6e6d561 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -397,3 +397,45 @@ int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
 
 	return ret ? : res.a1;
 }
+
+int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
+				      size_t *size)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	desc.args[0] = spare;
+	desc.arginfo = QCOM_SCM_ARGS(1);
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+			    QCOM_SCM_IOMMU_SECURE_PTBL_SIZE, &desc, &res);
+
+	if (size)
+		*size = res.a1;
+
+	return ret ? : res.a2;
+}
+
+int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr, u32 size,
+				      u32 spare)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	desc.args[0] = addr;
+	desc.args[1] = size;
+	desc.args[2] = spare;
+	desc.arginfo = QCOM_SCM_ARGS(3, QCOM_SCM_RW, QCOM_SCM_VAL,
+				     QCOM_SCM_VAL);
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP,
+			    QCOM_SCM_IOMMU_SECURE_PTBL_INIT, &desc, &res);
+
+	/* the pg table has been initialized already, ignore the error */
+	if (ret == -EPERM)
+		ret = 0;
+
+	return ret;
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index ae1f473..bb16510 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -321,6 +321,18 @@ int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
 }
 EXPORT_SYMBOL(qcom_scm_restore_sec_cfg);
 
+int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size)
+{
+	return __qcom_scm_iommu_secure_ptbl_size(__scm->dev, spare, size);
+}
+EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_size);
+
+int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare)
+{
+	return __qcom_scm_iommu_secure_ptbl_init(__scm->dev, addr, size, spare);
+}
+EXPORT_SYMBOL(qcom_scm_iommu_secure_ptbl_init);
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 31fc732..9bea691 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -89,5 +89,11 @@ static inline int qcom_scm_remap_error(int err)
 #define QCOM_SCM_RESTORE_SEC_CFG	2
 extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
 				      u32 spare);
+#define QCOM_SCM_IOMMU_SECURE_PTBL_SIZE	3
+#define QCOM_SCM_IOMMU_SECURE_PTBL_INIT	4
+extern int __qcom_scm_iommu_secure_ptbl_size(struct device *dev, u32 spare,
+					     size_t *size);
+extern int __qcom_scm_iommu_secure_ptbl_init(struct device *dev, u64 addr,
+					     u32 size, u32 spare);
 
 #endif
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index 22017f5d..e538047 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -41,6 +41,8 @@ extern void qcom_scm_cpu_power_down(u32 flags);
 extern u32 qcom_scm_get_version(void);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
+extern int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size);
+extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
 #else
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
@@ -69,5 +71,7 @@ static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
 qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
 static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
+static inline int qcom_scm_iommu_secure_ptbl_size(u32 spare, size_t *size) { return -ENODEV; }
+static inline int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare) { return -ENODEV; }
 #endif
 #endif
-- 
2.9.3
