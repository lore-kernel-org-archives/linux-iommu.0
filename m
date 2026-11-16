Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794813248;
	b=5NT8nSWEBkpMKuk9E4iq5RUd+2st4CFrOZFCqxj+plYUqi+7Jc/zkJRm2tgSZZAf9qcJ
	 x+30t4xs7tXb1S3w7lK9MuSwH6W6+OF0tM6YHGSnxnz33HNGgi5hGgLzcW5yHAX41sjhU
	 06c75LQvg7OnP4gOqqz1wAVjQBLg0QXfw25E3Ue+JGmgr7xiPjXqBoYdOIZOpJRn7CRNi
	 bGEsjK/WrSMYWZZ+GLBX2IyrIylimBX+MUSZJHZBpGWtmqsJrcrvmeaFRoXfyWCeLsr7J
	 qYgavLgj2hAQuMQ6dvhcXSxyWWHCcXjR9IHiyEoSC7B78yKYZA1Q8sGFCwUhU16WGqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794813248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BuQq4JFvVTaug2dVoyrAXV50xaKQGTRvxFBICoP+1lY=;
	b=pAfsKsLj83O+KTdn3p2A68Das+QsQuVFNUKOWPkTAvp4SgdWfpFVcPfvzSw8T+oe69lO
	 wHgm2vMqs9JPi13Rt1BSDY2ym9xoncBMmkEISCjzQFoC6WJoFi3W9GJ0OkMAVVZah+xW4
	 Bz3PhogW8L+DXhaIi0eYM3Az9zWMhZEWU8ZNxsSZGQX4tUmLfIUu+cxr0tUcbNu+U2bg9
	 UX89HHBdiOgGL+TiypzZCoyZ184uhVkdBxZtfgcd9uxBTQa5GW0KLB9fsTDib64TP4f44
	 b8V+Jqk93scy9BZtjhINHEpMiNtZlVNse3FNkscjIlPr8Xgy9DIuuvwg90geEtFeBnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a476DZVy;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D69606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 07:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D69606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=a476DZVy
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-36dbde64409so4553408eec.0
        for <iommu@lists.linux.dev>; Sun, 15 Nov 2026 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794813247; x=1795418047; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BuQq4JFvVTaug2dVoyrAXV50xaKQGTRvxFBICoP+1lY=;
        b=a476DZVyw42B5wc2EUNON6gv1SVRp6HqMf4FVp9Kgs128GxXkNlX6usSSq7O45WjrD
         vBpPX6YVIPXZnVnK0Pl0nTHsKBV69NOkOORfeZx0tzCwWsKKtlx3AhNp1jG8wArsJd3t
         5vDQaWlLBzVM2EE5Kiyop8aBLmnGv3ZT+pK6jmtYuTlM3rcJKsF40U1BFVqI6CxpjT8j
         LwW1elFEE47NLfQd7ifSHEGUmPmvDZ/i1lchqLNzsuy/mIbjoTEYG3fJZ0lhfifYX05e
         ScPVOwoOyJWcChcLobetUTMZmKR5NSqc/sME+hc8Q5ol5WAiVoXe1AfrvoIQgBGkQ9a0
         /cgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794813247; x=1795418047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BuQq4JFvVTaug2dVoyrAXV50xaKQGTRvxFBICoP+1lY=;
        b=FobPgv+gy2P2zrlb6TbYaE3+REmtG+mzFWzxgN2VUFiCjEZWG+EyVEd2MmOXR7aYnB
         LzpxvsMpQRdWour/sp4VHQeuWSQqeAHqbtEJNlwdnC5pvQYW4a0c8flHh0SDJ4GNtzxS
         ddkp+OAEjOWSjExOQqgSW7SZ0foakSVdFTjUHnNGxSWc5rQ1tVoPJ0eJu8gRsPBpwXlj
         XCl89Nh2ZjfDMUVs8qohW91+hRdjFUFqwFYkmJOGOYkg8frKas18347U07WIHdRTHXdy
         lSNhtNfh2pIlIY3vi+iW5M9PGTGaGfCTVFMFsrEQTgiSOVXE83qyD9jicl4Tp1GULtsX
         Lo7Q==
X-Forwarded-Encrypted: i=1; AL+hErENGQsJloR27O+FwNuL8KtO3KVvshc3Ve6SPEDlQm1kB6jNPez5FQE5bxIvDHQodjVVlzbfCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z854sT1KKarduZdU8N8i5RbTvQCh5BOWtQPLQiGBnGAnZtIo9pc
	RrmaMwM7IDbErwG2zkzSJFDQd9TUsmVh0PmqtDTclvM9KOlqrn4aHvAr0H+JqouTNZc=
