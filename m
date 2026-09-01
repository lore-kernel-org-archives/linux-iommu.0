Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACF3AEF4F
	for <iommu@lists.linux.dev>; Tue,  1 Sep 2026 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788271696; cv=none; b=qhWW6tFhkpE3p3XJ2geDJS8Fwev8WQsAdltwRR8hmndClQpgz52OMi21ikY+ihLo6MVRS75OQ1YurBaoMTVnwevRpjiGYdcHMMcu6Wbkq8o+8YLPz8OysxX9xlyKjgEViMpPzz7lY7pijrzYJ8g/FDstMY811P7iCZkOg4NLP6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788271696; c=relaxed/simple;
	bh=lf0h3bznGEjSwAzSNK2FV9u/G7zXGiXJHwOcUYr8YTY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fh2ce+kXx/eYYq1HJl1NCL5652qIuMzVijzGkX0KOiPMiq18UCMLXp8jsGD/JocMQSc7dWyA3kFbBp9wR20c0sKuFiMTlaWqpJHjQYFMewFPvtiPacmHJTwsbR1UNkug5/nBz5YM8/v8q68oOtkZZGy8kHQWozXlkyr+afQm/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=QtPGd3en; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="QtPGd3en"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/wWuisid/B1g3aYPdBQbcQz56bZzmD/4uLiIetT933I=;
	b=QtPGd3en16hOzB4p3OZxfgC4e72dWq1hRENC/mG44mNj7WEK+2yQHEN7Wwav4ur5L/BPuCIhH
	umFj0fZXd66mZ4+2uu/gxACCRjVxe07nocB5UF9ahk6lLGpoiiCBjpEcZOeSS1IRj8EzvGahaHc
	3jaQpQhlnCB9VkWsAFQUxnI=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hZ6qB4ZsTznTVd;
	Tue,  1 Sep 2026 21:56:54 +0800 (CST)
Received: from kwepemo500007.china.huawei.com (unknown [7.202.195.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C32C40578;
	Tue,  1 Sep 2026 22:08:08 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemo500007.china.huawei.com (7.202.195.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 1 Sep 2026 22:08:07 +0800
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
Subject: [RFC PATCH 5/5] fs/resctrl: Add a "devices" file to assign devices to groups
Date: Tue, 1 Sep 2026 22:08:02 +0800
Message-ID: <20260901140802.1215508-6-xiaqinxin@huawei.com>
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

Expose the device QoS tracking through a new "devices" file. Writing a
device name assigns it to the group, tagging its DMA with the group's QoS
IDs.

The file is only shown where an IOMMU can tag device DMA.

Signed-off-by: Qinxin Xia <xiaqinxin@huawei.com>
---
 Documentation/filesystems/resctrl.rst |  18 ++++-
 fs/resctrl/rdtgroup.c                 | 101 ++++++++++++++++++++++++++
 2 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index e4b66af55ffb..aa205ccaabf6 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -546,8 +546,8 @@ directories can be created to monitor subsets of tasks in the CTRL_MON
 group that is their ancestor. These are called "MON" groups in the rest
 of this document.
 
-Removing a directory will move all tasks and cpus owned by the group it
-represents to the parent. Removing one of the created CTRL_MON groups
+Removing a directory will move all tasks, cpus and devices owned by the
+group it represents to the parent. Removing one of the created CTRL_MON groups
 will automatically remove all MON groups below it.
 
 Moving MON group directories to a new parent CTRL_MON group is supported
@@ -581,6 +581,20 @@ All groups contain the following files:
 	idle tasks. Instead, a CPU's idle task is always considered as a
 	member of the group owning the CPU.
 
+"devices":
+	Reading this file shows the list of all devices that belong to
+	this group. Writing a device name to the file will add a device to
+	the group, tagging its DMA with the group's QoS IDs. Multiple
+	devices can be added by separating the names with commas. A single
+	failure encountered while attempting to assign a device will cause
+	the operation to abort and already added devices before the failure
+	will remain in the group. Failures will be logged to
+	/sys/fs/resctrl/info/last_cmd_status.
+
+	The device name is the one listed under
+	/sys/kernel/iommu_groups/<id>/devices/. This file is only present
+	when an IOMMU can tag the DMA of devices behind it with a QoS class.
+
 "cpus":
 	Reading this file shows a bitmask of the logical CPUs owned by
 	this group. Writing a mask to this file will add and remove
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index c33891ead788..3633b3521941 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -985,6 +985,92 @@ static const struct iommu_qos_device_ops rdtgroup_qos_device_ops = {
 	.remove = rdtgroup_remove_device,
 };
 
+static ssize_t rdtgroup_devices_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct rdtgroup *rdtgrp;
+	char *token;
+	int ret = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+	rdt_last_cmd_clear();
+
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
+		ret = -EINVAL;
+		rdt_last_cmd_puts("Pseudo-locking in progress\n");
+		goto unlock;
+	}
+
+	while ((token = strsep(&buf, ","))) {
+		struct device *dev;
+
+		token = strim(token);
+		if (!*token) {
+			rdt_last_cmd_puts("Device list parsing error\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		dev = iommu_group_find_device_by_name(token);
+		if (!dev) {
+			rdt_last_cmd_printf("No device %s\n", token);
+			ret = -ENODEV;
+			break;
+		}
+
+		ret = rdtgroup_set_device(dev, rdtgrp);
+		if (ret == -EOPNOTSUPP)
+			rdt_last_cmd_printf("Device %s does not support QoS\n",
+					    token);
+		else if (ret)
+			rdt_last_cmd_printf("Error while processing device %s\n",
+					    token);
+		/*
+		 * rdtgroup_set_device() takes its own reference on a new
+		 * rdtdev; drop the temporary reference returned by the
+		 * lookup regardless of the outcome.
+		 */
+		put_device(dev);
+		if (ret)
+			break;
+	}
+
+unlock:
+	rdtgroup_kn_unlock(of->kn);
+	return ret ?: nbytes;
+}
+
+static int rdtgroup_devices_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	struct rdtdev *rdtdev;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -ENOENT;
+	}
+
+	mutex_lock(&rdtdev_mutex);
+	list_for_each_entry(rdtdev, &rdtdev_list, node)
+		if (is_rmid_match_dev(rdtdev, rdtgrp) ||
+		    is_closid_match_dev(rdtdev, rdtgrp))
+			seq_printf(s, "%s\n", kobject_name(&rdtdev->dev->kobj));
+	mutex_unlock(&rdtdev_mutex);
+
+	rdtgroup_kn_unlock(of->kn);
+	return 0;
+}
+
 static void rdt_move_group_devices(struct rdtgroup *from, struct rdtgroup *to)
 {
 	struct rdtdev *rdtdev;
@@ -2295,6 +2381,14 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "devices",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_devices_write,
+		.seq_show	= rdtgroup_devices_show,
+		.fflags		= RFTYPE_BASE,
+	},
 	{
 		.name		= "mon_hw_id",
 		.mode		= 0444,
@@ -2363,6 +2457,13 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 
 	for (rft = rfts; rft < rfts + len; rft++) {
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
+			if (!strcmp(rft->name, "devices") &&
+			    (!resctrl_arch_devices_supported() ||
+			     ((fflags & RFTYPE_CTRL) &&
+			      !resctrl_arch_alloc_capable()) ||
+			     ((fflags & RFTYPE_MON) &&
+			      !resctrl_arch_mon_capable())))
+				continue;
 			ret = rdtgroup_add_file(kn, rft);
 			if (ret)
 				goto error;
-- 
2.33.0

