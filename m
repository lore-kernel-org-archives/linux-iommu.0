Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2F747276C
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784034470; cv=none; b=DcchmO9mpg9azlhmT5btvBNiiyF0gJFA4C5/PVaF6owxzdonKVGkF0Ds6oPq340j7P70aaLX5PBALx+XQIqvnZ+5xft8DSmNwXGL89ZueV3IGXAYQcv3WKCn+4sT0i02NjR+d8Mo3U7CKjJeCz5N6ewiwGgmOkcMAR3otQ0mxY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784034470; c=relaxed/simple;
	bh=lv5kWIUDJUDMWlaCosjBEeMFcK6y35rawRF3K3p6LiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ciz9QoUM51ilY74ASNJt02E1xNANauhuYMK7/vLWOjlfesrFzHvyE6+5mC2VhVg5eJIdnELeu+WYsh43jIGingV9xDMof5k29If++GfDu81rbPVeKMdZ7LtEuqof0aGeicsrb/XMUbxo+AvsjTAv+VH9AO+AAlMdojSawhr2UoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=a/Q/TBCD; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="a/Q/TBCD"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7ebd88be784so468559a34.2
        for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1784034467; x=1784639267; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kK72RdH/1XE7usLQ2kyIcth7swn3eieDHyIRvr+BBH8=;
        b=a/Q/TBCDl0nbI/d1CrcSsp5CeZ+4fBzT77vqw/0YCfElfuzqe4QM0ZEwdMdbicZm2I
         xQQy+2xBZze50K2mRjl/6oHMj4gBiTaPgeiPbspeGpsOvJjSgUIuOhnOnon1TpaFwNot
         huBJpGGhKKQOAMXoLmYpehflC9lmdFxi/dtARwWsh759wFwlKZxzFLfmXxw+JxsnEiue
         +9GapxdzcL/Y4MbLwxtC0OesI4T/wRf8oWHVPTUgPDc/fkzeL1x6ZgX2QoTcGeSsEscI
         /BepLU4TN4t+in00Bm1pWpjwtkgTpbweg7dbtg8qm2dFf/cKluiwikEISctZDp4SXk8F
         NRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784034467; x=1784639267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kK72RdH/1XE7usLQ2kyIcth7swn3eieDHyIRvr+BBH8=;
        b=DcZ0LrJz8YRyXMS13p7+WH4cZkXLUPPSucgvYBCTgRSWrbCXxBT6SvY2hlOGXf0Jyw
         1t22AZI3gjgR0v9MluTKdrpWa3nyRht3TMCRjzNKX1yD9FZBEiHbsY0c1K5W/bdmCf7J
         jolAl/PBs8Nx6xTk3Qbc//4EhrGHiCep/GBdCPsJuiSygY/cal7fTOz9iey0i4A1hA/y
         IBQZ5NkigjuqPJyirfwuTZ/DTJMxaSkbqeFIPqXjPXoSwnPlYe1qZteDaU0TOy7iApDo
         +LakgJXwX5EBG8UHHjNvRYCprJn3PGdfGj2EJHZ0DFvVLHdpwKyp8eMNrrvfBeF4vZlO
         P4cQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h81NTzMwf0sWVDDTbNootj2C70jMwDNTLdKfnYhyq4Gg7LZTU5WzezVCb9L5shn/j6lBq2g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzj9XWZh3/UajQHxww4oXLGePxeUijNUE54IZ0Otlh8p5FgzNIq
	WSt/qN8O0wN0HubfF4SQjxkBmkTfbCd7PJQpnZpSLfrOhOETakQ7KJK5mJ8BfB4EBis=
X-Gm-Gg: AfdE7cnNUcuH/mZmhxXQJCLdk4qBTMS7+ug/sXIv6tIDGQTL0xAcWSdMTYKWxIu2Dn2
	5n+HyO3GEpNiSZpHnSgBJtcXkad6rOWUg4s5LugNQHtejE7KnAUv+4YScd/bLryTfYkPpDbgGsZ
	IEbZ0x/wqnnpyFeF90DMPyXgzv5GcMXxQhpFICZfXHjYM2aRgOCKoo/tVr2gkQVI/PQQe9OMAy1
	aVRWx4uyBYV4ZC13gPOllYMdrmSXxI4V3r8ifIX6AL+mEJwREBnD8LHNgnMXWuHVGOtLCZxKvsA
	lm8JDeI65JmcB9XIE/DXAEBiN5N25Ch5/LL04Ki9AWSD3z2j33xK2JujfMQrRSQtzWCWsSn85+V
	K0/vt7hNCrUKrNYRdYsk50W94mOjy0TTEMCTK/KmsfCrpNQPSrKUgabSTwrsSbCgZO6RlZe4p0q
	8wFtasJDqoypdqIFAGyc+GQnNckgMryoPX9KGj9RBmWdu6i4kx1Uv12FMsuyUyKw==
