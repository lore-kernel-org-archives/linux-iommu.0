Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0436838F934
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271696; cv=none; b=ozytcsJHVjU56n7hsGgYSNzGF73EF3wjSirZS7zcM5aJo636XzAhV73bCp9L5mXEWGF/NCSqiVzMUy/xeoN67ETyKp94ZGoP9NYa/h8eAW6Bd3wiDjRdnvTuLqe+brm8pvPRQdD+GuxAmpS82vkr9kdLbcPczvDKzWfkhPAsXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271696; c=relaxed/simple;
	bh=xvdhLHIEKbr7HGy9oT9m7GhSzKZk60P1O4UUY3LeOw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aGU0mPp39HI5Bg/4EMspoAxwAXArS74mXdbEmolNFVsZzY24v19fHU9v2wrg+EZ0VglIKpZlhKwyEcWlLXK3/pHPYRPlsUv5Nov1vzPFfNgCsg7OJhxkVP8vDxsLWDDKQ6i1hEaABAg1kvCG53iEifQKHUeYOsWTfg9n/NOLmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=GKjpLfTB; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="GKjpLfTB"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uO1+Nfki5zCqqYC7AakTTzDTMm3QkIwwJrsqHCHdqM0=;
	b=GKjpLfTBX2fxuEx0F5mcEYoMmhCRqnd0dWIOy9ylIDqh0BLqMM+0BbbpIgeCvLhu4sJr0E84g
	L+5BioLp+i0IRQ3kUaiI/hcoo2A+LW5JuLBZn/+eDyzyReuKd8c0J1nZ5mwpVE0biwaA98JB8VC
	J+/y2ypvYqayHYvut0u+0n8=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6qZ2YnvzKmB5;
	Tue,  1 Sep 2026 21:57:14 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F0DD40565;
	Tue,  1 Sep 2026 22:08:07 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:06 +0800
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
Subject: [RFC PATCH 4/5] fs/resctrl: Add device-to-group QoS tracking infrastructure
Date: Tue, 1 Sep 2026 22:08:01 +0800
Message-ID: <20260901140802.1215508-5-xiaqinxin@huawei.com>
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

Add the core support for tracking which devices belong to a resource group
and tagging their DMA with the group's QoS IDs.

Devices mastering through an IOMMU are tracked automatically and default to
the root group; when a group is destroyed its devices are moved back to it.
A group with assigned devices cannot be pseudo-locked.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 fs/resctrl/internal.h    |   9 +++
 fs/resctrl/pseudo_lock.c |   5 ++
 fs/resctrl/rdtgroup.c    | 148 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 162 insertions(+)

diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e62a277dee85..6457962763ff 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -202,6 +202,13 @@ struct mongroup {
 	u32			rmid;
 };
 
+struct rdtdev {
+	struct list_head	node;
+	struct device		*dev;
+	u32			closid;
+	u32			rmid;
+};
+
 /**
  * struct rdtgroup - store rdtgroup's data in resctrl file system.
  * @kn:				kernfs node
@@ -366,6 +373,8 @@ enum rdtgrp_mode rdtgroup_mode_by_closid(int closid);
 
 int rdtgroup_tasks_assigned(struct rdtgroup *r);
 
+int rdtgroup_devices_assigned(struct rdtgroup *r);
+
 int closids_supported(void);
 
 void closid_free(int closid);
diff --git a/fs/resctrl/pseudo_lock.c b/fs/resctrl/pseudo_lock.c
index dea2b4bf966f..e3b4f53aacce 100644
--- a/fs/resctrl/pseudo_lock.c
+++ b/fs/resctrl/pseudo_lock.c
@@ -531,6 +531,11 @@ int rdtgroup_locksetup_enter(struct rdtgroup *rdtgrp)
 		return -EINVAL;
 	}
 
+	if (rdtgroup_devices_assigned(rdtgrp)) {
+		rdt_last_cmd_puts("Devices assigned to resource group\n");
+		return -EINVAL;
+	}
+
 	if (!cpumask_empty(&rdtgrp->cpu_mask)) {
 		rdt_last_cmd_puts("CPUs assigned to resource group\n");
 		return -EINVAL;
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 5dcbb0a964e8..c33891ead788 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/fs_parser.h>
+#include <linux/iommu.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
 #include <linux/once.h>
@@ -33,6 +34,9 @@
 /* Mutex to protect rdtgroup access. */
 DEFINE_MUTEX(rdtgroup_mutex);
 
+/* Mutex to protect the rdtdev_list and the rdtdev entries. */
+DEFINE_MUTEX(rdtdev_mutex);
+
 static struct kernfs_root *rdt_root;
 
 struct rdtgroup rdtgroup_default;
@@ -42,6 +46,8 @@ LIST_HEAD(rdt_all_groups);
 /* list of entries for the schemata file */
 LIST_HEAD(resctrl_schema_all);
 