X-Gm-Gg: AYBFou25FJ/daE0LRloWJGrLKdzG0evro13WT1sFW9TZ0Hv/dahNJ/LWDJwgKk5+o9d
	r+jLvUhbnc37tqcAkECC6BEyY4UdKceLvY0QsYtTWT3fsYyvO93+R9RzsGBst3kyXJF2ZS8rKyr
	tDqLnJ1OnTrlckOSuSIg/3NqxfqaYomEAJHV69satZy76qMSjNCdI7BZmSh4VDf6cQQM9BLhdZG
	T/8kOMBABXxb8D+6dYeh/LdPxZhncLHjA0iJ2aggudL5tjCLKcxGiflrqzmqHIN7O7VcsgwQn27
	Tc2UOq1+0Cd3pAuA+Y9xIO5LHFufCRIFYlT3uejDgzHJ9SieTuYqRR356/z65SJyCMa/Av8LTI4
	Fpr2JVNBa4apLhOFanKFkiInifJHTWRKORo2ojh/FTv5D2Pf3DoDemorNXn7OUaF+9ld7Y8A3rX
	Xb8u7crcw2/a0Mm1HjfpxfoCsckVGWAbr0MKPq0PlTwZsDRVk7Hb/ViCe6G5Fb2O7HJnl54mV1j
	G35disnzKH+Q2VzKbV0Wm4MZxavSx8acWPL1m03dwPFMUaEMD84updXkeT5W2haFACeIddf5bw1
	RM8Zx1MUZpu5mbg0zC1A+PEnxKADxJFJLFH71ejwlgtKPlVaCcflQqC4/m8YDho1TlZtsmcGUax
	xCkPZj4g=
X-Received: by 2002:a05:7301:c017:b0:36a:31b2:8643 with SMTP id 5a478bee46e88-37967dd4caamr9968595eec.38.1794813246758;
        Sun, 15 Nov 2026 23:14:06 -0800 (PST)
Received: from FJ7FR2JRQ3.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332ae7sm47858505eec.8.2026.11.15.23.13.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Nov 2026 23:14:06 -0800 (PST)
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
To: joro@8bytes.org,
	palmer@dabbelt.com,
	tony.luck@intel.com,
	reinette.chatre@intel.com,
	tomasz.jeznach@linux.dev
Cc: fustini@kernel.org,
	jgg@ziepe.ca,
	james.morse@arm.com,
	ben.horgan@arm.com,
	xiaqinxin@huawei.com,
	will@kernel.org,
	robin.murphy@arm.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	Dave.Martin@arm.com,
	babu.moger@amd.com,
	kevin.tian@intel.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	shuah@kernel.org,
	randy.dunlap@infradead.org,
	cuiyunhui@bytedance.com,
	yuanzhu@bytedance.com,
	iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [RFC PATCH v2 1/4] resctrl: Add registered device assignment
Date: Mon, 16 Nov 2026 15:13:40 +0800
Message-ID: <20261116071338.35991-7-zhangzhanpeng.jasper@bytedance.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
References: <20261116071338.35991-6-zhangzhanpeng.jasper@bytedance.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep requester discovery and hardware programming in providers. Common
resctrl owns a bus/name registry and resource-group membership, with one
sleepable set_ids callback per provider. Keep filesystem integration small
and separate from the registry implementation.

Snapshot runtime availability at mount, serialize assignment with
unregister, reject removal of assigned groups, and quarantine ID reuse
after an uncertain hardware update. Recovery and dynamic creation of the
first devices file are intentionally outside this RFC.

Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
---
 fs/resctrl/Makefile            |   2 +-
 fs/resctrl/devices.c           | 233 +++++++++++++++++++++++++++++++++
 fs/resctrl/internal.h          |   8 ++
 fs/resctrl/rdtgroup.c          |  28 ++++
 include/linux/resctrl_device.h |  53 ++++++++
 5 files changed, 323 insertions(+), 1 deletion(-)
 create mode 100644 fs/resctrl/devices.c
 create mode 100644 include/linux/resctrl_device.h

diff --git a/fs/resctrl/Makefile b/fs/resctrl/Makefile
index e67f34d2236a..1cd663c3309a 100644
--- a/fs/resctrl/Makefile
+++ b/fs/resctrl/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o
+obj-$(CONFIG_RESCTRL_FS)		+= rdtgroup.o ctrlmondata.o monitor.o devices.o
 obj-$(CONFIG_RESCTRL_FS_PSEUDO_LOCK)	+= pseudo_lock.o
 
 # To allow define_trace.h's recursive include:
