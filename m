Return-Path: <SRS0=Pr8R=H6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F78C433E6
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7467664E51
	for <iommu@archiver.kernel.org>; Sun, 28 Feb 2021 06:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7467664E51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 380C56F965;
	Sun, 28 Feb 2021 06:33:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OGiK_nFERJKv; Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1728F6F9CC;
	Sun, 28 Feb 2021 06:33:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FB0FC001F;
	Sun, 28 Feb 2021 06:33:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40873C001B
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 72EA54338C
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BDt30BIdaAVu for <iommu@lists.linux-foundation.org>;
 Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7DD63433BD
 for <iommu@lists.linux-foundation.org>; Sun, 28 Feb 2021 06:33:12 +0000 (UTC)
IronPort-SDR: /7pFMDVvW5gEzQSVvx80jNt/Klos7/MvGC286IMyLPul42cdla1D0wphM1rWs51704pzLkUh73
 e/4JSpF9B04g==
X-IronPort-AV: E=McAfee;i="6000,8403,9908"; a="247624816"
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="247624816"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Feb 2021 22:33:10 -0800
IronPort-SDR: fYlVC9ne3ocbRyTYqqdSjSNHWJ/y6MOKeukSYbfFFCiCPsZEwMgp8eVO7e5WwQ+u7zprn8BX3y
 UdXgFugPUYPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,211,1610438400"; d="scan'208";a="517029740"
Received: from otc-wp-03.jf.intel.com ([10.54.39.79])
 by orsmga004.jf.intel.com with ESMTP; 27 Feb 2021 22:33:10 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 "Lu Baolu" <baolu.lu@linux.intel.com>,
 David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org,
 cgroups@vger.kernel.org, Tejun Heo <tj@kernel.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>
Subject: [RFC PATCH 15/18] cgroup: Introduce ioasids controller
Date: Sat, 27 Feb 2021 14:01:23 -0800
Message-Id: <1614463286-97618-16-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Alex Williamson <alex.williamson@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Wu Hao <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

IOASIDs are used to associate DMA requests with virtual address spaces.
They are a system-wide limited resource made available to the userspace
applications. Let it be VMs or user-space device drivers.

This RFC patch introduces a cgroup controller to address the following
problems:
1. Some user applications exhaust all the available IOASIDs thus
depriving others of the same host.
2. System admins need to provision VMs based on their needs for IOASIDs,
e.g. the number of VMs with assigned devices that perform DMA requests
with PASID.

This patch is nowhere near its completion, it merely provides the basic
functionality for resource distribution and cgroup hierarchy
organizational changes.

Since this is part of a greater effort to enable Shared Virtual Address
(SVA) virtualization. We would like to have a direction check and
collect feedback early. For details, please refer to the documentation:
Documentation/admin-guide/cgroup-v1/ioasids.rst

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/linux/cgroup_subsys.h |   4 +
 include/linux/ioasid.h        |  17 ++
 init/Kconfig                  |   7 +
 kernel/cgroup/Makefile        |   1 +
 kernel/cgroup/ioasids.c       | 345 ++++++++++++++++++++++++++++++++++
 5 files changed, 374 insertions(+)
 create mode 100644 kernel/cgroup/ioasids.c

diff --git a/include/linux/cgroup_subsys.h b/include/linux/cgroup_subsys.h
index acb77dcff3b4..cda75ecdcdcb 100644
--- a/include/linux/cgroup_subsys.h
+++ b/include/linux/cgroup_subsys.h
@@ -57,6 +57,10 @@ SUBSYS(hugetlb)
 SUBSYS(pids)
 #endif
 
+#if IS_ENABLED(CONFIG_CGROUP_IOASIDS)
+SUBSYS(ioasids)
+#endif
+
 #if IS_ENABLED(CONFIG_CGROUP_RDMA)
 SUBSYS(rdma)
 #endif
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 4547086797df..5ea4710efb02 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -135,8 +135,25 @@ void ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 				void *data);
 int ioasid_register_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
 void ioasid_unregister_notifier_mm(struct mm_struct *mm, struct notifier_block *nb);
+#ifdef CONFIG_CGROUP_IOASIDS
+int ioasid_cg_charge(struct ioasid_set *set);
+void ioasid_cg_uncharge(struct ioasid_set *set);
+#else
+/* No cgroup control, allocation will proceed until run out total pool */
+static inline int ioasid_cg_charge(struct ioasid_set *set)
+{
+	return 0;
+}
+
+static inline int ioasid_cg_uncharge(struct ioasid_set *set)
+{
+	return 0;
+}
+#endif /* CGROUP_IOASIDS */
 bool ioasid_queue_work(struct work_struct *work);