+LIST_HEAD(rdtdev_list);
+
 /*
  * List of struct mon_data containing private data of event files for use by
  * rdtgroup_mondata_show(). Protected by rdtgroup_mutex.
@@ -885,6 +891,137 @@ static int rdtgroup_rmid_show(struct kernfs_open_file *of,
 	return ret;
 }
 
+static bool is_closid_match_dev(struct rdtdev *rdtdev, struct rdtgroup *r)
+{
+	return (resctrl_arch_alloc_capable() && (r->type == RDTCTRL_GROUP) &&
+		(rdtdev->closid == r->closid));
+}
+
+static bool is_rmid_match_dev(struct rdtdev *rdtdev, struct rdtgroup *r)
+{
+	return (resctrl_arch_mon_capable() && (r->type == RDTMON_GROUP) &&
+		rdtdev->rmid == r->mon.rmid && rdtdev->closid == r->mon.parent->closid);
+}
+
+static int rdtdev_set_qos(struct device *dev, u32 closid, u32 rmid)
+{
+	return iommu_set_dev_requestor_id(dev, closid, rmid);
+}
+
+static int rdtgroup_set_device(struct device *dev, struct rdtgroup *rdtgrp)
+{
+	struct rdtdev *rdtdev, *entry = NULL, *tmp;
+	u32 closid, rmid;
+	int ret;
+
+	if (!dev)
+		return -ENODEV;
+
+	if (!rdtgrp)
+		rdtgrp = &rdtgroup_default;
+
+	closid = (rdtgrp->type == RDTMON_GROUP) ?
+			rdtgrp->mon.parent->closid : rdtgrp->closid;
+	rmid = rdtgrp->mon.rmid;
+
+	guard(mutex)(&rdtdev_mutex);
+
+	list_for_each_entry(tmp, &rdtdev_list, node)
+		if (tmp->dev == dev) {
+			entry = tmp;
+			break;
+		}
+
+	if (entry) {
+		ret = rdtdev_set_qos(dev, closid, rmid);
+		if (ret)
+			return ret;
+		entry->closid = closid;
+		entry->rmid = rmid;
+		return 0;
+	}
+
+	rdtdev = kzalloc_obj(*rdtdev);
+	if (!rdtdev)
+		return -ENOMEM;
+
+	rdtdev->dev = get_device(dev);
+	rdtdev->closid = closid;
+	rdtdev->rmid = rmid;
+	list_add_tail(&rdtdev->node, &rdtdev_list);
+
+	ret = rdtdev_set_qos(dev, closid, rmid);
+	if (ret) {
+		list_del(&rdtdev->node);
+		put_device(rdtdev->dev);
+		kfree(rdtdev);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void rdtgroup_remove_device(struct device *dev)
+{
+	struct rdtdev *rdtdev, *entry;
+
+	guard(mutex)(&rdtdev_mutex);
+	list_for_each_entry_safe(rdtdev, entry, &rdtdev_list, node)
+		if (rdtdev->dev == dev) {
+			list_del(&rdtdev->node);
+			put_device(rdtdev->dev);
+			kfree(rdtdev);
+			break;
+		}
+}
+
+static void rdtgroup_qos_device_add(struct device *dev)
+{
+	rdtgroup_set_device(dev, NULL);
+}
+
+static const struct iommu_qos_device_ops rdtgroup_qos_device_ops = {
+	.add	= rdtgroup_qos_device_add,
+	.remove = rdtgroup_remove_device,
+};
+
+static void rdt_move_group_devices(struct rdtgroup *from, struct rdtgroup *to)
+{
+	struct rdtdev *rdtdev;
+
+	guard(mutex)(&rdtdev_mutex);
+	list_for_each_entry(rdtdev, &rdtdev_list, node)
+		if (!from || is_rmid_match_dev(rdtdev, from) ||
+		    is_closid_match_dev(rdtdev, from)) {
+			/*
+			 * The source group is going away and its closid/rmid
+			 * will be freed and reused. Retag the device to @to,
+			 * and move it in the tracking list regardless of the
+			 * hardware result: leaving it on the old ids would
+			 * later match a different group once they are reused.
+			 * Warn if the hardware could not be updated to match.
+			 */
+			if (rdtdev_set_qos(rdtdev->dev, to->closid, to->mon.rmid))
+				pr_warn("Failed to retag device %s while moving group\n",
+					dev_name(rdtdev->dev));
+			rdtdev->closid = to->closid;
+			rdtdev->rmid = to->mon.rmid;
+		}
+}
+
+int rdtgroup_devices_assigned(struct rdtgroup *r)
+{
+	struct rdtdev *rdtdev;
+
+	guard(mutex)(&rdtdev_mutex);
+	list_for_each_entry(rdtdev, &rdtdev_list, node)
+		if (is_rmid_match_dev(rdtdev, r) ||
+		    is_closid_match_dev(rdtdev, r))
+			return 1;
+
+	return 0;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 /*
  * A task can only be part of one resctrl control group and of one monitor
@@ -3024,6 +3161,9 @@ static void rmdir_all_sub(void)
 	/* Move all tasks to the default resource group */
 	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
 
+	/* Move all devices to the default resource group */
+	rdt_move_group_devices(NULL, &rdtgroup_default);
+
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
 		free_all_child_rdtgrp(rdtgrp);
@@ -4173,6 +4313,9 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
 
+	/* Give any devices back to the parent group */
+	rdt_move_group_devices(rdtgrp, prdtgrp);
+
 	/*
 	 * Update per cpu closid/rmid of the moved CPUs first.
 	 * Note: the closid will not change, but the arch code still needs it.
@@ -4223,6 +4366,9 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	/* Give any tasks back to the default group */
 	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
 
+	/* Give any devices back to the default group */
+	rdt_move_group_devices(rdtgrp, &rdtgroup_default);
+
 	/* Give any CPUs back to the default group */
 	cpumask_or(&rdtgroup_default.cpu_mask,
 		   &rdtgroup_default.cpu_mask, &rdtgrp->cpu_mask);
@@ -4826,6 +4972,8 @@ int resctrl_init(void)
 	if (ret)
 		goto cleanup_mountpoint;
 
+	iommu_register_qos_device_ops(&rdtgroup_qos_device_ops);
+
 	/*
 	 * Adding the resctrl debugfs directory here may not be ideal since
 	 * it would let the resctrl debugfs directory appear on the debugfs
-- 
2.33.0