diff --git a/fs/resctrl/devices.c b/fs/resctrl/devices.c
new file mode 100644
index 000000000000..f98d375e6934
--- /dev/null
+++ b/fs/resctrl/devices.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Registered, independently tagged devices assigned to resctrl groups. */
+#include <linux/capability.h>
+#include <linux/device.h>
+#include <linux/resctrl_device.h>
+#include <linux/slab.h>
+
+#include "internal.h"
+
+/* All registry, ownership and callback access is under rdtgroup_mutex. */
+struct resctrl_device {
+	struct list_head list;
+	struct device *dev;
+	const struct resctrl_device_ops *ops;
+	struct rdtgroup *group; /* NULL denotes the default group. */
+	char *token; /* Stable bus/name identity; not a sysfs pathname. */
+};
+
+static LIST_HEAD(resctrl_devices);
+/* No recovery protocol yet: never recycle IDs after an uncertain update. */
+static bool devices_quarantined;
+/* File visibility is a mount-time capability snapshot. */
+static bool devices_enabled;
+
+static struct resctrl_device *resctrl_device_find(struct device *dev)
+{
+	struct resctrl_device *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+	list_for_each_entry(entry, &resctrl_devices, list)
+		if (entry->dev == dev)
+			return entry;
+	return NULL;
+}
+
+int resctrl_device_register(struct device *dev,
+			    const struct resctrl_device_ops *ops)
+{
+	struct resctrl_device *entry, *other;
+	int ret = 0;
+
+	if (!dev->bus || !ops || !ops->set_ids ||
+	    strpbrk(dev->bus->name, "/ \t\n\r\v\f,") ||
+	    strpbrk(dev_name(dev), "/ \t\n\r\v\f,"))
+		return -EINVAL;
+
+	entry = kzalloc_obj(*entry);
+	if (!entry)
+		return -ENOMEM;
+	entry->token = kasprintf(GFP_KERNEL, "%s/%s", dev->bus->name,
+				 dev_name(dev));
+	if (!entry->token) {
+		kfree(entry);
+		return -ENOMEM;
+	}
+	entry->dev = get_device(dev);
+	entry->ops = ops;
+
+	mutex_lock(&rdtgroup_mutex);
+	list_for_each_entry(other, &resctrl_devices, list) {
+		if (other->dev == dev || !strcmp(other->token, entry->token)) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+	list_add_tail(&entry->list, &resctrl_devices);
+out:
+	mutex_unlock(&rdtgroup_mutex);
+	if (ret) {
+		put_device(entry->dev);
+		kfree(entry->token);
+		kfree(entry);
+	}
+	return ret;
+}
+EXPORT_SYMBOL_GPL(resctrl_device_register);
+
+void resctrl_device_unregister(struct device *dev)
+{
+	struct resctrl_device *entry;
+
+	mutex_lock(&rdtgroup_mutex);
+	entry = resctrl_device_find(dev);
+	if (!entry)
+		goto out;
+
+	if (entry->ops->set_ids(dev, (struct resctrl_device_ids){})) {
+		devices_quarantined = true;
+		dev_err(dev, "resctrl: reset failed; ID reuse disabled\n");
+	}
+	list_del(&entry->list);
+	put_device(entry->dev);
+	kfree(entry->token);
+	kfree(entry);
+out:
+	mutex_unlock(&rdtgroup_mutex);
+}
+EXPORT_SYMBOL_GPL(resctrl_device_unregister);
+
+bool resctrl_devices_visible(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+	return devices_enabled;
+}
+
+int resctrl_devices_prepare_mount(void)
+{
+	lockdep_assert_held(&rdtgroup_mutex);
+	if (devices_quarantined)
+		return -EIO;
+	devices_enabled = !list_empty(&resctrl_devices);
+	return 0;
+}
+
+/* Must precede freeing any resource group or its IDs. */
+void resctrl_devices_unmount(void)
+{
+	struct resctrl_device *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+	list_for_each_entry(entry, &resctrl_devices, list) {
+		if (entry->group &&
+		    entry->ops->set_ids(entry->dev,
+					(struct resctrl_device_ids){})) {
+			devices_quarantined = true;
+			dev_err(entry->dev, "resctrl: unmount reset failed\n");
+		}
+		entry->group = NULL;
+	}
+	devices_enabled = false;
+}
+
+/* Includes monitor children when the caller changes/removes a CTRL group. */
+int resctrl_devices_check_group(struct rdtgroup *group)
+{
+	struct resctrl_device *entry;
+
+	lockdep_assert_held(&rdtgroup_mutex);
+	if (devices_quarantined) {
+		rdt_last_cmd_puts("Device QoS state uncertain; reboot required\n");
+		return -EIO;
+	}
+	list_for_each_entry(entry, &resctrl_devices, list) {
+		if (entry->group == group ||
+		    (entry->group && entry->group->type == RDTMON_GROUP &&
+		     entry->group->mon.parent == group)) {
+			rdt_last_cmd_puts("Move assigned devices to the default group first\n");
+			return -EBUSY;
+		}
+	}
+	return 0;
+}
+
+int resctrl_devices_show(struct kernfs_open_file *of, struct seq_file *s,
+			 void *v)
+{
+	struct rdtgroup *group = rdtgroup_kn_lock_live(of->kn);
+	struct resctrl_device *entry;
+	int ret = 0;
+
+	if (!group) {
+		ret = -ENOENT;
+		goto out;
+	}
+	if (devices_quarantined) {
+		ret = -EIO;
+		goto out;
+	}
+	if (group == &rdtgroup_default)
+		group = NULL;
+	list_for_each_entry(entry, &resctrl_devices, list)
+		if (entry->group == group)
+			seq_printf(s, "%s\n", entry->token);
+out:
+	rdtgroup_kn_unlock(of->kn);
+	return ret;
+}
+
+ssize_t resctrl_devices_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off)
+{
+	struct resctrl_device_ids ids;
+	struct resctrl_device *entry;
+	struct rdtgroup *group;
+	char *token;
+	int ret = -ENODEV;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+	group = rdtgroup_kn_lock_live(of->kn);
+	if (!group) {
+		ret = -ENOENT;
+		goto out;
+	}
+	if (off || memchr(buf, '\0', nbytes)) {
+		ret = -EINVAL;
+		goto out;
+	}
+	token = strim(buf);
+	if (devices_quarantined) {
+		ret = -EIO;
+		goto out;
+	}
+	if (group->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
+	    group->mode == RDT_MODE_PSEUDO_LOCKED ||
+	    (group->type == RDTMON_GROUP &&
+	     group->mon.parent->mode != RDT_MODE_SHAREABLE)) {
+		ret = -EBUSY;
+		goto out;
+	}
+	/* One registered identity per write, with no path or list parsing. */
+	if (!*token || strpbrk(token, " \t\n\r\v\f,")) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ids.closid = group->closid;
+	ids.rmid = group->mon.rmid;
+	list_for_each_entry(entry, &resctrl_devices, list) {
+		if (strcmp(entry->token, token))
+			continue;
+		ret = entry->ops->set_ids(entry->dev, ids);
+		if (!ret)
+			entry->group = group == &rdtgroup_default ? NULL : group;
+		else if (ret == -EIO || ret == -ETIMEDOUT)
+			devices_quarantined = true;
+		break;
+	}
+out:
+	if (ret)
+		rdt_last_cmd_printf("Device assignment failed: %d\n", ret);
+	rdtgroup_kn_unlock(of->kn);
+	return ret ? ret : nbytes;
+}
diff --git a/fs/resctrl/internal.h b/fs/resctrl/internal.h
index e62a277dee85..4bebd998bdb7 100644
--- a/fs/resctrl/internal.h
+++ b/fs/resctrl/internal.h
@@ -335,6 +335,14 @@ __printf(1, 2)
 void rdt_last_cmd_printf(const char *fmt, ...);
 
 struct rdtgroup *rdtgroup_kn_lock_live(struct kernfs_node *kn);