X-Received: by 2002:a05:6830:3492:b0:7e9:bd00:c6ad with SMTP id 46e09a7af769-7ec097e11c2mr8750217a34.16.1784034466935;
        Tue, 14 Jul 2026 06:07:46 -0700 (PDT)
Received: from FJ7FR2JRQ3.bytedance.net ([178.93.176.7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcab8efc3sm14657738a34.0.2026.07.14.06.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 06:07:46 -0700 (PDT)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: will@kernel.org,
	robin.murphy@arm.com,
	fustini@kernel.org,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	james.morse@arm.com,
	babu.moger@amd.com,
	corbet@lwn.net,
	shuah@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH 3/7] resctrl: Add a devices file for external requester assignment
Date: Tue, 14 Jul 2026 21:06:53 +0800
Message-ID: <20260714130657.46963-4-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260714130657.46963-1-zhangzhanpeng.jasper@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not overload the resctrl tasks file with architecture-specific
non-PID tokens. The tasks ABI remains a list of task IDs, while the new
devices file carries external requesters assigned to a resctrl group.

Add architecture hooks for assigning and showing those external
objects, and reject group removal, reparenting, or pseudo-lock setup
while devices are still assigned. The teardown path performs a
best-effort reset to the default group.

The devices file is an assignment interface only. It does not describe
a new resource schema or domain; resource allocation and monitoring
policy remain described by the existing schemata and info files.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 Documentation/filesystems/resctrl.rst |  26 ++++
 arch/Kconfig                          |   6 +
 fs/resctrl/rdtgroup.c                 | 206 +++++++++++++++++++++++++-
 include/linux/resctrl.h               |  45 ++++++
 4 files changed, 280 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystems/resctrl.rst
index e4b66af55ffb..fce61d019114 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -581,6 +581,32 @@ All groups contain the following files:
 	idle tasks. Instead, a CPU's idle task is always considered as a
 	member of the group owning the CPU.
 
+"devices":
+	On architectures that support external requester assignment through
+	resctrl, reading this file shows the devices or device groups assigned
+	to this resource group. Writing an architecture-specific device token
+	moves that external requester to the group. Multiple tokens can be
+	separated by commas and are processed sequentially. A failure aborts the
+	write, but requesters moved before the failure remain in their new groups.
+
+	On RISC-V, an IOMMU group is identified by the following token::
+
+		 iommu_group:<group-id>
+
+	Each assigned IOMMU group is reported on a separate line when the file is
+	read. Writing the token to the root control group's devices file restores
+	the IOMMU group to the reserved default QoS IDs. Default assignments are
+	not listed in the root devices file.
+
+	This file only controls external requester membership. Resource
+	allocation and monitoring policy remains described by schemata and
+	info files.
+
+	Resource groups with assigned devices cannot be removed or reparented.
+	Move devices to another group first.
+
+	Failures will be logged to /sys/fs/resctrl/info/last_cmd_status.
+
 "cpus":
 	Reading this file shows a bitmask of the logical CPUs owned by
 	this group. Writing a mask to this file will add and remove
diff --git a/arch/Kconfig b/arch/Kconfig
index fa7507ac8e13..36a4f4fbb164 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1615,6 +1615,12 @@ config ARCH_HAS_CPU_RESCTRL
 	  monitoring and control interfaces provided by the 'resctrl'
 	  filesystem (see RESCTRL_FS).
 
+config ARCH_HAS_RESCTRL_DEVICES
+	bool
+	help
+	  An architecture selects this option to indicate that external
+	  device objects can be attached to resctrl resource groups.
+
 config HAVE_ARCH_COMPILER_H
 	bool
 	help
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index af2cbab14497..2e424c911049 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -99,13 +99,32 @@ void rdt_last_cmd_puts(const char *s)
 	seq_buf_puts(&last_cmd_status, s);
 }
 
+void resctrl_last_cmd_puts(const char *s)
+{
+	rdt_last_cmd_puts(s);
+}
+
+static void rdt_last_cmd_vprintf(const char *fmt, va_list ap)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+}
+
 void rdt_last_cmd_printf(const char *fmt, ...)
 {
 	va_list ap;
 
 	va_start(ap, fmt);
-	lockdep_assert_held(&rdtgroup_mutex);
-	seq_buf_vprintf(&last_cmd_status, fmt, ap);
+	rdt_last_cmd_vprintf(fmt, ap);
+	va_end(ap);
+}
+
+void resctrl_last_cmd_printf(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	rdt_last_cmd_vprintf(fmt, ap);
 	va_end(ap);
 }
 
