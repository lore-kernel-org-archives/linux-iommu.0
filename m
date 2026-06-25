Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD19387363
	for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380066; cv=none; b=DQ/BYngWoGsRhUQF2+tIdy8lFg9B/JpU878DVjDkwE6Hybekn8S2qLE9XU9cyhPELnmP0seRKngXnffThNTB2XzrdOFZrXB60Wm0pF3UhhNLYPmv/GGM8ZL1Mj4I71PhyRjx9Y3SqMkIyrgD+ccDirJIzRqX4oVcjpAbAQrK764=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380066; c=relaxed/simple;
	bh=YMMr9RRiGqMF7PQhm0kMMZ6gvvbut+7gbRTPmff6HJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAxJQOaacaBSJfy2ykUT+71KXVa5zzlP6nJUolD4mDUxUx4VJhl1xk3mQSYHCkCrx2OWNwzUF6CtvpVSebZuXH3vu4W09cLOfACpFI14dAyKTYnUavn5T9ls2gIFY+fNtL/ssNIbTY34aMsZ+vrzQS566LtZYkCsMeUCw2r1uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rDc71A49; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDc71A49"
Received: by mail-pj2-f4.google.com with SMTP id 98e67ed59e1d1-37dcc1ef35dso25957a91.0
        for <iommu@lists.linux.dev>; Thu, 25 Jun 2026 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782380063; x=1782984863; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1qPFW7V6FcXhucM4uqGUnMjNmz8eHjPw7xkWHkZ93k=;
        b=rDc71A49jadLw2XdDIfXAWyyh5xXFmaeARlwLPoC48hNMYYEWuebELlQdo2w9aQVNf
         JwaUXuN+PEl1btF9dd/J63MpL/D7F+JDl8EbH0TyP3pRmGkOn+VsDi6X4jltaEaItgQC
         aQoQzN84nga8ph7NsxK6jROTE/Dwofb1+RHiLMsdBtUBfX+//xtwO2zh7FR6veY4XbXR
         RdpyJfANQLbghmokPZDVE4yKpc+ZsrOOWZwMOGTche6sewvdUNVBsMH0prP/0AZzq93Q
         0WLer+Xgs9m/UvtYvtvBjJ4xMlSM6OeGGQ21KwTbpUfbscPO/YKZTLGArJkd2R3Nue7R
         ba0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380063; x=1782984863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s1qPFW7V6FcXhucM4uqGUnMjNmz8eHjPw7xkWHkZ93k=;
        b=BDqxpsbJ5L0ghIX4pt8U73VlQ4pNkvZfN6cG/1yQ65WeOA8KwMwXSbk2PCEVPNaLz2
         paYcXj+omWWxPbZqNtFu6c38JOSQ0gtiMcwkts5I9hq9VdbYrFDcYJpIsoeh6t0zvxHP
         4aDFGJjgBTDCqOiqipbr/uQnZrEnlTWv8jly+StoXyFS6mfm8JGD2BsESt1rLj2dKPUJ
         SHKHSQAgO+cBh5L5kWJ6L62BO8DGSKMeQ2Vhp0NRf0Ghc7o5xnL+55/+jwXyl+NtHo04
         xB943CQpOfJexLHlht/sib5k4DWO5s/xEg0WMbOtMPGghl64N2m2J17n7LMbXvcO5KxN
         BY0Q==
X-Gm-Message-State: AOJu0YyvoHuRq4SkYSS2IdW5HlT+CeF/P+8/dOllN70DXJerP8a4flmT
	KuuWypmr8fisCsSfC9vAdHc4Vh+sBXdaCVvjSgDf+xRKsM3geP5Tc/iA