+bool resctrl_devices_visible(void);
+int resctrl_devices_prepare_mount(void);
+void resctrl_devices_unmount(void);
+int resctrl_devices_check_group(struct rdtgroup *group);
+int resctrl_devices_show(struct kernfs_open_file *of, struct seq_file *s,
+			 void *v);
+ssize_t resctrl_devices_write(struct kernfs_open_file *of, char *buf,
+			      size_t nbytes, loff_t off);
 void rdtgroup_kn_unlock(struct kernfs_node *kn);
 bool info_kn_lock(struct kernfs_node *kn);
 void info_kn_unlock(struct kernfs_node *kn);
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 57ab090072c2..4d3417273934 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -1560,6 +1560,9 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		}
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	} else if (!strcmp(buf, "exclusive")) {
+		ret = resctrl_devices_check_group(rdtgrp);
+		if (ret)
+			goto out;
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
 			ret = -EINVAL;
 			goto out;
@@ -1572,6 +1575,9 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
 	} else if (IS_ENABLED(CONFIG_RESCTRL_FS_PSEUDO_LOCK) &&
 		   !strcmp(buf, "pseudo-locksetup")) {
+		ret = resctrl_devices_check_group(rdtgrp);
+		if (ret)
+			goto out;
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
@@ -2158,6 +2164,14 @@ static struct rftype res_common_files[] = {
 		.seq_show	= rdtgroup_tasks_show,
 		.fflags		= RFTYPE_BASE,
 	},
+	{
+		.name		= "devices",
+		.mode		= 0600,
+		.kf_ops		= &rdtgroup_kf_single_ops,
+		.write		= resctrl_devices_write,
+		.seq_show	= resctrl_devices_show,
+		.fflags		= RFTYPE_BASE,
+	},
 	{
 		.name		= "mon_hw_id",
 		.mode		= 0444,
@@ -2225,6 +2239,8 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
 		fflags |= RFTYPE_DEBUG;
 
 	for (rft = rfts; rft < rfts + len; rft++) {
+		if (!strcmp(rft->name, "devices") && !resctrl_devices_visible())
+			continue;
 		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
 			ret = rdtgroup_add_file(kn, rft);
 			if (ret)
@@ -3132,6 +3148,7 @@ static void resctrl_fs_teardown(void)
 	if (!rdtgroup_default.kn)
 		return;
 
+	resctrl_devices_unmount();
 	rmdir_all_sub();
 	rdtgroup_unassign_cntrs(&rdtgroup_default);
 	mon_put_kn_priv();
@@ -3192,6 +3209,9 @@ static int rdt_get_tree(struct fs_context *fc)
 		ret = -EBUSY;
 		goto out;
 	}
+	ret = resctrl_devices_prepare_mount();
+	if (ret)
+		goto out;
 
 	ret = setup_rmid_lru_list();
 	if (ret)
@@ -4278,6 +4298,9 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 		goto out;
 	}
 	parent_kn = rdt_kn_parent(kn);
+	ret = resctrl_devices_check_group(rdtgrp);
+	if (ret)
+		goto out;
 
 	/*
 	 * If the rdtgroup is a ctrl_mon group and parent directory
@@ -4394,6 +4417,11 @@ static int rdtgroup_rename(struct kernfs_node *kn,
 		ret = -EPERM;
 		goto out;
 	}
+	if (rdtgrp->mon.parent != new_prdtgrp) {
+		ret = resctrl_devices_check_group(rdtgrp);
+		if (ret)
+			goto out;
+	}
 
 	/*
 	 * If the MON group is monitoring CPUs, the CPUs must be assigned to the
diff --git a/include/linux/resctrl_device.h b/include/linux/resctrl_device.h
new file mode 100644
index 000000000000..a39f674739d6
--- /dev/null
+++ b/include/linux/resctrl_device.h
@@ -0,0 +1,53 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RESCTRL_DEVICE_H
+#define _LINUX_RESCTRL_DEVICE_H
+
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
+
+struct device;
+
+/* Resource-group IDs, interpreted by the architecture's request tagger. */
+struct resctrl_device_ids {
+	u32 closid;
+	u32 rmid;
+};
+
+/**
+ * struct resctrl_device_ops - program one independently tagged requester
+ * @set_ids: Complete the update before returning zero. Validation errors must
+ *	leave the old IDs intact. Return -EIO if hardware state is uncertain;
+ *	resctrl then prevents ID reuse. Called in sleepable context, serialized
+ *	with assignment and unregister. Must not call back into resctrl.
+ */
+struct resctrl_device_ops {
+	int (*set_ids)(struct device *dev, struct resctrl_device_ids ids);
+};
+
+#ifdef CONFIG_RESCTRL_FS
+/*
+ * Register only after hardware and driver-private state are ready. The bus and
+ * device names must remain stable until unregister. Initial IDs must be zero.
+ * The driver must own the tag fields exclusively, including across reattach.
+ */
+int resctrl_device_register(struct device *dev,
+			    const struct resctrl_device_ops *ops);
+
+/*
+ * Remove the requester and drain callbacks BEFORE freeing driver state.
+ * This also resets its IDs. A failed reset quarantines resctrl until reboot,
+ * rather than recycling IDs which the device might still be using.
+ */
+void resctrl_device_unregister(struct device *dev);
+#else
+static inline int
+resctrl_device_register(struct device *dev, const struct resctrl_device_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void resctrl_device_unregister(struct device *dev) { }
+#endif
+
+#endif
-- 
2.50.1 (Apple Git-155)

