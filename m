From: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
Subject: [RFC PATCH v5 1/5] iommu: Add capabilities to a group
Date: Mon,  7 Aug 2017 17:25:44 +1000
Message-ID: <20170807072548.3023-2-aik@ozlabs.ru>
References: <20170807072548.3023-1-aik@ozlabs.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170807072548.3023-1-aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Kyle Mahlkuch <Kyle.Mahlkuch-qyM6JfAXOaQ@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, kvm-ppc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>, Yongji Xie <elohimes-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mauricio Faria de Oliveira <mauricfo-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Vlad Tsyrklevich <vlad-NIZqynvkaCU43zv7NVfAiQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

This introduces capabilities to IOMMU groups. The first defined
capability is IOMMU_GROUP_CAP_ISOLATE_MSIX which tells the IOMMU
group users that a particular IOMMU group is capable of MSIX message
filtering; this is useful when deciding whether or not to allow mapping
of MSIX table to the userspace. Various architectures will enable it
when they decide that it is safe to do so.

Signed-off-by: Alexey Kardashevskiy <aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org>
---
 include/linux/iommu.h | 20 ++++++++++++++++++++
 drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 2cb54adc4a33..6b6f3c2f4904 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -155,6 +155,9 @@ struct iommu_resv_region {
 	enum iommu_resv_type	type;
 };
 
+/* IOMMU group capabilities */
+#define IOMMU_GROUP_CAP_ISOLATE_MSIX		(1U)
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -312,6 +315,11 @@ extern void *iommu_group_get_iommudata(struct iommu_group *group);
 extern void iommu_group_set_iommudata(struct iommu_group *group,
 				      void *iommu_data,
 				      void (*release)(void *iommu_data));
+extern void iommu_group_set_caps(struct iommu_group *group,
+				 unsigned long clearcaps,
+				 unsigned long setcaps);
+extern bool iommu_group_is_capable(struct iommu_group *group,
+				   unsigned long cap);
 extern int iommu_group_set_name(struct iommu_group *group, const char *name);
 extern int iommu_group_add_device(struct iommu_group *group,
 				  struct device *dev);
@@ -513,6 +521,18 @@ static inline void iommu_group_set_iommudata(struct iommu_group *group,
 {
 }
 
+static inline void iommu_group_set_caps(struct iommu_group *group,
+					unsigned long clearcaps,
+					unsigned long setcaps)
+{
+}
+
+static inline bool iommu_group_is_capable(struct iommu_group *group,
+					  unsigned long cap)
+{
+	return false;
+}
+
 static inline int iommu_group_set_name(struct iommu_group *group,
 				       const char *name)
 {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3f6ea160afed..6b2c34fe2c3d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -52,6 +52,7 @@ struct iommu_group {
 	void (*iommu_data_release)(void *iommu_data);
 	char *name;
 	int id;
+	unsigned long caps;
 	struct iommu_domain *default_domain;
 	struct iommu_domain *domain;
 };
@@ -447,6 +448,33 @@ void iommu_group_set_iommudata(struct iommu_group *group, void *iommu_data,
 EXPORT_SYMBOL_GPL(iommu_group_set_iommudata);
 
 /**
+ * iommu_group_set_caps - Change the group capabilities
+ * @group: the group
+ * @clearcaps: capabilities mask to remove
+ * @setcaps: capabilities mask to add
+ *
+ * IOMMU groups can be capable of various features which device drivers
+ * may read and adjust the behavior.
+ */
+void iommu_group_set_caps(struct iommu_group *group,
+		unsigned long clearcaps, unsigned long setcaps)
+{
+	group->caps &= ~clearcaps;
+	group->caps |= setcaps;
+}
+EXPORT_SYMBOL_GPL(iommu_group_set_caps);
+
+/**
+ * iommu_group_is_capable - Returns if a group capability is present
+ * @group: the group
+ */
+bool iommu_group_is_capable(struct iommu_group *group, unsigned long cap)
+{
+	return !!(group->caps & cap);
+}
+EXPORT_SYMBOL_GPL(iommu_group_is_capable);
+
+/**
  * iommu_group_set_name - set name for a group
  * @group: the group
  * @name: name
-- 
2.11.0