+
 #else /* !CONFIG_IOASID */
+
 static inline void ioasid_install_capacity(ioasid_t total)
 {
 }
diff --git a/init/Kconfig b/init/Kconfig
index b77c60f8b963..9a23683dad98 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1017,6 +1017,13 @@ config CGROUP_PIDS
 	  since the PIDs limit only affects a process's ability to fork, not to
 	  attach to a cgroup.
 
+config CGROUP_IOASIDS
+	bool "IOASIDs controller"
+	depends on IOASID
+	help
+	  Provides enforcement of IO Address Space ID limits in the scope of a
+	  cgroup.
+
 config CGROUP_RDMA
 	bool "RDMA controller"
 	help
diff --git a/kernel/cgroup/Makefile b/kernel/cgroup/Makefile
index 5d7a76bfbbb7..c5ad7c9a2305 100644
--- a/kernel/cgroup/Makefile
+++ b/kernel/cgroup/Makefile
@@ -3,6 +3,7 @@ obj-y := cgroup.o rstat.o namespace.o cgroup-v1.o freezer.o
 
 obj-$(CONFIG_CGROUP_FREEZER) += legacy_freezer.o
 obj-$(CONFIG_CGROUP_PIDS) += pids.o
+obj-$(CONFIG_CGROUP_IOASIDS) += ioasids.o
 obj-$(CONFIG_CGROUP_RDMA) += rdma.o
 obj-$(CONFIG_CPUSETS) += cpuset.o
 obj-$(CONFIG_CGROUP_DEBUG) += debug.o