X-Gm-Gg: AfdE7cnqMIXyjXpnmlaG2pYz+nlWveFYRksZcf4ahsh64AMhqAKVKyc4JeclU4lRQrk
	z6cAjHoDAJJam7EGnzpd74JDNTeXRDLfA5+eaoufeyKNVc9rqCskoISghhbv+mZ9IibkAQJtGxS
	WF2RU0YhyN0EXQhcnTB6AixY6HAIvHoviXN34Q3jRdBR7jnzVs5f+IVbdUkWQmaqwQh9H+7ugUe
	VbQDHY/imrO+tdR5N02P1SuDuZwg+n20xSBYFstKrmLxcy/ZPzLxgvbl0aUh7iLoS0ZyhwJZbUa
	pb16x3Wf5fki6RflvmvGvCMdi05wySDYcAAngayo1AhpbDe6H72eH33KjOOt4tvOJmp0CoSnOdw
	lJLHrAgiCW0uShVIFXUTluT/21X55gk08nl+pcFWcJYRQcK186AIrgdA6Z4J925Y0PhoOqJV9Rl
	YEANoiVHqjtlP+XmiHx3OmV262mYo5jLfRvEIb9Q==
X-Received: by 2002:a17:90b:3f4b:b0:369:1dbb:4732 with SMTP id 98e67ed59e1d1-37df8dc18a1mr1469532a91.0.1782380062722;
        Thu, 25 Jun 2026 02:34:22 -0700 (PDT)