@@ -766,6 +785,151 @@ static int rdtgroup_move_task(pid_t pid, struct rdtgroup *rdtgrp,
 	return ret;
 }
 
+static bool rdtgroup_effective_ids(struct rdtgroup *r,
+				   struct resctrl_group_ids *ids)
+{
+	if (!r || !ids)
+		return false;
+
+	if (r->type == RDTMON_GROUP)
+		ids->closid = r->mon.parent->closid;
+	else if (r->type == RDTCTRL_GROUP)
+		ids->closid = r->closid;
+	else
+		return false;
+
+	ids->rmid = r->mon.rmid;
+	return true;
+}
+
+#ifdef CONFIG_ARCH_HAS_RESCTRL_DEVICES
+static void show_rdt_devices(struct rdtgroup *r, struct seq_file *s)
+{
+	struct resctrl_group_ids ids;
+
+	if (rdtgroup_effective_ids(r, &ids))
+		resctrl_arch_devices_show(s, ids);
+}
+
+static int rdtgroup_reset_all_devices(struct rdtgroup *to)
+{
+	struct resctrl_group_ids default_ids;
+
+	if (!to || !rdtgroup_effective_ids(to, &default_ids))
+		return 0;
+
+	return resctrl_arch_devices_reset_all(default_ids);
+}
+
+static bool rdtgroup_arch_devices_assigned(struct rdtgroup *rdtgrp)
+{
+	struct resctrl_group_ids ids;
+
+	if (!rdtgroup_effective_ids(rdtgrp, &ids))
+		return false;
+
+	return resctrl_arch_devices_assigned(ids);
+}
+
+static bool rdtgroup_child_arch_devices_assigned(struct rdtgroup *rdtgrp)
+{
+	struct rdtgroup *crgrp;
+
+	list_for_each_entry(crgrp, &rdtgrp->mon.crdtgrp_list, mon.crdtgrp_list) {
+		if (rdtgroup_arch_devices_assigned(crgrp))
+			return true;
+	}
+
+	return false;
+}
+
+static int rdtgroup_reject_assigned_devices(struct rdtgroup *rdtgrp,
+					    bool include_children,
+					    const char *operation)
+{
+	if (!rdtgroup_arch_devices_assigned(rdtgrp) &&
+	    (!include_children || !rdtgroup_child_arch_devices_assigned(rdtgrp)))
+		return 0;
+
+	rdt_last_cmd_printf("Move devices out before %s group\n", operation);
+	return -EBUSY;
+}
+
+static ssize_t rdtgroup_devices_write(struct kernfs_open_file *of,
+				      char *buf, size_t nbytes, loff_t off)
+{
+	struct resctrl_group_ids ids;
+	struct rdtgroup *rdtgrp;
+	char *tok;
+	int ret = 0;
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
+	if (!rdtgroup_effective_ids(rdtgrp, &ids)) {
+		ret = -EINVAL;
+		goto unlock;
+	}
+
+	while ((tok = strsep(&buf, ","))) {
+		tok = strim(tok);
+		if (!*tok) {
+			rdt_last_cmd_puts("Device list parsing error\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		ret = resctrl_arch_devices_write(tok, ids);
+		if (ret)
+			break;
+	}
+
+unlock:
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
+static int rdtgroup_devices_show(struct kernfs_open_file *of,
+				 struct seq_file *s, void *v)
+{
+	struct rdtgroup *rdtgrp;
+	int ret = 0;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (rdtgrp)
+		show_rdt_devices(rdtgrp, s);
+	else
+		ret = -ENOENT;
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret;
+}
+#else
+static inline int rdtgroup_reset_all_devices(struct rdtgroup *to)
+{
+	return 0;
+}
+
+static inline int rdtgroup_reject_assigned_devices(struct rdtgroup *rdtgrp,
+						   bool include_children,
+						   const char *operation)
+{
+	return 0;
+}
+#endif
+
 static ssize_t rdtgroup_tasks_write(struct kernfs_open_file *of,
 				    char *buf, size_t nbytes, loff_t off)
 {
@@ -1491,6 +1655,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
 	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
 		   !strcmp(buf, "pseudo-locksetup")) {
+		ret = rdtgroup_reject_assigned_devices(rdtgrp, true,
+						       "entering pseudo-locksetup");
+		if (ret)
+			goto out;
+
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
@@ -2067,6 +2236,16 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+#ifdef CONFIG_ARCH_HAS_RESCTRL_DEVICES
+	{
+		.name		= "devices",
+		.mode		= 0644,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= rdtgroup_devices_write,
+		.seq_show	= rdtgroup_devices_show,
+		.fflags		= RFTYPE_BASE,
+	},
+#endif
 	{
 		.name		= "mon_hw_id",
 		.mode		= 0444,
@@ -3061,6 +3240,8 @@ static void rmdir_all_sub(void)
 	/* Move all tasks to the default resource group */
 	rdt_move_group_tasks(NULL, &rdtgroup_default, NULL);
 
+	WARN_ON_ONCE(rdtgroup_reset_all_devices(&rdtgroup_default));
+
 	list_for_each_entry_safe(rdtgrp, tmp, &rdt_all_groups, rdtgroup_list) {
 		/* Free any child rmids */
 		free_all_child_rdtgrp(rdtgrp);
@@ -3970,6 +4151,11 @@ static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 	struct rdtgroup *prdtgrp = rdtgrp->mon.parent;
 	u32 closid, rmid;
 	int cpu;
+	int ret;
+
+	ret = rdtgroup_reject_assigned_devices(rdtgrp, false, "removing");
+	if (ret)
+		return ret;
 
 	/* Give any tasks back to the parent group */
 	rdt_move_group_tasks(rdtgrp, prdtgrp, tmpmask);
@@ -4020,6 +4206,11 @@ static int rdtgroup_rmdir_ctrl(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
 {
 	u32 closid, rmid;
 	int cpu;
+	int ret;
+
+	ret = rdtgroup_reject_assigned_devices(rdtgrp, true, "removing");
+	if (ret)
+		return ret;
 
 	/* Give any tasks back to the default group */
 	rdt_move_group_tasks(rdtgrp, &rdtgroup_default, tmpmask);
@@ -4093,7 +4284,10 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	    rdtgrp != &rdtgroup_default) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
-			ret = rdtgroup_ctrl_remove(rdtgrp);
+			ret = rdtgroup_reject_assigned_devices(rdtgrp, true,
+							       "removing");
+			if (!ret)
+				ret = rdtgroup_ctrl_remove(rdtgrp);
 		} else {
 			ret = rdtgroup_rmdir_ctrl(rdtgrp, tmpmask);
 		}
@@ -4210,6 +4404,12 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		goto out;
 	}
 
+	if (rdtgrp->mon.parent != new_prdtgrp) {
+		ret = rdtgroup_reject_assigned_devices(rdtgrp, false, "reparenting");
+		if (ret)
+			goto out;
+	}
+
 	/*
 	 * Allocate the cpumask for use in mongrp_reparent() to avoid the
 	 * possibility of failing to allocate it after kernfs_rename() has
diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index 73ff522448a0..a4b5c2d5e814 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -8,6 +8,8 @@
 #include <linux/pid.h>
 #include <linux/resctrl_types.h>
 
+struct seq_file;
+
 #ifdef CONFIG_ARCH_HAS_CPU_RESCTRL
 #include <asm/resctrl.h>
 #endif
@@ -18,6 +20,49 @@
 
 #define RESCTRL_PICK_ANY_CPU		-1
 
+/**
+ * struct resctrl_group_ids - resctrl control and monitoring IDs
+ * @closid: resource control class ID
+ * @rmid: resource monitoring ID
+ */
+struct resctrl_group_ids {
+	u32 closid;
+	u32 rmid;
+};
+
+void resctrl_last_cmd_puts(const char *s);
+void resctrl_last_cmd_printf(const char *fmt, ...) __printf(1, 2);
+
+#ifdef CONFIG_ARCH_HAS_RESCTRL_DEVICES
+int resctrl_arch_devices_write(char *tok, struct resctrl_group_ids ids);
+void resctrl_arch_devices_show(struct seq_file *s,
+			       struct resctrl_group_ids ids);
+bool resctrl_arch_devices_assigned(struct resctrl_group_ids ids);
+int resctrl_arch_devices_reset_all(struct resctrl_group_ids default_ids);
+#else
+static inline int resctrl_arch_devices_write(char *tok,
+					     struct resctrl_group_ids ids)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void resctrl_arch_devices_show(struct seq_file *s,
+					     struct resctrl_group_ids ids)
+{
+}
+
+static inline bool resctrl_arch_devices_assigned(struct resctrl_group_ids ids)
+{
+	return false;
+}
+
+static inline int
+resctrl_arch_devices_reset_all(struct resctrl_group_ids default_ids)
+{
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 int proc_resctrl_show(struct seq_file *m,
-- 
2.50.1 (Apple Git-155)

