From: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] firmware/qcom: add qcom_scm_restore_sec_cfg()
Date: Fri, 10 Feb 2017 13:41:53 -0500
Message-ID: <20170210184154.20193-1-robdclark@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Signed-off-by: Rob Clark <robdclark-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/firmware/qcom_scm-32.c |  6 ++++++
 drivers/firmware/qcom_scm-64.c | 16 ++++++++++++++++
 drivers/firmware/qcom_scm.c    |  6 ++++++
 drivers/firmware/qcom_scm.h    |  5 +++++
 include/linux/qcom_scm.h       |  2 ++
 5 files changed, 35 insertions(+)

diff --git a/drivers/firmware/qcom_scm-32.c b/drivers/firmware/qcom_scm-32.c
index 8ad226c..722e65a 100644
--- a/drivers/firmware/qcom_scm-32.c
+++ b/drivers/firmware/qcom_scm-32.c
@@ -578,3 +578,9 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 
 	return ret ? : le32_to_cpu(scm_ret);
 }
+
+int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
+			       u32 spare)
+{
+	return -ENODEV;
+}
diff --git a/drivers/firmware/qcom_scm-64.c b/drivers/firmware/qcom_scm-64.c
index c933259..550e3a3 100644
--- a/drivers/firmware/qcom_scm-64.c
+++ b/drivers/firmware/qcom_scm-64.c
@@ -381,3 +381,19 @@ int __qcom_scm_set_remote_state(struct device *dev, u32 state, u32 id)
 
 	return ret ? : res.a1;
 }
+
+int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id, u32 spare)
+{
+	struct qcom_scm_desc desc = {0};
+	struct arm_smccc_res res;
+	int ret;
+
+	desc.args[0] = device_id;
+	desc.args[1] = spare;
+	desc.arginfo = QCOM_SCM_ARGS(2);
+
+	ret = qcom_scm_call(dev, QCOM_SCM_SVC_MP, QCOM_SCM_RESTORE_SEC_CFG,
+			    &desc, &res);
+
+	return ret ? : res.a1;
+}
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index d987bcc..ae1f473 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -315,6 +315,12 @@ static const struct reset_control_ops qcom_scm_pas_reset_ops = {
 	.deassert = qcom_scm_pas_reset_deassert,
 };
 
+int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare)
+{
+	return __qcom_scm_restore_sec_cfg(__scm->dev, device_id, spare);
+}
+EXPORT_SYMBOL(qcom_scm_restore_sec_cfg);
+
 /**
  * qcom_scm_is_available() - Checks if SCM is available
  */
diff --git a/drivers/firmware/qcom_scm.h b/drivers/firmware/qcom_scm.h
index 6a0f154..31fc732 100644
--- a/drivers/firmware/qcom_scm.h
+++ b/drivers/firmware/qcom_scm.h
@@ -85,4 +85,9 @@ static inline int qcom_scm_remap_error(int err)
 	return -EINVAL;
 }
 
+#define QCOM_SCM_SVC_MP			0xc
+#define QCOM_SCM_RESTORE_SEC_CFG	2
+extern int __qcom_scm_restore_sec_cfg(struct device *dev, u32 device_id,
+				      u32 spare);
+
 #endif
diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
index d32f6f1..22017f5d 100644
--- a/include/linux/qcom_scm.h
+++ b/include/linux/qcom_scm.h
@@ -40,6 +40,7 @@ extern int qcom_scm_pas_shutdown(u32 peripheral);
 extern void qcom_scm_cpu_power_down(u32 flags);
 extern u32 qcom_scm_get_version(void);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
+extern int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare);
 #else
 static inline
 int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
@@ -67,5 +68,6 @@ static inline void qcom_scm_cpu_power_down(u32 flags) {}
 static inline u32 qcom_scm_get_version(void) { return 0; }
 static inline u32
 qcom_scm_set_remote_state(u32 state,u32 id) { return -ENODEV; }
+static inline int qcom_scm_restore_sec_cfg(u32 device_id, u32 spare) { return -ENODEV; }
 #endif
 #endif
-- 
2.9.3