diff --git a/kernel/cgroup/ioasids.c b/kernel/cgroup/ioasids.c
new file mode 100644
index 000000000000..ac43813da6ad
--- /dev/null
+++ b/kernel/cgroup/ioasids.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * IO Address Space ID limiting controller for cgroups.
+ *
+ */
+#define pr_fmt(fmt)	"ioasids_cg: " fmt
+
+#include <linux/kernel.h>
+#include <linux/threads.h>
+#include <linux/atomic.h>
+#include <linux/cgroup.h>
+#include <linux/slab.h>
+#include <linux/ioasid.h>
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
+
+#define IOASIDS_MAX_STR "max"
+static DEFINE_MUTEX(ioasids_cg_lock);
+
+struct ioasids_cgroup {
+	struct cgroup_subsys_state	css;
+	atomic64_t			counter;
+	atomic64_t			limit;
+	struct cgroup_file		events_file;
+	/* Number of times allocations failed because limit was hit. */
+	atomic64_t			events_limit;
+};
+
+static struct ioasids_cgroup *css_ioasids(struct cgroup_subsys_state *css)
+{
+	return container_of(css, struct ioasids_cgroup, css);
+}
+
+static struct ioasids_cgroup *parent_ioasids(struct ioasids_cgroup *ioasids)
+{
+	return css_ioasids(ioasids->css.parent);
+}
+
+static struct cgroup_subsys_state *
+ioasids_css_alloc(struct cgroup_subsys_state *parent)
+{
+	struct ioasids_cgroup *ioasids;
+
+	ioasids = kzalloc(sizeof(struct ioasids_cgroup), GFP_KERNEL);
+	if (!ioasids)
+		return ERR_PTR(-ENOMEM);
+
+	atomic64_set(&ioasids->counter, 0);
+	atomic64_set(&ioasids->limit, 0);
+	atomic64_set(&ioasids->events_limit, 0);
+	return &ioasids->css;
+}
+
+static void ioasids_css_free(struct cgroup_subsys_state *css)
+{
+	kfree(css_ioasids(css));
+}
+
+/**
+ * ioasids_cancel - uncharge the local IOASID count
+ * @ioasids: the ioasid cgroup state
+ * @num: the number of ioasids to cancel
+ *
+ */
+static void ioasids_cancel(struct ioasids_cgroup *ioasids, int num)
+{
+	WARN_ON_ONCE(atomic64_add_negative(-num, &ioasids->counter));
+}
+
+/**
+ * ioasids_uncharge - hierarchically uncharge the ioasid count
+ * @ioasids: the ioasid cgroup state
+ * @num: the number of ioasids to uncharge
+ */
+static void ioasids_uncharge(struct ioasids_cgroup *ioasids, int num)
+{
+	struct ioasids_cgroup *p;
+
+	for (p = ioasids; parent_ioasids(p); p = parent_ioasids(p))
+		ioasids_cancel(p, num);
+}
+
+/**
+ * ioasids_charge - hierarchically charge the ioasid count
+ * @ioasids: the ioasid cgroup state
+ * @num: the number of ioasids to charge
+ */
+static void ioasids_charge(struct ioasids_cgroup *ioasids, int num)
+{
+	struct ioasids_cgroup *p;
+
+	for (p = ioasids; parent_ioasids(p); p = parent_ioasids(p))
+		atomic64_add(num, &p->counter);
+}
+
+/**
+ * ioasids_try_charge - hierarchically try to charge the ioasid count
+ * @ioasids: the ioasid cgroup state
+ * @num: the number of ioasids to charge
+ */
+static int ioasids_try_charge(struct ioasids_cgroup *ioasids, int num)
+{
+	struct ioasids_cgroup *p, *q;
+
+	for (p = ioasids; parent_ioasids(p); p = parent_ioasids(p)) {
+		int64_t new = atomic64_add_return(num, &p->counter);
+		int64_t limit = atomic64_read(&p->limit);
+
+		if (new > limit)
+			goto revert;
+	}
+
+	return 0;
+
+revert:
+	for (q = ioasids; q != p; q = parent_ioasids(q))
+		ioasids_cancel(q, num);
+	ioasids_cancel(p, num);
+	cgroup_file_notify(&ioasids->events_file);
+
+	return -EAGAIN;
+}
+
+
+/**
+ * ioasid_cg_charge - Check and charge IOASIDs cgroup
+ *
+ * @set: IOASID set used for allocation
+ *
+ * The IOASID quota is managed per cgroup, all process based allocations
+ * must be validated per cgroup hierarchy.
+ * Return 0 if a single IOASID can be allocated or error if failed in various
+ * checks.
+ */
+int ioasid_cg_charge(struct ioasid_set *set)
+{
+	struct mm_struct *mm = get_task_mm(current);
+	struct cgroup_subsys_state *css;
+	struct ioasids_cgroup *ioasids;
+	int ret = 0;
+
+	/* Must be called with a valid mm, not during process exit */
+	if (set->type != IOASID_SET_TYPE_MM)
+		return ret;
+	if (!mm)
+		return -EINVAL;
+	/* We only charge user process allocated PASIDs */
+	if (set->type != IOASID_SET_TYPE_MM) {
+		ret = -EINVAL;
+		goto exit_drop;
+	}
+	if (set->token != mm) {
+		pr_err("No permisson to allocate IOASID\n");
+		ret = -EPERM;
+		goto exit_drop;
+	}
+	rcu_read_lock();
+	css = task_css(current, ioasids_cgrp_id);
+	ioasids = css_ioasids(css);
+	rcu_read_unlock();
+	ret = ioasids_try_charge(ioasids, 1);
+	if (ret)
+		pr_warn("%s: Unable to charge IOASID %d\n", __func__, ret);
+exit_drop:
+	mmput_async(mm);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_cg_charge);
+
+/* Uncharge IOASIDs cgroup after freeing an IOASID */
+void ioasid_cg_uncharge(struct ioasid_set *set)
+{
+	struct cgroup_subsys_state *css;
+	struct ioasids_cgroup *ioasids;
+	struct mm_struct *mm;
+
+	/* We only charge user process allocated PASIDs */
+	if (set->type != IOASID_SET_TYPE_MM)
+		return;
+	mm = set->token;
+	if (!mmget_not_zero(mm)) {
+		pr_err("MM defunct! Cannot uncharge IOASID\n");
+		return;
+	}
+	rcu_read_lock();
+	css = task_css(current, ioasids_cgrp_id);
+	ioasids = css_ioasids(css);
+	rcu_read_unlock();
+	ioasids_uncharge(ioasids, 1);
+	mmput_async(mm);
+}
+EXPORT_SYMBOL_GPL(ioasid_cg_uncharge);
+
+static int ioasids_can_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *dst_css;
+	static struct ioasid_set *set;
+	struct task_struct *leader;
+
+	/*
+	 * IOASIDs are managed at per process level, we only support domain mode
+	 * in task management model. Loop through all processes by each thread
+	 * leader, charge the leader's css.
+	 */
+	cgroup_taskset_for_each_leader(leader, dst_css, tset) {
+		struct ioasids_cgroup *ioasids = css_ioasids(dst_css);
+		struct cgroup_subsys_state *old_css;
+		struct ioasids_cgroup *old_ioasids;
+		struct mm_struct *mm = get_task_mm(leader);
+
+		set = ioasid_find_mm_set(mm);
+		mmput(mm);
+		if (!set)
+			continue;
+
+		old_css = task_css(leader, ioasids_cgrp_id);
+		old_ioasids = css_ioasids(old_css);
+
+		ioasids_charge(ioasids, atomic_read(&set->nr_ioasids));
+		ioasids_uncharge(old_ioasids, atomic_read(&set->nr_ioasids));
+	}
+
+	return 0;
+}
+
+static void ioasids_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *dst_css;
+	struct task_struct *task;
+
+	cgroup_taskset_for_each(task, dst_css, tset) {
+		struct ioasids_cgroup *ioasids = css_ioasids(dst_css);
+		struct cgroup_subsys_state *old_css;
+		struct ioasids_cgroup *old_ioasids;
+
+		old_css = task_css(task, ioasids_cgrp_id);
+		old_ioasids = css_ioasids(old_css);
+
+		ioasids_charge(old_ioasids, 1);
+		ioasids_uncharge(ioasids, 1);
+	}
+}
+
+static ssize_t ioasids_max_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct cgroup_subsys_state *css = of_css(of);
+	struct ioasids_cgroup *ioasids = css_ioasids(css);
+	int64_t limit, limit_cur;
+	int err;
+
+	mutex_lock(&ioasids_cg_lock);
+	/* Check whether we are growing or shrinking */
+	limit_cur = atomic64_read(&ioasids->limit);
+	buf = strstrip(buf);
+	if (!strcmp(buf, IOASIDS_MAX_STR)) {
+		/* Returns how many IOASIDs was in the pool */
+		limit = ioasid_reserve_capacity(0);
+		ioasid_reserve_capacity(limit - limit_cur);
+		goto set_limit;
+	}
+	err = kstrtoll(buf, 0, &limit);
+	if (err)
+		goto done_unlock;
+
+	err = nbytes;
+	/* Check whether we are growing or shrinking */
+	limit_cur = atomic64_read(&ioasids->limit);
+	if (limit < 0 || limit == limit_cur) {
+		err = -EINVAL;
+		goto done_unlock;
+	}
+	if (limit < limit_cur)
+		err = ioasid_cancel_capacity(limit_cur - limit);
+	else
+		err = ioasid_reserve_capacity(limit - limit_cur);
+	if (err < 0)
+		goto done_unlock;
+
+set_limit:
+	err = nbytes;
+	atomic64_set(&ioasids->limit, limit);
+done_unlock:
+	mutex_unlock(&ioasids_cg_lock);
+	return err;
+}
+
+static int ioasids_max_show(struct seq_file *sf, void *v)
+{
+	struct cgroup_subsys_state *css = seq_css(sf);
+	struct ioasids_cgroup *ioasids = css_ioasids(css);
+	int64_t limit = atomic64_read(&ioasids->limit);
+
+	seq_printf(sf, "%lld\n", limit);
+
+	return 0;
+}
+
+static s64 ioasids_current_read(struct cgroup_subsys_state *css,
+			     struct cftype *cft)
+{
+	struct ioasids_cgroup *ioasids = css_ioasids(css);
+
+	return atomic64_read(&ioasids->counter);
+}
+
+static int ioasids_events_show(struct seq_file *sf, void *v)
+{
+	struct ioasids_cgroup *ioasids = css_ioasids(seq_css(sf));
+
+	seq_printf(sf, "max %lld\n", (s64)atomic64_read(&ioasids->events_limit));
+	return 0;
+}
+
+static struct cftype ioasids_files[] = {
+	{
+		.name = "max",
+		.write = ioasids_max_write,
+		.seq_show = ioasids_max_show,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "current",
+		.read_s64 = ioasids_current_read,
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{
+		.name = "events",
+		.seq_show = ioasids_events_show,
+		.file_offset = offsetof(struct ioasids_cgroup, events_file),
+		.flags = CFTYPE_NOT_ON_ROOT,
+	},
+	{ }	/* terminate */
+};
+
+struct cgroup_subsys ioasids_cgrp_subsys = {
+	.css_alloc	= ioasids_css_alloc,
+	.css_free	= ioasids_css_free,
+	.can_attach	= ioasids_can_attach,
+	.cancel_attach	= ioasids_cancel_attach,
+	.legacy_cftypes	= ioasids_files,
+	.dfl_cftypes	= ioasids_files,
+	.threaded	= false,
+};
+
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