Received: from q-System-Product-Name ([129.227.183.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df400b68esm1473863a91.13.2026.06.25.02.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:34:22 -0700 (PDT)
From: "bingyu.xian" <shanbeeyoo@gmail.com>
To: tomasz.jeznach@linux.dev,
	joro@8bytes.org,
	will@kernel.org,
	palmer@dabbelt.com,
	pjw@kernel.org,
	aou@eecs.berkeley.edu
Cc: iommu@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Bingyu Shan <shanbeeyoo@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>
Subject: [PATCH 1/1] iommu/riscv: RFC: mark endpoint ATS-broken on ATS invalidation timeout
Date: Thu, 25 Jun 2026 17:34:16 +0800
Message-ID: <20260625093416.4023451-2-shanbeeyoo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625093416.4023451-1-shanbeeyoo@gmail.com>
References: <20260625093416.4023451-1-shanbeeyoo@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bingyu Shan <shanbeeyoo@gmail.com>

A PCIe endpoint that fails to complete an ATS invalidation keeps stale ATC
entries and can keep DMA-ing through them. ARM SMMUv3 recently added handling
for this class of problem (ATC invalidation timeout / quarantine). The RISC-V
IOMMU driver currently has no such handling: riscv_iommu_cmd_sync() only logs
"Hardware error: command execution timeout" once and discards the failure,
with no attribution to a device and no policy response.

This RFC adds the first, conservative milestone:

  * On a command-queue timeout, read CQH to find the offending command. If it
    is an ATS.INVAL, extract its device-id (the RISC-V analog of ARM SMMUv3
    CERROR_ATC_INV_IDX) and schedule deferred marking.

  * The marking worker resolves the device-id back to a struct device, sets a
    per-device ats_broken flag, increments a counter, calls pci_disable_ats(),
    and logs "marked ATS-broken after ATS.INVAL timeout". It is deferred to a
    work item because cmd_sync() may run with only RCU held while the device
    lookup takes a sleeping mutex.

  * riscv_iommu_enable_pdev() refuses pci_enable_ats() for a device already
    marked ats_broken, so a broken endpoint is not put back on the ATS path.

  * Device tracking (the DID-keyed rbtree) previously happened only on the PRI
    enable/disable path, so ATS-only devices were never tracked and could not
    be attributed. Move registration to probe_device/release_device so ATS-only
    devices are tracked. add_device() now takes the iommu explicitly, because
    dev_to_iommu(dev) is not usable inside probe_device() (the iommu core only
    links dev->iommu after probe returns). Also fixes a latent duplicate-devid
    double-unlock in the rbtree insert.

  * Debugfs fault injection (inject_ats_inval_timeout) and a state table
    (ats_devices) so the marking path can be exercised. Real RISC-V IOMMU
    hardware and unmodified QEMU complete ATS.INVAL synchronously, so a native
    timeout cannot be reproduced against a real endpoint; the knob schedules
    the same worker the real cmd_sync() timeout path would.

Full quarantine and PCI reset recovery are intentionally left out of this step.

This RFC is based on the RISC-V IOMMU ATS support series in
tjeznach/riscv_iommu.next, because ATS support is not yet in the IOMMU tree.
It is intended to discuss timeout handling policy, not for immediate merge.
The single patch can be split (rbtree tracking / timeout marking / debugfs)
in a non-RFC version.

Validated on stock QEMU (-device virtio-net-pci,ats=on) with no QEMU changes:

  BEFORE                          AFTER
  0x18 0000:00:03.0 0 0   ->   0x18 0000:00:03.0 1 1
  virtio-pci 0000:00:03.0: marked ATS-broken after ATS.INVAL timeout

Assisted-by: YuanSheng: deepseek-v4-pro
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Bingyu Shan <shanbeeyoo@gmail.com>
---
 drivers/iommu/riscv/iommu.c | 210 ++++++++++++++++++++++++++++++++++--
 drivers/iommu/riscv/iommu.h |   9 ++
 2 files changed, 210 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/riscv/iommu.c b/drivers/iommu/riscv/iommu.c
index 2249eea885cc..98f580dc5b49 100644
--- a/drivers/iommu/riscv/iommu.c
+++ b/drivers/iommu/riscv/iommu.c
@@ -14,14 +14,17 @@
 
 #include <linux/compiler.h>
 #include <linux/crash_dump.h>
+#include <linux/debugfs.h>
 #include <linux/init.h>
 #include <linux/iommu.h>
 #include <linux/iopoll.h>
 #include <linux/irqchip/riscv-imsic.h>
 #include <linux/kernel.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
+#include <linux/seq_file.h>
 
 #include "../iommu-pages.h"
 #include "iommu-bits.h"
@@ -492,12 +495,56 @@ static void riscv_iommu_cmd_send(struct riscv_iommu_device *iommu,
 	riscv_iommu_queue_send(&iommu->cmdq, cmd, sizeof(*cmd));
 }
 
-/* Send IOFENCE.C command and wait for all scheduled commands to complete. */
+static struct device *
+riscv_iommu_get_device(struct riscv_iommu_device *iommu, unsigned int devid);
+static void riscv_iommu_ats_broken_work(struct work_struct *work);
+
+/*
+ * Extract the device-id of the command that caused a command-queue timeout.
+ *
+ * On CQCSR.CMD_TO the hardware stops advancing CQH at the offending command,
+ * so reading CQH indexes the entry that timed out. If that entry is an
+ * ATS.INVAL, return its device-id; otherwise return an invalid id.
+ */
+static unsigned int riscv_iommu_cmd_timeout_devid(struct riscv_iommu_device *iommu)
+{
+	struct riscv_iommu_queue *q = &iommu->cmdq;
+	struct riscv_iommu_command *entry;
+	unsigned int head, devid;
+
+	if (riscv_iommu_readl_timeout(iommu, Q_HEAD(q), head,
+				      !(head & ~q->mask), 0, RISCV_IOMMU_QUEUE_TIMEOUT))
+		return UINT_MAX;
+
+	entry = q->base + (head & q->mask) * sizeof(*entry);
+
+	if (FIELD_GET(RISCV_IOMMU_CMD_OPCODE, entry->dword0) !=
+	    RISCV_IOMMU_CMD_ATS_OPCODE)
+		return UINT_MAX;
+
+	if (FIELD_GET(RISCV_IOMMU_CMD_FUNC, entry->dword0) !=
+	    RISCV_IOMMU_CMD_ATS_FUNC_INVAL)
+		return UINT_MAX;
+
+	devid = FIELD_GET(RISCV_IOMMU_CMD_ATS_RID, entry->dword0);
+	if (entry->dword0 & RISCV_IOMMU_CMD_ATS_DSV)
+		devid |= FIELD_GET(RISCV_IOMMU_CMD_ATS_DSEG, entry->dword0) << 16;
+
+	return devid;
+}
+
+/*
+ * Send IOFENCE.C command and wait for all scheduled commands to complete.
+ *
+ * On a command execution timeout, attribute the failure to a device when the
+ * offending command is an ATS.INVAL, and schedule deferred ATS-broken marking
+ * (the device lookup takes a sleeping mutex, while the caller may hold RCU).
+ */
 static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 				 unsigned int timeout_us)
 {
 	struct riscv_iommu_command cmd;
-	unsigned int prod;
+	unsigned int prod, devid;
 
 	riscv_iommu_cmd_iofence(&cmd);
 	prod = riscv_iommu_queue_send(&iommu->cmdq, &cmd, sizeof(cmd));
@@ -508,6 +555,14 @@ static void riscv_iommu_cmd_sync(struct riscv_iommu_device *iommu,
 	if (riscv_iommu_queue_wait(&iommu->cmdq, prod, timeout_us))
 		dev_err_once(iommu->dev,
 			     "Hardware error: command execution timeout\n");
+	else
+		return;
+
+	devid = riscv_iommu_cmd_timeout_devid(iommu);
+	if (devid != UINT_MAX) {
+		iommu->ats_broken_devid = devid;
+		schedule_work(&iommu->ats_broken_work);
+	}
 }
 
 /*
@@ -959,11 +1014,13 @@ struct riscv_iommu_info {
 	u32 devid;		/* device identifier, assuming iommu_fwspec->num_ids == 1 */
 	u8 ats_supported:1;
 	u8 ats_enabled:1;
+	u8 ats_broken:1;	/* ATS disabled due to ATS.INVAL timeout, do not re-enable */
 	u8 pasid_supported:1;
 	u8 pasid_enabled:1;
 	u8 pri_supported:1;
 	u8 pri_enabled:1;
 	u8 pri_pasid_required:1;
+	unsigned int ats_inval_timeouts;
 };
 
 /*
@@ -1058,10 +1115,17 @@ static void riscv_iommu_bond_unlink(struct riscv_iommu_domain *domain,
 	}
 }
 
-/* Register device for IOMMU device-id based tracking. */
-static void riscv_iommu_add_device(struct device *dev)
+/*
+ * Register device for IOMMU device-id based tracking.
+ *
+ * Takes the iommu explicitly: at probe time dev_to_iommu(dev) is not usable
+ * yet, because the iommu core only links dev->iommu after probe_device()
+ * returns. Tracking is bound to probe/release so ATS-only devices (which
+ * never enable PRI) are tracked as well.
+ */
+static void riscv_iommu_add_device(struct riscv_iommu_device *iommu,
+				   struct device *dev)
 {
-	struct riscv_iommu_device *iommu = dev_to_iommu(dev);
 	struct riscv_iommu_info *info, *rb_info;
 	struct rb_node **new_node, *parent_node = NULL;
 
@@ -1077,7 +1141,9 @@ static void riscv_iommu_add_device(struct device *dev)
 		} else if (rb_info->devid < info->devid) {
 			new_node = &((*new_node)->rb_right);
 		} else {
+			/* Already tracked, nothing to do. */
 			mutex_unlock(&iommu->devs_mutex);
+			return;
 		}
 	}
 
