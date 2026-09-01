Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DEC391825
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271696; cv=none; b=UDam5qbIf9B8bhZXu1CsHuKWRrD+QcYd3cADSY4jeAMh8xKGB6hADdmq57MQcN7ViPZU5rd65TCMwY/AfA1+lQ61LxyxnJ3/kFfy74cuNwy5XQGkQoGT8jg1j3va+BDUaowQdyrpO45CWMwe0i1NFlm4/H+Exxw7de3zknws77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271696; c=relaxed/simple;
	bh=TnCoyEPhflrK5LKmevmWm/BatjsrXGYILgkXMUkEwZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZfWv/cNf5cr9+cbh/lg7jmf1HqMFqZW7VQ/vI+HsC8P0jf58lkrNsuJnoPsM3Egk9biDrIjo2c9fFZNgZbhvmjFBVpfzB6IoodrABmV6rG8ifZ0Y9hxETSgG+EbRR2BMHcARiaZdeqWwNoXLPMMTOq0tL1/LyzO4D1T+0fBLwNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fi6wunC3; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fi6wunC3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Kxx8KzUKNhZvcNy9sy33d736zsc/L4Pm7djph0dLkpM=;
	b=fi6wunC3qGcoZx6w8zJNCdWj8u2B7qPlnlb7qZ+g8jHbzsIBAmSnUk/M0VD+TJ17iNbX0Z+7K
	GD1WwO/vkFzdmpkuHCeb8UqjQlKPDhLPv9jcxT6B8HYswyxw4GkvwQNLfXrRvLxDzlK6NAun0Ia
	rXjtOqvHrQoV9J/9xe5P4CY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6qd55QmzRhQt;
	Tue,  1 Sep 2026 21:57:17 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 2001740537;
	Tue,  1 Sep 2026 22:08:05 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:04 +0800
From: Qinxin Xia <xiaqinxin@huawei.com>
To: <ben.horgan@arm.com>, <zhangzhanpeng.jasper@bytedance.com>,
	<joro@8bytes.org>, <palmer@dabbelt.com>, <tony.luck@intel.com>,
	<reinette.chatre@intel.com>, <tomasz.jeznach@linux.dev>,
	<zengheng4@huawei.com>, <fustini@kernel.org>, <cuiyunhui@bytedance.com>,
	<wangzhou1@hisilicon.com>, <xiaqinxin@huawei.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <pjw@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <Dave.Martin@arm.com>,
	<james.morse@arm.com>, <babu.moger@amd.com>, <corbet@lwn.net>,
	<shuah@kernel.org>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<yuanzhu@bytedance.com>, <iommu@lists.linux.dev>, <linuxarm@huawei.com>,
	<baolin.wang@linux.alibaba.com>
Subject: [RFC PATCH 1/5] iommu: Add per-device requestor QoS tagging and lookup helpers
Date: Tue, 1 Sep 2026 22:07:58 +0800
Message-ID: <20260901140802.1215508-2-xiaqinxin@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260901140802.1215508-1-xiaqinxin@huawei.com>
References: <20260901140802.1215508-1-xiaqinxin@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500007.china.huawei.com (7.202.195.114)

Allow a device's DMA to be tagged with a QoS requestor ID so resctrl can
assign the device to a resource group.

Add helpers to program the requestor ID, track group membership changes,
and look up a device by name.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 drivers/iommu/iommu.c | 113 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iommu.h |  29 +++++++++++
 2 files changed, 142 insertions(+)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9a..2f3739a755d6 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -43,6 +43,8 @@ static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
 
+static const struct iommu_qos_device_ops *iommu_qos_dev_ops;
+
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
 static u32 iommu_cmd_line __read_mostly;