@@ -1127,6 +1193,115 @@ static struct device *riscv_iommu_get_device(struct riscv_iommu_device *iommu,
 	return dev;
 }
 
+/*
+ * Mark an endpoint ATS-broken after an ATS invalidation timeout.
+ *
+ * A device that fails to complete an ATS invalidation keeps stale ATC entries
+ * and can keep DMA-ing through them. Mirroring the ARM SMMUv3 ATC invalidation
+ * timeout handling, disable ATS on the offending endpoint and refuse to
+ * re-enable it, so the IOMMU no longer relies on the device's ATC being
+ * coherent. Full quarantine / reset recovery is intentionally left out of this
+ * first step.
+ *
+ * The device lookup takes the sleeping devs_mutex, so the marking is deferred
+ * to this work item from riscv_iommu_cmd_sync(), which may run with only RCU
+ * held. It also serves the debugfs fault-injection path.
+ */
+static void riscv_iommu_ats_broken_work(struct work_struct *work)
+{
+	struct riscv_iommu_device *iommu =
+		container_of(work, struct riscv_iommu_device, ats_broken_work);
+	struct device *dev = riscv_iommu_get_device(iommu, iommu->ats_broken_devid);
+	struct riscv_iommu_info *info;
+	struct pci_dev *pdev;
+
+	if (!dev)
+		return;
+
+	info = dev_iommu_priv_get(dev);
+	info->ats_broken = true;
+	info->ats_inval_timeouts++;
+
+	if (info->ats_enabled && dev_is_pci(dev)) {
+		pdev = to_pci_dev(dev);
+		pci_disable_ats(pdev);
+		info->ats_enabled = false;
+	}
+
+	dev_warn(dev, "marked ATS-broken after ATS.INVAL timeout\n");
+	put_device(dev);
+}
+
+#ifdef CONFIG_DEBUG_FS
+/*
+ * Debugfs fault injection.
+ *
+ * Real RISC-V IOMMU hardware completes ATS.INVAL synchronously, so a timeout
+ * cannot be reproduced against an unmodified endpoint. To exercise the
+ * ATS-broken marking path in isolation, this knob records the target device-id
+ * and schedules the same deferred marking that the real cmd_sync() timeout path
+ * would. It does not depend on QEMU fault injection.
+ */
+static int riscv_iommu_debugfs_inject_ats_timeout(void *data, u64 devid)
+{
+	struct riscv_iommu_device *iommu = data;
+
+	if (!(iommu->caps & RISCV_IOMMU_CAPABILITIES_ATS))
+		return -ENOTSUPP;
+
+	iommu->ats_broken_devid = (unsigned int)devid;
+	schedule_work(&iommu->ats_broken_work);
+
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(riscv_iommu_debugfs_inject_ats_fops, NULL,
+			riscv_iommu_debugfs_inject_ats_timeout, "%llu\n");
+
+static int riscv_iommu_debugfs_ats_devices_show(struct seq_file *s, void *data)
+{
+	struct riscv_iommu_device *iommu = s->private;
+	struct rb_node *node;
+
+	seq_puts(s, "devid device ats_broken ats_inval_timeouts\n");
+
+	mutex_lock(&iommu->devs_mutex);
+	for (node = rb_first(&iommu->devs); node; node = rb_next(node)) {
+		struct riscv_iommu_info *info =
+			rb_entry(node, struct riscv_iommu_info, node);
+
+		seq_printf(s, "0x%x %s %d %u\n", info->devid,
+			   dev_name(info->dev), info->ats_broken,
+			   info->ats_inval_timeouts);
+	}
+	mutex_unlock(&iommu->devs_mutex);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(riscv_iommu_debugfs_ats_devices);
+
+static void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu)
+{
+	struct dentry *root;
+
+	root = debugfs_create_dir(dev_name(iommu->dev), NULL);
+	iommu->debugfs = root;
+
+	debugfs_create_file("inject_ats_inval_timeout", 0200, root, iommu,
+			    &riscv_iommu_debugfs_inject_ats_fops);
+	debugfs_create_file("ats_devices", 0400, root, iommu,
+			    &riscv_iommu_debugfs_ats_devices_fops);
+}
+
+static void riscv_iommu_debugfs_remove(struct riscv_iommu_device *iommu)
+{
+	debugfs_remove_recursive(iommu->debugfs);
+	iommu->debugfs = NULL;
+}
+#else
+static inline void riscv_iommu_debugfs_init(struct riscv_iommu_device *iommu) { }
+static inline void riscv_iommu_debugfs_remove(struct riscv_iommu_device *iommu) { }
+#endif
+
 static void riscv_iommu_page_response(struct device *dev,
 				      struct iopf_fault *evt,
 				      struct iommu_page_response *msg)
@@ -1237,8 +1412,6 @@ static int riscv_iommu_dev_enable_iopf(struct device *dev)
 	if (info->pri_enabled)
 		return -EBUSY;
 
-	riscv_iommu_add_device(dev);
-
 #ifdef CONFIG_PCI_PRI
 	rc = pci_reset_pri(to_pci_dev(dev));
 	if (rc)
@@ -1275,8 +1448,6 @@ static int riscv_iommu_dev_disable_iopf(struct device *dev)
 	info->pri_enabled = false;
 	pci_disable_pri(to_pci_dev(dev));
 	iopf_queue_remove_device(iommu->pq_work, dev);
-
-	riscv_iommu_del_device(dev);
 #endif
 
 	return 0;
@@ -1287,6 +1458,11 @@ static void riscv_iommu_enable_pdev(struct pci_dev *pdev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(&pdev->dev);
 
+	if (info->ats_broken) {
+		pci_warn(pdev, "ATS disabled: device marked ATS-broken after ATS.INVAL timeout\n");
+		return;
+	}
+
 	if (info->ats_supported)
 		info->ats_enabled = !pci_enable_ats(pdev, PAGE_SHIFT);
 }
@@ -2270,6 +2446,14 @@ static struct iommu_device *riscv_iommu_probe_device(struct device *dev)
 
 	dev_iommu_priv_set(dev, info);
 
+	/*
+	 * Track the device by its device-id so that ATS invalidation timeouts
+	 * (and PRI page requests) can be attributed back to a struct device.
+	 * Registration is bound to probe/release, not to PRI enable, so that
+	 * ATS-only devices are tracked as well.
+	 */
+	riscv_iommu_add_device(iommu, dev);
+
 	return &iommu->iommu;
 }
 
@@ -2277,6 +2461,8 @@ static void riscv_iommu_release_device(struct device *dev)
 {
 	struct riscv_iommu_info *info = dev_iommu_priv_get(dev);
 
+	riscv_iommu_del_device(dev);
+
 	if (info->pasid_enabled) {
 		pci_disable_pasid(to_pci_dev(dev));
 	}
@@ -2379,6 +2565,9 @@ void riscv_iommu_remove(struct riscv_iommu_device *iommu)
 	riscv_iommu_queue_disable(&iommu->fltq);
 	riscv_iommu_queue_disable(&iommu->priq);
 	iopf_queue_free(iommu->pq_work);
+	riscv_iommu_debugfs_remove(iommu);
+	/* Flush any pending ATS-broken marking before the device goes away. */
+	cancel_work_sync(&iommu->ats_broken_work);
 }
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu)
@@ -2389,6 +2578,7 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 	RISCV_IOMMU_QUEUE_INIT(&iommu->fltq, FQ);
 	RISCV_IOMMU_QUEUE_INIT(&iommu->priq, PQ);
 	mutex_init(&iommu->devs_mutex);
+	INIT_WORK(&iommu->ats_broken_work, riscv_iommu_ats_broken_work);
 
 	rc = riscv_iommu_init_check(iommu);
 	if (rc)