@@ -728,7 +730,10 @@ static void __iommu_group_free_device(struct iommu_group *group,
 				      struct group_device *grp_dev)
 {
 	struct device *dev = grp_dev->dev;
+	const struct iommu_qos_device_ops *qos_ops = READ_ONCE(iommu_qos_dev_ops);
 
+	if (qos_ops)
+		qos_ops->remove(dev);
 	sysfs_remove_link(group->devices_kobj, grp_dev->name);
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 
@@ -1266,6 +1271,7 @@ static int iommu_create_device_direct_mappings(struct iommu_domain *domain,
 static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 						     struct device *dev)
 {
+	const struct iommu_qos_device_ops *qos_ops;
 	int ret, i = 0;
 	struct group_device *device;
 
@@ -1304,6 +1310,9 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
 
 	trace_add_device_to_group(group->id, dev);
 
+	qos_ops = READ_ONCE(iommu_qos_dev_ops);
+	if (qos_ops)
+		qos_ops->add(dev);
 	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return device;
@@ -4222,6 +4231,110 @@ void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL_GPL(pci_dev_reset_iommu_done);
 
+static struct iommu_group *iommu_group_kset_next_get(struct iommu_group *prev)
+{
+	struct iommu_group *group = NULL;
+	struct kobject *kobj;
+
+	if (!iommu_group_kset)
+		return NULL;
+
+	spin_lock(&iommu_group_kset->list_lock);
+	kobj = prev ? list_next_entry(&prev->kobj, entry) :
+		      list_first_entry_or_null(&iommu_group_kset->list,
+					       struct kobject, entry);
+	if (kobj) {
+		list_for_each_entry_from(kobj, &iommu_group_kset->list, entry) {
+			group = container_of(kobj, struct iommu_group, kobj);
+
+			/* Skip groups already on their way out (refcount 0). */
+			if (kobject_get_unless_zero(&group->kobj))
+				break;
+			group = NULL;
+		}
+	}
+	spin_unlock(&iommu_group_kset->list_lock);
+
+	return group;
+}
+
+struct device *iommu_group_find_device_by_name(const char *name)
+{
+	struct iommu_group *group, *next;
+	struct group_device *gdev;
+	struct device *dev = NULL;
+
+	if (!name)
+		return NULL;
+
+	for (group = iommu_group_kset_next_get(NULL); group; group = next) {
+		mutex_lock(&group->mutex);
+		for_each_group_device(group, gdev) {
+			if (!strcmp(gdev->name, name)) {
+				/*
+				 * Take a reference while still under
+				 * group->mutex: device removal also takes this
+				 * mutex before freeing the device, so the
+				 * pointer cannot vanish until we hold a
+				 * reference. The caller must put_device().
+				 */
+				dev = get_device(gdev->dev);
+				break;
+			}
+		}
+		mutex_unlock(&group->mutex);
+
+		next = dev ? NULL : iommu_group_kset_next_get(group);
+		kobject_put(&group->kobj);
+		if (dev)
+			break;
+	}
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(iommu_group_find_device_by_name);
+
+int iommu_set_dev_requestor_id(struct device *dev, u32 requestor_id, u8 pmg)
+{
+	const struct iommu_ops *ops;
+
+	if (!dev_has_iommu(dev))
+		return -EOPNOTSUPP;
+
+	ops = dev_iommu_ops(dev);
+	if (!ops->set_dev_requestor_id)
+		return -EOPNOTSUPP;
+
+	return ops->set_dev_requestor_id(dev, requestor_id, pmg);
+}
+EXPORT_SYMBOL_GPL(iommu_set_dev_requestor_id);
+
+void iommu_register_qos_device_ops(const struct iommu_qos_device_ops *ops)
+{
+	struct iommu_group *group, *next;
+	struct group_device *gdev;
+
+	/* Publish the ops first so newly probed devices see them. */
+	WRITE_ONCE(iommu_qos_dev_ops, ops);
+
+	/*
+	 * Registration happens late (e.g. from resctrl's fs_initcall), after
+	 * early IOMMU devices have already been added to their groups. Replay
+	 * the add() callback for every device that is currently on a group so
+	 * none are missed.
+	 */
+	for (group = iommu_group_kset_next_get(NULL); group; group = next) {
+		mutex_lock(&group->mutex);
+		for_each_group_device(group, gdev)
+			ops->add(gdev->dev);
+		mutex_unlock(&group->mutex);
+
+		next = iommu_group_kset_next_get(group);
+		kobject_put(&group->kobj);
+	}
+}
+EXPORT_SYMBOL_GPL(iommu_register_qos_device_ops);
+
 #if IS_ENABLED(CONFIG_IRQ_MSI_IOMMU)
 /**
  * iommu_dma_prepare_msi() - Map the MSI page in the IOMMU domain
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ac43b8b93f14..20bb7f381064 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -340,6 +340,11 @@ struct iommu_pages_list {
 #define IOMMU_PAGES_LIST_INIT(name) \
 	((struct iommu_pages_list){ .pages = LIST_HEAD_INIT(name.pages) })
 
+struct iommu_qos_device_ops {
+	void (*add)(struct device *dev);
+	void (*remove)(struct device *dev);
+};
+
 #ifdef CONFIG_IOMMU_API
 
 /**
@@ -735,6 +740,9 @@ struct iommu_ops {
 			   struct iommu_domain *parent_domain,
 			   const struct iommu_user_data *user_data);
 
+	int (*set_dev_requestor_id)(struct device *dev, u32 requestor_id,
+				    u8 pmg);
+
 	const struct iommu_domain_ops *default_domain_ops;
 	struct module *owner;
 	struct iommu_domain *identity_domain;
@@ -1225,6 +1233,10 @@ void iommu_free_global_pasid(ioasid_t pasid);
 /* PCI device reset functions */
 int pci_dev_reset_iommu_prepare(struct pci_dev *pdev);
 void pci_dev_reset_iommu_done(struct pci_dev *pdev);
+
+struct device *iommu_group_find_device_by_name(const char *name);
+int iommu_set_dev_requestor_id(struct device *dev, u32 requestor_id, u8 pmg);
+void iommu_register_qos_device_ops(const struct iommu_qos_device_ops *ops);
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1557,6 +1569,23 @@ static inline int pci_dev_reset_iommu_prepare(struct pci_dev *pdev)
 static inline void pci_dev_reset_iommu_done(struct pci_dev *pdev)
 {
 }
+
+static inline struct device *iommu_group_find_device_by_name(const char *name)
+{
+	return NULL;
+}
+
+static inline int iommu_set_dev_requestor_id(struct device *dev,
+					     u32 requestor_id, u8 pmg)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void
+iommu_register_qos_device_ops(const struct iommu_qos_device_ops *ops)
+{
+}
+
 #endif /* CONFIG_IOMMU_API */
 
 #ifdef CONFIG_IRQ_MSI_IOMMU
-- 
2.33.0