@@ -2444,6 +2634,8 @@ int riscv_iommu_init(struct riscv_iommu_device *iommu)
 		goto err_remove_sysfs;
 	}
 
+	riscv_iommu_debugfs_init(iommu);
+
 	return 0;
 
 err_remove_sysfs:
diff --git a/drivers/iommu/riscv/iommu.h b/drivers/iommu/riscv/iommu.h
index 498d9c645fb5..5ac86efc123a 100644
--- a/drivers/iommu/riscv/iommu.h
+++ b/drivers/iommu/riscv/iommu.h
@@ -14,9 +14,11 @@
 #include <linux/iommu.h>
 #include <linux/types.h>
 #include <linux/iopoll.h>
+#include <linux/workqueue.h>
 
 #include "iommu-bits.h"
 
+struct dentry;
 struct riscv_iommu_device;
 
 struct riscv_iommu_queue {
@@ -67,6 +69,13 @@ struct riscv_iommu_device {
 	/* Connected end-points */
 	struct rb_root devs;
 	struct mutex devs_mutex;
+
+	/* debugfs interface */
+	struct dentry *debugfs;
+
+	/* Deferred ATS-broken marking, see riscv_iommu_cmd_timeout() */
+	struct work_struct ats_broken_work;
+	unsigned int ats_broken_devid;
 };
 
 int riscv_iommu_init(struct riscv_iommu_device *iommu);
-- 
2.54.0

